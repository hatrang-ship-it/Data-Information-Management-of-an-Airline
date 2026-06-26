Use Finaldatabase
Create table Airport(
ID VARCHAR(10) NOT NULL Primary key,
Country VARCHAR(225),
Terminals INT,
Nameairport VARCHAR(225),
City VARCHAR(225)
)
Create table Aircraft(
ID VARCHAR(225) NOT NULL Primary key,
Model VARCHAR(225),
Capacity INT,
Manufacturer VARCHAR(225)
)
Create table Airway(
ID VARCHAR(225) NOT NULL PRIMARY KEY,
Distance INT,
FlightDuration TIME,
ArrivalAirportID  VARCHAR(10) Foreign key references Airport (ID),
DepartureAirportID VARCHAR(10) Foreign key references Airport (ID)
)
Create table Maintenance_Record(
ID VARCHAR(225) NOT NULL primary key,
AircraftID VARCHAR(225) foreign key references Aircraft(ID),
MaintenanceDate DATE,
PerformedBy VARCHAR(225)
)
Create table Flight(
ID INT NOT NULL primary key,
AircraftID VARCHAR(225) Foreign key references Aircraft (ID),
DepartureTime DATETIME,
ArrivalTime DATETIME,
AirwayID VARCHAR(225) Foreign key references Airway(ID),
Status_FL CHAR(1) CHECK (Status_FL IN ('O','D','C'))
)
Create table Employee(
ID INT NOT NULL primary key,
Lastname VARCHAR(225),
Firstname VARCHAR(225),
Role VARCHAR(225),
HireYear INT)
Create table Employee_Flight(
EmployeeID INT foreign key references Employee (ID),
FlightID INT foreign key references Flight(ID))
Create table Passenger(
ID INT NOT NULL primary key,
Firstname VARCHAR(225),
Lastname VARCHAR(225),
Birthday DATE,
PassportNumber VARCHAR(225),
Contactdetail VARCHAR(225))
Create table Booking (
ID INT primary key,
FlightID INT foreign key references Flight(ID),
PassengerID INT foreign key references Passenger(ID),
BookingDate DATE,
SeatNumber VARCHAR(10))
Create table Service_Type(
ID INT NOT NULL primary key,
ServiceType VARCHAR(225),
Terminals INT)
Create table Booking_service(
BookingID INT foreign key references Booking (ID),
ServiceID INT foreign key references Service_Type(ID))