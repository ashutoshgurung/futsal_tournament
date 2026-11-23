const router = require('express').Router();
const rateLimit = require('express-rate-limit');
const c = require('../controllers/authController');
const s = require('../validators/schemas');
const validate = require('../middleware/validate');
const { protect } = require('../middleware/auth');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  limit: 100,
  standardHeaders: true,
  legacyHeaders: false,
  message: { success: false, message: 'Too many attempts, please try again later' },
});
const emailLimiter = rateLimit({
  windowMs: 60 * 60 * 1000,   // 1 hour window
  limit: 10,                  // max 10 requests per IP in that hour
  standardHeaders: true,
  legacyHeaders: false,
  message: { success: false, message: 'Too many email requests, please try again later' },
});


  router.get('/verify-email', limiter, c.verifyEmail);
  router.post('/verify-email', limiter, validate(s.verifyEmailToken), c.verifyEmailJson);
  router.post('/resend-verification', emailLimiter, validate(s.resendVerification), c.resendVerification);

router.post('/register', limiter, validate(s.register), c.register);
router.post('/google', limiter, validate(s.google), c.google);
router.post('/login', limiter, validate(s.login), c.login);
router.get('/me', protect, c.me);
router.post('/logout', protect, c.logout);
router.post('/organization', protect, validate(s.createOrganization), c.createOrganization);
router.put('/password', protect, validate(s.changePassword), c.changePassword);

module.exports = router;