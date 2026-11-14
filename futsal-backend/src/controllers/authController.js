const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const env = require('../config/env');
const { prisma, tx } = require('../config/db');
const ApiError = require('../utils/ApiError');
const asyncHandler = require('../utils/asyncHandler');
const { uniqueSlug } = require('../utils/slugify');
const dto = require('../utils/dto');

const signToken = (user) =>
  jwt.sign({ id: user.id, org: user.organizationId, role: user.role }, env.jwtSecret, { expiresIn: env.jwtExpiresIn });

const { OAuth2Client } = require('google-auth-library');
const googleClient = new OAuth2Client(env.googleClientId);

// Handles both login and signup.
// - Existing user (by googleId or email)  -> log in (links Google on first use)
// - New user + organizationName           -> creates org + owner (signup)
// - New user, no organizationName         -> 404 ORGANIZATION_REQUIRED so the UI can ask for it
exports.google = asyncHandler(async (req, res) => {
  const { credential, organizationName } = req.body;
  if (!credential) throw new ApiError(400, 'Google credential is required');

  let payload;
  try {
    const ticket = await googleClient.verifyIdToken({ idToken: credential, audience: env.googleClientId });
    payload = ticket.getPayload();
  } catch {
    throw new ApiError(401, 'Invalid Google credential');
  }
  // Never link/create by an unverified email
  if (!payload?.email || !payload.email_verified) throw new ApiError(401, 'Google email is not verified');

  const email = payload.email.toLowerCase();
  const googleId = payload.sub;

  let user = await prisma.user.findFirst({
    where: { OR: [{ googleId }, { email }] },
    include: { organization: true },
  });

  // ---- Login (existing account) ----
  if (user) {
    if (!user.isActive || !user.organization?.isActive) throw new ApiError(403, 'Account is disabled');
    if (!user.googleId) {
      user = await prisma.user.update({
        where: { id: user.id },
        data: { googleId, avatarUrl: user.avatarUrl ?? payload.picture ?? null },
        include: { organization: true },
      });
    }
    return res.json({
      success: true,
      token: signToken(user),
      user: dto.user(user),
      organization: dto.org(user.organization),
      isNewUser: false,
    });
  }

  // ---- Signup (new tenant) ----
  if (!organizationName?.trim()) {
    return res.status(404).json({
      success: false,
      code: 'ORGANIZATION_REQUIRED',
      message: 'No account found. Provide an organization name to sign up.',
      profile: { name: payload.name, email },
    });
  }

  const { org, user: created } = await tx(async (t) => {
    const slug = await uniqueSlug('organizations', organizationName.trim(), null, t);
    const org = await t.organization.create({
      data: { name: organizationName.trim(), slug, contactEmail: email },
    });
    const user = await t.user.create({
      data: {
        organizationId: org.id,
        name: payload.name || email.split('@')[0],
        email,
        googleId,
        avatarUrl: payload.picture ?? null,
        role: 'owner',
      },
    });
    return { org, user };
  });

  res.status(201).json({
    success: true,
    token: signToken(created),
    user: dto.user(created),
    organization: dto.org(org),
    isNewUser: true,
  });
});

// SaaS sign-up: creates a new organization (tenant) and its owner account atomically
exports.register = asyncHandler(async (req, res) => {
  const { organizationName, name, email, password } = req.body;
  const passwordHash = await bcrypt.hash(password, 12);

  const { org, user } = await tx(async (t) => {
    const taken = await t.user.findUnique({ where: { email }, select: { id: true } });
    if (taken) throw new ApiError(409, 'Email already registered');

    const slug = await uniqueSlug('organizations', organizationName, null, t);
    const org = await t.organization.create({ data: { name: organizationName, slug, contactEmail: email } });
    const user = await t.user.create({
      data: { organizationId: org.id, name, email, passwordHash, role: 'owner' },
    });
    return { org, user };
  });

  res.status(201).json({ success: true, token: signToken(user), user: dto.user(user), organization: dto.org(org) });
});
// ---- REPLACE exports.login in authController.js with this ----
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
  if (!user.isActive || !user.organization?.isActive) throw new ApiError(403, 'Account is disabled');

  res.json({
    success: true,
    token: signToken(user),
    user: dto.user(user),
    organization: dto.org(user.organization),
  });
});

// ---- REPLACE exports.changePassword with this (lets Google-only users set a first password) ----
exports.changePassword = asyncHandler(async (req, res) => {
  const user = await prisma.user.findUnique({ where: { id: req.user.id }, select: { passwordHash: true } });
  if (!user) throw new ApiError(404, 'User not found');
  if (user.passwordHash && !(await bcrypt.compare(req.body.currentPassword || '', user.passwordHash))) {
    throw new ApiError(400, 'Current password is incorrect');
  }
  const hash = await bcrypt.hash(req.body.newPassword, 12);
  await prisma.user.update({ where: { id: req.user.id }, data: { passwordHash: hash } });
  res.json({ success: true, message: 'Password updated' });
});

// ---- In exports.register also normalise the email, since login/google lowercase it ----
// const email = req.body.email.toLowerCase();
exports.me = asyncHandler(async (req, res) => {
  res.json({ success: true, user: req.user, organization: req.org });
});

exports.changePassword = asyncHandler(async (req, res) => {
  const user = await prisma.user.findUnique({ where: { id: req.user.id }, select: { passwordHash: true } });
  if (!user || !(await bcrypt.compare(req.body.currentPassword, user.passwordHash))) {
    throw new ApiError(400, 'Current password is incorrect');
  }
  const hash = await bcrypt.hash(req.body.newPassword, 12);
  await prisma.user.update({ where: { id: req.user.id }, data: { passwordHash: hash } });
  res.json({ success: true, message: 'Password updated' });
});
