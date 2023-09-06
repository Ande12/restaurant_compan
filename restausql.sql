-- MySQL Script generated by MySQL Workbench
-- Wed Sep  6 13:04:12 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema restaurant_company
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema restaurant_company
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `restaurant_company` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `restaurant_company` ;

-- -----------------------------------------------------
-- Table `restaurant_company`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant_company`.`addresses` (
  `addressId` INT NOT NULL AUTO_INCREMENT,
  `quarter` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`addressId`),
  UNIQUE INDEX `addressId_UNIQUE` (`addressId` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant_company`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant_company`.`categories` (
  `categoryId` INT NOT NULL AUTO_INCREMENT,
  `starter` VARCHAR(45) NOT NULL,
  `main_course` VARCHAR(45) NOT NULL,
  `dessert` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`categoryId`),
  UNIQUE INDEX `categoryId_UNIQUE` (`categoryId` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant_company`.`cutomers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant_company`.`cutomers` (
  `customerId` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `addresses_addressId` INT NOT NULL,
  PRIMARY KEY (`customerId`),
  UNIQUE INDEX `customerId_UNIQUE` (`customerId` ASC) VISIBLE,
  INDEX `fk_cutomers_addresses1_idx` (`addresses_addressId` ASC) VISIBLE,
  CONSTRAINT `fk_cutomers_addresses1`
    FOREIGN KEY (`addresses_addressId`)
    REFERENCES `restaurant_company`.`addresses` (`addressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant_company`.`dishes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant_company`.`dishes` (
  `serial_number` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `categories_categoryId` INT NOT NULL,
  PRIMARY KEY (`serial_number`),
  UNIQUE INDEX `serial_number_UNIQUE` (`serial_number` ASC) VISIBLE,
  INDEX `fk_dishes_categories_idx` (`categories_categoryId` ASC) VISIBLE,
  CONSTRAINT `fk_dishes_categories`
    FOREIGN KEY (`categories_categoryId`)
    REFERENCES `restaurant_company`.`categories` (`categoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant_company`.`reataurants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant_company`.`reataurants` (
  `restaurantId` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`restaurantId`),
  UNIQUE INDEX `restaurantId_UNIQUE` (`restaurantId` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant_company`.`waiters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant_company`.`waiters` (
  `waiterId` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `salary` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `addresses_addressId` INT NOT NULL,
  `reataurants_restaurantId` INT NOT NULL,
  PRIMARY KEY (`waiterId`),
  UNIQUE INDEX `waiterId_UNIQUE` (`waiterId` ASC) VISIBLE,
  INDEX `fk_waiters_addresses1_idx` (`addresses_addressId` ASC) VISIBLE,
  INDEX `fk_waiters_reataurants1_idx` (`reataurants_restaurantId` ASC) VISIBLE,
  CONSTRAINT `fk_waiters_addresses1`
    FOREIGN KEY (`addresses_addressId`)
    REFERENCES `restaurant_company`.`addresses` (`addressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_waiters_reataurants1`
    FOREIGN KEY (`reataurants_restaurantId`)
    REFERENCES `restaurant_company`.`reataurants` (`restaurantId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant_company`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant_company`.`orders` (
  `orderId` INT NOT NULL AUTO_INCREMENT,
  `list` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `cutomers_customerId` INT NOT NULL,
  `waiters_waiterId` INT NOT NULL,
  PRIMARY KEY (`orderId`),
  UNIQUE INDEX `orderId_UNIQUE` (`orderId` ASC) VISIBLE,
  INDEX `fk_orders_cutomers1_idx` (`cutomers_customerId` ASC) VISIBLE,
  INDEX `fk_orders_waiters1_idx` (`waiters_waiterId` ASC) VISIBLE,
  CONSTRAINT `fk_orders_cutomers1`
    FOREIGN KEY (`cutomers_customerId`)
    REFERENCES `restaurant_company`.`cutomers` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_waiters1`
    FOREIGN KEY (`waiters_waiterId`)
    REFERENCES `restaurant_company`.`waiters` (`waiterId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant_company`.`preparations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant_company`.`preparations` (
  `preparationId` INT NOT NULL AUTO_INCREMENT,
  `chef` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `dishes_serial_number` INT UNSIGNED NOT NULL,
  `reataurants_restaurantId` INT NOT NULL,
  PRIMARY KEY (`preparationId`),
  UNIQUE INDEX `preparationId_UNIQUE` (`preparationId` ASC) VISIBLE,
  INDEX `fk_preparations_dishes1_idx` (`dishes_serial_number` ASC) VISIBLE,
  INDEX `fk_preparations_reataurants1_idx` (`reataurants_restaurantId` ASC) VISIBLE,
  CONSTRAINT `fk_preparations_dishes1`
    FOREIGN KEY (`dishes_serial_number`)
    REFERENCES `restaurant_company`.`dishes` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_preparations_reataurants1`
    FOREIGN KEY (`reataurants_restaurantId`)
    REFERENCES `restaurant_company`.`reataurants` (`restaurantId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant_company`.`transfers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant_company`.`transfers` (
  `transferId` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dishes_serial_number` INT UNSIGNED NOT NULL,
  `reataurants_restaurantId` INT NOT NULL,
  PRIMARY KEY (`transferId`, `reataurants_restaurantId`),
  UNIQUE INDEX `transferId_UNIQUE` (`transferId` ASC) VISIBLE,
  INDEX `fk_transfers_dishes1_idx` (`dishes_serial_number` ASC) VISIBLE,
  INDEX `fk_transfers_reataurants1_idx` (`reataurants_restaurantId` ASC) VISIBLE,
  CONSTRAINT `fk_transfers_dishes1`
    FOREIGN KEY (`dishes_serial_number`)
    REFERENCES `restaurant_company`.`dishes` (`serial_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transfers_reataurants1`
    FOREIGN KEY (`reataurants_restaurantId`)
    REFERENCES `restaurant_company`.`reataurants` (`restaurantId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
