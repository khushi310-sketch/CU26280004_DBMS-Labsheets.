DELIMITER //

CREATE TRIGGER trg_normalize_status
BEFORE UPDATE ON Doctors
FOR EACH ROW
BEGIN
    IF NEW.Status = 'active' THEN
        SET NEW.Status = 'Active';
    END IF;
END //

DELIMITER ;


UPDATE Doctors
SET Status = 'active'
WHERE DoctorID = 201;

SELECT DoctorID, Status
FROM Doctors
WHERE DoctorID = 201;