--Store Procedure: căn bản giống với hàm trong lập trình, 
--dùng để gom nhóm nhiều câu lệnh SQL để thực hiện một nhiệm vụ chung nào đấy
--Cách tạo ra store:
--Loại 1: Không tham số, không có giá trị trả về
create procedure sp_getCustomer
as
begin
	--Chứa các câu lệnh SQL
	select * from Customers
end

--Sử dụng store ntn?
exec sp_getCustomer

--Loại 2: Có tham số nhưng kh có giá trị trả về
create procedure sp_getCustomerById
@id varchar(10)
as
begin
	select * from Customers
	where CustomerID=@id
end

exec sp_getCustomerbyId 'ANTON'

--Loại 3: Có tham số , có giá trị trả về
create procedure sp_countCustomerByCountry
@country varchar(20),--Tham số truyền vào
@count int output --Biến chứa giá trị trả về
as
begin
	set @count =(select COUNT(*) from Customers where Country=@country)
	return @count;
end

--Gọi store trên và in ra kết quả 
declare @c int
exec sp_countCustomerByCountry 'USA',@count = @c output
print @c

--Store nâng cao : Chỉ là tập hợp của nhiều câu lệnh SQL
--và cú pháp lập trình SQL , để liên kết và sử dụng các câu lệnh
--SQL để xửr lí dữ liệu
--CÚ PHÁP :
--1:Khai báo , khởi tạo giá trị cho biến
declare @n int;
set @n = 10;

--2.Câu lệnh if
--Kiểm tra xem n là số không , số dương, số âm
if @n > 0
begin
	print 'n la so duong'
end
else
begin
	if @n<0
	begin
		print'n la so am'
	end
	else
	begin
		print 'n la so khong'
	end
end

--3. Câu lệnh while:
--Hiển thị các số chẵn từ 1 đến n
declare @i int=1;
while @i <= @n
begin
	if @i % 2 = 0
	begin
		print @i;
	end
	set @i=@i +1;
end

--Tạo store để xử lí câu 5 trong lap3
use ProductOrders

select * from Orders
select * from OrderItems
update Orders set Amount = 0

drop procedure sp_Q5
Create procedure sp_Q5
as
begin
	with t as(select OrderID,SUM((1 - Discount) * Quantity * SellPrice) as Amount 
	from OrderItems group by OrderID)
	
	--Sao chép tất cả dữ liệu của bảng t vào bảng temp
	select *
	into #temp
	from t

	declare @id varchar(10);
	declare @a float;
	while (select COUNT(*) from #temp) > 0
	begin
		select @id=OrderID,@a=Amount from #temp
		--update amount cho order tương ứng
		update Orders set Amount = @a where OrderID = @id
		delete #temp where orderid=@id
	end
	print 'Update thanh cong!'
end
-- Thao tác Store
exec sp_Q5

]--Practise: làm trên db của Lab3
--1.Storel:
--Param:
--Content: Hiển thị các hóa đơn mua trước ngày 1/1/2021
create procedure sp_Store1
as
begin
	Select * from Orders
	where Date < '1/1/2021'
end
exec sp_Store1
select * from Orders
exec sp_Store1
--2.store2:
--Param: SellDate
--Content: Trả về số lượng hóa đơn mua sau ngày <Param>
	drop procedure sp_Store2
	create procedure sp_Store2
	@SellDate date,
		@Count int output 
	as 
	begin 
		set @Count =
		(Select * from OrderItems os join Orders o
		on o.OrderID = os.OrderID)

		return @Count
	end
	exec sp_Store2
	Select * from OrderItems
	Select * from Orders
--3.Store3:
--Param: name,phone
--Content: Get tất cả Customer có name và phone bằng với tham số truyền vào
	create procedure sp_Store3
	@Name name nvarchar(30),
	@Phone phone varchar(10)
	as
	begin
	
	end

--4.Store4:
--Param: Address
--Content: Get ra những customer có địa chỉ như tham số và đã từng mua hàng



