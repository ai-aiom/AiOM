CREATE TABLE IF NOT EXISTS `aiom_machine` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(512) NULL,
  `type` INT NOT NULL,
  `service_endpoint` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `aiom_machine_resource_relation` (
  `machine_id` INT NOT NULL,
  `resource_id` VARCHAR(45) NOT NULL,
  `resource_type` VARCHAR(45) NOT NULL,
  `module_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`machine_id`),
  CONSTRAINT `aiom_machine_resource_relation_fk_machine_id`
    FOREIGN KEY (`machine_id`)
    REFERENCES `aiom_machine` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `aiom_machine_module` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `machine_type` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;