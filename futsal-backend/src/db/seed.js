const bcrypt = require('bcryptjs');
const { UserRole } = require('@prisma/client');
const { tx, prisma } = require('../config/db');
const { createLeagueFixtures } = require('../services/fixtureService');

const DEMO_ORGANIZER_EMAIL = 'organizer@demo.com';
const DEMO_SCORER_EMAIL = 'scorer@demo.com';

// ...constants and helpers unchanged...

(async () => {
  // Users use onDelete: SetNull, so deleting the org leaves the demo users behind
  // and the next seed run fails on the unique email. Remove them explicitly.
  await prisma.user.deleteMany({
    where: { email: { in: [DEMO_ORGANIZER_EMAIL, DEMO_SCORER_EMAIL] } },
  });
  await prisma.organization.deleteMany({ where: { slug: 'demo-futsal' } });

  await tx(async (t) => {
    const org = await t.organization.create({
      data: { name: 'Demo Futsal League', slug: 'demo-futsal', plan: 'pro' },
    });
    const hash = await bcrypt.hash('password123', 12);
    await t.user.createMany({
      data: [
        { organizationId: org.id, name: 'Demo Organizer', email: DEMO_ORGANIZER_EMAIL, passwordHash: hash, role: UserRole.organizer },
        { organizationId: org.id, name: 'Demo Scorer', email: DEMO_SCORER_EMAIL, passwordHash: hash, role: UserRole.scorekeeper },
      ],
    });

    // ...tournament, teams, players, fixtures, matchdays unchanged...
  });

  console.log('Seed complete.');
  console.log(`  Organizer:   ${DEMO_ORGANIZER_EMAIL} / password123`);
  console.log(`  Scorekeeper: ${DEMO_SCORER_EMAIL} / password123`);
  console.log('  Public:      GET /api/public/demo-futsal/tournaments/spring-futsal-cup/standings');
  await prisma.$disconnect();
})().catch((err) => {
  console.error(err);
  process.exit(1);
});