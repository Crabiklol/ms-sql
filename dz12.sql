--1
SELECT 
    Manufacturer AS [Производитель],
    ProductName AS [Модель],
    SUM(ProductCount) AS [Общее_количество],
    SUM(ProductCount * Price) AS [Общая_стоимость],
    AVG(Price) AS [Средняя_цена] -- Включено для наглядности проверки условия HAVING
FROM Products
WHERE ProductCount * Price > 100000
GROUP BY ROLLUP(Manufacturer, ProductName)
HAVING AVG(Price) >= 40000;

--2
SELECT 
    Manufacturer AS [Производитель],
    ProductName AS [Модель],
    SUM(ProductCount) AS [Общее_количество],
    SUM(ProductCount * Price) AS [Общая_стоимость],
    AVG(Price) AS [Средняя_цена]
FROM Products
WHERE ProductCount * Price > 100000
GROUP BY CUBE(Manufacturer, ProductName)
HAVING AVG(Price) >= 40000;

