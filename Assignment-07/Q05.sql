DELIMITER //

CREATE PROCEDURE CountCardiologyDoctors(OUT total INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id INT;

    DECLARE cur CURSOR FOR
        SELECT DoctorID FROM Doctors
        WHERE Department = 'Cardiology';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET total = 0;
    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_id;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET total = total + 1;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL CountCardiologyDoctors(@count);
SELECT @count AS CardiologyDoctors;