DELIMITER //

CREATE PROCEDURE CheckResult(IN p_StudentID INT)
BEGIN
    IF (SELECT Marks FROM Student
        WHERE StudentID = p_StudentID) >= 50 THEN
        SELECT 'Pass' AS Result;
    ELSE
        SELECT 'Fail' AS Result;
    END IF;
END //

DELIMITER ;

CALL CheckResult(3);