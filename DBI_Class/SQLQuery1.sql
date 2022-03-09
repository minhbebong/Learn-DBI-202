-- Đây là dòng comment 
-- tuy nhiên khi đi thi kh được viết tiếng việt
-- Đầu tiên tạo được data base
use master
go 

-- Tạo database
create database DBI2022_SE1623

--Xóa database
--drop database

--Các thao tác liên quan đến table
use DBI2022_SE1623

--Tạo bảng
create table Supplier(
	SupplierCode varchar(10) primary key,
	SupplierName varchar(20),
	[Address] varchar(max)
)

--Xóa bảng 
drop table Supplier

create table Employee(
	EmployeeID varchar(10) primary key,
	FullName nvarchar(20) not null,
	Gender varchar(6) not null check(Gender = 'Male' or Gender = 'Female'),
	Birthdate smalldatetime not null,
	[Address] varchar(max)
)

drop table Employee

create table Product(
	ProductCode varchar(10) not null,
	[Name] varchar(30) not null,
	PurchasePrice real not null,
	SellPrice real not null,
	[Type] varchar (10) not null,
	SupplierCode varchar (10) not null,
	primary key (ProductCode)
)
create table Invoice(
	InvoiceID varchar(10) primary key,
	SellDate smalldatetime not null check (selldate<=getdate()),
	EmployeeID varchar (10) not null,
	Foreign key (EmployeeID) references Employee (EmployeeID)
)

drop table Invoice
create table InvoiceLine(
	ProductCode varchar(10) not null,
	InvoiceID varchar(10),
	Quantity varchar(10) not null 
)
drop table InvoiceLine
--Insert dữ liệu vào table
insert into Product(ProductCode,[Name] ,PurchasePrice,SellPrice,[Type],SupplierCode)
values('P01', 'LapTop', 100, 99, 'Standard','T01' )

insert into Product(ProductCode,[Name] ,PurchasePrice,SellPrice,[Type],SupplierCode)
values('P02', 'PC', 50, 49, 'Standard','T02' )

insert into Product
values ('P04','LaptopDell',50,49,'Standard','T03')

insert into Product
values ('P05','LaptopDell new',50,49,'Standard','S03')

insert into Invoice
value
--Hiển thị 
select*from Product
select*from Supplier

--Update dữ liệu cho bảng
update Product set SupplierCode='L01'

update Supplier set SupplierName='Suzuki',Address='Japan'
where SupplierCode='S03'

--Xóa dữ liệu trong bảng
delete from Product
where ProductCode='P04'

--Add thêm constraints cho bảng Product(mà kh xóa bảng và tạo lại)
----1.Constraint Unique cho trường Name
alter table Product
add constraint Unique_Name unique (Name)

--2.Constraint FK cho trường SupplierCode
alter table Product
add constraint FK_Suppliercode
Foreign key (SupplierCode) references Supplier(SupplierCode)

--3. Constraint check: Sellprice >= purchasePrice
alter table Product
add constraint Check_Price
check (SellPrice >= PurchasePrice)

