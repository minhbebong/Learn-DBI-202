create database Test4
 
use Test4
--Create table tblTeacher
	Create table tblTeacher(
		teacherCode nvarchar(10) primary key not null,
		teacherName nvarchar(30) not null, 
	)
--Create table tblStudent
	Create table tblStudent (
		studentCode nvarchar(10) primary key not null, 
		studentName nvarchar(30) not null, 
		gender bit not null, 
		dob smalldatetime not null, 
		subjectCode nvarchar(10) not null
		foreign key references tblTeacher(teacherCode)
	)

	--INSERT INTO TABLE tblTeacher

	Insert into tblTeacher(teacherCode, teacherName) values ('DBI202', 'Database 202')
	Insert into tblTeacher(teacherCode, teacherName) values ('CSI204', 'Computer 204')
	Insert into tblTeacher(teacherCode, teacherName) values ('CSD201', 'Computer 201')
	Insert into tblTeacher(teacherCode, teacherName) values ('MKT202', 'Marketing 202')
	Insert into tblTeacher(teacherCode, teacherName) values ('NWC203', 'Network 203c')


	--INSERT INTO TABLE tblStudent

	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS01', N'Huỳnh Tuấn Kiệt', 0, '2001/02/26' ,'DBI202')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS02', N'Vũ Kim Anh', 1, '2002/10/30', 'CSD201')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS03', N'Hạ Như Bình', 0, '2001/04/04','CSI204')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS04', N'Nguyễn Thanh Long', 0, '2001/06/07','NWC203')
	Insert into tblStudent(studentCode, studentName, gender, dob, subjectCode) values ('HS05', N'Châu Tuấn Tú', 0, '2000/06/07','MKT202')



	--Xử lí dữ liệu

	SELECT * FROM tblTeacher
	SELECT * FROM tblStudent

	DELETE tblTeacher
	DELETE tblStudent

	--Question 4: 
--A:Display information about male students after June 2020.

	Select * from tblStudent
	where gender = 1 and dob < '2020/06/01'

--B: Display the subject information that has the most students study.
	WITH A as
   (SELECT te.teacherCode, te.teacherName, COUNT(te.teacherCode) as count1 
	FROM tblStudent st right join tblTeacher te on st.subjectCode = te.teacherCode
	GROUP BY te.teacherCode, te.teacherName )
	Select * from A
	where count1 = (select top 1 count1 from A order by count1 DESC)
