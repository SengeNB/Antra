USE AdventureWorks2019
GO

--1
SELECT count(*)
From Production.Product

--2
SELECT COUNT(*) as ProductionSubcategory
FROM Production.Product
Where ProductSubcategoryID IS NOT NULL

--3
SELECT ProductSubcategoryID, COUNT(ProductSubcategoryID) as CountedProducts
FROM Production.Product
Where ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID

--4 
SELECT COUNT(*) AS ProductsWithoutSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;

--5
SELECT SUM(Quantity) 
FROM Production.ProductInventory

--6
SELECT ProductID, SUM(Quantity) as TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 
GROUP by ProductID
HAVING SUM(Quantity) < 100


--7
SELECT Shelf, ProductID , SUM(Quantity) as TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 
GROUP by Shelf, ProductID
HAVING SUM(Quantity) < 100


--8
SELECT LocationID, AVG(Quantity)
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY LocationID

--9
SELECT ProductID, Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf


--10
SELECT ProductID, Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY ProductID, Shelf

--11
SELECT Color, CLASS, Count(*) as TheCount,AVG(ListPrice) as AVGPrice
FROM Production.Product
WHERE Color IS NOT NUll And CLASS IS NOT NULL
GROUP By Color, CLASS

--12
SELECT cr.Name as Country, sp.Name as Province
FROM person.CountryRegion as cr
JOIN Person.StateProvince as sp
ON cr.CountryRegionCode = sp.CountryRegionCode;

--13
SELECT cr.Name as Country, sp.Name as Province
FROM person.CountryRegion as cr
JOIN Person.StateProvince as sp
    ON cr.CountryRegionCode = sp.CountryRegionCode
Where cr.Name In('Canada','Germany') 

USE Northwind
GO

--14
SELECT DISTINCT p.ProductName
FROM dbo.Products AS p
JOIN dbo.[Order Details] AS od ON p.ProductID = od.ProductID
JOIN dbo.Orders AS o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE());

--15
SELECT top 5 o.ShipPostalCode as ZipCode, SUM(od.Quantity) as TotalSold
FROM dbo.Orders as o
JOIN dbo.[Order Details] as od ON o.OrderID = od.OrderID
Where o.ShipPostalCode is NOT NULL
GROUP BY o.ShipPostalCode
ORDER BY TotalSold DESC

--16
SELECT top 5 o.ShipPostalCode as ZipCode, SUM(od.Quantity) as TotalSold
FROM dbo.Orders as o
JOIN dbo.[Order Details] as od ON o.OrderID = od.OrderID
Where o.ShipPostalCode is NOT NULL 
    AND o.OrderDate >= DATEADD(YEAR,-27,GETDATE())
GROUP BY o.ShipPostalCode
ORDER BY TotalSold DESC

--17
SELECT City, COUNT(*) as NumCustomers
FROM dbo.Customers
WHERE City is NOT NULL
GROUP By City 
Order by NumCustomers DESC

--18
SELECT City, COUNT(*) as NumCustomers
FROM dbo.Customers
WHERE City is NOT NULL
GROUP By City 
HAVING COUNT(*) >=2
Order by NumCustomers DESC

--19
SELECT c.ContactName as 'NAME', o.OrderDate as 'order date'
From dbo.Customers as c
JOIN dbo.Orders as o On o.CustomerID = c.CustomerID
Where o.OrderDate > '1998-01-01'

--20
SELECT c.ContactName as 'NAME', o.OrderDate as 'order date'
From dbo.Customers as c
JOIN dbo.Orders as o On o.CustomerID = c.CustomerID
ORDER by o.OrderDate DESC

--21
SELECT c.ContactName AS [NAME], SUM(od.Quantity) AS countOfProducts
FROM dbo.Customers AS c
JOIN dbo.Orders AS o ON o.CustomerID = c.CustomerID
JOIN dbo.[Order Details] AS od ON o.OrderID = od.OrderID
GROUP BY c.ContactName

--22
SELECT c.CustomerID AS [ids], SUM(od.Quantity) AS countOfProducts
FROM dbo.Customers AS c
JOIN dbo.Orders AS o ON o.CustomerID = c.CustomerID
JOIN dbo.[Order Details] AS od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID
HAVING SUM(od.Quantity) > 100

--23
SELECT DISTINCT s.CompanyName AS [Supplier Company Name], sh.CompanyName AS [Shipping Company Name]
FROM dbo.Suppliers AS s
JOIN dbo.Products AS p ON s.SupplierID = p.SupplierID
JOIN dbo.[Order Details] AS od ON p.ProductID = od.ProductID
JOIN dbo.Orders AS o ON od.OrderID = o.OrderID
JOIN dbo.Shippers AS sh ON o.ShipVia = sh.ShipperID;

-- 24
SELECT o.OrderDate, p.ProductName
FROM dbo.Orders AS o
JOIN dbo.[Order Details] AS od ON o.OrderID = od.OrderID
JOIN dbo.Products AS p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate, p.ProductName;

-- 25
SELECT 
  e1.EmployeeID AS Employee1ID,
  e1.FirstName + ' ' + e1.LastName AS Employee1Name,
  e2.EmployeeID AS Employee2ID,
  e2.FirstName + ' ' + e2.LastName AS Employee2Name,
  e1.Title
FROM dbo.Employees AS e1
JOIN dbo.Employees AS e2 
  ON e1.Title = e2.Title 
  AND e1.EmployeeID < e2.EmployeeID
ORDER BY e1.Title;

-- 26
SELECT 
  m.EmployeeID AS ManagerID,
  m.FirstName + ' ' + m.LastName AS ManagerName,
  COUNT(e.EmployeeID) AS NumEmployees
FROM dbo.Employees AS m
JOIN dbo.Employees AS e ON m.EmployeeID = e.ReportsTo
GROUP BY m.EmployeeID, m.FirstName, m.LastName
HAVING COUNT(e.EmployeeID) > 2;

-- 27
SELECT 
  c.City AS City,
  c.CompanyName AS CustomerCompanyName,
  NULL AS SupplierCompanyName
FROM dbo.Customers AS c

UNION

SELECT 
  s.City AS City,
  NULL AS CustomerCompanyName,
  s.CompanyName AS SupplierCompanyName
FROM dbo.Suppliers AS s
ORDER BY City;
