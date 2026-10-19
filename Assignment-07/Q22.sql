DELIMITER //

CREATE TRIGGER trg_validate_department
BEFORE INSERT ON Doctors
FOR EACH ROW
BEGIN
    IF NEW.Department IS NULL
       OR TRIM(NEW.Department) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Department cannot be empty';
    END IF;
END //

DELIMITER ;


INSERT INTO Doctors
VALUES (304, 'Dr. Sample', '', 1000, 'Active');