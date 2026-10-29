DELIMITER //

CREATE PROCEDURE medicine_count(OUT p_count INT)
BEGIN
    SELECT COUNT(*)
    INTO p_count
    FROM Medicines;
END //

DELIMITER ;

CALL medicine_count(@total_medicines);

SELECT @total_medicines AS TotalMedicines;