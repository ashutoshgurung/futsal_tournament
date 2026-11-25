const router = require('express').Router();
const { UserRole } = require('@prisma/client');
const c = require('../controllers/tieSheetController');
const s = require('../validators/tieSheetSchemas');
const validate = require('../middleware/validate');
const { protect, requireOrg, authorize } = require('../middleware/auth');

router.use(protect, requireOrg);

router.get('/', c.list); // ?tournamentId=...
router.get('/:id', c.get);

router.post('/generate', authorize(UserRole.organizer), validate(s.generate), c.generate);
router.post('/manual', authorize(UserRole.organizer), validate(s.manual), c.createManual);
router.put('/:id/pairings', authorize(UserRole.organizer), validate(s.replacePairings), c.replacePairings);
router.patch('/:id', authorize(UserRole.organizer), validate(s.update), c.update);
router.delete('/:id', authorize(UserRole.organizer), c.remove);

module.exports = router;