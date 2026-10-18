ALTER TABLE student_enrollments
 DROP PRIMARY KEY, 
 ADD enrollment_id BIGINT FIRST,
 ADD PRIMARY KEY (enrollment_id);