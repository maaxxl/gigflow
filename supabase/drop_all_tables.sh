#!/usr/bin/env bash
set -euo pipefail

# Danger: This will drop all tables in the public schema.
# Usage: DATABASE_URL=postgres://... ./supabase/drop_all_tables.sh

if [ -z "${DATABASE_URL:-}" ]; then
  echo "Please set DATABASE_URL environment variable to your Supabase Postgres URL"
  exit 1
fi

echo "Dropping all tables in public schema on $DATABASE_URL"

psql "$DATABASE_URL" -v ON_ERROR_STOP=1 <<'SQL'
DO $$ DECLARE
  r RECORD;
BEGIN
  -- Drop all foreign-key constraints
  FOR r IN (SELECT table_name, constraint_name FROM information_schema.table_constraints WHERE constraint_type = 'FOREIGN KEY' AND table_schema='public') LOOP
    EXECUTE format('ALTER TABLE %I DROP CONSTRAINT %I', r.table_name, r.constraint_name);
  END LOOP;

  -- Drop all tables
  FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') LOOP
    EXECUTE format('DROP TABLE IF EXISTS %I CASCADE', r.tablename);
  END LOOP;
END $$;
SQL

echo "All tables dropped."
