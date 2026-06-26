# Data Information Management of an Airline

## Giới thiệu dự án
Dự án này tập trung vào việc thiết kế và xây dựng hệ thống cơ sở dữ liệu (CSDL) quan hệ nhằm tối ưu hóa quản lý các hoạt động vận hành cho một hãng hàng không giả tưởng. Hệ thống hỗ trợ quản lý hiệu quả các thông tin quan trọng bao gồm: hành khách, thông tin đặt vé, nhân viên, lộ trình bay, lịch trình bảo trì máy bay, v.v.

## Mục tiêu
- Cải thiện hiệu quả vận hành và quản lý dữ liệu bay.
- Tối ưu hóa quy trình tra cứu thông tin bảo trì máy bay.
- Cung cấp các hàm (Function) và thủ tục (Stored Procedure) tự động hóa việc tính toán thời gian bay và các báo cáo liên quan.

## Các tính năng chính
- **Quản lý chuyến bay:** Cập nhật thông tin lộ trình và lịch trình bay.
- **Tính toán thời gian bay:** Hàm tự động tính toán tổng thời gian thực tế dựa trên giờ cất cánh và hạ cánh (`caculate_Flightduration`).
- **Tra cứu bảo trì:** Thủ tục tra cứu lịch sử bảo trì của máy bay theo ID (`Search_maintenance`).
- **Phân tích dữ liệu:** Hỗ trợ quản lý kiểm soát đội bay và phân tích doanh thu.

## Công nghệ sử dụng
- **Database:** SQL Server (T-SQL).
- **Công cụ quản lý:** SQL Server Management Studio (SSMS).

## Hướng dẫn cấu trúc thư mục
- `/Scripts`: Chứa các tệp lệnh SQL để khởi tạo bảng và dữ liệu mẫu.
- `/Documentation`: Chứa tài liệu mô tả chi tiết yêu cầu hệ thống và quy trình nghiệp vụ.# Data-Information-Management-of-an-Airline
