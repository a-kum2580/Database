show DATABASES;


use bscs_1;

--a) Retrieve employees and their department details
SELECT e.*, d.Dname, d.Loc from employee e join department d on e.DeptNo = d.DeptNo;


--b) Retrieve projects and their department details
SELECT p.ProjID, p.ProJName, d.Dname, d.Loc 
from project p 
join department d on p.DeptNo = d.DeptNo;


--c) Retrieve all employees, their department and projects
 
SELECT e.*, d.Dname As Department, p.ProjName As Project 
from employee e 
join department d on e.DeptNo = d.DeptNo 
join project p on d.DeptNo = p.DeptNo;
 
 --d) Retrieve all projects along with the department and employees in that.
SELECT  p.ProjName As Project , d.Dname As Department, e.Ename As Employee, e.Job
from project p
join department d on p.DeptNo = d.DeptNo 
join employee e   on d.DeptNo = e.DeptNo
order by p.ProJName;

--e) Find employees working on projects in their departments with salary greater than 40,000

SELECT e.*, p.ProjName As Project, d.Dname AS Department 
from employee e 
join department d on e.DeptNo = d.DeptNo 
join project p on d.DeptNo = p.DeptNo
where e.Salary >40000;

--f) Count How many Employees are in each department working on a project.

SELECT d.Dname AS Department , p.ProjName As Project, count(e.EmpNo) as Total_Employees
from employee e 
join department d on e.DeptNo = d.DeptNo 
join project p on d.DeptNo = p.DeptNo
GROUP BY d.Dname, p.ProJName;

--g) Retrieve employees who are managers and their department's projects.
SELECT e.*, d.Dname AS Department , p.ProjName As Project
from employee e 
join department d on e.DeptNo = d.DeptNo 
join project p on d.DeptNo = p.DeptNo
WHERE e.Job = "Manager";

--h) View of Employees and their projects

Create view View_Emp_Proj as SELECT e.Ename, e.Job,p.ProjName As Project
from employee e 
join department d on e.DeptNo = d.DeptNo 
join project p on d.DeptNo = p.DeptNo;

 --ADD two columns AssignedDate and Role to table project. 
ALTER TABLE project 
ADD COLUMN Role VARCHAR(100), 
ADD COLUMN AssignedDate DATE;

--i)
UPDATE employee set Salary = 45000 where EmpNo ="E005"