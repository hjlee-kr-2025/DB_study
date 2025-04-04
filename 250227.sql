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
select * from film_actor;
-- title 에 family 가 들어있는 데이터를 가져올때?
select * from film where title like '%family%';


select * from film_list;
-- 논리연산자로 데이터 가져오기
select title from film_list where category
	like 'Sci-Fi' and rating like 'PG';

select title from film_list where
	category like 'Children' or
    category like 'Family';

select title from film_list where
	(category like 'Sci-Fi' or
    category like 'Family') and
    rating like 'PG';
    
select * from language where
	not (language_id = '3');
    
select * from film_list;    
-- 복잡한 쿼리
-- 가격범위가 2에서 4 사이이고 Documentary 나 Horror 장르
-- Bob 배우등장하는 영화제목을 가져오는 쿼리
select title from film_list
	where price between 2 and 4
    and (category like 'Documentary' or
    category like 'Horror')
    and actors like '%Bob%';
    
select * from actor;
-- sort (정렬) 을 위해 사용하는 명령 ordey by
select * from actor order by first_name;
-- 기본은 오름차순 정렬입니다.
-- 내림차순 정렬은?
select * from actor order by first_name desc;

-- mysql 에서만 사용할 수 있는 limit
select * from actor order by first_name desc limit 5;

-- 두개의 테이블을 결합해서 데이터를 가져옵니다.
select * from city;
select * from country;

select city, country from city inner join country
	on city.country_id = country.country_id
    where country.country_id < 5
    order by country, city;
-- 위와 똑같은 처리를 하는 다른 방법
select city. country from city inner join country
	using (country_id)
    where country.country_id <5
    order by country, city;

-- country_id = 49 인 도시의 개수는?
select count(*) from city inner join country
	on city.country_id = country.country_id
    where country.country_id = 49
    order by country, city;
    
    
-- insert CRUD의 C에 해당하는 명령문입니다.
-- lagauage table이 어떻게 구성되어있는지 확인
show columns from language;
select * from language;
insert into language values(null, 'Protuguese', now());
insert into language values(8, 'Russian', '2025-02-27 14:27:01');
insert into language values(null, 'Arabic', now());
insert into language values(null, 'Spanish', now()),
	(null, 'Hebrew', now());
    
insert into language (name) values ('Korean'); 


desc city;
insert into city (city, country_id) 
	values ('Bebedouro', 19);
select * from city order by city_id desc;

-- 여러 데이터 동시 저장
insert into city (city, country_id)
	values ('Sao Carlos', 19),
    ('Araraquara', 19),
    ('Ribeirao Preto', 19);

desc country;
insert into country values (null, 'Uruguay', default);
select * from country order by country_id desc;

insert into country set country_id=null,
	country='Bahamas', last_update=now();
    
    
-- delete 명령문 (데이터 삭제)
select * from rental;
-- safe모드 비활성화
set sql_safe_updates = 0;
-- 테이블내 데이터를 전체 삭제합니다.
delete from rental;

select * from language;
-- language 테이블에 language_id 가 10번인것은 삭제하겠습니다.
delete from language where language_id = 10;


-- update : 데이터 수정
select * from payment;
update payment set amount=amount*1.1;

update payment set last_update=now();


-- 보통은 수정시 where 문과 함께 사용됩니다.
select * from actor;
update actor set last_name=upper('cruz')
	where first_name like 'PENELOPE'
    and last_name like 'GUINESS';


-- 정보를 확인하는 명령들
-- 데이터베이스가 어떤것이 있는지 확인
show databases;
-- 테이블(table) 확인
show tables;
show tables from world;
-- column 확인
show columns from country;

show create table country;
   