-- Run once in Supabase > SQL Editor
create table if not exists members (
  id uuid primary key references auth.users(id) on delete cascade,
  saved jsonb default '[]'::jsonb,
  draft jsonb default '{}'::jsonb,
  updated_at timestamptz default now()
);
alter table members enable row level security;
create policy "own row read"   on members for select using (auth.uid() = id);
create policy "own row insert" on members for insert with check (auth.uid() = id);
create policy "own row update" on members for update using (auth.uid() = id);
