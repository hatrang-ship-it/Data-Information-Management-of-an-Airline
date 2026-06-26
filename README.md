# Data Information Management of an Airline

## 1. Giới thiệu dự án
[cite_start]Dự án tập trung vào việc thiết kế và xây dựng hệ thống cơ sở dữ liệu (CSDL) quan hệ nhằm tối ưu hóa quản lý các hoạt động vận hành cho hãng hàng không giả tưởng[cite: 1, 2]. [cite_start]Việc đầu tư vào hệ thống CSDL quan hệ hiện đại giúp cải thiện hiệu quả vận hành, nâng cao chất lượng dịch vụ khách hàng, quản lý tài chính và đảm bảo an toàn[cite: 3].

## 2. Bối cảnh kinh doanh
* [cite_start]**Mô hình hoạt động**: Hãng áp dụng mô hình hàng không giá rẻ (LCC), tối ưu hóa chi phí bằng cách sử dụng một loại máy bay duy nhất và cắt giảm các dịch vụ không cần thiết[cite: 6, 7].
* **Đối tượng người dùng**:
    * [cite_start]**Hành khách**: Đặt vé, chọn dịch vụ bổ trợ và quản lý thông tin đặt chỗ[cite: 10].
    * [cite_start]**Nhân viên**: Quản lý chuyến bay, thông tin hành khách và xử lý yêu cầu dịch vụ[cite: 11].
    * [cite_start]**Quản lý**: Kiểm soát đội bay, bảo trì, xem báo cáo doanh thu và phân tích dữ liệu[cite: 12].

## 3. Mô hình quan hệ (Relationship)
[cite_start]Hệ thống được thiết kế dựa trên các mối quan hệ thực thể chặt chẽ[cite: 13]:

### Nhóm Quản lý Khai thác
* [cite_start]**Flight & Aircraft**: [Một-Nhiều] - Một máy bay thực hiện nhiều chuyến bay theo thời gian[cite: 15, 16, 17].
* [cite_start]**Flight & Airway**: [Một-Nhiều] - Mỗi chuyến bay tuân thủ một tuyến bay duy nhất[cite: 18, 19, 20].
* [cite_start]**Airway & Airport**: [Một-Nhiều] - Tuyến bay được xác định bởi Sân bay đi và Sân bay đến[cite: 21, 22, 23].
* [cite_start]**Flight & Employee**: [Nhiều-Nhiều] - Thông qua bảng `Employee_Flight`[cite: 24, 25, 26].
* [cite_start]**Aircraft & Maintenance_Record**: [Một-Nhiều] - Ghi nhận lịch sử bảo trì định kỳ[cite: 27, 28, 29].

### Nhóm Quản lý Dịch vụ & Hành khách
* **Booking & Passenger**: [Một-Nhiều] - Mỗi lượt đặt chỗ thuộc về một hành khách duy nhất[cite: 31, 32, 33].
* [cite_start]**Booking & Flight**: [Một-Nhiều] - Mỗi lượt đặt chỗ có hiệu lực trên một chuyến bay cụ thể[cite: 34, 35, 36].
* [cite_start]**Booking & Service_Type**: [Nhiều-Nhiều] - Thông qua bảng `Booking_service`[cite: 37, 38, 39].

![Sơ đồ ERD của hệ thống] (ERD Framework.png)
