
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'test')
BEGIN
    CREATE DATABASE test;
END
GO

USE test;
GO

IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
GO



CREATE TABLE Products
(
    Id INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price MONEY NOT NULL
);

CREATE TABLE Customers
(
    Id INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(30) NOT NULL
);

CREATE TABLE Orders
(
    Id INT IDENTITY PRIMARY KEY,
    ProductId INT NOT NULL REFERENCES Products(Id) ON DELETE CASCADE,
    CustomerId INT NOT NULL REFERENCES Customers(Id) ON DELETE CASCADE,
    CreatedAt DATE NOT NULL,
    ProductCount INT DEFAULT 1,
    Price MONEY NOT NULL
);
GO



INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES 
(N'iPhone 15', N'Apple', 12, 85000.00),
(N'Galaxy S24', N'Samsung', 8, 75000.00),
(N'Pixel 8', N'Google', 5, 65000.00),
(N'Redmi Note 13', N'Xiaomi', 20, 22000.00),
(N'Mate 60 Pro', N'Huawei', 4, 90000.00);
GO

INSERT INTO Customers (FirstName)
VALUES 
(N'Александр'),
(N'Мария'),
(N'Дмитрий'),
(N'Елена'),
(N'Иван');
GO

INSERT INTO Orders (ProductId, CustomerId, CreatedAt, ProductCount, Price)
VALUES 
(1, 1, '2026-09-01', 1, 150.00),
(2, 2, '2026-09-01', 2, 600.50),
(1, 3, '2026-09-02', 1, 150.00),
(3, 4, '2026-09-03', 5, 4500.00),
(4, 5, '2026-09-05', 1, 1200.00);
GO



PRINT '--- ЗАДАЧА 1: Список всех фактически проданных товаров ---';

SELECT 
    p.ProductName,
    p.Manufacturer,
    o.Price AS SalePrice
FROM Orders o
INNER JOIN Products p ON o.ProductId = p.Id;
GO



PRINT '--- ЗАДАЧА 2: История заказов товаров Apple ---';

SELECT 
    p.ProductName,
    o.CreatedAt,
    o.ProductCount
FROM Orders o
INNER JOIN Products p ON o.ProductId = p.Id
WHERE p.Manufacturer = 'Apple';
GO

PRINT '=== ВСЕ ЗАДАЧИ УСПЕШНО ВЫПОЛНЕНЫ! ===';
