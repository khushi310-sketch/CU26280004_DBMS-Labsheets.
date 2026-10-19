DELIMITER //

CREATE TRIGGER trg_doctor_uppercase
BEFORE INSERT ON Doctors
FOR EACH ROW
BEGIN
    SET NEW.DoctorName = UPPER(NEW.DoctorName);
END //

DELIMITER ;


INSERT INTO Doctors
VALUES (302, 'dr. test', 'Neurology', 1000, 'Active');

SELECT * FROM Doctors
WHERE DoctorID = 302;