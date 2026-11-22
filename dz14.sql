--chap 7 
--1
SELECT 
    e.FirstName, 
    e.LastName, 
    d.DepartmentName
FROM Employees e, Departments d
WHERE e.DepartmentID = d.DepartmentID;

--2
SELECT 
    c.ClientName, 
    c.City, 
    o.OrderDate
FROM Clients c
INNER JOIN Orders o ON c.ClientID = o.ClientID
ORDER BY o.OrderDate DESC;

--3
SELECT 
    d.DepartmentName
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
WHERE e.EmployeeID IS NULL;

--4
SELECT 
    c.ClientName, 
    c.City, 
    ISNULL(SUM(o.OrderSum), 0) AS TotalOrderSum
FROM Clients c
LEFT JOIN Orders o ON c.ClientID = o.ClientID
GROUP BY c.ClientID, c.ClientName, c.City;

--5
SELECT City FROM Clients
UNION
SELECT City FROM Employees;

--6
SELECT City FROM Clients
EXCEPT
SELECT City FROM Employees;

--7
SELECT City FROM Clients
INTERSECT
SELECT City FROM Employees;

--chap 8
--1
SELECT 
    UPPER(FirstName + ' ' + LastName) AS FullName,
    LEN(UPPER(FirstName + ' ' + LastName)) AS NameLength
FROM Employees;

--2
SELECT 
    OrderID,
    OrderSum * 0.18 AS RawTax,
    -- Трюк с умножением на 100 и делением на 100.0 нужен, так как CEILING и FLOOR 
    CEILING(OrderSum * 0.18 * 100) / 100.0 AS TaxCeiling,
    FLOOR(OrderSum * 0.18 * 100) / 100.0 AS TaxFloor
FROM Orders;

--3
SELECT 
    OrderID, 
    OrderDate,
    DATEDIFF(day, OrderDate, GETDATE()) AS DaysPassed
FROM Orders
WHERE MONTH(OrderDate) = MONTH(GETDATE()) 
  AND YEAR(OrderDate) = YEAR(GETDATE());

--4
SELECT 
    CONVERT(VARCHAR(10), OrderDate, 104) AS FormattedDate, 
    CAST(OrderSum AS INT) AS IntegerAmount
FROM Orders;

--5
SELECT 
    FirstName, 
    LastName, 
    Salary,
    CASE 
        WHEN Salary > 100000 THEN 'Высокая'
        WHEN Salary >= 50000 AND Salary <= 100000 THEN 'Средняя'
        ELSE 'Низкая'
    END AS SalaryCategory
FROM Employees;

--6
SELECT 
    ClientName,
    ISNULL(Phone, 'Нет телефона') AS ContactPhone,
    NEWID() AS UniqueRowID
FROM Clients;
