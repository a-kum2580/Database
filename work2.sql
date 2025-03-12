
USE WORK2;

CREATE TABLE Donation (
    DonorID VARCHAR(10) NOT NULL PRIMARY KEY, 
    Department VARCHAR(5) NOT NULL, 
    Amount INT NOT NULL
);

INSERT INTO Donation VALUES ('D/25', 'CT', 2500);
INSERT INTO Donation VALUES ('D/67', 'SOT', 1200);
INSERT INTO Donation VALUES ('D/45', 'CT', 1500);
INSERT INTO Donation VALUES ('D/46', 'SOB', 0);
INSERT INTO Donation VALUES ('D/50', 'SOT', 1100);

-- Begin stored procedures
DELIMITER //

-- Procedure 1: Display the least amount received by the Computing department
CREATE PROCEDURE Procedure1()
BEGIN
    SELECT MIN(Amount) AS LeastAmount
    FROM Donation
    WHERE Department = 'CT';
END //

-- Procedure 2: Display total amount received per department (user input)
CREATE PROCEDURE Procedure2(IN dept VARCHAR(5))
BEGIN
    SELECT Department, SUM(Amount) AS TotalAmount
    FROM Donation
    WHERE Department = dept
    GROUP BY Department;
END //

-- Procedure 3: Delete records where Amount is NULL
CREATE PROCEDURE Procedure3()
BEGIN
    DELETE FROM Donation WHERE Amount IS NULL;
END //

-- Procedure 4: Change the name of a department
CREATE PROCEDURE Procedure4(IN oldDept VARCHAR(5), IN newDept VARCHAR(5))
BEGIN
    UPDATE Donation 
    SET Department = newDept
    WHERE Department = oldDept;
END //

-- Procedure 5: Delete records where Amount is below a given value
CREATE PROCEDURE Procedure5(IN minAmount INT)
BEGIN
    DELETE FROM Donation WHERE Amount < minAmount;
END //


ALTER TABLE Donation 
ADD CONSTRAINT chk_DonorID CHECK (DonorID LIKE 'D%');
ALTER TABLE Donation 
ADD CONSTRAINT chk_Department CHECK (Department IN ('CT', 'SOT', 'SOB'));

ALTER TABLE Donation 
ADD CONSTRAINT chk_Amount CHECK (Amount >= 12000 AND Amount <= 25000);

-- Add Auto-increment column 'SN' as Primary Key
ALTER TABLE Donation 
ADD COLUMN SNO INT AUTO_INCREMENT PRIMARY KEY FIRST;

-- Start auto-increment from 4
ALTER TABLE Donation AUTO_INCREMENT = 4;

-- Add Unique Constraint on DonorID
ALTER TABLE Donation 
ADD CONSTRAINT unique_DonorID UNIQUE (DonorID);


-- Add CHECK Constraint on Amount to ensure values are between 12000 and 25000
ALTER TABLE Donation 
ADD CONSTRAINT chk_Amount CHECK (Amount BETWEEN 12000 AND 25000);
