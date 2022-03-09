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
select * from