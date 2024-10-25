IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Flight')
BEGIN
    CREATE DATABASE Flight;
    PRINT 'Database Flight created successfully.';
END
ELSE
BEGIN
    PRINT 'Database Flight already exists.';
END

Use Flight;


--Select PA�S from PaisesExcel;

-- Verificaci�n y creaci�n de la tabla Country
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



-- Verificaci�n y creaci�n de la tabla Airline
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Airline]') AND type in (N'U'))
BEGIN
    CREATE TABLE Airline(
        id INT PRIMARY KEY IDENTITY(1,1),
        Name VARCHAR(100)
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




IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TicketClass]') AND type in (N'U'))
 BEGIN
 CREATE TABLE TicketClass(
  id int PRIMARY KEY IDENTITY(1,1),
  ClassName varchar(50),
  Price int,
 )
 END
GO



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Benefit]') AND type in (N'U'))
 BEGIN
 CREATE TABLE Benefit(
  id int PRIMARY KEY IDENTITY(1,1),
  Name varchar(100),
 )
 END
GO


-- Creaci�n de la tabla PaymentMethod
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentMethod]') AND type in (N'U'))
BEGIN
    CREATE TABLE PaymentMethod (
        id INT PRIMARY KEY IDENTITY(1,1),
        MethodName VARCHAR(50),
        Description VARCHAR(255)
    );
END
GO




IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClass]') AND type in (N'U'))
 BEGIN
 CREATE TABLE CustomerClass(
  id int PRIMARY KEY IDENTITY(1,1),
  ClassName varchar(50),
  Discount int,
  idBenefit int,
  FOREIGN KEY (idBenefit) REFERENCES Benefit(id)
   ON UPDATE CASCADE
   ON DELETE CASCADE,
 )
 END
GO

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



-- Creaci�n de la tabla FrequentFlyerCard
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


-- Verificaci�n y creaci�n de la tabla Airport
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

-- Verificaci�n y creaci�n de la tabla Crew
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

-- Verificaci�n y creaci�n de la tabla PlaneModel
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PlaneModel]') AND type in (N'U'))
BEGIN
    CREATE TABLE PlaneModel (
        id INT PRIMARY KEY IDENTITY(1,1),
        Description VARCHAR(255),
        Graphic VARBINARY(MAX),
    );
END
GO



-- Verificaci�n y creaci�n de la tabla Airplane
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


-- Verificaci�n y creaci�n de la tabla Flight
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


-- Verificaci�n y creaci�n de la tabla Ticket
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Ticket]') AND type in (N'U'))
BEGIN
    CREATE TABLE Ticket (
        id INT PRIMARY KEY IDENTITY(1,1),
  TicketingCode INT,
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
















-- Creaci�n de la tabla Payment
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


-- Verificaci�n y creaci�n de la tabla Seat
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


-- Verificaci�n y creaci�n de la tabla AvailableSeat
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



-- Verificaci�n y creaci�n de la tabla PiecesOfLuggage POSIBLE ERROR
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



IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Survey]') AND type in (N'U'))
 BEGIN
 CREATE TABLE Survey(
  id int PRIMARY KEY IDENTITY(1,1),
  Date varchar(100),
  Rating int,
  idFlight int, 
  idCustomer int,
  FOREIGN KEY (idFlight) REFERENCES Flight(id)
   ON UPDATE CASCADE
   ON DELETE CASCADE,
  FOREIGN KEY (idCustomer) REFERENCES Customer(id)
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
  FOREIGN KEY (idSurvey) REFERENCES Survey(id)
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


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Refund]') AND type in (N'U'))
 BEGIN
 CREATE TABLE Refund(
  id int PRIMARY KEY IDENTITY(1,1),
  Amount int,
  Date date,
  idTicket int, 
  FOREIGN kEY (idTicket) REFERENCES Ticket(id) 
   ON UPDATE NO ACTION
   ON DELETE NO ACTION,
  
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


INSERT INTO Country (Name)
SELECT PA�S 
FROM PaisesExcel;

go

INSERT INTO Airline(Name)
SELECT Airline
FROM AerolineasExcel;
go



BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @RandomName NVARCHAR(255); -- Aseg�rate de que el tipo de dato sea adecuado para los nombres
    DECLARE @i INT = 1;

    WHILE @i <= 500
    BEGIN
        -- Selecciona un nombre aleatorio en cada iteraci�n
        SELECT TOP 1 @RandomName = Nombres FROM NombresPersonasExcel ORDER BY NEWID();
        
        INSERT INTO Employee (Name, Salary)
        VALUES (
            @RandomName,
            (1000 + (@i * 50)) -- Salario din�mico basado en el n�mero del empleado
        );
        
        SET @i = @i + 1;
    END

    -- Si todo sale bien, hacemos commit de la transacci�n
    COMMIT TRANSACTION;
    PRINT 'Transacci�n completada con �xito.';
    
END TRY
BEGIN CATCH
    -- Si ocurre alg�n error, hacemos rollback para deshacer todos los cambios
    ROLLBACK TRANSACTION;
    PRINT 'Error en la transacci�n. Todos los cambios fueron revertidos.';
    -- Opcional: Mostrar el error
    THROW;
END CATCH;

go



INSERT INTO Airport (Name, idCountry, idAirline)
VALUES
('John F. Kennedy International Airport', 1, 2),
('Los Angeles International Airport', 1, 1),
('Heathrow Airport', 2, 3),
('Tokyo Haneda Airport', 1, 3),
('Sydney Airport',3, 1);

go

INSERT INTO FlightNumber (DepartureTime, Description, Type, idAirline, idAirportStart, idAirportGol) 
VALUES ('08:30:00', 'Flight to New York', 'International', 1, 1, 2);

go
INSERT INTO FlightNumber (DepartureTime, Description, Type, idAirline, idAirportStart, idAirportGol) 
VALUES ('09:45:00', 'Flight to Toronto', 'International', 2, 2, 3);

go
INSERT INTO FlightNumber (DepartureTime, Description, Type, idAirline, idAirportStart, idAirportGol) 
VALUES ('11:00:00', 'Flight to Mexico City', 'International', 3, 3, 1);
go


INSERT INTO Crew (Name, idEmployee) VALUES ('Crew John', 1);
INSERT INTO Crew (Name, idEmployee) VALUES ('Crew Jane', 2);
INSERT INTO Crew (Name, idEmployee) VALUES ('Crew Mike', 3);

go
INSERT INTO PlaneModel (Description, Graphic)
VALUES
('Boeing 737-800', NULL), 
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

go


-- Flight 2k 
BEGIN TRANSACTION;

BEGIN TRY
    DECLARE @RandomFlightNumber INT, @RandomCrew INT, @RandomAirPlane INT;

    DECLARE @i INT = 1;
    WHILE @i <= 2000
    BEGIN
        -- Seleccionar FlightNumber, Crew y AirPlane aleatoriamente en cada iteraci�n
        SELECT TOP 1 @RandomFlightNumber = id FROM FlightNumber ORDER BY NEWID();
        SELECT TOP 1 @RandomCrew = id FROM Crew ORDER BY NEWID();
        SELECT TOP 1 @RandomAirPlane = id FROM AirPlane ORDER BY NEWID();

        -- Generar una hora aleatoria para BoardingTime
        DECLARE @RandomTime TIME = DATEADD(SECOND, ROUND(RAND() * 86400, 0), '00:00:00'); -- 86400 segundos en un d�a

        -- Insertar los datos
        INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, idFlightNumber, idCrew, idAirPlane)
        VALUES (
            @RandomTime, -- Hora de embarque aleatoria
            DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 30, GETDATE()), -- Fecha aleatoria dentro de los pr�ximos 30 d�as
            'Gate ' + CAST(ROUND(RAND() * 20, 0) AS VARCHAR(2)), -- N�mero de gate aleatorio
            'Counter ' + CAST(ROUND(RAND() * 10, 0) AS VARCHAR(2)), -- N�mero de counter aleatorio
            @RandomFlightNumber, -- FlightNumber aleatorio
            @RandomCrew, -- Crew aleatorio
            @RandomAirPlane -- AirPlane aleatorio
        );
        SET @i = @i + 1;
   END;

    COMMIT TRANSACTION;
    PRINT 'Data inserted successfully into Flight table.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error occurred while inserting data into Flight table.';
END CATCH;
GO



INSERT INTO Service (Name) VALUES
('WiFi'),
('In-flight entertainment'),
('Meal service'),
('Priority boarding'),
('Extra legroom');

go


INSERT INTO TicketClass (ClassName, Price) VALUES
('Economy', 150),
('Business', 300),
('First Class', 500),
('Premium Economy', 250),
('Ultra Low-Cost', 100);

go
INSERT INTO Benefit (Name) VALUES
('Lounge access'),
('Extra baggage'),
('Fast-track security'),
('In-flight meals'),
('Flexible ticketing');

INSERT INTO PaymentMethod (MethodName, Description) VALUES
('Credit Card', 'Payment by credit card'),
('Debit Card', 'Payment by debit card'),
('PayPal', 'Payment via PayPal'),
('Cash', 'Payment in cash'),
('Bank Transfer', 'Direct bank transfer');

go



go
INSERT INTO Seat (Size, idPlaneModel) VALUES
( 0, 3),
( 10, 2),
( 10, 4),
( 20, 5),
( 40, 1);

go
INSERT INTO AvailableSeat (idSeat, idFlight) VALUES
( 2, 1),
( 3, 1),
( 4, 2),
( 2, 2),
( 3, 3);

go


go
INSERT INTO CustomerClass (ClassName, Discount, idBenefit) VALUES
('Class1', 10,1),
('Class2', 30,3),
('Class3', 50,4),
('Class4', 20,2),
('Class5', 10,5);

go
INSERT INTO Customer (Name, idCustomerClass) VALUES
('Name1',1),
('Name2',3),
('Name3',4),
('Name4',2),
('Name5',5);

go
INSERT INTO Document (Title, Image, idCustomer) VALUES
('Titulo1', null,1),
('Titulo2', null,3),
('Titulo3', null,4),
('Titulo4', null,2),
('Titulo5', null,5);

go
INSERT INTO City (Name,idCountry) VALUES
('Ciudad1',5),
('Ciudad2',2),
('Ciudad3',3),
('Ciudad4',4),
('Ciudad5',5);

go
INSERT INTO AirlineService (Name,idAirline,idService ,idTicketClass) VALUES
('Ciudad1',5,1,1),
('Ciudad2',2,5,4),
('Ciudad3',3,2,3),
('Ciudad4',4,5,2),
('Ciudad5',5,5,5);

go
INSERT INTO FlightDelay (Duration,Reason,idFlight) VALUES
('3','Reason1',1),
('2','Reason2',2),
('1','Reason3',3),
('4','Reason4',4),
('5','Reason5',5);


INSERT INTO Survey (Date,Rating,idFlight,idCustomer) VALUES
('10:30:00',1,1,5),
('11:30:00',2,2,1),
('12:30:00',3,3,4),
('13:30:00',4,4,3),
('14:30:00',5,5,3);

go
INSERT INTO Comment (Text,idSurvey) VALUES
('Text1',1),
('Text2',2),
('Text3',3),
('Text4',4)











