﻿create database Task
use Task

-- Section 1: Cats – Purr-fect SQL Exercises to Sharpen Your Claws
create table Cats(
	Id int primary key,
	Name varchar(30),
	Breed varchar(50),
	Coloration varchar(50),
	Age int,
	Sex varchar(1),
	FavToy varchar(100)
);

INSERT INTO Cats (Id,Name,Breed,Coloration,Age,Sex,FavToy)
VALUES	(1,'LUNA','RAGDOLL','CREAM',3,'F','BALL OF YARN'),
		(2,'MAX','SIAMESE','BLACK',7,'M','FEATHER STICK'),
		(3,'BELLA','RUSSIAN BLUE','PLATINUM',12,'F','LASER POINTER'),
		(4,'LEO','REX','BROWN',2,'M','BALL MOUSE'),
		(5,'DAISY','RAGDOLL','CREAM',11,'F','STRING BALL');

SELECT * FROM Cats

-- Exercise 1: Get to Know the Cat Table
-- Exercise: Select all data from the Cat table.
SELECT * FROM Cats

-- Exercise 2: Kittens
-- Exercise: Select the Name, Breed, and Coloration for every cat that is younger than five years old.
SELECT Name,Breed,Coloration FROM Cats WHERE Age < 5;

-- Exercise 3: Young and Old Ragdoll cats
-- Exercise: Select the ID and name for every cat that is either younger than five years old or older than ten years old and that is of the Ragdoll breed.
SELECT ID,Name FROM Cats WHERE Age < 5 OR Age > 10 AND Breed = 'RAGDOLL';

-- Exercise 4: Which Cats Like to Play with Balls?
-- Exercise: Select all data for cats whose: Breed starts with an 'R',Coloration ends with an 'm',Favorite toy starts with the word 'ball'.
SELECT * FROM Cats WHERE Breed LIKE 'R%' AND Coloration LIKE '%M'AND FavToy LIKE 'BALL%';


-- Section 2: Games – Level Up Your SQL Skills with Video Game Data
CREATE TABLE GAMES (
	ID INT PRIMARY KEY ,
	TITLE VARCHAR(100),
	COMPANY VARCHAR(50),
	TYPE VARCHAR(50),
	PRODUCTIONYEAR INT,
	SYSTEM VARCHAR(50),
	PRODUCTIONCOST INT,
	REVENUE INT,
	RATING DECIMAL(2,1)
);

INSERT INTO GAMES (ID,TITLE,COMPANY,TYPE,PRODUCTIONYEAR,SYSTEM,PRODUCTIONCOST,REVENUE,RATING)
VALUES	(1,'MARIO KART','NINTENDO','RACING',2024,'WII',300.00,30000.00,8.9),
		(2,'HALO','MICROSOFT','SHOOTER',2007,'XBOX',400.00,46000.00,9.2),
		(3,'TETRIS','EA','PUZZLE',1999,'NINTENDO',50.00,10000.00,7.5),
		(4,'GOD OF WAR','SONY','ACTION',2018,'PS4',500.00,80000.00,9.5),
		(5,'SONIC MANIA','SEGA','PLATFORM',2017,'SWITCH',150.00,2000000.00,8.2);

SELECT * FROM GAMES

-- Exercise 5: Average Production Costs for Good Games
-- Exercise: Show the average production cost of games that were produced between 2010 and 2015 and were rated higher than 7.
SELECT AVG(PRODUCTIONCOST) FROM GAMES WHERE PRODUCTIONYEAR BETWEEN 2010 AND 2015 AND RATING > 7;

-- Exercise 6: Game Production Statistics by Year
-- Exercise: For all games, display how many games were released each year (as the count column), the average cost of production (as the AvgCost column), and their average revenue (as the AvgRevenue column).
SELECT PRODUCTIONYEAR,COUNT(*) AS COUNT,AVG(PRODUCTIONCOST) AS COST_OF_PRODUCTION,AVG(REVENUE) AS AvgRevenue 
FROM GAMES GROUP BY PRODUCTIONYEAR;

-- Exercise 7: Company Production Statistics
-- Exercise: For each company, select its name, the number of games it produced (as the NumberOfGames column), the average cost of production (as the AvgCost column). Note: Show only the companies that produced more than one game.
SELECT COMPANY,AVG(PRODUCTIONCOST) AS AvgCost FROM GAMES GROUP BY COMPANY HAVING COUNT(*)>1;

-- Exercise 8: Identify Good Games
-- Exercise: We're interested in good games produced between 2000 and 2009. A good game is a game that has a rating higher than 6 and was profitable (earned more than its production costs).
SELECT * FROM GAMES WHERE PRODUCTIONYEAR BETWEEN 2000 AND 2009 AND RATING > 6 AND PRODUCTIONCOST < REVENUE; 

-- Exercise 9: Gross Profit by Company
-- Exercise: For all companies present in the table, show their name and the sum of gross profit over all years. To simplify this problem, assume that the gross profit is Revenue - ProductionCost; show this column as GrossProfitSum.
SELECT COMPANY,SUM(REVENUE-PRODUCTIONCOST) AS GrossProfitSum FROM GAMES group by COMPANY;

-- Section 3: The Art of the JOIN
CREATE TABLE Artist(
	Id int primary key,
	Name varchar(30),
	BirthYear int,
	DeathYear int,
	ArtisticField varchar(50)
);

INSERT INTO Artist (Id,Name,BirthYear,DeathYear,ArtisticField)
VALUES	(1,'Leonardo','1452','1519','Invention'),
		(2,'Van','1853','1899','Painting'),
		(3,'Picasso','1881','1973','Sculpture'),
		(4,'Frida','1907','1954','Folk Art'),
		(5,'Mike','1475','1564','Architecture');

CREATE TABLE Museum (
	Id int primary key,
	Name varchar(50),
	country varchar(50)
);

INSERT INTO Museum (Id,Name,country)
VALUES	(1,'Greate','Spain'),
		(2,'Fetcher','Rome'),
		(3,'Enove','Italy'),
		(4,'Nova','Japan'),
		(5,'Louvre','France');

CREATE TABLE PieceOfArt(
	Id int primary key,
	Name varchar(50),
	ArtistID int foreign key (ArtistId) references Artist(Id),
	MuseumId int foreign key (MuseumId) references Museum(Id)
);

INSERT INTO PieceOfArt(Id,Name,ArtistID,MuseumId)
VALUES	(1,'Simle',1,1),
		(2,'Night',2,2),
		(3,'Twins',3,3),
		(4,'Sky',4,4),
		(5,'Waterfall',5,5);

SELECT * FROM Artist
SELECT * FROM Museum 
SELECT * FROM PieceOfArt 

-- Exercise 10: List All Pieces of Art
-- Exercise: Show the names of all pieces of art, together with the names of their creators and the names of the museums that house the art.
select p.Name as PiecesOfArt,a.Name as Creator,m.Name as Museums
  from Artist A join PieceOfArt P on A.Id=P.Id 
				join Museum M on P.Id =M.Id;	

-- Exercise 11: Works from 19th-Century Artists (and Later)
-- Exercise: Find artists who lived more than 50 years and were born after the year 1800. Show their  name and the name of the pieces of art they created. Rename these columns ArtistName and PieceName, respectively.

select A.Name as ArtistName,P.Name as PieceName
from Artist A join PieceOfArt P on A.Id=P.ArtistID 
where A.BirthYear > 1800 and (A.DeathYear - A.BirthYear) > 50;

-- Exercise 12: Artists' Productivity
-- Exercise: Show the names of artists together with the number of years they lived (name the column YearsLived) and the number of pieces they created (name the column NumberOfCreated).
select A.Name ,(A.DeathYear-A.BirthYear) as YearsLived, count(p.Id) as NumberOfCreated
from Artist A join PieceOfArt P on A.Id=P.ArtistID
group by A.Name,A.BirthYear,A.DeathYear;

-- Section 4: A Cart Load of Data
create table categories(
	Id int primary key,
	Name varchar(50)
);

INSERT INTO Categories (Id, Name) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Clothing');

create table products(
	Id int primary key,
	Name varchar(50),
	CategoryId int ,
	foreign key (CategoryId) references categories(Id),
	price decimal(10,2)
);

INSERT INTO Products (Id, Name, CategoryId, Price) VALUES
(1, 'Smartphone', 1, 500),
(2, 'Laptop', 1, 1000),
(3, 'Novel', 2, 30),
(4, 'T-Shirt', 3, 20),
(5, 'Notebook', 2, 10);

create table clients(
	Id int primary key,
	FirstName varchar(30),
	LastName varchar(30)
);

INSERT INTO Clients (Id, FirstName, LastName) VALUES
(1, 'Alice', 'Brown'),
(2, 'Bob', 'Smith'),
(3, 'Charlie', 'Davis');

create table orders(
	Id int primary key,
	ClientId int,
	foreign key (ClientId) references clients(Id),
	Year int
);

INSERT INTO Orders (Id, ClientId, Year) VALUES
(1, 1, 2023),
(2, 1, 2024),
(3, 2, 2024),
(4, 3, 2024);

create table orderitems(
	OrderId int,
	ProductId int,
	Quantity int,
	Price decimal(10,2),
	primary key (OrderId,ProductId),
	foreign key (OrderId) references orders(Id),
	foreign key(ProductId) references products(Id)
);

INSERT INTO OrderItems (OrderId, ProductId, Quantity, Price) VALUES
(1, 1, 1, 500),
(1, 3, 2, 60),
(2, 3, 1, 30),
(3, 2, 1, 1000),
(3, 4, 3, 60),
(4, 5, 2, 20),
(4, 3, 1, 30);

SELECT * FROM Categories
SELECT * FROM Products
SELECT * FROM Clients
SELECT * FROM Orders
SELECT * FROM OrderItems

-- Exercise 13: Revenue for each order
-- Exercise: For each order, select its ID (name the column OrderId), the first and last name of the client who placed this order, and the total revenue generated by this order (name the column Revenue).
-- Note: The revenue for the order is the sum of the Price column for each item in the order.
select o.Id as OrderId,c.FirstName,c.LastName, SUM(p.price) as Revenue 
from clients c join orders o on c.Id=o.Id
			join products p on c.Id=p.Id
group by o.Id,c.FirstName,c.LastName;

-- Exercise 14: Who Repurchased Products?
-- Exercise: Select the first name and last name of the clients who repurchased products (i.e., bought the same product in more than one order). Include the names of those products and the number of the orders they were part of (name the column OrderCount).
select c.FirstName,c.LastName,p.Name,COUNT(distinct oi.OrderId)AS countOrder
from clients c join orders o on c.Id=o.ClientId
				join orderitems oi on o.Id=oi.OrderId
				join products p on oi.ProductId=p.Id
group by p.Name,c.FirstName,c.LastName
having COUNT(distinct oi.OrderId) > 1 

-- Exercise 15: How Much Did Each Client Spend per Category?
-- Exercise: Select the first and last name of each client, the name of the category they purchased from (in any of their orders), and the total amount of money they spent on this product category (name this column TotalAmount).
select c.FirstName,c.LastName,ca.Name,SUM(oi.price) as TotalAmount
from clients c join orders o on c.Id=o.ClientId
			join orderitems oi on o.Id=oi.OrderId
			join products p on oi.ProductId=p.Id
			join categories ca on p.CategoryId=ca.Id
group by c.FirstName,c.LastName,ca.Name

				
