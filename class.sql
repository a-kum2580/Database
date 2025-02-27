create DATABASE Class;
use Class;
CREATE TABLE Employee(
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT CHECK(Age >= 18),
    Email VARCHAR(100) UNIQUE 
);
INSERT INTO Employee(FirstName, LastName, Age, Email) VALUES ('John','Doe', 30, 'john@gmail.com'),
('Calliope','Sloan', 20, 'callie12@gmail.com'),
('Christina','Yang', 23, 'christina45@gmail.com'),
('Jane','Smith', 25, 'jane.smith@gmail.com');
ALTER TABLE Employee DROP COLUMN Age; 
UPDATE Employee SET Age = 32 WHERE EmployeeID = 6;
ALTER TABLE Employee ADD COLUMN DOJ DATETIME DEFAULT CURRENT_TIMESTAMP;
INSERT INTO Employee(FirstName,lastname,Age, )