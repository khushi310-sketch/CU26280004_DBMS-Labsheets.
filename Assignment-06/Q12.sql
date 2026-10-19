DELIMITER //

CREATE PROCEDURE StudentsBetweenMarks(
    IN p_MinMarks DECIMAL(5,2),
    IN p_MaxMarks DECIMAL(5,2)
)
BEGIN
    SELECT *
    FROM Student
    WHERE Marks BETWEEN p_MinMarks AND p_MaxMarks;
END //

DELIMITER ;

CALL StudentsBetweenMarks(70, 90);