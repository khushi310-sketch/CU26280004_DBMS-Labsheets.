DELIMITER //

CREATE PROCEDURE GetStudentsByGender(IN p_Gender VARCHAR(10))
BEGIN
    SELECT *
    FROM Student
    WHERE Gender = p_Gender;
END //

DELIMITER ;

CALL GetStudentsByGender('Female');