DELIMITER //

CREATE PROCEDURE IncreasePediatricsFee()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id INT;

    DECLARE cur CURSOR FOR
        SELECT DoctorID FROM Doctors
        WHERE Department = 'Pediatrics';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_id;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        UPDATE Doctors
        SET ConsultationFee = ConsultationFee * 1.10
        WHERE DoctorID = v_id;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL IncreasePediatricsFee();

SELECT * FROM Doctors
WHERE Department = 'Pediatrics';