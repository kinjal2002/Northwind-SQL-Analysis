--Total Sales Revenue by Category-----------
SELECT c.CategoryName, SUM(od.UnitPrice * od.Quantity) AS TotalRevenue
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN [Order Details] od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY c.CategoryName
ORDER BY TotalRevenue DESC

--Top Selling Products
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantitySold
FROM Products p
JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantitySold DESC

--Sales Performance Over Time
SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, SUM(UnitPrice * Quantity) AS TotalRevenue
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth

--Customer Sales Contribution
SELECT c.CompanyName, SUM(od.UnitPrice * od.Quantity) AS TotalSalesContribution
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
ORDER BY TotalSalesContribution DESC

--Sales by Employee
SELECT e.FirstName + ' ' + e.LastName AS EmployeeName, SUM(od.UnitPrice * od.Quantity) AS TotalSalesRevenue
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY e.FirstName, e.LastName
ORDER BY TotalSalesRevenue DESC

