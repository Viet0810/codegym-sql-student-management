-- Bài tập 374: Thao tác với CSDL Quản lý bán hàng

USE QuanLyBanHang;

-- 1. Thêm dữ liệu vào bảng Customer
INSERT INTO Customer (cID, Name, cAge) VALUES
    (1, 'Minh Quan', 10),
    (2, 'Ngoc Oanh', 20),
    (3, 'Hong Ha', 50);

-- 2. Thêm dữ liệu vào bảng `Order`
-- Order là từ khóa của MySQL nên cần đặt trong dấu backtick.
INSERT INTO `Order` (oID, cID, oDate, oTotalPrice) VALUES
    (1, 1, '2006-03-21', NULL),
    (2, 2, '2006-03-23', NULL),
    (3, 1, '2006-03-16', NULL);

-- 3. Thêm dữ liệu vào bảng Product
INSERT INTO Product (pID, pName, pPrice) VALUES
    (1, 'May Giat', 3),
    (2, 'Tu Lanh', 5),
    (3, 'Dieu Hoa', 7),
    (4, 'Quat', 1),
    (5, 'Bep Dien', 2);

-- 4. Thêm dữ liệu vào bảng OrderDetail
INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
    (1, 1, 3),
    (1, 3, 7),
    (1, 4, 2),
    (2, 1, 1),
    (3, 1, 8),
    (2, 5, 4),
    (2, 3, 3);

-- 5. Hiển thị oID, oDate, oPrice của tất cả hóa đơn
SELECT oID, oDate, oTotalPrice AS oPrice
FROM `Order`;

-- 6. Hiển thị khách hàng đã mua hàng và sản phẩm họ đã mua
SELECT DISTINCT C.Name AS CustomerName, P.pName AS ProductName
FROM Customer AS C
JOIN `Order` AS O ON C.cID = O.cID
JOIN OrderDetail AS OD ON O.oID = OD.oID
JOIN Product AS P ON OD.pID = P.pID;

-- 7. Hiển thị tên khách hàng chưa mua bất kỳ sản phẩm nào
SELECT C.Name
FROM Customer AS C
LEFT JOIN `Order` AS O ON C.cID = O.cID
WHERE O.oID IS NULL;

-- 8. Hiển thị mã hóa đơn, ngày bán và tổng giá tiền từng hóa đơn
SELECT O.oID,
       O.oDate,
       SUM(OD.odQTY * P.pPrice) AS oPrice
FROM `Order` AS O
JOIN OrderDetail AS OD ON O.oID = OD.oID
JOIN Product AS P ON OD.pID = P.pID
GROUP BY O.oID, O.oDate;
