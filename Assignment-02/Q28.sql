SELECT dept_id, SUM(salary) AS total_department_salary 
FROM employees 
GROUP BY dept_id; 