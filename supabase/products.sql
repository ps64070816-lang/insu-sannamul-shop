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
('고사리', '쫄깃한 식감이 매력적인 대표 산나물, 나물무침에 잘 어울려요', '뿌리줄기', 9200, 7500, 'https://upload.wikimedia.org/wikipedia/commons/7/78/Bracken_%28Pteridium_aquilinum%29_frond_unfurling.JPG', true),
('취나물', '향긋한 향과 부드러운 식감의 봄나물이에요', '잎나물', 8100, 6800, 'https://images.pexels.com/photos/4506881/pexels-photo-4506881.jpeg?auto=compress&cs=tinysrgb&w=400', true),
('곰취', '향긋해서 쌈채소로 인기 많은 산나물이에요', '잎나물', 10400, 8600, 'https://images.pexels.com/photos/2270249/pexels-photo-2270249.jpeg?auto=compress&cs=tinysrgb&w=400', true),
('콩나물', '아삭한 식감으로 국물 요리에 잘 어울려요', '새싹', 3500, 2500, 'https://images.pexels.com/photos/36346265/pexels-photo-36346265.jpeg?auto=compress&cs=tinysrgb&w=400', false),
('두릅', '봄철 대표 별미, 초고추장과 찰떡궁합이에요', '잎나물', 11500, 9800, 'https://upload.wikimedia.org/wikipedia/commons/9/90/Korean_angelica-tree_shoots.jpg', false),
('고구마순', '쫄깃하고 담백한 맛, 볶음나물로 인기예요', '잎나물', 9000, 6300, 'https://upload.wikimedia.org/wikipedia/commons/4/45/Sweet_potatoes.JPG', false),
('냉이', '봄내음 가득한 향긋한 뿌리나물이에요', '잎나물', 6000, 5000, 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Capsella_bursa-pastoris_002.JPG', false),
('달래', '알싸한 향으로 양념장 재료로 인기 많아요', '뿌리줄기', 7200, 6000, 'https://upload.wikimedia.org/wikipedia/commons/2/28/Allium_monanthum.jpg', false),
('참나물', '상큼한 향의 쌈채소, 무침에도 잘 어울려요', '잎나물', 8500, 7200, 'https://upload.wikimedia.org/wikipedia/commons/8/87/Chamnamul_flower_%28Pimpinella_brachycarpa%29.jpg', false),
('미나리', '향긋하고 아삭한, 물가에서 자란 나물이에요', '잎나물', 5500, 4500, 'https://upload.wikimedia.org/wikipedia/commons/a/a0/Oenanthe_javanica1.jpg', false);
