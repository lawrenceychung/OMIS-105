-- Create Customer Table
CREATE TABLE Customer_T
	(CustomerID		NUMERIC(11,0)	NOT NULL,
	CustomerName	VARCHAR(25)		NOT NULL,
	CustomerPhone	VARCHAR(14),
CONSTRAINT Customer_PK PRIMARY KEY (CustomerID));
 
-- Create Pet Table
CREATE TABLE Pet_T
	(PetID		NUMERIC(11,0)		NOT NULL,
	PetName		VARCHAR(25)			NOT NULL,
	Breed		VARCHAR(25),
	CustomerID	NUMERIC(11,0)		NOT NULL,	
CONSTRAINT Pet_PK PRIMARY KEY (PetID),
CONSTRAINT Pet_FK1 FOREIGN KEY (CustomerID) REFERENCES Customer_T(CustomerID));
 
-- Create Boarding Table
CREATE TABLE Boarding_T
	(CageNumber 		NUMERIC(11,0)	NOT NULL,
	TimeInCage			TIME(0)			NOT NULL,
	PetID				NUMERIC(11,0)	NOT NULL,
CONSTRAINT Boarding_PK PRIMARY KEY (CageNumber),
CONSTRAINT Boarding_FK1 FOREIGN KEY (PetID) REFERENCES Pet_T(PetID));
 
-- Create Appointment Table
CREATE TABLE Appointment_T
	(AppointmentID		NUMERIC(11,0)	NOT NULL,
	AppointmentDate		DATE			NOT NULL,
	DropOffTime			TIME(0),
	PetID				NUMERIC(11,0)	NOT NULL,
	CustomerID			NUMERIC(11,0)	NOT NULL,
	CageNumber			NUMERIC(11,0)	NOT NULL,
CONSTRAINT Appointment_PK  PRIMARY KEY (AppointmentID),
CONSTRAINT Appointment_FK1  FOREIGN KEY (PetID)  REFERENCES Pet_T(PetID),
CONSTRAINT Appoitnment_FK2  FOREIGN KEY (CustomerID)  REFERENCES Customer_T(CustomerID),
CONSTRAINT Appointment_FK3 FOREIGN KEY (CageNumber)  REFERENCES Boarding_T(CageNumber));
 
-- Create Service Table
CREATE TABLE Service_T
	(ServiceID		NUMERIC(11,0)	NOT NULL,
	ServiceTime		TIME(0),
	ServiceType		VARCHAR(25),
	AppointmentID	NUMERIC(11,0)	NOT NULL,
CONSTRAINT Service_PK  PRIMARY KEY (ServiceID),
CONSTRAINT Service_FK1  FOREIGN KEY (AppointmentID)  REFERENCES Appointment_T(AppointmentID));
 
-- Create Employee Table
CREATE TABLE Employee_T
	(EmployeeID		NUMERIC(11,0)	NOT NULL,
	EmployeeName	VARCHAR(25)		NOT NULL,
	EmployeeDOB		DATE,
	EmployeePhone	VARCHAR(14)		NOT NULL,
	EmployeeStreet	VARCHAR(30),
	EmployeeCity	VARCHAR(25),
	EmployeeState	CHAR(2),
	EmployeeZip		NUMERIC(11,0),
CONSTRAINT Employee_PK  PRIMARY KEY (EmployeeID));
 
-- Create Equipment Table
CREATE TABLE Equipment_T
	(EquipmentID			NUMERIC(11,0)		NOT NULL,
	BrandName				VARCHAR(25),
	EquipmentDescription	VARCHAR(25),
	EmployeeID				NUMERIC(11,0)		NOT NULL,
CONSTRAINT Equipment_PK  PRIMARY KEY (EquipmentID),
CONSTRAINT Equipment_FK1  FOREIGN KEY (EmployeeID)  REFERENCES Employee_T(EmployeeID));
 
-- Create Billing Table
CREATE TABLE Billing_T
	(ReceiptID		NUMERIC(11,0)	NOT NULL,
	ReceiptDate		DATE			NOT NULL,
	ReceiptNumber	NUMERIC(11,0)	NOT NULL,
	PaymentAmount	NUMERIC(11,0)	NOT NULL,
	ServiceID		NUMERIC(11,0)	NOT NULL,
	CustomerID		NUMERIC(11,0)	NOT NULL,
CONSTRAINT Billing_PK  PRIMARY KEY (ReceiptID),
CONSTRAINT Billing_FK1  FOREIGN KEY (ServiceID)  REFERENCES Service_T(ServiceID),
CONSTRAINT Billing_FK2  FOREIGN KEY (CustomerID)  REFERENCES Customer_T(CustomerID));
 
-- Create Brush Table
CREATE TABLE Brush_T
	(ServiceID		NUMERIC(11,0) 	NOT NULL,
CONSTRAINT Brush_PK  PRIMARY KEY (ServiceID),
CONSTRAINT Brush_FK1  FOREIGN KEY (ServiceID) REFERENCES Service_T(ServiceID));
 
-- Create Cut Table
CREATE TABLE Cut_T
	(ServiceID		NUMERIC(11,0)  NOT NULL,
	TimeHair		TIME(0),
	TimeNails		TIME(0),
CONSTRAINT Cut_PK  PRIMARY KEY (ServiceID),
CONSTRAINT Cut_FK1  FOREIGN KEY (ServiceID)  REFERENCES Service_T(ServiceID));
 
-- Create Wash Table
CREATE TABLE Wash_T
	(ServiceID		NUMERIC(11,0)	NOT NULL,
	WaterUsed		VARCHAR(11),
	ShampooUsed		VARCHAR(11),
CONSTRAINT Wash_PK PRIMARY KEY (ServiceID),
CONSTRAINT Wash_FK1  FOREIGN KEY (ServiceID)  REFERENCES Service_T(ServiceID));
 
-- Create Payment Table
CREATE TABLE Payment_T
	(ReceiptID		NUMERIC(11,0) 	NOT NULL,
	PaymentMethod	CHAR(11)	NOT NULL,
CONSTRAINT Payment_PK PRIMARY KEY (ReceiptID, PaymentMethod),
CONSTRAINT Payment_FK1  FOREIGN KEY (ReceiptID) REFERENCES Billing_T(ReceiptID));
 
-- Create Equipment Use Table
CREATE TABLE EquipUse_T
	(EmployeeID		NUMERIC(11,0)	NOT NULL,
	EquipmentID		NUMERIC(11,0)	NOT NULL,
	CheckOutTime	TIME(0),
	CheckInTime		TIME(0),
	EquipUseDate	DATE,
CONSTRAINT EquipUse_PK PRIMARY KEY (EmployeeID, EquipmentID),
CONSTRAINT EquipUse_FK1 FOREIGN KEY (EmployeeID)  REFERENCES Employee_T(EmployeeID),
CONSTRAINT EquipUse_FK2 FOREIGN KEY (EquipmentID)  REFERENCES Equipment_T(EquipmentID));
 
-- Create Employee Service Table
CREATE TABLE EmplService_T
	(EmployeeID		NUMERIC(11,0)	NOT NULL,
	ServiceID		NUMERIC(11,0)	NOT NULL,
CONSTRAINT EmplService_PK PRIMARY KEY (EmployeeID, ServiceID),
CONSTRAINT EmplService_FK1 FOREIGN KEY (EmployeeID)  REFERENCES Employee_T(EmployeeID),
CONSTRAINT EmplService_FK2 FOREIGN KEY (ServiceID)  REFERENCES Service_T(ServiceID));
 
-- Create Appointment Service Table
CREATE TABLE AppointService_T
	(AppointmentID	NUMERIC(11,0)	NOT NULL,
	ServiceID		NUMERIC(11,0)	NOT NULL,
CONSTRAINT AppointService_PK PRIMARY KEY (AppointmentID, ServiceID),
CONSTRAINT AppointService_FK1 FOREIGN KEY (AppointmentID)  REFERENCES Appointment_T(AppointmentID),
CONSTRAINT AppointService_FK2 FOREIGN KEY (ServiceID)  REFERENCES Service_T(ServiceID));


-- Inserting Data for Customer Table
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (1, 'John Smith', '(773) 699-2675')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (2, 'Tever Parker', '(261) 918-4114')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (3, 'Annetta Raynor', '(877) 720-0086')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (4, 'Stuart Klein', '(756) 763-4941')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (5, 'Clay Williamson', '(589) 273-3724')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (6, 'Maribel Balistreri', '(541) 980-7722')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (7, 'Heath Lehner', '(438) 710-1667')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (8, 'Hortense Herzog', '(988) 960-1438')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (9, 'Kyla Lubowit', '(956) 260-6570')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (10, 'Ansel Schinner', '(215) 887-3106')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (11, 'Abbie Mann', '(955) 523-0506')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (12, 'Magnus Kshlerin', '(899) 640-5537')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (13, 'Chaim Rowe', '(958) 331-6670')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (14, 'Odell Mosciski', '(519) 737-5886')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (15, 'Camille Rolfson', '(886) 796-8742')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (16, 'Alexanne Rath', '(748) 202-9614')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (17, 'Dannie Ratke', '(768) 237-1539')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (18, 'Stan Runte', '(508) 546-0557')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (19, 'Agusta Willms', '(648) 666-0092')
INSERT INTO Customer_T (CustomerID, CustomerName, CustomerPhone)
VALUES (20, 'Joana Ledner', '(575) 209-2665')

-- Inserting Data for Pet Table
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (001, 'Harper', 'Basenji',1)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (002, 'Kumar', 'Siberian Husky',2)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (003, 'Lester', 'Cairn Terrier',3)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (004, 'Poncho', 'Wire Fox Terrier',4)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (005, 'Marvin', 'Swedish Vallhund',5)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (006, 'Bugs', 'Lancashire Heeler',6)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (007, 'Cupid', 'Rottweiler',7)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (008, 'Sugar', 'Dalmatian',8)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (009, 'Otis', 'Bluetick Coonhound',9)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (010, 'Gambit', 'Yorkshire Terrier',10)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (011, 'Precious', 'Boston Terrier',11)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (012, 'Opal', 'Samoyed',12)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (013, 'Emmitt', 'Greyhound',13)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (014, 'Prancer', 'Siberian Husky',14)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (015, 'Bronze', 'Whippet',15)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (016, 'Bebop', 'Shetland Sheepdog',16)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (017, 'Lazy', 'Irish Terrier',17)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (018, 'Feather', 'Basenji',18)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (019, 'Kip', 'Chihuahua',19)
INSERT INTO Pet_T (PetID, PetName, Breed, CustomerID)
VALUES (020, 'Bro', 'Pointer',20)

-- Inserting Data for Boarding Table
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (01, '01:53', 001)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (02, '01:37', 002)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (03, '00:53', 003)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (04, '01:46', 004)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (05, '01:44', 005)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (06, '00:33', 006)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (07, '01:46', 007)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (08, '00:57', 008)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (09, '00:23', 009)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (10, '00:41', 010)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (01, '01:22', 011)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (02, '01:38', 012)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (03, '00:23', 013)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (04, '01:42', 014)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (05, '00:35', 015)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (06, '01:44', 016)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (07, '01:13', 017)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (08, '00:25', 018)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (09, '01:08', 019)
INSERT INTO Boarding_T (CageNumber, TimeInCage, PetID)
VALUES (10, '01:53', 020)

-- Inserting Data for Appointment Table
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0001, '2020-11-10', '09:30', 001, 1, 01)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0002, '2020-11-10', '10:00', 002, 2, 02)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0003, '2020-11-10', '10:30', 003, 3, 03)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0004, '2020-11-10', '10:30', 004, 4, 04)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0005, '2020-11-10', '11:00', 005, 5, 05)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0006, '2020-11-10', '11:30', 006, 6, 06)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0007, '2020-11-10', '01:00', 007, 7, 07)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0008, '2020-11-10', '02:00', 008, 8, 08)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0009, '2020-11-10', '02:30', 009, 9, 09)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0010, '2020-11-10', '03:00', 010, 10, 10)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0011, '2020-11-11', '09:00', 011, 11, 01)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0012, '2020-11-11', '09:30', 012, 12, 02)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0013, '2020-11-11', '11:00', 013, 13, 03)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0014, '2020-11-11', '11:00', 014, 14, 04)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0015, '2020-11-11', '11:30', 015, 15, 05)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0016, '2020-11-11', '12:00', 016, 16, 06)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0017, '2020-11-11', '01:00', 017, 17, 07)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0018, '2020-11-11', '01:30', 018, 18, 08)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0019, '2020-11-11', '02:00', 019, 19, 09)
INSERT INTO Appointment_T (AppointmentID, AppointmentDate, DropOffTime, PetID, CustomerID, CageNumber)
VALUES (0020, '2020-11-11', '02:00', 020, 20, 10)

-- Inserting Data for Service Table
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00001, '01:54', 'Wash/Cut', 0001)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00002, '02:40', 'Wash/Cut/Brush', 0002)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00003, '02:17', 'Wash/Cut/Brush', 0003)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00004, '02:41', 'Wash/Cut/Brush', 0004)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00005, '02:34', 'Wash/Cut/Brush', 0005)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00006, '01:36', 'Wash/Cut', 0006)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00007, '02:32', 'Wash/Cut/Brush', 0007)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00008, '00:55', 'Wash', 0008)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00009, '02:45', 'Wash/Cut/Brush', 0009)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00010, '02:33', 'Wash/Cut/Brush', 0010)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00011, '02:56', 'Wash/Cut/Brush', 0011)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00012, '02:27', 'Wash/Cut/Brush', 0012)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00013, '01:50', 'Wash/Cut', 0013)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00014, '02:08', 'Wash/Cut/Brush', 0014)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00015, '02:20', 'Wash/Cut/Brush', 0015)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00016, '00:49', 'Wash', 0016)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00017, '01:57', 'Wash/Cut', 0017)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00018, '00:51', 'Wash', 0018)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00019, '00:54', 'Wash', 0019)
INSERT INTO Service_T (ServiceID, ServiceTime, ServiceType, AppointmentID)
VALUES (00020, '01:02', 'Wash/Cut', 0020)

-- Inserting Data for Employee Table
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (01, 'William Morris', '1987-12-23', '(392) 513-8955', '832 Cobblestone St.', 'Folsom', 'CA', '95630')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (02, 'Freya Sharma', '1986-04-15', '(808) 376-6755', '4626 Eucalyptus Ave', 'Chino', 'CA', '91710')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (03, 'Isabelle Crawford', '1995-09-20', '(329) 612-5937', '26731 Aliso Creek Rd #200', 'Aliso Viejo', 'CA', '92656')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (04, 'Danyaal Millington', '1981-03-27', '(442) 999-6513', '110 Constitution Dr', 'Menlo Park', 'CA', '94025')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (05, 'Bary Sexton', '1986-08-13', '(745) 961-5579', '5651 Olive Ave', 'Rialto', 'CA', '92377')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (06, 'Jeremiah Maguire', '1981-09-24', '(998) 954-6635', '3833 Prospect Ave #1', 'Culver City', 'CA', '90232')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (07, 'Annaliese Myers', '1982-06-09', '(911) 253-9859', '3848 Overland Ave', 'Culver City', 'CA', '90232')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (08, 'Stephan Wells', '1980-11-05', '(350) 660-2417', '69 Happy Ln', 'San Rafael', 'CA', '94901')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (09, 'Finn Mecer', '1980-11-05', '(629) 593-7779', '69 Heather Garden Ln', 'Danville', 'CA', '94506')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (10, 'Rodney Shelton', '1970-12-22', '(315) 500-6907', '70 Manderly Rd', 'San Rafael', 'CA', '94901')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (11, 'Miranda Smyth', '2000-10-14', '(259) 803-8260', '410 7th St', 'Pacific Grove', 'CA', '93950')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (12, 'Piers Yu', '1989-05-10', '(876) 466-6715', '4 Ontare Rd', 'Arcadia', 'CA', '91006')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (13, 'Jordan Walton', '2000-08-10', '(804) 459-0481', '864 Alta Loma Dr.', 'South San Francisco', 'CA', '94080')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (14, 'Rukhsar Beard', '1989-05-10', '(566) 394-2915', '23 Shore St.', 'San Bernardino', 'CA', '92418')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (15, 'Dolcie Rahman', '1997-10-21', '(753) 692-8924', '907 Sheffield Street', 'Orange', 'CA', '92856')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (16, 'Summer Russell', '1985-05-30', '(800) 466-0665', '245 Providence Dr.', 'Trinidad', 'CA', '95570')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (17, 'Woody Hopper', '1993-11-13', '(930) 998-7048', '468 Johnson St.', 'Irvine', 'CA', '92623')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (18, 'Dale Rojas', '1999-08-25', '(529) 766-5366', '18 Bliss St', 'Fountain Valley', 'CA', '92708')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (19, 'Eliana Cartwright', '1989-01-04', '(540) 792-7302', '802 Indian Spring St', 'Orangevale', 'CA', '95662')
INSERT INTO Employee_T (EmployeeID, EmployeeName, EmployeeDOB, EmployeePhone, EmployeeStreet, EmployeeCity, EmployeeState, EmployeeZip)
VALUES (20, 'Cali Esparza', '1978-08-12', '(595) 934-3244', '7429 West Ebon Street', 'Gualala', 'CA', '95445')

-- Inserting Data for Equipment Table
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (1001, 'Brand A', 'Brush', 01)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (1002, 'Brand A', 'Brush', 02)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (1003, 'Brand B', 'Brush', 01)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (1004, 'Brand B', 'Brush', 05)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (1005, 'Brand C', 'Brush', 03)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (2001, 'Brand A', 'Hair Clippers', 01)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (2002, 'Brand A', 'Hair Clippers', 03)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (2003, 'Brand B', 'Hair Clippers', 05)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (2004, 'Brand C', 'Hair Clippers', 12)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (2005, 'Brand C', 'Hair Clippers', 02)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (3001, 'Brand A', 'Nail Clippers', 13)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (3002, 'Brand B', 'Nail Clippers', 20)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (3003, 'Brand B', 'Nail Clippers', 10)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (3004, 'Brand B', 'Nail Clippers', 05)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (3005, 'Brand C', 'Nail Clippers', 17)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (4001, 'Brand B', 'Towel', 01)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (4002, 'Brand B', 'Towel', 12)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (4003, 'Brand C', 'Towel', 11)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (4004, 'Brand C', 'Towel', 15)
INSERT INTO Equipment_T (EquipmentID, BrandName, EquipmentDescription, EmployeeID)
VALUES (4005, 'Brand C', 'Towel', 17)

-- Inserting Data for Billing Table
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10001, '2020-11-10', 10001, 90, 00001, 1)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10002, '2020-11-10', 10002, 60, 00002, 2)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10003, '2020-11-10', 10003, 90, 00003, 3)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10004, '2020-11-10', 10004, 90, 00004, 4)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10005, '2020-11-10', 10005, 30, 00005, 5)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10006, '2020-11-10', 10006, 60, 00006, 6)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10007, '2020-11-10', 10007, 90, 00007, 7)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10008, '2020-11-10', 10008, 60, 00008, 8)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10009, '2020-11-10', 10009, 60, 00009, 9)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10010, '2020-11-10', 10010, 90, 00010, 10)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10011, '2020-11-11', 10011, 30, 00011, 11)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10012, '2020-11-11', 10012, 30, 00012, 12)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10013, '2020-11-11', 10013, 30, 00013, 13)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10014, '2020-11-11', 10014, 60, 00014, 14)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10015, '2020-11-11', 10015, 90, 00015, 15)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10016, '2020-11-11', 10016, 90, 00016, 16)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10017, '2020-11-11', 10017, 90, 00017, 17)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10018, '2020-11-11', 10018, 90, 00018, 18)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10019, '2020-11-11', 10019, 30, 00019, 19)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10020, '2020-11-11', 10020, 60, 00020, 20)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10021, '2020-11-12', 10021, 60, 00021, 21)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10022, '2020-11-12', 10022, 90, 00022, 22)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10023, '2020-11-12', 10023, 90, 00023, 23)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10024, '2020-11-12', 10024, 60, 00024, 24)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10025, '2020-11-12', 10025, 90, 00025, 25)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10026, '2020-11-12', 10026, 30, 00026, 26)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10027, '2020-11-12', 10027, 30, 00027, 27)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10028, '2020-11-12', 10028, 90, 00028, 28)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10029, '2020-11-12', 10029, 30, 00029, 29)
INSERT INTO Billing_T (ReceiptID, ReceiptDate, ReceiptNumber, PaymentAmount, ServiceID, CustomerID)
VALUES (10030, '2020-11-12', 10030, 90, 00030, 30)

-- Inserting Data for Brush Station (Sub-type)
INSERT INTO Brush_T (ServiceID)
VALUES (00001)
INSERT INTO Brush_T (ServiceID)
VALUES (00002)
INSERT INTO Brush_T (ServiceID)
VALUES (00003)
INSERT INTO Brush_T (ServiceID)
VALUES (00004)
INSERT INTO Brush_T (ServiceID)
VALUES (00005)
INSERT INTO Brush_T (ServiceID)
VALUES (00006)
INSERT INTO Brush_T (ServiceID)
VALUES (00007)
INSERT INTO Brush_T (ServiceID)
VALUES (00008)
INSERT INTO Brush_T (ServiceID)
VALUES (00009)
INSERT INTO Brush_T (ServiceID)
VALUES (00010)

-- Inserting Data for Cut Station (Sub-type)
INSERT INTO Cut_T (ServiceID, TimeHair, TimeNails)
VALUES (00001, '01:20', '00:10')
INSERT INTO Cut_T (ServiceID, TimeHair, TimeNails)
VALUES (00002, '00:39', '00:11')
INSERT INTO Cut_T (ServiceID, TimeHair, TimeNails)
VALUES (00003, '00:40', '00:06')
INSERT INTO Cut_T (ServiceID, TimeHair, TimeNails)
VALUES (00004, '00:29', '00:15')
INSERT INTO Cut_T (ServiceID, TimeHair, TimeNails)
VALUES (00005, '01:31', '00:09')
INSERT INTO Cut_T (ServiceID, TimeHair, TimeNails)
VALUES (00006, '01:09', '00:10')
INSERT INTO Cut_T (ServiceID, TimeHair, TimeNails)
VALUES (00007, '01:05', '00:12')
INSERT INTO Cut_T (ServiceID, TimeHair, TimeNails)
VALUES (00008, '01:13', '00:05')
INSERT INTO Cut_T (ServiceID, TimeHair, TimeNails)
VALUES (00009, '01:03', '00:07')
INSERT INTO Cut_T (ServiceID, TimeHair, TimeNails)
VALUES (00010, '00:45', '00:08')

-- Inserting Data for Wash Station (Sub-type)
INSERT INTO Wash_T (ServiceID, WaterUsed, ShampooUsed)
VALUES (00001, '15 gallons', '4 ounces')
INSERT INTO Wash_T (ServiceID, WaterUsed, ShampooUsed)
VALUES (00002, '7 gallons', '3 ounces')
INSERT INTO Wash_T (ServiceID, WaterUsed, ShampooUsed)
VALUES (00003, '10 gallons', '7 ounces')
INSERT INTO Wash_T (ServiceID, WaterUsed, ShampooUsed)
VALUES (00004, '9 gallons', '9 ounces')
INSERT INTO Wash_T (ServiceID, WaterUsed, ShampooUsed)
VALUES (00005, '16 gallons', '2 ounces')
INSERT INTO Wash_T (ServiceID, WaterUsed, ShampooUsed)
VALUES (00006, '11 gallons', '7 ounces')
INSERT INTO Wash_T (ServiceID, WaterUsed, ShampooUsed)
VALUES (00007, '10 gallons', '3 ounces')
INSERT INTO Wash_T (ServiceID, WaterUsed, ShampooUsed)
VALUES (00008, '15 gallons', '4 ounces')
INSERT INTO Wash_T (ServiceID, WaterUsed, ShampooUsed)
VALUES (00009, '9 gallons', '5 ounces')
INSERT INTO Wash_T (ServiceID, WaterUsed, ShampooUsed)
VALUES (00010, '8 gallons', '5 ounces')

-- Inserting Data for Payment Method (??? Attribute)
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10001, 'Cash')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10002, 'Credit Card')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10003, 'Cash')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10004, 'Check')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10005, 'Cash')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10006, 'Credit Card')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10007, 'Credit Card')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10008, 'Credit Card')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10009, 'Cash')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10010, 'Cash')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10011, 'Cash')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10012, 'Credit Card')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10013, 'Credit Card')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10014, 'Cash')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10015, 'Credit Card')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10016, 'Check')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10017, 'Credit Card')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10018, 'Cash')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10019, 'Credit Card')
INSERT INTO Payment_T (ReceiptID, PaymentMethod)
VALUES (10020, 'Credit Card')

-- Inserting Data for Equipment Use (Relationship Attribute)
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (01, 10001, '09:09', '09:39', '2020-11-10')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (02, 10002, '11:03', '11:55', '2020-11-10')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (03, 10003, '10:34', '10:51', '2020-11-10')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (04, 20001, '04:11', '04:54', '2020-11-10')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (05, 20002, '01:55', '02:29', '2020-11-10')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (06, 40001, '12:47', '01:11', '2020-11-10')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (07, 30001, '05:31', '05:55', '2020-11-10')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (08, 40002, '05:08', '05:31', '2020-11-10')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (09, 10004, '04:31', '04:51', '2020-11-10')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (10, 20003, '09:13', '10:16', '2020-11-10')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (11, 30002, '02:47', '03:22', '2020-11-11')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (12, 30003, '12:28', '01:12', '2020-11-11')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (13, 40003, '04:18', '04:39', '2020-11-11')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (14, 30004, '10:16', '11:14', '2020-11-11')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (15, 20004, '02:15', '02:48', '2020-11-11')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (16, 10005, '12:07', '12:57', '2020-11-11')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (17, 20005, '02:51', '03:35', '2020-11-11')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (18, 30005, '03:26', '04:12', '2020-11-11')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (19, 40004, '11:37', '12:41', '2020-11-11')
INSERT INTO EquipUse_T (EmployeeID, EquipmentID, CheckOutTime, CheckInTime, EquipUseDate)
VALUES (20, 40005, '11:03', '11:49', '2020-11-11')

-- Inserting Data for Employee Services (Many to Many Relationship)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (01, 00001)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (02, 00002)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (03, 00003)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (04, 00004)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (05, 00005)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (06, 00006)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (07, 00007)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (08, 00008)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (09, 00009)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (10, 00010)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (11, 00011)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (12, 00012)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (13, 00013)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (14, 00014)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (15, 00015)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (16, 00016)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (17, 00017)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (18, 00018)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (19, 00019)
INSERT INTO EmplService_T (EmployeeID, ServiceID)
VALUES (20, 00020)

-- Inserting Data for Appointment Service (Many to Many Relationship)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0001, 00001)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0002, 00002)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0003, 00003)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0004, 00004)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0005, 00005)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0006, 00006)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0007, 00007)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0008, 00008)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0009, 00009)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0010, 00010)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0011, 00011)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0012, 00012)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0013, 00013)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0014, 00014)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0015, 00015)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0016, 00016)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0017, 00017)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0018, 00018)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0019, 00019)
INSERT INTO AppointService_T (AppointmentID, ServiceID)
VALUES (0020, 00020)

