-------------Procedure in SQL--------------
create procedure sp_CustCity
@City varchar(50)
as
Begin
select * from Customers where City=@City
End


execute sp_CustCity 'London'

alter procedure vy_delorder
@OrderID int
as
begin
delete from [Order Details] where OrderID=@OrderID
delete from Orders where OrderID=@OrderID
End

execute vy_delorder 10249

alter procedure mg_Update
@CategoryName varchar(50),
@rate float
as
begin
update Products 
set UnitPrice=UnitPrice-(Unitprice*@rate)/100
where categoryId=(select CategoryID from Categories where CategoryName=@CategoryName)
End

select *from Categories
select * from Products
execute mg_Update 'condiments',10