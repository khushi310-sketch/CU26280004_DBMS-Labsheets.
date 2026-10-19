DELIMITER //

CREATE TRIGGER trg_department_change
AFTER UPDATE ON Doctors
FOR EACH ROW
BEGIN
    IF NOT (OLD.Department <=> NEW.Department) THEN
        INSERT INTO Doctor_Audit
            (DoctorID, ActionType, OldFee, NewFee)
        VALUES
            (NEW.DoctorID,
             CONCAT('DEPT: ', OLD.Department, ' -> ', NEW.Department),
             NULL, NULL);
    END IF;
END //

DELIMITER ;

UPDATE Doctors
SET Department = 'Neurology'
WHERE DoctorID = 201;

SELECT * FROM Doctor_Audit
WHERE DoctorID = 201;