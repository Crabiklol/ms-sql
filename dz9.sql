IF OBJECT_ID('tempdb..#Products') IS NOT NULL
    DROP TABLE #Products;
GO

CREATE TABLE #Products
(
    Id           INT IDENTITY PRIMARY KEY,
    ProductName  NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price        MONEY NOT NULL
);
GO

INSERT INTO #Products (ProductName, Manufacturer, ProductCount, Price)
VALUES 
    (N'iPhone 15 Pro',      N'Apple',   5,  120000.00),
    (N'Galaxy S24 Ultra',   N'Samsung', 0,  110000.00),
    (N'Redmi Note 13',      N'Xiaomi', 15,   25000.50),
    (N'Pixel 8 Pro',        N'Google',  3,   85000.80),
    (N'PlayStation 5 Slim', N'Sony',    8,   54990.00),
    (N'MacBook Air 13',     N'Apple',   2,  105400.30);
GO

SELECT 
    UPPER(LEFT(Manufacturer, 3)) 
    + '-' 
    + LOWER(REPLACE(SUBSTRING(ProductName, 1, 4), ' ', '')) AS ProductCode,

   CASE 
        WHEN ProductCount > 0 THEN CAST(N'Да' AS NVARCHAR(3))
        ELSE CAST(N'Нет' AS NVARCHAR(3))
    END AS IsAvailable,

    FLOOR(ProductCount * Price) AS TotalCost,

    CAST(ROUND(Price * 0.90, 2) AS DECIMAL(10,2)) AS PromoPrice,

    CAST(
        CONCAT(
            ProductCount / 5, 
            N' коробок по 5 шт. и ', 
            ProductCount % 5, 
            N' шт. остатка'
        ) AS NVARCHAR(100)
    ) AS Distribution,

    CAST(DATEADD(month, 18, GETDATE()) AS DATE) AS WarrantyExpiration,

   DATENAME(weekday, GETDATE()) AS ReportDay

FROM #Products
WHERE LEN(ProductName) > 10;
GO
