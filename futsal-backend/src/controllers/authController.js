const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const { OAuth2Client } = require('google-auth-library');
const { UserRole } = require('@prisma/client');
const env = require('../config/env');
const { prisma, tx } = require('../config/db');
const ApiError = require('../utils/ApiError');
const asyncHandler = require('../utils/asyncHandler');
const { uniqueSlug } = require('../utils/slugify');
const dto = require('../utils/dto');
const { hashToken, trySendVerification } = require('../utils/emailVerification');

const signToken = (user) =>
  jwt.sign(
    { id: user.id, org: user.organizationId ?? null, role: user.role },
    env.jwtSecret,
    { expiresIn: env.jwtExpiresIn }
  );

const orgDto = (org) => (org ? dto.org(org) : null);
const isDisabled = (user) => !user.isActive || (user.organization && !user.organization.isActive);

const googleClient = new OAuth2Client(env.googleClientId || process.env.GOOGLE_CLIENT_ID);

// ---------------------------------------------------------------------------
// Google sign-in (Google has already verified the email, so users are verified)
// ---------------------------------------------------------------------------
exports.google = asyncHandler(async (req, res) => {
  const { idToken, organizationName } = req.body;

  // 1. Verify the token with Google
  let payload;
  try {
    const ticket = await googleClient.verifyIdToken({
      idToken,
      audience: process.env.GOOGLE_CLIENT_ID, // the Web client ID
    });
    payload = ticket.getPayload();
  } catch (err) {
    throw new ApiError(401, 'Invalid Google token');
  }

  if (!payload?.email || !payload.email_verified) {
    throw new ApiError(401, 'Google account email not verified');
  }

  const email = payload.email.toLowerCase();
  const googleId = payload.sub;
  const name = payload.name || email.split('@')[0];
  const avatarUrl = payload.picture ?? null;

  // 2. Existing user? (match by googleId, or by email for accounts made with a password)
  let user = await prisma.user.findFirst({
    where: { OR: [{ googleId }, { email }] },
    include: { organization: true },
  });

  if (user) {
    if (isDisabled(user)) throw new ApiError(403, 'Account is disabled');

    // Link Google to an existing email/password account and mark the email verified
    if (!user.googleId || !user.emailVerified) {
      user = await prisma.user.update({
        where: { id: user.id },
        data: {
          googleId,
          avatarUrl: user.avatarUrl ?? avatarUrl,
          emailVerified: true,
          emailVerifiedAt: user.emailVerifiedAt ?? new Date(),
        },
        include: { organization: true },
      });
    }

    return res.json({
      success: true,
      token: signToken(user),
      user: dto.user(user),
      organization: orgDto(user.organization),
      isNewUser: false,
    });
  }


  // 3. New user with an organization name: create org + organizer atomically
  const orgName = organizationName?.trim();
  if (orgName) {
    const { org, created } = await tx(async (t) => {
      const slug = await uniqueSlug('organizations', orgName, null, t);
      const org = await t.organization.create({
        data: { name: orgName, slug, contactEmail: email },
      });
      const created = await t.user.create({
        data: {
          organizationId: org.id,
          name,
          email,
          googleId,
          avatarUrl,
          role: UserRole.organizer,
          emailVerified: true,
          emailVerifiedAt: new Date(),
        },
      });
      return { org, created };
    });

    return res.status(201).json({
      success: true,
      token: signToken(created),
      user: dto.user(created),
      organization: orgDto(org),
      isNewUser: true,
    });
  }

  // 4. New user without an organization (default role: user; can call /organization later)
  const created = await prisma.user.create({
    data: {
      name,
      email,
      googleId,
      avatarUrl,
      emailVerified: true,
      emailVerifiedAt: new Date(),
    },
  });

  res.status(201).json({
    success: true,
    token: signToken(created),
    user: dto.user(created),
    organization: null,
    isNewUser: true,
  });
});
  // ---------------------------------------------------------------------------
// Logout (stateless: the client deletes its token)
// ---------------------------------------------------------------------------
exports.logout = asyncHandler(async (req, res) => {
  res.json({ success: true, message: 'Logged out' });
});

// ---------------------------------------------------------------------------
// Email + password registration (no token until the email is verified)
// ---------------------------------------------------------------------------
exports.register = asyncHandler(async (req, res) => {
  const { organizationName, name, password, contactEmail, logoUrl } = req.body;
  const email = req.body.email.toLowerCase();
  const passwordHash = await bcrypt.hash(password, 12);
  const orgName = organizationName?.trim();

  const { org, user } = await tx(async (t) => {
    const taken = await t.user.findUnique({ where: { email }, select: { id: true } });
    if (taken) throw new ApiError(409, 'Email already registered');

    // Regular sign-up: no organization, role falls back to the schema default (user)
    if (!orgName) {
      const user = await t.user.create({ data: { name, email, passwordHash } });
      return { org: null, user };
    }

    const slug = await uniqueSlug('organizations', orgName, null, t);
    const org = await t.organization.create({
      data: {
        name: orgName,
        slug,
        contactEmail: contactEmail?.toLowerCase() || email,
        logoUrl: logoUrl || null,
      },
    });
    const user = await t.user.create({
      data: { organizationId: org.id, name, email, passwordHash, role: UserRole.organizer },
    });
    return { org, user };
  });

  // Fire-and-forget: a mail failure must not break signup (user can resend)
  trySendVerification(user);

  res.status(201).json({
    success: true,
    message: 'Account created. Check your email to verify your address.',
    user: dto.user(user),
    organization: orgDto(org),
  });
});

// ---------------------------------------------------------------------------
// Login
// ---------------------------------------------------------------------------
exports.login = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  const user = await prisma.user.findUnique({
    where: { email: email.toLowerCase() },
    include: { organization: true },
  });

  // Google-only accounts have no passwordHash -> generic error
  if (!user || !user.passwordHash || !(await bcrypt.compare(password, user.passwordHash))) {
    throw new ApiError(401, 'Invalid email or password');
  }
  if (isDisabled(user)) throw new ApiError(403, 'Account is disabled');
  if (!user.emailVerified) throw new ApiError(403, 'Please verify your email before logging in');

  res.json({
    success: true,
    token: signToken(user),
    user: dto.user(user),
    organization: orgDto(user.organization),
  });
});

// ---------------------------------------------------------------------------
// Email verification
// ---------------------------------------------------------------------------
exports.verifyEmail = asyncHandler(async (req, res) => {
  const token = String(req.query.token || req.body?.token || '');
  if (!token) throw new ApiError(400, 'Token is required');

  const record = await prisma.emailVerificationToken.findUnique({
    where: { tokenHash: hashToken(token) },
  });
  if (!record || record.expiresAt < new Date()) {
    throw new ApiError(400, 'Invalid or expired verification link');
  }

  await tx(async (t) => {
    await t.user.update({
      where: { id: record.userId },
      data: { emailVerified: true, emailVerifiedAt: new Date() },
    });
    await t.emailVerificationToken.deleteMany({ where: { userId: record.userId } });
  });

  res.json({ success: true, message: 'Email verified. You can now log in.' });
});

exports.resendVerification = asyncHandler(async (req, res) => {
  const email = String(req.body.email || '').toLowerCase();
  const user = email ? await prisma.user.findUnique({ where: { email } }) : null;

  if (user && user.isActive && !user.emailVerified) await trySendVerification(user);

  // Same response either way so this can't be used to discover registered emails
  res.json({
    success: true,
    message: 'If that account exists and is unverified, a new email has been sent.',
  });
});

// ---------------------------------------------------------------------------
// For users who signed up without an organization
// ---------------------------------------------------------------------------
exports.createOrganization = asyncHandler(async (req, res) => {
  const name = req.body.organizationName?.trim();
  if (!name) throw new ApiError(400, 'Organization name is required');

  const { org, user } = await tx(async (t) => {
    const slug = await uniqueSlug('organizations', name, null, t);
    const org = await t.organization.create({
      data: { name, slug, contactEmail: req.user.email },
    });

    // organizationId: null in the filter makes this safe against double submits
    const { count } = await t.user.updateMany({
      where: { id: req.user.id, organizationId: null },
      data: { organizationId: org.id, role: UserRole.organizer },
    });
    if (!count) throw new ApiError(409, 'You already belong to an organization');

    const user = await t.user.findUnique({ where: { id: req.user.id } });
    return { org, user };
  });

  res.status(201).json({
    success: true,
    token: signToken(user),
    user: dto.user(user),
    organization: dto.org(org),
  });
});

exports.me = asyncHandler(async (req, res) => {
  res.json({ success: true, user: req.user, organization: req.org });
});

// Lets Google-only users set a first password (no current password required)
exports.changePassword = asyncHandler(async (req, res) => {
  const user = await prisma.user.findUnique({
    where: { id: req.user.id },
    select: { passwordHash: true },
  });
  if (!user) throw new ApiError(404, 'User not found');

  if (user.passwordHash && !(await bcrypt.compare(req.body.currentPassword || '', user.passwordHash))) {
    throw new ApiError(400, 'Current password is incorrect');
  }

  const hash = await bcrypt.hash(req.body.newPassword, 12);
  await prisma.user.update({ where: { id: req.user.id }, data: { passwordHash: hash } });
  res.json({ success: true, message: 'Password updated' });
});