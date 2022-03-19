--LAB5A
use ProductOrders
--1.	Stored procedure for showing the details of all customers.

		create procedure SP_ShowAllCustomers
		AS
		BEGIN 
			SELECT * FROM Customers
		END

		EXECUTE SP_ShowAllCustomers

--2.	Stored procedure for showing the details of all customers 
--		by using “with encryption” option

		create procedure SP_WithEncryption
		(
			@CustormerID nvarchar(5)
		)
		WITH ENCRYPTION
		AS 
		BEGIN 
			SELECT * FROM Customers
			WHERE CustomerID = @CustormerID
		END

		EXECUTE SP_WithEncryption @CustormerID = 'C01'
		EXECUTE SP_WithEncryption @CustormerID = 'C02'
		EXECUTE SP_WithEncryption @CustormerID = 'C03'
		EXECUTE SP_WithEncryption @CustormerID = 'C04'
		EXECUTE SP_WithEncryption @CustormerID = 'C05'
		EXECUTE SP_WithEncryption @CustormerID = 'C06'

--3.	Stored procedure for showing the list of orders
--      of a given customer where CustomerID is an input parameter of the procedure.

		create procedure SP_ListOrdersByInput
		(
			@Parameter nvarchar(10) = 'C01' -- Có thể thay thế parameter
		)
		AS 
		BEGIN
			SELECT * FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID
			WHERE O.CustomerID = @Parameter
		END

		EXECUTE SP_ListOrdersByInput

--4.	Stored procedure for calculating the number of orders of a given customer where 
--		CustomerID is an input parameter of the procedure and NumberOfOrder is the output
--		parameter of the procedure.

		create procedure SP_CalTheNumberOrderInputOutPut
		(
			@CustomerID nvarchar(10),
			@NumberOfOrder int output
		)
		AS
		BEGIN
			SET @NumberOfOrder = (SELECT COUNT(*) FROM Orders WHERE CustomerID = @CustomerID)
			RETURN @NumberOfOrder
		END

		DECLARE @n INT
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C01', @NumberOfOrder = @n output
		PRINT @n
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C02', @NumberOfOrder = @n output
		PRINT @n
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C03', @NumberOfOrder = @n output
		PRINT @n
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C04', @NumberOfOrder = @n output
		PRINT @n
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C05', @NumberOfOrder = @n output
		PRINT @n
		EXECUTE SP_CalTheNumberOrderInputOutPut @CustomerID = 'C06', @NumberOfOrder = @n output
		PRINT @n

--5.	Write an example using TRY...CATCH for handling errors.
		
		create procedure SP_UsingTryCatch
		AS 
		BEGIN TRY
			insert into Customers values
			('KH100','Nguyen Van A', 'Ha noi','0345678912','')
		END TRY

		BEGIN CATCH
			print 'Something wrong'
		END CATCH

		exec SP_UsingTryCatch

--6.	Write an example using stored procedure in a query using OPENQUERY

--  OPENQUERY (linked_server ,'query')  

/*
7.	Stored procedure having CustomerID as an input parameter:
a.	Display the list (OrderID, OrderDate, ProductCode, ProductName, 
	Quantity, SellPrice) of a given customer.
b.	Calculate the total amount of all orders of the given customer 
	and return as an output parameter.
c.	Calculate the number of orders of the given customer and return
	as an output parameter.
*/
	create procedure SP_CustomerID
	(
		@CustomerID nvarchar(max),
		@totalamount float output,
		@count int output
	)
	AS
	BEGIN
		WITH A AS(SELECT o.OrderID, o.Date, p.ProductCode, p.Name, oi.Quantity, oi.SellPrice 
					FROM Orders o LEFT JOIN OrderItems oi 
					on o.OrderID = oi.OrderID
					LEFT JOIN Products p 
					on oi.ProductCode = p.ProductCode)
		SELECT * INTO #TEMP FROM A
		SET @totalamount = (SELECT SUM(Quantity*SellPrice) FROM #TEMP)
		SET @count = (SELECT COUNT(*) FROM Orders WHERE CustomerID = @customerid)
		SELECT * FROM #Temp
	END 

	DECLARE @t float, @c int
	EXECUTE SP_CustomerID 'C01', @totalamount = @t output, @count = @c output
	PRINT @t
	PRINT @c

--8.	Function for calculating the total amount of an order, where orderID 
--		is an input parameter of the function and TotalAmount is the returning
--		value of the function.
	create function [dbo].[fu_amount]   -- CREATE FUNCTION
	(@id varchar(10))	-- input parameter
	RETURNS int -- return giá trị int
	AS
	BEGIN
		DECLARE @amount int -- khai báo biến @amount
		SET @amount = (SELECT SUM(i.Quantity*i.SellPrice) FROM Orders o
		join OrderItems i on i.OrderID = o.OrderID
		WHERE o.CustomerID = @id)
		RETURN @amount
	END

	select [dbo].[fu_amount]('C01')

--9.	Function returning the list (ProductCode, ProducttName, TotalQuantity) 
--		of all products that a customer bought, where CustomerID is the input 
--		parameter of the function.

	create function [dbo].[fu_return] -- Tạo function
	(@CustomerID nvarchar(max)) -- input parameter
	RETURNS TABLE -- return table
	AS
	RETURN
	(
		SELECT p.ProductCode,p.Name, SUM(oi.Quantity) as 'TotalQuantity' FROM Products p LEFT JOIN OrderItems oi
		on p.ProductCode = oi.ProductCode 
		LEFT JOIN Orders o
		on oi.OrderID = o.OrderID
		WHERE o.CustomerID = @CustomerID
		GROUP BY p.ProductCode, p.Name
	);

	select * from [dbo].[fu_return] ('C01') -- input ở trong ngoặc mới hợp lệ

--LAB5B
--1.	Trigger to print a message “N customers are successfully inserted” 
--		when some customers are inserted into the Customers table, where 
--		N is the number of inserted customers.

	create trigger trg1_LAB5B on Customers
	AFTER INSERT
	AS
	BEGIN 
		DECLARE @count int -- khai báo count
		SET @count = (SELECT COUNT(*) FROM inserted) -- count đếm số dữ liệu đã insert
		PRINT CAST(@count as varchar(max)) + ' customers are successfully inserted' -- in ra 
	END

	INSERT INTO Customers VALUES ('KH17', 'NGUYEN VAN A', 'HA NOI', '0123456789', '')

--2.	Trigger for the insertion of a product into an order (insert into OrderItems),
--		if SellPrice < Price then do not allow the insertion (use after or for in this trigger).
	CREATE TRIGGER trg_2_LAB5B on OrderItems
	AFTER INSERT 
	AS
	BEGIN 
		-- khai báo biến @count để đếm những sản phẩm có giá lớn hơn giá bán
		DECLARE @count int = (SELECT COUNT(*) FROM inserted i JOIN Products p 
		on i.ProductCode = p.ProductCode
		WHERE p.Price > i.SellPrice )
		IF(@count > 0) -- nếu count lớn hơn 0 thì 
		BEGIN
		print 'khong duoc insert'
			ROLLBACK 
		END
	END
	INSERT INTO OrderItems VALUES ('OR001', 'P03', 15, NULL, 100)
--3.	Trigger for the update of SellPrice in OrderItems, if SellPrice < Price, then do not 
--		allow the update (use instead of in this trigger).
	CREATE TRIGGER TRG_3 on OrderItems
	INSTEAD OF UPDATE 
	AS
	BEGIN
		-- Tạo bảng tạm #temp1 lưu trữ những inserted của update mà Sellprice < Price
			SELECT i.* INTO #temp1 FROM inserted i JOIN Products p
			ON i.ProductCode = p.ProductCode
			WHERE i.SellPrice < p.Price
		-- Tạo bảng tạm #temp2 lưu trữ những inserted của những update mà SellPrice > Price
			SELECT * INTO #temp2 FROM inserted i JOIN Products p
			ON i.ProductCode = p.ProductCode
			WHERE i.SellPrice >= p.Price
		-- Khai báo biến @count
			DECLARE @count int = (SELECT count(*) FROM #temp1)
		-- #temp1 có thì không update 
			IF @count > 0 PRINT 'UPDATE NOT SUCCESS'
		--	#temp1 không có dòng nào thì ta sẽ update dùng 
		--  dữ liệu ở bảng temp2 update cho OrderItems
			ELSE 
				DECLARE @OrderId nvarchar(MAX), @ProductCode nvarchar(MAX), @SellPrice float
				BEGIN
					WHILE (SELECT COUNT(*) FROM #temp2) > 0
					BEGIN
					 -- Chọn ra TOP 1 của bảng #Temp2
						SELECT TOP 1 OrderId = @OrderID,ProductCode = @ProductCode,SellPrice = @SellPrice  FROM #temp2
					 -- UPDATE 
						UPDATE OrderItems SET SellPrice = @SellPrice WHERE  OrderID = @OrderId and ProductCode = @ProductCode
					 -- Xóa đối tượng vừa Update
						DELETE FROM #temp2 WHERE OrderID = @OrderId and ProductCode = @ProductCode
					END
				END
	END
--4.Trigger for the insertion of a product into an order (insert into OrderItems):
--If Quantity > StockQuantity, then refuse the insertion.
create trigger trg_4 on OderItems
after insert
as
begin
	declare @count int  =(select COUNT(*) from inserted
	join Products on inserted.ProductCode = Products.ProductCode
	where inserted.Quantity > Products.StockQuantity)
	if(@count > 0)
	begin
		print 'Khong insert vao bang OrderItems do Quantity > StockQuatity'
		rollback 
	end
--If Quantity <= StockQuantity, then update the StockQuantity of the corresponding product 
--(StockQuantity = StockQuantity - Quantity)


