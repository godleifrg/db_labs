-- MySQL Script generated by MySQL Workbench
-- Tue Dec 19 23:16:46 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`menu` (
  `ID` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `description` VARCHAR(350) NULL,
  `weight` SMALLINT UNSIGNED NOT NULL,
  `price` DECIMAL(7,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`deliveryman`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`deliveryman` (
  `ID` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fullname` VARCHAR(75) NULL,
  `phonenumber` VARCHAR(20) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`deliveries` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `deliveryID` VARCHAR(4) NOT NULL,
  `menuID` SMALLINT UNSIGNED NULL,
  `quantity` TINYINT UNSIGNED NOT NULL,
  `customerName` VARCHAR(75) NULL,
  `telephone` VARCHAR(20) NULL,
  `address` VARCHAR(200) NULL,
  `orderDate` TIMESTAMP NOT NULL,
  `deliverymanID` SMALLINT UNSIGNED NULL,
  `deliveryDate` TIMESTAMP NULL,
  PRIMARY KEY (`ID`),
  INDEX `menuID_idx` (`menuID` ASC) VISIBLE,
  INDEX `deliverymanID_idx` (`deliverymanID` ASC) VISIBLE,
  CONSTRAINT `menuID`
    FOREIGN KEY (`menuID`)
    REFERENCES `pizzeria`.`menu` (`ID`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `deliverymanID`
    FOREIGN KEY (`deliverymanID`)
    REFERENCES `pizzeria`.`deliveryman` (`ID`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `pizzeria` ;

-- -----------------------------------------------------
-- Placeholder table for view `pizzeria`.`free_deliveryman`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`free_deliveryman` (`ID` INT, `'ФИО'` INT, `'Номер телефона'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `pizzeria`.`order_cost`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`order_cost` (`ID` INT, `'ID доставки'` INT, `'ID меню'` INT, `'Кол-во продуктов'` INT, `'Стоимость заказа'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `pizzeria`.`average_quantity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`average_quantity` (`ID` INT, `'Название позиции'` INT, `'Дата заказа'` INT, `'Среднее кол-во заказов'` INT);

-- -----------------------------------------------------
-- View `pizzeria`.`free_deliveryman`
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'pizzeria'.'free_deliveryman';
USE 'pizzeria';
CREATE OR REPLACE VIEW free_deliveryman AS
  SELECT DISTINCT delman.ID, delman.fullname AS 'ФИО', delman.phonenumber AS 'Номер телефона' FROM deliveryman delman;

-- -----------------------------------------------------
-- View `pizzeria`.`order_cost`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`order_cost`;
USE `pizzeria`;
CREATE  OR REPLACE VIEW `order_cost` AS
	SELECT deliv.ID, deliv.deliveryID AS 'ID доставки', deliv.menuID AS 'ID меню', deliv.quantity AS 'Кол-во продуктов', 
	deliv.quantity * menu.price AS 'Стоимость заказа' FROM deliveries deliv
	LEFT JOIN menu ON menu.ID = deliv.menuID;

-- -----------------------------------------------------
-- View `pizzeria`.`average_quantity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS 'pizzeria'.'average_quantity';
USE 'pizzeria';
CREATE OR REPLACE VIEW average_quantity AS
  SELECT menu.ID AS ID, menu.name AS 'Название позиции',  
  ROUND(AVG(deliv.quantity), 3) AS 'Среднее кол-во заказов'
  FROM menu 
  JOIN deliveries deliv ON menu.ID = deliv.menuID
  GROUP BY menu.ID;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;