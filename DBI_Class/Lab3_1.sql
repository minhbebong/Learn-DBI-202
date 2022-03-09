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
('C01' , 'NGUYEN THI BE' , 'TAN BINH' , '08457895' ,'bnt@yahoo.com'),
('C02' , 'LE HOANG NAM' , 'BINH CHANH' , '09878987' ,'namlehoang @abc.com.vn'),
('C03' , 'TRAN THI CHIEU' , 'TAN BINH' , '08457895',''),
('C04' , 'MAI THI QUE ANH' , 'BINH CHANH','',''),
('C05' , 'LE VAN SANG' , 'QUAN 10' ,'','sanglv@hcm.vnn.vn'),
('C06' , 'TRAN HOANG KHAI' , 'TAN BINH' , '08457895','' );

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

---Hiển thị
select*from Products

---Tạo bảng Orders
create table Orders(
	OrderID Nvarchar(10) primary key,
	[Date] Date check([Date] < getdate()),
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

---Hiển thị
select*from Orders

---Tạo bảng OrderItems
create table OrderItems(
	OrderID Nvarchar(10),
	ProductCode Nvarchar(5) ,
	Quantity int check ( Quantity > 0),
	Discount float,
	SellPrice float,
	primary key (OrderID, ProductCode),
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


---1.1.	Insert a new Product(‘P08’, ‘Pen’, 0.25, 2000)
insert into Products
values('P08', 'Pen', 0.25, 2000);

--Xóa những hóa đơn mua 25sp P02
update Orders set Amount = - 1 where OrderID in(select OrderID from OrderItems
where Quantity = 25 and ProductCode = 'P02')


---2.Create a table 
create table CustomerProduct(
CustomerID nvarchar(5) foreign key references Customers(CustomerID) ,
CustomerName nvarchar(30),
ProductCode nvarchar(5) foreign key references Products(ProductCode),
ProductName nvarchar(30), 
TotalQuantity int,
TotalAmount float, 
primary key(CustomerID , ProductCode)
)
Insert CustomerProduct(CustomerID, ProductCode, TotalQuantity, TotalAmount)
Select Orders.CustomerID,
OrderItems.ProductCode,
sum(OrderItems.Quantity) as TotalQuantity,
sum((1-Discount)*SellPrice*Quantity) as TotalAmount
FROM Orders, orderItems
WHERE Orders.OrderID = OrderItems.OrderID
GROUP BY Orders.CustomerID, OrderItems. ProductCode

UPDATE CustomerProduct set CustomerName = Customers.Name
from Customers
where Customers.CustomerID = CustomerProduct.CustomerID

UPDATE CustomerProduct set ProductName = Products.Name
from Products
where Products.ProductCode = CustomerProduct. ProductCode
select * from CustomerProduct

--3.Update Email of ’NGUYEN THI BE’ to nguyenthibe@yahoo.com
update Customers set Email = 'nguyenthibe@yahoo.com'where Name = 'NGUYEN THI BE'

--4	Update Discount of OrderItems 
update OrderItems set
Discount = 0 where (Quantity >= 0 and Quantity < 5)
update OrderItems set
Discount = 0.05 where (Quantity >= 5 and Quantity < 10)
update OrderItems set
Discount = 0.1 where (Quantity >= 10 and Quantity < 20)
update OrderItems set
Discount = 0.15 where (Quantity >= 20 and Quantity < 90000)

--5

--update email abc@abc.com.vn cho những khách hàng mua số lượng sản phẩm trên 50

select Customers.CustomerID   
from Customers, Orders, OrderItems 
where
		Customers.CustomerID = Orders.CustomerID
		and Orders.OrderID = OrderItems.OrderID
group by Customers.CustomerID
having sum (Quantity) >= 50

update Customers set Email = 'abc@abc.com.vn' where C(
)


--6.Delete rows corresponding to customers ‘NGUYEN THI BE’ from table CustomerProducts.
Delete from CustomerProduct
where CustomerName = 'NGUYEN THI BE'

--7.	Delete order ‘Or012’ from the table Orders.
delete from OrderItems where OrderID = 'Or012'
delete from Orders where OrderID = 'Or012'