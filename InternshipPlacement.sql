CREATE DATABASE InternshipPlacement;

use InternshipPlacement;

CREATE TABLE Users (
    user_id VARCHAR (20) PRIMARY KEY  ,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    user_type ENUM('student', 'employer') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
desc users;

-- Inserting of values into Users Table
INSERT INTO Users (user_id, name, email, password, user_type, created_at) VALUES
('U001', 'Denise Priscilla', 'den@gmail.com', 'hashed_password1', 'student', NOW()),
('U002', 'Angella Kisa', 'kissa@gmail.com', 'hashed_password2', 'student', NOW()),
('U003', 'Promise Mokili', 'mok@gmail.com', 'hashed_password3', 'employer', NOW()),
('U004', 'Calvin Tendo', 'ten@gmail.com', 'hashed_password4', 'employer', NOW()),
('U005', 'Precious Wakabi', 'waka@gmail.com', 'hashed_password5', 'student', NOW()),
('U006', 'Isaac Nabasa', 'isaac@gmail.com', 'hashed_password5', 'employer', NOW());
INSERT INTO Users (user_id, name, email, password, user_type, created_at) VALUES
('U007', 'Zaharah Nankya', 'zah@gmail.com', 'hashed_password5', 'employer', NOW());
INSERT INTO Users (user_id, name, email, password, user_type, created_at) VALUES
('U008', 'Newton Anguyi', 'new@gmail.com', 'hashed_password5', 'student', NOW());
INSERT INTO Users (user_id, name, email, password, user_type, created_at) VALUES
('U009', 'Humphrey Mubiru', 'hummy@gmail.com', 'hashed_password5', 'student', NOW());
INSERT INTO Users (user_id, name, email, password, user_type, created_at) VALUES
('U010', 'Andrew Ogwang', 'and@gmail.com', 'hashed_password5', 'employer', NOW());

select * from users;
CREATE TABLE Speciality (
    speciality_id VARCHAR(30) PRIMARY KEY ,
    name VARCHAR(255) UNIQUE NOT NULL,
    description TEXT NULL
);
desc speciality;

-- Inserting of values into Speciality Table
INSERT INTO Speciality (speciality_id, name, description) VALUES
('S001', 'Software Development', 'Building and maintaining software applications'),
('S002', 'Cybersecurity', 'Protecting systems and networks from digital attacks'),
('S003', 'Data Science', 'Analyzing data to extract meaningful insights'),
('S004', 'Networking', 'Designing and managing computer networks'),
('S005', 'UI/UX Design', 'Creating user-friendly interfaces for applications');

select * from speciality;


CREATE TABLE Students (
    student_id VARCHAR(30) PRIMARY KEY,
    user_id VARCHAR(20) NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    speciality_id VARCHAR(30) NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (speciality_id) REFERENCES Speciality(speciality_id) ON DELETE SET NULL
); 

desc students;
INSERT INTO Students (student_id, user_id, contact_number, speciality_id) VALUES
('ST001', 'U001', '123-456-7890', 'S001'),
('ST002', 'U002', '987-654-3210', 'S002'),
('ST003', 'U005', '555-666-7777', 'S003'),
('ST004', 'U008', '333-444-5555', 'S004'),
('ST005', 'U009', '222-333-4444', 'S005');

select * from students;

CREATE TABLE Employers (
    employer_id VARCHAR(30)PRIMARY KEY,
    user_id VARCHAR (20) NOT NULL,
    company_name VARCHAR(255) NOT NULL,
    contact_number VARCHAR(20) NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

desc employers;

-- Inserting of values into Employers Table
INSERT INTO Employers (employer_id, user_id, company_name, contact_number) VALUES
('E001', 'U003', 'TechCorp Inc.', '111-222-3333'),
('E002', 'U004', 'CyberSafe Ltd.', '444-555-6666'),
('E003', 'U006', 'AI Innovations', '666-777-8888'),
('E004', 'U007', 'Cloud Networks', '777-888-9999');
INSERT INTO Employers (employer_id, user_id, company_name, contact_number) VALUES
('E005', 'U010', 'FinTech Solutions', '888-999-0000');

select * from employers;
CREATE TABLE Job_Postings (
    job_id VARCHAR(30) PRIMARY KEY ,
    user_id VARCHAR(30) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    employment_type ENUM('full-time', 'part-time', 'internship') NOT NULL,
    speciality_id VARCHAR(30) NULL,
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (speciality_id) REFERENCES Speciality(speciality_id) ON DELETE SET NULL
);

desc job_postings; 

-- Insert data into Job_Postings Table
INSERT INTO Job_Postings (job_id, user_id, title, description, employment_type, speciality_id, posted_at) VALUES
('J001', 'U003', 'Software Engineer Intern', 'Develop and test software', 'internship', 'S001', NOW()),
('J002', 'U006', 'Junior Developer', 'Assist in software development', 'full-time', 'S003', NOW()),
('J003', 'U004', 'Cybersecurity Analyst', 'Monitor security threats', 'full-time', 'S002', NOW()),
('J004', 'U007', 'Network Engineer', 'Design and manage networks', 'full-time', 'S004', NOW());
INSERT INTO Job_Postings (job_id, user_id, title, description, employment_type, speciality_id, posted_at) VALUES
('J005', 'U010', 'UI/UX Designer', 'Improve user experience', 'part-time','S005', NOW()); 



select * from Job_postings;




CREATE TABLE Applications (
    application_id VARCHAR(30) PRIMARY KEY,
    job_id VARCHAR(30) NOT NULL,
    student_id VARCHAR(30) NULL,
    resume_link VARCHAR(255) NULL,
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES Job_Postings(job_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE
);
desc applications;



-- Insert data into Applications Table
INSERT INTO Applications (application_id, job_id, student_id, resume_link, status, applied_at) VALUES
('A001', 'J001', 'ST001', 'resume1.pdf', 'pending', NOW()),
('A002', 'J002', 'ST002', 'resume2.pdf', 'accepted', NOW()),
('A003', 'J003', 'ST003', 'resume3.pdf', 'rejected', NOW()),
('A004', 'J004', 'ST004', 'resume4.pdf', 'pending', NOW()),
('A005', 'J003', 'ST005', 'resume5.pdf', 'pending', NOW());


CREATE TABLE Interviews (
    interview_id VARCHAR(30) PRIMARY KEY,
    application_id VARCHAR(30) NOT NULL,
    interview_date DATETIME NOT NULL,
    interview_mode ENUM('in-person', 'virtual') NOT NULL,
    interview_status ENUM('scheduled', 'completed', 'canceled') DEFAULT 'scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES Applications(application_id) ON DELETE CASCADE
);
desc interviews;



-- Insert data into Interviews Table
INSERT INTO Interviews (interview_id, application_id, interview_date, interview_mode, interview_status, created_at) VALUES
('ID001', 'A001', '2025-03-05 10:00:00', 'virtual', 'scheduled', NOW()),
('ID002', 'A002', '2025-03-06 11:00:00', 'in-person', 'scheduled', NOW()),
('ID003', 'A003', '2025-03-07 09:30:00', 'virtual', 'completed', NOW()),
('ID004', 'A004', '2025-03-08 14:00:00', 'in-person', 'canceled', NOW()),
('ID005', 'A005', '2025-03-09 15:00:00', 'virtual', 'scheduled', NOW());



CREATE TABLE Feedback (
    feedback_id VARCHAR(30) PRIMARY KEY,
    interview_id VARCHAR(30) NOT NULL,
    employer_id VARCHAR(30) NOT NULL,
    student_id VARCHAR(30) NOT NULL,
    comments TEXT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    given_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (interview_id) REFERENCES Interviews(interview_id) ON DELETE CASCADE,
    FOREIGN KEY (employer_id) REFERENCES Employers(employer_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE
); 

desc feedback;

-- Inserting values into Feedback Table
INSERT INTO Feedback (feedback_id, interview_id, employer_id, student_id, comments, rating, given_at) VALUES
('F001', 'ID001', 'E001', 'ST001', 'Great potential, needs more experience.', 4, NOW()),
('F002', 'ID002', 'E002', 'ST002', 'Very skilled, excellent candidate.', 5, NOW()),
('F003', 'ID003', 'E003', 'ST003', 'Lacks technical depth.', 3, NOW()),
('F004', 'ID004', 'E004', 'ST004', 'Did not attend the interview.', 2, NOW()),
('F005', 'ID005', 'E003', 'ST005', 'Good problem-solving skills.', 4, NOW());


-- //DATA RETRIVAL VIEWS 
CREATE VIEW Total_Users AS
SELECT COUNT(user_id) AS total_users
FROM Users;

use internshipplacement;
select * from total_users;

--  Count Employers and Students Separately
CREATE VIEW User_Type_Count AS
SELECT user_type, COUNT(user_id) AS total_users
FROM Users
GROUP BY user_type; 

SELECT * FROM User_Type_Count;

-- View to list all students with their contact numbers and specializations
CREATE VIEW StudentDetails AS
SELECT student_id, user_id, contact_number, speciality_id
FROM Students;
SELECT * FROM User_Type_Count;

-- View to list all employers with their contact details
CREATE VIEW EmployerDetails AS
SELECT employer_id, user_id, company_name, contact_number
FROM Employers;
select * from employerdetails;

-- View to list all job postings with their employment type
CREATE VIEW JobPostingsSummary AS
SELECT job_id, user_id, title, employment_type, speciality_id, posted_at
FROM Job_Postings;

select * from jobpostingssummary;

-- View to list all applications with their status
CREATE VIEW ApplicationStatus AS
SELECT application_id, job_id, student_id, resume_link, status, applied_at
FROM Applications; 

select * from applicationstatus;

-- View to list all scheduled interviews
CREATE VIEW ScheduledInterviews AS
SELECT interview_id, application_id, interview_date, interview_mode, interview_status, created_at
FROM Interviews
WHERE interview_status = 'scheduled';

select * from scheduledinterviews;

-- Maximum, Minimum, and Average Job Postings Per Employer
CREATE VIEW Job_Posting_Stats AS
SELECT 
    MAX(post_count) AS max_jobs_posted, 
    MIN(post_count) AS min_jobs_posted, 
    AVG(post_count) AS avg_jobs_posted
FROM (
    SELECT user_id, COUNT(job_id) AS post_count
    FROM Job_Postings
    GROUP BY user_id
) AS job_counts; 


SELECT * FROM Job_Posting_Stats;  

-- Number of Applications per Job (Ordered by Popularity)

CREATE VIEW Job_Application_Count_Ordered AS
SELECT job_id, COUNT(application_id) AS total_applications
FROM Applications
GROUP BY job_id
ORDER BY total_applications DESC;  

SELECT * FROM Job_Application_Count_Ordered;




-- Count of Distinct Specialities in the System
-- This view returns the number of distinct specialities available.

CREATE VIEW Total_Specialities AS
SELECT COUNT(DISTINCT speciality_id) AS distinct_specialities
FROM Speciality;

SELECT * FROM Total_Specialities;

-- Total Number of Interviews by Status
-- This view counts how many interviews are scheduled, completed, or canceled.
CREATE VIEW Interview_Status_Count AS
SELECT interview_status, COUNT(interview_id) AS total_interviews
FROM Interviews
GROUP BY interview_status;
SELECT * FROM Interview_Status_Count;

-- Highest and Lowest Rating Given in Feedback
-- This view retrieves the highest and lowest ratings given by employers in feedback.
CREATE VIEW Feedback_Rating_Stats AS
SELECT 
    MAX(rating) AS highest_rating, 
    MIN(rating) AS lowest_rating
FROM Feedback;
SELECT * FROM Feedback_Rating_Stats;

-- This view calculates the average feedback rating for each employer.
CREATE VIEW Employer_Avg_Rating AS
SELECT employer_id, AVG(rating) AS avg_rating
FROM Feedback
GROUP BY employer_id;

select * from employer_avg_rating;

-- This view sums up the total number of applications submitted by all students.
CREATE VIEW Total_Applications AS
SELECT SUM(application_count) AS total_applications_submitted
FROM (
    SELECT student_id, COUNT(application_id) AS application_count
    FROM Applications
    GROUP BY student_id
) AS student_app_counts;

select * from total_applications;

-- This view retrieves the distinct employment types available.
CREATE VIEW Distinct_Employment_Types AS
SELECT DISTINCT employment_type 
FROM Job_Postings;

SELECT * FROM Distinct_Employment_Types;


-- JOINS
-- Natural_Join_Students_Speciality 
use internshipplacement;
CREATE VIEW Natural_Join_Students_Speciality AS
SELECT * FROM Students NATURAL JOIN Speciality;
select * from Natural_Join_Students_Speciality;

--Natural_Join_Employers_Users
CREATE VIEW Natural_Join_Employers_Users AS
SELECT * FROM Employers NATURAL JOIN Users;
select * from Natural_Join_Employers_Users;

--Left_Join_JobPostings_Speciality
CREATE VIEW Left_Join_JobPostings_Speciality AS
SELECT Job_Postings.*, Speciality.name AS Speciality_Name
FROM Job_Postings 
LEFT JOIN Speciality ON Job_Postings.speciality_id = Speciality.speciality_id;
select * from Left_Join_JobPostings_Speciality;

--Left_Join_Applications_Students
CREATE VIEW Left_Join_Applications_Students AS
SELECT Applications.*, Students.contact_number 
FROM Applications 
LEFT JOIN Students ON Applications.student_id = Students.student_id;
select * from Left_Join_Applications_Students;

--Right_Join_Users_Employers
CREATE VIEW Right_Join_Users_Employers AS
SELECT Users.*, Employers.company_name 
FROM Users 
RIGHT JOIN Employers ON Users.user_id = Employers.user_id;
select * from Right_Join_Users_Employers;

--Right_Join_JobPostings_Speciality
CREATE VIEW Right_Join_JobPostings_Speciality AS
SELECT Job_Postings.*, Speciality.name AS Speciality_Name
FROM Job_Postings 
RIGHT JOIN Speciality ON Job_Postings.speciality_id = Speciality.speciality_id;
select * from Right_Join_JobPostings_Speciality;

--View: Full_Join_Students_Applications
--Note: MySQL does not support FULL OUTER JOIN directly, so we use UNION of LEFT JOIN and RIGHT JOIN
CREATE VIEW Full_Join_Students_Applications AS
SELECT Students.*, Applications.application_id, Applications.status
FROM Students 
LEFT JOIN Applications ON Students.student_id = Applications.student_id
UNION
SELECT Students.*, Applications.application_id, Applications.status
FROM Students 
RIGHT JOIN Applications ON Students.student_id = Applications.student_id;
select * from Full_Join_Students_Applications;

--Full_Join_Employers_JobPostings
CREATE VIEW Full_Join_Employers_JobPostings AS
SELECT Employers.*, Job_Postings.title
FROM Employers 
LEFT JOIN Job_Postings ON Employers.user_id = Job_Postings.user_id
UNION
SELECT Employers.*, Job_Postings.title
FROM Employers 
RIGHT JOIN Job_Postings ON Employers.user_id = Job_Postings.user_id;
select * from Full_Join_Employers_JobPostings;



----CASE CONDITIONAL STATEMENTS----
--Job_Postings_With_Category (Classifying job types)
use internshipplacement;
CREATE VIEW Case_Job_Postings_With_Category AS
SELECT job_id, title, employment_type,
    CASE 
        WHEN employment_type = 'full-time' THEN 'Permanent Job'
        WHEN employment_type = 'part-time' THEN 'Flexible Job'
        WHEN employment_type = 'internship' THEN 'Internship Opportunity'
        ELSE 'Unknown'
    END AS job_category
FROM Job_Postings;
select * from Case_Job_Postings_With_Category;

--Applications_Status_Label (Assigning labels based on application status
CREATE VIEW Case_Applications_Status_Label AS
SELECT application_id, job_id, student_id, status,
    CASE 
        WHEN status = 'pending' THEN 'Awaiting Review'
        WHEN status = 'accepted' THEN 'Congratulations! You are Hired'
        WHEN status = 'rejected' THEN 'Application Declined'
        ELSE 'Unknown Status'
    END AS status_label
FROM Applications;
select * from Case_Applications_Status_Label;

--CASE in UPDATE Statements
--Updating job descriptions based on job type
UPDATE Job_Postings 
SET description = CASE 
    WHEN employment_type = 'full-time' THEN 'This is a full-time position.'
    WHEN employment_type = 'part-time' THEN 'This is a part-time position.'
    WHEN employment_type = 'internship' THEN 'This is an internship opportunity.'
    ELSE description 
END;


select * from Job_Postings;

-- Updating student contact numbers based on missing values
UPDATE Students
SET contact_number = 
    CASE 
        WHEN contact_number IS NULL THEN 'Not Provided'
        ELSE contact_number
    END;

select * from Students;

-- Deleting job postings for employers with no valid company names 

DELETE FROM Job_Postings 
WHERE user_id IN (
    SELECT user_id FROM Employers 
    WHERE company_name IS NULL OR company_name = ''
);

select * from job_postings;

-- CONSTRAINTS

use internshipplacement;  

-- all emails must have a symbol
alter table users add constraint users_email check(email like '%@%'); 

-- prefixing such that the emails are distinct or unique

alter table users add constraint users_email unique(email);


-- phone number/contact number should be distinct
alter table students add constraint students_contact_number UNIQUE(contact_number);


-- checking whether the user_type is student or employer
alter TABLE users add constraint users_user_type check (user_type in ('student','employer')); 

-- name should be in capital letters
alter table users add constraint users_name check (name=upper(name)); 

-- dropping the CONSTRAINT of name being in capital letters
alter table users drop constraint users_name;  


-- APPLICATION OF DDL AND DML

-- DDL (Data Definition Language)
-- Modifying Tables for example Adding a new column to track user status
ALTER TABLE Users ADD COLUMN status ENUM('active', 'inactive') DEFAULT 'active';

-- Dropping a column for example removing an unnecessary column
ALTER TABLE Users DROP COLUMN status;

-- Truncating a Table for example Clearing the Applications table
TRUNCATE TABLE Applications;
We could not truncate the table(Applications) because It is referenced by a foreign key constraint in another table (unless CASCADE is enabled).

-- DML (Data Manipulation Language)
-- Updating user type (Example: Changing a student's type to an employer)
UPDATE Users SET user_type = 'employer' WHERE user_id = 'U002';

-- Deleting an application (Example: Removing a specific application entry)
DELETE FROM Applications WHERE application_id = 'A003';

-- Selecting Data (Example: Retrieving all active job postings)
SELECT * FROM Job_Postings WHERE employment_type = 'full-time';


-- Start a transaction
START TRANSACTION;

-- Insert a new job posting
INSERT INTO Job_Postings (job_id, user_id, title, description, employment_type, speciality_id, posted_at) 
VALUES ('J006', 'U003', 'AI Researcher', 'Research on AI models', 'full-time', 'S001', NOW());

-- Insert a corresponding application for a student
INSERT INTO Applications (application_id, job_id, student_id, resume_link, status, applied_at) 
VALUES ('A006', 'J006', 'ST001', 'resume6.pdf', 'pending', NOW());

-- If both inserts succeed, commit the transaction
COMMIT;

