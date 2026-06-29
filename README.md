# Data Information Management of an Airline

## 1. Giới thiệu dự án
Dự án tập trung vào việc thiết kế và xây dựng hệ thống cơ sở dữ liệu (CSDL) quan hệ nhằm tối ưu hóa quản lý các hoạt động vận hành cho hãng hàng không giả tưởng. Việc đầu tư vào hệ thống CSDL quan hệ hiện đại giúp cải thiện hiệu quả vận hành, nâng cao chất lượng dịch vụ khách hàng, quản lý tài chính và đảm bảo an toàn.

## 2. Bối cảnh kinh doanh
**Mô hình hoạt động**: Hãng áp dụng mô hình hàng không giá rẻ (LCC), tối ưu hóa chi phí bằng cách sử dụng một loại máy bay duy nhất và cắt giảm các dịch vụ không cần thiết.
* **Đối tượng người dùng**:
    * **Hành khách**: Đặt vé, chọn dịch vụ bổ trợ và quản lý thông tin đặt chỗ.
    * **Nhân viên**: Quản lý chuyến bay, thông tin hành khách và xử lý yêu cầu dịch vụ.
    * **Quản lý**: Kiểm soát đội bay, bảo trì, xem báo cáo doanh thu và phân tích dữ liệu.

## 3. Mô hình quan hệ (Relationship)
Hệ thống được thiết kế dựa trên các mối quan hệ thực thể chặt chẽ:

### Nhóm Quản lý Khai thác
* **Flight & Aircraft**: [Một-Nhiều] - Một máy bay thực hiện nhiều chuyến bay theo thời gian.
* **Flight & Airway**: [Một-Nhiều] - Mỗi chuyến bay tuân thủ một tuyến bay duy nhất.
* **Airway & Airport**: [Một-Nhiều] - Tuyến bay được xác định bởi Sân bay đi và Sân bay đến.
* **Flight & Employee**: [Nhiều-Nhiều] - Thông qua bảng `Employee_Flight`.
* **Aircraft & Maintenance_Record**: [Một-Nhiều] - Ghi nhận lịch sử bảo trì định kỳ.

### Nhóm Quản lý Dịch vụ & Hành khách
* **Booking & Passenger**: [Một-Nhiều] - Mỗi lượt đặt chỗ thuộc về một hành khách duy nhất.
* **Booking & Flight**: [Một-Nhiều] - Mỗi lượt đặt chỗ có hiệu lực trên một chuyến bay cụ thể.
* **Booking & Service_Type**: [Nhiều-Nhiều] - Thông qua bảng `Booking_service`.

![Sơ đồ ERD của hệ thống](https://github.com/hatrang-ship-it/Data-Information-Management-of-an-Airline/blob/18eb69c8bc5c6c88c9bcd75ead6d4a4aa69b80b4/ERD%20Framework.png?raw=true)
## 4. Các Truy vấn SQL và Thao tác Dữ liệu

Dưới đây là tổng hợp các truy vấn SQL quan trọng phục vụ cho việc vận hành, phân tích và quản lý hệ thống dữ liệu VietJet Air.

### 4.1. Vận hành hàng ngày
* **Lọc khách hàng mục tiêu:** Sử dụng toán tử `LIKE` để tìm kiếm khách hàng có tên chứa ký tự "a", phục vụ các chiến dịch marketing.
  ```sql
  SELECT * FROM Passenger WHERE Firstname LIKE '%a%';

```
### 4.2. Xử lý sự cố & Quản trị dữ liệu

* **Cập nhật trạng thái chuyến bay:** Sử dụng `UPDATE` để hủy chuyến bay và `Subquery` để lấy thông tin liên lạc của hành khách.
```sql
UPDATE Flight SET Status_FL = 'C' WHERE ID = 852;
SELECT Firstname, Lastname, Contact_detail 
FROM Passenger
WHERE ID IN (SELECT PassengerID FROM Booking WHERE FlightID = 852);

```
### 4.3. Tối ưu Hóa Doanh thu & Dịch vụ

* **Tổng doanh thu dịch vụ phụ trợ:** Sử dụng `INNER JOIN` kết hợp hàm `SUM` để tính toán doanh thu trên chuyến bay cụ thể.
```sql
SELECT SUM(S.Price) AS Totalrevenue 
FROM Booking B
INNER JOIN Flight_service FS ON B.FlightID = FS.FlightID
INNER JOIN Service_type S ON FS.ServiceID = S.ID 
WHERE B.FlightID = 123;

```

* **Tìm kiếm cơ hội bán chéo (Cross-selling): tìm các khách hàng đã đi máy bay nhưng không sử dụng dịch vụ** Sử dụng `LEFT JOIN` với điều kiện `IS NULL` để tìm hành khách chưa sử dụng dịch vụ.
```sql
SELECT B.ID, P.ID, P.Firstname, P.Lastname, P.Contact_detail 
FROM Passenger P
INNER JOIN Booking B ON B.PassengerID = P.ID
LEFT JOIN Flight_service FS ON B.FlightID = FS.FlightID
WHERE FS.ServiceID IS NULL;

```

### 4.4. Quy hoạch Chiến lược

* **Đánh giá lưu lượng sân bay:** Sử dụng `GROUP BY`, `COUNT` và `HAVING` để xác định các sân bay trọng điểm.
```sql
SELECT P.ID AS Airportcode, P.Nameairport, COUNT(A.AirwayID) AS number_airway
FROM Airway_Airport A 
INNER JOIN Airport P ON P.ID = A.AirportID
GROUP BY P.ID, P.Nameairport, P.Country, P.Terminals 
HAVING COUNT(A.AirwayID) >= 1
ORDER BY number_airway DESC;

```

### 4.5. Tự động hóa Hệ thống

* **Stored Procedure (Tra cứu bảo trì):** Thủ tục lưu trữ để tra cứu lịch sử bảo trì nhanh chóng.
```sql
CREATE PROCEDURE Search_maintenance @AircraftID VARCHAR(255) AS
BEGIN
    SELECT AC.ID AS AircraftID, M.ID, AC.Model, M.MaintenanceDate, M.PerformedBy
    FROM Maintenance_Record M
    INNER JOIN Aircraft AC ON M.AircraftID = AC.ID 
    WHERE M.AircraftID = @AircraftID;
END;

```

* **Function (Tính thời gian bay thực tế):** Hàm tự động tính toán thời lượng bay giữa giờ cất cánh và hạ cánh.
```sql
CREATE FUNCTION udrealdurationtime(@Arrival TIME, @Departure TIME) 
RETURNS TIME AS
BEGIN
    DECLARE @DurationSeconds INT = DATEDIFF(SECOND, @Departure, @Arrival);
    RETURN CONVERT(TIME, DATEADD(SECOND, @DurationSeconds, '00:00:00'));
END;

```
