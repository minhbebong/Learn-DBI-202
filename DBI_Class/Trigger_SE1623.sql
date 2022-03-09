--TRIGGER
--Khi chúng ta sửa đổi data trong 1 table nào đó thì trigger được tự động kích hoạt
-->Thao tác sửa đổi data: insert, delete, update(thực tế là delete, update)
--Khi insert thì dữ liệu sẽ được lưu vào một bảng tạm có tên là inserted
--Khi delete thì dữ liệu sẽ được lưu vào 1 bnagr tạm có têm là deleted
--Khi update thì dữ liệu sẽ được lưu vào 1 bảng tạm có tên deleted sau đó inserted
--VD1: Khi insert vào bảnrg Customer thì sẽ tự động hiển thị những bảng ghi vừa insert
--và hiện ra dòng 'insert thành công!'
insert into Customers values ('KH10','Nguyen Van A', 'Ha Noi','0123456789','abc@gmail.com')
insert into Customers values ('KH11','Nguyen Van B', 'Ha Noi','0123456789','abc@gmail.com')
insert into Customers values ('KH12','Nguyen Van C', 'Ha Nam','0123456789','abc@gmail.com')
CREATE TRIGGER trg_insertCustomer on Customers
	AFTER INSERT 
	AS
	BEGIN 
		SELECT * FROM inserted
		print 'Insert thanh cong'
	END

--ví dụ 2: Khi delete dữ liệu trong bảng Customer thì tự động hiển thị số lượng
--bản ghi đã xóa
delete from Customers where customerid in ('KH10', 'KH12')
create trigger trg_deleteCustomer on Customers
after delete
as
begin
	declare @count int =(select count(*) from deleted)
	print @count
end

--VD3: Khi update dữ liệu cho bảng product thì tự động hiển thị thông tin trước
--và sau khi update
create trigger trg_updateProDuct on Products
after update
as
begin
	select * from deleted
	select * from inserted
end

update products set Name='Mouse optical' where productcode='P03'

--Practise
--1.
--Tạo 1 table hist_order , bao gồm các trường giống table Order + EditDate(lấy giờ system)
--Tạo trigger để khi thay đổi thông tin trong bảng hoá đơn thì tự động insert những thông tin 
--vào bảng hist_Order
Create table hist_Order
(
	OrderID nvarchar(10) not null,
	Date smalldatetime
)
select * from Orders
create trigger trg_editOrderHist on Orders
after insert, delete , update
as
begin
	--Insert thong tin vào bảng hist_Order
	insert into hist_Order
		select *,GETDATE() from deleted
		union
		select *,GETDATE() from inserted
end
--2.Tạo trigger để khi thay đổi thông tin trong bảrng product thì sẽ kiểm tra:
--nếu peice < Stockquantity thì sẽ không cho thay đổi (Rollback)
	