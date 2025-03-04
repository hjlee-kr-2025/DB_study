-- DML : 데이터 조작어
-- select : R
-- insert : C
-- update : U
-- delete : D

-- 데이터베이스 사용을 위해 이동 명령
-- 한줄실행을 [ctrl]+[Enter]
use world;
-- world 데이터베이스 안의 테이블확인
show tables;
-- world : city, country, countrylanguage
-- city table의 모든 데이터 확인
select * from city;
select * from country;
select * from countrylanguage;
-- 테이블의 구성확인
desc city;

-- 테이블의 데이터 추가
insert into city (name, countrycode, district)
	values ('SEOUL', 'KOR', '대한민국 수도');
select * from city order by id desc;

-- 수정
update city set district='세계의 중심', population='10000000'
	where id=4080;
select * from city order by id desc;

-- 삭제
delete from city where id=4080;
select * from city order by id desc;

-- shopdb 데이터베이스 생성
create database shopdb;
-- shopdb 데이터베이스 사용
use shopdb;
-- 일반게시판에 사용할 table을 생성
-- no, title, content, writer, writeDate, hit, pw
-- 테이블이름: board
create table board (
	no int not null auto_increment,
    title varchar(200) not null,
    content varchar(4000) not null,
    writer varchar(40) not null,
    writeDate datetime default now(),
    hit int default 0,
    pw varchar(20) not null,
    primary key(no)
);
select * from board;






