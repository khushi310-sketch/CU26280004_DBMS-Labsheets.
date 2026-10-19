CREATE DATABASE CollegeDB; 
USE CollegeDB; 


CREATE TABLE Department ( 
DeptID INT PRIMARY KEY, 
DeptName VARCHAR(50) NOT NULL, 
Location VARCHAR(50) 
); 


CREATE TABLE Student ( 
StudentID INT PRIMARY KEY, 
StudentName VARCHAR(50) NOT NULL, 
Age INT, 
Gender VARCHAR(10), 
Marks DECIMAL(5,2), 
DeptID INT, 
Email VARCHAR(100), 
FOREIGN KEY (DeptID) REFERENCES Department(DeptID) 
); 


CREATE TABLE Course ( 
CourseID INT PRIMARY KEY, 
CourseName VARCHAR(50) NOT NULL, 
Credits INT 
); 
