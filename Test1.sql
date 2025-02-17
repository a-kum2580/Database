CREATE DATABASE Test1;
USE Test1;

CREATE TABLE Crops(
    Crop_ID INT PRIMARY KEY,
    Crop_Name VARCHAR(50) NOT NULL,
    Type VARCHAR(50) NOT NULL,
    Season VARCHAR(50) NOT NULL
);

CREATE TABLE Farmer_Crop(
    Farmer_Crop_ID INT PRIMARY KEY,
    Farmer_ID INT,
    Crop_ID INT,
    Farmer_Nmae VARCHAR(50),
    Area_Cultivated DECIMAL(10,2),
    Yield INT,
    FOREIGN KEY (Crop_ID) REFERENCES Crops(Crop_ID)
);

CREATE TABLE Sales_Transaction(
    Transaction_ID INT PRIMARY KEY,
    Farmer_Crop_ID INT,
    Market_ID INT,
    DATE DATETIME,
    Quantity_sold INT,
    Price_Per_Unit DECIMAL(10,2),
    FOREIGN KEY (Farmer_Crop_ID) REFERENCES Farmer_Crop(Farmer_Crop_ID)
);

INSERT INTO Crops(Crop_ID, Crop_Name, Type, Season) VALUES (101, 'Coffee', 'Cash_crop', 'Rainy'), (102, 'Maize', 'Food_crop', 'Dry'), (103, 'Beans', 'Food_crop', 'Rainy'), (104, 'Mango', 'Fruits', 'Dry');
select * from Crops;
ALTER TABLE Farmer_Crop CHANGE COLUMN Farmer_Nmae FName VARCHAR(50);
DESC Farmer_Crop;

INSERT INTO Farmer_Crop(Farmer_Crop_ID, Farmer_ID, Crop_ID, FName, Area_Cultivated, Yield) VALUES (1, 1, 101, 'Badde', 2, 1000), (2, 1, 102, 'Nambi', 6, 700), (3, 3, 103, 'Mazedde', 2.5, 400), (4, 4, 102, 'Kimuli', 3, 300);
SELECT * FROM Farmer_Crop;

INSERT INTO Sales_Transaction(Transaction_ID, Farmer_Crop_ID, Market_ID, DATE, Quantity_sold, Price_Per_Unit) VALUES (301, 1, 201, '2024-01-15', 500, 3), (303, 1, 203, '2024-03-05', 150, 4);
SELECT * FROM Sales_Transaction;

CREATE VIEW view_c AS SELECT * FROM Crops WHERE Type = 'Food_Crop';
SELECT * FROM view_c;

CREATE VIEW view_d AS SELECT DISTINCT Type FROM Crops ORDER BY Type DESC;
SELECT * FROM view_d;

CREATE VIEW view_e AS SELECT DISTINCT FName FROM Farmer_Crop WHERE FName NOT LIKE '%e';
SELECT * FROM view_e;

CREATE VIEW  view_f AS SELECT COUNT(DISTINCT Crop_ID) AS Food_Crop_Count FROM Crops WHERE Type = 'Food_Crop';
SELECT * FROM view_f;

CREATE VIEW view_g AS SELECT Transaction_ID, (Quantity_sold * Price_Per_Unit) AS Total_Amount FROM Sales_Transaction;
SELECT * FROM view_g;

CREATE VIEW view_h AS SELECT Crop_ID, SUM(Area_Cultivated) AS Total_Area FROM Farmer_Crop GROUP BY Crop_ID HAVING Total_Area > 8;
SELECT * FROM view_h;

CREATE VIEW view_i AS SELECT FC.Farmer_ID, FC.FName, C.Crop_Name, FC.Area_Cultivated, FC.Yield FROM Farmer_Crop FC JOIN Crops C ON FC.Crop_ID = C.Crop_ID;
SELECT * FROM view_i;

CREATE VIEW view_j AS
SELECT Farmer_Crop_ID, Farmer_ID, Crop_ID, FName, 
       CASE 
           WHEN Crop_ID = 101 THEN Area_Cultivated * 2
           WHEN Crop_ID = 102 THEN Area_Cultivated / 2
           WHEN Crop_ID = 103 THEN Area_Cultivated * 3
           ELSE Area_Cultivated
       END AS Modified_Area_Cultivated,
       Yield
FROM Farmer_Crop;
SELECT * FROM view_j;

ALTER TABLE Farmer_Crop ADD Email VARCHAR(100);
SELECT * FROM Farmer_Crop;

ALTER TABLE Farmer_Crop CHANGE Farmer_ID Farmer_Identification INT;
SELECT * FROM Farmer_Crop;