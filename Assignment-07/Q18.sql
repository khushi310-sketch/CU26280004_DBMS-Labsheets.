DELIMITER //

CREATE TRIGGER trg_prevent_negative_insert
BEFORE INSERT ON Doctors
FOR EACH ROW
BEGIN
    IF NEW.ConsultationFee < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Consultation fee cannot be negative';
    END IF;
END //

DELIMITER ;

INSERT INTO Doctors
VALUES (303, 'Dr. Invalid', 'Cardiology', -500, 'Active');