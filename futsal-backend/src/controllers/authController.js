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
const { hashToken, trySendVerification } = require('../services/emailVerification');
const verification = require('../services/emailVerification'); // adjust path

// ---- top of authController.js, next to APP_SCHEME ----
const APP_SCHEME = (process.env.APP_SCHEME || 'footballapp').replace(/[^a-zA-Z0-9+.-]/g, '');
const ANDROID_PACKAGE = process.env.ANDROID_PACKAGE || 'com.example.football_app';

// ---- replace your existing verifyEmail with this ----
exports.verifyEmail = async (req, res) => {
  try {
    const { token, confirm } = req.query;
    if (!token || typeof token !== 'string') {
      return page(res, 400, 'Invalid link', 'This verification link is invalid.', false);
    }

    // Browser fallback: verify right here
    if (confirm === '1') {
      const r = await verifyToken(token);
      return page(
        res,
        r.status,
        r.ok ? 'Email verified' : 'Link not valid',
        r.ok ? 'Your email has been verified. You can now return to the app.' : r.message,
        r.ok
      );
    }

    // Landing page: choose app or browser (does NOT consume the token)
    const encoded = encodeURIComponent(token);
    const isAndroid = /android/i.test(req.get('user-agent') || '');

    const browserUrl = `/api/auth/verify-email?token=${encoded}&confirm=1`;
    const absoluteBrowserUrl = `${process.env.API_URL}${browserUrl}`;

    const appUrl = isAndroid
      ? `intent://verify-email?token=${encoded}#Intent;scheme=${APP_SCHEME};package=${ANDROID_PACKAGE};S.browser_fallback_url=${encodeURIComponent(absoluteBrowserUrl)};end`
      : `${APP_SCHEME}://verify-email?token=${encoded}`;

    return res.type('html').send(`<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Verify your email</title>
  <style>
    body{font-family:Arial,Helvetica,sans-serif;background:#f5f5f5;display:flex;align-items:center;justify-content:center;min-height:100vh;margin:0}
    .card{background:#fff;padding:32px;border-radius:12px;max-width:380px;text-align:center;box-shadow:0 2px 12px rgba(0,0,0,.08)}
    h1{font-size:22px;margin:0 0 8px}
    p{color:#555;line-height:1.5}
    .btn{display:block;padding:12px 24px;border-radius:6px;text-decoration:none;font-weight:bold;margin-top:12px}
    .primary{background:#16a34a;color:#fff}
    .secondary{background:#fff;color:#16a34a;border:1px solid #16a34a}
  </style>
</head>
<body>
  <div class="card">
    <h1>Verify your email</h1>
    <p>Continue in the app, or verify right here in your browser.</p>
    <a class="btn primary" href="${appUrl}">Open in app</a>
    <a class="btn secondary" href="${browserUrl}">Verify in browser</a>
  </div>
</body>
</html>`);
  } catch (err) {
    console.error('verifyEmail error:', err);
    return page(res, 500, 'Something went wrong', 'Please try again in a moment.', false);
  }
};
// ---------- helper: HTML result page ----------
const page = (res, status, title, message, ok) =>
  res.status(status).type('html').send(`<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${title}</title>
  <style>
    body{font-family:Arial,Helvetica,sans-serif;background:#f5f5f5;display:flex;align-items:center;justify-content:center;min-height:100vh;margin:0}
    .card{background:#fff;padding:32px;border-radius:12px;max-width:380px;text-align:center;box-shadow:0 2px 12px rgba(0,0,0,.08)}
    .icon{font-size:48px}
    h1{font-size:22px;margin:12px 0 8px;color:${ok ? '#16a34a' : '#dc2626'}}
    p{color:#555;line-height:1.5}
  </style>
</head>
<body>
  <div class="card">
    <div class="icon">${ok ? '✅' : '⚠️'}</div>
    <h1>${title}</h1>
    <p>${message}</p>
  </div>
</body>
</html>`);

// ---------- helper: shared token check ----------
const verifyToken = async (token) => {
  if (!token || typeof token !== 'string') {
    return { ok: false, status: 400, message: 'Invalid link' };
  }

  const record = await prisma.emailVerificationToken.findUnique({
    where: { tokenHash: verification.hashToken(token) },
  });
  if (!record) {
    return { ok: false, status: 400, message: 'Link is invalid or already used' };
  }

  if (record.expiresAt < new Date()) {
    await prisma.emailVerificationToken.delete({ where: { id: record.id } });
    return { ok: false, status: 400, message: 'Link expired. Request a new email.' };
  }

  await prisma.$transaction([
    prisma.user.update({
      where: { id: record.userId },
      data: { emailVerified: true, emailVerifiedAt: new Date() },
    }),
    prisma.emailVerificationToken.deleteMany({ where: { userId: record.userId } }),
  ]);

  return { ok: true, status: 200, message: 'Email verified' };
};

// ---------- POST /api/auth/verify-email   body: { token } ----------
// Called by the Flutter app after it catches the deep link
exports.verifyEmailJson = async (req, res, next) => {
  try {
    const r = await verifyToken(req.body.token);
    res.status(r.status).json({ success: r.ok, message: r.message });
  } catch (err) {
    next(err);
  }
};

// ---------- POST /api/auth/resend-verification   body: { email } ----------
exports.resendVerification = async (req, res, next) => {
  try {
    const user = await prisma.user.findUnique({
      where: { email: String(req.body.email).toLowerCase() },
    });

    if (user && !user.emailVerified) {
      try {
        await verification.sendVerification(user);
      } catch (err) {
        if (err.status === 429) {
          return res.status(429).json({ success: false, message: err.message });
        }
        throw err;
      }
    }

    // Same response whether or not the account exists
    res.json({
      success: true,
      message: 'If the account exists, a new verification email has been sent',
    });
  } catch (err) {
    next(err);
  }
};

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
// Email + password registration (organizer sign-ups get a token right away)
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

  const body = {
    success: true,
    user: dto.user(user),
    organization: orgDto(org),
  };

  // Organizer sign-up (has an org): sign them in right away
  if (org) {
    return res.status(201).json({
      ...body,
      token: signToken(user),
      message: 'Organizer account created.',
    });
  }

  // Regular user: must verify email first
  res.status(201).json({
    ...body,
    message: 'Account created. Check your email to verify your address.',
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