USE master;
GO
IF DB_ID('RaceDayDB1') IS NOT NULL
BEGIN
ALTER DATABASE RaceDayDB1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE RaceDayDB1;
END
GO

CREATE DATABASE RaceDayDB1;
GO
USE RaceDayDB1;
GO

CREATE TABLE Users (
UserID INT IDENTITY(1,1) PRIMARY KEY, 
FirstName NVARCHAR(50) NOT NULL,
LastName NVARCHAR(50) NOT NULL,
Email NVARCHAR(100) UNIQUE NOT NULL,
PasswordHash NVARCHAR(255) NOT NULL, 
Role NVARCHAR(20) CHECK (Role IN ('Organiser', 'Participant')) NOT NULL,
CreatedAt DATETIME DEFAULT GETDATE());
GO

CREATE TABLE Venues (
VenueID INT IDENTITY(1,1) PRIMARY KEY, 
VenueName NVARCHAR(100) NOT NULL,
City NVARCHAR(50) NOT NULL,
Province NVARCHAR(50) NOT NULL,
Capacity INT NOT NULL);
GO

CREATE TABLE Events (
EventID INT IDENTITY(1,1) PRIMARY KEY, 
EventName NVARCHAR(100) NOT NULL, 
Description NVARCHAR(500) NULL,
EventDate DATETIME NOT NULL, 
VenueID INT NOT NULL,
OrganiserID INT NOT NULL,
Status NVARCHAR(20) DEFAULT 'Open' CHECK (Status IN ('Open', 'Closed', 'Cancelled', 'Completed')),
CreatedDate DATETIME DEFAULT GETDATE(), CONSTRAINT FK_Events_Venue FOREIGN KEY (VenueID) REFERENCES Venues(VenueID),
CONSTRAINT FK_Events_Organiser FOREIGN KEY (OrganiserID) REFERENCES Users(UserID));
GO

CREATE TABLE Categories (
CategoryID INT IDENTITY(1,1) PRIMARY KEY, 
EventID INT NOT NULL, CategoryName NVARCHAR(50) NOT NULL,
Distance DECIMAL(5,2) NOT NULL,
EntryFee DECIMAL(10,2) NOT NULL,
CONSTRAINT FK_Categories_Event FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE);
GO

CREATE TABLE Enrolments (
EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
ParticipantID INT NOT NULL,
CategoryID INT NOT NULL,
EnrolmentDate DATETIME DEFAULT GETDATE(), 
PaymentStatus NVARCHAR(20) CHECK (PaymentStatus IN ('Pending', 'Paid', 'Cancelled')) DEFAULT 'Pending',
EnrolmentStatus NVARCHAR(20) DEFAULT 'Registered' CHECK (EnrolmentStatus IN ('Registered', 'Withdrawn', 'Pending', 'Confirmed')), 
CONSTRAINT FK_Enrolments_Participant FOREIGN KEY (ParticipantID) REFERENCES Users(UserID), 
CONSTRAINT FK_Enrolments_Category FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID), 
CONSTRAINT UQ_Participant_Category UNIQUE (ParticipantID, CategoryID));


CREATE TABLE Results (
ResultID INT IDENTITY(1,1) PRIMARY KEY,
EnrolmentID INT UNIQUE NOT NULL, FinishTime TIME NOT NULL,
OverallPosition INT NOT NULL,
CategoryPosition INT NULL, RaceNumber INT NULL, 
Status NVARCHAR(20) DEFAULT 'Confirmed' CHECK (Status IN ('Pending', 'Confirmed', 'Disqualified')),
CONSTRAINT FK_Results_Enrolment FOREIGN KEY (EnrolmentID) REFERENCES Enrolments(EnrolmentID));
GO

USE RaceDayDB1;
GO

INSERT INTO Users (FirstName, LastName, Email, PasswordHash, Role) VALUES
('Sipho','Mthembu','sipho.organiser@raceday.co.za','HASH1','Organiser'),
('Anke','Van Der Merwe','anke.organiser@raceday.co.za','HASH2','Organiser'),
('Lerato','Khumalo','lerato.p@gmail.com','HASH3','Participant'),
('John','Smith','john.smith@gmail.com','HASH4','Participant');

INSERT INTO Venues (VenueName, City, Province, Capacity) VALUES
('Moses Mabhida','Durban','KwaZulu-Natal',25000),
('Green Point Park','Cape Town','Western Cape',15000),
('FNB Stadium','Johannesburg','Gauteng',30000);

INSERT INTO Events (EventName, Description, EventDate, VenueID, OrganiserID, Status) VALUES
('Durban Marathon','Coastal run','2026-06-14 06:00:00',1,1,'Open'),
('Cape Cycle','Scenic cycle','2026-10-10 07:00:00',2,2,'Open'),
('Soweto Walk','Fun walk','2026-09-20 08:00:00',3,1,'Closed');

INSERT INTO Categories (EventID, CategoryName, Distance, EntryFee) VALUES
(1,'10km Run',10,220),(1,'21.1km Half',21.10,350),(2,'42km Cycle',42,550),(3,'5km Walk',5,100);

INSERT INTO Enrolments (ParticipantID, CategoryID, PaymentStatus, EnrolmentStatus) VALUES
(3,1,'Paid','Confirmed'),(3,2,'Paid','Confirmed'),(4,3,'Paid','Confirmed'),(4,4,'Paid','Confirmed');

INSERT INTO Results (EnrolmentID, FinishTime, OverallPosition) VALUES
(1,'01:05:23',15),(2,'02:10:45',42),(3,'00:45:10',32);

SELECT 'DONE RaceDayDB1 READY' AS Status;
GO

