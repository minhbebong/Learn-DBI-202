use ProductOrders

--1.Find all Products in the database
select * from Products

--2Find the name and the phone number of all customers who live in ‘Ha Noi’
select Name,Phone from Customers
where Address = 'Ha Noi'

--3.	Show the Name, Price, StockQuantity and Amount (which is equal to StockQuantity * Price) of all Products having Amount < 20000.
select Name, Price, StockQuantity, Amount = (StockQuantity * Price) from Products
where (StockQuantity * Price > 2000)

--4.	Find all customers who lives in ‘Ha Noi’ or ‘Ho Chi Minh’
select * from Customers
where Address = 'Ha Noi' or Address = 'Ho Chi Minh'

--5.	Find all Products having 10<= Price <= 45
select * from Products
where 10 <= Price and Price <= 45

--6.	Find all customers who have a phone number.
select * from Customers
where Phone != '' and Phone is not null
 --C2:
select * from Customers
where Phone is not null and ISNUMERIC (Phone) !=0
update Customers
set Phone=''
where CustomerID = 'C01'

--7.	Find months and years in which customer ‘C01’ made at least an order.
select MONTH(Date) as 'months' ,YEAR(Date) as'Year' from Orders
where CustomerID = 'C01'

--7b. hiện mã customer của tất cả khác hang mua hàng ít nhất 2 lần
WITH
T AS (
    SELECT CustomerID, COUNT(1) AS 'OrderCount'
    FROM Orders
    GROUP BY CustomerID
)
SELECT CustomerID
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM T
    WHERE OrderCount >= 2
)

SELECT CustomerID
    FROM Customers
    where CustomerID in (select CustomerID from Orders
                       GROUP BY CustomerID
                       having COUNT (1) >= 2)

--8.	Find all customers whose name begin with ‘TRAN ‘.
select * from Customers
where Name like 'TRAN %'

--9.	Find all LCD monitor products.
select * from Products
where Name = 'LCD monitor'

--10.	Find the CustomerID of all customer who made orders in May 2020.
-- Sử dụng DISRINCT để các kết quả không bị trùng nhau
select  DISTINCT CustomerID from Orders
where MONTH(Date) = '5'and
year(Date) = 2020

--10b.	Find the CustomerID of all customer who made orders in May 2020., price > 2000
select DISTINCT o.CustomerID from Orders o
		join Customers as c on c.CustomerID = o.CustomerID
		join OrderItems as oi on o.OrderID = oi.OrderID
		join Products as p on p.ProductCode= oi.ProductCode
where MONTH(Date) = '5'and
year(Date) = 2000 and Price > 20

--11.	List all Products by descending order of Price.
select * from Products order by Price desc

--12.	List all customer by descending order of Address, with customers having same address we order by ascending order of Name.
select * from Customers
order by Address desc, Name asc
--13.	Find the product with the highest Price.
select * from Products
where Price = (select max(Price) from Products)

--1.	Find OrderID, Date, CustomerID, CustomerName, Address, Phone, Email of all orders.
select O.OrderID, O.Date, O.CustomerID, c.Name, c.Email, C.Phone from Customers C
join Orders O on C.CustomerID = O.CustomerID

--2.	List all orders of all customers including CustomerID, CustomerName, OrderID, Date. Order the result by descending order of CustomerName (Note that we need to know also the customer who have no order). Try to use left outer join for this question.
Select c.CustomerID, c.Name, o.OrderID, o.Date from Customers c 
		LEFT JOIN Orders o
		on c.CustomerID = o.CustomerID
		order by [Name] desc
--3.	List CustomerID of all customers who have never bought any product.
select CustomerID from Customers c
where c.CustomerID not in (select CustomerID from Orders) 

--4.	Do the intersect between the list of CutomerID from Customers and the list of CustomerID from Orders? How many rows in the output?
with a as
(select CustomerID from Customers
intersect
select CustomerID from Orders)
select COUNT(*) from a

--5.	Do the union between the list of CutomerID from Customers and the list of CustomerID from Orders? How many rows in the output?
with c5 as(
select CustomerID from Customers
union
select CustomerID from Orders)
select COUNT(*) from c5

--6.	Do the union all between the list of CutomerID from Customers and the list of CustomerID from Orders? How many rows in the output?
with c6 as(
select CustomerID from Customers
union all
select CustomerID from Orders)
select COUNT(*) from c6
--7.	List all orders of ‘NGUYEN THI BE’ and ‘LE VAN SANG’, 
--		including CustomerID, CustomerName, OrderID, Date; ordered by CustomerName.
select c.CustomerID, c.Name, o.OrderID,o.Date from Customers c 
join Orders o on c.CustomerID = o.CustomerID
where c.Name like 'NGUYEN THI BE' or c.Name like 'LE VAN SANG'
--8.	List OrderID, ProductCode, ProductName, Price, SellPrice, SoldQuantity, 
--		Profit ((SellPrice - Price)*SoldQuantity) by ascending order of OrderID.
select oi.OrderID, oi.ProductCode,p.Name, p.Price,oi.SellPrice,
oi.Quantity,((oi.SellPrice - p.Price) * oi.Quantity) as 'Profit'
from OrderItems oi 
join Products p 
on oi.ProductCode = p.ProductCode
order by OrderID
--9.	List CustomerID, CustomerName, OrderID, ProductCode, ProductName, Price, SellPrice, 
--		SoldQuantity, Profit ((SellPrice - Price)*SoldQuantity) by ascending order of CustomerName.
select cu.CustomerID, cu.Name, oi.OrderID, oi.ProductCode, p.Name, p.Price, oi.SellPrice, 
		oi.Quantity, ((oi.SellPrice - p.Price)*oi.Quantity) as 'Profit' 
from Products p
join OrderItems oi on p.ProductCode = oi.ProductCode
join Orders		o  on o.OrderID = oi.OrderID
join Customers  cu on cu.CustomerID = o.CustomerID
--10.	List 5 OrderItems having the highest profit (profit = (SellPrice - Price)*Quantity).
Select top 5 oi.* from OrderItems oi JOIN Products p
		on oi.ProductCode = p.ProductCode
		ORDER BY ((oi.SellPrice - p.Price)*oi.Quantity) desc 

SELECT TOP 5 *, Profit = ( (SellPrice - Price)* Quantity) 
FROM OrderItems oi
JOIN Products p ON oi. ProductCode = p. ProductCode 
ORDER BY Profit DESC
--11.	List all products (ProductCode, ProductName) bought by both ‘NGUYEN THI BE’ and ‘MAI THI QUE ANH’.
select distinct p.ProductCode, p.Name from Customers as c
		join Orders as o on c.CustomerID = o.CustomerID
		join OrderItems as oi on o.OrderID = oi.OrderID
		join Products as p on p.ProductCode= oi.ProductCode
		where (c.Name != 'NGUYEN THI BE' and c.Name = 'MAI THI QUE ANH')
		Intersect
		select distinct p.ProductCode, p.Name from Customers as c
		join Orders as o on c.CustomerID = o.CustomerID
		join OrderItems as oi on o.OrderID = oi.OrderID
		join Products as p on p.ProductCode= oi.ProductCode
		where (c.Name = 'NGUYEN THI BE' and c.Name != 'MAI THI QUE ANH')
--12.	List all products with highest price (Note that there could have many products with the highest price). You should not use the aggregate function max().
select * from Products
		where price = (select top 1 price from Products order by price DESC)
--Hiến thị tất cả sản phẩm có giá cao nhất trong số những sản phẩm có số lượng trong kho nhỏ hơn 500
update Products
set Price = 219
where ProductCode in ('P02', 'P03')
---
select * from Products
where Price = (select max(Price) from Products where StockQuantity < 500)
and StockQuantity < 500

--[III]
--1.	List all products having Price smaller than the price of product ‘P05’
select * from Products
where Price < (select Price from Products where ProductCode = 'P05')
--2.List all customers who have made an order by using EXISTS in WHERE clause.
select * from Customers
where  exists( select CustomerID from Orders where Customers.CustomerID = Orders.CustomerID)
--3.	List all customers who have never made an order by using NOT EXISTS in WHERE clause
select * from Customers
where  not exists( select CustomerID from Orders where Customers.CustomerID = Orders.CustomerID)
--4.	List all customers who have made an order by using IN in WHERE clause.
select * from Customers
where CustomerID in(select CustomerID from Orders)
--5.	List all customers who have never made an order by using NOT IN in WHERE clause
select * from Customers
where CustomerID not in(select CustomerID from Orders)

--Hiển thông tin của tất cả các khách hàng có họ là LÊ
--và đã từng đặt hàng 
select * from Customers c
join Orders o on C.CustomerID = O.CustomerID
where c.Name like 'Le_%'

--6.	List all products bought in order ‘Or002’

--7.	List all products having Price greater than all the prices of ‘Keyboard’ and ‘Mouse’
select * from Products
where Price > (select Price from Products where Name = 'Keyboard')
and Price > (select Price from Products where Name = 'Mouse')

--8.	List all products having price greater than the prices ‘Keyboard’ or ‘Mouse’
select * from Products
where Price > (select Price from Products where Name = 'Keyboard')
or Price > (select Price from Products where Name = 'Mouse')

--9.	List all products which have been bought by customer ‘NGUYEN THI BE’ (Nguyễn Thị Bé).
select * from Products
where ProductCode in (select ProductCode from CustomerProduct
where Name = 'Nguyen Thi Be')

--9b. 

 --10
 select * from Products
 where Price > (select AVG(Price) from Products)




