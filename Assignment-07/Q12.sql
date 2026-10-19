DELIMITER //

CREATE TRIGGER trg_doctor_insert
AFTER INSERT ON Doctors
FOR EACH ROW
BEGIN
    INSERT INTO Doctor_Audit
        (DoctorID, ActionType, OldFee, NewFee)
    VALUES
        (NEW.DoctorID, 'INSERT', NULL, NEW.ConsultationFee);
END //

DELIMITER ;