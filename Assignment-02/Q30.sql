SELECT emp_id, SUM(salary) AS quantity 
FROM employees 
GROUP BY emp_id 
HAVING SUM(salary) > 100000.00; 