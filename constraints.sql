use cs;
CREATE TABLE empx (
    eid VARCHAR(20), 
    designation VARCHAR(20), 
    age INT, 
    DOJ DATETIME DEFAULT CURRENT_TIMESTAMP, 
    gender VARCHAR(10),  
    email VARCHAR(20), 
    Telno INT, 
    CONSTRAINT empx_pk PRIMARY KEY (eid), 
    CONSTRAINT empx_des CHECK (designation IN ('manager', 'clerk', 'teacher')), 
    CONSTRAINT empx_age CHECK (age > 18)
);
select * from empx

ALTER TABLE empx  add constraint emp_gender check (gender in ('M', 'F'));
ALTER TABLE empx DROP constraint emp_gender;
ALTER TABLE empx  add constraint empx_gender check (gender = 'M' OR gender = 'F');
ALTER TABLE empx add constraint empx_email unique(email);
ALTER TABLE empx add constraint empx_Telno check (length(Telno) = 10);

INSERT INTO empx (eid, designation, age , gender, email, Telno) VALUES
('E001','MANAGER','34','F','one@gmail.com','1234567898');

INSERT INTO empx (eid, designation, age , gender, email, Telno) VALUES
('E002','clerk','34', 'M','two@gmail.com','1534567898');


SELECT CONSTRAINT_NAME, CONSTRAINT_type FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_NAME='empx';
CREATE TABLE EMPY (
    EID CHAR(4) NOT NULL PRIMARY KEY,    
    AGE INT NOT NULL,       
    GENDER CHAR(1) ,     
    LNAME VARCHAR(50), 
    DNAME VARCHAR(50),                                    
    SALARY DECIMAL(10, 2) NOT NULL, 
    PHONENO VARCHAR(15),                                  
    Email VARCHAR(100), 
    DOJ DATE NOT NULL
);
DROP TABLE EMPTY

CREATE TABLE EMPY (
    EID CHAR(4) NOT NULL PRIMARY KEY,    
    AGE INT NOT NULL,       
    GENDER CHAR(1) ,     
    LNAME VARCHAR(50), 
    DNAME VARCHAR(50),                                    
    SALARY DECIMAL(10, 2) NOT NULL, 
    PHONENO VARCHAR(15),                                  
    Email VARCHAR(100) UNIQUE, 
    DOJ DATE NOT NULL
);


--iii--
ALTER TABLE empy add constraint empy_age check (age>18 and age<=60);

--iv--
ALTER TABLE empy add constraint empy_salary check (salary>40000 and salary<=100000);


--vi--
ALTER TABLE empy add constraint empy_phoneno unique(PHONENO);

--vii--
ALTER TABLE empy add constraint empy_email check (Email like '%@%');

--viii--
ALTER TABLE EMPY ADD CONSTRAINT empy_gender_chk CHECK (GENDER IN ('M', 'F', 'O'));

--iv--
ALTER TABLE EMPY ADD CONSTRAINT empy_lname CHECK (LNAME = UPPER(LNAME));

--all EID'S must stsrt with letter E
ALTER TABLE EMPY ADD CONSTRAINT empy_eid_chk CHECK (EID LIKE 'E%');

--
ALTER TABLE EMPY ADD CONSTRAINT empy_eid_chk CHECK (EID ~ '^E[A-Za-z0-9]{3}$');


SELECT CONSTRAINT_NAME, CONSTRAINT_type FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_NAME='EMPY';






