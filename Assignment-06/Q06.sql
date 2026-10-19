DELIMITER //

CREATE PROCEDURE GetStudent(IN p_StudentID INT)
BEGIN
    SELECT *
    FROM Student
    WHERE StudentID = p_StudentID;
END //

DELIMITER ;

CALL GetStudent(3);