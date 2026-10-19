-- PayFlow: tối ưu truy vấn báo cáo tiền nạp tháng 06/2026

CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15, 2),
    transaction_type VARCHAR(20),
    created_at DATETIME
);

-- Truy vấn cũ: Non-SARGable vì bọc cột created_at trong YEAR() và MONTH().
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND YEAR(created_at) = 2026
  AND MONTH(created_at) = 6;

-- Composite Index: điều kiện bằng đặt trước, điều kiện khoảng đặt sau.
CREATE INDEX idx_type_date
    ON Transactions (transaction_type, created_at);

-- Truy vấn mới: SARGable, cho phép MySQL dùng B-Tree Index theo khoảng ngày.
EXPLAIN
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at <  '2026-07-01 00:00:00';

-- Câu truy vấn dùng để lấy kết quả báo cáo thực tế.
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT'
  AND created_at >= '2026-06-01 00:00:00'
  AND created_at <  '2026-07-01 00:00:00';
