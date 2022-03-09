USE Northwind

-------------------------------------------------------------------------------------
-- L� THUY?T
-- DB ENGINE h? tr? 1 lo?t nh�m h�m d�ng thao t�c tr�n nh�m d�ng/c?t, gom data t�nh to�n
-- tr�n ?�m data gom n�y - nh�m h�m gom nh�m  - AGGREGATE FUNCTIONS, AGGREGATION
-- COUNT() SUM() MIN() MAX() AVG()

-- * C� PH�P CHU?N
-- SELECT C?T..., H�M GOM NH�M(),... FROM <TABLE>

-- * C� PH�P M? R?NG

-- SELECT C?T..., H�M GOM NH�M(),... FROM <TABLE>...WHERE... GROUP BY (GOM THEO C?M C?T N�O)

-- SELECT C?T..., H�M GOM NH�M(),... FROM <TABLE>...WHERE... GROUP BY (GOM THEO C?M C?T N�O) HAVING...

-- * H�M COUNT(???) ??M S? L?N XU?T HI?N C?A 1 C�I G� ?�???
--       COUNT(*):  ??M S? D�NG TRONG TABLE, ??M T?T C? C�C D�NG KO CARE TI�U CHU?N N�O KH�C
--       COUNT(*) FROM... WHERE ...
--                  CH?N RA NH?NG D�NG TH?A TI�U CH� WHERE N�O ?� TR??C ?�, R?I M?I ??M
--                  FILTER R?I ??M  
--
--       COUNT(C?T N�O ?�): 

-------------------------------------------------------------------------------------
--1. In ra danh s�ch c�c nh�n vi�n
SELECT * FROM Employees

--2. ??m xem c� bao nhi�u nh�n vi�n
SELECT COUNT(*) FROM Employees
SELECT COUNT(*) AS [Number of employees] FROM Employees

--3. C� bao nhi�u NV ? London
SELECT COUNT(*) FROM Employees WHERE City = 'London'
SELECT COUNT(*) AS NoempsinLondon FROM Employees WHERE City = 'London'

--4. C� bao nhi�u l??t th�nh ph? xu?t hi?n - c? xh t�n tp l� ??m, ko care l?p l?i hay ko
SELECT COUNT(City) FROM Employees --9

--5. ??m xem c� bao nhi�u Region
SELECT COUNT(Region) FROM Employees --
-- PH�T HI?N H�M COUNT(C?T), N?U CELL C?A C?T CH?A NULL, KO T�NH, KO ??M

--6. ??m xem c� bao nhi�u khu v?c null, c� bao nhi�u d�ng region null
SELECT COUNT(*) FROM Employees WHERE Region IS NULL -- ??m s? xh d�ng ch?a Region null

SELECT COUNT(Region) FROM Employees WHERE Region IS NULL --0 null ko ??m ?c, ko value
SELECT * FROM Employees WHERE Region IS NULL

--7. C� bao nhi�u th�nh ph? trong table NV
SELECT * FROM Employees

SELECT City FROM Employees --9
SELECT DISTINCT City FROM Employees --5
-- tui coi k?t qu? tr�n l� 1 table, m?t qu� tr?i c�ng s?c l?c ra 5 tp

-- SUB QUERY M?I, COI 1 C�U SELECT L� 1 TABLE, BI?N TABLE N�Y V�O TRONG M?NH ?? FROM
-- NG�O
SELECT * FROM   
         (SELECT DISTINCT City FROM Employees) AS CITIES   

SELECT COUNT(*) FROM   
         (SELECT DISTINCT City FROM Employees) AS CITIES   --5 

SELECT COUNT(*) FROM Employees --9 NV
SELECT COUNT(City) FROM Employees --9 City

SELECT COUNT(DISTINCT City) FROM Employees --5

--8. ??m xem M?I th�nh ph? c� bao nhi�u nh�n vi�n
-- KHI C�U H?I C� T�NH TO�N GOM DATA (H�M AGGREGATE) M� L?I CH?A T? KH�A M?I....
-- G?P T? "M?I", CH�NH L� CHIA ?? ??M, CHIA ?? TR?, CHIA C?M ?? GOM ??M
SELECT * FROM Employees

--Seatle 2 | Tacoma 1 | Kirland 1 | Redmon 1 | London 4
-- S? xu?t hi?n c?a nh�m
-- ??m theo s? xh c?a nh�m, count++ trong nh�m thoy, sau ?� reset ? nh�m m?i
SELECT COUNT(City) FROM Employees GROUP BY City ---??M VALUE C?A CITY, NH?NG ??M THEO NH�M 
                                                -- CHIA CITY TH�NH NH�M, R?I ??M TRONG NH�M

SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City 
 
SELECT EmployeeID, City, COUNT(City) AS [No employess] FROM Employees GROUP BY City, EmployeeID
--v� ngh?a, chia nh�m theo key, mssv v� ngh?a


--CH?T H?: KHI X�I H�M GOM NH�M, B?N C� QUY?N LI?T K� T�N C?T L? ? SELECT 
--         NH?NG C?T L? ?� B?T BU?C PH?I XU?T HI?N TRONG M?NH ?? GROUP BY 
--         ?? ??M B?O LOGIC: C?T HI?N TH? | S? L??NG ?I K�M, ??M GOM THEO C?T HI?N TH? M?I LOGIC
-- C? THEO C?T CITY M� GOM, C?T CITY N?M ? SELECT H?P L� 
-- MU?N HI?N TH? S? L??NG C?A AI ?�, G� ?�, GOM NH�M THEO C�I G� ?� 

-- N?U B?N GOM THEO KEY/PK, V� NGH?A HENG, V� KEY HOK TR�NG, M?I TH?NG 1 NH�M, ??M C�I G�???

-- M� S? SV  --- ??M C�I G�??? V� NGH?A
-- M� CHUY�N NG�NH -- ??M S? SV CHUY�N NG�NH!!!!!
-- M� QU?C GIA --- ??M S? ??N H�NG
-- ?I?M THI  -- ??M S? L??NG SV ??T ?C ?I?M ?�
-- C� C?T ?? GOM NH�M, C?T ?� S? D�NG ?? HI?N TH? S? L??NG K?T QU?


--IN RA M� NV
--1  London 1   
--2  Seatle 1
--3         1
--4
--5


SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City 

--9. H�Y CHO TUI BI?T TP N�O C� T? 2 NV TR? L�N
-- 2 ch?ng l�m
-- 9.1 C�c tp c� bao nhi�u nh�n vi�n
-- 9.2 ??m xong m?i tp, ta b?t ??u l?c l?i k?t qu? sau ??m
-- FILTER SAU ??M, WHERE SAU ??M, WHERE SAU KHI ?� GOM NH�M, AGGREGATE TH� G?I L� HAVING

SELECT City, COUNT(City) AS [No employess] FROM Employees GROUP BY City 
SELECT City, COUNT(*) AS [No employess] FROM Employees GROUP BY City

SELECT City, COUNT(*) AS [No employess] FROM Employees GROUP BY City
                                                       HAVING COUNT(*) >= 2


--10. ??m s? nh�n vi�n c?a 2 th�nh ph? Seatle v� London
SELECT COUNT(*) FROM Employees WHERE City IN ('London', 'Seattle') --6 ??A, SAI R?I
SELECT COUNT(*) FROM Employees WHERE City IN ('London', 'Seattle') GROUP BY City --6 ??A, SAI R?I
SELECT City, COUNT(*) FROM Employees WHERE City IN ('London', 'Seattle') GROUP BY City --2 4

--11. Trong 2 tp, London Seattle, tp n�o c� nhi?u h?n 3 nv
SELECT City, COUNT(*) FROM Employees 
                      WHERE City IN ('London', 'Seattle') 
					  GROUP BY City --
					  HAVING COUNT(*) >= 3

--12. ??m xem c� bao nhi�u ??n h�ng ?� b�n ra
SELECT * FROM Orders
SELECT COUNT(*) AS [No Orders] FROM Orders --830

SELECT COUNT(OrderID) AS [No Orders] FROM Orders --830
--830 m� ??n kh�c nhau, ??m m� ??n, hay ??m c? c�i ??n l� nh? nhau
--n?u c?t c� value NULL ?n h�nh!!!!

--12.1. N??c M? c� bao nhi�u ??n h�ng
-- ?i t�m M? m� ??m, l?c M? r?i t�nh ti?p, WHERE M?
-- KO PH?I L� C�U GOM CHIA NH�M, HOK C� M?I QU?C GIA BAO NHI�U ??N, 
-- M?I QG C� BAO NHI�U ??N, COUNT THEO QU?C GIA, GROUP BY THEO QU?C GIA
SELECT COUNT(*) AS [No USA Orders] FROM Orders WHERE ShipCountry = 'USA'

--12.2. M? Anh Ph�p chi?m t?ng c?ng bao nhi�u ??n h�ng - WHERE GOM CHUNG
SELECT COUNT(*) FROM Orders WHERE ShipCountry IN ('USA', 'UK', 'FRANCE') --255 CHO C? 3
SELECT COUNT(*) FROM Orders WHERE ShipCountry = 'USA' 
                                  AND ShipCountry = 'UK' 
								  AND ShipCountry = 'FRANCE'  --0

SELECT COUNT(*) FROM Orders WHERE ShipCountry = 'USA' 
                                  OR ShipCountry = 'UK' 
								  OR ShipCountry = 'FRANCE'  --255

--12.3. M? Anh Ph�p, m?i qu?c gia c� bao nhi�u ??n h�ng
SELECT ShipCountry, COUNT(*) AS [No Orders] 
                             FROM Orders
							 WHERE ShipCountry IN ('USA', 'FRANCE', 'UK')
							 GROUP BY ShipCountry 
--12.4. Trong 3 qu?c gia A P M, qu?c gia n�o c� t? 100 ??n h�ng tr? l�n
SELECT ShipCountry, COUNT(*) AS [No Orders] 
                             FROM Orders
							 WHERE ShipCountry IN ('USA', 'FRANCE', 'UK')
                             GROUP BY ShipCountry
							 HAVING COUNT(*) >= 100

--13. ??m xem c� bao nhi�u m?t h�ng c� trong kho
--14. ??m xem c� bao nhi�u l??t qu?c gia ?� mua h�ng 
--15. ??m xem c� bao nhi�u qu?c gia ?� mua h�ng (m?i qu?c gia ??m m?t l?n)
--16. ??m s? l??ng ??n h�ng c?a m?i qu?c gia
--17. Qu?c gia n�o c� t? 10 ??n h�ng tr? l�n
--18. ??m xem m?i ch?ng lo?i h�ng c� bao nhi�u m?t h�ng (bia r??u c� 5 sp, th?y s?n 10 sp)
--19. Trong 3 qu?c gia A P M, qu?c gia n�o c� nhi?u ??n h�ng nh?t
--20. Qu?c gia n�o c� nhi?u ??n h�ng nh?t
--21. Th�nh ph? n�o c� nhi?u nh�n vi�n nh?t???