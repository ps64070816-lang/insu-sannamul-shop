-- Supabase SQL Editor에서 이 파일 내용을 통째로 붙여넣고 Run 하세요.
-- (Project 대시보드 -> SQL Editor -> New query)
-- 로그인한 사용자의 장바구니를 저장하는 테이블입니다.
-- (비로그인 방문자는 기존처럼 브라우저 localStorage를 계속 사용합니다)

create table if not exists cart_items (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  product_name text not null,
  price integer not null,
  qty integer not null default 1,
  added_at timestamptz not null default now(),
  unique (user_id, product_name)
);

-- 본인의 장바구니만 보고 수정할 수 있도록 제한
alter table cart_items enable row level security;

drop policy if exists "Users manage their own cart" on cart_items;
create policy "Users manage their own cart" on cart_items
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
