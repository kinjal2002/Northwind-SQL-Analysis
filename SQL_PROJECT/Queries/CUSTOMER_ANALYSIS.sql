--All Customers who ordered Chai
select * from Customers where CustomerID in
(select CustomerID from Orders where OrderID in
(select OrderID from [Order Details] where ProductID in
(select ProductID from Products where ProductName='Chai')))

--All the customers who Lives in London and his Order is not going to London
select * from Customers where CustomerID in
(select CustomerID from Orders where ShipCity !='London') and City='London'

-- Number of customers and orders
SELECT COUNT(DISTINCT Customers.CustomerID) AS TotalCustomers, COUNT(DISTINCT OrderID) AS TotalOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID

-- Top customers based on total amount spent
SELECT Customers.CustomerID, CompanyName, SUM(UnitPrice * Quantity) AS TotalAmountSpent
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerID, CompanyName
ORDER BY TotalAmountSpent DESC

--Analyze customer retention rates:
SELECT YEAR(OrderDate) AS Year, COUNT(DISTINCT CustomerID) AS TotalCustomers,
       COUNT(DISTINCT CASE WHEN DATEDIFF(yy, RequiredDate, OrderDate) = 0 THEN CustomerID END) AS NewCustomers
FROM Orders
GROUP BY YEAR(OrderDate)
select * from Orders
--Perform customer segmentation
--do not run this code---------------------
SELECT CASE
WHEN TotalSpent > 1000 THEN 'High Value'
WHEN TotalSpent > 500 THEN 'Medium Value'
ELSE 'Low Value'
END AS CustomerSegment,
COUNT(CustomerID) AS TotalCustomers
FROM 
(SELECT CustomerID, SUM(UnitPrice * Quantity) AS TotalSpent
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY CustomerID) 
AS CustomerSpending
--------------------------------------------

--run this code---------
WITH CustomerSpending AS (
    SELECT CustomerID, SUM(UnitPrice * Quantity) AS TotalSpent
    FROM Orders
    JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
    GROUP BY CustomerID
)
SELECT CASE
           WHEN TotalSpent > 1000 THEN 'High Value'
           WHEN TotalSpent > 500 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS CustomerSegment,
       COUNT(CustomerID) AS TotalCustomers
FROM CustomerSpending
GROUP BY CASE
             WHEN TotalSpent > 1000 THEN 'High Value'
             WHEN TotalSpent > 500 THEN 'Medium Value'
             ELSE 'Low Value'
         END

--Calculate customer retention rate
SELECT Year,COUNT(DISTINCT CustomerID) AS TotalCustomers,
SUM(CASE WHEN Retained = 1 THEN 1 ELSE 0 END) AS RetainedCustomers,
100 * SUM(CASE WHEN Retained = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT CustomerID) AS RetentionRate FROM 
(SELECT CustomerID,YEAR(MIN(OrderDate)) AS Year,
CASE WHEN MAX(OrderDate) >= DATEADD(yy, -1, GETDATE()) THEN 1 ELSE 0 END AS Retained
FROM 
Orders
GROUP BY CustomerID
) 
AS SubqueryAlias
GROUP BY Year

--Calculate total spending and average order value for each customer
SELECT CustomerID, SUM(UnitPrice * Quantity) AS TotalSpending, AVG(UnitPrice * Quantity) AS AvgOrderValue
FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
GROUP BY CustomerID

--Analyze customer demographics
SELECT Country, COUNT(CustomerID) AS TotalCustomers
FROM Customers
GROUP BY Country


