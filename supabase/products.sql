-- Supabase SQL Editor에서 이 파일 내용을 통째로 붙여넣고 Run 하세요.
-- (Project 대시보드 -> SQL Editor -> New query)

create table if not exists products (
  id bigint generated always as identity primary key,
  name text not null,
  description text,
  category text,
  old_price integer,
  price integer,
  image_url text,
  is_best boolean default false,
  created_at timestamptz default now()
);

-- 사이트에서 공개키로 상품을 읽을 수 있도록 읽기 전용 공개 접근 허용
alter table products enable row level security;

drop policy if exists "Public read access" on products;
create policy "Public read access" on products
  for select using (true);

-- 기존 데이터가 있다면 중복 없이 다시 실행할 수 있도록 비우고 다시 넣기
truncate table products restart identity;

insert into products (name, description, category, old_price, price, image_url, is_best) values
('전동드릴', '강력한 모터로 나사 조임과 구멍 뚫기를 빠르게 해주는 필수 전동공구예요', '전동공구', 89000, 69000, 'https://upload.wikimedia.org/wikipedia/commons/0/0c/Cordless_electric_%28screw%29_drill.jpg', true),
('전동그라인더', '금속 절단과 연마에 강한 힘을 발휘하는 전문가용 그라인더예요', '전동공구', 75000, 59000, 'https://upload.wikimedia.org/wikipedia/commons/4/48/Makita_GA9050_Angle_Grinder.jpg', true),
('전동톱', '목재 절단을 빠르고 정확하게 해주는 인기 전동공구예요', '전동공구', 95000, 78000, 'https://upload.wikimedia.org/wikipedia/commons/5/59/The_circular_saw.jpg', false),
('망치', '튼튼한 강철 헤드로 못박기와 철거 작업에 두루 쓰이는 기본 공구예요', '수공구', 15000, 11000, 'https://upload.wikimedia.org/wikipedia/commons/8/84/Claw-hammer.jpg', false),
('렌치세트', '다양한 크기의 볼트와 너트에 맞춰 쓸 수 있는 필수 렌치 세트예요', '수공구', 32000, 25000, 'https://upload.wikimedia.org/wikipedia/commons/9/98/Chrome_Vanadium_Adjustable_Wrench.jpg', false),
('니퍼', '전선이나 얇은 철사를 깔끔하게 잘라주는 손에 꼭 맞는 공구예요', '수공구', 12000, 9000, 'https://upload.wikimedia.org/wikipedia/commons/5/51/Carbon_steel_diagonal_side_cutters.jpg', false),
('롱노즈플라이어', '좁은 공간에서 부품을 잡거나 구부릴 때 유용한 플라이어예요', '수공구', 11000, 8500, 'https://upload.wikimedia.org/wikipedia/commons/6/6b/Needle_nose_pliers.jpg', false),
('스크류드라이버세트', '다양한 나사 규격에 맞는 팁이 모두 들어있는 실용적인 세트예요', '수공구', 25000, 18000, 'https://upload.wikimedia.org/wikipedia/commons/d/d3/Robertson_screwdriver_set.jpg', false),
('줄자', '정확한 길이 측정을 위한 필수 아이템, 휴대하기도 편해요', '측정공구', 9000, 6500, 'https://upload.wikimedia.org/wikipedia/commons/e/ea/Tape_measure.JPG', false),
('수평계', '수평과 수직을 정확히 맞춰주는 시공 필수 측정 도구예요', '측정공구', 18000, 14000, 'https://upload.wikimedia.org/wikipedia/commons/4/4c/Vodovaha_-_Spirit_level_-_Wasserwaage.jpg', false);
