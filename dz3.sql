
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'usersdb')
BEGIN
    CREATE DATABASE usersdb;
END
GO

USE usersdb;
GO



IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
GO

CREATE TABLE Customers
(
    Id INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(20) NOT NULL,
    LastName NVARCHAR(20) NOT NULL,
    AccountSum MONEY
);

CREATE TABLE Employees
(
    Id INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(20) NOT NULL,
    LastName NVARCHAR(20) NOT NULL
);
GO



INSERT INTO Customers (FirstName, LastName, AccountSum) VALUES
('Tom', 'Smith', 2000),
('Sam', 'Brown', 3000),
('Mark', 'Adams', 2500),
('Paul', 'Ins', 4200),
('John', 'Smith', 2800),
('Tim', 'Cook', 2800);
GO

INSERT INTO Employees (FirstName, LastName) VALUES
('Homer', 'Simpson'),
('Tom', 'Smith'),
('Mark', 'Adams'),
('Nick', 'Svensson');
GO



PRINT '--- ЗАДАЧА 1: Люди с фамилией Smith или Adams ---';

WITH AllPeople AS (
    SELECT FirstName, LastName, 'Клиент' AS Role, AccountSum AS Balance
    FROM Customers
    UNION ALL
    SELECT FirstName, LastName, 'Сотрудник' AS Role, CAST(0 AS MONEY) AS Balance
    FROM Employees
)
SELECT FirstName, LastName, Role, Balance
FROM AllPeople
WHERE LastName IN ('Smith', 'Adams')
ORDER BY LastName, FirstName;
GO



PRINT '--- ЗАДАЧА 2: Люди с балансом > 2500 ---';

WITH AllPeople AS (
    SELECT FirstName, LastName, 'Клиент' AS Role, AccountSum AS Balance
    FROM Customers
    UNION ALL
    SELECT FirstName, LastName, 'Сотрудник' AS Role, CAST(0 AS MONEY) AS Balance
    FROM Employees
)
SELECT FirstName, LastName, Role, Balance
FROM AllPeople
WHERE Balance > 2500
ORDER BY Balance DESC;
GO



PRINT '--- ЗАДАЧА 3: Количество клиентов и сотрудников ---';

WITH AllPeople AS (
    SELECT 'Клиент' AS Role FROM Customers
    UNION ALL
    SELECT 'Сотрудник' AS Role FROM Employees
)
SELECT Role, COUNT(*) AS TotalCount
FROM AllPeople
GROUP BY Role;
GO



PRINT '--- ЗАДАЧА 4: 3 самые частые фамилии ---';

WITH AllPeople AS (
    SELECT LastName FROM Customers
    UNION ALL
    SELECT LastName FROM Employees
)
SELECT TOP 3
    LastName,
    COUNT(*) AS Occurrences
FROM AllPeople
GROUP BY LastName
ORDER BY COUNT(*) DESC, LastName ASC;
GO

PRINT '=== ВСЕ ЗАДАЧИ УСПЕШНО ВЫПОЛНЕНЫ! ===';
