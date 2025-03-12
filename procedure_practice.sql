use cs;
CREATE PROCEDURE GetEmployeeByJob(IN ID1 VARCHAR(25))
BEGIN
SELECT * FROM Employee WHERE Job = ID1;
END/
CALL GetEmployeeByJob('Salesman');
SHOW CREATE PROCEDURE GetEmployeeByJob;

CREATE PROCEDURE GetTotalSalaryByJob(IN id1 VARCHAR(20))
BEGIN
SELECT SUM(Salary) FROM Employee WHERE Job = id1;
END/
CALL GetTotalSalaryByJob('Teacher');

use cs;
select * from Employee;
select * from Department;

CREATE PROCEDURE InsertEmployee(
    IN id1 VARCHAR(10),
    IN id2 VARCHAR(30),
    IN id3 VARCHAR(20),
    IN id4 INT,
    IN id5 VARCHAR(10)
)
BEGIN
INSERT INTO Employee VALUES (id1, id2, id3, id4, id5);
END/
CALL InsertEmployee('E008', 'Zinda', 'Salesman', 50000, 10);


CREATE PROCEDURE UpdateEmployeeSalary(IN id1 VARCHAR(20), IN id2 INT)
BEGIN
UPDATE Employee SET Salary = id2 WHERE EmpNo = id1;
END/
CALL UpdateEmployeeSalary('E005', 65000);
select * from Employee;

SHOW PROCEDURE STATUS WHERE Db = 'cs';

