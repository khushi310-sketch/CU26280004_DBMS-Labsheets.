SELECT d.DeptName, COUNT(e.EmpID) AS EmployeeCount
FROM Employees e
INNER JOIN Departments d
ON e.DeptID = d.DeptID
GROUP BY d.DeptID, d.DeptName;