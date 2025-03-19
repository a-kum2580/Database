CREATE DATABASE MyCompanyDB;
USE MyCompanyDB;
CREATE TABLE Employees (
    emp_id INT AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    hire_date DATE NOT NULL,
    department_id INT,
    salary DECIMAL(10,2),
    PRIMARY KEY (emp_id)
);
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (department_id)
);
CREATE TABLE Projects (
    project_id INT AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    budget DECIMAL(15,2),
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY (project_id)
);
-- Employee_Project Relationship Table
CREATE TABLE EmployeeProjects (
    emp_id INT,
    project_id INT,
    role VARCHAR(50) NOT NULL
);
-- Add UNIQUE Constraint on Email
ALTER TABLE Employees ADD CONSTRAINT unique_email UNIQUE (email);

-- Add CHECK Constraint on Salary (Ensure Positive Salary)
ALTER TABLE Employees ADD CONSTRAINT check_salary CHECK (salary > 0);

-- Add FOREIGN KEY for Department Reference
ALTER TABLE Employees 
ADD CONSTRAINT fk_department FOREIGN KEY (department_id) 
REFERENCES Departments(department_id) ON DELETE SET NULL;

-- Add PRIMARY KEY to EmployeeProjects (Composite Key)
ALTER TABLE EmployeeProjects ADD PRIMARY KEY (emp_id, project_id);

-- Add FOREIGN KEYS to EmployeeProjects
ALTER TABLE EmployeeProjects 
ADD CONSTRAINT fk_emp FOREIGN KEY (emp_id) REFERENCES Employees(emp_id) ON DELETE CASCADE;

ALTER TABLE EmployeeProjects 
ADD CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE;

-- Insert Departments
INSERT INTO Departments (department_name) VALUES ('IT'), ('HR'), ('Finance');
select * from Departments;
-- Insert Employees
INSERT INTO Employees (first_name, last_name, email, phone, hire_date, department_id, salary)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '1234567890', '2022-01-10', 1, 5000.00),
    ('Jane', 'Smith', 'jane.smith@example.com', '9876543210', '2023-03-15', 2, 6000.00);
select * from Employees;
use MyCompanyDB;
-- Insert Projects
INSERT INTO Projects (project_name, budget, start_date, end_date)
VALUES
    ('AI Research', 100000, '2024-01-01', '2025-01-01'),
    ('Cybersecurity Audit', 50000, '2024-02-01', NULL);
select * from Projects;
-- Assign Employees to Projects
INSERT INTO EmployeeProjects (emp_id, project_id, role)
VALUES
    (1, 1, 'Developer'),
    (2, 2, 'Security Analyst');
select * from EmployeeProjects;

--full join
SELECT e.emp_id, e.first_name, e.last_name, d.department_name, e.salary
FROM Employees e
LEFT JOIN Departments d ON e.department_id = d.department_id

UNION

SELECT e.emp_id, e.first_name, e.last_name, d.department_name, e.salary
FROM Employees e
RIGHT JOIN Departments d ON e.department_id = d.department_id;

--left outer join
SELECT e.first_name, e.last_name, p.project_name, ep.role
FROM Employees e
LEFT OUTER JOIN EmployeeProjects ep ON e.emp_id = ep.emp_id
LEFT OUTER JOIN Projects p ON ep.project_id = p.project_id;

--right outer join
SELECT e.emp_id, e.first_name, e.last_name, d.department_name, e.salary
FROM Employees e
RIGHT OUTER JOIN Departments d ON e.department_id = d.department_id;

SELECT e.first_name, e.last_name, p.project_name, ep.role
FROM Employees e
RIGHT OUTER JOIN EmployeeProjects ep ON e.emp_id = ep.emp_id
RIGHT OUTER JOIN Projects p ON ep.project_id = p.project_id;

--viwes
-- View to Display Employee Salaries above 5000
CREATE VIEW HighSalaryEmployees AS
SELECT first_name, last_name, salary
FROM Employees
WHERE salary > 5000;
select * from HighSalaryEmployees;

-- Get Employees in the IT Department
CREATE VIEW ITDepartmentEmployees AS
SELECT e.first_name, e.last_name, d.department_name
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
WHERE d.department_name = 'IT';
select * from ITDepartmentEmployees;

--Transactions
START TRANSACTION;

-- Insert New Employee (Fails if duplicate email)
INSERT INTO Employees (first_name, last_name, email, phone, hire_date, department_id, salary)
VALUES ('Alice', 'Brown', 'alice.brown@example.com', '1122334455', '2024-05-20', 1, 7000.00);

-- Insert New Project
INSERT INTO Projects (project_name, budget, start_date, end_date)
VALUES ('Machine Learning Model', 120000, '2025-06-01', '2026-06-01');

-- Check for errors, then commit or rollback
SELECT COUNT(*) FROM Employees WHERE email = 'alice.brown@example.com';

-- If no errors, commit
COMMIT;

-- If error occurred, rollback
ROLLBACK;
select * from Employees;
select * from Projects;

--Stored Procedures
-- Procedure to Get Employees by Department
DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(100))
BEGIN
    SELECT e.first_name, e.last_name, d.department_name
    FROM Employees e
    JOIN Departments d ON e.department_id = d.department_id
    WHERE d.department_name = dept_name;
END //
-- Call the Stored Procedure
CALL GetEmployeesByDepartment('IT');
SELECT first_name, last_name, salary FROM Employees ORDER BY salary DESC;
SELECT department_id, AVG(salary) FROM Employees GROUP BY department_id;
UPDATE Employees SET salary = 7000 WHERE emp_id = 1;

CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'SecurePass@123';
GRANT SELECT, INSERT, UPDATE ON CompanyDB.* TO 'new_user'@'localhost';

REVOKE INSERT ON CompanyDB.* FROM 'new_user'@'localhost';



