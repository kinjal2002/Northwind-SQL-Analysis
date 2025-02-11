-------------Function----------
create function fn_AddNUM(@num1 int,@num2 int)
returns int
as
Begin
Declare 
@num3 int
select @num3=@num1+@num2
return @num3
End

select dbo.fn_AddNUM(10,20)

select MAX(25)

select * from Customers
select * from Suppliers
select * from Employees

create function fn_GetAddress
(
@Address varchar(50),@City varchar(50),@Region varchar(50),@PostalCode varchar(50),@Country varchar(50)
)
returns varchar(MAX)
as
Begin
return @Address +' '+@City +' '+ @Region +' '+@PostalCode +' '+@Country
End

select CompanyName,dbo.fn_GetAddress(Address,City,isNull(Region,' '),isNull(PostalCode,'ABC'),Country) "Address" from Customers


print 'Hello From SQL'