-- MySQL Script generated by MySQL Workbench
-- Thu Jan  9 16:28:47 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET FOREIGN_KEY_CHECKS=0;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DOCENCIA_MODEL
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `DOCENCIA_MODEL` ;

-- -----------------------------------------------------
-- Schema DOCENCIA_MODEL
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DOCENCIA_MODEL` DEFAULT CHARACTER SET utf8 ;
USE `DOCENCIA_MODEL` ;

-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`PROVINCIA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`PROVINCIA` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`PROVINCIA` (
  `CPROV` INT(2) NOT NULL,
  `NOMBRE` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`CPROV`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`MUNICIPIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`MUNICIPIO` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`MUNICIPIO` (
  `CPROV` INT(2) NOT NULL,
  `CMUN` INT(5) NOT NULL,
  `NOMBRE` VARCHAR(50) NOT NULL,
  `HOMBRES` INT(11) NULL,
  `MUJERES` INT(11) NULL,
  PRIMARY KEY (`CPROV`, `CMUN`),
  INDEX `CODPROV_MUNICIPIO_idx` (`CPROV` ASC) VISIBLE,
  CONSTRAINT `CODPROV_MUNICIPIO`
    FOREIGN KEY (`CPROV`)
    REFERENCES `DOCENCIA_MODEL`.`PROVINCIA` (`CPROV`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`ALUMNOS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`ALUMNOS` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`ALUMNOS` (
  `DNI` INT(9) NOT NULL,
  `NOMBRE` VARCHAR(20) NULL,
  `APELLIDO1` VARCHAR(20) NULL,
  `APELLIDO2` VARCHAR(20) NULL,
  `GENERO` VARCHAR(4) NULL,
  `DIRECCION` VARCHAR(100) NULL,
  `TELEFONO` VARCHAR(9) NULL,
  `EMAIL` VARCHAR(40) NULL,
  `FECHA_NACIMIENTO` DATE NULL,
  `FECHA_PRIM_MATRICULA` DATE NOT NULL,
  `CPROV` INT(2) NULL,
  `CMUN` INT(5) NULL,
  PRIMARY KEY (`DNI`),
  INDEX `fk_ALUMNOS_MUNICIPIO1_idx` (`CPROV` ASC, `CMUN` ASC) VISIBLE,
  CONSTRAINT `fk_ALUMNOS_MUNICIPIO1`
    FOREIGN KEY (`CPROV` , `CMUN`)
    REFERENCES `DOCENCIA_MODEL`.`MUNICIPIO` (`CPROV` , `CMUN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`DEPARTAMENTOS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`DEPARTAMENTOS` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`DEPARTAMENTOS` (
  `CDEPARTAMENTOS` INT(3) NOT NULL,
  `NOMBRE` VARCHAR(40) NOT NULL,
  `DIRECCION` VARCHAR(30) NULL,
  `TELEFONO` VARCHAR(9) NULL,
  `WEB` VARCHAR(30) NULL,
  `FECHA_CREACION` DATE NULL,
  PRIMARY KEY (`CDEPARTAMENTOS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`PROFESORES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`PROFESORES` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`PROFESORES` (
  `IDPROFE` VARCHAR(20) NOT NULL,
  `NOMBRE` VARCHAR(20) NOT NULL,
  `APELLIDO1` VARCHAR(20) NOT NULL,
  `APELLIDO2` VARCHAR(20) NULL,
  `CDEPARTAMENTOS` INT(3) NULL,
  `TELEFONO` VARCHAR(4) NULL,
  `EMAIL` VARCHAR(100) NULL,
  `DESPACHO` VARCHAR(10) NULL,
  `FECHA_NACIMIENTO` DATE NULL,
  `ANTIGUEDAD` DATE NULL,
  `IDPROFE_TESIS` VARCHAR(20) NULL,
  PRIMARY KEY (`IDPROFE`),
  INDEX `CODDEP_idx` (`CDEPARTAMENTOS` ASC) VISIBLE,
  INDEX `IDDIRIGE_PROFESORES_idx` (`IDPROFE_TESIS` ASC) VISIBLE,
  CONSTRAINT `CODDEP_PROFESORES`
    FOREIGN KEY (`CDEPARTAMENTOS`)
    REFERENCES `DOCENCIA_MODEL`.`DEPARTAMENTOS` (`CDEPARTAMENTOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDDIRIGE_PROFESORES`
    FOREIGN KEY (`IDPROFE_TESIS`)
    REFERENCES `DOCENCIA_MODEL`.`PROFESORES` (`IDPROFE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`MATERIAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`MATERIAS` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`MATERIAS` (
  `CMATERIAS` INT(2) NOT NULL,
  `NOMBRE` VARCHAR(40) NOT NULL,
  `DESCRIPCION` VARCHAR(200) NULL,
  PRIMARY KEY (`CMATERIAS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`ASIGNATURAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`ASIGNATURAS` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`ASIGNATURAS` (
  `CASIGNATURA` INT(3) NOT NULL,
  `NOMBRE` VARCHAR(50) NOT NULL,
  `CDEPARTAMENTOS` INT(3) NULL,
  `CMATERIAS` INT(2) NULL,
  `CREDITOS` DECIMAL(3,1) NULL,
  `TEORICOS` DECIMAL(3,1) NULL,
  `PRACTICOS` DECIMAL(3,1) NULL,
  `CARACTER` VARCHAR(2) NULL,
  `CURSO` INT(1) NULL,
  `WEB` VARCHAR(30) NULL,
  PRIMARY KEY (`CASIGNATURA`),
  INDEX `CODDEP_ASIGNATURAS_idx` (`CDEPARTAMENTOS` ASC) VISIBLE,
  INDEX `CODMAT_ASIGNATURAS_idx` (`CMATERIAS` ASC) VISIBLE,
  CONSTRAINT `CODDEP_ASIGNATURAS`
    FOREIGN KEY (`CDEPARTAMENTOS`)
    REFERENCES `DOCENCIA_MODEL`.`DEPARTAMENTOS` (`CDEPARTAMENTOS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CODMAT_ASIGNATURAS`
    FOREIGN KEY (`CMATERIAS`)
    REFERENCES `DOCENCIA_MODEL`.`MATERIAS` (`CMATERIAS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`INVESTIGADORES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`INVESTIGADORES` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`INVESTIGADORES` (
  `IDPROFE` VARCHAR(20) NOT NULL,
  `TRAMOS` INT(2) NULL,
  PRIMARY KEY (`IDPROFE`),
  CONSTRAINT `IDPROF_INVESTIGADORES`
    FOREIGN KEY (`IDPROFE`)
    REFERENCES `DOCENCIA_MODEL`.`PROFESORES` (`IDPROFE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`MATRICULAR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`MATRICULAR` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`MATRICULAR` (
  `DNIALUM` INT(9) NOT NULL,
  `CASIGNATURA` INT(3) NOT NULL,
  `GRUPO` VARCHAR(1) NOT NULL,
  `CURSO` VARCHAR(5) NOT NULL,
  `CALIFICACION` VARCHAR(2) NULL,
  PRIMARY KEY (`DNIALUM`, `CASIGNATURA`, `GRUPO`, `CURSO`),
  INDEX `CODASIG_MATRICULAR_idx` (`CASIGNATURA` ASC) VISIBLE,
  INDEX `DNIALU_MATRICULAR_idx` (`DNIALUM` ASC) VISIBLE,
  CONSTRAINT `CODASIG_MATRICULAR`
    FOREIGN KEY (`CASIGNATURA`)
    REFERENCES `DOCENCIA_MODEL`.`ASIGNATURAS` (`CASIGNATURA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DNIALU_MATRICULAR`
    FOREIGN KEY (`DNIALUM`)
    REFERENCES `DOCENCIA_MODEL`.`ALUMNOS` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`IMPARTIR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`IMPARTIR` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`IMPARTIR` (
  `IDPROFE` VARCHAR(20) NOT NULL,
  `ASIGNATURA` INT(3) NOT NULL,
  `GRUPO` VARCHAR(1) NOT NULL,
  `CURSO` VARCHAR(5) NOT NULL,
  `CARGA_CREDITOS` DECIMAL(3,1) NULL,
  PRIMARY KEY (`IDPROFE`, `ASIGNATURA`, `GRUPO`, `CURSO`),
  INDEX `CODASIG_IMPARTIR_idx` (`ASIGNATURA` ASC) VISIBLE,
  INDEX `IDPROF_IMPARTIR_idx` (`IDPROFE` ASC) VISIBLE,
  CONSTRAINT `CODASIG_IMPARTIR`
    FOREIGN KEY (`ASIGNATURA`)
    REFERENCES `DOCENCIA_MODEL`.`ASIGNATURAS` (`CASIGNATURA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IDPROF_IMPARTIR`
    FOREIGN KEY (`IDPROFE`)
    REFERENCES `DOCENCIA_MODEL`.`PROFESORES` (`IDPROFE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`ES_CORREQUISITO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`ES_CORREQUISITO` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`ES_CORREQUISITO` (
  `ASIGCODIGO1` INT(3) NOT NULL,
  `ASIGCODIGO2` INT(3) NOT NULL,
  PRIMARY KEY (`ASIGCODIGO1`, `ASIGCODIGO2`),
  INDEX `CODASIG2CORREQUISITO_idx` (`ASIGCODIGO2` ASC) VISIBLE,
  CONSTRAINT `CODASIG1CORREQUISITO`
    FOREIGN KEY (`ASIGCODIGO1`)
    REFERENCES `DOCENCIA_MODEL`.`ASIGNATURAS` (`CASIGNATURA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CODASIG2CORREQUISITO`
    FOREIGN KEY (`ASIGCODIGO2`)
    REFERENCES `DOCENCIA_MODEL`.`ASIGNATURAS` (`CASIGNATURA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DOCENCIA_MODEL`.`ES_PRERREQUISITO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DOCENCIA_MODEL`.`ES_PRERREQUISITO` ;

CREATE TABLE IF NOT EXISTS `DOCENCIA_MODEL`.`ES_PRERREQUISITO` (
  `ASIGCODIGO1` INT(3) NOT NULL,
  `ASIGCODIGO2` INT(3) NOT NULL,
  PRIMARY KEY (`ASIGCODIGO1`, `ASIGCODIGO2`),
  CONSTRAINT `CODASIG1_PRERREQUISITO`
    FOREIGN KEY (`ASIGCODIGO1`)
    REFERENCES `DOCENCIA_MODEL`.`ASIGNATURAS` (`CASIGNATURA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CODASIG2_PRERREQUISITO`
    FOREIGN KEY (`ASIGCODIGO2`)
    REFERENCES `DOCENCIA_MODEL`.`ASIGNATURAS` (`CASIGNATURA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
