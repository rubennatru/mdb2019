SET FOREIGN_KEY_CHECKS=0;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/languages.csv'
INTO TABLE languages
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv'
INTO TABLE employee
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/agents.csv'
INTO TABLE agent
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee_relative.csv'
INTO TABLE employee_relative
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/locations.csv'
INTO TABLE locations
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/rooms.csv'
INTO TABLE rooms
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/payments.csv'
INTO TABLE payments
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/travel_documents.csv'
INTO TABLE travel_documents
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/subcharter.csv'
INTO TABLE subcharter
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/hotel.csv'
INTO TABLE hotel
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ports_of_call.csv'
INTO TABLE ports_of_call
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/flights.csv'
INTO TABLE flight
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/train.csv'
INTO TABLE train
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/seats.csv'
INTO TABLE seats
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/books.csv'
INTO TABLE books
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/buys.csv'
INTO TABLE buys
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cruise.csv'
INTO TABLE cruise
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv'
INTO TABLE customer
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/season.csv'
INTO TABLE season
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/travels.csv'
INTO TABLE travel
FIELDS TERMINATED BY ';'
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SET FOREIGN_KEY_CHECKS=1;