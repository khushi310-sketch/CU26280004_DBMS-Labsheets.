CREATE TABLE Loans ( 
loan_id INT PRIMARY KEY, 
book_id INT, 
member_id INT, 
loan_date DATE, 
return_date DATE NULL, 
FOREIGN KEY (book_id) REFERENCES Books(book_id), 
FOREIGN KEY (member_id) REFERENCES Members(member_id)
);