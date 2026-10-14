
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



PRINT '--- ЗАДАЧА 1.2: Полный список всех людей (с дубликатами) ---';

SELECT FirstName, LastName
FROM Customers
UNION ALL
SELECT FirstName, LastName
FROM Employees;
GO



PRINT '--- ЗАДАЧА 3.1: Клиенты с балансом > 2500 и сотрудники с именем из 3 букв ---';

SELECT FirstName, LastName
FROM Customers
WHERE AccountSum > 2500

UNION

SELECT FirstName, LastName
FROM Employees
WHERE LEN(FirstName) = 3;
GO


PRINT '--- ЗАДАЧА 3.2: Люди, которые одновременно клиенты и сотрудники ---';

WITH AllPeople AS (
    SELECT FirstName, LastName FROM Customers
    UNION ALL
    SELECT FirstName, LastName FROM Employees
)
SELECT FirstName, LastName
FROM AllPeople
GROUP BY FirstName, LastName
HAVING COUNT(*) > 1;
GO

PRINT '=== ВСЕ ЗАДАЧИ УСПЕШНО ВЫПОЛНЕНЫ! ===';
