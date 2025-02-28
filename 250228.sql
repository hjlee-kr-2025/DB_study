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


select * from customer;
select * from rental;
select * from inventory;    
select email, name as category_name,
	count(category_id) as cnt
    from customer join rental using (customer_id)
    join inventory using (inventory_id)
    join film_category using (film_id)
    join category using (category_id)
    group by 1, 2
    order by 3 desc;
-- 1, 2, 3, 숫자 대신에 email, category_name, cnt 를
-- 사용하셔되 됩니다.

-- count() 열 갯수를 알려주는 함수 입니다.
-- max() 최대값을 알려주는 함수 입니다.


-- join
-- join 명령어가 없었을때 두개의 테이블을 결합하는 방법
use sakila;
select * from actor;
select * from film_actor;
select first_name, last_name, film_id
	from actor, film_actor
    where actor.actor_id = film_actor.actor_id;

select first_name, last_name, film_id
	from actor as a, film_actor as fa
    where a.actor_id = fa.actor_id;
    
select first_name, last_name, film_id
	from actor join film_actor
    on actor.actor_id = film_actor.actor_id;
    
select first_name, last_name, film_id
	from actor join film_actor using (actor_id);

-- union
select first_name from actor
	union
    select first_name from customer
    union
    select title from film;

-- 가장 많이 대여한 영화 5개, 가장 적게 대여한 영화 5개
(select title, count(rental_id) as num_rented
	from film join inventory using (film_id)
    join rental using (inventory_id)
    group by title order by num_rented desc
    limit 5)
    union
    (select title, count(rental_id) as num_rented
	from film join inventory using (film_id)
    join rental using (inventory_id)
    group by title order by num_rented
    limit 5);
    
select title, rental_date
	from film left join inventory using (film_id)
    left join rental using (inventory_id);
-- left join 을 사용시 join 순서도 중요합니다.
-- table의 순서도 중요합니다.


select email, name as category_name, 
	count(category_id) as cnt
    from customer join rental using (customer_id)
    join inventory using (inventory_id)
    join film_category using (film_id)
    join category using (category_id)
    group by email, category_name
    order by cnt desc;
select count(*) from category;
-- 16 개의 카테고리

select email, name as category_name,
	count(category_id) as cnt
    from category left join film_category using (category_id)
	left join inventory using (film_id)
	left join rental using (inventory_id)
    join customer cs on rental.customer_id = cs.customer_id
    where cs.email = 'WESLEY.BULL@sakilacustomer.org'
    group by email, category_name
    order by cnt desc;
    
-- 중첩쿼리
-- 특정영화에 출연한 모든 배우의 이름을 찾는 방법
select first_name, last_name from
	actor join film_actor using (actor_id)
    join film  using (film_id)
    where title = 'ZHIVAGO CORE';

-- 위 내용을 다른 방식으로 구현해 보겠습니다.
select first_name, last_name from
	actor join film_actor using (actor_id)
    where film_id = 
	(select film_id from film
	where title = 'ZHIVAGO CORE');
-- select문 안에 select문이 있는것을 중첩 쿼리라고 합니다.
-- 중첩쿼리 확인
-- 1.
select film_id from film
	where title = 'ZHIVAGO CORE';
-- 위 결과값 998
-- 2.
select first_name, last_name from
	actor join film_actor using (actor_id)
    where film_id = 998;
    
select max(rental_date) from rental
	join customer using (customer_id)
    where email = 'WESLEY.BULL@sakilacustomer.org';
    
select title from film
	join inventory using (film_id)
    join rental using (inventory_id)
    join customer using (customer_id)
    where email = 'WESLEY.BULL@sakilacustomer.org'
    and rental_date = '2025-02-28 11:24:19';
    
-- 위 두 쿼리를 중첩쿼리를 이용해 완성해 봅시다.
select title from film
	join inventory using (film_id)
    join rental using (inventory_id)
    join customer using (customer_id)
    where email = 'WESLEY.BULL@sakilacustomer.org'
    and 
    rental_date = (
		select max(rental_date)
		from rental
		join customer using (customer_id)
		where email =
		'WESLEY.BULL@sakilacustomer.org'
	);
    
-- employees DB 사용
-- setting : mysql 프로그램 경로 path 에 설정
-- cmd 창에서 test_db를 다운받은 폴더로 이동후 p287, p288 명령실행

select * from employees;
-- any
-- 근무기간이 가장 짧은 관리자보다 더 오래 재직한 보조 엔지니어를 찾습니다.
select emp_no, first_name, last_name, hire_date
	from employees join titles using (emp_no)
    where title = 'Assistant Engineer'
    and hire_date < any (
		select hire_date from employees join titles using (emp_no)
        where title = 'Manager'
    );

select hire_date from employees join titles using (emp_no)
        where title = 'Manager'
        order by hire_date desc;
        
-- 직함이 다른 관리자
select emp_no, first_name, last_name
	from employees join titles using (emp_no)
    where title = 'Manager'
    and emp_no = any (
		select emp_no from employees join titles using (emp_no)
        where title <> 'Manager'
    );
select emp_no, first_name, last_name
	from employees join titles using (emp_no)
    where title = 'Manager'
    and emp_no IN (
		select emp_no from employees join titles using (emp_no)
        where title <> 'Manager'
    );



select mgr.emp_no, year(mgr.from_date) as fd
	from titles as mgr, titles as other
    where mgr.emp_no = other.emp_no
    and mgr.title = 'Manager'
    and mgr.title <> other.title
    and year(mgr.from_date) = year(other.from_date);
-- 동일 쿼리
select emp_no, year(from_date) as fd
	from titles where title = 'Manager'
    and (emp_no, year(from_date)) in (
		select emp_no, year(from_date)
        from titles where title <> 'Manager'
    );
    
-- exists, not exists
-- 상호연관 하위쿼리
use sakila;
select count(*) from film where exists (select * from rental);
select * from rental;
select count(*) from film;

select title from film
	where exists (
		select * from film
        where title = 'IS THIS A MOVIE?'
    );
select * from film
        where title = 'IS THIS A MOVIE?';    
        
        
-- 직원중에서 대여 기록이 있거나 고객인 직원 목록을 알고 싶다면?
select first_name, last_name from staff
	where exists (
		select * from customer
        where customer.first_name = staff.first_name
        and customer.last_name = staff.last_name
	);
insert into customer (store_id, first_name, last_name,
	email, address_id, create_date)
    values (1, 'Mike', 'Hillyer', 'Mike.Hillyer@sakilastaff.com',
    3, now());


-- 두 개이상이 있는 영화의 수
-- ==> 동일한 영화에 대한 행이 두개 이상있을때 출력하면 됩니다.
select count(*) from film
	where exists (
		select film_id from inventory
        where inventory.film_id = film.film_id
        group by film_id having count(*) >= 2
        );


-- employees DB 사용하여 Test
use employees;
select emp_no, first_name, last_name
	from employees join titles using (emp_no)
    where title = 'Manager'
    and emp_no in (
		select emp_no from employees
        join titles using (emp_no)
        where title <> 'Manager'
    );
-- 동일 결과 : exists 사용
select emp_no, first_name, last_name
	from employees join titles using (emp_no)
    where title = 'Manager'
    and exists (
		select emp_no from titles
        where titles.emp_no = employees.emp_no
        and title <> 'Manager'
    );

-- from 절에서의 중첩쿼리
select emp_no, monthly_salary from
	(select emp_no, salary/12 as monthly_salary from salaries) as ms;
-- from 절에 사용할 하위쿼리는 별칭을 다른곳에서 사용하지 않더라도 별칭을 만들어야 합니다.
-- 만들지 않으면 오류가 발생됩니다.


select emp_no, salary/12 as monthly_salary from salaries;

select * from salaries;


-- sakila db
use sakila;
select avg(gross) from (
		select sum(amount) as gross
        from payment join rental using (rental_id)
        join inventory using (inventory_id)
        join film using (film_id)
        group by film_id
	) as gross_amount;

select sum(amount) as gross
        from payment join rental using (rental_id)
        join inventory using (inventory_id)
        join film using (film_id)
        group by film_id;


-- join 에서의 중첩쿼리
select cat.name as category_name, cnt
	from category as cat 
    left join (
		select cat.name, count(cat.category_id) as cnt
		from category as cat left join film_category using (category_id)
		left join inventory using (film_id)
		left join rental using (inventory_id)
		join customer as cs on rental.customer_id = cs.customer_id
		where cs.email = 'WESLEY.BULL@sakilacustomer.org'
		group by cat.name
    ) as customer_cat using (name)
    order by cnt desc;
