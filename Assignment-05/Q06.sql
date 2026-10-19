SELECT e.EmpName, d.DeptName
FROM Employees e, Departments d
WHERE e.DeptID = d.DeptID;