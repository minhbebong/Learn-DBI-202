--Tạo 1 script mới và save lại là Script_Select_SE1623
--Câu lệnh select trong SQL : 
--Truy vấn và thống kê dữ liệu(chọn , chiếu , join , rename,..)
--Cú pháp tổng quát : theo đúng thứ tự dưới đây
-- Select *,[Liệt kê các column cần hiển thị]
--From[tên bảng]
--Where [điều kiện lọc]
--Order by [tên cột muốn sắp xếp]  ASC|DESC
--Group by [những cột muốn group]
--Having [điều kiện của mỗi group]

--1.câu lệnh select from đơn giản
--*:liệt kê tất cả các cột theo đúng thứ tự trong bảng 
--Nếu chỉ muốn liệt kê ra một số cột mong muốn thì chỉ cần viết tên cột cần hiển thị ra
--VD1:Lấy ra tất cả các thông tin của các bảng của db PMSystem
select * from Categories
select * from Products
select * from Customers
select * from Employees
select * from Orders
select * from [Order Details]

--Chỉ lấy ra mã , tên unitprice của tất cả các sản phẩm
select ProductID, ProductName, UnitPrice from Products

--Lấy ra mã nv, tên nv, địa chỉ của tất cả nhân viên
select 
EmployeeID as 'Mã nhân viên',--rename --> alias
FirstName 'Tên nhân viên',
Address 'Địa chỉ'
from Employees

--Lấy ra 5 sản phẩm đầu tiên trong kho
select top 5 * from Products

--Lấy ra các mã order của tất cả trong bảng orderdetail
select distinct OrderID from [Order Details]
--distinct cái nào trùng thì sẽ cần lấy ra một 

--Lấy ra tất cả thông tin ở bảng orderDetail 
--Tính ra ở mỗi dòng detail số tiền cần thanh toán là bn
select *,Quantity * UnitPrice as'Amount' from [Order Details]
--Phép chiếu mở rộng

--Tìm xem ra cao nhât trong bảng Product
select max(UnitPrice) as 'Max price' from Products

--Tương tự sẽ có một số hàm sau : sum, avg, count(đếm)
--Practise
--1.Tìm số lượng thấp nhất của sp trong kho
select min(QuantityPerUnit) as 'số lượng thấp nhất' from Products
--2. Có bao nhiêu sp trong bảng product
select count(*) from Products
--3.Có bao nhiêu sp đã bán
select sum(UnitPrice) from [Order Details] where Quantity
--4.Gía bán trung bình tất cả các hóa đơn là bao nhiêu
select avg(UnitPrice) as 'Gía trung bình' from [Order Details]
--5. Tổng số tiền thu được khi bán hàng
select sum(UnitPrice) as 'Tổng tiền thu' from [Order Details] where Quantity

