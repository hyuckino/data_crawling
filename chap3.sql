-- mapdonalds DB 진입
USE mapdonalds;

-- burgers 테이블 생성
CREATE TABLE burgers (
	id INTEGER, 		-- 아이디(정수형 숫자)
	name VARCHAR(50),	-- 이름(문자: 최대 50자)
	price INTEGER, 		-- 가격(정수형 숫자)
	gram INTEGER, 		-- 그램(정수형 숫자)
	kcal INTEGER, 		-- 열량(정수형 숫자)
	protein INTEGER, 	-- 단백질량(정수형 숫자)
	PRIMARY KEY (id) 	-- 기본키 지정: id
);

-- burgers 데이터 삽입
INSERT INTO burgers (id, name, price, gram, kcal, protein)
VALUES
	(1, '빅맨', 5300, 223, 583, 27),
	(2, '베이컨 틈메이러 디럭스', 6200, 242, 545, 27),
	(3, '맨스파이시 상해 버거', 5300, 235, 494, 20),
	(4, '슈비두밥 버거', 6200, 269, 563, 21),
	(5, '더블 쿼터파운드 치즈', 7700, 275, 770, 50);

SELECT * FROM burgers;

SELECT * 
FROM burgers
WHERE price < 5500;

SELECT * 
FROM burgers
WHERE price > 5500;

SELECT * 
FROM burgers
WHERE protein < 25;

SELECT * 
FROM burgers
WHERE price < 5500 AND protein >25;

SELECT * 
FROM burgers
WHERE price < 5500 OR protein >25;

SELECT *
FROM burgers
WHERE NOT protein > 25 or price < 5500;

use mapdonalds;

select 100 + 20;

select 100 - 20;
select 100 * 20;

select 100/20

select 100 % 20

select 3 + 5 *2;

select (3+5)*2;

SELECT TRUE OR TRUE AND FALSE;

SELECT (TRUE OR TRUE) AND FALSE;

-- university DB 생성 및 진입
CREATE DATABASE university;
USE university;


CREATE DATABASE university;

-- students 테이블 생성
CREATE TABLE students (
	id INTEGER, 			-- 아이디
	nickname VARCHAR(50), 	-- 닉네임
	math INTEGER, 			-- 수학 성적
	english INTEGER, 		-- 영어 성적
	programming INTEGER, 	-- 프로그래밍 성적
	PRIMARY KEY (id) 		-- 기본키 지정: id
);
SELECT DATABASE();
-- students 데이터 삽입
INSERT INTO students (id, nickname, math, english, programming)
VALUES
	(1, 'Sparkles', 98, 96, 93),
	(2, 'Soldier', 82, 66, 98),
	(3, 'Lapooheart', 84, 70, 82),
	(4, 'Slick', 87, 99, 98),
	(5, 'Smile', 75, 73, 70),
	(6, 'Jellyboo', 84, 82, 70),
	(7, 'Bagel', 97, 91, 87),
	(8, 'Queen', 99, 100, 88);

SELECT *
FROM students;

SELECT *
FROM students
WHERE math>=90 AND english>=90 AND programming >=90;

SELECT *
FROM students
WHERE math < 75 OR english < 75 OR programming <75;

SELECT nickname, math, english, math + english + programming
FROM students;

SELECT nickname, math, english, (math + english + programming) /3
FROM students;

SELECT 
nickname,
(math + english + programming),
(math + english + programming) / 3
FROM students
WHERE (math + english + programming) >= 270;

SELECT 
nickname AS 닉네임,
(math + english + programming) AS 총점,
(math + english + programming) / 3 AS 평균
FROM students
WHERE (math + english + programming) >= 270;

use mapdonalds;

drop table students;
--self check 
select *
from burgers
where price >= 6000 and price <7000;

select * 
from burgers
where kcal < 500 or protein >= 25;

select name AS 버거이름, price/gram*100 as '100g당 가격'
from burgers;

select name AS 버거이름, 
price AS 가격,
gram AS '무게(g)',
price/gram*100 as '100g당 가격'
from burgers
WHERE price/gram*100 < 2500;

SELECT 
name AS 버거이름,
protein/price*1000 AS '1000원당 단백질량'
from burgers;

SELECT 
name AS 버거이름,
protein/price*1000 AS '1000원당 단백질량'
from burgers
WHERE protein/price*1000 >= 5;