
CREATE DATABASE MetanitShop;
GO


USE MetanitShop;
GO


CREATE TABLE Products (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL(18, 2) NOT NULL
);
GO


INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price) VALUES
('iPhone 13', 'Apple', 3, 80000.00),
('iPhone 14', 'Apple', 2, 120000.00),
('Galaxy S22', 'Samsung', 5, 70000.00),
('Mi 11', 'Xiaomi', 4, 45000.00);
GO




USE MetanitShop;
GO

DECLARE @Vendor NVARCHAR(50) = 'Apple';
DECLARE @TotalModels INT;
DECLARE @MaxPrice DECIMAL(18, 2);

SELECT 
    @TotalModels = COUNT(Id),
    @MaxPrice = MAX(Price)
FROM Products
WHERE Manufacturer = @Vendor;

PRINT 'Бренд: ' + @Vendor + 
      '. Всего моделей: ' + CAST(@TotalModels AS NVARCHAR(10)) + 
      '. Самый дорогой товар стоит: ' + CAST(@MaxPrice AS NVARCHAR(20)) + ' руб.';
GO



USE MetanitShop;
GO

DECLARE @TargetProductId INT = 1;
DECLARE @RequiredCount INT = 3;
DECLARE @AvailableCount INT;

SELECT @AvailableCount = ProductCount
FROM Products
WHERE Id = @TargetProductId;

IF @AvailableCount IS NULL
BEGIN
    PRINT 'Ошибка: Товар с ID ' + CAST(@TargetProductId AS NVARCHAR(10)) + ' не найден.';
END
ELSE
BEGIN
    IF @AvailableCount >= @RequiredCount
    BEGIN
        PRINT 'Сделка одобрена. Доступно штук: ' + CAST(@AvailableCount AS NVARCHAR(10)) + '.';
    END
    ELSE
    BEGIN
        PRINT 'Ошибка: Недостаточно товара. Требуется: ' + CAST(@RequiredCount AS NVARCHAR(10)) + 
              ', в наличии: ' + CAST(@AvailableCount AS NVARCHAR(10)) + '.';
    END
END
GO
