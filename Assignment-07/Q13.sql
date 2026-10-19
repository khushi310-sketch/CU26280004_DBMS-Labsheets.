INSERT INTO Doctors
VALUES (301, 'Dr. Test', 'Cardiology', 1100, 'Active');

SELECT * FROM Doctor_Audit
WHERE DoctorID = 301;