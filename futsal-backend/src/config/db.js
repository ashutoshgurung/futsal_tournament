const { PrismaClient } = require('@prisma/client');
const env = require('./env');

const databaseUrl = new URL(env.databaseUrl);
if (databaseUrl.hostname.includes('-pooler')) {
  const defaults = {
    pgbouncer: 'true',
    connection_limit: '5',
    connect_timeout: '30',
    pool_timeout: '30',
  };
  for (const [key, value] of Object.entries(defaults)) {
    if (!databaseUrl.searchParams.has(key)) databaseUrl.searchParams.set(key, value);
  }
}

// Reuse one client across nodemon reloads in development
const prisma =
  global.__prisma ||
  new PrismaClient({
    datasources: { db: { url: databaseUrl.toString() } },
    log: env.nodeEnv === 'development' ? ['warn', 'error'] : ['error'],
  });
if (env.nodeEnv !== 'production') global.__prisma = prisma;

const tx = (fn) =>
  prisma.$transaction((transaction) => fn(transaction), {
    maxWait: 15_000,
    timeout: 20_000,
  });

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

async function connectDB(retries = 5, delayMs = 3000) {
  for (let attempt = 1; attempt <= retries; attempt++) {
    try {
      const rows = await prisma.$queryRaw`SELECT current_database() AS db`;
      console.log(`PostgreSQL connected: ${rows[0].db}`);
      return;
    } catch (err) {
      const msg = err.message.split('\n').filter(Boolean).pop();
      console.error(`DB connect attempt ${attempt}/${retries} failed: ${msg}`);
      if (attempt === retries) {
        console.error('Giving up on PostgreSQL connection.');
        process.exit(1);
      }
      await sleep(delayMs);
    }
  }
}

// Release connections on shutdown / nodemon restart
let shuttingDown = false;
async function shutdown(signal) {
  if (shuttingDown) return;
  shuttingDown = true;
  try {
    await prisma.$disconnect();
  } finally {
    if (signal === 'SIGUSR2') process.kill(process.pid, 'SIGUSR2'); // nodemon restart
    else process.exit(0);
  }
}
process.once('SIGUSR2', () => shutdown('SIGUSR2'));
process.on('SIGINT', () => shutdown('SIGINT'));
process.on('SIGTERM', () => shutdown('SIGTERM'));

module.exports = { prisma, tx, connectDB };