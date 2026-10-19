DELIMITER //

CREATE PROCEDURE StudentsAboveMarks(IN p_Marks DECIMAL(5,2))
BEGIN
    SELECT *
    FROM Student
    WHERE Marks > p_Marks;
END //

DELIMITER ;

CALL StudentsAboveMarks(80);