---All the Suppliers who Supplies Beverages and Lives in London
select * from Suppliers where SupplierID in
(select SupplierID from Products where CategoryID in
(select CategoryID from Categories where CategoryName='Beverages' and City='London'))

--List the ProductID, ProductName, CategoryName, and CompanyName for each product in the Northwind database, showing the category and supplier information for each product
select ProductID,ProductName,CategoryName,CompanyName
from 
Categories,Products,Suppliers
where
Categories.CategoryID=Products.CategoryID
and
Suppliers.SupplierID=Products.SupplierID

--Union
select Address,City,Country from Customers
Union 
select Address,City,Country from Suppliers

--Union All
select City,Country from Customers
Union All
select City,Country from Suppliers

--Intersect
select City,Country from Customers
Intersect
select City,Country from Suppliers

--Except
select City,Country from Customers
Except
select City,Country from Suppliers

-- Number of suppliers and products supplied by each supplier
SELECT Suppliers.SupplierID, Suppliers.CompanyName,COUNT(Products.ProductID) AS TotalProductsSupplied
FROM Products
JOIN 
Suppliers 
ON 
Products.SupplierID = Suppliers.SupplierID
GROUP BY 
Suppliers.SupplierID, Suppliers.CompanyName

-- Top suppliers based on total revenue generated
SELECT Suppliers.SupplierID, Suppliers.CompanyName, SUM(Products.UnitPrice * [Order Details].Quantity) AS TotalRevenue
FROM [Order Details]
JOIN Products 
ON 
[Order Details].ProductID = Products.ProductID
JOIN Suppliers 
ON 
Products.SupplierID = Suppliers.SupplierID
GROUP BY 
Suppliers.SupplierID, Suppliers.CompanyName
ORDER BY 
TotalRevenue DESC


-- Supplier performance metrics
SELECT Suppliers.SupplierID, Suppliers.CompanyName, AVG(DATEDIFF(day, Orders.OrderDate, Orders.ShippedDate)) AS AvgDeliveryTime
FROM Suppliers
JOIN Products ON Suppliers.SupplierID = Products.SupplierID
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON [Order Details].OrderID = Orders.OrderID
GROUP BY Suppliers.SupplierID, Suppliers.CompanyName


SELECT 
    Suppliers.SupplierID, 
    Suppliers.CompanyName, 
    AVG([Order Details].UnitPrice * [Order Details].Quantity) AS AvgSalesAmount
FROM 
    Suppliers
JOIN 
    Products ON Suppliers.SupplierID = Products.SupplierID
JOIN 
    [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY 
    Suppliers.SupplierID, Suppliers.CompanyName


