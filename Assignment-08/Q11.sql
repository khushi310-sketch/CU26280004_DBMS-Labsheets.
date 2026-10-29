DELIMITER //

CREATE PROCEDURE medicine_report()
BEGIN
    SELECT
        MedicineID,
        MedicineName,
        UnitPrice,
        Stock,
        medicine_stock_value(UnitPrice, Stock) AS StockValue,
        CASE
            WHEN Stock <= 30 THEN 'Low Stock'
            WHEN Stock <= 60 THEN 'Medium Stock'
            ELSE 'Sufficient Stock'
        END AS StockStatus
    FROM Medicines;
END //

DELIMITER ;

CALL medicine_report();