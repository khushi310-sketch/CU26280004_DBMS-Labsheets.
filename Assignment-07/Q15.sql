UPDATE Doctors
SET ConsultationFee = 1250
WHERE DoctorID = 301;

SELECT * FROM Doctor_Audit
WHERE DoctorID = 301;