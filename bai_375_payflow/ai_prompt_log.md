# Nhật ký trao đổi với AI

## Câu hỏi 1

**Hỏi:** SARGable là gì và vì sao `YEAR(created_at) = 2026` làm MySQL khó sử dụng Index?

**Trả lời tóm tắt:** SARGable là điều kiện tìm kiếm có thể tận dụng cấu trúc Index. Khi bọc cột trong `YEAR()`, MySQL phải tính hàm trên từng dòng, nên không thể tìm trực tiếp theo thứ tự của B-Tree. Dùng khoảng ngày `created_at >= ... AND created_at < ...` giúp Index hoạt động.

## Câu hỏi 2

**Hỏi:** Vì sao Composite Index nên là `(transaction_type, created_at)`?

**Trả lời tóm tắt:** Quy tắc leftmost prefix cho phép MySQL lọc điều kiện bằng trên `transaction_type` trước, sau đó quét một khoảng liên tục của `created_at`. Nếu đảo thứ tự, điều kiện khoảng trên ngày có thể hạn chế khả năng sử dụng cột còn lại.

## Câu hỏi 3

**Hỏi:** `Using index condition` khác `Using index` thế nào?

**Trả lời tóm tắt:** `Using index condition` là Index Condition Pushdown: MySQL lọc bằng điều kiện Index trước rồi vẫn có thể phải đọc dòng bảng. `Using index` thường biểu thị Covering Index, nghĩa là toàn bộ dữ liệu cần thiết đã nằm trong Index nên không cần đọc bảng gốc.

## Câu hỏi 4

**Hỏi:** Tạo quá nhiều Index có rủi ro gì?

**Trả lời tóm tắt:** Mỗi thao tác INSERT, UPDATE hoặc DELETE phải cập nhật thêm các cây Index, làm tăng chi phí ghi, dung lượng lưu trữ, bộ nhớ đệm và thời gian bảo trì. Vì vậy chỉ nên tạo Index phục vụ truy vấn quan trọng.
