DELETE FROM orders 
WHERE customer_name IN ( 
SELECT customer_name FROM orders WHERE status = 'Cancelled' 
); 