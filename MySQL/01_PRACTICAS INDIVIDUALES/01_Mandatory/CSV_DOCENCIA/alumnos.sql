SET FOREIGN_KEY_CHECKS = 0;
load data infile 'C:/Program Files/MySQL/MySQL Server 8.0/uploads/alumnos.csv'
INTO TABLE alumnos
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;