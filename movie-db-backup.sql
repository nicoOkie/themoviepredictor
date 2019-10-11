-- Adminer 4.7.3 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fr_title` varchar(255) CHARACTER SET armscii8 COLLATE armscii8_general_ci NOT NULL,
  `original_title` varchar(45) NOT NULL,
  `rating` enum('TP','-12','-16','-18') NOT NULL,
  `production_budget` int(11) DEFAULT NULL,
  `marketing_budget` int(11) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `release_date` date NOT NULL,
  `3d` tinyint(4) NOT NULL DEFAULT '0',
  `synopsis` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `movies_companies_roles`;
CREATE TABLE `movies_companies_role` (
  `movie_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  KEY `movie_id_idx` (`movie_id`),
  KEY `company_id_idx` (`company_id`),
  KEY `role_id_idx` (`role_id`),
  CONSTRAINT `company_mr_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `movie_cr_id` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`),
  CONSTRAINT `role_mc_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `movies_origin_countries`;
CREATE TABLE `movies_origin_countries` (
  `movie_id` int(11) NOT NULL,
  `country_iso2` char(2) NOT NULL,
  KEY `country_iso2` (`country_iso2`),
  KEY `movie_id_idx` (`movie_id`),
  CONSTRAINT `movie_oc_id` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `movies_people_roles`;
CREATE TABLE `movies_people_roles` (
  `movie_id` int(11) NOT NULL,
  `people_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  KEY `movie_id_idx` (`movie_id`),
  KEY `role_id_idx` (`role_id`),
  KEY `people_id_idx` (`people_id`),
  CONSTRAINT `movie-pr_id` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`),
  CONSTRAINT `people_mr_id` FOREIGN KEY (`people_id`) REFERENCES `people` (`id`),
  CONSTRAINT `role_mp_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `people`;
CREATE TABLE `people` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- 2019-10-08 08:19:20
