DELIMITER //

CREATE TRIGGER trg_doctor_delete
AFTER DELETE ON Doctors
FOR EACH ROW
BEGIN
    INSERT INTO Doctor_Audit
        (DoctorID, ActionType, OldFee, NewFee)
    VALUES
        (OLD.DoctorID, 'DELETE', OLD.ConsultationFee, NULL);
END //

DELIMITER ;


DELETE FROM Doctors
WHERE DoctorID = 302;

SELECT * FROM Doctor_Audit
WHERE DoctorID = 302;