
IF DB_ID('TrackNestDB') IS NULL
BEGIN
    EXEC('CREATE DATABASE TrackNestDB');
END;
GO

USE TrackNestDB;
GO

-- 1. Customers
IF OBJECT_ID('dbo.Customers', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Customers (
        CustomerID INT IDENTITY(1,1) PRIMARY KEY,
        FullName NVARCHAR(100) NOT NULL,
        Email NVARCHAR(255) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(100) NOT NULL,
        CreatedAt DATETIME2 DEFAULT SYSDATETIME()
    );
END;
GO

-- 2. Orders
IF OBJECT_ID('dbo.Orders', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Orders (
        OrderID INT IDENTITY(1,1) PRIMARY KEY,
        CustomerID INT NOT NULL,
        StoreName NVARCHAR(100) NOT NULL,
        OrderNumber NVARCHAR(100) NOT NULL,
        OrderDate DATETIME2 DEFAULT SYSDATETIME(),
        OrderStatus NVARCHAR(50) NOT NULL,
        CONSTRAINT FK_Orders_Customers
            FOREIGN KEY (CustomerID)
            REFERENCES dbo.Customers(CustomerID)
    );
END;
GO

-- 3. Shipments
IF OBJECT_ID('dbo.Shipments', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Shipments (
        ShipmentID INT IDENTITY(1,1) PRIMARY KEY,
        OrderID INT NOT NULL UNIQUE,
        TrackingNumber NVARCHAR(100) NOT NULL,
        CourierName NVARCHAR(100) NOT NULL,
        CurrentStatus NVARCHAR(50) NOT NULL,
        LastUpdated DATETIME2 DEFAULT SYSDATETIME(),
        CONSTRAINT FK_Shipments_Orders
            FOREIGN KEY (OrderID)
            REFERENCES dbo.Orders(OrderID)
    );
END;
GO

-- 4. Tracking Events
IF OBJECT_ID('dbo.TrackingEvents', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.TrackingEvents (
        EventID INT IDENTITY(1,1) PRIMARY KEY,
        ShipmentID INT NOT NULL,
        Status NVARCHAR(100) NOT NULL,
        Location NVARCHAR(150),
        Description NVARCHAR(500),
        EventTime DATETIME2 DEFAULT SYSDATETIME(),
        CONSTRAINT FK_TrackingEvents_Shipments
            FOREIGN KEY (ShipmentID)
            REFERENCES dbo.Shipments(ShipmentID)
    );
END;
GO

PRINT 'TrackNest database setup completed.';
