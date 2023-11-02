create database dml_demo_db;
use dml_demo_db;
create table Student(
	student_id char(5) primary key,
    student_name varchar(100) not null unique,
    age int,
    sex bit,
    student_status bit default(1)
);
create table student_class(
	class_id int primary key auto_increment,
    class_name varchar(50)    
);
alter table student
	add column class_id int;
alter table student
	add constraint foreign key(class_id) references student_class(class_id);
    
-- 1. Thêm mới 1 sinh viên gồm đầy đủ thông tin
insert into student
	values('SV001','Nguyễn Văn A',20,1,1);
select * from student;
insert into student(student_id,student_name,age,sex,Student_Status)
	values('SV002','Nguyễn Văn B',22,1,1);
-- 2. Thêm mới 1 sinh viên gồm mã sinh viên, tên sinh viên, tuổi, trạng thái
insert into student(student_id,age,student_name,student_status)
	values('SV003',25,'Nguyễn Văn C',0);
-- 3. Thêm mới 2 sinh viên gồm tất cả thông tin
insert into student
	values('SV004','Nguyễn Thanh Thư',27,0,1),
    ('SV005','Nguyễn Thị Hiền', 29,0,1);
-- 4. Cập nhật sinh viên có mã là SV002 có tên là Lê Thanh Bình và có tuổi 18
update student
set student_name = 'Lê Thanh Bình',
	age = 18
where student_id = 'SV002';
-- 5. Cập nhật trạng thái sinh viên thành 0
update student
set student_status = 0;
-- 6. Xóa sinh viên có mã là SV003
delete from student
where student_id = 'SV003';
-- 7. Lấy tất cả dữ liệu trong bảng student
select * from student;
-- 8. Lấy thông tin sinh viên gồm mã, tên, tuổi
select st.student_id, st.student_name, st.age
from student st;
-- 9. Lấy thông tin sinh viên gồm mã, tên, tuổi (tăng 5 tuổi), giới tính
select st.student_id,st.student_name, (st.age+5) as ageNew, st.sex
from student st;
-- 10. Lấy tuổi lớn nhất, nhỏ nhất, trung bình tuổi, tổng tuổi của các sinh viên
select max(st.age) as ageMax, min(st.age) as ageMin, sum(st.age) as ageSum, avg(st.age) as ageAvg
from student st;
-- 11. Thêm dữ liệu bảng class_student
insert into student_class(class_name)
values('JV230508'),('JV230627'),('JV230829');
select * from student_class;
-- 12. Lấy thông tin sinh viên gồm mã sinh viên, tên sinh viên, tên lớp học (inner join)
select st.student_id, st.student_name, cs.class_name
from student st join student_class cs on st.class_id = cs.class_id;

select * from student;
-- 12. Lấy thông tin sinh viên gồm mã sinh viên, tên sinh viên, tên lớp học (left join)
select st.student_id, st.student_name, cs.class_name
from student st left join student_class cs on st.class_id = cs.class_id;

-- 13. Lấy thông tin sinh viên gồm mã sinh viên, tên sinh viên, tên lớp học (right join)
select st.student_id, st.student_name, cs.class_name
from student st right join student_class cs on st.class_id = cs.class_id;
-- 14. Lấy thông tin sinh viên gồm mã sinh viên, tên sinh viên, tên lớp học (outer join)
select st.student_id, st.student_name, cs.class_name
from student st left join student_class cs on st.class_id = cs.class_id
union
select st.student_id, st.student_name, cs.class_name
from student st right join student_class cs on st.class_id = cs.class_id;
-- 15. Lấy các sinh viên có tuổi lớn hơn hoặc bằng 22
select *
from student st
where st.age>=22;
-- 16. Lấy sinh viên có tuổi bằng 27
select *
from student st
where st.age=27;
-- 17. Lấy các sinh viên có tuổi nhơ hơn hoặc bằng 22 và có giới tính là 0
select *
from student st
where st.age<=22 or st.sex=0;
-- 18. Sử dụng not để lấy các sinh viên có tuổi nhỏ hơn hoặc bằng 22
select *
from student st
where not st.age>22;
-- 19. Lấy các sinh viên có tuổi từ 20 đến 29 tuổi
select *
from student st
where st.age between 20 and 29;
-- 20. Lấy các sinh viên có tuổi 18, 23 hoặc 29
select *
from student st
where st.age in (18,23,29);
-- 21. Lấy các sinh viên có tên là Nguyễn Thị Hiền - Tìm kiếm chính xác
select *
from student st
where st.student_name = 'Nguyễn Thị Hiền';
-- 22. Lấy các sinh viên có họ là Nguyễn - Tìm kiếm tương đối
select *
from student st
where st.student_name like 'nguyễn%';
-- 23. Lấy các sinh viên có tên là Hiền
select *
from student st
where st.student_name like '%hiến';
-- 24. Lấy các sinh viên có ký tự thứ 2 là ê
select *
from student st
where st.student_name like '_ê%';
-- 25. Thống kê số sinh viên theo tên lớp
select sc.class_name, count(st.student_id)
from student st right join student_class sc on st.class_id = sc.class_id
group by sc.class_name;
-- 26. Lấy ra thông tin các lớp có số sinh viên lớn hơn 1
select sc.class_name, count(st.student_id)
from student st right join student_class sc on st.class_id = sc.class_id
group by sc.class_name
having count(st.student_id)>1;
-- 27. Lấy thông tin sinh viên gồm mã, tên, tuổi và được sắp xếp theo tuổi giảm dần
select st.student_id, st.student_name, st.age
from student st
order by age DESC;
-- 28. Lấy thông tin sinh viên gồm mã, tên, tuổi và được sắp xếp theo tuổi giảm dần, những
-- sinh viên bằng tuổi thì sắp xếp theo tên tăng dần
insert into student values('SV006', 'Nguyễn Văn C',20,1,1,2),('SV007', 'Nguyễn Văn B',20,0,1,1);
select st.student_id, st.student_name, st.age
from student st
order by st.age DESC, st.student_name ASC;
-- 29. Lấy 2 sinh viên đầu tiên
select *
from student
limit 2;
-- 20. Lấy 3 sinh viên trừ sinh viên đầu tiên
select *
from student
limit 3 offset 1;
-- 30. Truy vấn lồng: kết quả của câu truy vấn này là đầu vào của câu truy vấn khác
-- Lấy các sinh viên có tuổi nhỏ hơn hoặc bằng 22 và có giới tính là 0
select *
from (select *
		from student
		where age <= 22) as student22
where student22.sex = 0;
