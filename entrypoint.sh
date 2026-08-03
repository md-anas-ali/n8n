#!/bin/bash
set -e

# ---------------------------------------------------------
# If DB_POSTGRESDB_CONNECTION_URL is set, parse it into the
# individual DB_POSTGRESDB_* variables that n8n actually reads.
# n8n has no native support for a single connection-string env
# var, so this script bridges that gap.
# ---------------------------------------------------------

if [ -n "$DB_POSTGRESDB_CONNECTION_URL" ]; then
  echo "[entrypoint] DB_POSTGRESDB_CONNECTION_URL detected — parsing into DB_POSTGRESDB_* vars"

  eval "$(python3 - <<'PYEOF'
import os
from urllib.parse import urlparse, parse_qs

url = os.environ["DB_POSTGRESDB_CONNECTION_URL"]
parsed = urlparse(url)
qs = parse_qs(parsed.query)

host = parsed.hostname or ""
port = parsed.port or 5432
database = (parsed.path or "/").lstrip("/")
user = parsed.username or ""
password = parsed.password or ""

sslmode = qs.get("sslmode", [""])[0].lower()
ssl_enabled = "true" if sslmode in ("require", "verify-ca", "verify-full") else "false"

def esc(v):
    return str(v).replace("'", "'\\''")

print(f"export DB_POSTGRESDB_HOST='{esc(host)}'")
print(f"export DB_POSTGRESDB_PORT='{esc(port)}'")
print(f"export DB_POSTGRESDB_DATABASE='{esc(database)}'")
print(f"export DB_POSTGRESDB_USER='{esc(user)}'")
print(f"export DB_POSTGRESDB_PASSWORD='{esc(password)}'")
print(f"export DB_POSTGRESDB_SSL_ENABLED='{esc(ssl_enabled)}'")
PYEOF
)"

  echo "[entrypoint] Parsed host=${DB_POSTGRESDB_HOST} port=${DB_POSTGRESDB_PORT} db=${DB_POSTGRESDB_DATABASE} user=${DB_POSTGRESDB_USER} ssl=${DB_POSTGRESDB_SSL_ENABLED}"
fi

exec "$@"
