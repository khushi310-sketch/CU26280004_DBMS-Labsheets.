DELIMITER //

CREATE PROCEDURE TotalConsultationFee(OUT total DECIMAL(10,2))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_fee DECIMAL(10,2);
    DECLARE cur CURSOR FOR
        SELECT ConsultationFee FROM Doctors;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    SET total = 0;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_fee;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET total = total + v_fee;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL TotalConsultationFee(@total);
SELECT @total AS TotalConsultationFee;