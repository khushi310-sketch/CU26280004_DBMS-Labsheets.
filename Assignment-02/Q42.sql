SELECT dept_id, AVG(salary) AS dept_avg 
FROM employees 
GROUP BY dept_id 
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees

);