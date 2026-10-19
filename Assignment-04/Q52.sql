CREATE TABLE Members ( 
member_id INT PRIMARY KEY, 
name VARCHAR(255) NOT NULL, 
email VARCHAR(255) UNIQUE, 
phone_number VARCHAR(20)
);