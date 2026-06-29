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
