
module.exports = Object.freeze({
  USER: 'user',
  player: 'player',      // signed up without an organization
  OWNER: 'owner',            // created the organization (use 'organizer' if that's what your middleware checks)
  SCOREKEEPER: 'scorekeeper' // staff invited into an org
});