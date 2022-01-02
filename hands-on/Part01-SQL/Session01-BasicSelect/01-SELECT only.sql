USE Northwind -- Chọn để chơi với thùng data nào đó
			  -- tại 1 thời điểm chơi với 1 thùng chứa data
SELECT * FROM Customers

SELECT * FROM Employees
---------------------
--Lí thuyết
--1.DBE cung cấp câu lệnh SELECT để
-- in ra màn hình 1 cái gì đó ~~ printf() sout()
-- in ra dữ liệu có trong table (hàng/cột) !!!!!
-- dùng cho mục đích nào thì kết quả hiển thị luôn là 1 table
---------------------

-- 1.Hôm nay ngày bao nhiêu ??
SELECT GETDATE()

SELECT GETDATE() AS [Hôm nay là ngày]

-- 2.Bây giờ tháng mấy ?
SELECT MONTH(GETDATE()) AS[Bây giờ tháng mấy ?]

SELECT YEAR(GETDATE())

-- 3.Trị tuyệt đối của -5 là bn
SELECT ABS(-5) AS[Trị tuyệt đối của -5 là bn]

--4. 5 + 5 là mấy ??
SELECT 5 + 5 AS[5 + 5 LÀ ...]

-- 5.In ra tên của mình 
SELECT N'Nguyễn Đình Minh' AS[My fullname is]
SELECT N'Nguyễn' + N'Đình Minh' AS [My fullname is]

-- 6 Tính tuổi 
SELECT YEAR(GETDATE()) - 2001
-- SELECT N'Hoàng' +  N'Ngọc Trinh ' + (YEAR(GETDATE()) - 2001) + ' years old'  LỖI VÌ LỘN XỘN KIỂU DATA

SELECT N'Nguyễn' +  N'Đình Minh ' + CONVERT(VARCHAR,  YEAR(GETDATE()) - 2001)  + ' years old' AS [My profile]

SELECT N'Nguyễn' +  N'Đình Minh ' + CAST(YEAR(GETDATE()) - 2001 AS varchar)  + ' years old' AS MyProfile

--7.Phép nhân 2 số 
SELECT 10 * 10 AS[10 X 10 = ]

