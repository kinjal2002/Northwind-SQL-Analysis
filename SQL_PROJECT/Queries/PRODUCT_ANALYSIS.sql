--All the Products that belongs to beverages or Seafood
select * from Products where CategoryID in
(select CategoryID from Categories where CategoryName='Beverages'
or
CategoryName='Seafood')

--List all products from the Northwind database where the unit price is equal to the maximum unit price among all products
select * from Products where UnitPrice=(select MAX(UnitPrice) 
"Max" from Products)

--List all products from the Northwind database where the unit price is higher than the average unit price across all products
select * from Products where UnitPrice>(select Avg(UnitPrice)
from Products)

--Calculate total sales amount and quantity sold for each product
SELECT Products.ProductID, ProductName, SUM(Products.UnitPrice * [Order Details].Quantity) AS TotalSalesAmount, SUM(Quantity) AS TotalQuantitySold
FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY Products.ProductID, ProductName

--Get total sales, cost, and profit for each product using unit prices from Order Details and Products tables
SELECT Products.ProductID, ProductName, SUM([Order Details].UnitPrice * Quantity) AS TotalSalesAmount, SUM(Products.UnitPrice * Quantity) AS TotalCost,
       SUM([Order Details].UnitPrice * Quantity) - SUM([Order Details].UnitPrice * Quantity) AS TotalProfit
FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY Products.ProductID, ProductName

--Retrieve the total quantity of each product sold in each month and year from the Northwind database, providing insights into the sales performance of products over time
SELECT Products.ProductID, ProductName, YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, 
       SUM(Quantity) AS TotalQuantitySold
FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON [Order Details].OrderID = Orders.OrderID
GROUP BY Products.ProductID, ProductName, YEAR(OrderDate), MONTH(OrderDate)
