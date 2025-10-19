#!/usr/bin/env bash
set -euo pipefail

# Usage: DATABASE_URL=postgres://... ./apply_migrations.sh
if [ -z "${DATABASE_URL:-}" ]; then
  echo "Please set DATABASE_URL environment variable to your Supabase Postgres URL"
  exit 1
fi

echo "Applying migrations to $DATABASE_URL"

for f in $(ls -1 supabase/migrations/*.sql | sort); do
  echo "Applying $f"
  psql "$DATABASE_URL" -f "$f"
done

echo "Migrations applied"
