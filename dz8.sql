
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
GO


CREATE TABLE Customers (
    Id INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(30) NOT NULL,
    BonusPoints INT DEFAULT 0
);

CREATE TABLE Products (
    Id INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Price MONEY NOT NULL
);

CREATE TABLE Orders (
    Id INT IDENTITY PRIMARY KEY,
    ProductId INT NOT NULL FOREIGN KEY REFERENCES Products(Id),
    CustomerId INT NOT NULL FOREIGN KEY REFERENCES Customers(Id),
    ProductCount INT DEFAULT 1
);


INSERT INTO Customers (FirstName) VALUES (N'Алексей'), (N'Мария'), (N'Иван'), (N'Ольга');

INSERT INTO Products (ProductName, Price) 
VALUES (N'Смартфон', 30000), (N'Чехол', 1500), (N'Наушники', 5000);


INSERT INTO Orders (ProductId, CustomerId, ProductCount) VALUES (1, 1, 2), (2, 1, 3), (3, 1, 1);

INSERT INTO Orders (ProductId, CustomerId, ProductCount) VALUES (2, 2, 1), (3, 2, 1);

INSERT INTO Orders (ProductId, CustomerId, ProductCount) VALUES (2, 3, 1);


DECLARE @CurrentId INT = 1;
DECLARE @MaxId INT;
DECLARE @CustomerName NVARCHAR(30);
DECLARE @TotalSpent MONEY;
DECLARE @BonusPoints INT;

SELECT @MaxId = MAX(Id) FROM Customers;

WHILE @CurrentId <= @MaxId
BEGIN
    SELECT @CustomerName = FirstName 
    FROM Customers 
    WHERE Id = @CurrentId;

    IF @CustomerName IS NULL
    BEGIN
        SET @CurrentId = @CurrentId + 1;
        CONTINUE;
    END

    SELECT @TotalSpent = ISNULL(SUM(p.Price * o.ProductCount), 0)
    FROM Orders o
    INNER JOIN Products p ON o.ProductId = p.Id
    WHERE o.CustomerId = @CurrentId;

    IF @TotalSpent > 50000
    BEGIN
        SET @BonusPoints = @TotalSpent * 0.10;
        PRINT N'Клиент ' + @CustomerName + N': потрачено ' + CAST(@TotalSpent AS NVARCHAR(20)) + N', начислено ' + CAST(@BonusPoints AS NVARCHAR(20)) + N' бонусов.';
    END
    ELSE IF @TotalSpent >= 5000
    BEGIN
        SET @BonusPoints = @TotalSpent * 0.05;
        PRINT N'Клиент ' + @CustomerName + N': потрачено ' + CAST(@TotalSpent AS NVARCHAR(20)) + N', начислено ' + CAST(@BonusPoints AS NVARCHAR(20)) + N' бонусов.';
    END
    ELSE IF @TotalSpent > 0
    BEGIN
        SET @BonusPoints = 200;
        PRINT N'Клиент ' + @CustomerName + N': потрачено ' + CAST(@TotalSpent AS NVARCHAR(20)) + N', начислено ' + CAST(@BonusPoints AS NVARCHAR(20)) + N' бонусов.';
    END
    ELSE
    BEGIN
        SET @BonusPoints = 0;
        PRINT N'Предупреждение: Клиент ' + @CustomerName + N' не совершал покупок. Бонусы не начислены.';
    END

    UPDATE Customers 
    SET BonusPoints = @BonusPoints 
    WHERE Id = @CurrentId;

    SET @CurrentId = @CurrentId + 1;
END


SELECT * FROM Customers;
