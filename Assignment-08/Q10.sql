ALTER TABLE Patients
ADD HeightM DECIMAL(4,2);

UPDATE Patients SET HeightM = 1.62 WHERE PatientID = 201;
UPDATE Patients SET HeightM = 1.75 WHERE PatientID = 202;
UPDATE Patients SET HeightM = 1.60 WHERE PatientID = 203;
UPDATE Patients SET HeightM = 1.78 WHERE PatientID = 204;
UPDATE Patients SET HeightM = 1.68 WHERE PatientID = 205;
UPDATE Patients SET HeightM = 1.58 WHERE PatientID = 206;