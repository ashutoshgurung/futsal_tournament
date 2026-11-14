// src/validators/auth.validators.js
const { z } = require('zod');

const googleSchema = z.object({
  body: z.object({
    idToken: z.string().min(1),
  }),
});

module.exports = { loginSchema, registerSchema, googleSchema }; // <- must include googleSchema