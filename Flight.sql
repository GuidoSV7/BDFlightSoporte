CREATE DATABASE Flight;

Use Flight;



-- Verificación y creación de la tabla Country
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Country]') AND type in (N'U'))
BEGIN
    CREATE TABLE Country(
        id INT PRIMARY KEY IDENTITY(1,1),
        Name VARCHAR(30)
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Service]') AND type in (N'U'))
 BEGIN
	CREATE TABLE Service(
		id int PRIMARY KEY IDENTITY(1,1),
		Name varchar(50),
	)
 END
GO



-- Verificación y creación de la tabla Airline
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Airline]') AND type in (N'U'))
BEGIN
    CREATE TABLE Airline(
        id INT PRIMARY KEY IDENTITY(1,1),
        Name VARCHAR(30)
    );
END
GO





IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
 BEGIN
	CREATE TABLE Employee(
		id int PRIMARY KEY IDENTITY(1,1),
		Name varchar(50),
		Salary int,
	)
 END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PassengerType]') AND type in (N'U'))
 BEGIN
	CREATE TABLE PassengerType(
		id int PRIMARY KEY IDENTITY(1,1),
		Name varchar(50),
		Price int,
	)
 END
GO



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TicketClass]') AND type in (N'U'))
 BEGIN
	CREATE TABLE TicketClass(
		id int PRIMARY KEY IDENTITY(1,1),
		ClassName varchar(50),
		Price int,
	)
 END
GO

--

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Benefit]') AND type in (N'U'))
 BEGIN
	CREATE TABLE Benefit(
		id int PRIMARY KEY IDENTITY(1,1),
		Name varchar(100),
	)
 END
GO


-- Creación de la tabla PaymentMethod
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentMethod]') AND type in (N'U'))
BEGIN
    CREATE TABLE PaymentMethod (
        id INT PRIMARY KEY IDENTITY(1,1),
        MethodName VARCHAR(50),
        Description VARCHAR(255)
    );
END
GO


-- Creación de la tabla PaymentMethod
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MealOption]') AND type in (N'U'))
BEGIN
    CREATE TABLE MealOption (
        id INT PRIMARY KEY IDENTITY(1,1),
        Vegetarian bit,
        GlutenFree bit,
		Vegan bit
	);
END
GO

-------------------------------------------------------------------------------------


-- Verificar y crear la tabla Customer si no existe
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type in (N'U'))
BEGIN

    CREATE TABLE Customer (
        id INT PRIMARY KEY IDENTITY(1,1),
        Name VARCHAR(100),
		idCustomerClass int,
		FOREIGN KEY (idCustomerClass) REFERENCES CustomerClass(id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
    );
END
GO



-- Creación de la tabla FrequentFlyerCard
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FrequentFlyerCard]') AND type in (N'U'))
BEGIN
    CREATE TABLE FrequentFlyerCard (
        id INT PRIMARY KEY IDENTITY(1,1),
        FFCNumber INT,
        Miles INT,
        MealCode VARCHAR(50),
        idCustomer INT,
        FOREIGN KEY (idCustomer) REFERENCES Customer(id)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FrequentFlyerCard]') AND type in (N'U'))
BEGIN
    CREATE TABLE Refound (
        id INT PRIMARY KEY IDENTITY(1,1),
        Amount INT,
        Date Date,
        idTicket INT,
        FOREIGN KEY (idTicket) REFERENCES Ticket(id)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
    );
END
GO

-- Verificación y creación de la tabla PlaneModel
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PlaneModel]') AND type in (N'U'))
BEGIN
    CREATE TABLE PlaneModel (
        id INT PRIMARY KEY IDENTITY(1,1),
        Description VARCHAR(255),
        Graphic VARBINARY(MAX),
    );
END
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FlightNumber]') AND type in (N'U'))
BEGIN
    CREATE TABLE FlightNumber (
        id INT PRIMARY KEY IDENTITY(1,1),
        DepartureTime TIME,
        Description varchar(100),
        Type VARCHAR(50),
        idAirline INT,
        idAirportStart INT,
        idAirportGol INT,
        FOREIGN KEY (idAirportStart) REFERENCES Airport(id)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
        FOREIGN KEY (idAirportGol) REFERENCES Airport(id)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
        FOREIGN KEY (idAirline) REFERENCES Airline(id)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
      
        CONSTRAINT chk_CountryDiff CHECK (idAirportStart <> idAirportGol)
    );
END
GO


-- Verificación y creación de la tabla Crew
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Crew]') AND type in (N'U'))
BEGIN
    CREATE TABLE Crew (
        id INT PRIMARY KEY IDENTITY(1,1),
		Name varchar(50),
        idEmployee INT,
        FOREIGN KEY (idEmployee) REFERENCES Employee(id) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE
    );
END
GO





-- Verificación y creación de la tabla Flight
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Flight]') AND type in (N'U'))
BEGIN
    CREATE TABLE Flight (
        id INT PRIMARY KEY IDENTITY(1,1),
        BoardingTime TIME,
        FlightDate DATE,
        Gate VARCHAR(50),
        CheckInCounter VARCHAR(50),
        idFlightNumber INT,
        idCrew INT,
		idAirPlane INT,
        --idRoute INT,
        FOREIGN KEY (idFlightNumber) REFERENCES FlightNumber(id)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
        FOREIGN KEY (idCrew) REFERENCES Crew(id)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
        FOREIGN KEY (idAirPlane) REFERENCES AirPlane(id)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
        
    );
END
GO




-- Verificación y creación de la tabla Ticket
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ticket]') AND type in (N'U'))
BEGIN
    CREATE TABLE Ticket (
        id INT PRIMARY KEY IDENTITY(1,1),
        idCustomer INT,
        idFlight INT,
        idTicketClass INT,
        FOREIGN KEY (idCustomer) REFERENCES Customer(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
        FOREIGN KEY(idFlight) REFERENCES Flight(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
		FOREIGN KEY (idTicketClass) REFERENCES TicketClass(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    );
END
GO


-- Creación de la tabla Payment
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Payment]') AND type in (N'U'))
BEGIN
    CREATE TABLE Payment (
        id INT PRIMARY KEY IDENTITY(1,1),
        Amount DECIMAL(10, 2),
		Date date,
        idTicket INT,
        idPaymentMethod INT,
        FOREIGN KEY (idTicket) REFERENCES Ticket(id) 
            ON UPDATE CASCADE 
            ON DELETE CASCADE,
        FOREIGN KEY (idPaymentMethod) REFERENCES PaymentMethod(id) 
            ON UPDATE CASCADE 
            ON DELETE SET NULL
    );
END
GO


-- Verificación y creación de la tabla Seat
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Seat]') AND type in (N'U'))
BEGIN
    CREATE TABLE Seat (
        id INT PRIMARY KEY IDENTITY(1,1),
        Size int,
        idPlaneModel INT,
        FOREIGN KEY (idPlaneModel) REFERENCES PlaneModel(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
    );
END
GO


-- Verificación y creación de la tabla AvailableSeat
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AvailableSeat]') AND type in (N'U'))
BEGIN
    CREATE TABLE AvailableSeat (
        id INT PRIMARY KEY IDENTITY(1,1),
        idFlight INT,
        idSeat INT,
        FOREIGN KEY (idFlight) REFERENCES Flight(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
        FOREIGN KEY (idSeat) REFERENCES Seat(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
    );
END
GO



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Coupon]') AND type in (N'U'))
BEGIN
    CREATE TABLE Coupon (
        id INT PRIMARY KEY IDENTITY(1,1),
        DateOfRedemption DATE,
        Class VARCHAR(50),
        Standby BIT,
        MealCode VARCHAR(50),
        idTicket INT,
		idFlight INT,
		idAvailableSeat INT,
        FOREIGN KEY (idTicket) REFERENCES Ticket(id)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,  -- Cambiado a NO ACTION
		FOREIGN KEY (idFlight) REFERENCES Flight(id)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,  -- Cambiado a NO ACTION
		FOREIGN KEY (idAvailableSeat) REFERENCES AvailableSeat(id)
            ON UPDATE NO ACTION  -- Cambiado a NO ACTION
            ON DELETE NO ACTION,  -- Cambiado a NO ACTION
    );
END
GO



-- Verificación y creación de la tabla PiecesOfLuggage POSIBLE ERROR
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PiecesOfLuggage]') AND type in (N'U'))
BEGIN
    CREATE TABLE PiecesOfLuggage (
        id INT PRIMARY KEY IDENTITY(1,1),
        Number INT,
        Weight DECIMAL(5, 2),
        idCoupon INT,
        FOREIGN KEY (idCoupon) REFERENCES Coupon(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
    );
END
GO




IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[City]') AND type in (N'U'))
 BEGIN
	CREATE TABLE City(
		id int PRIMARY KEY IDENTITY(1,1),
		Name varchar(50),
		idCountry int,
		FOREIGN KEY (idCountry) REFERENCES Country(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
	)
 END
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Passenger]') AND type in (N'U'))
 BEGIN
	CREATE TABLE Passenger(
		id int PRIMARY KEY IDENTITY(1,1),
		idPassengerType int,
		FOREIGN KEY (idPassengerType) REFERENCES PassengerType(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
	)
 END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClass]') AND type in (N'U'))
 BEGIN
	CREATE TABLE CustomerClass(
		id int PRIMARY KEY IDENTITY(1,1),
		ClassName varchar(50),
		Discount int,
		idBenefit int,
		FOREIGN KEY	(idBenefit) REFERENCES Benefit(id)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
	)
 END
GO


---*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-**-*

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Survey]') AND type in (N'U'))
 BEGIN
	CREATE TABLE Survey(
		id int PRIMARY KEY IDENTITY(1,1),
		Date varchar(100),
		Rating int,
		idFlight int, 
		idCustomer int,
		FOREIGN KEY	(idFlight) REFERENCES Flight(id)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		FOREIGN KEY	(idCustomer) REFERENCES Customer(id)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
	)
 END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Comment]') AND type in (N'U'))
 BEGIN
	CREATE TABLE Comment(
		id int PRIMARY KEY IDENTITY(1,1),
		Text varchar(100),
		idSurvey int,
		FOREIGN KEY	(idSurvey) REFERENCES Survey(id)
			ON UPDATE CASCADE
			ON DELETE CASCADE,
	)
 END
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AirlineService]') AND type in (N'U'))
 BEGIN
	CREATE TABLE AirlineService(
		id int PRIMARY KEY IDENTITY(1,1),
		Name varchar(30),
		idAirline int,
		idService int, 
		idTicketClass int,
		FOREIGN kEY (idAirline) REFERENCES Airline(id) 
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		FOREIGN kEY (idService) REFERENCES Service(id) 
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		FOREIGN kEY (idTicketClass) REFERENCES TicketClass(id) 
			ON UPDATE CASCADE
			ON DELETE CASCADE

	)
 END
GO

-- Verificación y creación de la tabla Airport
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Airport]') AND type in (N'U'))
BEGIN
    CREATE TABLE Airport (
        id INT PRIMARY KEY IDENTITY(1,1),
        Name VARCHAR(80),
		idCountry int,
		idAirline int,
		FOREIGN kEY (idCountry) REFERENCES Country(id) 
			ON UPDATE CASCADE
			ON DELETE CASCADE,
		FOREIGN kEY (idAirline) REFERENCES Airline(id) 
			ON UPDATE CASCADE
			ON DELETE CASCADE


    );
END
GO


-- Verificación y creación de la tabla Airplane
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Airplane]') AND type in (N'U'))
BEGIN
    CREATE TABLE Airplane (
        id INT PRIMARY KEY IDENTITY(1,1),
        RegistrationNumber VARCHAR(50),
        BeginOfOperation DATE,
        Status VARCHAR(50),
		idPlaneModel int,
		FOREIGN kEY (idPlaneModel) REFERENCES PlaneModel(id) 
			ON UPDATE CASCADE
			ON DELETE CASCADE
		
    );
END
GO




IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FlightDelay]') AND type in (N'U'))
BEGIN
    CREATE TABLE FlightDelay (
        id INT PRIMARY KEY IDENTITY(1,1),
		Duration int,
		Reason varchar(50),
        idFlight INT,
        FOREIGN KEY (idFlight) REFERENCES Flight(id) 
			ON UPDATE CASCADE 
			ON DELETE CASCADE,
    );
END
GO




--********************************



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MealSelecction]') AND type in (N'U'))
BEGIN
    CREATE TABLE MealSelecction (
        id INT PRIMARY KEY IDENTITY(1,1),
        idTicket INT,
		idMealOption INT,
        FOREIGN KEY (idTicket) REFERENCES Ticket(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
        FOREIGN KEY(idMealOption) REFERENCES MealOption(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    );
END
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fine]') AND type in (N'U'))
 BEGIN
	CREATE TABLE Fine(
		id int PRIMARY KEY IDENTITY(1,1),
		Amount int,
		Date date,
		Description varchar(100),
		idTicket int, 
		idCustomer int,
		FOREIGN kEY (idTicket) REFERENCES Ticket(id) 
			ON UPDATE NO ACTION
			ON DELETE NO ACTION,
		FOREIGN kEY (idCustomer) REFERENCES Customer(id) 
			ON UPDATE NO ACTION
			ON DELETE NO ACTION
	)
 END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Document]') AND type in (N'U'))
BEGIN
    CREATE TABLE Document (
        id INT PRIMARY KEY IDENTITY(1,1),
        Title varchar(30),
		Image VARBINARY(MAX),
		idCustomer int,
        FOREIGN KEY (idCustomer) REFERENCES Customer(id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
       
    );
END
GO


INSERT INTO Country (Name) VALUES ('USA');
INSERT INTO Country (Name) VALUES ('Canada');
INSERT INTO Country (Name) VALUES ('Mexico');


INSERT INTO Airline (Name) VALUES ('American Airlines');
INSERT INTO Airline (Name) VALUES ('Air Canada');
INSERT INTO Airline (Name) VALUES ('Aeromexico');

INSERT INTO Employee (Name, Salary) VALUES ('John Smith', 50000);
INSERT INTO Employee (Name, Salary) VALUES ('Jane Doe', 55000);
INSERT INTO Employee (Name, Salary) VALUES ('Mike Johnson', 60000);

INSERT INTO Airport (Name, idCountry, idAirline)
VALUES
('John F. Kennedy International Airport', 1, 2),
('Los Angeles International Airport', 1, 1),
('Heathrow Airport', 2, 3),
('Tokyo Haneda Airport', 1, 3),
('Sydney Airport',3, 1);



/*************************************************/

INSERT INTO FlightNumber (DepartureTime, Description, Type, idAirline, idAirportStart, idAirportGol) 
VALUES ('08:30:00', 'Flight to New York', 'International', 1, 1, 2);

INSERT INTO FlightNumber (DepartureTime, Description, Type, idAirline, idAirportStart, idAirportGol) 
VALUES ('09:45:00', 'Flight to Toronto', 'International', 2, 2, 3);

INSERT INTO FlightNumber (DepartureTime, Description, Type, idAirline, idAirportStart, idAirportGol) 
VALUES ('11:00:00', 'Flight to Mexico City', 'International', 3, 3, 1);

select * from FlightNumber

INSERT INTO Crew (Name, idEmployee) VALUES ('Crew John', 1);
INSERT INTO Crew (Name, idEmployee) VALUES ('Crew Jane', 2);
INSERT INTO Crew (Name, idEmployee) VALUES ('Crew Mike', 3);


INSERT INTO PlaneModel (Description, Graphic)
VALUES
('Boeing 737-800', NULL),  -- NULL para el campo Graphic si no se inserta un archivo binario
('Airbus A320', NULL),
('Boeing 787 Dreamliner', NULL),
('Airbus A350-900', NULL),
('Embraer E190', NULL);

INSERT INTO Airplane (RegistrationNumber, BeginOfOperation, Status, idPlaneModel)
VALUES
('N12345', '2010-05-12', 'Active', 1),
('G-ABCD', '2015-08-21', 'Active', 2),
('JA8901', '2008-11-03', 'Maintenance', 3),
('VH-OQA', '2012-07-15', 'Active', 4),
('C-FGHI', '2019-01-30', 'Retired', 5);

INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, idFlightNumber, idCrew, idAirPlane)
VALUES ('07:30:00', '2024-09-22', 'Gate A1', 'Counter 5', 2, 1, 1);

INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, idFlightNumber, idCrew, idAirPlane)
VALUES ('09:00:00', '2024-09-22', 'Gate B2', 'Counter 6', 2, 2, 2);

INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, idFlightNumber, idCrew, idAirPlane)
VALUES ('10:45:00', '2024-09-22', 'Gate C3', 'Counter 7', 3, 3, 3);

select * from Flight




















