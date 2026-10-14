CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(100),
    Address NVARCHAR(255),
    Status NVARCHAR(50)
);
INSERT INTO Customers (CustomerName, Address, Status) VALUES
('Иван Иванов', 'Старый адрес 1', 'Active'),
('Пётр Петров', 'Старый адрес 2', 'Inactive'),
('Анна Сидорова', 'Старый адрес 3', 'Active');
GO

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE
);
INSERT INTO Orders (CustomerID, OrderDate) VALUES
(1, '2023-10-01'),
(2, '2023-10-05');
GO


CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductName, Price) VALUES
('Ноутбук', 50000.00),
('Ноутбук', 50000.00), 
('Мышь', 1500.00),
('Мышь', 1500.00),     
('Клавиатура', 3000.00);
GO

CREATE TABLE ProductPrices (
    PriceID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    Price DECIMAL(10, 2)
);
INSERT INTO ProductPrices (ProductID, Price) VALUES
(1, 52000.00),
(1, 55000.00),
(3, 1600.00);
GO


CREATE TABLE OrderDetails (
    DetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT );
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 2),
(1, 3, 1);
GO


PRINT '--- ЗАДАЧА 1: До обновления ---';
SELECT * FROM Customers;

UPDATE Customers
SET Address = 'New Address'
WHERE Status = 'Active';

PRINT '--- ЗАДАЧА 1: После обновления (адрес изменился только у Active) ---';
SELECT * FROM Customers;
GO

ALTER TABLE Orders
ADD OrderStatus VARCHAR(50) DEFAULT 'Pending';

PRINT '--- ЗАДАЧА 2: Результат добавления столбца ---';
SELECT * FROM Orders;
GO

PRINT '--- ЗАДАЧА 3: До удаления дубликатов (5 строк) ---';
SELECT * FROM Products ORDER BY ProductID;

WITH temp AS (
    SELECT ProductName, ROW_NUMBER() OVER (PARTITION BY ProductName ORDER BY ProductID) AS rn
    FROM Products
)
DELETE FROM temp
WHERE rn > 1;

PRINT '--- ЗАДАЧА 3: После удаления дубликатов (осталось 3 уникальных строки) ---';
SELECT * FROM Products ORDER BY ProductID;
GO


PRINT '--- ЗАДАЧА 4: До обновления цен ---';
SELECT * FROM Products;

UPDATE Products
SET Price = (SELECT MAX(Price) FROM ProductPrices)
WHERE ProductID IN (
    SELECT ProductID FROM ProductPrices
);

PRINT '--- ЗАДАЧА 4: После обновления цен ---';
SELECT * FROM Products;
GO


PRINT '--- ЗАДАЧА 5: Тип данных до изменения (должен быть int) ---';
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'OrderDetails' AND COLUMN_NAME = 'Quantity';

ALTER TABLE OrderDetails
ALTER COLUMN Quantity DECIMAL(10, 2);

PRINT '--- ЗАДАЧА 5: Тип данных после изменения (должен быть numeric/decimal) ---';
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'OrderDetails' AND COLUMN_NAME = 'Quantity';
GO

PRINT '=== ВСЕ ЗАДАЧИ УСПЕШНО ВЫПОЛНЕНЫ! ===';
