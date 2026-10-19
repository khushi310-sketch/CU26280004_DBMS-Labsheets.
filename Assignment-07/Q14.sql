DELIMITER //

CREATE TRIGGER trg_doctor_fee_update
AFTER UPDATE ON Doctors
FOR EACH ROW
BEGIN
    IF OLD.ConsultationFee <> NEW.ConsultationFee THEN
        INSERT INTO Doctor_Audit
            (DoctorID, ActionType, OldFee, NewFee)
        VALUES
            (NEW.DoctorID, 'FEE_UPDATE',
             OLD.ConsultationFee, NEW.ConsultationFee);
    END IF;
END //

DELIMITER ;