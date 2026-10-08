
  ----Question No.1(Create Database)----

--USE master
--GO
--IF DB_ID('VehicleDB') IS NOT NULL
--DROP DATABASE VehicleDB
--GO
--CREATE DATABASE VehicleDB
--ON(
--Name='VehicleDB_Data_1',
--FileName='C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\VehicleDB_Data_1.mdf',
--Size=25mb,
--MaxSize=100mb,
--FileGrowth=5%
--)
--LOG ON(
--Name='VehicleDB_Log_1',
----FileName='C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\VehicleDB_Log_1.ldf',
----Size=2mb,
----MaxSize=50mb,
----FileGrowth=1mb
----)
-- GO

     ----Question No.2(Create Tables)----

 USE VehicleDB
 GO

 CREATE TABLE Customer
(Customer_ID INT PRIMARY KEY,
Customer_Name varchar(50) NOT NULL,
Phone varchar(20) NOT NULL,
Present_Address varchar(50) NULL,
Permanent_Address varchar(50) NULL,
City varchar(20)NULL,
Email varchar(100) NOT NULL
);

CREATE TABLE Vehicle(
Vehicle_ID INT PRIMARY KEY,
VIN VARCHAR(17) NOT NULL UNIQUE,
Make VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL,
Year INT NOT NULL,
Owner_ID INT NOT NULL,
FOREIGN KEY(Owner_ID)REFERENCES Customer(Customer_ID)
);

CREATE TABLE Vehicle_Status
(Status_ID INT PRIMARY KEY NOT NULL,
Status_Name varchar(50));

CREATE TABLE Repair(
Repair_ID INT PRIMARY KEY,
Vehicle_ID INT,
Repair_Date Date,
Description VARCHAR(255),
Cost Decimal(8,2),
Status_ID INT Default 1,
FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(Vehicle_ID),
FOREIGN KEY (Status_ID) REFERENCES Vehicle_Status(Status_ID)
);



----Question No.77 Modify a Table (Add column)

ALTER TABLE Customer ADD Discount_Tier char(1);
GO

----Question No.78 Modify a Table (Alter column)

ALTER TABLE Customer ALTER COLUMN Phone varchar(25);
GO

----Question No.79 Modify a Table (Delete a column)

ALTER TABLE Customer ADD TempCol varchar(10);
GO
ALTER TABLE Customer DROP COLUMN TempCol;
GO

----Question No.80 CREATE VIEW

CREATE VIEW vu_RepairDetails AS
SELECT r.Repair_ID, v.Make, v.Model, c.Customer_Name, r.Cost, vs.Status_Name
FROM Repair r 
JOIN Vehicle v ON r.Vehicle_ID = v.Vehicle_ID
JOIN Customer c ON v.Owner_ID = c.Customer_ID
JOIN Vehicle_Status vs ON r.Status_ID = vs.Status_ID;
GO

----Question No.81 VIEW with ENCRYPTION

CREATE VIEW vu_CustomerVehicles 
WITH ENCRYPTION AS
SELECT c.Customer_ID,c.Customer_Name, v.VIN, v.Make, v.Model
FROM Customer c 
JOIN Vehicle v ON c.Customer_ID = v.Owner_ID;
GO

----Question No.82 VIEW with SCHEMABINDING

CREATE VIEW vu_RepairCostSchemabinding 
WITH SCHEMABINDING AS
SELECT r.Repair_ID, r.Cost, r.Description, v.VIN
FROM dbo.Repair r 
JOIN dbo.Vehicle v ON r.Vehicle_ID = v.Vehicle_ID;
GO

----Question No.83 VIEW with ENCRYPTION and SCHEMABINDING

CREATE VIEW vu_VehicleStatusEncryptSchemabind WITH ENCRYPTION, SCHEMABINDING AS
SELECT r.Repair_ID, r.Cost, v.Make, v.Model, vs.Status_Name
FROM dbo.Repair r 
JOIN dbo.Vehicle v ON r.Vehicle_ID = v.Vehicle_ID
JOIN dbo.Vehicle_Status vs ON r.Status_ID = vs.Status_ID;
GO

----Question No.84 ALTER VIEW

ALTER VIEW vu_CustomerVehicles 
WITH ENCRYPTION AS
SELECT c.Customer_ID, c.Customer_Name, c.Phone, v.VIN, v.Make, v.Model, v.Year
FROM Customer c 
JOIN Vehicle v ON c.Customer_ID = v.Owner_ID;
GO

----Question No.85 CREATE an Updatable View

CREATE VIEW vu_HondaVehicles AS
SELECT Vehicle_ID, VIN, Make, Model, Year, Owner_ID
FROM Vehicle
WHERE Make = 'Honda';
GO

----Question No.86 ALTER Updatable View

ALTER VIEW vu_HondaVehicles AS
SELECT Vehicle_ID, VIN, Make, Model, Year, Owner_ID
FROM Vehicle
WHERE Make = 'Honda' AND Year >= 2020;
GO

----Question No.87 Create View With Check Option

CREATE VIEW vu_ToyotaVehicles_With_Check AS
SELECT Vehicle_ID, VIN, Make, Model, Year, Owner_ID
FROM Vehicle
WHERE Make = 'Toyota'
WITH CHECK OPTION;
GO

----Question No.88 DROP VIEW

DROP VIEW vu_VehicleStatusEncryptSchemabind;
GO

----Question No.89 CREATE SEQUENCE

CREATE SEQUENCE RepairInvoiceSequence
START WITH 1000
INCREMENT BY 5;
GO

CREATE SEQUENCE GeneralSequence
AS int
START WITH 10
INCREMENT BY 10
MINVALUE 10
MAXVALUE 10000
CYCLE CACHE 10;
GO

----Question No.90 ALTER SEQUENCE

ALTER SEQUENCE GeneralSequence
INCREMENT BY 15
CACHE 5
CYCLE;
GO

----Question No.91 DROP SEQUENCE

DROP SEQUENCE GeneralSequence;
GO

----Question No.92 Store Procedure

CREATE PROC spCustomerRepairSummary
AS
BEGIN
SELECT c.Customer_ID, c.Customer_Name, c.Phone, SUM(r.Cost) AS TotalRepairCost
FROM Customer c
JOIN Vehicle v ON c.Customer_ID = v.Owner_ID
JOIN Repair r ON v.Vehicle_ID = r.Vehicle_ID
GROUP BY c.Customer_ID, c.Customer_Name, c.Phone;
END;
GO

CREATE PROC spCustomerByCity
    @City varchar(20)
AS
SELECT Customer_Name, Phone, Present_Address
FROM Customer
WHERE City = @City;
GO

----Question No.93 ALTER Procedure

ALTER PROC spCustomerByCity
    @City varchar(20) = NULL
AS
BEGIN
IF @City IS NULL
SELECT Customer_Name, Phone, Present_Address, City FROM Customer;
ELSE
SELECT Customer_Name, Phone, Present_Address, City FROM Customer WHERE City = @City;
END;
GO

----Question No.94 Create PROCEDURE WITH ENCRYPTION

CREATE PROC spHighCostRepairs
WITH ENCRYPTION
AS
BEGIN
SELECT * FROM Repair WHERE Cost > 2000;
END;
GO

----Question No.95 Create PROCEDURE WITH RECOMPILE

CREATE PROC spPendingRepairs
WITH RECOMPILE
AS
BEGIN
SELECT * FROM Repair WHERE Status_ID = 1;
END;
GO

----Question No.96 Create PROCEDURE WITH ENCRYPTION and RECOMPILE

CREATE PROC spCompletedRepairs
WITH ENCRYPTION, RECOMPILE
AS
BEGIN
SELECT * FROM Repair WHERE Status_ID = 3;
END;
GO

----Question No.97 Create PROCEDURE with Required Parameter 

CREATE PROC spGetVehicleByMake
@Make varchar(50)
AS
BEGIN
SELECT * FROM Vehicle WHERE Make = @Make;
END;
GO

----Question No.98 Create PROCEDURE with Optional Parameter and Output Parameter

CREATE PROC spCalculateTotalRepairCost
    @VehicleID INT = NULL,
    @TotalCost DECIMAL(8,2) OUTPUT
AS
BEGIN
IF @VehicleID IS NULL
SELECT @TotalCost = SUM(Cost) FROM Repair;
ELSE
SELECT @TotalCost = SUM(Cost) FROM Repair WHERE Vehicle_ID = @VehicleID;
END;
GO

----Question No.99 INSERT PROCEDURE 

CREATE PROC spAddCustomer
    @CustomerID INT,
    @CustomerName varchar(50),
    @Phone varchar(25),
    @PresentAddress varchar(50),
    @PermanentAddress varchar(50),
    @City varchar(20),
    @Email varchar(100)
AS
BEGIN
INSERT INTO Customer (Customer_ID, Customer_Name, Phone, Present_Address, Permanent_Address, City, Email)
VALUES (@CustomerID, @CustomerName, @Phone, @PresentAddress, @PermanentAddress, @City, @Email);
END;
GO

----Question No.100 Create a procedure using THROW 

CREATE PROC spInsertRepairWithCheck
    @RepairID INT,
    @VehicleID INT,
    @RepairDate DATE,
    @Description VARCHAR(255),
    @Cost DECIMAL(8,2),
    @StatusID INT
AS
BEGIN
IF EXISTS (SELECT * FROM Vehicle WHERE Vehicle_ID = @VehicleID)
INSERT INTO Repair (Repair_ID, Vehicle_ID, Repair_Date, Description, Cost, Status_ID)
VALUES (@RepairID, @VehicleID, @RepairDate, @Description, @Cost, @StatusID);
ELSE
THROW 50001, 'Not a valid Vehicle ID', 1;
END;
GO

----Question No.101 Creates a User-Defined Table Type

CREATE TYPE VehicleTypeTable AS TABLE(
Vehicle_ID int NOT NULL,
VIN varchar(17) NOT NULL,
PRIMARY KEY (Vehicle_ID));
GO

----Question No.102 Create Procedure that accepts a table type as a parameter

CREATE PROC spAddVehiclesFromTable
@VehicleTable VehicleTypeTable READONLY
AS
BEGIN
SELECT * FROM @VehicleTable;
END;
GO

----Question No.103 Multiple Action Procedure without Transaction and Error Handling

CREATE PROC spManageVehicleStatus
    @OperationType char(1),
    @StatusID int,
    @StatusName varchar(50) = NULL
AS
BEGIN
IF @OperationType = 'S'
SELECT * FROM Vehicle_Status;

IF @OperationType = 'I'
INSERT INTO Vehicle_Status (Status_ID, Status_Name) VALUES (@StatusID, @StatusName);

IF @OperationType = 'U'
UPDATE Vehicle_Status SET Status_Name = @StatusName WHERE Status_ID = @StatusID;

IF @OperationType = 'D'
DELETE FROM Vehicle_Status WHERE Status_ID = @StatusID;
END;
GO

----Question No.104 Procedure with error handling

CREATE PROC spAddCustomerWithTryCatch
    @CustomerID INT,
    @CustomerName varchar(50),
    @Phone varchar(25),
    @Email varchar(100)
AS
BEGIN
BEGIN TRY
INSERT INTO Customer (Customer_ID, Customer_Name, Phone, Email)
VALUES (@CustomerID, @CustomerName, @Phone, @Email);
END TRY
BEGIN CATCH
SELECT ERROR_NUMBER() AS ErNum, ERROR_MESSAGE() AS ErMsg, ERROR_SEVERITY() AS ErSever, ERROR_LINE() AS ErLine;
END CATCH
END;
GO

----Question No.105 Procedure with Transaction

CREATE PROC spInsertRepairWithTx
    @RepairID INT, 
    @VehicleID INT, 
    @Cost DECIMAL(8,2)
AS
BEGIN
BEGIN TRY
BEGIN TRAN
INSERT INTO Repair (Repair_ID, Vehicle_ID, Repair_Date, Description, Cost, Status_ID)
VALUES (@RepairID, @VehicleID, GETDATE(), 'General Service', @Cost, 1);
COMMIT TRAN
END TRY
BEGIN CATCH
ROLLBACK TRAN
END CATCH
END;
GO

----Question No.106 DROP PROCEDURE
DROP PROC spHighCostRepairs;
GO

----Question No.107 Create Scalar-valued Function
CREATE FUNCTION fnGetTotalRepairsForVehicle (@VehicleID INT)
RETURNS INT
AS
BEGIN
RETURN (SELECT COUNT(*) FROM Repair WHERE Vehicle_ID = @VehicleID);
END;
GO

CREATE FUNCTION fnGetTotalSpentByCustomer (@CustomerID INT)
RETURNS DECIMAL(8,2)
AS
BEGIN
RETURN (SELECT SUM(Cost) FROM Repair r JOIN Vehicle v 
ON r.Vehicle_ID = v.Vehicle_ID WHERE v.Owner_ID = @CustomerID);
END;
GO

----Question No.108 Create Simple/Inline Table-valued Function
CREATE FUNCTION fnTopSpendingCustomers (@MinSpent DECIMAL(8,2))
RETURNS TABLE
AS
RETURN (SELECT c.Customer_Name, SUM(r.Cost) AS TotalSpent
FROM Customer c
JOIN Vehicle v ON c.Customer_ID = v.Owner_ID
JOIN Repair r ON v.Vehicle_ID = r.Vehicle_ID
GROUP BY c.Customer_Name
HAVING SUM(r.Cost) > @MinSpent);
GO

----Question No.109 Create Multi-statement Table-valued Function
CREATE FUNCTION fnCustomerRepairHistory (@CustomerID INT)
RETURNS @RepairHistory TABLE (
CustomerName varchar(50), VehicleModel varchar(50), RepairDate DATE, Description varchar(255), Cost DECIMAL(8,2))
AS
BEGIN
INSERT INTO @RepairHistory
SELECT c.Customer_Name, v.Model, r.Repair_Date, r.Description, r.Cost
FROM Customer c
JOIN Vehicle v ON c.Customer_ID = v.Owner_ID
JOIN Repair r ON v.Vehicle_ID = r.Vehicle_ID
WHERE c.Customer_ID = @CustomerID;
RETURN;
END;
GO

----Question No.110 Create Function With Encryption and Schemabinding

CREATE FUNCTION fnGetStatusName (@StatusID INT)
RETURNS VARCHAR(50)
WITH ENCRYPTION, SCHEMABINDING
AS
BEGIN
DECLARE @Name varchar(50);
SELECT @Name = Status_Name FROM dbo.Vehicle_Status WHERE Status_ID = @StatusID;
RETURN @Name;
END;
GO

----Question No.111 Alter Function

ALTER FUNCTION fnGetStatusName (@StatusID INT)
RETURNS VARCHAR(60)
WITH ENCRYPTION, SCHEMABINDING
AS
BEGIN
DECLARE @Name varchar(60);
SELECT @Name = 'Status: ' + Status_Name FROM dbo.Vehicle_Status WHERE Status_ID = @StatusID;
RETURN @Name;
END;
GO

----Question No.112 DROP Function

DROP FUNCTION fnCustomerRepairHistory;
GO

