CREATE TABLE IF NOT EXISTS `aiom_machine` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(512) NULL,
  `type` INT NOT NULL,
  `service_endpoint` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `aiom_machine_module` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `machine_type` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;