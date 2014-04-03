SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `alunos_si_bd` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `alunos_si_bd` ;

-- -----------------------------------------------------
-- Table `alunos_si_bd`.`states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`states` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`states` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NOT NULL ,
  `acronym` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alunos_si_bd`.`cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`cities` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`cities` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NOT NULL ,
  `state_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_cidades_estados_idx` (`state_id` ASC) ,
  CONSTRAINT `fk_cidades_estados`
    FOREIGN KEY (`state_id` )
    REFERENCES `alunos_si_bd`.`states` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alunos_si_bd`.`neighborhoods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`neighborhoods` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`neighborhoods` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NOT NULL ,
  `city_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_bairros_cidades1_idx` (`city_id` ASC) ,
  CONSTRAINT `fk_bairros_cidades1`
    FOREIGN KEY (`city_id` )
    REFERENCES `alunos_si_bd`.`cities` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alunos_si_bd`.`addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`addresses` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`addresses` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `cep` BIGINT NULL ,
  `street` VARCHAR(120) NULL ,
  `number` INT NULL ,
  `complement` VARCHAR(60) NULL ,
  `neighborhood_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Enderecos_bairros1_idx` (`neighborhood_id` ASC) ,
  CONSTRAINT `fk_Enderecos_bairros1`
    FOREIGN KEY (`neighborhood_id` )
    REFERENCES `alunos_si_bd`.`neighborhoods` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alunos_si_bd`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`users` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(255) NOT NULL ,
  `password` VARCHAR(255) NOT NULL ,
  `role` VARCHAR(30) NOT NULL ,
  `name` VARCHAR(60) NOT NULL ,
  `email` VARCHAR(255) NOT NULL ,
  `goal` TEXT NULL ,
  `telephone` BIGINT NULL ,
  `created` DATETIME NULL ,
  `modified` DATETIME NULL ,
  `address_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `fk_users_Enderecos1_idx` (`address_id` ASC) ,
  CONSTRAINT `fk_users_Enderecos1`
    FOREIGN KEY (`address_id` )
    REFERENCES `alunos_si_bd`.`addresses` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alunos_si_bd`.`files`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`files` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`files` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `description` TEXT NOT NULL ,
  `user_id` INT NOT NULL ,
  `filename` VARCHAR(255) NULL ,
  `dir` VARCHAR(255) NULL ,
  `filesize` INT(11) NULL ,
  `mimetype` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_trabalhos_users1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_trabalhos_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `alunos_si_bd`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alunos_si_bd`.`skills`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`skills` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`skills` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(60) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alunos_si_bd`.`skills_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`skills_users` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`skills_users` (
  `user_id` INT NOT NULL ,
  `skill_id` INT NOT NULL ,
  PRIMARY KEY (`user_id`, `skill_id`) ,
  INDEX `fk_skills_has_users_users1_idx` (`user_id` ASC) ,
  INDEX `fk_skills_has_users_skills1_idx` (`skill_id` ASC) ,
  CONSTRAINT `fk_skills_has_users_skills1`
    FOREIGN KEY (`skill_id` )
    REFERENCES `alunos_si_bd`.`skills` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_skills_has_users_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `alunos_si_bd`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alunos_si_bd`.`formations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`formations` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`formations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `description` TEXT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_formations_users1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_formations_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `alunos_si_bd`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alunos_si_bd`.`professional_experiences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`professional_experiences` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`professional_experiences` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `description` TEXT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_professional_experiences_users1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_professional_experiences_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `alunos_si_bd`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `alunos_si_bd`.`recommendations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `alunos_si_bd`.`recommendations` ;

CREATE  TABLE IF NOT EXISTS `alunos_si_bd`.`recommendations` (
  `user_id` INT NOT NULL ,
  `recommendation_user_id` INT NOT NULL ,
  `recommendation_skill_id` INT NOT NULL ,
  PRIMARY KEY (`user_id`, `recommendation_user_id`, `recommendation_skill_id`) ,
  INDEX `fk_users_has_skills_users_skills_users1_idx` (`recommendation_user_id` ASC, `recommendation_skill_id` ASC) ,
  INDEX `fk_users_has_skills_users_users1_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_users_has_skills_users_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `alunos_si_bd`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_skills_users_skills_users1`
    FOREIGN KEY (`recommendation_user_id` , `recommendation_skill_id` )
    REFERENCES `alunos_si_bd`.`skills_users` (`user_id` , `skill_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `alunos_si_bd` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
