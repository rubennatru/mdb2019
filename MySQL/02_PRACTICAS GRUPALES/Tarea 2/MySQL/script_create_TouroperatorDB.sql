-- MySQL Script generated by MySQL Workbench
-- Tue Jan 14 15:08:48 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema touroperator
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `touroperator` ;

-- -----------------------------------------------------
-- Schema touroperator
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `touroperator` DEFAULT CHARACTER SET utf8 ;
USE `touroperator` ;

-- -----------------------------------------------------
-- Table `touroperator`.`CUSTOMER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`CUSTOMER` (
  `IDENTIFIER` VARCHAR(10) NOT NULL,
  `CUST_NAME` VARCHAR(50) NULL,
  `SURNAME` VARCHAR(80) NULL,
  `DATE_BIRTH` DATE NULL,
  `STREET` VARCHAR(60) NULL,
  `NUMBER` INT(4) NULL,
  `NO_APART` INT(4) NULL,
  `CITY` VARCHAR(45) NULL,
  `COUNTRY` VARCHAR(30) NULL,
  `MAIL` VARCHAR(80) NULL,
  `PHONE` INT(9) NULL,
  PRIMARY KEY (`IDENTIFIER`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`EMPLOYEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`EMPLOYEE` (
  `ID_EMPLOYEE` INT(9) NOT NULL,
  `DEPARTMENT` VARCHAR(45) NULL,
  `RANK` INT(3) NULL,
  `ID_CUSTOMER` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`ID_EMPLOYEE`),
  INDEX `FK_EMP_CUSTOMER_idx` (`ID_CUSTOMER` ASC) VISIBLE,
  CONSTRAINT `FK_EMP_CUSTOMER`
    FOREIGN KEY (`ID_CUSTOMER`)
    REFERENCES `touroperator`.`CUSTOMER` (`IDENTIFIER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`EMPLOYEE_RELATIVE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`EMPLOYEE_RELATIVE` (
  `ID_CUSTOMER` VARCHAR(10) NOT NULL,
  `ID_EMPLO` INT(9) NOT NULL,
  PRIMARY KEY (`ID_CUSTOMER`, `ID_EMPLO`),
  INDEX `FK_RELA_EMPLO_idx` (`ID_EMPLO` ASC) VISIBLE,
  CONSTRAINT `FK_EMP_REL_EMPLO`
    FOREIGN KEY (`ID_EMPLO`)
    REFERENCES `touroperator`.`EMPLOYEE` (`ID_EMPLOYEE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_EMP_REL_CUSTOM`
    FOREIGN KEY (`ID_CUSTOMER`)
    REFERENCES `touroperator`.`CUSTOMER` (`IDENTIFIER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`PAYMENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`PAYMENTS` (
  `ID_PAYMENT` INT(2) NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  PRIMARY KEY (`ID_PAYMENT`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`AGENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`AGENT` (
  `ID_AGENT` INT(8) NOT NULL,
  `NAME` VARCHAR(45) NULL,
  `STREET` VARCHAR(45) NULL,
  `NUMBER` INT(4) NULL,
  `EMAIL` VARCHAR(60) NULL,
  `PHONE` INT(9) NULL,
  PRIMARY KEY (`ID_AGENT`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`SEASON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`SEASON` (
  `ID_SEASON` INT(2) NOT NULL,
  `START_DATE` DATE NOT NULL,
  `END_DATE` DATE NOT NULL,
  `PRICE_MODIFIER` DECIMAL(3,2) NOT NULL,
  PRIMARY KEY (`ID_SEASON`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`PRODUCTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`PRODUCTS` (
  `ID_PRODUCTS` INT(9) NOT NULL,
  `PRODUCT_TYPE` VARCHAR(1) NULL,
  PRIMARY KEY (`ID_PRODUCTS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`TRAVEL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`TRAVEL` (
  `BOOK_NUMBER` INT(10) NOT NULL,
  `ID_PROD` INT(9) NOT NULL,
  `AMOUNT` INT(2) NOT NULL,
  `BOOKING_TYPE` VARCHAR(45) NULL,
  `SEASON` INT(2) NOT NULL,
  `START_DATE` DATE NOT NULL,
  `END_DATE` DATE NOT NULL,
  PRIMARY KEY (`BOOK_NUMBER`, `ID_PROD`),
  INDEX `FK_TRA_SEASON_idx` (`SEASON` ASC) VISIBLE,
  INDEX `FK_TRA_PRODUCT_idx` (`ID_PROD` ASC) VISIBLE,
  CONSTRAINT `FK_TRA_SEASON`
    FOREIGN KEY (`SEASON`)
    REFERENCES `touroperator`.`SEASON` (`ID_SEASON`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TRA_PRODUCT`
    FOREIGN KEY (`ID_PROD`)
    REFERENCES `touroperator`.`PRODUCTS` (`ID_PRODUCTS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`BOOKS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`BOOKS` (
  `ID_CUST` VARCHAR(10) NOT NULL,
  `BOOK_NUMBER` INT(10) NOT NULL,
  `ID_PAY` INT(2) NULL,
  `BOOK_DATE` DATE NOT NULL,
  `ID_AG` INT(8) NOT NULL,
  PRIMARY KEY (`ID_CUST`, `BOOK_NUMBER`),
  INDEX `FK_BOOK_PAY_idx` (`ID_PAY` ASC) VISIBLE,
  INDEX `FK_BOOK_AG_idx` (`ID_AG` ASC) VISIBLE,
  INDEX `FK_BOOK_TRA_idx` (`BOOK_NUMBER` ASC) VISIBLE,
  CONSTRAINT `FK_BOOK_CUST`
    FOREIGN KEY (`ID_CUST`)
    REFERENCES `touroperator`.`CUSTOMER` (`IDENTIFIER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_BOOK_PAY`
    FOREIGN KEY (`ID_PAY`)
    REFERENCES `touroperator`.`PAYMENTS` (`ID_PAYMENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_BOOK_AG`
    FOREIGN KEY (`ID_AG`)
    REFERENCES `touroperator`.`AGENT` (`ID_AGENT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_BOOK_TRA`
    FOREIGN KEY (`BOOK_NUMBER`)
    REFERENCES `touroperator`.`TRAVEL` (`BOOK_NUMBER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`LOCATIONS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`LOCATIONS` (
  `ID_SEASON` INT(2) NOT NULL,
  `CONTINENT` VARCHAR(50) NULL,
  PRIMARY KEY (`ID_SEASON`),
  CONSTRAINT `FK_LOCA_SEAS`
    FOREIGN KEY (`ID_SEASON`)
    REFERENCES `touroperator`.`SEASON` (`ID_SEASON`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`SUBCHARTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`SUBCHARTER` (
  `ID_SUBCHARTER` VARCHAR(10) NOT NULL,
  `NAME` VARCHAR(45) NULL,
  `STREET` VARCHAR(45) NULL,
  `NUMBER` INT(4) NULL,
  `EMAIL` VARCHAR(60) NULL,
  `PHONE` INT(9) NULL,
  PRIMARY KEY (`ID_SUBCHARTER`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`BUYS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`BUYS` (
  `ID_SUB` VARCHAR(10) NOT NULL,
  `ID_PRODU` INT(9) NOT NULL,
  `BUY_DATE` DATE NOT NULL,
  `NO_VIP` INT(3) NULL,
  `NO_SEATS` INT(3) NULL,
  PRIMARY KEY (`ID_SUB`, `BUY_DATE`, `ID_PRODU`),
  INDEX `FK_BUY_PRODUCTS_idx` (`ID_PRODU` ASC) INVISIBLE,
  CONSTRAINT `FK_BUY_SUB`
    FOREIGN KEY (`ID_SUB`)
    REFERENCES `touroperator`.`SUBCHARTER` (`ID_SUBCHARTER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_BUY_PRODUCTS`
    FOREIGN KEY (`ID_PRODU`)
    REFERENCES `touroperator`.`PRODUCTS` (`ID_PRODUCTS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`LANGUAGES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`LANGUAGES` (
  `ID_DOC` INT(2) NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  `BOOKNUMBER` INT(30) NOT NULL,
  PRIMARY KEY (`ID_DOC`, `BOOKNUMBER`),
  CONSTRAINT `FK_LANGUAGES_DOC`
    FOREIGN KEY (`ID_DOC` , `BOOKNUMBER`)
    REFERENCES `touroperator`.`TRAVEL_DOCUMENTS` (`ID_DOCUMENT` , `BOOK_NUM`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`TRAVEL_DOCUMENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`TRAVEL_DOCUMENTS` (
  `ID_DOCUMENT` INT(3) NOT NULL,
  `BOOK_NUM` INT(10) NOT NULL,
  `TEXT` VARCHAR(300) NULL,
  PRIMARY KEY (`ID_DOCUMENT`, `BOOK_NUM`),
  INDEX `FK_TRAVDOC_TRAV_idx` (`BOOK_NUM` ASC) VISIBLE,
  CONSTRAINT `FK_TRAVDOC_TRAV`
    FOREIGN KEY (`BOOK_NUM`)
    REFERENCES `touroperator`.`TRAVEL` (`BOOK_NUMBER`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`SEATS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`SEATS` (
  `ID_PROD` INT(9) NOT NULL,
  `ID_TRANSPORT` VARCHAR(6) NOT NULL,
  `TYPE_SEAT` VARCHAR(1) NOT NULL,
  `DATE_SEAT` DATE NOT NULL,
  `TIME_SEAT` TIME NOT NULL,
  `ORIGIN` VARCHAR(6) NOT NULL,
  `DEST` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`ID_PROD`, `ID_TRANSPORT`, `DATE_SEAT`, `TIME_SEAT`, `ORIGIN`, `DEST`),
  CONSTRAINT `FK_SEAT_PROD`
    FOREIGN KEY (`ID_PROD`)
    REFERENCES `touroperator`.`PRODUCTS` (`ID_PRODUCTS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`FLIGHT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`FLIGHT` (
  `ID_PRODUCT` INT(9) NOT NULL,
  `ID_FLIGHT` VARCHAR(6) NOT NULL,
  `DEP_DATE_FLIGHT` DATE NOT NULL,
  `DEP_TIME_FLIGHT` TIME NOT NULL,
  `IATA_DEP` VARCHAR(6) NOT NULL,
  `IATA_ARR` VARCHAR(6) NOT NULL,
  `ARR_FLIGHT_DATE` DATE NULL,
  `ARR_FLIGHT_TIME` TIME NULL,
  `PLANE` VARCHAR(45) NULL,
  `TOTAL_SEAT_VIP` INT(3) NULL,
  `TOTAL_SEAT_ECO` INT(3) NULL,
  `PRICE_VIP` DECIMAL(10,2) NULL,
  `PRICE_ECO` DECIMAL(10,2) NULL,
  PRIMARY KEY (`ID_PRODUCT`, `ID_FLIGHT`, `DEP_DATE_FLIGHT`, `DEP_TIME_FLIGHT`, `IATA_DEP`, `IATA_ARR`),
  CONSTRAINT `FK_FLIGHT_SEATS`
    FOREIGN KEY (`ID_PRODUCT` , `ID_FLIGHT` , `DEP_DATE_FLIGHT` , `DEP_TIME_FLIGHT` , `IATA_DEP` , `IATA_ARR`)
    REFERENCES `touroperator`.`SEATS` (`ID_PROD` , `ID_TRANSPORT` , `DATE_SEAT` , `TIME_SEAT` , `ORIGIN` , `DEST`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`TRAIN`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`TRAIN` (
  `ID_PRODUCT` INT(9) NOT NULL,
  `ID_TRAIN` VARCHAR(6) NOT NULL,
  `DEP_TRAIN_DATE` DATE NOT NULL,
  `DEP_TRAIN_TIME` TIME NOT NULL,
  `DEP_STATION` VARCHAR(6) NOT NULL,
  `ARR_STATION` VARCHAR(6) NOT NULL,
  `DEP_TRAIN_CITY` VARCHAR(45) NULL,
  `TRAIN` VARCHAR(45) NULL,
  `ARR_TRAIN_CITY` VARCHAR(45) NULL,
  `ARR_TRAIN_DATE` DATE NULL,
  `ARR_TRAIN_TIME` TIME NULL,
  `TOTAL_SEAT_VIP` INT(3) NULL,
  `TOTAL_SEAT_COMMON` INT(3) NULL,
  `PRICE_VIP` DECIMAL(10,2) NULL,
  `PRICE_COMMON` DECIMAL(10,2) NULL,
  PRIMARY KEY (`ID_PRODUCT`, `ID_TRAIN`, `DEP_TRAIN_DATE`, `DEP_TRAIN_TIME`, `DEP_STATION`, `ARR_STATION`),
  CONSTRAINT `FK_SEAT_TRAIN`
    FOREIGN KEY (`ID_PRODUCT` , `ID_TRAIN` , `DEP_TRAIN_DATE` , `DEP_TRAIN_TIME` , `DEP_STATION` , `ARR_STATION`)
    REFERENCES `touroperator`.`SEATS` (`ID_PROD` , `ID_TRANSPORT` , `DATE_SEAT` , `TIME_SEAT` , `ORIGIN` , `DEST`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`ROOMS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`ROOMS` (
  `ID_PRODU` INT(9) NOT NULL,
  `ID_ALLOT` VARCHAR(6) NOT NULL,
  `TYPE_ROOM` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`ID_PRODU`, `ID_ALLOT`),
  CONSTRAINT `FK_ROOM_PROD`
    FOREIGN KEY (`ID_PRODU`)
    REFERENCES `touroperator`.`PRODUCTS` (`ID_PRODUCTS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`CRUISE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`CRUISE` (
  `ID_PRODUCT` INT(9) NOT NULL,
  `ID_CRUISE` VARCHAR(6) NOT NULL,
  `DEP_CRUISE_DATE` DATE NULL,
  `DEP_CRUISE_TIME` TIME NULL,
  `SHIP` VARCHAR(45) NULL,
  `DEP_CITY` VARCHAR(45) NULL,
  `DEP_PORT` VARCHAR(45) NULL,
  `ARR_CITY` VARCHAR(45) NULL,
  `ARR_PORT` VARCHAR(45) NULL,
  `ARR_CRUISE_DATE` DATE NULL,
  `ARR_CRUISE_TIME` TIME NULL,
  `TOTAL_ROOM_EXT` INT(3) NULL,
  `TOTAL_ROOM_INT` INT(3) NULL,
  `PRICE_EXT` DECIMAL(10,2) NULL,
  `PRICE_INT` DECIMAL(10,2) NULL,
  PRIMARY KEY (`ID_PRODUCT`, `ID_CRUISE`),
  CONSTRAINT `FK_ROOM_HOTEL`
    FOREIGN KEY (`ID_PRODUCT` , `ID_CRUISE`)
    REFERENCES `touroperator`.`ROOMS` (`ID_PRODU` , `ID_ALLOT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`HOTEL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`HOTEL` (
  `ID_PRODUCT` INT(9) NOT NULL,
  `ID_HOTEL` VARCHAR(6) NOT NULL,
  `HOTEL` VARCHAR(45) NULL,
  `STREET` VARCHAR(45) NULL,
  `NUMBER` INT(4) NULL,
  `CITY` VARCHAR(45) NULL,
  `COUNTRY` VARCHAR(45) NULL,
  `HOTEL_RATING` VARCHAR(15) NULL,
  `PHONE` INT(9) NULL,
  `EMAIL` VARCHAR(60) NULL,
  `TOTAL_SUITE` INT(3) NULL,
  `TOTAL_COMMON` INT(3) NULL,
  `PRICE_SUITE` DECIMAL(10,2) NULL,
  `PRICE_COMMON` DECIMAL(10,2) NULL,
  PRIMARY KEY (`ID_PRODUCT`, `ID_HOTEL`),
  CONSTRAINT `FK_ROOMS_CRUISE`
    FOREIGN KEY (`ID_PRODUCT` , `ID_HOTEL`)
    REFERENCES `touroperator`.`ROOMS` (`ID_PRODU` , `ID_ALLOT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `touroperator`.`PORTS_OF_CALL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `touroperator`.`PORTS_OF_CALL` (
  `ID_PRODUCT` INT(9) NOT NULL,
  `ID_PORT_CRUISE` VARCHAR(6) NOT NULL,
  `PORT_CALL` VARCHAR(45) NOT NULL,
  `DATE_PORT` DATE NOT NULL,
  `TIME_PORT` TIME NOT NULL,
  PRIMARY KEY (`ID_PORT_CRUISE`, `PORT_CALL`, `DATE_PORT`, `TIME_PORT`, `ID_PRODUCT`),
  INDEX `FK_PORT_CUISE_idx` ( `ID_PRODUCT` ASC, `ID_PORT_CRUISE` ASC) VISIBLE,
  CONSTRAINT `FK_PORT_CRUISE`
    FOREIGN KEY (`ID_PRODUCT`, `ID_PORT_CRUISE`)
    REFERENCES `touroperator`.`CRUISE` (`ID_PRODUCT`,`ID_CRUISE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
