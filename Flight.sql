--CREATE DATABASE Flight;

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


--IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TypeRoute]') AND type in (N'U'))
-- BEGIN
--	CREATE TABLE TypeRoute(
--		id int PRIMARY KEY IDENTITY(1,1),
--		Name varchar(50)
--	)
-- END
--GO



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

--IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RouteStop]') AND type in (N'U'))
-- BEGIN
--	CREATE TABLE RouteStop(
--		id int PRIMARY KEY IDENTITY(1,1),
--		StopSecuence int,
--		ArrivalTime time,
--		idAirport int,
--		FOREIGN kEY (idAirport) REFERENCES Airport(id) 
--			ON UPDATE CASCADE
--			ON DELETE CASCADE
--	)
-- END
--GO



--IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Route]') AND type in (N'U'))
--BEGIN
--    CREATE TABLE Route (
--        id INT PRIMARY KEY IDENTITY(1,1),
--		Title varchar(50),
--        idRouteStop INT,
--		idTypeRoute INT,
--        FOREIGN KEY (idRouteStop) REFERENCES RouteStop(id) 
--			ON UPDATE CASCADE 
--			ON DELETE CASCADE,
--		 FOREIGN KEY (idTypeRoute) REFERENCES TypeRoute(id) 
--			ON UPDATE CASCADE 
--			ON DELETE CASCADE
--    );
--END
--GO



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





















/*--------------------------------------------------------------*/

-- Insertar datos en Customer
--INSERT INTO Customer (Name, DateOfBirth) VALUES 
--('John Doe', '1980-01-15'),
--('Jane Smith', '1992-07-23');

---- Insertar datos en PaymentMethod
--INSERT INTO PaymentMethod (MethodName, Description) VALUES 
--('Credit Card', 'Visa Credit Card'),
--('PayPal', 'PayPal Account');

---- Insertar datos en FrequentFlyerCard
--INSERT INTO FrequentFlyerCard (FFCNumber, idCustomer, Miles, MealCode) VALUES 
--(123456, 1, 5000, 'VGML'),
--(789012, 2, 3000, 'KSML');

---- Insertar datos en Airport
--INSERT INTO Airport (Name) VALUES 
--('JFK International Airport'),
--('Los Angeles International Airport'),
--('Heathrow Airport');

---- Insertar datos en la tabla FlightNumber
--INSERT INTO FlightNumber (DepartureTime, Description, Type, idAirportStart, idAirportGoal) VALUES
--('06:00:00', 'Early Morning Flight to NYC', 'Domestic', 1, 2),
--('09:30:00', 'Mid-Morning Flight to London', 'International', 3, 4),
--('13:15:00', 'Afternoon Flight to Tokyo', 'International', 5, 1),
--('17:45:00', 'Evening Flight to Paris', 'International', 2, 3),
--('22:00:00', 'Late Night Flight to Sydney', 'International', 4, 5);
--GO

---- Insertar datos en Airplane
--INSERT INTO Airplane (RegistrationNumber, BeginOfOperation, Status) VALUES 
--('N12345', '2010-05-01', 'Active'),
--('N67890', '2015-03-15', 'Under Maintenance');

---- Insertar datos en PlaneModel
--INSERT INTO PlaneModel (Description, Graphic, idAirplane) VALUES 
--('Boeing 747', NULL, 1),
--('Airbus A380', NULL, 2);

---- Insertar datos en Seat
--INSERT INTO Seat (Size, Number, Location, idPlaneModel) VALUES 
--('Economy', 1, 'A1', 1),
--('Business', 2, 'B1', 2),
--('Economy', 3, 'C1', 1),
--('Business', 4, 'D1', 2),
--('Economy', 5, 'E1', 1),
--('Business', 6, 'F1', 2),
--('Economy', 7, 'G1', 1),
--('Business', 8, 'H1', 2),
--('Economy', 9, 'I1', 1),
--('Business', 10, 'J1', 2);
--GO


---- Insertar datos en Country
--INSERT INTO Country (Name) VALUES 
--('United States'),
--('United Kingdom');

---- Insertar datos en Airline
--INSERT INTO Airline (Name) VALUES 
--('Delta Airlines'),
--('British Airways');

---- Insertar datos en la tabla Flight
--INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, idFlightNumber, idCountryStart, idCountryEnd, idAirline) VALUES
--('05:30:00', '2024-09-15', 'A12', 'Counter 5', 1, 1, 2, 1),
--('08:45:00', '2024-09-16', 'B22', 'Counter 8', 2, 3, 4, 2),
--('12:00:00', '2024-09-17', 'C18', 'Counter 3', 3, 5, 1, 3),
--('16:30:00', '2024-09-18', 'D10', 'Counter 7', 4, 2, 3, 4),
--('21:00:00', '2024-09-19', 'E5', 'Counter 1', 5, 4, 5, 5);
--GO
---- Insertar datos en Ticket
--INSERT INTO Ticket (TicketingCode, idCustomer, idFlight) VALUES 
--('ABC123', 1, 1),
--('DEF456', 2, 2);

---- Insertar datos en AvailableSeat
--INSERT INTO AvailableSeat (idFlight, idSeat) VALUES 
--(1, 1),
--(2, 2),
--(3, 3),
--(4, 4),
--(5, 5),
--(1, 6),
--(2, 7),
--(3, 8),
--(4, 9),
--(5, 10);
--GO

---- Insertar datos en la tabla Coupon
--INSERT INTO Coupon (DateOfRedemption, Class, Standby, MealCode, idTicket, idAvailableSeat) VALUES
--('2024-09-01', 'Economy', 0, 'VEG', 1, 1),
--('2024-09-02', 'Business', 1, 'NON', 2, 2),
--('2024-09-03', 'First Class', 0, 'GLUTEN_FREE', 3, 3),
--('2024-09-04', 'Economy', 1, 'NON', 4, 4),
--('2024-09-05', 'Business', 0, 'VEG', 5, 5);
--GO
---- Insertar datos en PiecesOfLuggage
--INSERT INTO PiecesOfLuggage (Number, Weight, idCoupon) VALUES 
--(2, 23.5, 1),
--(1, 15.0, 2);

---- Insertar datos en Payment
--INSERT INTO Payment (idTicket, idPaymentMethod, Amount, PaymentDate) VALUES 
--(1, 1, 299.99, '2024-08-15'),
--(2, 2, 399.99, '2024-08-20');



---- Insertar datos en la tabla Employee
--INSERT INTO Employee (Name, Position, HireDate, Salary) VALUES 
--('John Doe', 'Pilot', '2015-06-15', 75000.00),
--('Jane Smith', 'Flight Attendant', '2017-03-22', 40000.00),
--('Robert Brown', 'Co-Pilot', '2016-11-10', 65000.00),
--('Emily Davis', 'Ground Staff', '2018-01-05', 35000.00),
--('Michael Johnson', 'Aircraft Mechanic', '2014-09-30', 50000.00);
--GO



---- Insertar datos en la tabla Crew
--INSERT INTO Crew (idFlight, idEmployee, Role) VALUES 
--(1, 1, 'Pilot'),
--(1, 2, 'Flight Attendant'),
--(2, 3, 'Co-Pilot'),
--(2, 4, 'Ground Staff'),
--(3, 5, 'Aircraft Mechanic');
--GO