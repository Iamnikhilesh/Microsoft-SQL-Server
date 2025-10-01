create database Task
use Task

-- Create Sales table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT FOREIGN KEY REFERENCES Products(product_id),
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10,2)
);

-- Insert values into Sales
INSERT INTO Sales (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);
-- Create Products table

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

-- Insert values into Products
INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphone', 'Electronics', 30.00),
(104, 'Keyboard', 'Electronics', 20.00),
(105, 'Mouse', 'Electronics', 15.00);

select * from Sales;
select * from Products;

-- 1. Retrieve all columns from the Sales table. 
select * from Sales;

-- 2. Retrieve the product_name and unit_price from the Products table. 
select product_name,unit_price from Products;

-- 3. Retrieve the sale_id and sale_date from the Sales table. 
select sale_id,sale_date from Sales;

-- 4. Filter the Sales table to show only sales with a total_price greater than $100. 
select * from Sales where total_price > 100;

-- 5. Filter the Products table to show only products in the 'Electronics' category. 
select product_name,category from Products where category = 'Electronics';

-- 6. Retrieve the sale_id and total_price from the Sales table for sales made on January 3, 2024. 
select sale_id,total_price from Sales where sale_date = '2024-01-03';

-- 7. Retrieve the product_id and product_name from the Products table for products with a unit_price greater than $100. 
select product_id,product_name from Products where unit_price >100;

-- 8. Calculate the total revenue generated from all sales in the Sales table. 
select sum(total_price) as total_revenue from Sales;

-- 9. Calculate the average unit_price of products in the Products table. 
select AVG(unit_price) from Products;

-- 10. Calculate the total quantity_sold from the Sales table.
select SUM(quantity_sold) as total_quantity_sold from Sales;

-- 11. Count Sales Per Day from the Sales table 
select sale_date,count(*) as sales_per_day from Sales group by sale_date;

-- 12. Retrieve product_name and unit_price from the Products table with the Highest Unit Price 
select top 1 product_name,unit_price from Products order by unit_price desc;

-- 13. Retrieve the sale_id, product_id, and total_price from the Sales table for sales with a quantity_sold greater than 4. 
select sale_id,product_id,total_price from Sales where quantity_sold>4;

-- 14. Retrieve the product_name and unit_price from the Products table, ordering the results by unit_price in descending order. 
select product_name,unit_price from Products order by unit_price desc;

-- 15. Retrieve the total_price of all sales, rounding the values to two decimal places. 
select sale_id,Round(total_price,2) from Sales;

-- 16. Calculate the average total_price of sales in the Sales table. 
select AVG(total_price) from Sales;

-- 17. Retrieve the sale_id and sale_date from the Sales table, formatting the sale_date as 'YYYY-MM-DD'. 
select sale_id,sale_date,FORMAT(sale_date,'yyyy-MM-dd') as formatted_date from Sales;

-- 18. Calculate the total revenue generated from sales of products in the 'Electronics' category. 
select SUM(quantity_sold*unit_price) as total_revenue from Sales,Products where category like 'Electronics';

-- 19. Retrieve the product_name and unit_price from the Products table, filtering the unit_price to show only values between $20 and $600. 
select product_name,unit_price from Products where unit_price between 20 and 600;

-- 20. Retrieve the product_name and category from the Products table, ordering the results by category in ascending order. 
select product_name,category from Products order by category asc;

-- 1. Calculate the total quantity_sold of products in the 'Electronics' category. 
select sum(s.quantity_sold) as total_quantity_sold
from Sales s full join Products p on s.product_id=p.product_id where category like 'Electronics';

-- 2. Retrieve the product_name and total_price from the Sales table, calculating the total_price as quantity_sold multiplied by unit_price. 
select p.product_name,s.quantity_sold *unit_price as calculated_total_price
from Sales s full join Products p on s.product_id =p.product_id ;

-- 3. Identify the Most Frequently Sold Product from Sales table 
select product_id,sum(quantity_sold) as frequently_sold from Sales group by product_id order by frequently_sold desc;

-- 4. Find the Products Not Sold from Products table 
select p.product_id,p.product_name from Products p left join Sales s on p.product_id=s.product_id where s.product_id is null;

-- 5. Calculate the total revenue generated from sales for each product category. 
select SUM(Sales.total_price) as total_revenue from Sales 
join Products on Sales.product_id=Products.product_id group by category;

-- 6. Find the product category with the highest average unit price. 
select top 1 avg(unit_price) as avg_unit_price from Products group by category order by avg_unit_price;

-- 7. Identify products with total sales exceeding 30. 
SELECT P.product_id, P.product_name, SUM(S.quantity_sold) FROM Sales S
JOIN Products P ON S.product_id = P.product_id
GROUP BY P.product_id, P.product_name
HAVING SUM(S.quantity_sold) > 30;

-- 8. Count the number of sales made in each month. 
SELECT FORMAT(sale_date, 'yyyy-MM') AS sale_month, COUNT(*) AS sale_count
FROM Sales GROUP BY FORMAT(sale_date, 'yyyy-MM');

-- 9. Retrieve Sales Details for Products with 'Smart' in Their Name 
SELECT S.* FROM Sales S
JOIN Products P ON S.product_id = P.product_id
WHERE P.product_name LIKE '%Smart%';

-- 10. Determine the average quantity sold for products with a unit price greater than $100. 
select avg(s.quantity_sold) from Sales s join Products p on p.product_id=s.product_id where p.unit_price>100

-- 11. Retrieve the product name and total sales revenue for each product. 
SELECT P.product_name, SUM(S.total_price) AS total_revenue 
FROM Sales S JOIN Products P ON S.product_id = P.product_id
GROUP BY P.product_name;

-- 12. List all sales along with the corresponding product names. 
select s.*,p.product_name from Sales s join Products p on s.product_id=p.product_id;

-- 13. Retrieve the product name and total sales revenue for each product. 
SELECT P.product_name, SUM(S.total_price) AS total_revenue 
FROM Sales S JOIN Products P ON S.product_id = P.product_id
GROUP BY P.product_name;

-- 14. Rank products based on total sales revenue. 
SELECT P.product_name, SUM(S.total_price) AS total_revenue,
rank() over(order by SUM(S.total_price) desc)rank_revenue
FROM Sales S JOIN Products P ON S.product_id = P.product_id
GROUP BY P.product_name;

-- 15. Calculate the running total revenue for each product category. 
SELECT p.category,
       SUM(s.total_price) OVER (PARTITION BY p.category ORDER BY s.sale_date) AS running_total_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
ORDER BY p.category, s.sale_date;

-- 16. Categorize sales as "High", "Medium", or "Low" based on total price (e.g., > $200 is High, $100-$200 is Medium, < $100 is Low). 
select *, 
case 
	when total_price > 200 then 'high'
	when total_price  between 100 and 200 then 'medium'
	else 'low'
	end as sale_category
from Sales;

-- 17. Identify sales where the quantity sold is greater than the average quantity sold. 
select * from Sales where quantity_sold > (select AVG(quantity_sold) from Sales);

-- 18. Extract the month and year from the sale date and count the number of sales for each month. 
SELECT FORMAT(sale_date, 'yyyy-MM') AS sale_month, 
       COUNT(*) AS sales_count
FROM Sales
GROUP BY FORMAT(sale_date, 'yyyy-MM')
ORDER BY sale_month;

-- 19. Calculate the number of days between the current date and the sale date for each sale. 
select *,DATEDIFF(day,sale_date,GETDATE()) as days_difference from Sales;

-- 20. Identify sales made during weekdays versus weekends.
SELECT sale_id, 
       sale_date, 
       CASE 
           WHEN DATENAME(WEEKDAY, sale_date) IN ('Saturday', 'Sunday') THEN 'Weekend'
           ELSE 'Weekday'
       END AS sale_day_type
FROM Sales;

-- 1. List the Top 3 Products by Revenue Contribution Percentage 
WITH ProductRevenue AS (
    SELECT p.product_name, SUM(s.quantity_sold * p.unit_price) AS total_revenue
    FROM Sales s
    JOIN Products p ON s.product_id = p.product_id
    GROUP BY p.product_name
)
SELECT product_name, 
       total_revenue,
       (total_revenue / (SELECT SUM(quantity_sold * unit_price) FROM Sales s JOIN Products p ON s.product_id = p.product_id)) * 100 AS revenue_percentage
FROM ProductRevenue
ORDER BY revenue_percentage DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

-- 2. Write a query to create a view named Total_Sales that displays the total sales amount for each product along with their names and categories. 
CREATE VIEW Total_Sales AS
SELECT p.product_name, p.category, SUM(s.quantity_sold * p.unit_price) AS total_sales
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name, p.category;
SELECT * FROM Total_Sales;

-- 3. Retrieve the product details (name, category, unit price) for products that have a quantity sold greater than the average quantity sold across all products. 
SELECT p.product_name, p.category, p.unit_price
FROM Products p
JOIN Sales s ON p.product_id = s.product_id
WHERE s.quantity_sold > (SELECT AVG(quantity_sold) FROM Sales);

-- 4. Explain the significance of indexing in SQL databases and provide an example scenario where indexing could significantly improve query performance in the given schema. 
CREATE INDEX idx_sale_date ON Sales(sale_date);

-- 5. Add a foreign key constraint to the Sales table that references the product_id column in the Products table. 
ALTER TABLE Sales
ADD CONSTRAINT fk_product_id
FOREIGN KEY (product_id)
REFERENCES Products(product_id);

-- 6. Create a view named Top_Products that lists the top 3 products based on the total quantity sold. 
CREATE VIEW Top_Products AS
SELECT p.product_name, SUM(s.quantity_sold) AS total_quantity_sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

-- 7. Implement a transaction that deducts the quantity sold from the Products table when a sale is made in the Sales table, ensuring that both operations are either committed or rolled back together. 
BEGIN TRANSACTION;
UPDATE Products
SET quantity_in_stock = quantity_in_stock - (SELECT quantity_sold FROM Sales WHERE sale_id = @sale_id)
WHERE product_id = @product_id;
INSERT INTO Sales (sale_id, product_id, quantity_sold, total_price, sale_date)
VALUES (@sale_id, @product_id, @quantity_sold, @total_price, @sale_date);
IF @@ERROR != 0
    ROLLBACK TRANSACTION;
ELSE
    COMMIT TRANSACTION;

-- 8. Create a query that lists the product names along with their corresponding sales count. 
SELECT p.product_name, COUNT(s.sale_id) AS sales_count
FROM Products p
JOIN Sales s ON p.product_id = s.product_id
GROUP BY p.product_name;

-- 9. Write a query to find all sales where the total price is greater than the average total price of all sales. 
SELECT * 
FROM Sales
WHERE total_price > (SELECT AVG(total_price) FROM Sales);

-- 10. Analyze the performance implications of indexing the sale_date column in the Sales table, considering the types of queries commonly executed against this column. 
CREATE INDEX idx_sale_date ON Sales(sale_date);

-- 11. Add a check constraint to the quantity_sold column in the Sales table to ensure that the quantity sold is always greater than zero. 
ALTER TABLE Sales
ADD CONSTRAINT chk_quantity_sold CHECK (quantity_sold > 0);

-- 12. Create a view named Product_Sales_Info that displays product details along with the total number of sales made for each product. 
CREATE VIEW Product_Sales_Info AS
SELECT p.product_name, p.category, SUM(s.quantity_sold) AS total_sales
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name, p.category;

-- 13. Develop a stored procedure named Update_Unit_Price that updates the unit price of a product in the Products table based on the provided product_id. 
CREATE PROCEDURE Update_Unit_Price 
    @product_id INT, 
    @new_unit_price DECIMAL(10, 2)
AS
BEGIN
    UPDATE Products
    SET unit_price = @new_unit_price
    WHERE product_id = @product_id;
END;

-- 14. Implement a transaction that inserts a new product into the Products table and then adds a corresponding sale record into the Sales table, ensuring that both operations are either fully completed or fully rolled back. 
BEGIN TRANSACTION;
INSERT INTO Products (product_name, category, unit_price)
VALUES (@product_name, @category, @unit_price);
INSERT INTO Sales (sale_id, product_id, quantity_sold, total_price, sale_date)
VALUES (@sale_id, @product_id, @quantity_sold, @total_price, @sale_date);
IF @@ERROR != 0
    ROLLBACK TRANSACTION;
ELSE
    COMMIT TRANSACTION;

-- 15. Write a query that calculates the total revenue generated from each category of products for the year 2024. 
SELECT p.category, SUM(s.quantity_sold * p.unit_price) AS total_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
WHERE YEAR(s.sale_date) = 2024
GROUP BY p.category;
