const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const { OAuth2Client } = require('google-auth-library');
const env = require('../config/env');
const { prisma, tx } = require('../config/db');
const ApiError = require('../utils/ApiError');
const asyncHandler = require('../utils/asyncHandler');
const { uniqueSlug } = require('../utils/slugify');
const dto = require('../utils/dto');

const googleClient = new OAuth2Client(env.googleClientId);

const signToken = (user) =>
  jwt.sign(
    { id: user.id, org: user.organizationId ?? null, role: user.role },
    env.jwtSecret,
    { expiresIn: env.jwtExpiresIn }
  );

const orgDto = (org) => (org ? dto.org(org) : null);
const isDisabled = (user) => !user.isActive || (user.organization && !user.organization.isActive);

// Handles both login and signup.
// - Existing user (by googleId or email) -> log in (links Google on first use)
// - New user + organizationName          -> creates org + owner
// - New user, no organizationName        -> creates user with no organization;
//                                           client then calls POST /auth/organization
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
    if (isDisabled(user)) throw new ApiError(403, 'Account is disabled');
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
      organization: orgDto(user.organization),
      isNewUser: false,
    });
  }

  // ---- Signup ----
  const name = payload.name || email.split('@')[0];
  const orgName = organizationName?.trim();

  // Organization name supplied: create org + owner together
  if (orgName) {
    const { org, user: created } = await tx(async (t) => {
      const slug = await uniqueSlug('organizations', orgName, null, t);
      const org = await t.organization.create({
        data: { name: orgName, slug, contactEmail: email },
      });
      const user = await t.user.create({
        data: {
          organizationId: org.id,
          name,
          email,
          googleId,
          avatarUrl: payload.picture ?? null,
          role: 'owner',
        },
      });
      return { org, user };
    });

    return res.status(201).json({
      success: true,
      token: signToken(created),
      user: dto.user(created),
      organization: orgDto(org),
      isNewUser: true,
    });
  }

  // No organization yet
  const created = await prisma.user.create({
    data: { name, email, googleId, avatarUrl: payload.picture ?? null },
  });

  res.status(201).json({
    success: true,
    token: signToken(created),
    user: dto.user(created),
    organization: null,
    isNewUser: true,
  });
});

// SaaS sign-up: creates a new organization (tenant) and its owner account atomically
exports.register = asyncHandler(async (req, res) => {
  const { organizationName, name, password } = req.body;
  const email = req.body.email.toLowerCase();
  const passwordHash = await bcrypt.hash(password, 12);

  const { org, user } = await tx(async (t) => {
    const taken = await t.user.findUnique({ where: { email }, select: { id: true } });
    if (taken) throw new ApiError(409, 'Email already registered');

    const slug = await uniqueSlug('organizations', organizationName, null, t);
    const org = await t.organization.create({
      data: { name: organizationName, slug, contactEmail: email },
    });
    const user = await t.user.create({
      data: { organizationId: org.id, name, email, passwordHash, role: 'owner' },
    });
    return { org, user };
  });

  res.status(201).json({
    success: true,
    token: signToken(user),
    user: dto.user(user),
    organization: orgDto(org),
  });
});

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

  res.json({
    success: true,
    token: signToken(user),
    user: dto.user(user),
    organization: orgDto(user.organization),
  });
});

// For users who signed up without an organization
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
      data: { organizationId: org.id, role: 'owner' },
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