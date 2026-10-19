DELIMITER //

CREATE PROCEDURE GetStudentsByDept(IN p_DeptID INT)
BEGIN
    SELECT *
    FROM Student
    WHERE DeptID = p_DeptID;
END //

DELIMITER ;

CALL GetStudentsByDept(102);