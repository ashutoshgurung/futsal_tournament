// Joi version. If your validate() middleware uses zod/express-validator, port these shapes.
const Joi = require('joi');

const uuid = Joi.string().uuid();
const pairing = Joi.object({
  team1Id: uuid.allow(null),
  team2Id: uuid.allow(null), // omit/null = bye
}).or('team1Id', 'team2Id');

exports.generate = Joi.object({
  tournamentId: uuid.required(),
  name: Joi.string().trim().max(100).default('Main Draw'),
  seedingMethod: Joi.string().valid('random', 'seeded').default('random'),
  seeds: Joi.array().items(uuid).unique().default([]), // teamIds in seed order (seeded only)
  thirdPlaceMatch: Joi.boolean().default(false),
});

exports.manual = Joi.object({
  tournamentId: uuid.required(),
  name: Joi.string().trim().max(100).default('Main Draw'),
  pairings: Joi.array().items(pairing).min(1).required(), // count must be a power of 2 (checked in service)
  thirdPlaceMatch: Joi.boolean().default(false),
});

exports.replacePairings = Joi.object({
  pairings: Joi.array().items(pairing).min(1).required(),
  thirdPlaceMatch: Joi.boolean(),
});

exports.update = Joi.object({
  name: Joi.string().trim().max(100),
  isPublished: Joi.boolean(),
  isLocked: Joi.boolean(),
}).min(1);