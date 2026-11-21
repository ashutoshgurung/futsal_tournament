const { z } = require('zod');

const uuid = z.string().uuid('Invalid ID');
const email = z.string().trim().toLowerCase().email();
const password = z.string().min(8, 'Password must be at least 8 characters').max(72);
const name = z.string().trim().min(2).max(80);

// Treat "" and null as "not provided"
const emptyToUndef = (v) =>
  v === null || (typeof v === 'string' && v.trim() === '') ? undefined : v;

// Wraps any zod schema so null / "" / missing all become undefined
const optional = (schema) => z.preprocess(emptyToUndef, schema.optional());

// ---- auth / users / org ----
exports.register = z.object({
  organizationName: optional(name), // omitted => regular user account
  contactEmail: optional(email),
  logoUrl: optional(z.string().trim().url().max(500)),
  name,
  email,
  password,
});

exports.login = z.object({ email, password: z.string().min(1) });

exports.google = z.object({
  idToken: z.string().min(1, 'idToken is required'),
  organizationName: optional(name),
});

// FIX: this was missing, so POST /api/auth/organization returned a 500
exports.createOrganization = z.object({
  organizationName: name,
});

exports.changePassword = z.object({
  currentPassword: z.string().min(1).optional(), // Google-only users have none
  newPassword: password,
});

// FIX: 'admin' is not in your Prisma UserRole enum
exports.createUser = z.object({
  name,
  email,
  password,
  role: z.enum(['organizer', 'scorekeeper']).default('scorekeeper'),
});
exports.updateUser = z.object({
  name: name.optional(),
  role: z.enum(['organizer', 'scorekeeper']).optional(),
  isActive: z.boolean().optional(),
});

exports.updateOrganization = z.object({
  name: name.optional(),
  contactEmail: optional(email),
});

// ---- tournaments ----
const tournamentFields = {
  name: z.string().trim().min(2).max(100),
  description: optional(z.string().max(1000)),
  format: z.enum(['league', 'knockout']).optional(),
  status: z.enum(['draft', 'registration', 'ongoing', 'completed']).optional(),
  startDate: z.coerce.date().optional(),
  endDate: z.coerce.date().optional(),
  venue: optional(z.string().max(200)),
  maxTeams: z.number().int().min(2).max(128).optional(), // was being stripped
  imageUrl: optional(z.string().trim().url().max(500)),  // was being stripped
  rules: z
    .object({
      pointsWin: z.number().int().min(0).max(10),
      pointsDraw: z.number().int().min(0).max(10),
      pointsLoss: z.number().int().min(0).max(10),
      halfDurationMinutes: z.number().int().min(1).max(60),
    })
    .partial()
    .optional(),
};
exports.createTournament = z.object(tournamentFields);
exports.updateTournament = z.object(tournamentFields).partial();
exports.generateFixtures = z.object({
  doubleRound: z.boolean().optional(),
  startDate: z.coerce.date().optional(),
  roundIntervalDays: z.number().int().min(1).max(60).optional(),
  shuffle: z.boolean().optional(),
  regenerate: z.boolean().optional(),
});

// ---- teams / players ----
const teamFields = {
  name: z.string().trim().min(2).max(80),
  shortName: optional(z.string().trim().min(2).max(6)),
  logoUrl: optional(z.string().trim().url().max(500)),
  manager: z
    .object({
      name: optional(z.string().trim().max(100)),
      phone: optional(z.string().trim().max(30)),
      email: optional(email),
    })
    .optional(),
};
exports.createTeam = z.object({ tournament: uuid, ...teamFields });
exports.updateTeam = z.object(teamFields).partial();

const playerFields = {
  name: z.string().trim().min(2).max(80),
  jerseyNumber: z.number().int().min(0).max(99),
  position: z.enum(['goalkeeper', 'fixo', 'ala', 'pivot']).optional(),
  dateOfBirth: z.coerce.date().optional(),
  isActive: z.boolean().optional(),
};
exports.createPlayer = z.object({ team: uuid, ...playerFields });
exports.updatePlayer = z.object(playerFields).partial();

// ---- matches ----
exports.updateMatch = z.object({
  scheduledAt: z.coerce.date().optional(),
  court: optional(z.string().max(100)),
  status: z.enum(['scheduled', 'postponed', 'cancelled']).optional(),
});
exports.matchEvent = z.object({
  type: z.enum(['goal', 'own_goal', 'yellow_card', 'red_card']),
  team: uuid,
  player: uuid.optional(),
  minute: z.number().int().min(0).max(120).default(0),
});
exports.finishMatch = z.object({
  penaltyHome: z.number().int().min(0).optional(),
  penaltyAway: z.number().int().min(0).optional(),
});