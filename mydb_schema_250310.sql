-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`grade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`grade` ;

CREATE TABLE IF NOT EXISTS `mydb`.`grade` (
  `gradeNo` INT NOT NULL,
  `gradeName` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`gradeNo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`member` ;

CREATE TABLE IF NOT EXISTS `mydb`.`member` (
  `id` VARCHAR(20) NOT NULL,
  `pw` VARCHAR(20) NOT NULL,
  `name` VARCHAR(40) NOT NULL,
  `gender` VARCHAR(8) NOT NULL,
  `birth` DATETIME NOT NULL,
  `tel` VARCHAR(13) NULL,
  `email` VARCHAR(50) NOT NULL,
  `regDate` DATETIME NULL DEFAULT now(),
  `conDate` DATETIME NULL DEFAULT now(),
  `status` VARCHAR(8) NULL DEFAULT '정상',
  `photo` VARCHAR(100) NULL,
  `newMsgCnt` INT NULL DEFAULT 0,
  `gradeNo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_member_grade_idx` (`gradeNo` ASC) VISIBLE,
  CONSTRAINT `fk_member_grade`
    FOREIGN KEY (`gradeNo`)
    REFERENCES `mydb`.`grade` (`gradeNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`notice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`notice` ;

CREATE TABLE IF NOT EXISTS `mydb`.`notice` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(40) NOT NULL,
  `content` VARCHAR(2000) NOT NULL,
  `startDate` DATETIME NULL DEFAULT now(),
  `endDate` DATETIME NULL DEFAULT '9999-12-31',
  `writeDate` DATETIME NULL DEFAULT now(),
  `updateDate` DATETIME NULL,
  PRIMARY KEY (`no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`image` ;

CREATE TABLE IF NOT EXISTS `mydb`.`image` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(400) NOT NULL,
  `content` VARCHAR(2000) NULL,
  `member_id` VARCHAR(20) NOT NULL,
  `writeDate` DATETIME NULL DEFAULT now(),
  `fileName` VARCHAR(100) NULL,
  PRIMARY KEY (`no`),
  INDEX `fk_image_member1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_image_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `mydb`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`qna`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`qna` ;

CREATE TABLE IF NOT EXISTS `mydb`.`qna` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(400) NOT NULL,
  `content` VARCHAR(2000) NOT NULL,
  `member_id` VARCHAR(20) NOT NULL,
  `writeDate` DATETIME NULL DEFAULT now(),
  `hit` INT NULL DEFAULT 0,
  `refNo` INT NOT NULL,
  `ordNo` INT NULL,
  `levNo` INT NULL,
  `parentNo` INT NOT NULL,
  PRIMARY KEY (`no`),
  INDEX `fk_qna_member1_idx` (`member_id` ASC) VISIBLE,
  INDEX `fk_qna_qna1_idx` (`refNo` ASC) VISIBLE,
  INDEX `fk_qna_qna2_idx` (`parentNo` ASC) VISIBLE,
  CONSTRAINT `fk_qna_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `mydb`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_qna_qna1`
    FOREIGN KEY (`refNo`)
    REFERENCES `mydb`.`qna` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_qna_qna2`
    FOREIGN KEY (`parentNo`)
    REFERENCES `mydb`.`qna` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`message` ;

CREATE TABLE IF NOT EXISTS `mydb`.`message` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(2000) NOT NULL,
  `senderID` VARCHAR(20) NOT NULL,
  `sendDate` DATETIME NULL DEFAULT now(),
  `acceptID` VARCHAR(20) NOT NULL,
  `acceptDate` DATETIME NULL DEFAULT NULL,
  `allUser` INT NULL DEFAULT 0,
  PRIMARY KEY (`no`),
  INDEX `fk_message_member1_idx` (`senderID` ASC) VISIBLE,
  INDEX `fk_message_member2_idx` (`acceptID` ASC) VISIBLE,
  CONSTRAINT `fk_message_member1`
    FOREIGN KEY (`senderID`)
    REFERENCES `mydb`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_member2`
    FOREIGN KEY (`acceptID`)
    REFERENCES `mydb`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`board`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`board` ;

CREATE TABLE IF NOT EXISTS `mydb`.`board` (
  `no` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(400) NOT NULL,
  `content` VARCHAR(2000) NOT NULL,
  `writer` VARCHAR(40) NOT NULL,
  `writeDate` DATETIME NULL DEFAULT now(),
  `hit` INT NULL DEFAULT 0,
  `pw` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`board_reply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`board_reply` ;

CREATE TABLE IF NOT EXISTS `mydb`.`board_reply` (
  `rno` INT NOT NULL AUTO_INCREMENT,
  `no` INT NOT NULL,
  `content` VARCHAR(500) NOT NULL,
  `writer` VARCHAR(40) NOT NULL,
  `writeDate` DATETIME NULL DEFAULT now(),
  `pw` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`rno`),
  INDEX `fk_board_reply_board1_idx` (`no` ASC) VISIBLE,
  CONSTRAINT `fk_board_reply_board1`
    FOREIGN KEY (`no`)
    REFERENCES `mydb`.`board` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`goods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`goods` ;

CREATE TABLE IF NOT EXISTS `mydb`.`goods` (
  `gno` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(400) NOT NULL,
  `content` VARCHAR(2000) NOT NULL,
  `writeDate` DATETIME NULL DEFAULT now(),
  `productDate` DATETIME NULL,
  `modelNo` VARCHAR(20) NOT NULL,
  `company` VARCHAR(40) NOT NULL,
  `imageName` VARCHAR(100) NOT NULL,
  `delivery_cost` INT NOT NULL,
  PRIMARY KEY (`gno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`price` ;

CREATE TABLE IF NOT EXISTS `mydb`.`price` (
  `pno` INT NOT NULL AUTO_INCREMENT,
  `gno` INT NOT NULL,
  `std_price` INT NOT NULL,
  `discount` INT NULL,
  `rate` INT NULL,
  `startDate` DATETIME NULL DEFAULT now(),
  `enddate` DATETIME NULL DEFAULT '9999-12-31',
  PRIMARY KEY (`pno`),
  INDEX `fk_price_goods1_idx` (`gno` ASC) VISIBLE,
  CONSTRAINT `fk_price_goods1`
    FOREIGN KEY (`gno`)
    REFERENCES `mydb`.`goods` (`gno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
