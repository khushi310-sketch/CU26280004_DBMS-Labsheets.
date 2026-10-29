DELIMITER //

CREATE FUNCTION consultation_with_tax(
    fee DECIMAL(10,2),
    tax_percent DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN fee + (fee * tax_percent / 100);
END //

DELIMITER ;

SELECT PatientName,
       ConsultationFee AS OriginalFee,
       consultation_with_tax(ConsultationFee, 10) AS FeeWithTax
FROM Patients;