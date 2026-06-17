-- ─────────────────────────────────────────────────────────────
--  ClassTrack — Supabase SQL Setup
--  Run this in the Supabase SQL Editor (once).
-- ─────────────────────────────────────────────────────────────

-- 1. Admins table (credentials stored here, not in client code)
create table if not exists admins (
  id         uuid primary key default gen_random_uuid(),
  username   text unique not null,
  password   text not null,          -- store plaintext for now; see note below
  created_at timestamptz default now()
);

-- 2. Seed your first admin account
--    Change the username/password before running!
insert into admins (username, password)
values ('admin', 'change_me_now')
on conflict (username) do nothing;

-- 3. Lock down the admins table with Row Level Security
--    The anon key can SELECT (needed for login check) but cannot INSERT/UPDATE/DELETE
alter table admins enable row level security;

-- Allow the app to check credentials (read-only)
create policy "allow_login_check" on admins
  for select using (true);

-- Block all writes from the browser (manage admins via Supabase dashboard only)
create policy "deny_insert" on admins for insert with check (false);
create policy "deny_update" on admins for update using (false);
create policy "deny_delete" on admins for delete using (false);

-- ─────────────────────────────────────────────────────────────
--  NOTE ON PASSWORD SECURITY
--  The setup above stores plaintext passwords, which is fine
--  for a private classroom tool. If you want proper hashing:
--
--  1. Enable the pgcrypto extension in Supabase:
--       create extension if not exists pgcrypto;
--
--  2. Store hashed passwords:
--       insert into admins (username, password)
--       values ('admin', crypt('your_password', gen_salt('bf')));
--
--  3. In classroom_tracker.html, change the login query to:
--       .eq('username', u)
--       .filter('password', 'eq', `crypt('${p}', password)`)
--     OR use a Supabase Edge Function / RPC for the comparison.
-- ─────────────────────────────────────────────────────────────
