DELIMITER //

CREATE PROCEDURE DoctorsFeeAbove1000()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(50);
    DECLARE v_fee DECIMAL(10,2);

    DECLARE cur CURSOR FOR
        SELECT DoctorID, DoctorName, ConsultationFee
        FROM Doctors
        WHERE ConsultationFee > 1000;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_id, v_name, v_fee;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT v_id AS DoctorID, v_name AS DoctorName,
               v_fee AS ConsultationFee;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL DoctorsFeeAbove1000();