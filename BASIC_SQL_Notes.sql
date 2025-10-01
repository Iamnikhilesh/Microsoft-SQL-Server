-- Database creation
Create database DemoDB;
use DemoDB;

--table creation
create table employee(
	ID int,
	EmpName varchar(255),
	City varchar(255),
	Salary int
);

--Values insertion
insert into employee(ID,EmpName,City,Salary)
values(1,'Tom','ABC',7000);

select * from employee;

insert into employee(ID,EmpName,City,Salary)
values(2,'Emma','PQR',8000);

-- mulitple values insertion
insert into employee(ID,EmpName,City,Salary)
values	(3,'Jeni','ZYW',5000),
		(4,'David','FGH',7500),
		(5,'Henry','PQR',9500),
		(6,'Will','ABC',6700);

select * from employee;

-- Use of Select clause
select ID,EmpName from employee;

select distinct City from employee;

-- Use of Where Clause
select * 
from employee 
where Salary=8000;

select * 
from employee 
where EmpName='Jeni';

select * 
from employee 
where Salary >= 7000;

-- Use of Order by Clause
select * from employee 
order by Salary;

select * from employee 
order by Salary DESC;

select * from employee 
order by City, Salary;

--Use of Operators
--Use of AND Operators
select * from employee
where City='ABC' AND Salary=7000;

select * from employee
where City='ABC' AND Salary< 7000;

--Use of OR Operators
select * from employee
where EmpName='Jeni' OR EmpName='Henry';

select * from employee
where EmpName='Jeni' OR EmpName='Steve';

--Use of NOT Operators
select * from employee
where NOT Salary=8000;

--Use of IN Operators
select * from employee
where City IN('ZYW','FGH');

select * from employee
where EmpName IN('Emma','Henry','Will');

--Use of NOT IN Operators
select * from employee
where EmpName NOT IN('Emma','Henry','Will');

--Use of BETWEEN Operators
select * from employee
where Salary BETWEEN 7000 AND 9000;

select * from employee
where Salary NOT BETWEEN 7000 AND 9000;

select * from employee
where EmpName BETWEEN 'David' AND 'Jeni'
ORDER BY EmpName;

--Use of LIKE Operators
select * from employee
where City LIKE 'A%';

select * from employee
where EmpName LIKE '%i';

select * from employee
where EmpName LIKE '_e%';

select * from employee
where EmpName NOT LIKE 'E%';

--Use of MAX() Function
select max(Salary) AS Result from employee;

--Use of MIN() Function
select min(Salary) AS Result from employee;

--Use of SUM() Function
select SUM(Salary) AS Result from employee;

select SUM(Salary) AS Result from employee 
where Salary>=7000;

--Use of AVG() Function
select AVG(Salary) AS Result from employee;

select AVG(Salary) AS Result from employee
where Salary > 6000;

--Use of COUNT() Function
select COUNT(EmpName) from employee;

select COUNT(EmpName) from employee
where Salary > 7000;

select COUNT(*) from employee;

--Use of Constraint
--Use of NOT NULL Constraint
create table Employees(
	ID int NOT NULL,
	EmpName varchar(255) NOT NULL,
	City varchar(255),
	Salary int
);

insert into Employees(ID,EmpName,City,Salary)
values(1,'Tom','ABC',7000);

insert into Employees(ID,EmpName,City,Salary)
values(2,'Emma','PQR',8000);

select * from Employees;
Drop table Employees;

--Use of UNIQUE Constraint
create table Employees(
	ID int NOT NULL UNIQUE,
	EmpName varchar(255) NOT NULL,
	City varchar(255),
	Salary int
);

insert into Employees(ID,EmpName,City,Salary)
values(1,'Tom','ABC',7000);

insert into Employees(ID,EmpName,City,Salary)
values	(2,'Emma','XYZ',5000),
		(3,'Jack','PQR',6000),
		(4,'David','AQR',8500);

insert into Employees(ID,EmpName,City,Salary)
values(5,'Gary','QUH',7200);

select * from Employees;
Drop table Employees;

--Use of PRIMARY KEY Constraint
create table Employees(
	ID int NOT NULL PRIMARY KEY,
	EmpName varchar(255) NOT NULL,
	City varchar(255),
	Salary int
);

insert into Employees(ID,EmpName,City,Salary)
values(1,'Tom','ABC',7000);

insert into Employees(ID,EmpName,City,Salary)
values	(2,'Emma','XYZ',5000);

select * from Employees;
Drop table Employees;

--Use of FOREIGN KEY Constraint
create table Employees(
EmpID int NOT NULL PRIMARY KEY,
EmpName varchar(255) NOT NULL,
EmpCity varchar(255),
EmpSalary int
)

create table Department (
DeptID int NOT NULL PRIMARY KEY,
DeptName varchar(255) NOT NULL,
EmpID int FOREIGN KEY REFERENCES Employees(EmpID)
);

--Use of CHECK Constraint
create table Employees(
ID int NOT NULL PRIMARY KEY,
EmpName varchar(255) NOT NULL,
City varchar(255),
Salary int CHECK (Salary < 10000)
)

insert into Employees(ID,EmpName,City,Salary)
values(1,'Tom','ABC',7000);

insert into Employees(ID,EmpName,City,Salary)
values	(2,'Emma','XYZ',8000);

select * from Employees;

insert into Employees(ID,EmpName,City,Salary)
values	(3,'Will','ASD',11000);

--Use of ASC Command
select * from employee
ORDER BY Salary ASC;

select * from employee
ORDER BY EmpName ASC;

--Use of DESC Command
select * from employee
ORDER BY Salary DESC;

select * from employee
ORDER BY EmpName DESC;

--Use of ALTER Table Statement
select * from employee;

alter table employee
ADD Age int;

alter table employee
DROP COLUMN Age;

--Use of UPDATE Table Statement
select * from employee;

-- FOR single row records
UPDATE employee
SET Salary = '9500'
WHERE ID =4;

-- FOR Multiple row records
UPDATE employee
SET EmpName='Brad',City='JKL'
WHERE ID =1;

--SQL Aliases
select EmpName as MyResult from employee;

--JOINS
CREATE TABLE MYEMPLOYEE (EMPLOYEEID INT, FIRSTNAME VARCHAR(20), LASTNAME VARCHAR(20))

INSERT INTO MYEMPLOYEE VALUES(1, 'JOHN', 'DEO')
INSERT INTO MYEMPLOYEE VALUES(2, 'BLAKE', 'LEO')
INSERT INTO MYEMPLOYEE VALUES(3, 'TIGER', 'DAS')

SELECT * FROM MYEMPLOYEE

CREATE TABLE MYSALARY (EMPLOYEEID INT, SALARY FLOAT)

INSERT INTO MYSALARY VALUES(1, 1000)
INSERT INTO MYSALARY VALUES(2, 8000)
INSERT INTO MYSALARY VALUES(3, 6000)
SELECT * FROM MYSALARY

-- INNER JOINS 
SELECT * FROM MYEMPLOYEE
SELECT * FROM MYSALARY

SELECT A.FIRSTNAME, A.LASTNAME,B.SALARY
FROM MYEMPLOYEE A INNER  JOIN MYSALARY B ON A.EMPLOYEEID=B.EMPLOYEEID

--LEFT OUTER JOINS
CREATE TABLE MYPHONE(EMPLOYEEID INT, PHONENUMBER INT)

INSERT INTO MYPHONE VALUES(1,1234567890)
INSERT INTO MYPHONE VALUES(3,756846812)

SELECT * FROM MYPHONE
SELECT * FROM MYEMPLOYEE

SELECT A.FIRSTNAME, A.LASTNAME, B.PHONENUMBER FROM MYEMPLOYEE A LEFT JOIN MYPHONE B
ON A.EMPLOYEEID=B.EMPLOYEEID

-- RIGHT JOINS
CREATE TABLE MYPARKING(EMPLOYEEID INT, PARKINGSPOT VARCHAR(20))

INSERT INTO MYPARKING VALUES (1,'A1')
INSERT INTO MYPARKING VALUES (2,'A2')

SELECT *FROM MYPARKING
SELECT * FROM MYEMPLOYEE

SELECT A.PARKINGSPOT, B.FIRSTNAME,B.LASTNAME
FROM MYPARKING A RIGHT JOIN MYEMPLOYEE B ON A.EMPLOYEEID=B.EMPLOYEEID

--FULL OUTER JOIN
CREATE TABLE MYCUSTOMER(CUSTOMERID INT, CUSTOMERNAME VARCHAR(20))

TRUNCATE TABLE MYCUSTOMER
INSERT INTO MYCUSTOMER VALUES (1,'RAKESH')
INSERT INTO MYCUSTOMER VALUES (3,'PAM')

CREATE TABLE MYORDER(OREDERNUMBER INT, ORDERNAME VARCHAR(20), CUSTOMERID INT)

INSERT INTO MYORDER VALUES (1,'SOMEORDER1',1)
INSERT INTO MYORDER VALUES (2,'SOMEORDER2',2)
INSERT INTO MYORDER VALUES (3,'SOMEORDER3',7)
INSERT INTO MYORDER VALUES (4,'SOMEORDER4',8)

SELECT * FROM MYCUSTOMER
SELECT * FROM MYORDER

SELECT A.CUSTOMERID, A.CUSTOMERNAME, B.OREDERNUMBER,B.ORDERNAME 
FROM MYCUSTOMER A FULL OUTER JOIN MYORDER B
ON A.CUSTOMERID= B.CUSTOMERID

--CROSS JOINS
SELECT * FROM MYCUSTOMER
SELECT * FROM MYSALARY

--SELECT * FROM MYCUSTOMER CROSS JOIN MYSALARY
SELECT * FROM MYCUSTOMER ,MYSALARY

-- DATES 
SELECT GETDATE()

SELECT GETDATE()-2

--- DATEPART
SELECT DATEPART(YYYY, GETDATE()) AS YEARNUMBER

SELECT DATEPART(MM, GETDATE()) 
SELECT DATEPART(DD, GETDATE()) 

-- DATAADD Syntax
SELECT DATEADD(DD, -(DATEPART(DAY, GETDATE()) -1),GETDATE())

--DATEADD
SELECT DATEADD(DAY,4, GETDATE())
SELECT DATEADD(DAY,4, '7/4/2015')

SELECT DATEADD(MONTH,4, GETDATE())
SELECT DATEADD(YEAR,4, GETDATE())

--  DATEDIFF
SELECT TOP 10 * FROM [SalesLT].[Product]
SELECT SIZE,Weight,SellStartDate,SellEndDate, DATEDIFF(DAY, SellStartDate, SellEndDate)
FROM [SalesLT].[Product]

-- MYSALARY
-- AGGRGATE FUCNTIONS
SELECT * FROM MYSALARY
SELECT AVG(SALARY) FROM MYSALARY
SELECT COUNT(SALARY) FROM MYSALARY
SELECT COUNT(*) FROM MYSALARY

SELECT * FROM MYSALARY
SELECT SUM(SALARY) FROM MYSALARY
SELECT MIN(SALARY) FROM MYSALARY
SELECT MAX(SALARY) FROM MYSALARY

-- MYORDER
SELECT *FROM MYORDER

--CONCAT
PRINT CONCAT('STRING1', 'STRING2')

SELECT OREDERNUMBER,ORDERNAME, CONCAT(ORDERNAME, ' ', ORDERNAME) AS CONCARENATEDTEXT
FROM MYORDER

SELECT OREDERNUMBER,ORDERNAME, CONCAT(ORDERNAME, ' ', RAND()) AS CONCARENATEDTEXT
FROM MYORDER

-- LEFT 
SELECT OREDERNUMBER,ORDERNAME, LEFT(ORDERNAME,5) FROM MYORDER

-- RIGHT 
SELECT OREDERNUMBER,ORDERNAME, RIGHT(ORDERNAME,5) FROM MYORDER

-- SUBSTRING
SELECT OREDERNUMBER,ORDERNAME, SUBSTRING(ORDERNAME,2,5) FROM MYORDER

-- LOWERCASE
SELECT OREDERNUMBER,ORDERNAME, LOWER(ORDERNAME) FROM MYORDER

-- UPPERCASE
SELECT OREDERNUMBER,ORDERNAME, UPPER(ORDERNAME) FROM MYORDER

-- LENGTH
SELECT OREDERNUMBER,ORDERNAME, LEN(ORDERNAME) FROM MYORDER

-- CAPTILIZE
SELECT OREDERNUMBER,ORDERNAME, CONCAT(UPPER(LEFT(ORDERNAME,1)), LOWER(SUBSTRING(ORDERNAME,2,LEN(ORDERNAME)))) FROM MYORDER

-- TRIM
SELECT ' MYTEXT   '
SELECT LEN('          MYTEXT       ')

-- LTRIM
SELECT LTRIM('          MYTEXT       ')

-- RTRIM
SELECT RTRIM('          MYTEXT       ')

-- Use of LTRIM and RTRIM
SELECT LTRIM(RTRIM('          MYTEXT       '))

--SQL STORED PROCEDURES
select * from employee;

create procedure AllRecords
AS
select * from employee
GO;

exec AllRecords;

-- With one parameter
-- Correct Procedure Creation
CREATE PROCEDURE AllRecords2 @City VARCHAR(225)
AS
SELECT * FROM employee WHERE City = @City;

EXEC AllRecords2 @City = 'ABC';

-- With Muilt parameter
create procedure AllRecords3 @City varchar(225),@EmpName varchar(255)
AS
select * from employee where City=@City AND EmpName=@EmpName;

exec AllRecords3 @City = 'ABC', @EmpName = 'Will'

--create indexs statements
select * from employee;

CREATE INDEX MyIndex
on employee(EmpName);

CREATE INDEX MyIndex2
on employee(EmpName, Salary);

DROP INDEX employee.MyIndex2;

--select into statement
select * from employee;

select * into EmpBackup2022 
from employee;

select * from EmpBackup2022

select EmpName,Salary into MyBackup
from employee;

select * from MyBackup

--select top clause
select top 2 * from employee;

select top 50 percent * from employee;

select top 75 percent * from employee;

select top 25 percent * from employee
where Salary>7000;

--Backup a database in sql
backup database DemoDB
to disk='D:\001_code_playground\mybackup.bak';

--views
select * from employee;

create view [Employees ABC] AS 
select EmpName, City from employee
where City='ABC';

select * from [Employees ABC];

create view [Salary ABOVE 7000] AS 
select EmpName, City, Salary from employee
where Salary > 7000;

select * from [Salary ABOVE 7000];

DROP VIEW [Employees ABC];

--DROP TABLE in SQL server
select * from employee;

DROP table employee;