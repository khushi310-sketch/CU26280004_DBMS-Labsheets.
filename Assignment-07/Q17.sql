DELIMITER //

CREATE TRIGGER trg_fee_log_update
AFTER UPDATE ON Doctors
FOR EACH ROW
BEGIN
    IF OLD.ConsultationFee <> NEW.ConsultationFee THEN
        INSERT INTO Fee_Log
            (DoctorID, DoctorName, OldFee, NewFee)
        VALUES
            (NEW.DoctorID, NEW.DoctorName,
             OLD.ConsultationFee, NEW.ConsultationFee);
    END IF;
END //

DELIMITER ;

UPDATE Doctors
SET ConsultationFee = 1400
WHERE DoctorID = 201;

SELECT * FROM Fee_Log
WHERE DoctorID = 201;