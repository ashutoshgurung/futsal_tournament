const crypto = require('crypto');
const { prisma } = require('../config/db');
const mailer = require('../utils/mailer');

const TTL_MS = 24 * 60 * 60 * 1000;
const RESEND_COOLDOWN_MS = 60 * 1000;

const hashToken = (token) => crypto.createHash('sha256').update(token).digest('hex');

const escapeHtml = (s = '') =>
  String(s).replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));

const sendVerification = async (user) => {
  const last = await prisma.emailVerificationToken.findFirst({
    where: { userId: user.id },
    orderBy: { createdAt: 'desc' },
  });
  if (last && Date.now() - last.createdAt.getTime() < RESEND_COOLDOWN_MS) {
    const err = new Error('Please wait a minute before requesting another email');
    err.status = 429;
    throw err;
  }

  const token = crypto.randomBytes(32).toString('hex');

  // One live token per user
  await prisma.emailVerificationToken.deleteMany({ where: { userId: user.id } });
  await prisma.emailVerificationToken.create({
    data: {
      userId: user.id,
      tokenHash: hashToken(token),
      expiresAt: new Date(Date.now() + TTL_MS),
    },
  });

  const url = `${process.env.API_URL}/api/auth/verify-email?token=${token}`;
if (process.env.NODE_ENV !== 'production') {
  console.log('VERIFY URL:', url);
}
  const name = escapeHtml(user.name);

  await mailer.send({
    to: user.email,
    subject: 'Verify your email address',
    text:
      `Hi ${user.name},\n\n` +
      `Confirm your email address by opening this link:\n${url}\n\n` +
      `This link expires in 24 hours. If you didn't create an account, you can ignore this email.`,
    html: `
<div style="font-family:Arial,Helvetica,sans-serif;max-width:480px;margin:0 auto;padding:24px;color:#222">
  <h2 style="margin:0 0 16px">Verify your email</h2>
  <p>Hi ${name},</p>
  <p>Thanks for signing up. Tap the button below to confirm your email address.</p>
  <p style="margin:28px 0">
    <a href="${url}"
       style="background:#16a34a;color:#fff;text-decoration:none;padding:12px 24px;border-radius:6px;display:inline-block;font-weight:bold">
      Verify email
    </a>
  </p>
  <p style="font-size:13px;color:#555">Button not working? Copy and paste this link into your browser:<br>
    <a href="${url}" style="color:#16a34a;word-break:break-all">${url}</a></p>
  <p style="font-size:13px;color:#555">This link expires in 24 hours. If you didn't create an account, you can ignore this email.</p>
</div>`,
  });
};

// Never let a mail failure break signup; the user can request a resend.
const trySendVerification = (user) =>
  sendVerification(user).catch((err) => console.error('Verification email failed:', err));

module.exports = { hashToken, sendVerification, trySendVerification, escapeHtml };