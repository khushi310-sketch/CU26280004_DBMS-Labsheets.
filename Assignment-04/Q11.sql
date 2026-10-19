SELECT s.StudentID, s.Name, d.DeptName FROM Student s INNER JOIN Department d ON 
s.DeptID = d.DeptID