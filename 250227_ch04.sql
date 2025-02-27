-- 데이터 베이스 생성
-- 데이터베이스 이름 : lucy
create database lucy;
-- 데이터 베이스 제거
drop database lucy;

-- 데이터베이스 사용
use lucy;
-- 위 명령사용후에는 lucy db위에서 명령들이 실행됩니다.

-- 테이블 생성
create table actor (
	actor_id smallint unsigned not null default 0,
    first_name varchar(45) default null,
    last_name varchar(45),
    last_update timestamp,
    primary key (actor_id)
	);
show tables;

select * from actor;
insert into actor (actor_id) values (1);

show character set;


-- 테이블 삭제 : actor 테이블을 지웁시다.
drop table actor;

show tables;

create table actor (
	actor_id smallint unsigned not null auto_increment,
    first_name varchar(45) not null,
    last_name varchar(45) not null,
    last_update timestamp not null default current_timestamp
    on update current_timestamp,
    primary key (actor_id)
	);
show tables;
insert into actor (first_name, last_name)
	values (upper('hj'), upper('lee'));
select * from actor;
insert into actor (first_name, last_name)
	values ('현진', '이');