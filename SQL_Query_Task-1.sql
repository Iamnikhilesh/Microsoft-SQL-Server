create database Task
use Task

create schema SubQuery;

-- Table 1
create Table SubQuery.Employees (
	EmpID int primary key,
	EmpName Varchar(50) not null,
	DepartmentID int,
	Salary decimal(10,2),
	ManagerID int,
	JoinDate date
);

-- Table 2
create table SubQuery.Departments(
	DepartmentID int primary key,
	DeptName Varchar(50),
	Location varchar(50)
);

-- Table 3
create table SubQuery.Products (
	ProductID int primary key,
	ProductName Varchar(50),
	CategoryID int,
	Price decimal(10,2),
	stock int
);

-- Table 4
create table SubQuery.Orders(
	OrderID int primary key,
	CustomerID int,
	OrderDate date,
	TotalAmount decimal(10,2)
);

--Table 5
create table SubQuery.Customers(
	CustomerID int,
	CustomerName Varchar(50),
	City varchar(50),
	Email Varchar(100)
);

-- Table 1: Employees (EmpID, EmpName, DepartmentID, Salary, ManagerID, JoinDate)
-- 1.	Retrieve names of employees who earn more than the average salary.
select EmpName,Salary from SubQuery.Employees 
where Salary > (select AVG(salary) from SubQuery.Employees);

-- 2.	List employees who joined after the employee with EmpName = 'John'.
select * from SubQuery.Employees 
where JoinDate > (select JoinDate from SubQuery.Employees where EmpName='John')

-- 3.	Find employees who work in the same department as 'Alice'.
select * from SubQuery.Employees
where DepartmentID = (select DepartmentID from SubQuery.Employees where EmpName = 'Alice');

-- 4.	Get employees whose salary is the maximum among all employees.
select * from SubQuery.Employees 
where Salary = (select Max(Salary) from SubQuery.Employees);

-- 5.	Display employee names who are managers (ManagerID present in EmpID).
select EmpName from SubQuery.Employees 
where EmpID in (select ManagerID from SubQuery.Employees where ManagerID is not null) 

-- 6.	List employees who are not managers.
select EmpName from SubQuery.Employees 
where EmpID not in (select ManagerID from SubQuery.Employees where ManagerID is not null)

-- 7.	Find employees whose salary is higher than all employees in DepartmentID 3.
select * from SubQuery.Employees
where Salary>(select Max(Salary) from SubQuery.Employees where DepartmentID =103)

-- 8.	Display employees whose department location is 'New York'. (Join with Departments)
select e.*,d.Location from SubQuery.Employees e
Join SubQuery.Departments d on e.DepartmentID=d.DepartmentID 
where e.DepartmentID in (select DepartmentID from SubQuery.Departments where Location = 'New York');

-- 9.	Get employees who have the same join date as their manager.
select EmpName,EmpID,ManagerID,JoinDate from SubQuery.Employees E
where JoinDate = (select * from SubQuery.Employees where EmpID=E.ManagerID)

-- 10.	Find employees whose salary is more than the average salary of their department.
select e.EmpName,e.Salary,e.DepartmentID from SubQuery.Employees e
where e.Salary > (select AVG(e2.salary) from SubQuery.Employees e2 where e2.DepartmentID=e.DepartmentID);


-- Table 2: Departments (DepartmentID, DeptName, Location)
-- 1.	Retrieve department names that have more than 2 employees.
select DeptName from SubQuery.Departments 
where DepartmentID in (select DepartmentID from SubQuery.Employees group by DepartmentID having count(*) > 2)

-- 2.	List departments that have no employees.
select DeptName,DepartmentID from SubQuery.Departments 
where DepartmentID not in (select DepartmentID from SubQuery.Employees)

-- 3.	Get the department with the highest number of employees.
select DeptName from SubQuery.Departments 
where DepartmentID in (select Top 5 DepartmentID from SubQuery.Employees group by DepartmentID order by count(*) desc)

-- 4.	Find departments located in the same city as any customer. (Join with Customers)
select d.DeptName,d.Location,c.CustomerName,c.City from SubQuery.Departments d join SubQuery.Customers c  on d.Location=c.City
where Location in (select distinct City from SubQuery.Customers group by City)

-- 5.	Get the department where the maximum salary is paid.
select DeptName,DepartmentID from SubQuery.Departments
where DepartmentID in 
(select top 5 DepartmentID from SubQuery.Employees group by DepartmentID order by max(salary) desc)

--6.	List departments that have employees earning above 1 lakh.
select DeptName from SubQuery.Departments
where DepartmentID in (select DepartmentID from SubQuery.Employees where Salary >= 100000)

--7.	Find departments where no one earns less than 30,000.
select DeptName from SubQuery.Departments 
where DepartmentID > (select DepartmentID from SubQuery.Employees where Salary < 30000)

--8.	Get departments that have at least one employee with JoinDate after 2020.
select DeptName,DepartmentID from SubQuery.Departments
where DepartmentID in (select DepartmentID  from SubQuery.Employees where JoinDate > '2020-01-01')

--9.	List department names having employees with the same manager.
select d.DeptName,d.DepartmentID	from SubQuery.Departments d 
									join SubQuery.Employees e on d.DepartmentID=e.DepartmentID
where ManagerID in (SELECT ManagerID FROM SubQuery.Employees
					GROUP BY ManagerID,DepartmentID HAVING COUNT(*) > 1)

--10.	Display departments which have all employees with salary > 40,000.
select DeptName from SubQuery.Departments 
where DepartmentID in (select DepartmentID from SubQuery.Employees where Salary >= 40000)


-- Table 3: Products (ProductID, ProductName, CategoryID, Price, Stock)
-- 1.	Retrieve products that are costlier than the average product price.
select * from SubQuery.Products
where price > (select AVG(price) from SubQuery.Products)

-- 2.	List products that have the same price as 'iPhone 14'.
select ProductName from SubQuery.Products 
where price = (select price from SubQuery.Products where ProductName='iPhone 14')

-- 3.	Get products with the highest price in each category.
select ProductName,CategoryID from SubQuery.Products 
where Price in (select max(price) from SubQuery.Products group by CategoryID)

-- 4.	Find products with stock less than the average stock.
select ProductName from SubQuery.Products 
where stock < (select avg(stock) from SubQuery.Products)

-- 5.	List products whose stock is 0 (Out of stock).
select ProductName from SubQuery.Products 
where stock in (select Min(stock) from SubQuery.Products) 

-- 6.	Get products which were never ordered (if linked to Orders).
SELECT p.ProductID, p.ProductName
FROM SubQuery.Products p 
LEFT JOIN SubQuery.Orders o ON p.ProductID = o.OrderID
WHERE o.OrderID IS NULL;

-- 7.	Display products whose price is more than any product in category 2.
select ProductName,Price from SubQuery.Products 
where Price > any(select Price from SubQuery.Products where CategoryID =2) 

-- 8.	List products with price greater than all products in stock < 10.
select ProductName,Price from SubQuery.Products 
where Price > all(select Price from SubQuery.Products where stock <10)

-- 9.	Retrieve the cheapest product in each category.
select ProductName,Price,CategoryID from SubQuery.Products 
where Price in (select Min(Price) from SubQuery.Products group by CategoryID)

-- 10.	Find products that belong to the same category as 'Samsung Galaxy'.
select ProductName from SubQuery.Products 
where CategoryID = (select CategoryID from SubQuery.Products where ProductName='Samsung Galaxy')


-- Table 4: Orders (OrderID, CustomerID, OrderDate, TotalAmount)
-- 1.	Get orders with amount greater than the average order amount.
select * from SubQuery.Orders
where TotalAmount > (select avg(TotalAmount) from SubQuery.Orders)

-- 2.	List customers who placed the highest value order.
select * from SubQuery.Orders
where TotalAmount in (select Max(TotalAmount) from SubQuery.Orders)

-- 3.	Find customers who have more than 3 orders.
select * from SubQuery.Orders
where CustomerID in (select CustomerID from SubQuery.Orders group by CustomerID having COUNT(*) >3)

-- 4.	Retrieve customers who placed orders in the last 30 days.
select CustomerName from SubQuery.Customers 
where CustomerID in (select CustomerID from SubQuery.Orders where OrderDate between '2023-07-01' and '2023-07-30')

-- 5.	Display orders with total amount more than any order placed by CustomerID 5.
select * from SubQuery.Orders 
where TotalAmount > ANY (select TotalAmount from SubQuery.Orders where CustomerID = 105)

-- 6.	Find customers who placed orders only in the month of January.
select CustomerName from SubQuery.Customers 
where CustomerID in (select CustomerID from SubQuery.Orders where OrderDate between '2023-01-01' and '2023-01-30')

-- 7.	Get customers who never placed any order.
select CustomerName from SubQuery.Customers 
where CustomerID not in (select CustomerID from SubQuery.Orders where OrderID is not null)

-- 8.	List the top 5 highest order amounts with customer names.
select CustomerName from SubQuery.Customers 
where CustomerID in (select top 5 CustomerID from SubQuery.Orders order by TotalAmount desc)

-- 9.	Find customers who placed multiple orders on the same day.
SELECT CustomerID FROM SubQuery.Orders
WHERE CustomerID IN (SELECT CustomerID FROM SubQuery.Orders
						GROUP BY CustomerID, OrderDate HAVING COUNT(*) > 1)

-- 10.	Get the latest order placed by each customer.
select * from SubQuery.Customers 
where CustomerID in (SELECT CustomerID FROM SubQuery.Orders o
					WHERE OrderDate = (SELECT MAX(OrderDate) FROM SubQuery.Orders o2 
										WHERE o2.CustomerID = o.CustomerID))


-- Table 5: Customers (CustomerID, CustomerName, City, Email)
-- 1.	List customers from cities where no department exists. (Subquery with Departments)
select * from SubQuery.Customers 
where City not in (select Location from SubQuery.Departments)

-- 2.	Get customers who have placed at least one order above ₹5000.
select * from SubQuery.Customers 
where CustomerID in (select CustomerID from SubQuery.Orders where TotalAmount > 5000)

-- 3.	Retrieve customers whose names are similar to other customers.
SELECT CustomerName, COUNT(*) AS count_of_customers
FROM SubQuery.Customers GROUP BY CustomerName
HAVING COUNT(*) > 1

-- 4.	Find customers who haven't placed any order yet.
select * from SubQuery.Customers 
where CustomerID not in (select CustomerID from SubQuery.Orders)

-- 5.	List customers who placed more than 5 orders in total.
select * from SubQuery.Customers 
where CustomerID in (select CustomerID from SubQuery.Orders group by CustomerID having count(*) > 5)

-- 6.	Display customer(s) who placed the earliest order.
select * from SubQuery.Customers 
where CustomerID in (select top 1 CustomerID from SubQuery.Orders order by OrderDate)

-- 7.	Find cities where all customers placed orders.
SELECT DISTINCT City FROM SubQuery.Customers 
WHERE City NOT IN(SELECT City FROM SubQuery.Customers 
					WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM SubQuery.Orders))

-- 8.	Get customers who placed orders in the same city where department exists.
select CustomerName,City from SubQuery.Customers c
where exists (select Location from SubQuery.Departments d where d.Location=c.City)

-- 9.	List customers who placed only one order.
select * from SubQuery.Customers 
where CustomerID in (select CustomerID from SubQuery.Orders group by CustomerID having count(*) = 1)

-- 10.	Find customers whose total order amount is greater than ₹10,000.
select * from SubQuery.Customers 
where CustomerID in (select CustomerID from SubQuery.Orders where TotalAmount > 10000)



