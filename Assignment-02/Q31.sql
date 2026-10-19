SELECT status, MAX(total_amount) AS max_amount, MIN(total_amount) AS min_amount 
FROM orders 
GROUP BY status;