use mapdonalds;
select *
from burgers;

SELECT MAX(price), MIN(price)
FROM burgers;

SELECT COUNT(*)
FROM burgers
WHERE gram > 240;

-- employees 테이블 생성
CREATE TABLE employees (
	id INTEGER, 				-- 아이디
	name VARCHAR(50), 			-- 직원명
	department VARCHAR(200), 		-- 소속 부서
	PRIMARY KEY (id) 			-- 기본키 지정: id
);

-- employees 데이터 삽입
INSERT INTO employees (id, name, department)
VALUES
	(1, 'Alice', 'Sales'),
	(2, 'Bob', 'Marketing'),
	(3, 'Carol', NULL),
	(4, 'Dave', 'Marketing'),
	(5, 'Joseph', 'Sales');

-- 모든 직원 수 세기
SELECT COUNT(*)
FROM employees;

-- 부서에 소속된 직원 수 세기
SELECT COUNT(department)
FROM employees;
 

SELECT SUM(price)
FROM burgers;

SELECT AVG(price)
FROM burgers;

CREATE DATABASE bank;
USE bank;

CREATE TABLE transactions (
    id INTEGER,
    amount DECIMAL(12,2),
    msg VARCHAR(15),
    created_at DATETIME,
    PRIMARY KEY (id)
);

-- transactions 데이터 삽입
INSERT INTO transactions (id, amount, msg, created_at)
VALUES
	(1, -24.20, 'Google', '2024-11-01 10:02:48'),
	(2, -36.30, 'Amazon', '2024-11-02 10:01:05'),
	(3, 557.13, 'Udemy', '2024-11-10 11:00:09'),
	(4, -684.04, 'Bank of America', '2024-11-15 17:30:16'),
	(5, 495.71, 'PayPal', '2024-11-26 10:30:20'),
	(6, 726.87, 'Google', '2024-11-26 10:31:04'),
	(7, 124.71, 'Amazon', '2024-11-26 10:32:02'),
	(8, -24.20, 'Google', '2024-12-01 10:00:21'),
	(9, -36.30, 'Amazon', '2024-12-02 10:03:43'),
	(10, 821.63, 'Udemy', '2024-12-10 11:01:19'),
	(11, -837.25, 'Bank of America', '2024-12-14 17:32:54'),
	(12, 695.96, 'PayPal', '2024-12-27 10:32:02'),
	(13, 947.20, 'Google', '2024-12-28 10:33:40'),
	(14, 231.97, 'Amazon', '2024-12-28 10:35:12'),
	(15, -24.20, 'Google', '2025-01-03 10:01:20'),
	(16, -36.30, 'Amazon', '2025-01-03 10:02:35'),
	(17, 1270.87, 'Udemy', '2025-01-10 11:03:55'),
	(18, -540.64, 'Bank of America', '2025-01-14 17:33:01'),
	(19, 732.33, 'PayPal', '2025-01-25 10:31:21'),
	(20, 1328.72, 'Google', '2025-01-26 10:32:45'),
	(21, 824.71, 'Amazon', '2025-01-27 10:33:01'),
	(22, 182.55, 'Coupang', '2025-01-27 10:33:25'),
	(23, -24.20, 'Google', '2025-02-03 10:02:23'),
	(24, -36.30, 'Amazon', '2025-02-03 10:02:34'),
	(25, -36.30, 'Notion', '2025-02-03 10:04:51'),
	(26, 1549.27, 'Udemy', '2025-02-14 11:00:01'),
	(27, -480.78, 'Bank of America', '2025-02-14 17:30:12');

SELECT SUM(amount)
FROM transactions
WHERE msg = 'Google';


SELECT MAX(amount), MIN(amount)
FROM transactions
WHERE msg = 'PayPal';


SELECT COUNT(*)
FROM transactions
WHERE msg = 'Coupang' OR msg ='Amazon';

SELECT COUNT(*)
FROM transactions
WHERE msg IN ('Coupang', 'Amazon');

SELECT AVG(amount)
FROM transactions
WHERE msg IN ('Google', 'Amazon') and amount>0;

SELECT DISTINCT msg
FROM transactions;

SELECT COUNT(DISTINCT msg)
FROM transactions;

create DATABASE company;
use company;

ALTer table employees
add primary key(id);

create table employees(
    id integer,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INTEGER,
    primary key(id)
);

INSERT into employees(
    id,name,department,salary
) VALUES
    (101, 'John', 'Sales', 7000),
	(102, 'Aria', 'IT', 5500),
	(103, 'Mike', 'Sales', 8000),
	(104, 'Lily', 'HR', 6500),
	(105, 'David', 'IT', 7200),
	(106, 'Emma', 'Sales', 6500),
	(107, 'Oliver', 'IT', 5900),
	(108, 'Sophia', 'HR', 6300),
	(109, 'Lucas', 'Sales', 5500),
	(110, 'Charlotte', 'HR', 6800);
    

select SUM(salary)
FROm employees;

select avg(salary)
from employees
WHERE department in ('sales')
;

SELECT  COUNT(DISTINCT department)
FROM employees;

SELECT max(salary)-min(salary) as '차이'
from employees
where department = 'Sales';

select max(salary)-avg(salary)
from employees;

