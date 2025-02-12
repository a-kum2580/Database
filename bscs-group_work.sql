-- a) Activate the database
USE BSCS;
DESC department;
DESC employee;

-- b) Enforce entity and referential integrity
ALTER TABLE Employee ADD CONSTRAINT FK_Dept FOREIGN KEY (DeptNo) REFERENCES Department(DeptNo);

-- c) Show relational schema of Employee and Department tables
DESC Employee;
DESC Department;

-- d) Create a view to retrieve all details of employees in DeptNo 30
CREATE VIEW view_d AS SELECT * FROM Employee WHERE DeptNo = 30;

SELECT * FROM view_d;

-- e) Create a view to compute the number of employees per job
CREATE VIEW view_e AS SELECT Job, COUNT(*) AS EmployeeCount FROM Employee GROUP BY Job;

SELECT * FROM view_e;


-- f) Create a view to retrieve employees whose names start with 'T'
CREATE VIEW view_f AS SELECT * FROM Employee WHERE Ename LIKE 'T%';

SELECT * FROM view_f;

-- g) Create a view to retrieve unique jobs in descending order
CREATE VIEW view_g AS SELECT DISTINCT Job FROM Employee ORDER BY Job DESC;

SELECT * FROM view_g;

-- h) Create a view to retrieve the total amount spent on each job title
CREATE VIEW view_h AS SELECT Job, SUM(Salary) AS Total_Salary FROM Employee GROUP BY Job;

SELECT * FROM view_h;

-- i) Create a view fulfilling the principle of the HAVING clause (Total salary > 50000)
CREATE VIEW view_i AS SELECT Job, SUM(Salary) AS Total_Salary FROM Employee GROUP BY Job HAVING SUM(Salary) > 30000;

SELECT * FROM view_i;

-- j) create a view called view_j tp find the average and total salary collected per job
CREATE VIEW view_j AS SELECT job, AVG(Salary) AS Average_Salary, SUM(Salary) AS Total_Salary from employee GROUP BY `Job`;

SELECT * FROM view_j;

-- k) Add a new column "Location" to the Department table
ALTER TABLE Department ADD Location VARCHAR(50);

DESC department;

-- l) Modify the column size of DName in the Department table to 50 characters
ALTER TABLE Department MODIFY COLUMN DName VARCHAR(50);

DESC department;

-- m) Retrieve all base tables and views from the database
SHOW FULL TABLES; --SHOWS BOTH TABLES AND VIEWS
SHOW FULL TABLES WHERE Table_type = 'BASE TABLE';
SHOW FULL TABLES WHERE Table_type = 'VIEWS';

-- n) Create a view to assign department names based on DeptNo
CREATE VIEW view_n AS SELECT EmpNo, Ename, Job, Salary, DeptNo, 
    CASE 
        WHEN DeptNo = 10 THEN 'Computing Dept'
        WHEN DeptNo = 30 THEN 'Business Dept'
        WHEN DeptNo = 40 THEN 'Marketing Dept'
        ELSE 'N/A' 
    END AS Department_Name
FROM Employee;

SELECT * FROM view_n;

-- O) Create a view to compute salary adjustments based on conditions
CREATE VIEW view_o AS SELECT EmpNo, Ename, Job, Salary, DeptNo,
    CASE 
        WHEN DeptNo = 10 THEN Salary * 1.08  -- 8% salary increase
        WHEN DeptNo = 30 THEN Salary * 0.88  -- 12% salary reduction
        WHEN DeptNo = 40 THEN Salary * 1.10  -- 10% salary increase
        ELSE Salary 
    END AS AdjustedSalary
FROM Employee;

SELECT *FROM view_o;


-- P) Begin transaction management for changes in employee records
START TRANSACTION;

-- Q) Modify Employee E004 salary and job
UPDATE Employee SET Salary = 80000, Job = 'Cleaner' WHERE EmpNo = 'E004';

SELECT * FROM employee;

-- R) Delete Employee E002 from the table
DELETE FROM Employee WHERE EmpNo = 'E002';

-- S) View the structure of the Employee table after changes
SELECT * FROM employee;

-- T) Rollback the transactions performed in steps q and r
ROLLBACK;

-- U) View the structure of the Employee table after rollback
SELECT * FROM employee;

-- V) Observation: The rollback restores deleted and modified data,
-- meaning Employee E002 is back and Employee E004 retains its original data.

