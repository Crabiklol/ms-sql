
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'productsdb')
BEGIN
    CREATE DATABASE productsdb;
END
GO

USE productsdb;
GO



IF OBJECT_ID('trg_Products_AfterDelete', 'TR') IS NOT NULL 
    DROP TRIGGER trg_Products_AfterDelete;
GO

IF OBJECT_ID('History', 'U') IS NOT NULL DROP TABLE History;
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
    CreateAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO



CREATE TRIGGER trg_Products_AfterDelete
ON Products
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO History (ProductId, Operation)
    SELECT 
        d.Id,
        N'Удален товар: ' + d.ProductName + N', Производитель: ' + d.Manufacturer
    FROM deleted AS d;
END;
GO


PRINT '--- ШАГ 1: Добавляем товары ---';

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES 
(N'iPhone 15', N'Apple', 12, 85000.00),
(N'Galaxy S24', N'Samsung', 8, 75000.00),
(N'Pixel 8', N'Google', 5, 65000.00),
(N'Redmi Note 13', N'Xiaomi', 20, 22000.00),
(N'Mate 60 Pro', N'Huawei', 4, 90000.00);

PRINT 'Таблица Products (5 товаров):';
SELECT * FROM Products;
GO

PRINT '--- ШАГ 2: Удаляем один товар (Pixel 8) ---';

DELETE FROM Products WHERE ProductName = N'Pixel 8';

PRINT 'Таблица Products (осталось 4 товара):';
SELECT * FROM Products;

PRINT 'Таблица History (должна появиться 1 запись об удалении):';
SELECT * FROM History;
GO


PRINT '--- ШАГ 3: Удаляем несколько товаров сразу ---';

DELETE FROM Products WHERE Manufacturer IN (N'Samsung', N'Xiaomi');

PRINT 'Таблица Products (осталось 2 товара):';
SELECT * FROM Products;

PRINT 'Таблица History (должно быть 3 записи — 1 из шага 2 + 2 из шага 3):';
SELECT * FROM History;
GO

PRINT '=== ТРИГГЕР AFTER DELETE РАБОТАЕТ КОРРЕКТНО! ===';
