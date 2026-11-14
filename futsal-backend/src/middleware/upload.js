const multer = require('multer');
const sharp = require('sharp');

const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 2 * 1024 * 1024, files: 1 }, // 2 MB
  fileFilter: (req, file, cb) => {
    if (!/^image\/(png|jpe?g|webp)$/.test(file.mimetype)) {
      const err = new Error('Only PNG, JPG or WebP images are allowed');
      err.status = 400;
      return cb(err);
    }
    cb(null, true);
  },
});

// Usage: imageUpload('logo', { width: 512, height: 512 })
exports.imageUpload = (field, { width = 512, height = 512 } = {}) => [
  (req, res, next) =>
    upload.single(field)(req, res, (err) => {
      if (!err) return next();
      if (err.code === 'LIMIT_FILE_SIZE') err.message = 'Image must be 2 MB or smaller';
      err.status = err.status || 400;
      next(err);
    }),
  async (req, res, next) => {
    try {
      if (!req.file) {
        const err = new Error(`No image uploaded (field "${field}")`);
        err.status = 400;
        throw err;
      }
      // Re-encode: proves it's a real image, strips EXIF, normalizes format/size
      req.imageBuffer = await sharp(req.file.buffer)
        .rotate()
        .resize(width, height, { fit: 'inside', withoutEnlargement: true })
        .webp({ quality: 85 })
        .toBuffer();
      next();
    } catch (e) {
      e.status = 400;
      e.message = e.message.startsWith('No image') ? e.message : 'Invalid or corrupt image';
      next(e);
    }
  },
];