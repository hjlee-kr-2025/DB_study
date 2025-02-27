select @@version;
select @@datadir;
-- 주석은 '-- ' 마이너스2개와 스페이스하나를 치시고
-- 그뒤에 적는 문장은 주석입니다.
-- select 는 정보를 가져올때 사용합니다.
-- select @@ 로 시작하면 DB시스템에 가지고 있는
-- 정보를 확인할 때 사용하시면 됩니다.

-- 3.1 sakila DB사용
use sakila;
-- sakila에 만들어진 table 확인
show tables;
-- 데이터 베이스안에 저장된 내용은 테이블이름을 알아야
-- 가지고 올 수 있습니다.

-- 테이블의 모든 데이터를 불러오자.
select * from actor;
-- 특정 열(column)에 대한 데이터를 가져오자.
select first_name, last_name from actor;

select * from city;
-- 테이블안의 저장된데이터의 개수를 알려면?
-- actor 테이블 데이터개수를 알아보자.
select count(*) from actor;

select * from language;
-- language 테이블에서 name 이 English 인 데이터만 가져옵니다.
select * from language where name = 'English';

select * from actor where actor_id > 195;

-- language 테이블에서 language_id가 3인것을 제외하고 가져옵니다.
select * from language where language_id <> 3;
select * from language where language_id != 3;

-- actor 테이블의 first_name 을 조건으로 실습합니다.
select * from actor where first_name < 'B';
select * from actor where first_name < 'b';

-- film table
select * from ffilm_actorilm;
-- title 에 family 가 들어있는 데이터를 가져올때?
select * from film where title like '%family%';

