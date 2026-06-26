Use Finaldatabase
--1 xuất danh sách toàn bộ khách hàng tên chưa chữ a
Select *
From Passenger
Where Firstname Like '%a%';
--2 Chuyến bay 852 bất ngờ gặp sự cố thời tiết xấu và buộc phải hủy. 
-- Quản lý yêu cầu cập nhật lập tức trạng thái (Status) của chuyến bay này thành 'C' (Cancelled), 
--đồng thời dùng truy vấn lồng (Subquery) để lấy ngay số điện thoại của hành khách trên chuyến bay đó nhằm nhắn tin xin lỗi.
Update Flight
Set Status_FL = 'C'
Where ID = 852;
Select * from Flight where ID = 852;
Select Firstname, Lastname, Contactdetail
From Passenger
Where ID IN (Select PassengerID From Booking where FlightID = 852);
--3 Tính tổng doanh thu (SUM) thu được từ các dịch vụ phụ trợ bán ra trên chuyến bay 123.
Select SUM(S.Price) as Totalrevenue
From Booking B
Inner join Booking_service BS on B.ID = BS.BookingID
Inner join Service_Type S on BS.ServiceID = S.ID
Where B.FlightID = 123;
-- danh sách các hành khách đã đặt vé (Booking) nhưng hiện tại chưa mua thêm bất kỳ dịch vụ phụ trợ (Service) nào.
Select B.ID, P.ID, P.Firstname, p.Lastname, P.Contactdetail
From Passenger P
Inner join Booking B on B.PassengerID = P. ID
Left join Booking_service BS on B. ID = BS.BookingID
Where BS.ServiceID IS NULL;
-- Thống kê xem những sân bay nào đang phục vụ nhiều chuyến bay của hãng nhất (yêu cầu lọc ra các sân bay có tổng số chuyến bay cất/hạ cánh lớn hơn 2).
Select AP.ID Airportcode, AP.Nameairport, Count(F.ID) as Total_flights
From Airport AP
Inner join Airway AW on AP.ID = AW.ArrivalAirportID or AP.ID = AW.DepartureAirportID
Inner join Flight F on AW.ID = F.AirwayID
Group by AP.ID, AP.Nameairport
Having COUNT(F.ID)>2 
ORDER BY Total_Flights DESC;
-- Nhập ID của máy bay (ví dụ: '1'), hệ thống sẽ tự động in ra toàn bộ lịch sử bảo trì và tên đội ngũ thực hiện của chiếc máy bay đó.
Create Procedure Search_maintenance
	@AircraftID VARCHAR(225)
As
Begin
Select AC.ID AircraftID,M.ID, AC.Model, M.MaintenanceDate, M.PerformedBy MaintenanceTeam
From Maintenance_Record M
Inner Join Aircraft AC on M.AircraftID = AC.ID
Where M.AircraftID = @AircraftID
Order by M.MaintenanceDate DESC;
END;
EXEC Search_maintenance @AircraftID = 1
-- Hàm (Function) tự động tính toán ra "thời lượng bay" khi truyền vào tham số là giờ cất cánh và giờ hạ cánh.
Create function caculate_Flightduration(
@DepartureTime Datetime,
@ArrivalTime Datetime
)
Returns NVARCHAR(50)
As
Begin
Declare @TotalMinutues INT;
Declare @Hours INT;
Declare @Minutes INT;
Declare @Result NVARCHAR(50);
SET @TotalMinutues = DATEDIFF(Minute, @DepartureTime, @ArrivalTime);
SET @Hours = @TotalMinutues/60;
SET @Minutes = @TotalMinutues%60;
SET @Result = CAST(@Hours as NVARCHAR)+ N'giờ' + CAST(@Minutes as NVARCHAR) + N'phút';
Return @Result;
End;

SELECT 
ID AS FlightCode,
DepartureTime,
ArrivalTime,
dbo.caculate_Flightduration(DepartureTime, ArrivalTime) AS FlightDuration
FROM Flight;