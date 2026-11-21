// const router = require('express').Router();
// const c = require('../controllers/organizationController');
// const s = require('../validators/schemas');
// const validate = require('../middleware/validate');
// const { protect, authorize } = require('../middleware/auth');

// const { imageUpload } = require('../middleware/upload');

// router.use(protect);
// router.get('/', c.get);
// router.put('/', authorize('owner'), validate(s.updateOrganization), c.update);
// router.put('/logo', authorize('owner'), imageUpload('logo'), c.uploadLogo);
// router.delete('/logo', authorize('owner'), c.removeLogo);

// module.exports = router;


const router = require('express').Router();
const { UserRole } = require('@prisma/client');
const c = require('../controllers/organizationController');
const s = require('../validators/schemas');
const validate = require('../middleware/validate');
const { protect, requireOrg, authorize } = require('../middleware/auth');
const { imageUpload } = require('../middleware/upload');

router.use(protect, requireOrg);

router.get('/', c.get); // any member of the org can view it

router.put('/', authorize(UserRole.organizer), validate(s.updateOrganization), c.update);
router.put('/logo', authorize(UserRole.organizer), imageUpload('logo'), c.uploadLogo);
router.delete('/logo', authorize(UserRole.organizer), c.removeLogo);

module.exports = router;