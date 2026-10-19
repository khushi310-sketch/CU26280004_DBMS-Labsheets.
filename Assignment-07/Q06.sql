DELIMITER //

CREATE PROCEDURE AverageConsultationFee(OUT avg_fee DECIMAL(10,2))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_fee DECIMAL(10,2);
    DECLARE total DECIMAL(12,2) DEFAULT 0;
    DECLARE cnt INT DEFAULT 0;

    DECLARE cur CURSOR FOR
        SELECT ConsultationFee FROM Doctors;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_fee;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET total = total + v_fee;
        SET cnt = cnt + 1;
    END LOOP;

    CLOSE cur;

    IF cnt = 0 THEN
        SET avg_fee = NULL;
    ELSE
        SET avg_fee = total / cnt;
    END IF;
END //

DELIMITER ;

CALL AverageConsultationFee(@avg_fee);
SELECT @avg_fee AS AverageFee;