DELIMITER //

CREATE FUNCTION calculate_bmi(
    weight_kg DECIMAL(5,2),
    height_m DECIMAL(4,2)
)
RETURNS DECIMAL(6,2)
DETERMINISTIC
BEGIN
    RETURN weight_kg / (height_m * height_m);
END //

DELIMITER ;

SELECT calculate_bmi(60, 1.65) AS BMI;