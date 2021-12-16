SELECT * FROM quanlysinhvien.class;

select student.StudentId, student.StudentName, class.ClassName
from student join Class on student.ClassId = class.ClassID
where class.ClassName = 'A1';