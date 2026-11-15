
USE TrackNestDB;
GO

-- Use an existing customer for demonstration data.
DECLARE @CustomerID INT;

SELECT TOP 1 @CustomerID = CustomerID
FROM dbo.Customers
ORDER BY CustomerID;

IF @CustomerID IS NULL
BEGIN
    PRINT 'Register a customer before inserting sample orders.';
    RETURN;
END;

-- Insert sample orders only if they do not already exist.
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderNumber = 'TN-1001')
    INSERT INTO dbo.Orders
        (CustomerID, StoreName, OrderNumber, OrderDate, OrderStatus)
    VALUES
        (@CustomerID, 'Daraz', 'TN-1001', GETDATE(), 'Shipped');

IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderNumber = 'TN-1002')
    INSERT INTO dbo.Orders
        (CustomerID, StoreName, OrderNumber, OrderDate, OrderStatus)
    VALUES
        (@CustomerID, 'Amazon', 'TN-1002', GETDATE(), 'In Transit');

IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderNumber = 'TN-1003')
    INSERT INTO dbo.Orders
        (CustomerID, StoreName, OrderNumber, OrderDate, OrderStatus)
    VALUES
        (@CustomerID, 'AliExpress', 'TN-1003', GETDATE(), 'Delivered');

-- Add shipments only when the order exists and has no shipment.
IF NOT EXISTS (SELECT 1 FROM dbo.Shipments WHERE TrackingNumber = 'TN-TRACK-001')
    INSERT INTO dbo.Shipments
        (OrderID, TrackingNumber, CourierName, CurrentStatus, LastUpdated)
    SELECT OrderID, 'TN-TRACK-001', 'TCS', 'In Transit', GETDATE()
    FROM dbo.Orders WHERE OrderNumber = 'TN-1001'
      AND NOT EXISTS (
          SELECT 1 FROM dbo.Shipments s WHERE s.OrderID = dbo.Orders.OrderID
      );

IF NOT EXISTS (SELECT 1 FROM dbo.Shipments WHERE TrackingNumber = 'TN-TRACK-002')
    INSERT INTO dbo.Shipments
        (OrderID, TrackingNumber, CourierName, CurrentStatus, LastUpdated)
    SELECT OrderID, 'TN-TRACK-002', 'Leopard', 'Out for Delivery', GETDATE()
    FROM dbo.Orders WHERE OrderNumber = 'TN-1002'
      AND NOT EXISTS (
          SELECT 1 FROM dbo.Shipments s WHERE s.OrderID = dbo.Orders.OrderID
      );

IF NOT EXISTS (SELECT 1 FROM dbo.Shipments WHERE TrackingNumber = 'TN-TRACK-003')
    INSERT INTO dbo.Shipments
        (OrderID, TrackingNumber, CourierName, CurrentStatus, LastUpdated)
    SELECT OrderID, 'TN-TRACK-003', 'TCS', 'Delivered', GETDATE()
    FROM dbo.Orders WHERE OrderNumber = 'TN-1003'
      AND NOT EXISTS (
          SELECT 1 FROM dbo.Shipments s WHERE s.OrderID = dbo.Orders.OrderID
      );

-- Add one initial event per sample shipment if none exists.
INSERT INTO dbo.TrackingEvents
    (ShipmentID, Status, Location, Description, EventTime)
SELECT s.ShipmentID, s.CurrentStatus, 'Pakistan',
       'Sample tracking event for demonstration', GETDATE()
FROM dbo.Shipments s
WHERE s.TrackingNumber IN
    ('TN-TRACK-001', 'TN-TRACK-002', 'TN-TRACK-003')
AND NOT EXISTS (
    SELECT 1 FROM dbo.TrackingEvents e
    WHERE e.ShipmentID = s.ShipmentID
);

PRINT 'Sample data script completed.';
GO
