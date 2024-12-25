
create database employee_attenence;
use employee_attenence;


create table Departments (
    Dept_id int primary key auto_increment,
    Dept_Name varchar(30)
    );

create table Employees (
    Emp_id int primary key auto_increment,
    Emp_name VARCHAR(100),
    Dept_id int,
    Date_Of_Joining date,
    Foreign key (Dept_id) references Departments(Dept_id)
    );


CREATE TABLE AttendanceRecords (
    Emp_id INT,
    ClockIn_Time DATETIME,
    ClockOut_Time DATETIME,
    WorkHours DECIMAL(4,2),
    Attendance_Date DATE
);


create table LeaveRequests (
    LeaveRequest_ID int primary key auto_increment,
    Emp_id int,
    LeaveType VARCHAR(50), 
    LeaveStartDate date,
    LeaveEndDate date,
    LeaveStatus varchar(50),  
    FOREIGN KEY (Emp_id) references Employees(Emp_id)
);




insert into Departments (Dept_Name) values ("sales"),("marketing"),("analyst"),(" developer"),
("sales"),("sales"),("analyst"),("marketing"),("developer"),("analyst"),("developer"),("marketing"),("promotion");
select * from Departments;


insert into Employees(Emp_name , Dept_id , Date_Of_Joining) values ( "jeeva",1,"2018-04-12"),
( "babu",6,"2017-01-29"),
( "santhosh",8,"2016-03-18"),
( "kaviya",7,"2012-12-12"),
( "sabapathi",1,"2019-11-30"),
( "diwash",2,"2020-04-24"),
( "madhumitha",5,"2021-06-12"),
( "adithiyan",1,"2023-08-19"),
( "suji",3,"2015-02-12"),
( "gautham",3,"2010-04-16"),
( "balamurugan",10,"2011-02-26"),
( "venakatprasth",4,"2013-03-29"),
( "nivethitha",7,"2010-08-17"),
( "hema",9,"2016-09-20");

select * from Employees;

insert into AttendanceRecords (Emp_id, ClockIn_Time , ClockOut_Time , WorkHours , Attendance_Date ) values 
(1, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.00, '2025-01-01'), 
(3, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.70, '2025-01-01'),
(5, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.00, '2025-01-01'),
(8, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.00, '2025-01-01'),
(6, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.75, '2025-01-01'),
(1, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.00, '2025-01-01'),
(4, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.00, '2025-01-01'),
(2, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.65, '2025-01-01'),
(9, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.55, '2025-01-01'),
(8, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.45, '2025-01-01'),
(10, '2025-01-01 09:00:00', '2025-01-01 17:00:00', 8.00, '2025-01-01');

select * from AttendanceRecords;

insert into LeaveRequests (Emp_id ,LeaveType,  LeaveStartDate, LeaveEndDate,LeaveStatus) values 
(1, 'helath issue', '2025-01-10', '2025-02-10', 'informed'),
(9, 'vocation', '2025-01-21', '2024-01-28', 'not informed'),
(8, 'vocation', '2025-01-22', '2024-01-28', 'not informed'),
(7, 'health issue', '2025-01-19', '2024-01-25', ' informed'),
(6, 'marriage', '2025-01-18', '2024-01-20', 'informed'),
(10, 'vocation', '2025-01-19', '2024-01-29', 'not informed'),
(5, 'marriage', '2025-01-01', '2024-01-26', 'informed'),
(4, 'relation death', '2025-01-09', '2024-01-16', ' informed'),
(3, 'marriage', '2025-01-24', '2024-01-29', 'informed'),
(2, 'health issue', '2025-01-30', '2024-02-12', 'informed'),
(1, 'vocation', '2025-01-04', '2024-01-10', 'not informed');
select * from LeaveRequests;


select
    e.Emp_name, 
    e.Date_Of_Joining, 
    d.Dept_Name, 
    a.Attendance_Date, 
    a.ClockIn_Time, 
    a.ClockOut_Time, 
    a.WorkHours
FROM Employees e
JOIN Departments d ON e.Dept_id = d.Dept_id
JOIN AttendanceRecords a ON e.Emp_id = a.Emp_id;



SELECT *
FROM Departments 
WHERE Dept_id IN (
    SELECT Dept_id
    FROM Employees
    GROUP BY Dept_id
    HAVING COUNT(Emp_id) > 5
); 
 
SELECT E.Emp_name
FROM Employees E
WHERE EXISTS (SELECT 1
    FROM LeaveRequests L1
    WHERE L1.Emp_id = E.Emp_id
    AND EXISTS (
        SELECT 1
        FROM LeaveRequests L2
        WHERE L2.Emp_id <> E.Emp_id
        AND (
            (L1.LeaveStartDate BETWEEN L2.LeaveStartDate AND L2.LeaveEndDate)
            OR (L1.LeaveEndDate BETWEEN L2.LeaveStartDate AND L2.LeaveEndDate)
        )
    )
);

SELECT Emp_name 
FROM Employees 
WHERE Emp_id IN (
    SELECT Emp_id 
    FROM LeaveRequests 
    WHERE '2025-01-19' BETWEEN LeaveStartDate AND LeaveEndDate
);

SELECT Emp_name 
FROM Employees 
WHERE Emp_id IN (
    SELECT Emp_id
    FROM AttendanceRecords
    WHERE WorkHours > 8 AND Attendance_Date = '2025-01-01'
);
