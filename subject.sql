SELECT * FROM quanlysinhvien.subject;

select * from subject where Credit < 10;

select student.StudentId, student.StudentName, subject.SubName, mark.Mark
from student join mark on student.StudentId = mark.StudentId join subject on mark.SubId = subject.SubId
where subject.SubName = "CF";