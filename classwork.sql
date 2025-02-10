CREATE DATABASE BSCS;
USE BSCS;
-- Create Department Table
CREATE TABLE Department (
    DeptNo INT PRIMARY KEY,
    DName VARCHAR(100) NOT NULL,
    Loc VARCHAR(100)
);

-- Create Employee Table
CREATE TABLE Employee (
    EmpNo VARCHAR(20) PRIMARY KEY,
    Ename VARCHAR(50) NOT NULL,
    Job VARCHAR(50),
    Salary INT,
    DeptNo INT,
    FOREIGN KEY (DeptNo) REFERENCES Department(DeptNo)
);

 desc Employee;
 SELECT* FROM DEPARTMENT;
 SHOW TABLE Department;

 INSERT INTO Department (DeptNo, DName, Loc) VALUES
(10, 'SALES', 'KAMPALA'),
(40, 'MARKETING', 'ENTEBBE'),
(30, 'ACCOUNTING', 'MUKONO');
SELECT * FROM Department;

INSERT INTO Employee (EmpNo, Ename, Job, Salary, DeptNo) VALUES
('E001', 'Null', 'Clerk', 40000,30),
('E002', 'Agaba', 'Manager', 16000,30),
('E003', 'Mary', 'SalesLady', 20000,10),
('E004', 'Timo', 'Clerk', 40000,30),
('E005', 'Simon', 'Manager', 60000,40),
('E006', 'Mark', 'Manager', 45000,10),
('E007', 'Solomon', 'Teacher', 30000,30);

SELECT * FROM Employee;
use bscs;

USE BSCS;

SHOW TABLES;

SELECT * FROM Employee;

UPDATE Employee set salary = case when job = 'clerk' then salary*1.1 when job='manager' then salary*1.05 when job='teacher' then salary*1.15 else salary*1.08 end;

select * from Employee