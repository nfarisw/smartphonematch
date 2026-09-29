-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: smartphonematch
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','editor') NOT NULL DEFAULT 'editor',
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `slug` varchar(80) NOT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `slug` varchar(150) NOT NULL,
  `type` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `price_alerts`
--

DROP TABLE IF EXISTS `price_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price_alerts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(150) NOT NULL,
  `smartphone_id` int(11) NOT NULL,
  `target_price` decimal(8,2) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `notified_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `smartphone_id` (`smartphone_id`),
  CONSTRAINT `price_alerts_ibfk_1` FOREIGN KEY (`smartphone_id`) REFERENCES `smartphones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smartphone_id` int(11) NOT NULL,
  `retailer_id` int(11) NOT NULL,
  `condition` enum('nuevo','reacondicionado') NOT NULL DEFAULT 'nuevo',
  `refurb_grade` varchar(40) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `affiliate_url` varchar(500) DEFAULT NULL,
  `availability` enum('in_stock','out_of_stock','unknown') NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`),
  KEY `retailer_id` (`retailer_id`),
  KEY `idx_smartphone` (`smartphone_id`),
  CONSTRAINT `prices_ibfk_1` FOREIGN KEY (`smartphone_id`) REFERENCES `smartphones` (`id`) ON DELETE CASCADE,
  CONSTRAINT `prices_ibfk_2` FOREIGN KEY (`retailer_id`) REFERENCES `retailers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retailers`
--

DROP TABLE IF EXISTS `retailers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retailers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `slug` varchar(80) NOT NULL,
  `market` varchar(5) NOT NULL DEFAULT 'ES',
  `logo_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_market` (`market`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `smartphone_categories`
--

DROP TABLE IF EXISTS `smartphone_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smartphone_categories` (
  `smartphone_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`smartphone_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `smartphone_categories_ibfk_1` FOREIGN KEY (`smartphone_id`) REFERENCES `smartphones` (`id`) ON DELETE CASCADE,
  CONSTRAINT `smartphone_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `smartphones`
--

DROP TABLE IF EXISTS `smartphones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smartphones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_id` int(11) NOT NULL,
  `model` varchar(120) NOT NULL,
  `slug` varchar(150) NOT NULL,
  `release_year` smallint(6) DEFAULT NULL,
  `os` enum('Android','iOS') NOT NULL,
  `screen_size` varchar(20) DEFAULT NULL,
  `screen_type` varchar(40) DEFAULT NULL,
  `resolution` varchar(40) DEFAULT NULL,
  `refresh_rate` varchar(20) DEFAULT NULL,
  `processor` varchar(80) DEFAULT NULL,
  `ram` varchar(20) DEFAULT NULL,
  `storage` varchar(20) DEFAULT NULL,
  `battery_mah` varchar(20) DEFAULT NULL,
  `fast_charging` varchar(20) DEFAULT NULL,
  `wireless_charging` tinyint(1) NOT NULL DEFAULT 0,
  `main_camera` varchar(30) DEFAULT NULL,
  `ultrawide_camera` varchar(30) DEFAULT NULL,
  `telephoto` varchar(30) DEFAULT NULL,
  `front_camera` varchar(30) DEFAULT NULL,
  `weight` varchar(20) DEFAULT NULL,
  `dimensions` varchar(60) DEFAULT NULL,
  `water_resistance` varchar(20) DEFAULT NULL,
  `size_category` enum('compacto','normal','grande') NOT NULL DEFAULT 'normal',
  `has_5g` tinyint(1) NOT NULL DEFAULT 0,
  `has_nfc` tinyint(1) NOT NULL DEFAULT 0,
  `has_esim` tinyint(1) NOT NULL DEFAULT 0,
  `update_years` tinyint(4) DEFAULT NULL,
  `photo_score` tinyint(4) DEFAULT NULL,
  `performance_score` tinyint(4) DEFAULT NULL,
  `gaming_score` tinyint(4) DEFAULT NULL,
  `battery_score` tinyint(4) DEFAULT NULL,
  `screen_score` tinyint(4) DEFAULT NULL,
  `value_score` tinyint(4) DEFAULT NULL,
  `price_min` decimal(8,2) DEFAULT NULL,
  `price_max` decimal(8,2) DEFAULT NULL,
  `refurb_price_min` decimal(8,2) DEFAULT NULL,
  `refurb_price_max` decimal(8,2) DEFAULT NULL,
  `price_verified` tinyint(1) NOT NULL DEFAULT 0,
  `price_checked_at` date DEFAULT NULL,
  `is_demo_data` tinyint(1) NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `brand_id` (`brand_id`),
  KEY `idx_active` (`active`),
  KEY `idx_os` (`os`),
  CONSTRAINT `smartphones_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'smartphonematch'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-17 12:21:15
