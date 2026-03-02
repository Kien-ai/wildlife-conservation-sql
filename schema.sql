# Table	Create Table
protected_areas	CREATE TABLE `protected_areas` (
  `area_id` int NOT NULL AUTO_INCREMENT,
  `area_name` varchar(150) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `size_sq_km` decimal(10,2) DEFAULT NULL,
  `risk_level` enum('Low','Medium','High') DEFAULT NULL,
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


# Table	Create Table
animals	CREATE TABLE `animals` (
  `animal_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `species` varchar(100) DEFAULT NULL,
  `gender` enum('Male','Female') DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `status` enum('Alive','Injured','Missing','Deceased') DEFAULT NULL,
  `protected_area_id` int DEFAULT NULL,
  PRIMARY KEY (`animal_id`),
  KEY `protected_area_id` (`protected_area_id`),
  CONSTRAINT `animals_ibfk_1` FOREIGN KEY (`protected_area_id`) REFERENCES `protected_areas` (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

# Table	Create Table
rangers	CREATE TABLE `rangers` (
  `ranger_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `years_experience` int DEFAULT NULL,
  `assigned_area_id` int DEFAULT NULL,
  PRIMARY KEY (`ranger_id`),
  KEY `assigned_area_id` (`assigned_area_id`),
  CONSTRAINT `rangers_ibfk_1` FOREIGN KEY (`assigned_area_id`) REFERENCES `protected_areas` (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


# Table	Create Table
gps_tracking	CREATE TABLE `gps_tracking` (
  `tracking_id` int NOT NULL AUTO_INCREMENT,
  `animal_id` int DEFAULT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `location_time` datetime DEFAULT NULL,
  PRIMARY KEY (`tracking_id`),
  KEY `animal_id` (`animal_id`),
  CONSTRAINT `gps_tracking_ibfk_1` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`animal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


# Table	Create Table
poaching_incidents	CREATE TABLE `poaching_incidents` (
  `incident_id` int NOT NULL AUTO_INCREMENT,
  `area_id` int DEFAULT NULL,
  `incident_date` date DEFAULT NULL,
  `animals_affected` int DEFAULT NULL,
  `severity` enum('Low','Medium','High','Critical') DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`incident_id`),
  KEY `area_id` (`area_id`),
  CONSTRAINT `poaching_incidents_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `protected_areas` (`area_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
