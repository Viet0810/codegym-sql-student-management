# Phân tích EXPLAIN trước và sau tối ưu

Truy vấn cũ sử dụng `YEAR(created_at)` và `MONTH(created_at)`. Vì hàm được áp dụng trực tiếp lên cột đã lập chỉ mục, MySQL phải tính giá trị cho từng bản ghi trước khi so sánh. Truy vấn trở thành Non-SARGable, nên kế hoạch thực thi thường có `type = ALL`, không có `possible_keys`/`key` phù hợp và `rows` xấp xỉ toàn bộ 5 triệu giao dịch.

Giải pháp tạo Composite Index `idx_type_date(transaction_type, created_at)`. Cột `transaction_type` dùng điều kiện bằng nên đứng trước; `created_at` dùng điều kiện khoảng nên đứng sau. Truy vấn mới lọc thời gian bằng cận dưới `>= 2026-06-01` và cận trên `< 2026-07-01`, không bọc cột trong hàm.

Sau tối ưu, EXPLAIN dự kiến hiển thị `type = range` hoặc `ref`, `possible_keys` và `key` chứa `idx_type_date`, còn `rows` giảm xuống số giao dịch DEPOSIT trong tháng 06/2026. `Extra` có thể hiển thị `Using index condition`, chứng tỏ MySQL dùng điều kiện trên Index để thu hẹp dữ liệu trước khi đọc bản ghi.
