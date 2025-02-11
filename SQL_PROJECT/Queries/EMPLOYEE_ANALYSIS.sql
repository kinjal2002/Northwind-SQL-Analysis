--All the Orders of bevereages Handled by Steven that is going to London by Speedy Express
select * from Orders where OrderID in
(select OrderID from [Order Details] where ProductID in
(select ProductID from Products where CategoryID in
(select CategoryID from Categories where CategoryName='Beverages'))) and 
EmployeeID in (select EmployeeID from Employees where FirstName='Steven')
and ShipCity='London' and ShipVia in
(select ShipperId from Shippers where CompanyName='Speedy Express')

--All the Employees who works in western region
select*FROM EMPLOYEES WHERE EMPLOYEEID IN
(SELECT EmployeeID FROM EmployeeTerritories WHERE TerritoryID IN
(SELECT TerritoryID FROM Territories WHERE RegionID IN
( SELECT REGIONID FROM Region WHERE RegionDescription='WESTERN')))

--All the Employees Who works in Boston
select * from Employees where EmployeeID in 
(select EmployeeID from EmployeeTerritories where TerritoryID in
(select TerritoryID from Territories where TerritoryDescription='Boston'))

--All employees along with their respective managers in the company
select a.FirstName+' '+a.LastName "Employee",b.FirstName+' '+b.LastName "Manager"
from 
Employees a,Employees b
where
a.ReportsTo=b.EmployeeID

--List the EmployeeID, FirstName, LastName, Birthdate, Age, Hiredate, and Tenure of all employees in the company
select EmployeeID,FirstName,LastName,Birthdate,DATEDIFF(yy,birthdate,getdate())"Age",
Hiredate,DATEDIFF(yy,Hiredate,getdate())"Tenure"
from Employees

--Total sales amount for each employee
select Employees.EmployeeID, FirstName, LastName, SUM(UnitPrice * Quantity) AS TotalSalesAmount
from Employees
join Orders 
on 
Employees.EmployeeID = Orders.EmployeeID
join [Order Details] 
on 
Orders.OrderID = [Order Details].OrderID
group by Employees.EmployeeID, FirstName, LastName
order by TotalSalesAmount

--Analyze employee demographics
select COUNT(EmployeeID) as TotalEmployees,AVG(DATEDIFF(yy, Birthdate, GETDATE())) as AverageAge
from Employees;

--Employee tenure
SELECT EmployeeID, FirstName, LastName, DATEDIFF(yy, HireDate, GETDATE()) as TenureYears
FROM Employees;

--All employees along with the total number of unique customers assigned to each employee
select Employees.EmployeeID, FirstName, LastName, COUNT(CustomerID) as TotalCustomers
from Employees
join Orders on Employees.EmployeeID = Orders.EmployeeID
group by Employees.EmployeeID, FirstName, LastName

--All employees along with their average sales target achieved and average customer satisfaction rating
select Employees.EmployeeID, FirstName, LastName, SUM(UnitPrice * Quantity) as TotalSalesAmount
from Employees
join Orders on Employees.EmployeeID = Orders.EmployeeID
join [Order Details] on Orders.OrderID = [Order Details].OrderID
group by Employees.EmployeeID, FirstName, LastName
order by TotalSalesAmount asc;

select * from Employees

