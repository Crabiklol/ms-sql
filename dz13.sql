--1.1
SELECT 
    COUNT(EmployeeID) AS TotalEmployees,
    SUM(Salary) AS TotalSalary,
    AVG(Salary) AS AverageSalary
FROM Employees;
--1.2
SELECT 
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM Products
WHERE CategoryID = (
    SELECT CategoryID 
    FROM Categories 
    WHERE CategoryName LIKE '%Электроника%'
);

--2.1
SELECT 
    CategoryID,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY CategoryID;
--2.2
SELECT 
    o.EmployeeID,
    SUM(o.Quantity * p.Price) AS TotalSales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY o.EmployeeID;

--2.3
SELECT 
    o.EmployeeID,
    SUM(o.Quantity * p.Price) AS TotalSales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY o.EmployeeID
HAVING SUM(o.Quantity * p.Price) > 50000;

--3.1
SELECT 
    p.CategoryID,
    p.ProductID,
    SUM(o.Quantity * p.Price) AS TotalSales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY ROLLUP(p.CategoryID, p.ProductID);

--3.2
SELECT 
    EmployeeID,
    ProductID,
    SUM(Quantity) AS TotalQuantity
FROM Orders
GROUP BY CUBE(EmployeeID, ProductID);

--3.3
SELECT 
    OrderDate,
    EmployeeID,
    SUM(o.Quantity * p.Price) AS TotalSales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY GROUPING SETS (OrderDate, EmployeeID);

--4.1
SELECT 
    FirstName,
    LastName
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary) 
    FROM Employees
);

--4.2
SELECT 
    ProductName
FROM Products
WHERE Price > ALL (
    SELECT Price 
    FROM Products 
    WHERE CategoryID = (
        SELECT CategoryID 
        FROM Categories 
        WHERE CategoryName LIKE '%Книги%'
    )
);
