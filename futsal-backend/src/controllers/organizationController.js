const plans = require('../config/plans');
const { prisma } = require('../config/db');
const asyncHandler = require('../utils/asyncHandler');
const dto = require('../utils/dto');
const storage = require('../utils/storage');

exports.update = asyncHandler(async (req, res) => {
  const { name, contactEmail } = req.body; // whitelist; logoUrl only changes via /logo
  const org = await prisma.organization.update({
    where: { id: req.orgId },
    data: { name, contactEmail },
  });
  res.json({ success: true, data: dto.org(org) });
});

exports.uploadLogo = asyncHandler(async (req, res) => {
  const url = await storage.save(
    `orgs/${req.orgId}/logo-${Date.now()}.webp`, // timestamp busts browser/CDN cache
    req.imageBuffer
  );
  const org = await prisma.organization.update({
    where: { id: req.orgId },
    data: { logoUrl: url },
  });
  await storage.remove(req.org.logoUrl); // delete the old file after the DB write succeeds
  res.json({ success: true, data: dto.org(org) });
});

exports.removeLogo = asyncHandler(async (req, res) => {
  const org = await prisma.organization.update({
    where: { id: req.orgId },
    data: { logoUrl: null },
  });
  await storage.remove(req.org.logoUrl);
  res.json({ success: true, data: dto.org(org) });
});

const finite = (n) => (Number.isFinite(n) ? n : null); // null = unlimited

// Org profile + plan limits + current usage (for a billing/usage screen)
exports.get = asyncHandler(async (req, res) => {
  const [tournaments, staff, teams] = await Promise.all([
    prisma.tournament.count({ where: { organizationId: req.orgId } }),
    prisma.user.count({ where: { organizationId: req.orgId } }),
    prisma.team.count({ where: { organizationId: req.orgId } }),
  ]);
  const limits = plans[req.org.plan] || plans.free;
  res.json({
    success: true,
    data: req.org,
    limits: {
      maxTournaments: finite(limits.maxTournaments),
      maxTeamsPerTournament: finite(limits.maxTeamsPerTournament),
      maxStaff: finite(limits.maxStaff),
    },
    usage: { tournaments, staff, teams },
  });
});

exports.update = asyncHandler(async (req, res) => {
  // slug and plan are never client-editable
  const org = await prisma.organization.update({ where: { id: req.orgId }, data: req.body });
  res.json({ success: true, data: dto.org(org) });
});
