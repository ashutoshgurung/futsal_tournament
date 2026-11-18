const crypto = require('crypto');
const { prisma } = require('../config/db');
const mailer = require('./mailer');

const TTL_MS = 24 * 60 * 60 * 1000;

const hashToken = (token) => crypto.createHash('sha256').update(token).digest('hex');

const sendVerification = async (user) => {
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
  await mailer.send({
    to: user.email,
    subject: 'Verify your email',
    text: `Hi ${user.name}, verify your email: ${url}\nThis link expires in 24 hours.`,
    html: `<p>Hi ${user.name},</p><p><a href="${url}">Verify your email</a></p><p>This link expires in 24 hours.</p>`,
  });
};

// Never let a mail failure break signup; the user can request a resend.
const trySendVerification = (user) =>
  sendVerification(user).catch((err) => console.error('Verification email failed:', err));

module.exports = { hashToken, sendVerification, trySendVerification };