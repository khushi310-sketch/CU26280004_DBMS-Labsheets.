SELECT e.EmpName, e.Salary, s.Grade, s.MaxSalary
FROM Employees e
JOIN SalaryGrades s
ON e.Salary < s.MaxSalary;