
create table NewEmployee
(
EmployeeID int identity,
FirstName varchar(50),
LastName varchar(50),
[Address] varchar(50),
Deptno int,
Salary money,
Comm  money
)
create table NewEmployee_BackUp
(
EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
[Address] varchar(50),
Deptno int,
Salary money,
Comm  money
)
create trigger tr_ins_NewEmp on NewEmployee
for insert
as
Begin
Declare
@EmployeeID int,
@FirstName varchar(50),
@LastName varchar(50),
@Address varchar(50),
@Deptno int,
@Salary money,
@Comm  money
Select @EmployeeID=EmployeeID,@FirstName=FirstName,@LastName=LastName,@Address=Address,@Deptno=Deptno,
@Salary=Salary,@Comm=Comm
from inserted
insert into NewEmployee_BackUp values (@EmployeeID,@FirstName,@LastName,@Address,@Deptno,@Salary,@Comm)
End
select * from NewEmployee
select * from NewEmployee_BackUp
insert into NewEmployee values ('ABC','XYZ','KANDIVALI',10,25000,5000)
----------------Tigger on Update-----------------
create table NewEmployee_Update
(
RecType varchar(3),
EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
[Address] varchar(50),
Deptno int,
Salary money,
Comm  money,
UpdatedOn datetime default getdate(),
UpdatedBy sysname default suser_sname()
)

create trigger tr_upd_NewEmp on NewEmployee
for update 
as
Begin
insert into NewEmployee_Update (Rectype,EmployeeID,Firstname,Lastname,Address,Deptno,Salary,Comm)
select 'OLD',del.EmployeeID,del.Firstname,del.Lastname,del.Address,del.Deptno,del.Salary,del.Comm
from deleted del

insert into NewEmployee_Update (Rectype,EmployeeID,Firstname,Lastname,Address,Deptno,Salary,Comm)
select 'NEW',ins.EmployeeID,ins.Firstname,ins.Lastname,ins.Address,ins.Deptno,ins.Salary,ins.Comm
from inserted ins
End

drop trigger tr_upd_NewEmp
select * from NewEmployee
update NewEmployee set Salary=35000
where EmployeeID=1
select * from NewEmployee_Update


----------------------------Tigger on Delete-----------------
create table NewEmployee_Deleted
(
EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
[Address] varchar(50),
Deptno int,
Salary money,
Comm  money,
DeletedOn datetime default getdate(),
DeletedBy sysname default suser_sname()
)
create trigger tr_del_NewEmp on NewEmployee
for delete
as
Begin
Declare
@EmployeeID int,
@FirstName varchar(50),
@LastName varchar(50),
@Address varchar(50),
@Deptno int,
@Salary money,
@Comm  money
Select @EmployeeID=EmployeeID,@FirstName=FirstName,@LastName=LastName,@Address=Address,@Deptno=Deptno,
@Salary=Salary,@Comm=Comm
from deleted
insert into NewEmployee_Deleted (EmployeeID,FirstName,LastName,Address,Deptno,Salary,Comm)values (@EmployeeID,@FirstName,@LastName,@Address,@Deptno,@Salary,@Comm)
End
select * from NewEmployee
select * from NewEmployee_Deleted
delete from NewEmployee where EmployeeID=1