use master
go

create database ProductOrders

use ProductOrders

----Tạo bảng Customers
create table Customers(
	CustomerID Nvarchar(5) primary key,
	[Name] Nvarchar(30) not null,
	[Address] Nvarchar(50),
	Phone Nvarchar(10),
	Email Nvarchar(30),
)

---Insert dữ liệu vào table Customers
insert into Customers
values
('C01' , 'NGUYEN THI BE' , 'TAN BINH' , 08457895 ,'bnt@yahoo.com'),
('C02' , 'LE HOANG NAM' , 'BINH CHANH' , 09878987 ,'namlehoang @abc.com.vn'),
('C03' , 'TRAN THI CHIEU' , 'TAN BINH' , 08457895,''),
('C04' , 'MAI THI QUE ANH' , 'BINH CHANH','',''),
('C05' , 'LE VAN SANG' , 'QUAN 10' ,'','sanglv@hcm.vnn.vn'),
('C06' , 'TRAN HOANG KHAI' , 'TAN BINH' , 08457895,'' );

--3.Update Email of ’NGUYEN THI BE’ to nguyenthibe@yahoo.com
update Customers set Email = 'nguyenthibe@yahoo.com'where Name = 'NGUYEN THI BE'

---Hiển thị
select*from Customers


---Tạo bảng Products
create table Products(
	ProductCode Nvarchar(5) primary key,
	Name Nvarchar(30) not null,
	Price float check (Price > 0),
	StockQuantity int check ( StockQuantity >= 0)
)
---Insert dữ liệu vào table Products
insert into Products(ProductCode , [Name] , Price , StockQuantity)
values('P01', 'Paper A4 EPSON', 10 , 5000),
	  ('P02', 'Keyboard', 15 , 480),
	  ('P03', 'Mouse', 12 , 800),
	  ('P04', '17"LCD Monitor', 119 , 800),
	  ('P05', '21"LCD Monitor', 219 , 100),
	  ('P06', 'USB 8G' , 45 , 150),
	  ('P07', 'USB 16G', 60 , 500);

---1.1.	Insert a new Product(‘P08’, ‘Pen’, 0.25, 2000)
insert into Products
values('P08', 'Pen', 0.25, 2000);

---Hiển thị
select*from Products

---Tạo bảng Orders
create table Orders(
	OrderID Nvarchar(10) primary key,
	[Date] Date check([Date] <= getdate()),
	CustomerID Nvarchar(5),
	Amount float,
	Foreign key (CustomerID) references Customers(CustomerID)
)

---Insert dữ liệu vào table Orders
insert into Orders(OrderID,[Date],CustomerID)
values
('Or001' , '2000/05/15' , 'C01'),
('Or002' , '2000/05/25' , 'C02'),
('Or003' , '2000/05/25' , 'C01'),
('Or004' , '2000/05/12' , 'C04'),
('Or005' , '2000/05/26' , 'C04'),
('Or006' , '2000/06/02' , 'C03'),
('Or007' , '2000/06/22' , 'C04'),
('Or008' , '2000/06/26', 'C03'),
('Or009' , '2000/08/15' , 'C04'),
('Or010' , '2000/09/30', 'C01'),
('Or011' , '2000/12/27' , 'C06'),
('Or012' , '2000/12/27' , 'C01');

--7.	Delete order ‘Or012’ from the table Orders.
delete from OrderItems where OrderID = 'Or012'
delete from Orders where OrderID = 'Or012'

---Hiển thị
select*from Orders

---Tạo bảng OrderItems
create table OrderItems(
	OrderID Nvarchar(10),
	ProductCode Nvarchar(5),
	Quantity int check ( Quantity > 0),
	Discount float,
	SellPrice float,
	Foreign key (OrderID) references Orders(OrderID), 
	Foreign key (ProductCode) references Products(ProductCode)
)

---Insert dữ liệu vào table Orders
insert into OrderItems(OrderID,ProductCode,Quantity,SellPrice)
values
('Or001', 'P01' , 5 , 12),
('Or001', 'P05' , 10 , 300),
('Or002', 'P03' , 4 , 13),
('Or003', 'P02' , 20 , 16),
('Or004', 'P03' , 3 , 13),
('Or004', 'P04' , 10 , 120),
('Or005', 'P05' , 10 , 309),
('Or005', 'P06' , 15 , 46.6),
('Or005', 'P07' , 20 , 70),
('Or006', 'P04' , 10 , 120),
('Or007', 'P04' , 20 , 125),
('Or008', 'P01' , 2 , 11.5),
('Or008', 'P02' , 20 , 16),
('Or009', 'P02' , 25 , 17),
('Or010', 'P01' , 25 , 11.5),
('Or011', 'P01' , 20 , 12),
('Or011', 'P02' , 20 , 17),
('Or012', 'P01' , 20 , 12),
('Or012', 'P02' , 10 , 16.5),
('Or012', 'P03' , 1 , 13.5);

---Hiển thị
select*from OrderItems



