CREATE TABLE sensor_readings ( 
  sensor_id INT, 
  recorded_at TIMESTAMP,
  reading FLOAT,
  PRIMARY KEY (sensor_id, recorded_at) 
); 

RENAME TABLE sensor_readings to historical_sensor_readings;