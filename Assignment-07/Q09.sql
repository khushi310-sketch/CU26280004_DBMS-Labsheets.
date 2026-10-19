DELIMITER //

CREATE PROCEDURE DoctorReport()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_name VARCHAR(50);
    DECLARE v_dept VARCHAR(40);
    DECLARE v_fee DECIMAL(10,2);

    DECLARE cur CURSOR FOR
        SELECT DoctorName, Department, ConsultationFee
        FROM Doctors
        ORDER BY Department, DoctorName;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_name, v_dept, v_fee;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SELECT v_name AS DoctorName,
               v_dept AS Department,
               v_fee AS ConsultationFee;
    END LOOP;

    CLOSE cur;
END //

DELIMITER ;

CALL DoctorReport();