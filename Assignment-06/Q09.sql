DELIMITER //

CREATE PROCEDURE TotalStudents()
BEGIN
    SELECT COUNT(*) AS Total
    FROM Student;
END //

DELIMITER ;

CALL TotalStudents();