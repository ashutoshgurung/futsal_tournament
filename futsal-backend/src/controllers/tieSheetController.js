const asyncHandler = require('../utils/asyncHandler');
const svc = require('../services/tieSheetService');

exports.generate = asyncHandler(async (req, res) => {
  const data = await svc.generateTieSheet({ orgId: req.orgId, ...req.body });
  res.status(201).json({ success: true, data });
});

exports.createManual = asyncHandler(async (req, res) => {
  const data = await svc.createManualTieSheet({ orgId: req.orgId, ...req.body });
  res.status(201).json({ success: true, data });
});

exports.list = asyncHandler(async (req, res) => {
  const data = await svc.listTieSheets(req.orgId, req.query.tournamentId);
  res.json({ success: true, data });
});

exports.get = asyncHandler(async (req, res) => {
  const data = await svc.getTieSheet(req.orgId, req.params.id);
  res.json({ success: true, data });
});

exports.replacePairings = asyncHandler(async (req, res) => {
  const data = await svc.replacePairings(req.orgId, req.params.id, req.body);
  res.json({ success: true, data });
});

exports.update = asyncHandler(async (req, res) => {
  const { name, isPublished, isLocked } = req.body; // whitelist
  const data = await svc.updateTieSheet(req.orgId, req.params.id, { name, isPublished, isLocked });
  res.json({ success: true, data });
});

exports.remove = asyncHandler(async (req, res) => {
  await svc.deleteTieSheet(req.orgId, req.params.id);
  res.json({ success: true });
});