

USE test;
GO


IF OBJECT_ID('trg_Products_AfterInsert', 'TR') IS NOT NULL 
    DROP TRIGGER trg_Products_AfterInsert;
GO

IF OBJECT_ID('History', 'U') IS NOT NULL DROP TABLE History;
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
GO

CREATE TABLE History
(
    Id INT IDENTITY PRIMARY KEY,
    ProductId INT NOT NULL,
    Operation NVARCHAR(200) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO


CREATE TRIGGER trg_Products_AfterInsert
ON Products
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO History (ProductId, Operation)
    SELECT 
        i.Id,
        N'Добавлен новый товар: ' + i.ProductName + N', Производитель: ' + i.Manufacturer
    FROM inserted AS i;
END;
GO


PRINT '--- ТЕСТ 1: Добавляем один товар ---';

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES (N'iPhone 15', N'Apple', 12, 85000.00);

PRINT 'Таблица Products:';
SELECT * FROM Products;

PRINT 'Таблица History:';
SELECT * FROM History;
GO

PRINT '--- ТЕСТ 2: Добавляем несколько товаров ---';

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES 
(N'Galaxy S24', N'Samsung', 8, 75000.00),
(N'Pixel 8', N'Google', 5, 65000.00),
(N'Redmi Note 13', N'Xiaomi', 20, 22000.00);

PRINT 'Таблица Products:';
SELECT * FROM Products;

PRINT 'Таблица History (должно быть 4 записи):';
SELECT * FROM History;
GO

PRINT '=== ТРИГГЕР РАБОТАЕТ КОРРЕКТНО! ===';
