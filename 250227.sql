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
select first_name, last_name from actor;

