DELIMITER //

CREATE FUNCTION StudentGrade(marks DECIMAL(5,2))
RETURNS CHAR(1)
DETERMINISTIC
BEGIN
    IF marks >= 90 THEN
        RETURN 'A';
    ELSEIF marks >= 75 THEN
        RETURN 'B';
    ELSEIF marks >= 60 THEN
        RETURN 'C';
    ELSE
        RETURN 'D';
    END IF;
END //

DELIMITER ;

SELECT StudentGrade(85) AS Grade;