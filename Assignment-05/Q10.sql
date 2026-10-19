SELECT e.EmpName, e.Salary, s.Grade
FROM Employees e
JOIN SalaryGrades s
ON e.Salary >= s.MinSalary
AND e.Salary <= s.MaxSalary;