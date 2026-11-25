'use strict';
const crypto = require('crypto');
const { prisma } = require('../config/db');

// Swap for your own ApiError class if you have one.
const httpError = (statusCode, message) => Object.assign(new Error(message), { statusCode });

/* ──────────────────────────── pure bracket helpers ──────────────────────────── */

const isPowerOfTwo = (n) => Number.isInteger(n) && n >= 2 && (n & (n - 1)) === 0;

const nextPowerOfTwo = (n) => {
  let size = 2;
  while (size < n) size *= 2;
  return size;
};

const shuffle = (arr) => {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = crypto.randomInt(i + 1);
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
};

// Standard seeding order so seed 1 and 2 can only meet in the final.
// size 8 -> [1,8,4,5,2,7,3,6]. Seeds above team count become byes (top seeds get them).
const seedOrder = (size) => {
  let order = [1];
  while (order.length < size) {
    const total = order.length * 2;
    order = order.flatMap((s) => [s, total + 1 - s]);
  }
  return order;
};

const roundName = (round, totalRounds) => {
  const fromEnd = totalRounds - round;
  if (fromEnd === 0) return 'Final';
  if (fromEnd === 1) return 'Semi Final';
  if (fromEnd === 2) return 'Quarter Final';
  return `Round of ${2 ** (totalRounds - round + 1)}`;
};

// [{team1Id, team2Id|null}, ...] -> flat slot array (adjacent slots = one first-round match)
const pairingsToSlots = (pairings) =>
  pairings.flatMap((p) => {
    const a = p.team1Id || null;
    const b = p.team2Id || null;
    if (!a && !b) throw httpError(400, 'Each pairing needs at least one team');
    return a ? [a, b] : [b, null]; // a lone team is a bye
  });

/**
 * Builds every match of a single-elimination bracket in memory (no DB).
 * slots: array of teamId|null, length = bracket size (power of 2).
 */
const planMatches = ({ organizationId, tournamentId, tieSheetId, slots, thirdPlaceMatch }) => {
  const size = slots.length;
  const totalRounds = Math.log2(size);
  let matchNumber = 0;

  const blank = (round, i) => ({
    id: crypto.randomUUID(),
    organizationId,
    tournamentId,
    tieSheetId,
    round,
    roundName: roundName(round, totalRounds),
    matchNumber: ++matchNumber,
    bracketPosition: i + 1,
    team1Id: null,
    team2Id: null,
    winnerId: null,
    isBye: false,
    status: 'scheduled',
    nextMatchId: null,
    nextMatchSlot: null,
    loserNextMatchId: null,
    loserNextSlot: null,
  });

  const rounds = [];
  for (let r = 1; r <= totalRounds; r++) {
    rounds.push(Array.from({ length: size / 2 ** r }, (_, i) => blank(r, i)));
  }

  // wire winner progression
  for (let r = 0; r < totalRounds - 1; r++) {
    rounds[r].forEach((m, i) => {
      m.nextMatchId = rounds[r + 1][i >> 1].id;
      m.nextMatchSlot = i % 2 === 0 ? 1 : 2;
    });
  }

  // fill round 1, auto-advance byes
  rounds[0].forEach((m, i) => {
    const a = slots[2 * i];
    const b = slots[2 * i + 1];
    if (!a && !b) throw httpError(400, `First-round match ${i + 1} has no teams`);
    if (a && b) {
      m.team1Id = a;
      m.team2Id = b;
      return;
    }
    const team = a || b;
    m.team1Id = team;
    m.isBye = true;
    m.status = 'completed';
    m.winnerId = team;
    if (m.nextMatchId) {
      const next = rounds[1].find((x) => x.id === m.nextMatchId);
      next[m.nextMatchSlot === 1 ? 'team1Id' : 'team2Id'] = team;
    }
  });

  const matches = rounds.flat();

  if (thirdPlaceMatch) {
    if (totalRounds < 2) throw httpError(400, 'Third place match needs at least 4 slots');
    const semis = rounds[totalRounds - 2];
    if (semis.some((s) => s.isBye)) {
      throw httpError(400, 'Third place match is not possible when a semi final is a bye');
    }
    const third = blank(totalRounds, 1);
    third.roundName = 'Third Place';
    semis.forEach((s, i) => {
      s.loserNextMatchId = third.id;
      s.loserNextSlot = i + 1;
    });
    matches.push(third);
  }
  return matches;
};

const buildEntries = (tieSheetId, slots, seedOf) =>
  slots
    .map((teamId, idx) =>
      teamId ? { tieSheetId, teamId, slot: idx + 1, seed: seedOf ? seedOf.get(teamId) ?? null : null } : null
    )
    .filter(Boolean);

/* ──────────────────────────── validation helpers ──────────────────────────── */

const assertTournament = async (orgId, tournamentId) => {
  const t = await prisma.tournament.findFirst({ where: { id: tournamentId, organizationId: orgId } });
  if (!t) throw httpError(404, 'Tournament not found');
  return t;
};

const assertTeams = async (orgId, tournamentId, slots) => {
  const ids = slots.filter(Boolean);
  if (new Set(ids).size !== ids.length) throw httpError(400, 'A team appears more than once');
  if (ids.length < 2) throw httpError(400, 'At least 2 teams are required');
  const found = await prisma.team.count({
    where: { id: { in: ids }, tournamentId, organizationId: orgId },
  });
  if (found !== ids.length) throw httpError(400, 'One or more teams do not belong to this tournament');
};

/* ──────────────────────────── queries ──────────────────────────── */

const teamSelect = { id: true, name: true, shortName: true, logoUrl: true };

async function getTieSheet(orgId, id) {
  const sheet = await prisma.tieSheet.findFirst({
    where: { id, organizationId: orgId },
    include: {
      entries: { orderBy: { slot: 'asc' }, include: { team: { select: teamSelect } } },
      matches: {
        orderBy: [{ round: 'asc' }, { bracketPosition: 'asc' }],
        include: {
          team1: { select: teamSelect },
          team2: { select: teamSelect },
          winner: { select: teamSelect },
        },
      },
    },
  });
  if (!sheet) throw httpError(404, 'Tie sheet not found');

  const { matches, ...rest } = sheet;
  const byRound = new Map();
  matches.forEach((m) => {
    if (!byRound.has(m.round)) byRound.set(m.round, []);
    byRound.get(m.round).push(m);
  });
  const rounds = [...byRound.entries()].map(([round, ms]) => ({
    round,
    name: roundName(round, sheet.totalRounds),
    matches: ms,
  }));
  return { ...rest, rounds };
}

const listTieSheets = (orgId, tournamentId) =>
  prisma.tieSheet.findMany({
    where: { organizationId: orgId, tournamentId },
    orderBy: { createdAt: 'desc' },
  });

/* ──────────────────────────── create (shared) ──────────────────────────── */

async function createTieSheet({ orgId, tournamentId, name, seedingMethod, thirdPlaceMatch, slots, seedOf }) {
  if (!isPowerOfTwo(slots.length)) throw httpError(400, 'Bracket size must be a power of 2');
  await assertTournament(orgId, tournamentId);
  await assertTeams(orgId, tournamentId, slots);

  const dup = await prisma.tieSheet.findFirst({ where: { tournamentId, name } });
  if (dup) throw httpError(409, 'A tie sheet with this name already exists in the tournament');

  const id = crypto.randomUUID();
  const matches = planMatches({ organizationId: orgId, tournamentId, tieSheetId: id, slots, thirdPlaceMatch }); // throws before touching DB
  const entries = buildEntries(id, slots, seedOf);

  await prisma.$transaction(async (tx) => {
    await tx.tieSheet.create({
      data: {
        id,
        organizationId: orgId,
        tournamentId,
        name,
        type: 'single_elimination',
        seedingMethod,
        bracketSize: slots.length,
        totalRounds: Math.log2(slots.length),
        thirdPlaceMatch,
        generatedAt: new Date(),
      },
    });
    await tx.tieSheetEntry.createMany({ data: entries });
    await tx.match.createMany({ data: matches });
  });

  return getTieSheet(orgId, id);
}

/* ──────────────────────────── 1. GENERATOR (automatic) ──────────────────────────── */
/**
 * Uses all teams of the tournament.
 *  - random: shuffled, seeds assigned in shuffle order
 *  - seeded: `seeds` = teamIds in seed order (1st = seed 1); unlisted teams are shuffled in after
 * Bracket size is the next power of 2; byes go to the top seeds.
 */
async function generateTieSheet({ orgId, tournamentId, name = 'Main Draw', seedingMethod = 'random', seeds = [], thirdPlaceMatch = false }) {
  await assertTournament(orgId, tournamentId);
  const teams = await prisma.team.findMany({
    where: { tournamentId, organizationId: orgId },
    select: { id: true },
  });
  if (teams.length < 2) throw httpError(400, 'At least 2 teams are required to generate a tie sheet');

  const teamIds = teams.map((t) => t.id);
  let ordered;
  if (seedingMethod === 'seeded') {
    if (seeds.some((s) => !teamIds.includes(s))) throw httpError(400, 'seeds contains a team outside this tournament');
    const rest = shuffle(teamIds.filter((id) => !seeds.includes(id)));
    ordered = [...seeds, ...rest];
  } else {
    ordered = shuffle(teamIds);
  }

  const size = nextPowerOfTwo(ordered.length);
  const slots = seedOrder(size).map((seed) => ordered[seed - 1] ?? null);
  const seedOf = new Map(ordered.map((id, i) => [id, i + 1]));

  return createTieSheet({ orgId, tournamentId, name, seedingMethod, thirdPlaceMatch, slots, seedOf });
}

/* ──────────────────────────── 2. MANUAL ──────────────────────────── */
/**
 * Organizer decides every first-round pairing.
 * pairings: [{ team1Id, team2Id }, ...]; omit team2Id for a bye. Count must be a power of 2.
 */
async function createManualTieSheet({ orgId, tournamentId, name = 'Main Draw', pairings, thirdPlaceMatch = false }) {
  const slots = pairingsToSlots(pairings);
  return createTieSheet({ orgId, tournamentId, name, seedingMethod: 'manual', thirdPlaceMatch, slots, seedOf: null });
}

// Re-arrange a tie sheet before play starts (rebuilds all matches).
async function replacePairings(orgId, id, { pairings, thirdPlaceMatch }) {
  const sheet = await prisma.tieSheet.findFirst({
    where: { id, organizationId: orgId },
    include: { matches: { select: { status: true, isBye: true } } },
  });
  if (!sheet) throw httpError(404, 'Tie sheet not found');
  if (sheet.isLocked) throw httpError(409, 'Tie sheet is locked');
  if (sheet.matches.some((m) => !m.isBye && m.status !== 'scheduled')) {
    throw httpError(409, 'Matches have already started; the draw can no longer be changed');
  }

  const slots = pairingsToSlots(pairings);
  if (!isPowerOfTwo(slots.length)) throw httpError(400, 'Number of pairings must be a power of 2');
  await assertTeams(orgId, sheet.tournamentId, slots);

  const third = thirdPlaceMatch ?? sheet.thirdPlaceMatch;
  const matches = planMatches({
    organizationId: orgId,
    tournamentId: sheet.tournamentId,
    tieSheetId: id,
    slots,
    thirdPlaceMatch: third,
  });

  await prisma.$transaction(async (tx) => {
    await tx.match.deleteMany({ where: { tieSheetId: id } });
    await tx.tieSheetEntry.deleteMany({ where: { tieSheetId: id } });
    await tx.tieSheet.update({
      where: { id },
      data: {
        seedingMethod: 'manual',
        bracketSize: slots.length,
        totalRounds: Math.log2(slots.length),
        thirdPlaceMatch: third,
        generatedAt: new Date(),
      },
    });
    await tx.tieSheetEntry.createMany({ data: buildEntries(id, slots, null) });
    await tx.match.createMany({ data: matches });
  });

  return getTieSheet(orgId, id);
}

/* ──────────────────────────── meta / delete ──────────────────────────── */

async function updateTieSheet(orgId, id, data) {
  const sheet = await prisma.tieSheet.findFirst({ where: { id, organizationId: orgId } });
  if (!sheet) throw httpError(404, 'Tie sheet not found');
  if (data.name && data.name !== sheet.name) {
    const dup = await prisma.tieSheet.findFirst({ where: { tournamentId: sheet.tournamentId, name: data.name } });
    if (dup) throw httpError(409, 'A tie sheet with this name already exists in the tournament');
  }
  await prisma.tieSheet.update({ where: { id }, data });
  return getTieSheet(orgId, id);
}

async function deleteTieSheet(orgId, id) {
  const sheet = await prisma.tieSheet.findFirst({ where: { id, organizationId: orgId } });
  if (!sheet) throw httpError(404, 'Tie sheet not found');
  if (sheet.isLocked) throw httpError(409, 'Unlock the tie sheet before deleting it');
  await prisma.tieSheet.delete({ where: { id } }); // matches + entries cascade
}

/* ──────────────────────────── progression ──────────────────────────── */

// Winner of a knockout match from its scores (penalties break draws).
function determineWinnerId(m) {
  if (m.team1Score !== m.team2Score) return m.team1Score > m.team2Score ? m.team1Id : m.team2Id;
  if (m.penaltyTeam1 == null || m.penaltyTeam2 == null || m.penaltyTeam1 === m.penaltyTeam2) {
    throw httpError(400, 'Knockout match cannot end in a draw; enter penalty shootout result');
  }
  return m.penaltyTeam1 > m.penaltyTeam2 ? m.team1Id : m.team2Id;
}

/**
 * Call after a tie-sheet match is completed and winnerId is saved.
 * Pushes the winner (and loser, for the 3rd-place match) into the next match.
 * `db` can be prisma or a transaction client.
 */
async function advanceWinner(db, matchId) {
  const m = await db.match.findUnique({ where: { id: matchId } });
  if (!m || !m.tieSheetId || !m.winnerId) return;

  const push = async (nextId, slot, teamId) => {
    if (!nextId || !teamId) return;
    const next = await db.match.findUnique({ where: { id: nextId } });
    const field = slot === 1 ? 'team1Id' : 'team2Id';
    if (next.status !== 'scheduled' && next[field] !== teamId) {
      throw httpError(409, 'Next match has already started; cannot change its teams');
    }
    await db.match.update({ where: { id: nextId }, data: { [field]: teamId } });
  };

  const loserId = m.winnerId === m.team1Id ? m.team2Id : m.team1Id;
  await push(m.nextMatchId, m.nextMatchSlot, m.winnerId);
  await push(m.loserNextMatchId, m.loserNextSlot, loserId);
}

module.exports = {
  generateTieSheet,
  createManualTieSheet,
  replacePairings,
  getTieSheet,
  listTieSheets,
  updateTieSheet,
  deleteTieSheet,
  determineWinnerId,
  advanceWinner,
  // exported for unit tests
  _internal: { seedOrder, planMatches, nextPowerOfTwo, pairingsToSlots },
};