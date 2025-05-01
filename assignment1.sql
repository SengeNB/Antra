USE AdventureWorks2019
GO

--1.
SELECT ProductID, [Name], Color, ListPrice
FROM Production.Product 

--2.
SELECT ProductID, [Name], Color, ListPrice
FROM Production.Product 
WHERE ListPrice = 0

--3.
SELECT ProductID, [Name], Color, ListPrice
FROM Production.Product 
WHERE Color IS NULL

--4.
SELECT ProductID, [Name], Color, ListPrice
FROM Production.Product 
WHERE Color IS NOT NULL

--5.
SELECT ProductID, [Name], Color, ListPrice
FROM Production.Product 
WHERE Color IS NOT NULL AND ListPrice > 0

--6.
SELECT [Name] +'-' + Color AS tempTable
FROM Production.Product 
WHERE Color IS NOT NULL

--7.
SELECT 'NAME: '+[Name] +' -- COLOR: ' + Color AS tempTable
FROM Production.Product 
WHERE Color IS NOT NULL

--8.
SELECT ProductID, [Name]
FROM Production.Product
WHERE ProductID >= 400 AND ProductID <= 500

--9.
SELECT ProductID, [Name], Color
FROM Production.Product 
WHERE Color = 'black' or Color = 'blue'

--10.
SELECT ProductID, [Name], Color, ListPrice
FROM Production.Product
WHERE [Name] LIKE 'S%';

--11.
SELECT [Name], ListPrice
FROM Production.Product
WHERE [Name] LIKE 'S%' 
ORDER BY [Name] ASC;

--12.
SELECT [Name], ListPrice
FROM Production.Product
WHERE [Name] LIKE 'A%' OR [Name] LIKE 'S%'
ORDER BY [Name] ASC;

--13.
SELECT [Name], ListPrice
FROM Production.Product
WHERE [Name] LIKE 'SPO%' AND [Name] NOT LIKE 'SPOK%'
ORDER BY [Name] ASC;

--14.
SELECT DISTINCT [Color]
FROM Production.Product
ORDER BY [Color] DESC;
