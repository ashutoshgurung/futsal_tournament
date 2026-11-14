const fs = require('fs/promises');
const path = require('path');

const ROOT = path.join(__dirname, '..', 'uploads');
const PUBLIC_PREFIX = '/uploads';

// key e.g. "orgs/<orgId>/logo-1731600000000.webp"
exports.save = async (key, buffer) => {
  const full = path.join(ROOT, key);
  await fs.mkdir(path.dirname(full), { recursive: true });
  await fs.writeFile(full, buffer);
  return `${PUBLIC_PREFIX}/${key}`; // store this in logoUrl
};

exports.remove = async (url) => {
  if (!url || !url.startsWith(PUBLIC_PREFIX + '/')) return; // ignore foreign/legacy URLs
  const full = path.join(ROOT, url.slice(PUBLIC_PREFIX.length + 1));
  if (!full.startsWith(ROOT)) return; // path traversal guard
  await fs.unlink(full).catch(() => {});
};

exports.ROOT = ROOT;