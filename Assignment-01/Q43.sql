ALTER TABLE clients 
 DROP PRIMARY KEY, 
 ADD region_code CHAR(3),
 ADD PRIMARY KEY (client_id, region_code); 