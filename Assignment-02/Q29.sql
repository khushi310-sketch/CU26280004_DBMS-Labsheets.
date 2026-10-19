SELECT dept_id, COUNT(emp_id) AS employee_count 
FROM employees 
GROUP BY dept_id; 
