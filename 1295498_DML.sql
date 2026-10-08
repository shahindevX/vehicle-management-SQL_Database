
----Question No.3 Insert Table Records.

USE VehicleDB
GO

INSERT INTO Customer(Customer_ID,Customer_Name,Phone,Present_Address,Permanent_Address,City,Email)
VALUES
('1','Shahin Alam','01812557428','Green Road','Haluaghat','Mymensingh','shahin123@gmail.com'),
('2','Masud Rana','01812554298','Uttara','Kurigram','Comilla','masud123@gmail.com'),
('3','Kajem','01812557898','Mirpur','Mirpur','Dhaka','kajem123@gmail.com'),
('4','Towhid','01812074298','New Market','Dhanmondi','Dhaka','towhid123@gmail.com'),
('5','Alam','01612557420','Green Road','Haluaghat','Mymensingh','alam123@gmail.com'),
('6','Rana','01912554290','Uttara','Kurigram','Comilla','rana123@gmail.com'),
('7','Kayum','01812557899','Savar','Mirpur','Dhaka','Kayum123@gmail.com'),
('8','Fahad','01812074297','New Market','New Market','Dhaka','fahad@gmail.com'),
('9','Imran','01812554296','Norsinghdi','Norshinghdi','Dhaka','imran123@gmail.com'),
('10','Zafir','01812447898','Mohammadpur','Mirpur','Dhaka','zafir123@gmail.com');

INSERT INTO Vehicle(Vehicle_ID,VIN,Make,Model,Year,Owner_ID)
VALUES('101','1HG889V287V234C23','Honda','Civic',2022,1),
('102','1HG909V287V234C23','Honda','Insight',2022,1),
('103','1HG889V287V234C24','Toyota','Avalon',2021,2),
('104','1VG889V287V234C25','Hero','HF_Deluxe',2022,3),
(105,'1HG889V287V234D11','Honda','City',2021,6),
(106,'1HG889V287V234D12','Toyota','Corolla',2020,10),
(107,'1HG889V287V234D13','Nissan','Altima',2022,9),
(108,'1HG889V287V234D14','Suzuki','Swift',2022,7),
(109,'1HG889V287V234D15','Ford','Figo',2021,8),
(110,'1HG889V287V234D16','Hyundai','Creta',2022,5);

INSERT INTO Vehicle_Status(Status_ID,Status_Name)
VALUES
(1,'Pending'),
(2,'In Progress'),
(3,'Completed');

INSERT INTO Repair(Repair_ID, Vehicle_ID, Repair_Date, Description, Cost, Status_ID)
VALUES
(301, 101, '2026-03-06', 'Engine Repair', 2500, 1),
(302, 102, '2026-03-06', 'Brake Repair', 1500, 1),
(303, 103, '2025-03-06', 'Engine Repair', 2500, 1),
(304, 104, '2020-01-01', 'Body Repair', 5000, 1),
(305, 105, '2022-03-06', 'Engine Repair', 2500, 1),
(306, 106, '2020-01-01', 'Tyre Repair', 1500, 1),
(307, 107, '2019-01-01', 'Engine Repair', 2500, 1),
(308, 108, '2020-01-01', 'Oil leak Repair', 5000, 1),
(309, 109, '2021-01-01', 'Transmission Repair', 2500, 1),
(310, 110, '2026-03-06', 'Battery Replacement', 1500, 1);

----Question No.4 Retrieve  All Data From Customer.

SELECT * FROM  Customer;

----Question No.5(Retrieve Last 5 Customers).

SELECT TOP 5 * FROM Customer
ORDER BY Customer_ID DESC;

----Question No.6 (Retrieve those city whose city is Dhaka).

SELECT Customer_Name,City FROM Customer
WHERE City='Dhaka';

----Question No.7(Retrieve Vehicles whose Model starts with 'H').

SELECT Make,Model,Year FROM 
Vehicle WHERE Make LIKE'H%';

----Question No.8(Retrieve those customers whose city are all except 'Comilla').

SELECT Customer_ID,Customer_Name,City 
FROM Customer WHERE City NOT IN('Comilla');

----Question No.09(Retrieve Vehicles with their owner names).

SELECT v.Vehicle_ID,v.Make,v.Model,c.Customer_Name 
FROM Vehicle AS v 
JOIN Customer AS c
ON v.Owner_ID=c.Customer_ID;

----Question No.10(Retrieve Vehicles Make & Model & Year ).

SELECT Vehicle_ID,Make,Model,
Year FROM Vehicle;

----Question No.11(Retrieve Repair_Date from 01-01-2020 to 31-01-2025).

SELECT * FROM Repair WHERE Repair_Date BETWEEN '2020-01-01' AND '2025-01-31';

----Question No.12 (Show services whose costing more than 2000).

SELECT Repair_ID,Vehicle_ID,Description,Cost
FROM Repair WHERE Cost>2000;

----Question No.13 (Retrieve Vehicles whose Model has one of the following characters:a,e,i,o,u).

SELECT Make,Model,Year FROM Vehicle WHERE Model LIKE'%a%'
OR Model LIKE'%e%'
OR Model LIKE'%i%'
OR Model LIKE'%o%'
OR Model LIKE'%u%';

----Question No.14 (Retrieve Vehicles whose Make starts T and Next letter is one of the A through Y).

SELECT *
FROM Vehicle
WHERE Make LIKE 'T[A-Y]%';

----Question No.15 (Retrieve Vehicles whose Make starts T and Next letter is  NOT one of the K through Y).

SELECT *
FROM Vehicle
WHERE Make LIKE 'T[^K-Y]%';

----Question No.16(Write a query to retrive 4 through 8 records from Customer table).

SELECT * FROM Customer
ORDER BY Customer_ID OFFSET 3 ROWS FETCH NEXT 5 ROWS ONLY

----Question No.17(Write a query to Retrieve the top 3 Customers who repair highest number of Vehicles).

SELECT TOP 3 c.Customer_Name,COUNT(r.Repair_ID) AS Total_Repairs
FROM Customer c
JOIN Vehicle v ON c.Customer_ID = v.Owner_ID
JOIN Repair r ON v.Vehicle_ID = r.Vehicle_ID
GROUP BY c.Customer_Name
ORDER BY Total_Repairs DESC;

----Question No.18(Sub-Query--Write a query to find Customers who have never had any vehicle repaired).

SELECT Customer_ID, Customer_Name
FROM Customer
WHERE Customer_ID NOT IN (
    SELECT v.Owner_ID
    FROM Vehicle v
    JOIN Repair r ON v.Vehicle_ID = r.Vehicle_ID
);

----Question No.19 Use of Aggregate function(Count(*) ---
  
SELECT COUNT(*) AS Total_Customers
FROM Customer;

----Question No.20 Use of Aggregate function(SUM)---

SELECT SUM(Cost) AS Total_Repair_Cost
FROM Repair;

----Question No.21 Use of Aggregate function (AVG)---

SELECT AVG(Cost) AS Average_Repair_Cost
FROM Repair;

----Question No.22 Use of Aggregate function (MAX)---

SELECT MAX(Cost) AS Max_Repair_Cost
FROM Repair;

----Question No.23 Use of Aggregate function (MIN)---

SELECT MIN(Cost) AS Min_Repair_Cost
FROM Repair;

----Question No.24 (Update Rows)---

UPDATE Vehicle
SET Model = 'Civic LX'
WHERE Vehicle_ID = 101;

----Question No.25 (Delete Rows)---

DELETE Vehicle
WHERE Vehicle_ID= 101;

----Question No.26 (Give an Example of Subquery)---

SELECT Customer_Name
FROM Customer
WHERE Customer_ID NOT IN(SELECT Owner_ID FROM Vehicle 
WHERE Vehicle_ID IN (
SELECT Vehicle_ID FROM Repair));

----Question No.27 (Give an Example of JOIN)---

SELECT 
    c.Customer_ID,
    c.Customer_Name,
    c.Phone,
    v.Make,
    v.Model,
    r.Repair_Date,
    r.Cost,
    s.Status_Name AS Repair_Status
FROM Customer c
JOIN Vehicle v ON c.Customer_ID = v.Owner_ID
JOIN Repair r ON v.Vehicle_ID = r.Vehicle_ID
JOIN Vehicle_Status s ON r.Status_ID = s.Status_ID;

----Question No.28 (Give an Example of LEFT JOIN)---

SELECT c.Customer_Name, v.Make, v.Model
FROM Customer c
LEFT JOIN Vehicle v
ON c.Customer_ID = v.Owner_ID;

----Question No.29 (Give an Example of RIGHT JOIN)---

SELECT c.Customer_Name, v.Make, v.Model
FROM Customer c
RIGHT JOIN Vehicle v
ON c.Customer_ID = v.Owner_ID;

----Question No.30 (Give an Example of EXISTS Operator)---

SELECT DISTINCT c.Customer_Name
FROM Customer c
WHERE EXISTS (SELECT 1 FROM Vehicle v
JOIN Repair r ON v.Vehicle_ID = r.Vehicle_ID 
WHERE v.Owner_ID = c.Customer_ID);

----Question No.31 (Use of Union)---

SELECT City AS Info
FROM Customer
UNION
SELECT Make
FROM Vehicle;

----Question No.32 (Use of GROUP BY)---

SELECT Vehicle_ID, AVG(Cost) AS Avg_Cost
FROM Repair
GROUP BY Vehicle_ID;

----Question No.33 (Give an example of CUBE Operator)---

SELECT Vehicle_ID, Status_ID, SUM(Cost) AS Total_Cost
FROM Repair
GROUP BY CUBE (Vehicle_ID, Status_ID);

----Question No.34 (Give an example of ROLLOUP Operator)---

SELECT Vehicle_ID, Status_ID, SUM(Cost) AS Total_Cost
FROM Repair
GROUP BY ROLLUP (Vehicle_ID, Status_ID);

----Question No.35 (Give an example of GROUPING SETS Operator)---

SELECT Vehicle_ID, Status_ID, SUM(Cost) AS Total_Cost
FROM Repair
GROUP BY GROUPING SETS((Vehicle_ID),(Status_ID));

----Question No.36 (Give an example of OVER clause)---

SELECT c.Customer_Name, v.Vehicle_ID, r.Cost, SUM(r.Cost) 
OVER (PARTITION BY c.Customer_ID) AS Total_Cost_Per_Customer
FROM Customer c
JOIN Vehicle v ON c.Customer_ID = v.Owner_ID
JOIN Repair r ON v.Vehicle_ID = r.Vehicle_ID;

----Question No.37 (Give an example of ANY Keyword)---

SELECT Repair_ID, Vehicle_ID, Cost FROM Repair
WHERE Cost > ANY (SELECT Cost FROM Repair
WHERE YEAR(Repair_Date) = 2020);

----Question No.38 (Give an example of ALL Keyword)---

SELECT Repair_ID, Vehicle_ID, Cost FROM Repair
WHERE Cost > ALL (SELECT Cost
FROM Repair WHERE YEAR(Repair_Date) = 2020);

----Question No.39 (Give an example of SOME Keyword)---

SELECT Vehicle_ID, VIN, Model FROM Vehicle
WHERE Vehicle_ID IN (SELECT Vehicle_ID FROM Repair
WHERE Cost < SOME (SELECT Cost
FROM Repair  WHERE YEAR(Repair_Date) = 2026));

----Question No.40 (Give an example of CTE)---

WITH Customer_Repair_Cost AS (
SELECT c.Customer_ID,c.Customer_Name,
SUM(r.Cost) AS Total_Repair_Cost FROM Customer c
JOIN Vehicle v ON c.Customer_ID = v.Owner_ID
JOIN Repair r ON v.Vehicle_ID = r.Vehicle_ID
GROUP BY c.Customer_ID, c.Customer_Name)

SELECT *
FROM Customer_Repair_Cost
WHERE Total_Repair_Cost > 5000;


----Question No.41 (Give an example of CASE FUNCTION)---

SELECT Repair_ID,Vehicle_ID,Cost, 
CASE WHEN Cost < 2000 THEN 'Low'
WHEN Cost BETWEEN 2000 AND 4000 
THEN 'Medium'
ELSE 'High'
END AS Cost_Category FROM Repair;

----Question No.42 (Give an example of SEARCH CASE FUNCTION)---

SELECT Repair_ID,Vehicle_ID,Cost,
CASE WHEN Cost < 2000 THEN 'Low'
WHEN Cost BETWEEN 2000 AND 4000 
THEN 'Medium'
ELSE 'High'
END AS Cost_Category
FROM Repair;

----Question No.43 (IIF Function)---

SELECT Repair_ID, Cost,
IIF(Cost > 3000, 'Expensive', 'Affordable') AS PriceCategory
FROM Repair
ORDER BY Cost;

----Question No.44 (CHOOSE Function)---

SELECT Status_ID,
CHOOSE (Status_ID, 'Pending', 'In Progress', 'Completed') AS StatusCategory
FROM Vehicle_Status;

----Question No.45 (COALESCE Function)---

SELECT Customer_ID, Customer_Name, City,
COALESCE (City, 'Unknown City') AS ResolvedCity
FROM Customer;

----Question No.46 (ISNULL Function)---

SELECT Customer_ID, Customer_Name, Present_Address,
ISNULL (Present_Address, 'Address Not Provided') AS NewAddress
FROM Customer;

----Question No.47 (GROUPING Function)---

SELECT 
CASE WHEN GROUPING(Email) = 1 THEN 'ALL' ELSE Email END AS Email,
CASE WHEN GROUPING(City) = 1 THEN 'ALL' ELSE City END AS City,
COUNT(*) AS CustomerCount
FROM Customer
WHERE City IN ('Dhaka', 'Comilla')
GROUP BY City, Email WITH ROLLUP
ORDER BY City, Email;

----Question No.48 (Ranking Function ROW_NUMBER)---

SELECT ROW_NUMBER() OVER(PARTITION BY City ORDER BY City) AS CityGroupRow,
Customer_ID, Customer_Name, City
FROM Customer;

----Question No.49 (Ranking Function RANK and DENSE_RANK)---

SELECT RANK() OVER(ORDER BY Cost DESC) AS CostRank,
DENSE_RANK() OVER(ORDER BY Cost DESC) AS CostDenseRank,
Repair_ID, Vehicle_ID, Cost
FROM Repair;

----Question No.50 (Ranking Function NTILE Function)---

SELECT Repair_ID, Description, Cost,
NTILE(2) OVER(ORDER BY Cost) AS TwoGroups,
NTILE(3) OVER(ORDER BY Cost) AS ThreeGroups,
NTILE(4) OVER(ORDER BY Cost) AS FourGroups
FROM Repair;

----Question No.51 Analytic Functions(FIRST_VALUE)---

SELECT Repair_ID, Vehicle_ID, Repair_Date, Cost,
FIRST_VALUE(Cost) OVER(PARTITION BY Vehicle_ID ORDER BY Repair_Date) AS FirstRepairCost
FROM Repair;

----Question No.52 Analytic Functions(LAST_VALUE)---

SELECT Repair_ID, Vehicle_ID, Repair_Date, Cost,
LAST_VALUE(Cost) OVER(PARTITION BY Vehicle_ID ORDER BY Repair_Date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LastRepairCost
FROM Repair;

----Question No.53 Analytic Functions(LEAD)---

SELECT Repair_ID, Vehicle_ID, Repair_Date, Cost,
LEAD(Cost) OVER(PARTITION BY Vehicle_ID ORDER BY Repair_Date) AS NextRepairCost
FROM Repair;

----Question No.54 Analytic Functions(LAG)---

SELECT Repair_ID, Vehicle_ID, Repair_Date, Cost,
LAG(Cost) OVER(PARTITION BY Vehicle_ID ORDER BY Repair_Date) AS PreviousRepairCost
FROM Repair;

----Question No.55 Analytic Functions(PERCENT_RANK)---

SELECT Repair_ID, Vehicle_ID, Cost,
PERCENT_RANK() OVER(PARTITION BY Vehicle_ID ORDER BY Cost) AS CostPercentRanking
FROM Repair;

----Question No.56 Analytic Functions(CUME_DIST)---

SELECT Repair_ID, Vehicle_ID, Cost,
CUME_DIST() OVER(PARTITION BY Vehicle_ID ORDER BY Cost) AS CumulativeDistribution
FROM Repair;

----Question No.57 Analytic Functions(PERCENTILE_CONT)---

SELECT Repair_ID, Vehicle_ID, Cost,
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Cost DESC) 
OVER(PARTITION BY Vehicle_ID) AS MedianCost
FROM Repair;

----Question No.58 Analytic Functions(PERCENTILE_DISC)---

SELECT Repair_ID, Vehicle_ID, Cost,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY Cost DESC) 
OVER(PARTITION BY Vehicle_ID) AS DiscreteMedianCost
FROM Repair;

----Question No.59 (SELECT INTO Clause)---

SELECT * INTO RepairArchive
FROM Repair
WHERE Cost > 3000;

----Question No.60 (CREATE VIEW Justify)---
--SELECT * FROM vu_RepairDetails;

----Question No.61 (VIEW with ENCRYPTION Justify)---
--EXEC sp_helptext vu_CustomerVehicles;

----Question No.62 (VIEW with SCHEMABINDING Justify)---
--EXEC sp_helptext vu_RepairCostSchemabinding;

----Question No.63 (VIEW with SCHEMABINDING & ENCRYPTION Justify)---

--EXEC sp_helptext vu_VehicleStatusEncryptSchemabind;

----Question No.64 (ALTER VIEW Justify)---

--SELECT * FROM vu_CustomerVehicles;

----Question No.65 (CREATE an Updatable View Justify)---

--UPDATEvu_HondaVehicles;

----Question No.66 (ALTER Updatable View Justify)---

--ALTER vu_HondaVehicles;

----Question No.67 (Create View With Check Option Justify)---

--EXEC vu_ToyotaVehicles_With_Check;

----Question No.68 (DROP VIEW Justify)---
--EXEC vu_VehicleStatusEncryptSchemabind;

----Question No.69 (Store Procedure Justify)---
--EXEC spCustomerRepairSummary;
--EXEC spCustomerByCity @City = 'Dhaka';

----Question No.70 (ALTER Procedure Justify)---

--EXEC spCustomerByCity;
--EXEC spCustomerByCity @City = 'Chittagong';

----Question No.71 (Create PROCEDURE WITH ENCRYPTION Justify)---
--EXEC spHighCostRepairs;

----Question No.72 (Create PROCEDURE WITH RECOMPILE Justify)---

--EXEC spPendingRepairs;

----Question No.73 (Create PROCEDURE WITH ENCRYPTION and RECOMPILE Justify)---
--EXEC spSecureAndFreshRepairs;

----Question No.74 (INSERT PROCEDURE Justify)---
--EXEC spAddCustomer 101, 'Rahim Uddin', '01711223344', 'Dhanmondi', 'Comilla', 'Dhaka', 'rahim@email.com';

----Question No.75 (Procedure with error handling Justify)---
--EXEC spAddCustomerWithTryCatch 5, 'Rahim', '01712345678', 'rahim@gmail.com';

----Question No.76 (DROP Function Justify)---
--EXEC spHighCostRepairs;























