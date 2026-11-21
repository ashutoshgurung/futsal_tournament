// const router = require('express').Router();
// const c = require('../controllers/tournamentController');
// const s = require('../validators/schemas');
// const validate = require('../middleware/validate');
// const { protect, authorize } = require('../middleware/auth');
// const { checkTournamentLimit } = require('../middleware/planLimits');

// const admin = authorize('owner', 'admin');

// router.use(protect);
// router.get('/', c.list);
// router.post('/', admin, validate(s.createTournament), checkTournamentLimit, c.create);
// router.get('/:id', c.get);
// router.put('/:id', admin, validate(s.updateTournament), c.update);
// router.delete('/:id', admin, c.remove);
// router.post('/:id/fixtures', admin, validate(s.generateFixtures), c.generateFixtures);
// router.post('/:id/advance', admin, c.advance);
// router.get('/:id/standings', c.standings);
// router.get('/:id/top-scorers', c.topScorers);
// module.exports = router;


const router = require('express').Router();
const { UserRole } = require('@prisma/client');
const c = require('../controllers/tournamentController');
const s = require('../validators/schemas');
const validate = require('../middleware/validate');
const { protect, requireOrg, authorize } = require('../middleware/auth');
const { checkTournamentLimit } = require('../middleware/planLimits');

const organizerOnly = authorize(UserRole.organizer);

router.use(protect, requireOrg);

router.get('/', c.list);
router.post('/', organizerOnly, validate(s.createTournament), checkTournamentLimit, c.create);
router.get('/:id', c.get);
router.put('/:id', organizerOnly, validate(s.updateTournament), c.update);
router.delete('/:id', organizerOnly, c.remove);
router.post('/:id/fixtures', organizerOnly, validate(s.generateFixtures), c.generateFixtures);
router.post('/:id/advance', organizerOnly, c.advance);
router.get('/:id/standings', c.standings);
router.get('/:id/top-scorers', c.topScorers);

module.exports = router;