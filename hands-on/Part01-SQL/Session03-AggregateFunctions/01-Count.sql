USE Northwind

-------------------------------------------------------------------------------------
-- LÍ THUY?T
-- DB ENGINE h? tr? 1 lo?t nhóm hàm dùng thao tác trên nhóm dòng/c?t, gom data tính toán
-- trên ?ám data gom này - nhóm hàm gom nhóm  - AGGREGATE FUNCTIONS, AGGREGATION
-- COUNT() SUM() MIN() MAX() AVG()

-- * CÚ PHÁP CHU?N
-- SELECT C?T..., HÀM GOM NHÓM(),... FROM <TABLE>

-- * CÚ PHÁP M? R?NG

-- SELECT C?T..., HÀM GOM NHÓM(),... FROM <TABLE>...WHERE... GROUP BY (GOM THEO C?M C?T NÀO)

-- SELECT C?T..., HÀM GOM NHÓM(),... FROM <TABLE>...WHERE... GROUP BY (GOM THEO C?M C?T NÀO) HAVING...

-- * HÀM COUNT(???) ??M S? L?N XU?T HI?N C?A 1 CÁI GÌ ?Ó???
--       COUNT(*):  ??M S? DÒNG TRONG TABLE, ??M T?T C? CÁC DÒNG KO CARE TIÊU CHU?N NÀO KHÁC
--       COUNT(*) FROM... WHERE ...
--                  CH?N RA NH?NG DÒNG TH?A TIÊU CHÍ WHERE NÀO ?Ó TR??C ?Ã, R?I M?I ??M
--                  FILTER R?I ??M  
--
--       COUNT(C?T NÀO ?Ó): 

-------------------------------------------------------------------------------------
--1. In ra danh sách các nhân viên
SELECT * FROM Employees

--2. ??m xem có bao nhiêu nhân viên
SELECT COUNT(*) FROM Employees
SELECT COUNT(*) AS [Number of employees] FROM Employees

--3. Có bao nhiêu NV ? London
SELECT COUNT(*) FROM Employees WHERE City = 'London'
SELECT COUNT(*) AS NoempsinLondon FROM Employees WHERE City = 'London'

--4. Có bao nhiêu l??t thành ph? xu?t hi?n - c? xh tên tp là ??m, ko care l?p l?i hay ko
SELECT COUNT(City) FROM Employees --9

--5. ??m xem có bao nhiêu Region
SELECT COUNT(Region) FROM Employees --
-- PHÁT HI?N HÀM COUNT(C?T), N?U CELL C?A C?T CH?A NULL, KO TÍNH, KO ??M

--6. ??m xem có bao nhiêu khu v?c null, có bao nhiêu dòng region null
SELECT COUNT(*) FROM Employees WHERE Region IS NULL -- ??m s? xh dòng ch?a Region null

SELECT COUNT(Region) FROM Employees WHERE Region IS NULL --0 null ko ??m ?c, ko value
SELECT * FROM Employees WHERE Region IS NULL

--7. Có bao nhiêu thành ph? trong table NV
SELECT * FROM Employees

SELECT City FROM Employees --9
SELECT DISTINCT City FROM Employees --5
-- tui coi k?t qu? trên là 1 table, m?t quá tr?i công s?c l?c ra 5 tp

-- SUB QUERY M?I, COI 1 CÂU SELECT LÀ 1 TABLE, BI?N TABLE NÀY VÀO TRONG M?NH ?? FROM
-- NGÁO
SELECT * FROM   
         (SELECT DISTINCT City FROM Employees) AS CITIES   

SELECT COUNT(*) FROM   
         (SELECT DISTINCT City FROM Employees) AS CITIES   --5 

SELECT COUNT(*) FROM Employees --9 NV
SELECT COUNT(City) FROM Employees --9 City

SELECT COUNT(DISTINCT City) FROM Employees --5

--8. ??m xem M?I thành ph? có bao nhiêu nhân viên
-- KHI CÂU H?I CÓ TÍNH TOÁN GOM DATA (HÀM AGGREGATE) MÀ L?I CH?A T? KHÓA M?I....
-- G?P T? "M?I", CHÍNH LÀ CHIA ?? ??M, CHIA ?? TR?, CHIA C?M ?? GOM ??M
SELECT * FROM Employees

--Seatle 2 | Tacoma 1 | Kirland 1 | Redmon 1 | London 4
-- S? xu?t hi?n c?a nhóm
-- ??m theo s? xh c?a nhóm, count++ trong nhóm thoy, sau ?ó reset ? nhóm m?i
SELECT COUNT(City) FROM Employees GROUP BY City ---??M VALUE C?A CITY, NH?NG ??M THEO NHÓM 
                                                -- CHIA CITY THÀNH NHÓM, R?I ??M TRONG NHÓM

SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City 
 
SELECT EmployeeID, City, COUNT(City) AS [No employess] FROM Employees GROUP BY City, EmployeeID
--vô ngh?a, chia nhóm theo key, mssv vô ngh?a


--CH?T H?: KHI XÀI HÀM GOM NHÓM, B?N CÓ QUY?N LI?T KÊ TÊN C?T L? ? SELECT 
--         NH?NG C?T L? ?Ó B?T BU?C PH?I XU?T HI?N TRONG M?NH ?? GROUP BY 
--         ?? ??M B?O LOGIC: C?T HI?N TH? | S? L??NG ?I KÈM, ??M GOM THEO C?T HI?N TH? M?I LOGIC
-- C? THEO C?T CITY MÀ GOM, C?T CITY N?M ? SELECT H?P LÍ 
-- MU?N HI?N TH? S? L??NG C?A AI ?Ó, GÌ ?Ó, GOM NHÓM THEO CÁI GÌ ?Ó 

-- N?U B?N GOM THEO KEY/PK, VÔ NGH?A HENG, VÌ KEY HOK TRÙNG, M?I TH?NG 1 NHÓM, ??M CÁI GÌ???

-- MÃ S? SV  --- ??M CÁI GÌ??? VÔ NGH?A
-- MÃ CHUYÊN NGÀNH -- ??M S? SV CHUYÊN NGÀNH!!!!!
-- MÃ QU?C GIA --- ??M S? ??N HÀNG
-- ?I?M THI  -- ??M S? L??NG SV ??T ?C ?I?M ?Ó
-- CÓ C?T ?? GOM NHÓM, C?T ?Ó S? DÙNG ?? HI?N TH? S? L??NG K?T QU?


--IN RA MÃ NV
--1  London 1   
--2  Seatle 1
--3         1
--4
--5


SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City 

--9. HÃY CHO TUI BI?T TP NÀO CÓ T? 2 NV TR? LÊN
-- 2 ch?ng làm
-- 9.1 Các tp có bao nhiêu nhân viên
-- 9.2 ??m xong m?i tp, ta b?t ??u l?c l?i k?t qu? sau ??m
-- FILTER SAU ??M, WHERE SAU ??M, WHERE SAU KHI ?Ã GOM NHÓM, AGGREGATE THÌ G?I LÀ HAVING

SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City 
SELECT City, COUNT(*) AS [No employess] FROM Employees GROUP BY City

SELECT City, COUNT(*) AS [No employess] FROM Employees GROUP BY City
                                                       HAVING COUNT(*) >= 2


--10. ??m s? nhân viên c?a 2 thành ph? Seatle và London
SELECT COUNT(*) FROM Employees WHERE City IN ('London', 'Seattle') --6 ??A, SAI R?I
SELECT COUNT(*) FROM Employees WHERE City IN ('London', 'Seattle') GROUP BY City --6 ??A, SAI R?I
SELECT City, COUNT(*) FROM Employees WHERE City IN ('London', 'Seattle') GROUP BY City --2 4

--11. Trong 2 tp, London Seattle, tp nào có nhi?u h?n 3 nv
SELECT City, COUNT(*) FROM Employees 
                      WHERE City IN ('London', 'Seattle') 
					  GROUP BY City --
					  HAVING COUNT(*) >= 3

--12. ??m xem có bao nhiêu ??n hàng ?ã bán ra
SELECT * FROM Orders
SELECT COUNT(*) AS [No Orders] FROM Orders --830

SELECT COUNT(OrderID) AS [No Orders] FROM Orders --830
--830 mã ??n khác nhau, ??m mã ??n, hay ??m c? cái ??n là nh? nhau
--n?u c?t có value NULL ?n hành!!!!

--12.1. N??c M? có bao nhiêu ??n hàng
-- ?i tìm M? mà ??m, l?c M? r?i tính ti?p, WHERE M?
-- KO PH?I LÀ CÂU GOM CHIA NHÓM, HOK CÓ M?I QU?C GIA BAO NHIÊU ??N, 
-- M?I QG CÓ BAO NHIÊU ??N, COUNT THEO QU?C GIA, GROUP BY THEO QU?C GIA
SELECT COUNT(*) AS [No USA Orders] FROM Orders WHERE ShipCountry = 'USA'

--12.2. M? Anh Pháp chi?m t?ng c?ng bao nhiêu ??n hàng - WHERE GOM CHUNG
SELECT COUNT(*) FROM Orders WHERE ShipCountry IN ('USA', 'UK', 'FRANCE') --255 CHO C? 3
SELECT COUNT(*) FROM Orders WHERE ShipCountry = 'USA' 
                                  AND ShipCountry = 'UK' 
								  AND ShipCountry = 'FRANCE'  --0

SELECT COUNT(*) FROM Orders WHERE ShipCountry = 'USA' 
                                  OR ShipCountry = 'UK' 
								  OR ShipCountry = 'FRANCE'  --255

--12.3. M? Anh Pháp, m?i qu?c gia có bao nhiêu ??n hàng
SELECT ShipCountry, COUNT(*) AS [No Orders] 
                             FROM Orders
							 WHERE ShipCountry IN ('USA', 'FRANCE', 'UK')
							 GROUP BY ShipCountry 
--12.4. Trong 3 qu?c gia A P M, qu?c gia nào có t? 100 ??n hàng tr? lên
SELECT ShipCountry, COUNT(*) AS [No Orders] 
                             FROM Orders
							 WHERE ShipCountry IN ('USA', 'FRANCE', 'UK')
                             GROUP BY ShipCountry
							 HAVING COUNT(*) >= 100

--13. ??m xem có bao nhiêu m?t hàng có trong kho
--14. ??m xem có bao nhiêu l??t qu?c gia ?ã mua hàng 
--15. ??m xem có bao nhiêu qu?c gia ?ã mua hàng (m?i qu?c gia ??m m?t l?n)
--16. ??m s? l??ng ??n hàng c?a m?i qu?c gia
--17. Qu?c gia nào có t? 10 ??n hàng tr? lên
--18. ??m xem m?i ch?ng lo?i hàng có bao nhiêu m?t hàng (bia r??u có 5 sp, th?y s?n 10 sp)
--19. Trong 3 qu?c gia A P M, qu?c gia nào có nhi?u ??n hàng nh?t
--20. Qu?c gia nào có nhi?u ??n hàng nh?t
--21. Thành ph? nào có nhi?u nhân viên nh?t???