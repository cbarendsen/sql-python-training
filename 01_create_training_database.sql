/* =========================================================
   TrainingShop sample database
   A small online shop: customers, products, orders.
   Safe to re-run: it drops and recreates the database.
   ========================================================= */

USE master;
GO

IF DB_ID('TrainingShop') IS NOT NULL
BEGIN
    ALTER DATABASE TrainingShop SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TrainingShop;
END
GO

CREATE DATABASE TrainingShop;
GO

USE TrainingShop;
GO

CREATE TABLE dbo.Customers (
    CustomerID   INT IDENTITY(1,1) PRIMARY KEY,
    FirstName    NVARCHAR(50)  NOT NULL,
    LastName     NVARCHAR(50)  NOT NULL,
    Email        NVARCHAR(100) NOT NULL UNIQUE,
    City         NVARCHAR(50)  NOT NULL,
    Province     NVARCHAR(50)  NOT NULL,
    JoinedOn     DATE          NOT NULL
);

CREATE TABLE dbo.Categories (
    CategoryID   INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE dbo.Products (
    ProductID    INT IDENTITY(1,1) PRIMARY KEY,
    ProductName  NVARCHAR(100) NOT NULL,
    CategoryID   INT           NOT NULL REFERENCES dbo.Categories(CategoryID),
    UnitPrice    DECIMAL(10,2) NOT NULL CHECK (UnitPrice >= 0),
    InStock      INT           NOT NULL DEFAULT 0
);

CREATE TABLE dbo.Orders (
    OrderID      INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID   INT          NOT NULL REFERENCES dbo.Customers(CustomerID),
    OrderDate    DATE         NOT NULL,
    Status       NVARCHAR(20) NOT NULL
        CHECK (Status IN (N'Pending', N'Shipped', N'Delivered', N'Cancelled'))
);

CREATE TABLE dbo.OrderItems (
    OrderItemID  INT IDENTITY(1,1) PRIMARY KEY,
    OrderID      INT           NOT NULL REFERENCES dbo.Orders(OrderID),
    ProductID    INT           NOT NULL REFERENCES dbo.Products(ProductID),
    Quantity     INT           NOT NULL CHECK (Quantity > 0),
    UnitPrice    DECIMAL(10,2) NOT NULL
);
GO

INSERT INTO dbo.Customers (FirstName, LastName, Email, City, Province, JoinedOn) VALUES
 (N'Thandi',  N'Mokoena',   N'thandi.mokoena@example.com',  N'Johannesburg',   N'Gauteng',       '2025-02-14'),
 (N'Pieter',  N'van Wyk',   N'pieter.vanwyk@example.com',   N'Cape Town',      N'Western Cape',  '2025-03-02'),
 (N'Ayesha',  N'Patel',     N'ayesha.patel@example.com',    N'Durban',         N'KwaZulu-Natal', '2025-04-19'),
 (N'Sipho',   N'Dlamini',   N'sipho.dlamini@example.com',   N'Pietermaritzburg', N'KwaZulu-Natal', '2025-05-08'),
 (N'Megan',   N'Smith',     N'megan.smith@example.com',     N'Pretoria',       N'Gauteng',       '2025-06-21'),
 (N'Lerato',  N'Nkosi',     N'lerato.nkosi@example.com',    N'Bloemfontein',   N'Free State',    '2025-08-11'),
 (N'Johan',   N'Botha',     N'johan.botha@example.com',     N'Gqeberha',       N'Eastern Cape',  '2025-09-30'),
 (N'Naledi',  N'Khumalo',   N'naledi.khumalo@example.com',  N'Polokwane',      N'Limpopo',       '2025-11-05'),
 (N'Ravi',    N'Naidoo',    N'ravi.naidoo@example.com',     N'Durban',         N'KwaZulu-Natal', '2026-01-17'),
 (N'Zanele',  N'Mthembu',   N'zanele.mthembu@example.com',  N'Cape Town',      N'Western Cape',  '2026-03-09');

INSERT INTO dbo.Categories (CategoryName) VALUES
 (N'Stationery'), (N'Electronics'), (N'Books'), (N'Office Furniture');

INSERT INTO dbo.Products (ProductName, CategoryID, UnitPrice, InStock) VALUES
 (N'A4 Notebook (pack of 5)',        1,    89.00, 120),
 (N'Ballpoint Pens (box of 50)',     1,   145.00,  80),
 (N'Highlighter Set',                1,    65.00, 200),
 (N'Wireless Mouse',                 2,   349.00,  45),
 (N'USB-C Hub',                      2,   599.00,  30),
 (N'27-inch Monitor',                2,  3899.00,  12),
 (N'Noise-Cancelling Headset',       2,  1499.00,  20),
 (N'SQL for Beginners',              3,   420.00,  25),
 (N'Python Crash Course',            3,   550.00,  18),
 (N'Data Analysis Handbook',         3,   480.00,   0),
 (N'Ergonomic Office Chair',         4,  2999.00,   8),
 (N'Adjustable Standing Desk',       4,  6499.00,   5);

INSERT INTO dbo.Orders (CustomerID, OrderDate, Status) VALUES
 (1,  '2026-01-05', N'Delivered'),
 (2,  '2026-01-12', N'Delivered'),
 (3,  '2026-01-20', N'Delivered'),
 (1,  '2026-02-03', N'Delivered'),
 (4,  '2026-02-14', N'Cancelled'),
 (5,  '2026-02-25', N'Delivered'),
 (6,  '2026-03-08', N'Delivered'),
 (2,  '2026-03-19', N'Delivered'),
 (7,  '2026-04-02', N'Delivered'),
 (8,  '2026-04-15', N'Delivered'),
 (3,  '2026-05-06', N'Delivered'),
 (9,  '2026-05-22', N'Delivered'),
 (10, '2026-06-10', N'Delivered'),
 (5,  '2026-07-01', N'Shipped'),
 (1,  '2026-08-18', N'Delivered'),
 (6,  '2026-09-09', N'Shipped'),
 (9,  '2026-10-14', N'Shipped'),
 (2,  '2026-11-02', N'Pending'),
 (10, '2026-11-10', N'Pending'),
 (4,  '2026-11-15', N'Pending');

INSERT INTO dbo.OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES
 (1, 1, 2,   89.00), (1, 2, 1,  145.00),
 (2, 6, 1, 3899.00), (2, 4, 1,  349.00),
 (3, 8, 1,  420.00), (3, 9, 1,  550.00),
 (4, 3, 3,   65.00),
 (5, 11, 1, 2999.00),
 (6, 5, 1,  599.00), (6, 7, 1, 1499.00),
 (7, 1, 5,   89.00), (7, 3, 2,   65.00),
 (8, 12, 1, 6499.00),
 (9, 9, 2,  550.00),
 (10, 4, 2,  349.00), (10, 2, 2,  145.00),
 (11, 6, 2, 3899.00),
 (12, 8, 1,  420.00), (12, 1, 1,   89.00),
 (13, 11, 1, 2999.00), (13, 4, 1,  349.00),
 (14, 7, 1, 1499.00),
 (15, 5, 1,  599.00), (15, 3, 4,   65.00),
 (16, 9, 1,  550.00), (16, 8, 1,  420.00),
 (17, 12, 1, 6499.00),
 (18, 2, 3,  145.00),
 (19, 6, 1, 3899.00), (19, 7, 1, 1499.00),
 (20, 1, 10,   89.00);
GO

PRINT 'TrainingShop database created.';
GO
