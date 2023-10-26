-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema greenspot
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema greenspot
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `greenspot` DEFAULT CHARACTER SET utf8 ;
USE `greenspot` ;

-- -----------------------------------------------------
-- Table `greenspot`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `greenspot`.`customer` (
  `idCustomer` INT(11) NOT NULL,
  `customerName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCustomer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `greenspot`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `greenspot`.`products` (
  `itemNum` INT(11) NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(200) NOT NULL,
  `vendor` VARCHAR(200) NOT NULL,
  `itemType` VARCHAR(45) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `unit` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`itemNum`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `greenspot`.`purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `greenspot`.`purchase` (
  `purchaseNum` VARCHAR(30) NOT NULL,
  `itemNumP` INT(11) NOT NULL,
  `cost` DECIMAL(8,2) NOT NULL,
  `purchaseDate` DATE NOT NULL,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`purchaseNum`),
  INDEX `itemNum_idx` (`itemNumP` ASC) ,
  CONSTRAINT `itemNum`
    FOREIGN KEY (`itemNumP`)
    REFERENCES `greenspot`.`products` (`itemNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `greenspot`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `greenspot`.`sales` (
  `salesNum` VARCHAR(45) NOT NULL,
  `dateSold` DATE NOT NULL,
  `idCustomer` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`salesNum`),
  INDEX `idCustomer_idx` (`idCustomer` ASC) ,
  CONSTRAINT `idCustomer`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `greenspot`.`customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `greenspot`.`salesdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `greenspot`.`salesdetails` (
  `salesNum` VARCHAR(45) NOT NULL,
  `itemNumSales` INT(11) NOT NULL,
  `price` DECIMAL(8,2) NOT NULL,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`salesNum`, `itemNumSales`),
  INDEX `itemNum_idx` (`itemNumSales` ASC) ,
  CONSTRAINT `FK1_itemNum`
    FOREIGN KEY (`itemNumSales`)
    REFERENCES `greenspot`.`products` (`itemNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_salesNum`
    FOREIGN KEY (`salesNum`)
    REFERENCES `greenspot`.`sales` (`salesNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `greenspot`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `greenspot`.`stock` (
  `stockID` INT(11) NOT NULL,
  `itemNumStock` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`stockID`),
  INDEX `itemNum_idx` (`itemNumStock` ASC) ,
  CONSTRAINT `FK_itemNum`
    FOREIGN KEY (`itemNumStock`)
    REFERENCES `greenspot`.`products` (`itemNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- insert data customer
INSERT INTO `greenspot`.`customer` (`idCustomer`, `customerName`) VALUES ('198765', 'A');
INSERT INTO `greenspot`.`customer` (`idCustomer`, `customerName`) VALUES ('202900', 'B');
INSERT INTO `greenspot`.`customer` (`idCustomer`, `customerName`) VALUES ('196777', 'C');
INSERT INTO `greenspot`.`customer` (`idCustomer`, `customerName`) VALUES ('277177', 'D');
INSERT INTO `greenspot`.`customer` (`idCustomer`, `customerName`) VALUES ('111000', 'E');
INSERT INTO `greenspot`.`customer` (`idCustomer`, `customerName`) VALUES ('100988', 'F');

-- insert data products
INSERT INTO `greenspot`.`products` (`itemNum`, `description`, `vendor`, `itemType`, `location`, `unit`) VALUES ('1000', 'Bennet Farm free-range eggs', 'Bennet Farms, Rt. 17 Evansville, IL 55446', 'Dairy', 'D12', 'dozen');
INSERT INTO `greenspot`.`products` (`itemNum`, `description`, `vendor`, `itemType`, `location`, `unit`) VALUES ('1100', 'Freshness White beans', 'Freshness, Inc., 202 E. Maple St., St. Joseph, MO 45678', 'Canned', 'a2', '12 oz can');
INSERT INTO `greenspot`.`products` (`itemNum`, `description`, `vendor`, `itemType`, `location`, `unit`) VALUES ('1222', 'Freshness Green beans', 'Freshness, Inc., 202 E. Maple St., St. Joseph, MO 45678', 'Canned', 'a3', '12 ounce can');
INSERT INTO `greenspot`.`products` (`itemNum`, `description`, `vendor`, `itemType`, `location`, `unit`) VALUES ('1223', 'Freshness Green beans', 'Freshness, Inc., 202 E. Maple St., St. Joseph, MO 45678', 'Canned', 'a7', '36 oz can');
INSERT INTO `greenspot`.`products` (`itemNum`, `description`, `vendor`, `itemType`, `location`, `unit`) VALUES ('1224', 'Freshness Wax beans', 'Freshness, Inc., 202 E. Maple St., St. Joseph, MO 45678', 'Canned', 'a3', '12 ounce can');
INSERT INTO `greenspot`.`products` (`itemNum`, `description`, `vendor`, `itemType`, `location`, `unit`) VALUES ('2000', 'Ruby\'s Kale', 'Ruby Redd Produce, LLC, 1212 Milam St., Kenosha, AL, 34567', 'Produce', 'p12', 'bunch');
INSERT INTO `greenspot`.`products` (`itemNum`, `description`, `vendor`, `itemType`, `location`, `unit`) VALUES ('2001', 'Ruby\'s Organic Kale', 'Ruby Redd Produce, LLC, 1212 Milam St., Kenosha, AL, 34567', 'Produce', 'po2', 'bunch');

-- insert data purchase
INSERT INTO `greenspot`.`purchase` (`purchaseNum`, `itemNumP`, `cost`, `purchaseDate`, `quantity`) VALUES ('P1', '1000', '2.35', '2022-02-01', '25');
INSERT INTO `greenspot`.`purchase` (`purchaseNum`, `itemNumP`, `cost`, `purchaseDate`, `quantity`) VALUES ('P2', '1100', '0.69', '2022-02-02', '40');
INSERT INTO `greenspot`.`purchase` (`purchaseNum`, `itemNumP`, `cost`, `purchaseDate`, `quantity`) VALUES ('P3', '1222', '0.59', '2022-02-10', '40');
INSERT INTO `greenspot`.`purchase` (`purchaseNum`, `itemNumP`, `cost`, `purchaseDate`, `quantity`) VALUES ('P4', '1223', '1.75', '2022-02-10', '10');
INSERT INTO `greenspot`.`purchase` (`purchaseNum`, `itemNumP`, `cost`, `purchaseDate`, `quantity`) VALUES ('P5', '1224', '0.65', '2022-02-10', '30');
INSERT INTO `greenspot`.`purchase` (`purchaseNum`, `itemNumP`, `cost`, `purchaseDate`, `quantity`) VALUES ('P6', '2000', '1.29', '2022-02-12', '25');
INSERT INTO `greenspot`.`purchase` (`purchaseNum`, `itemNumP`, `cost`, `purchaseDate`, `quantity`) VALUES ('P7', '2001', '2.19', '2022-02-12', '20');
INSERT INTO `greenspot`.`purchase` (`purchaseNum`, `itemNumP`, `cost`, `purchaseDate`, `quantity`) VALUES ('P8', '1223', '1.8', '2022-02-15', '10');

-- insert data sales
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S1', '2022-02-02', '198765');
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S2', '2022-02-02', NULL);
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S3', '2022-02-02', '202900');
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S4', '2022-02-04', '196777');
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S5', '2022-02-07', '198765');
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S6', '2022-02-11', '277177');
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S7', '2022-02-11', NULL);
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S8', '2022-02-12', '111000');
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S9', '2022-02-12', NULL);
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S10', '2022-02-13', '198765');
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S11', '2022-02-13', '100988');
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S12', '2022-02-14', '202900');
INSERT INTO `greenspot`.`sales` (`salesNum`, `dateSold`, `idCustomer`) VALUES ('S13', '2022-02-15', '111000');

-- insert data salesdetails
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S1', '1000', '5.49', '2');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S2', '2000', '3.99', '2');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S3', '1100', '1.49', '2');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S4', '1000', '5.99', '2');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S5', '1100', '1.49', '8');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S6', '1000', '5.49', '4');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S7', '1100', '1.49', '4');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S8', '1222', '1.29', '12');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S9', '1224', '1.55', '8');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S10', '1223', '3.49', '5');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S11', '2001', '6.99', '1');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S12', '2001', '6.99', '12');
INSERT INTO `greenspot`.`salesdetails` (`salesNum`, `itemNumSales`, `price`, `quantity`) VALUES ('S13', '2000', '3.99', '2');


-- insert data stock
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('11', '1000', '29', '2022-02-01');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('12', '1000', '27', '2022-02-02');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('13', '2000', '3', '2022-02-02');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('14', '1100', '13', '2022-02-02');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('15', '1100', '53', '2022-02-02');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('16', '1000', '25', '2022-02-04');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('17', '1100', '45', '2022-02-07');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('18', '1222', '59', '2022-02-10');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('19', '1223', '12', '2022-02-10');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('20', '1224', '31', '2022-02-10');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('21', '1000', '21', '2022-02-11');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('22', '1100', '41', '2022-02-11');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('23', '1222', '47', '2022-02-12');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('24', '1224', '23', '2022-02-12');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('25', '2000', '28', '2022-02-12');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('26', '2001', '20', '2022-02-12');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('27', '1223', '7', '2022-02-13');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('28', '2001', '19', '2022-02-13');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('29', '2001', '7', '2022-02-14');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('30', '1223', '17', '2022-02-15');
INSERT INTO `greenspot`.`stock` (`stockID`, `itemNumStock`, `quantity`, `date`) VALUES ('31', '2000', '26', '2022-02-15');



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
