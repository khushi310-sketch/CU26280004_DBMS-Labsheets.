SELECT l.loan_id, b.title, m.name, l.loan_date, l.return_date 
FROM Loans l 
INNER JOIN Books b ON l.book_id = b.book_id 
INNER JOIN Members m ON l.member_id = m.member_id; 