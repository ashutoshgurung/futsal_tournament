const router = require('express').Router();
const c = require('../controllers/publicController');


// 1. Static routes FIRST: cross-organization listing of tournaments open for booking
router.get('/tournaments', c.listOpenTournaments);
router.get('/tournaments/:id', c.openTournament);

// 2. Param routes AFTER: per-organization public pages
router.get('/:orgSlug', c.organization);
router.get('/:orgSlug/tournaments', c.tournaments);
router.get('/:orgSlug/tournaments/:slug', c.tournament);
router.get('/:orgSlug/tournaments/:slug/teams', c.teams);
router.get('/:orgSlug/tournaments/:slug/teams/:teamId', c.team);
router.get('/:orgSlug/tournaments/:slug/standings', c.standings);
router.get('/:orgSlug/tournaments/:slug/matches', c.matches);
router.get('/:orgSlug/tournaments/:slug/matches/:matchId', c.match);
router.get('/:orgSlug/tournaments/:slug/top-scorers', c.topScorers);

module.exports = router;