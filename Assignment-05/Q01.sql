CREATE DATABASE CollegeJoinDB; 

USE CollegeJoinDB; 

 CREATE TABLE Departments (DeptID INT PRIMARY KEY,DeptName VARCHAR(50),Location VARCHAR(50));
 
 CREATE TABLE Employees (EmpID INT PRIMARY KEY,EmpName VARCHAR(50),DeptID INT,Salary DECIMAL(10,2),City VARCHAR(50));
 
CREATE TABLE SalaryGrades (Grade CHAR(2) PRIMARY KEY,MinSalary DECIMAL(10,2),MaxSalary DECIMAL(10,2));
 
 INSERT INTO Departments VALUES(10,'Computer Science','Block A'),
                               (20,'Pharmacy','Block B'),
                               (30,'Management','Block C'),
                               (40,'Civil Engineering','Block D'); 

 INSERT INTO Employees VALUES(101,'Aarav',10,65000,'Delhi'),
                             (102,'Priya',20,72000,'Mumbai'),
                             (103,'Rahul',10,48000,'Delhi'),
                             (104,'Sneha',30,91000,'Pune'), 
                             (105,'Vikram',20,55000,'Jaipur'), 
                             (106,'Neha',50,80000,'Bengaluru'), 
                             (107,'Kabir',30,43000,'Pune'); 

INSERT INTO SalaryGrades VALUES('G1',0,49999),
                               ('G2',50000,69999),
                               ('G3',70000,89999), 
                               ('G4',90000,120000); 

  SHOW TABLES; 
  SELECT * FROM Departments; 
  SELECT * FROM Employees; 
  SELECT * FROM SalaryGrades; 
