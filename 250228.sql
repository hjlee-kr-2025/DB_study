-- sakila db 사용명령 : use sakila;
use sakila;
-- actor 테이블에 저장된 모든 내용을 보여주세요
select * from actor;
-- 별칭에 대해 배우려고 합니다. (alias) as 명령어
select actor_id as id, first_name as fn,
	last_name as ln from actor;
    
select concat(first_name, ' ', last_name,
	' played in ', title) as movie
    from actor join film_actor using (actor_id)
    join film using (film_id)
    order by movie;
    
-- 열이름 별칭은 where, using, on 에는 사용할 수 없습니다.
-- 최대 255자 까지 가능합니다.

-- 테이블 별칭 : as 를 사용합니다.
select * from actor;
select * from film_actor;
select * from film;

select a.actor_id, a.first_name, a.last_name, f.title, a.last_update from
	actor as a inner join film_actor as fa using (actor_id)
    inner join film as f using (film_id)
    where f.title = 'AFFAIR PREJUDICE';
-- 테이블이름에 별칭을 주었을때 주의해야 할 사항
-- 별칭을 준 쿼리문에서는 테이블이름을 별칭으로만 사용해야 합니다.

-- 같은 테이블에 같은 제목의 영화가 있는지 확인하는 쿼리
-- 아래는 잘못된 쿼리 예)
select f1.film_id, f2.title from 
	film as f1, film as f2
    where f1.title = f2.title;

-- id 를 확인합니다. - id 가 다를때를 확인
select f1.film_id, f2.title from 
	film as f1, film as f2
    where f1.title = f2.title
    and f1.film_id <> f2.film_id;

-- 데이터 집계
-- distinct : 중복을 제거하는 필터역할
select first_name from actor
	join film_actor using (actor_id);
select distinct first_name from actor
	join film_actor using (actor_id);

select distinct first_name, last_name
	from actor join film_actor using (actor_id);
    
-- group by - 출력데이터를 그룹화
select first_name from actor
	where first_name in ('GENE', 'MERYL');
select first_name from actor
	where first_name in ('GENE', 'MERYL')
    group by first_name;

-- 영화출연작이 많은 배우순으로 이름을 보여주는 쿼리    
select first_name, last_name, count(film_id) as num_films
	from actor join film_actor using (actor_id)
    group by first_name, last_name
    order by num_films desc;
    
-- 영화이름, 카테고리, 출연배우수를 화면표시, 출연배우수기준 정렬
select * from category;
select title, name as category_name, count(*) as cnt
	from film join film_actor using (film_id)
    join film_category using (film_id)
    join category using (category_id)
    group by film_id, category_id
    order by cnt desc;





select 
