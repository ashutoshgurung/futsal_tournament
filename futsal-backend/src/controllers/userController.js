const bcrypt = require('bcryptjs');
const { UserRole } = require('@prisma/client');
const { prisma } = require('../config/db');
const ApiError = require('../utils/ApiError');
const asyncHandler = require('../utils/asyncHandler');
const findOwned = require('../utils/findOwned');
const dto = require('../utils/dto');
const { trySendVerification } = require('../utils/emailVerification');

// Roles an organizer may assign to people inside their organization.
// New accounts start as `user`; the organizer promotes them (e.g. to scorekeeper) via update.
// Add more here later if you introduce other roles.
const DEFAULT_ROLE = UserRole.user;
const STAFF_ROLES = [UserRole.user, UserRole.scorekeeper];

const assertStaffRole = (role) => {
  if (!STAFF_ROLES.includes(role)) {
    throw new ApiError(400, `Role must be one of: ${STAFF_ROLES.join(', ')}`);
  }
};

exports.list = asyncHandler(async (req, res) => {
  const users = await prisma.user.findMany({
    where: { organizationId: req.orgId },
    orderBy: { createdAt: 'asc' },
  });
  res.json({ success: true, data: users.map(dto.user) });
});

exports.create = asyncHandler(async (req, res) => {
  const { name, password } = req.body;
  const email = req.body.email.toLowerCase();
  const role = req.body.role ?? DEFAULT_ROLE;
  assertStaffRole(role);

  if (await prisma.user.findUnique({ where: { email }, select: { id: true } })) {
    throw new ApiError(409, 'Email already registered');
  }
  const user = await prisma.user.create({
    data: {
      organizationId: req.orgId,
      name,
      email,
      role,
      passwordHash: await bcrypt.hash(password, 12),
    },
  });

  // Fire-and-forget: a mail failure must not break creation (they can request a resend)
  trySendVerification(user);

  res.status(201).json({ success: true, data: dto.user(user) });
});

const assertCanManage = (req, target) => {
  if (target.role === UserRole.organizer) throw new ApiError(403, 'The organizer account cannot be modified');
  if (target.id === req.user.id) throw new ApiError(403, 'You cannot modify your own account here');
};

exports.update = asyncHandler(async (req, res) => {
  const target = await findOwned('users', req.params.id, req.orgId, 'User');
  assertCanManage(req, target);

  // Whitelist instead of data: req.body, so a request can't change
  // organizationId, email, passwordHash, googleId, etc.
  const { name, isActive, role } = req.body;
  if (role !== undefined) assertStaffRole(role);

  const user = await prisma.user.update({
    where: { id: target.id },
    data: { name, isActive, role },
  });
  res.json({ success: true, data: dto.user(user) });
});

exports.remove = asyncHandler(async (req, res) => {
  const target = await findOwned('users', req.params.id, req.orgId, 'User');
  assertCanManage(req, target);
  await prisma.user.delete({ where: { id: target.id } });
  res.json({ success: true, message: 'User removed' });
});