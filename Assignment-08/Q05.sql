DELIMITER //

CREATE FUNCTION medicine_stock_value(
    p_price DECIMAL(10,2),
    p_stock INT
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN p_price * p_stock;
END //

DELIMITER ;

SELECT MedicineID, MedicineName, UnitPrice, Stock,
       medicine_stock_value(UnitPrice, Stock) AS StockValue
FROM Medicines;