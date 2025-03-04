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

-- sample 데이터 입력
insert into board (title, content, writer, pw)
	values ('java', '자바를 배우는 시간입니다', '이현진', '1111');
insert into board (title, content, writer, pw)
	values ('mysql', '자바에 mysql을 연결합니다.', '이현진', '1111');

select * from board;

-- 리스트를 가져오는 쿼리
select no, title, writer, writeDate, hit
	from board order by no desc;
-- writeDate에 날짜만 출력하고 싶습니다.
select no, title, writer,
	date_format(writeDate, '%Y-%m-%d') as writeDate,
    hit
    from board order by no desc;
-- 글보기에 사용되는 쿼리
select no, title, content, writer,
	date_format(writeDate, '%Y-%m-%d') as writeDate,
    hit, pw
    from board where no = 1;
-- 조회수 증가
update board set hit = hit + 1 where no = 1;
-- 글쓰기
insert into board (title, content, writer, pw) 
	values ('자바', '자바+mysql', '이현진', '1111');
-- 글수정
update board set title='', content='', writer=''
	where no=1 and pw='1111';
-- 글삭제
delete from board where no=1 and pw='1111';

