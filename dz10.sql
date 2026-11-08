-- 0. Создание и заполнение таблицы (для контекста)
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;

CREATE TABLE Products
(
    Id INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price MONEY NOT NULL
);

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price) VALUES
('iPhone 14 Pro Max', ' APPLE ', 5, 110000.50),
('galaxy s23 ultra', 'Samsung', 0, 95490.99),
('Mi 13 Ultra', 'xiaomi', 12, 74999.00),
('Redmi Note 12', 'XIAOMI', 25, 19990.45),
('iPad Air 2022', 'Apple', 3, 65000.00),
('Galaxy Book 3', ' SAMSUNG ', 2, 125500.75),
('Xperia 1 V', 'Sony', 1, 102000.00),
('POCO F5 Pro', 'Xiaomi', 8, 42300.10);

-- 1. ФУНКЦИИ ДЛЯ РАБОТЫ СО СТРОКАМИ (STRING)

-- 1.1.
SELECT 
    Manufacturer AS OriginalManufacturer,
    TRIM(Manufacturer) AS CleanManufacturer
FROM Products;

-- 1.2. 
SELECT 
    UPPER(ProductName) AS ProductName_Upper,
    LOWER(Manufacturer) AS Manufacturer_Lower
FROM Products;

-- 1.3. 
SELECT * 
FROM Products 
WHERE CHARINDEX('Ultra', ProductName) > 0; 

-- 1.4. 
SELECT 
    ProductName AS OriginalName,
    REPLACE(ProductName, 'Galaxy', 'Galaxy (New Edition)') AS NewProductName
FROM Products;

-- 1.5. 
SELECT 
    ProductName, 
    LEN(ProductName) AS NameLength
FROM Products
ORDER BY NameLength DESC;


-- 2. ФУНКЦИИ ДЛЯ РАБОТЫ С ЧИСЛАМИ (NUMERIC)

-- 2.1. 
SELECT 
    ProductName,
    ProductCount,
    Price,
    CEILING(ProductCount * Price) AS TotalStockValue_Ceiling
FROM Products;

-- 2.2.
SELECT 
    ProductName,
    Price AS OriginalPrice,
    FLOOR(Price * 0.875) AS DiscountedPrice_Floor
FROM Products;

-- 2.3.
SELECT 
    ProductName,
    Price AS OriginalPrice,
    ROUND(Price, 1) AS Price_Rounded
FROM Products;

-- 2.4. 
SELECT 
    ProductName,
    Price,
    (SELECT AVG(Price) FROM Products) AS AvgPrice,
    SIGN(Price - (SELECT AVG(Price) FROM Products)) AS PriceVsAverage_Sign
    -- 1 = дороже среднего, -1 = дешевле среднего, 0 = равно среднему
FROM Products;


-- 3. ФУНКЦИИ ПО РАБОТЕ С ДАТАМИ И ВРЕМЕНЕМ (DATE & TIME)

-- 3.1. 
SELECT 
    ProductName,
    CONVERT(VARCHAR(16), GETDATE(), 120) AS ReportDate
FROM Products;

-- 3.2.
SELECT 
    ProductName,
    Manufacturer,
    DATEADD(day, 
        CASE WHEN UPPER(TRIM(Manufacturer)) = 'APPLE' THEN 730 ELSE 365 END, 
        CAST(GETDATE() AS DATE)
    ) AS WarrantyEndDate
FROM Products;

-- 3.3. 
SELECT 
    DATEDIFF(day, 
        CAST(GETDATE() AS DATE), 
        CAST(DATEFROMPARTS(YEAR(GETDATE()), 12, 31) AS DATE)
    ) AS DaysUntilEndOfYear;

-- 3.4.
SELECT 
    YEAR(GETDATE()) AS CurrentYear,
    MONTH(GETDATE()) AS CurrentMonth,
    DAY(GETDATE()) AS CurrentDay;
