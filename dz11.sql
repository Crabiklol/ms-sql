--1
SELECT 
    ProductName,
    IIF(ProductCount = 0, 'Нет на складе', 'В наличии') AS StockStatus
FROM Products;

--2
SELECT 
    ProductName,
    ProductCount,
    CASE 
        WHEN ProductCount = 0 THEN 'Отсутствует'
        WHEN ProductCount BETWEEN 1 AND 20 THEN 'Мало запасов'
        WHEN ProductCount BETWEEN 21 AND 50 THEN 'Достаточно'
        ELSE 'Избыток'
    END AS StockStatus
FROM Products;

--3
SELECT 
    ProductName,
    Manufacturer,
    CASE Manufacturer
        WHEN 'TechCorp' THEN 'Отечественный'
        WHEN 'HealthTech' THEN 'Отечественный'
        ELSE 'Импорт'
    END AS Origin
FROM Products;
