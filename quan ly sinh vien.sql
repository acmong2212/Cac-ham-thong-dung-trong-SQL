CREATE DATABASE QuanLySinhVien;

CREATE TABLE Class(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    NOT NULL,
    Status    BIT
);

insert into Class
values (1, "A1", "2008-12-20", 1);
insert into Class
values (2, 'A2', '2008-12-22', 1);
insert into Class
values (3, "B3", current_date, 0);

CREATE TABLE Student(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);

insert into Student (StudentName, Address, Phone, Status, ClassId)
values ("Hung", "Ha Noi", 0912113113, 1, 1);
insert into Student(StudentName, Address, Status, ClassId)
values ("Hoa", "Hai Phong", 1, 1);
insert into Student (StudentName, Address, Phone, Status, ClassId)
values ("Manh", "HCM", 0123123123, 0, 2);

CREATE TABLE Subject(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

insert into Subject (SubName, Credit, Status)
values ("CF", 5, 1);
insert into Subject (SubName, Credit, Status)
values ("C", 6, 1);
insert into Subject (SubName, Credit, Status)
values ("HDJ", 5, 1);
insert into Subject (SubName, Credit, Status)
values ("RDBMS", 10, 1);

CREATE TABLE Mark(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

insert into Mark(SubId, StudentId, Mark, ExamTimes)
values (1,1,8,1);
insert into Mark(SubId, StudentId, Mark, ExamTimes)
values (1,2,10,2);
insert into Mark(SubId, StudentId, Mark, ExamTimes)
values (2,1,12,1);

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select * from student
where StudentName like "h%";

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select * from class
where StartDate between "2008-12-01 00:00:00" and "2021-12-31 23:59:59";

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select * from subject
where Credit >= 3 and Credit <= 5;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
update student
set classId = 2
where studentId = 1;

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select StudentName, SubName, Mark from mark
join student on mark.StudentId = student.StudentId join subject on mark.SubId = subject.SubId
order by mark desc
limit 3;

----------------------------------
-- 4. Các hàm thông dụng trong SQL
-- [Thực hành] Sử dụng các hàm thông dụng trong SQL
-- Hiển thị số lượng sinh viên ở từng nơi
select Address, count(StudentId) as "Số lượng học viên" from student
group by Address;

-- Tính điểm trung bình các môn học của mỗi học viên
select StudentName, avg(Mark) from mark
join student on mark.StudentId = student.StudentId
group by StudentName;

-- Hiển thị những bạn học viên có điểm trung bình các môn học lớn hơn 15
select StudentName, avg(Mark) from mark
join student on mark.StudentId = student.StudentId
group by StudentName
having avg(Mark) > 15;

-- Hiển thị thông tin các học viên có điểm trung bình lớn nhất.
select student.*, avg(Mark) from mark
join student on mark.StudentId = student.StudentId
where (select max(Mark) from mark);

-- [Bài tập] Luyện tập các hàm thông dụng trong SQL
-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select * from subject
where Credit = (select max(Credit) from subject);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select subject.*, mark.Mark from subject
join mark on subject.SubId = mark.SubId
where Mark = (select max(Mark) from mark);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select student.*, avg(Mark) as avg 
from mark join student on mark.StudentId = student.StudentId
group by StudentName
order by avg desc;