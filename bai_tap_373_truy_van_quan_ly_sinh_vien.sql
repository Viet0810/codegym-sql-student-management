-- Bài tập 373: Truy vấn dữ liệu với CSDL Quản lý sinh viên

USE QuanLySinhVien;

-- 1. Hiển thị tất cả sinh viên có tên bắt đầu bằng ký tự 'h'
SELECT *
FROM Student
WHERE StudentName LIKE 'h%';

-- 2. Hiển thị các lớp học có thời gian bắt đầu vào tháng 12
SELECT *
FROM Class
WHERE MONTH(StartDate) = 12;

-- 3. Hiển thị tất cả môn học có Credit trong khoảng từ 3 đến 5
SELECT *
FROM Subject
WHERE Credit BETWEEN 3 AND 5;

-- 4. Đổi ClassID của sinh viên có tên 'Hung' thành 2
UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';

-- 5. Hiển thị StudentName, SubName, Mark;
-- sắp xếp điểm giảm dần, nếu trùng điểm thì tên tăng dần
SELECT S.StudentName, Sub.SubName, M.Mark
FROM Student AS S
JOIN Mark AS M ON S.StudentID = M.StudentID
JOIN Subject AS Sub ON M.SubID = Sub.SubID
ORDER BY M.Mark DESC, S.StudentName ASC;
