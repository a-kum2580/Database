USE AircraftFM;
CREATE TABLE Aircraft(
    AircraftID INT AUTO_INCREMENT PRIMARY KEY,
  Model VARCHAR(50) NOT NULL, Manufacturer VARCHAR(50), Capacity INT,
  Status ENUM('Active','Grounded','In Maintenance') DEFAULT 'Active' );

desc Aircraft;

CREATE TABLE Flight(
    FlightID INT AUTO_INCREMENT PRIMARY KEY,
    AircraftID INT NOT NULL,
    Route VARCHAR(100),
    DepartureTime DATETIME,
    ArrivalTime DATETIME,
    FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID));

CREATE TABLE Crew(
    CrewID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Role ENUM('Pilot','Co-Pilot', 'Flight Attendant', 'Ground Crew')NOT NULL,
    Certification VARCHAR(100),
    ContactInfo VARCHAR(100)
);   
desc Crew;

CREATE TABLE Passenger(
    PassengerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(100),
    BookingReference VARCHAR(50)
);
desc Passenger;

CREATE TABLE Booking(
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    PassengerID INT NOT NULL,
    FlightID INT NOT NULL,
    SeatNumber VARCHAR(10),
    BookingStatus ENUM('Confirmed', 'Canceled') DEFAULT 'Confirmed',
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);
desc Booking;

CREATE TABLE Maintenance(
    MaintenanceID INT AUTO_INCREMENT PRIMARY KEY,
    AircraftID INT NOT NULL,
    Description TEXT,
    MaintenanceDate DATE,
    TechnicianName VARCHAR(100),
    Status ENUM('Scheduled','Compeleted','pending') DEFAULT 'Scheduled',
    FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID)
);
desc Maintenance;

CREATE TABLE FlightCrewAssignment(
    AssignmentID INT AUTO_INCREMENT PRIMARY KEY,
    FlightID INT NOT NULL,
    CrewID INT NOT NULL,
    Role ENUM('Pilot','Co-Pilot','Flight Attendant')NOT NULL,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID),
    FOREIGN KEY (CrewID) REFERENCES Crew(CrewID)
);
desc FlightCrewAssignment;

CREATE TABLE GroundCrewAssignment(
    AssignmentID INT AUTO_INCREMENT PRIMARY KEY,
    AircraftID INT NOT NULL,
    CrewID INT NOT NULL,
    Task ENUM('Fueling','Loading','Cleaning','Inspection') NOT NULL,
    FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID),
    FOREIGN KEY (CrewID) REFERENCES Crew(CrewID)
);
desc GroundCrewAssignment;
use AircraftFM;