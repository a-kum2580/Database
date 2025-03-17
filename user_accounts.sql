--user account management

--cchecking the account your in now
 select current_user;
 ---accounts created

 create user 'six'@localhost identified by 'six@1234'; 
  create user 'seven'@localhost identified by 'seven@123';
  create user 'eight'@localhost identified by 'eight@123';


  ---changing the user name of a user like "root
  rename user 'six'@'localhost' to 'demo'@'localhost';

  --showing the different users
  select user, host from mysql.user;

  --enabling a user to change there own password
   alter user 'demo'@'localhost' password expire; 

  ---locking account seven
  alter user 'demo'@'localhost' account lock;
--these are passwords
--demo....six@1234
--seven....seven@123
--eight....eight@123




--RIGHTS GIVEN TO USERS TO PERFORM SPECIFIC ACTIVITIES
--we have three users demo, seven and eight
-- to check user demo first log out/exit of root.
--login into demo account using mysql -u demo -p , then enter the password
--demo....can view and insert data in the database cs
--exit demo  then login into root to grant demo permission and priveleges to demo
grant select, insert on cs.* to 'demo'@'localhost';--enables only select and insert privileges to demo.
--grants update previlege on cs to demo
grant update on cs.* to 'demo'@'localhost';



--demo.....giving it a privilege to access all databases and tables under the root user
grant update on *.* to 'demo'@'localhost';


--want to deprive TEN frommodifying in the department
--eight
--new ACCOUNT
create user 'TEN'@'localhost' identified by 'ten123';
--giving it access to only select table department ....hence can still block from 
grant select on cs.department to 'TEN'@'localhost';

---deny it from accessing a given pprivilege we USING "REVOKE"

revoke insert, update on cs.department from 'TEN'@'localhost';
--privileges user "TEN" HASH
show grants for 'TEN'@'localhost';


--CREATING A USER ACCOUNT WITH PRIVILEGES OF THE ADMINSTRATOR.
grant all on *.* to 'eight'@'localhost' with grant option;


--ROLES
--roles are groups of users that have the same privileges universty...create a role and give it to different users

--role one..........data_entrants..insert and elect
 create role 'Data_entrants'; 
 --giving roles
 grant insert, select on cs.employee to 'Data_entrants';
--grant role to user demo
grant 'Data_entrant' to 'demo'@'localhost';

--role two..........data_manager..insert, update, delete
 create role 'Data_manager';

 --giving roles
 grant insert, update, delete,select  on cs.employee to 'Data_manager';

--demo account
--seven account;
--showing the roles there
select * from mysql.role_edges;


--ACCOUNT JAMES
create user 'james'@'localhost' identified by 'james';
--GIVE THE GRANT TO JAMES
GRANT  update on universty.employee TO 'james'@'localhost';
REVOKE UPDATE(salary) on un
--granting update rights on the other columns
 GRANT  update(Empno,Ename, Job, Deptno) on universty.employee TO 'james'@'localhost';