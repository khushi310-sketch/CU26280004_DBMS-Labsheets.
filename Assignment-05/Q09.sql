SELECT e.EmpName, e.Salary, s.Grade, s.MinSalary
FROM Employees e
JOIN SalaryGrades s
ON e.Salary > s.MinSalary;