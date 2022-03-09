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

--mệnh đề Where
--Sau mệnh đề where sẽ là điều kiện lọc
--Các phép so sánh > < >= <= =
--Nếu có từ 2 điều kiện trở nên thì sử dụng thêm or, and

--Hiển thị những sp có giá bán > 20
select * from Products
where UnitPrice > 20

--Hiển thị những sp có giá  <= 20 nhưng có số lượng lớn hơn 50
select * from Products
where UnitPrice <= 20 and UnitsInStock > 50

--Điều kiện LIKE sử dụng cho điều kiện liên quan đến chuỗi
---VD 1 lấy ra những nhân viên có họ là "Fuller"
--Cách 1
select * from Employees
where LastName = 'Fuller'
--Cách 2
select * from Employees
where LastName like 'Fuller'

--VD 2 lấy ra những nhân viên có họ bắt đầu bằng kí tự 'D'
select * from Employees
where LastName like 'D%' 
--Kí tự % là đại diện cho nhiều kí tự 

--VD3: Nhân viên có họ kết thúc bởi kí tự'an'
select * from Employees
where LastName like '%an' 

--VD4 : Nhân viên mà kí tự 2 của tên là 'a'
select * from Employees
where FirstName like '_a%'
--Kí tự '_' đại diện cho một kí tự

--VD 5 : Nhân viên mà kí tự áp chót của tên là c
select * from Employees
where FirstName like '%c_'

-- Các hàm hay sử dụng trong mệnh đề Where
-- len: độ dài kí tự 
-- month, day , year: tháng , ngày , năm của trường datetime
--VD 1: Những nhân viên họ có độ dài là 7 kí tự
select * from Employees
where len(Lastname) = 7

--VD 2: NHân viên sinh vào năwm 1958
select * from Employees
where year(BirthDate) = 1958

--VD3:Nhân viên trên 60 tuổi
select * from Employees
where year(GETDATE()) - year(BirthDate) > 60 

--VD 4: Nhân viên sinh vào tháng chẵn
select * from Employees
where MONTH(BirthDate) = 2
or  MONTH(BirthDate) = 4
or  MONTH(BirthDate) = 6
or  MONTH(BirthDate) = 8
or  MONTH(BirthDate) = 10
or  MONTH(BirthDate) = 12
-- C2: 
select * from Employees
where MONTH(BirthDate) % 2 = 0 

--VD 5 NHân viên sinh vào các ngày từ 10 đến 20 hàng tháng
select * from Employees
where DAY(BirthDate) in (10,11,12,13,14,15,16,17,18,19,20)
--C2:
select* from Employees
where day(BirthDate) >=10 and day(BirthDate) <=20
--C3: 
select * from Employees
where day (BirthDate) between 10 and 20

--VD 6: Nhân viên có tên chứa hai kí tự 'an'
select * from Employees
where FirstName like '%an%'

--Ví dụ 7: Nhân viên có họ mà chứa 2 ký tự 'a' mà ở giữa có chúa ký tự 'n' hoặc 'm'
select * from Employees
where LastName like '%ana%' or LastName like '%ama%'
--C2:
select * from Employees
where LastName like '%a [nm]a%'

--Ví dụ 8: Nhân viên có họ mà chứa 2 ký tự 'a' mà ở giữa có chúa 2 ký tự 'nm' hoặc 'mn'
select * from Employees
where LastName like '%anma%' or LastName like '%amna%'

--Ví dụ 9: Nhân viên có tên mà chứa 2 ký tự 'a' mà ở giữa có chúa 2  ký tự thuộc('r','g','u')
select * from Employees
where FirstName like '%a[rgu][rgu]a%' 

--vd 10 Những nhân viên đã lập hóa đơn và có ngày sinh vào tháng 8
select * from Employees
where MONTH(BirthDate) = 8
and EmployeeID in ( select EmployeeID from Orders)

--Mệnh đề orderby - sắp xếp
--vd1 : Hiển thị thông tin sản phẩm theo chiều tăng dần của giá
select * from Products
order by UnitPrice 

--VD2: Hiển thị 10 sản phẩm có giá cao nhất
select top 10 * from Products
order by UnitPrice desc

--VD3: Hiển thị 5 sản phẩm có giá thấp nhất
select top 5 * from Products
order by UnitPrice

--VD4 : Hiển thị 3 sp có số lượng thấp nhất , 3 sp có số lượng cao nhất
select top 3 * from Products
order by UnitsInStock
union 
select top 3 * from Products
order by UnitsInStock desc

---> giải quyết vấn đề k thể union
with t1 as (select top 3 * from Products
order by UnitsInStock),
t2 as (select top 3 * from Products
order by UnitsInStock desc)

select * from t1
union 
select * from t2

--Hiển thị 5 sản phẩm có số lượng cao thứ 2 trong kho
with t3 as (select top 10 * from Products
order by UnitsInStock),
t4 as (select top 5 * from Products
order by UnitsInStock desc)

select * from t3
except
select * from t4

--Practise:
--1. Tìm những khách hàng đến từ Đức
select * from Customers
where Country = 'Germany'

--2. Tìm những khách hàng đã mua hàng
select * from Customers
where CustomerID in ( select CustomerID from Orders)

--3. Hiển thị những hóa đơn vào tháag lẻ
select OrderDate from Orders
where MONTH(OrderDate) in (1,3,5,7,9,11)

--4. Có bao nhiêu khách hàng order vào ngày chẳn
select count(OrderDate) from Orders
where day(OrderDate) % 2 = 0 and CustomerID in ( select CustomerID from Customers) 

--5. số lượng sản phẩm có giá nằm trong khoảng [50,100]
select * from Products
where UnitsInStock between 50 and 100

--6. Sản phẩm nào có giá cao nhất
select MAX(UnitPrice) from Products 
select * from Products order by UnitPrice desc

--7. Sản phẩm nào có số lượng trong kho thấp nhất
select  min(UnitsInStock) from Products
select * from Products order by UnitsInStock
--8. Tính tuổi trung bình của những nhân viên có tên bắt đầu 'M'
select avg(BirthDate) from Employees
where FirstName like 'M%'
and YEAR(GETDATE() - birthdate)

--9. Nhân viên nào nhiều tuổi nhất
select top 1 * from Employees
order by year(GETDATE() - birthdate)

--10. Hiển thị 5 sản phẩm có tên chứa ký tự 'a' có giá thấp nhất 
--và 5 sản phẩm không chúa ký tự 'b' có giá cao nhất
with t1 as (select top 5 * from Products where ProductName ='a'
order by UnitPrice desc),
t2 as (select top 5 * from Products where ProductName = 'b'
order by UnitPrice)
select * from t1
union 
select * from t2

--Join giữa các bảng
select * from Categories
select * from Products

--VD Hiêển thị mã Sp, Tên Sp, Tên danh mục
--C1
select Products.ProductID,
Products.ProductName,
Categories.CategoryName
from Products
inner join Categories on Products.CategoryID = Categories.CategoryID

--C2
select P.ProductID,
P.ProductName,
C.CategoryName
from Products P ,Categories C
where P.CategoryID = C.CategoryID

--VD2:Hiển thị mã ,tên nhân viên đã từng lập hóa đơn bán hàng
--C1: k dùng join mà dùng IN
select EmployeeID, FirstName from Employees
where EmployeeID in (select EmployeeID from Orders)

--C2: Dùng Join
Select distinct E.EmployeeID,
E.FirstName
from Employees E,Orders O
where E.EmployeeID = O.EmployeeID

--C3: 
Select E.EmployeeID,
E.FirstName from Orders O
left join Employees E  ON O.EmployeeID = E.EmployeeID

--C4
Select distinct E.EmployeeID,
E.FirstName from Employees E
right join Orders O ON O.EmployeeID = E.EmployeeID

--VD3: Tìm những khách hàng order trước ngày "1996-07-10"
select * from Customers C
join Orders O on C.CustomerID = O.CustomerID
where O.OrderDate < '1996-07-10'

--Group By - Gom nhóm 1 số trường
--VD 1: Gom nhóm nhân viên theo cách xưng hô, số lượng nhân viên
--trung bình số tuổi của từng nhóm
select TitleOfCourtesy, count(*) as 'Số lượng', 
avg(year(getdate())- year(BirthDate)) 'Trung bình tuổi'
from Employees
group by TitleOfCourtesy

--VD 2: Gom nhóm theo quốc gia số lượng nhân viên của từng nước
select Country,
COUNT(*) 'Số lượng'
from Employees
group by Country

--VD3:Gom nhóm nhân viên theo xưng hô, tính tổng số tuổi cùng từng nhóm xưng hô là 
--'Mr', 'Mrs' và đến từ nước 'USA' 
select TitleOfCourtesy, 
sum(year(getdate())- year(BirthDate))' Tổng số tuổi'
from Employees
where Country ='USA'and TitleOfCourtesy in ('Mr.', 'Mrs.')
group by TitleOfCourtesy

--C2
select TitleOfCourtesy,
SUM (YEAR (getdate ())-year (birthdate)) 'Tổng tuổi'
from
	(select *
	from Employees
	where Country='USA' and TitleofCourtesy IN ('Mr.','Mrs.')) as temp
group by TitleOfCourtesy

-- C3
--Sai vì group by không liên quan đến country
select TitleOfCourtesy, 
sum(year(getdate())- year(BirthDate))' Tổng số tuổi'
from Employees
group by TitleOfCourtesy
having Country ='USA'and TitleOfCourtesy in ('Mr.', 'Mrs.')

--VD4: Gom nhóm nhân viên theo xưng hô, tính tổng số tuổi cùng từng nhóm xưng hô là 
--'Mr', 'Mrs'
select TitleOfCourtesy, 
sum(year(getdate())- year(BirthDate))' Tổng số tuổi'
from Employees
where TitleOfCourtesy in ('Mr.', 'Mrs.')
group by TitleOfCourtesy

select TitleOfCourtesy, 
sum(year(getdate())- year(BirthDate))' Tổng số tuổi'
from Employees
group by TitleOfCourtesy
having TitleOfCourtesy in ('Mr.', 'Mrs.')

--VD4: Gom nhóm nhân viên theo xưng hô, tính tổng số tuổi cùng từng nhóm xưng hô là 
--'Mr', 'Mrs'mà tổng số tuổi > 100
--C1 using where
-- Sai vì trong where có chứa thông tin không liên quan gì đến các trường 
--trong bảng employees
select TitleOfCourtesy, 
sum(year(getdate())- year(BirthDate))' Tổng số tuổi'
from Employees
where TitleOfCourtesy in ('Mr.', 'Mrs.') and sum(year(getdate())- year(BirthDate)) > 100
group by TitleOfCourtesy

select TitleOfCourtesy, 
sum(year(getdate())- year(BirthDate))' Tổng số tuổi'
from Employees
group by TitleOfCourtesy
having TitleOfCourtesy in ('Mr.', 'Mrs.') and sum(year(getdate())- year(BirthDate)) > 100

--Practise:
--1. Hiển thị tên thành phố và số lượng customer ở từng thành phố, với điều kiện số lượng
--    customer > 5
select City,
COUNT(CustomerID) 'Số lượng Customer'
from Customers
group by City
having COUNT(CustomerID) > 5
-- 2. Hiển thị OrderID và tổng số sản phẩm bán được trong mỗi Order
select OrderID,
count(ProductID) 'Tổng số Sản Phẩm'
from [Order Details]
group by OrderID
-- 3. Hiện thị OrderID và tổng thành tiền của mỗi Order
select OrderID,
sum(UnitPrice) 'Tổng mỗi Order'
from [Order Details]
group by OrderID
-- 4. Hiển thị mã sản phẩm, tên sản phẩm và số lượng đã bán tương ứng.
select OrderID,
ProductID,
COUNT(ProductID)
from [Order Details]
group by OrderID, ProductID








