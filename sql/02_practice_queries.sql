/* =========================================================
   Practice queries for the TrainingShop database
   Highlight a query and press Ctrl+Shift+E (Cmd+Shift+E on a Mac)
   to run just that query.
   ========================================================= */

USE TrainingShop;
GO

-- 1. See everything in a table
SELECT * FROM dbo.Customers;

-- 2. Choose columns and sort
SELECT FirstName, LastName, City
FROM dbo.Customers
ORDER BY LastName;

-- 3. Filter rows with WHERE
SELECT ProductName, UnitPrice
FROM dbo.Products
WHERE UnitPrice > 500;

-- 4. Join two tables
SELECT p.ProductName, c.CategoryName, p.UnitPrice
FROM dbo.Products AS p
JOIN dbo.Categories AS c ON c.CategoryID = p.CategoryID;

-- 5. Group and total: sales value by category (excluding cancelled orders)
SELECT c.CategoryName,
       SUM(oi.Quantity * oi.UnitPrice) AS SalesValue
FROM dbo.OrderItems AS oi
JOIN dbo.Orders     AS o ON o.OrderID    = oi.OrderID
JOIN dbo.Products   AS p ON p.ProductID  = oi.ProductID
JOIN dbo.Categories AS c ON c.CategoryID = p.CategoryID
WHERE o.Status <> N'Cancelled'
GROUP BY c.CategoryName
ORDER BY SalesValue DESC;

-- 6. Top 3 customers by amount spent
SELECT TOP (3)
       cu.FirstName + N' ' + cu.LastName AS Customer,
       SUM(oi.Quantity * oi.UnitPrice)   AS TotalSpent
FROM dbo.Customers  AS cu
JOIN dbo.Orders     AS o  ON o.CustomerID = cu.CustomerID
JOIN dbo.OrderItems AS oi ON oi.OrderID   = o.OrderID
WHERE o.Status <> N'Cancelled'
GROUP BY cu.FirstName, cu.LastName
ORDER BY TotalSpent DESC;

/* ---------------------------------------------------------
   Your turn
   ---------------------------------------------------------
   a) List all products that are out of stock.
   b) How many customers are there in each province?
   c) Show every order with the customer's name and the order total.
   d) Add yourself as a new customer with INSERT, then find your row.
   e) Which month in 2026 had the highest sales value?
   --------------------------------------------------------- */
