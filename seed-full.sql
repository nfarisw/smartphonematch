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
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'Xiaomi','xiaomi',NULL),(2,'Samsung','samsung',NULL),(3,'Motorola','motorola',NULL),(4,'Nothing','nothing',NULL),(5,'Google','google',NULL),(6,'OnePlus','oneplus',NULL),(7,'Apple','apple',NULL),(15,'OPPO','oppo',NULL),(16,'HONOR','honor',NULL),(17,'Sony','sony',NULL);
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `price_alerts`
--

LOCK TABLES `price_alerts` WRITE;
/*!40000 ALTER TABLE `price_alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `price_alerts` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (1,1,1,'nuevo',NULL,'https://www.amazon.es/s?k=Xiaomi+Redmi+Note+13',NULL,'unknown'),(2,1,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Xiaomi+Redmi+Note+13',NULL,'unknown'),(3,1,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Xiaomi+Redmi+Note+13',NULL,'unknown'),(4,1,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Xiaomi+Redmi+Note+13',NULL,'unknown'),(5,1,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Xiaomi+Redmi+Note+13',NULL,'unknown'),(6,2,1,'nuevo',NULL,'https://www.amazon.es/s?k=Samsung+Galaxy+A15',NULL,'unknown'),(7,2,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Samsung+Galaxy+A15',NULL,'unknown'),(8,2,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Samsung+Galaxy+A15',NULL,'unknown'),(9,2,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Samsung+Galaxy+A15',NULL,'unknown'),(10,2,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Samsung+Galaxy+A15',NULL,'unknown'),(11,3,1,'nuevo',NULL,'https://www.amazon.es/s?k=Motorola+Moto+G54',NULL,'unknown'),(12,3,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Motorola+Moto+G54',NULL,'unknown'),(13,3,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Motorola+Moto+G54',NULL,'unknown'),(14,3,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Motorola+Moto+G54',NULL,'unknown'),(15,3,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Motorola+Moto+G54',NULL,'unknown'),(16,4,1,'nuevo',NULL,'https://www.amazon.es/s?k=Samsung+Galaxy+A35',NULL,'unknown'),(17,4,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Samsung+Galaxy+A35',NULL,'unknown'),(18,4,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Samsung+Galaxy+A35',NULL,'unknown'),(19,4,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Samsung+Galaxy+A35',NULL,'unknown'),(20,4,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Samsung+Galaxy+A35',NULL,'unknown'),(21,5,1,'nuevo',NULL,'https://www.amazon.es/s?k=Nothing+Phone+%282a%29',NULL,'unknown'),(22,5,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Nothing+Phone+%282a%29',NULL,'unknown'),(23,5,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Nothing+Phone+%282a%29',NULL,'unknown'),(24,5,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Nothing+Phone+%282a%29',NULL,'unknown'),(25,5,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Nothing+Phone+%282a%29',NULL,'unknown'),(26,6,1,'nuevo',NULL,'https://www.amazon.es/s?k=Google+Pixel+8a',NULL,'unknown'),(27,6,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Google+Pixel+8a',NULL,'unknown'),(28,6,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Google+Pixel+8a',NULL,'unknown'),(29,6,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Google+Pixel+8a',NULL,'unknown'),(30,6,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Google+Pixel+8a',NULL,'unknown'),(31,7,1,'nuevo',NULL,'https://www.amazon.es/s?k=Samsung+Galaxy+A55',NULL,'unknown'),(32,7,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Samsung+Galaxy+A55',NULL,'unknown'),(33,7,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Samsung+Galaxy+A55',NULL,'unknown'),(34,7,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Samsung+Galaxy+A55',NULL,'unknown'),(35,7,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Samsung+Galaxy+A55',NULL,'unknown'),(36,8,1,'nuevo',NULL,'https://www.amazon.es/s?k=OnePlus+Nord+4',NULL,'unknown'),(37,8,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=OnePlus+Nord+4',NULL,'unknown'),(38,8,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=OnePlus+Nord+4',NULL,'unknown'),(39,8,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=OnePlus+Nord+4',NULL,'unknown'),(40,8,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=OnePlus+Nord+4',NULL,'unknown'),(41,9,1,'nuevo',NULL,'https://www.amazon.es/s?k=Samsung+Galaxy+S24+FE',NULL,'unknown'),(42,9,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Samsung+Galaxy+S24+FE',NULL,'unknown'),(43,9,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Samsung+Galaxy+S24+FE',NULL,'unknown'),(44,9,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Samsung+Galaxy+S24+FE',NULL,'unknown'),(45,9,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Samsung+Galaxy+S24+FE',NULL,'unknown'),(46,10,1,'nuevo',NULL,'https://www.amazon.es/s?k=Apple+iPhone+SE+%283%C2%AA+gen%29',NULL,'unknown'),(47,10,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Apple+iPhone+SE+%283%C2%AA+gen%29',NULL,'unknown'),(48,10,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Apple+iPhone+SE+%283%C2%AA+gen%29',NULL,'unknown'),(49,10,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Apple+iPhone+SE+%283%C2%AA+gen%29',NULL,'unknown'),(50,10,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Apple+iPhone+SE+%283%C2%AA+gen%29',NULL,'unknown'),(51,11,1,'nuevo',NULL,'https://www.amazon.es/s?k=Apple+iPhone+15',NULL,'unknown'),(52,11,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Apple+iPhone+15',NULL,'unknown'),(53,11,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Apple+iPhone+15',NULL,'unknown'),(54,11,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Apple+iPhone+15',NULL,'unknown'),(55,11,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Apple+iPhone+15',NULL,'unknown'),(56,12,1,'nuevo',NULL,'https://www.amazon.es/s?k=Google+Pixel+9',NULL,'unknown'),(57,12,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Google+Pixel+9',NULL,'unknown'),(58,12,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Google+Pixel+9',NULL,'unknown'),(59,12,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Google+Pixel+9',NULL,'unknown'),(60,12,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Google+Pixel+9',NULL,'unknown'),(61,13,1,'nuevo',NULL,'https://www.amazon.es/s?k=Samsung+Galaxy+S24',NULL,'unknown'),(62,13,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Samsung+Galaxy+S24',NULL,'unknown'),(63,13,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Samsung+Galaxy+S24',NULL,'unknown'),(64,13,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Samsung+Galaxy+S24',NULL,'unknown'),(65,13,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Samsung+Galaxy+S24',NULL,'unknown'),(66,14,1,'nuevo',NULL,'https://www.amazon.es/s?k=Apple+iPhone+15+Pro',NULL,'unknown'),(67,14,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Apple+iPhone+15+Pro',NULL,'unknown'),(68,14,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Apple+iPhone+15+Pro',NULL,'unknown'),(69,14,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Apple+iPhone+15+Pro',NULL,'unknown'),(70,14,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Apple+iPhone+15+Pro',NULL,'unknown'),(71,15,1,'nuevo',NULL,'https://www.amazon.es/s?k=Samsung+Galaxy+S24+Ultra',NULL,'unknown'),(72,15,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Samsung+Galaxy+S24+Ultra',NULL,'unknown'),(73,15,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Samsung+Galaxy+S24+Ultra',NULL,'unknown'),(74,15,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Samsung+Galaxy+S24+Ultra',NULL,'unknown'),(75,15,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Samsung+Galaxy+S24+Ultra',NULL,'unknown'),(76,16,1,'nuevo',NULL,'https://www.amazon.es/s?k=Apple+iPhone+16',NULL,'unknown'),(77,16,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Apple+iPhone+16',NULL,'unknown'),(78,16,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Apple+iPhone+16',NULL,'unknown'),(79,16,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Apple+iPhone+16',NULL,'unknown'),(80,16,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Apple+iPhone+16',NULL,'unknown'),(81,17,1,'nuevo',NULL,'https://www.amazon.es/s?k=Samsung+Galaxy+Z+Flip6',NULL,'unknown'),(82,17,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Samsung+Galaxy+Z+Flip6',NULL,'unknown'),(83,17,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Samsung+Galaxy+Z+Flip6',NULL,'unknown'),(84,17,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Samsung+Galaxy+Z+Flip6',NULL,'unknown'),(85,17,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Samsung+Galaxy+Z+Flip6',NULL,'unknown'),(86,18,1,'nuevo',NULL,'https://www.amazon.es/s?k=Xiaomi+Xiaomi+14T',NULL,'unknown'),(87,18,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Xiaomi+Xiaomi+14T',NULL,'unknown'),(88,18,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Xiaomi+Xiaomi+14T',NULL,'unknown'),(89,18,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Xiaomi+Xiaomi+14T',NULL,'unknown'),(90,18,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Xiaomi+Xiaomi+14T',NULL,'unknown'),(91,19,1,'nuevo',NULL,'https://www.amazon.es/s?k=Google+Pixel+9a',NULL,'unknown'),(92,19,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Google+Pixel+9a',NULL,'unknown'),(93,19,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Google+Pixel+9a',NULL,'unknown'),(94,19,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Google+Pixel+9a',NULL,'unknown'),(95,19,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Google+Pixel+9a',NULL,'unknown'),(96,20,1,'nuevo',NULL,'https://www.amazon.es/s?k=OnePlus+OnePlus+12',NULL,'unknown'),(97,20,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=OnePlus+OnePlus+12',NULL,'unknown'),(98,20,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=OnePlus+OnePlus+12',NULL,'unknown'),(99,20,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=OnePlus+OnePlus+12',NULL,'unknown'),(100,20,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=OnePlus+OnePlus+12',NULL,'unknown'),(101,21,1,'nuevo',NULL,'https://www.amazon.es/s?k=Motorola+Motorola+Razr+50',NULL,'unknown'),(102,21,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Motorola+Motorola+Razr+50',NULL,'unknown'),(103,21,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Motorola+Motorola+Razr+50',NULL,'unknown'),(104,21,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Motorola+Motorola+Razr+50',NULL,'unknown'),(105,21,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Motorola+Motorola+Razr+50',NULL,'unknown'),(106,22,1,'nuevo',NULL,'https://www.amazon.es/s?k=OPPO+OPPO+Reno+12',NULL,'unknown'),(107,22,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=OPPO+OPPO+Reno+12',NULL,'unknown'),(108,22,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=OPPO+OPPO+Reno+12',NULL,'unknown'),(109,22,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=OPPO+OPPO+Reno+12',NULL,'unknown'),(110,22,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=OPPO+OPPO+Reno+12',NULL,'unknown'),(111,23,1,'nuevo',NULL,'https://www.amazon.es/s?k=HONOR+HONOR+200',NULL,'unknown'),(112,23,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=HONOR+HONOR+200',NULL,'unknown'),(113,23,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=HONOR+HONOR+200',NULL,'unknown'),(114,23,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=HONOR+HONOR+200',NULL,'unknown'),(115,23,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=HONOR+HONOR+200',NULL,'unknown'),(116,24,1,'nuevo',NULL,'https://www.amazon.es/s?k=Nothing+Nothing+Phone+%282%29',NULL,'unknown'),(117,24,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Nothing+Nothing+Phone+%282%29',NULL,'unknown'),(118,24,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Nothing+Nothing+Phone+%282%29',NULL,'unknown'),(119,24,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Nothing+Nothing+Phone+%282%29',NULL,'unknown'),(120,24,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Nothing+Nothing+Phone+%282%29',NULL,'unknown'),(121,25,1,'nuevo',NULL,'https://www.amazon.es/s?k=Sony+Sony+Xperia+1+VI',NULL,'unknown'),(122,25,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Sony+Sony+Xperia+1+VI',NULL,'unknown'),(123,25,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Sony+Sony+Xperia+1+VI',NULL,'unknown'),(124,25,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Sony+Sony+Xperia+1+VI',NULL,'unknown'),(125,25,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Sony+Sony+Xperia+1+VI',NULL,'unknown'),(126,26,1,'nuevo',NULL,'https://www.amazon.es/s?k=Apple+18+Pro',NULL,'unknown'),(127,26,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Apple+18+Pro',NULL,'unknown'),(128,26,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Apple+18+Pro',NULL,'unknown'),(129,26,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Apple+18+Pro',NULL,'unknown'),(130,26,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Apple+18+Pro',NULL,'unknown'),(131,27,1,'nuevo',NULL,'https://www.amazon.es/s?k=Apple+18+Pro+Max',NULL,'unknown'),(132,27,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Apple+18+Pro+Max',NULL,'unknown'),(133,27,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Apple+18+Pro+Max',NULL,'unknown'),(134,27,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Apple+18+Pro+Max',NULL,'unknown'),(135,27,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Apple+18+Pro+Max',NULL,'unknown'),(136,28,1,'nuevo',NULL,'https://www.amazon.es/s?k=Apple+iPhone+Air',NULL,'unknown'),(137,28,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Apple+iPhone+Air',NULL,'unknown'),(138,28,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Apple+iPhone+Air',NULL,'unknown'),(139,28,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Apple+iPhone+Air',NULL,'unknown'),(140,28,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Apple+iPhone+Air',NULL,'unknown'),(141,29,1,'nuevo',NULL,'https://www.amazon.es/s?k=Apple+17',NULL,'unknown'),(142,29,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Apple+17',NULL,'unknown'),(143,29,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Apple+17',NULL,'unknown'),(144,29,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Apple+17',NULL,'unknown'),(145,29,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Apple+17',NULL,'unknown'),(146,30,1,'nuevo',NULL,'https://www.amazon.es/s?k=Apple+17e',NULL,'unknown'),(147,30,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Apple+17e',NULL,'unknown'),(148,30,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Apple+17e',NULL,'unknown'),(149,30,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Apple+17e',NULL,'unknown'),(150,30,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Apple+17e',NULL,'unknown'),(151,31,1,'nuevo',NULL,'https://www.amazon.es/s?k=Samsung+Galaxy+S26',NULL,'unknown'),(152,31,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Samsung+Galaxy+S26',NULL,'unknown'),(153,31,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Samsung+Galaxy+S26',NULL,'unknown'),(154,31,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Samsung+Galaxy+S26',NULL,'unknown'),(155,31,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Samsung+Galaxy+S26',NULL,'unknown'),(156,32,1,'nuevo',NULL,'https://www.amazon.es/s?k=Samsung+Galaxy+S26+Ultra',NULL,'unknown'),(157,32,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Samsung+Galaxy+S26+Ultra',NULL,'unknown'),(158,32,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Samsung+Galaxy+S26+Ultra',NULL,'unknown'),(159,32,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Samsung+Galaxy+S26+Ultra',NULL,'unknown'),(160,32,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Samsung+Galaxy+S26+Ultra',NULL,'unknown'),(161,33,1,'nuevo',NULL,'https://www.amazon.es/s?k=Samsung+Galaxy+Z+Flip7',NULL,'unknown'),(162,33,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Samsung+Galaxy+Z+Flip7',NULL,'unknown'),(163,33,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Samsung+Galaxy+Z+Flip7',NULL,'unknown'),(164,33,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Samsung+Galaxy+Z+Flip7',NULL,'unknown'),(165,33,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Samsung+Galaxy+Z+Flip7',NULL,'unknown'),(166,34,1,'nuevo',NULL,'https://www.amazon.es/s?k=Google+Pixel+11',NULL,'unknown'),(167,34,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Google+Pixel+11',NULL,'unknown'),(168,34,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Google+Pixel+11',NULL,'unknown'),(169,34,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Google+Pixel+11',NULL,'unknown'),(170,34,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Google+Pixel+11',NULL,'unknown'),(171,35,1,'nuevo',NULL,'https://www.amazon.es/s?k=Google+Pixel+11+Pro',NULL,'unknown'),(172,35,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Google+Pixel+11+Pro',NULL,'unknown'),(173,35,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Google+Pixel+11+Pro',NULL,'unknown'),(174,35,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Google+Pixel+11+Pro',NULL,'unknown'),(175,35,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Google+Pixel+11+Pro',NULL,'unknown'),(176,36,1,'nuevo',NULL,'https://www.amazon.es/s?k=Apple+iPhone+16+Pro',NULL,'unknown'),(177,36,2,'nuevo',NULL,'https://www.mediamarkt.es/es/search.html?query=Apple+iPhone+16+Pro',NULL,'unknown'),(178,36,3,'nuevo',NULL,'https://www.pccomponentes.com/buscar/?query=Apple+iPhone+16+Pro',NULL,'unknown'),(179,36,4,'reacondicionado','Muy bueno','https://www.backmarket.es/es-es/search?q=Apple+iPhone+16+Pro',NULL,'unknown'),(180,36,5,'reacondicionado','Bueno','https://es.webuy.com/search?stext=Apple+iPhone+16+Pro',NULL,'unknown'),(181,1,6,'nuevo',NULL,'https://www.amazon.com/s?k=Xiaomi+Redmi+Note+13',NULL,'unknown'),(182,1,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Xiaomi+Redmi+Note+13',NULL,'unknown'),(183,1,8,'nuevo',NULL,'https://www.walmart.com/search?q=Xiaomi+Redmi+Note+13',NULL,'unknown'),(184,2,6,'nuevo',NULL,'https://www.amazon.com/s?k=Samsung+Galaxy+A15',NULL,'unknown'),(185,2,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Samsung+Galaxy+A15',NULL,'unknown'),(186,2,8,'nuevo',NULL,'https://www.walmart.com/search?q=Samsung+Galaxy+A15',NULL,'unknown'),(187,3,6,'nuevo',NULL,'https://www.amazon.com/s?k=Motorola+Moto+G54',NULL,'unknown'),(188,3,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Motorola+Moto+G54',NULL,'unknown'),(189,3,8,'nuevo',NULL,'https://www.walmart.com/search?q=Motorola+Moto+G54',NULL,'unknown'),(190,4,6,'nuevo',NULL,'https://www.amazon.com/s?k=Samsung+Galaxy+A35',NULL,'unknown'),(191,4,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Samsung+Galaxy+A35',NULL,'unknown'),(192,4,8,'nuevo',NULL,'https://www.walmart.com/search?q=Samsung+Galaxy+A35',NULL,'unknown'),(193,5,6,'nuevo',NULL,'https://www.amazon.com/s?k=Nothing+Phone+%282a%29',NULL,'unknown'),(194,5,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Nothing+Phone+%282a%29',NULL,'unknown'),(195,5,8,'nuevo',NULL,'https://www.walmart.com/search?q=Nothing+Phone+%282a%29',NULL,'unknown'),(196,6,6,'nuevo',NULL,'https://www.amazon.com/s?k=Google+Pixel+8a',NULL,'unknown'),(197,6,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Google+Pixel+8a',NULL,'unknown'),(198,6,8,'nuevo',NULL,'https://www.walmart.com/search?q=Google+Pixel+8a',NULL,'unknown'),(199,7,6,'nuevo',NULL,'https://www.amazon.com/s?k=Samsung+Galaxy+A55',NULL,'unknown'),(200,7,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Samsung+Galaxy+A55',NULL,'unknown'),(201,7,8,'nuevo',NULL,'https://www.walmart.com/search?q=Samsung+Galaxy+A55',NULL,'unknown'),(202,8,6,'nuevo',NULL,'https://www.amazon.com/s?k=OnePlus+Nord+4',NULL,'unknown'),(203,8,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=OnePlus+Nord+4',NULL,'unknown'),(204,8,8,'nuevo',NULL,'https://www.walmart.com/search?q=OnePlus+Nord+4',NULL,'unknown'),(205,9,6,'nuevo',NULL,'https://www.amazon.com/s?k=Samsung+Galaxy+S24+FE',NULL,'unknown'),(206,9,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Samsung+Galaxy+S24+FE',NULL,'unknown'),(207,9,8,'nuevo',NULL,'https://www.walmart.com/search?q=Samsung+Galaxy+S24+FE',NULL,'unknown'),(208,10,6,'nuevo',NULL,'https://www.amazon.com/s?k=Apple+iPhone+SE+%283%C2%AA+gen%29',NULL,'unknown'),(209,10,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Apple+iPhone+SE+%283%C2%AA+gen%29',NULL,'unknown'),(210,10,8,'nuevo',NULL,'https://www.walmart.com/search?q=Apple+iPhone+SE+%283%C2%AA+gen%29',NULL,'unknown'),(211,11,6,'nuevo',NULL,'https://www.amazon.com/s?k=Apple+iPhone+15',NULL,'unknown'),(212,11,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Apple+iPhone+15',NULL,'unknown'),(213,11,8,'nuevo',NULL,'https://www.walmart.com/search?q=Apple+iPhone+15',NULL,'unknown'),(214,12,6,'nuevo',NULL,'https://www.amazon.com/s?k=Google+Pixel+9',NULL,'unknown'),(215,12,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Google+Pixel+9',NULL,'unknown'),(216,12,8,'nuevo',NULL,'https://www.walmart.com/search?q=Google+Pixel+9',NULL,'unknown'),(217,13,6,'nuevo',NULL,'https://www.amazon.com/s?k=Samsung+Galaxy+S24',NULL,'unknown'),(218,13,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Samsung+Galaxy+S24',NULL,'unknown'),(219,13,8,'nuevo',NULL,'https://www.walmart.com/search?q=Samsung+Galaxy+S24',NULL,'unknown'),(220,14,6,'nuevo',NULL,'https://www.amazon.com/s?k=Apple+iPhone+15+Pro',NULL,'unknown'),(221,14,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Apple+iPhone+15+Pro',NULL,'unknown'),(222,14,8,'nuevo',NULL,'https://www.walmart.com/search?q=Apple+iPhone+15+Pro',NULL,'unknown'),(223,15,6,'nuevo',NULL,'https://www.amazon.com/s?k=Samsung+Galaxy+S24+Ultra',NULL,'unknown'),(224,15,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Samsung+Galaxy+S24+Ultra',NULL,'unknown'),(225,15,8,'nuevo',NULL,'https://www.walmart.com/search?q=Samsung+Galaxy+S24+Ultra',NULL,'unknown'),(226,16,6,'nuevo',NULL,'https://www.amazon.com/s?k=Apple+iPhone+16',NULL,'unknown'),(227,16,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Apple+iPhone+16',NULL,'unknown'),(228,16,8,'nuevo',NULL,'https://www.walmart.com/search?q=Apple+iPhone+16',NULL,'unknown'),(229,17,6,'nuevo',NULL,'https://www.amazon.com/s?k=Samsung+Galaxy+Z+Flip6',NULL,'unknown'),(230,17,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Samsung+Galaxy+Z+Flip6',NULL,'unknown'),(231,17,8,'nuevo',NULL,'https://www.walmart.com/search?q=Samsung+Galaxy+Z+Flip6',NULL,'unknown'),(232,18,6,'nuevo',NULL,'https://www.amazon.com/s?k=Xiaomi+14T',NULL,'unknown'),(233,18,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Xiaomi+14T',NULL,'unknown'),(234,18,8,'nuevo',NULL,'https://www.walmart.com/search?q=Xiaomi+14T',NULL,'unknown'),(235,19,6,'nuevo',NULL,'https://www.amazon.com/s?k=Google+Pixel+9a',NULL,'unknown'),(236,19,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Google+Pixel+9a',NULL,'unknown'),(237,19,8,'nuevo',NULL,'https://www.walmart.com/search?q=Google+Pixel+9a',NULL,'unknown'),(238,20,6,'nuevo',NULL,'https://www.amazon.com/s?k=OnePlus+12',NULL,'unknown'),(239,20,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=OnePlus+12',NULL,'unknown'),(240,20,8,'nuevo',NULL,'https://www.walmart.com/search?q=OnePlus+12',NULL,'unknown'),(241,21,6,'nuevo',NULL,'https://www.amazon.com/s?k=Motorola+Razr+50',NULL,'unknown'),(242,21,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Motorola+Razr+50',NULL,'unknown'),(243,21,8,'nuevo',NULL,'https://www.walmart.com/search?q=Motorola+Razr+50',NULL,'unknown'),(244,22,6,'nuevo',NULL,'https://www.amazon.com/s?k=OPPO+Reno+12',NULL,'unknown'),(245,22,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=OPPO+Reno+12',NULL,'unknown'),(246,22,8,'nuevo',NULL,'https://www.walmart.com/search?q=OPPO+Reno+12',NULL,'unknown'),(247,23,6,'nuevo',NULL,'https://www.amazon.com/s?k=HONOR+200',NULL,'unknown'),(248,23,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=HONOR+200',NULL,'unknown'),(249,23,8,'nuevo',NULL,'https://www.walmart.com/search?q=HONOR+200',NULL,'unknown'),(250,24,6,'nuevo',NULL,'https://www.amazon.com/s?k=Nothing+Phone+%282%29',NULL,'unknown'),(251,24,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Nothing+Phone+%282%29',NULL,'unknown'),(252,24,8,'nuevo',NULL,'https://www.walmart.com/search?q=Nothing+Phone+%282%29',NULL,'unknown'),(253,25,6,'nuevo',NULL,'https://www.amazon.com/s?k=Sony+Xperia+1+VI',NULL,'unknown'),(254,25,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Sony+Xperia+1+VI',NULL,'unknown'),(255,25,8,'nuevo',NULL,'https://www.walmart.com/search?q=Sony+Xperia+1+VI',NULL,'unknown'),(256,26,6,'nuevo',NULL,'https://www.amazon.com/s?k=Apple+iPhone+18+Pro',NULL,'unknown'),(257,26,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Apple+iPhone+18+Pro',NULL,'unknown'),(258,26,8,'nuevo',NULL,'https://www.walmart.com/search?q=Apple+iPhone+18+Pro',NULL,'unknown'),(259,27,6,'nuevo',NULL,'https://www.amazon.com/s?k=Apple+iPhone+18+Pro+Max',NULL,'unknown'),(260,27,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Apple+iPhone+18+Pro+Max',NULL,'unknown'),(261,27,8,'nuevo',NULL,'https://www.walmart.com/search?q=Apple+iPhone+18+Pro+Max',NULL,'unknown'),(262,28,6,'nuevo',NULL,'https://www.amazon.com/s?k=Apple+iPhone+Air',NULL,'unknown'),(263,28,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Apple+iPhone+Air',NULL,'unknown'),(264,28,8,'nuevo',NULL,'https://www.walmart.com/search?q=Apple+iPhone+Air',NULL,'unknown'),(265,29,6,'nuevo',NULL,'https://www.amazon.com/s?k=Apple+iPhone+17',NULL,'unknown'),(266,29,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Apple+iPhone+17',NULL,'unknown'),(267,29,8,'nuevo',NULL,'https://www.walmart.com/search?q=Apple+iPhone+17',NULL,'unknown'),(268,30,6,'nuevo',NULL,'https://www.amazon.com/s?k=Apple+iPhone+17e',NULL,'unknown'),(269,30,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Apple+iPhone+17e',NULL,'unknown'),(270,30,8,'nuevo',NULL,'https://www.walmart.com/search?q=Apple+iPhone+17e',NULL,'unknown'),(271,31,6,'nuevo',NULL,'https://www.amazon.com/s?k=Samsung+Galaxy+S26',NULL,'unknown'),(272,31,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Samsung+Galaxy+S26',NULL,'unknown'),(273,31,8,'nuevo',NULL,'https://www.walmart.com/search?q=Samsung+Galaxy+S26',NULL,'unknown'),(274,32,6,'nuevo',NULL,'https://www.amazon.com/s?k=Samsung+Galaxy+S26+Ultra',NULL,'unknown'),(275,32,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Samsung+Galaxy+S26+Ultra',NULL,'unknown'),(276,32,8,'nuevo',NULL,'https://www.walmart.com/search?q=Samsung+Galaxy+S26+Ultra',NULL,'unknown'),(277,33,6,'nuevo',NULL,'https://www.amazon.com/s?k=Samsung+Galaxy+Z+Flip7',NULL,'unknown'),(278,33,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Samsung+Galaxy+Z+Flip7',NULL,'unknown'),(279,33,8,'nuevo',NULL,'https://www.walmart.com/search?q=Samsung+Galaxy+Z+Flip7',NULL,'unknown'),(280,34,6,'nuevo',NULL,'https://www.amazon.com/s?k=Google+Pixel+11',NULL,'unknown'),(281,34,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Google+Pixel+11',NULL,'unknown'),(282,34,8,'nuevo',NULL,'https://www.walmart.com/search?q=Google+Pixel+11',NULL,'unknown'),(283,35,6,'nuevo',NULL,'https://www.amazon.com/s?k=Google+Pixel+11+Pro',NULL,'unknown'),(284,35,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Google+Pixel+11+Pro',NULL,'unknown'),(285,35,8,'nuevo',NULL,'https://www.walmart.com/search?q=Google+Pixel+11+Pro',NULL,'unknown'),(286,36,6,'nuevo',NULL,'https://www.amazon.com/s?k=Apple+iPhone+16+Pro',NULL,'unknown'),(287,36,7,'nuevo',NULL,'https://www.bestbuy.com/site/searchpage.jsp?st=Apple+iPhone+16+Pro',NULL,'unknown'),(288,36,8,'nuevo',NULL,'https://www.walmart.com/search?q=Apple+iPhone+16+Pro',NULL,'unknown');
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

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
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retailers`
--

LOCK TABLES `retailers` WRITE;
/*!40000 ALTER TABLE `retailers` DISABLE KEYS */;
INSERT INTO `retailers` VALUES (1,'Amazon','amazon','ES',NULL),(2,'MediaMarkt','mediamarkt','ES',NULL),(3,'PcComponentes','pccomponentes','ES',NULL),(4,'Back Market','backmarket','ES',NULL),(5,'CeX','cex','ES',NULL),(6,'Amazon','amazon-us','US',NULL),(7,'Best Buy','bestbuy','US',NULL),(8,'Walmart','walmart','US',NULL);
/*!40000 ALTER TABLE `retailers` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `smartphone_categories`
--

LOCK TABLES `smartphone_categories` WRITE;
/*!40000 ALTER TABLE `smartphone_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `smartphone_categories` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smartphones`
--

LOCK TABLES `smartphones` WRITE;
/*!40000 ALTER TABLE `smartphones` DISABLE KEYS */;
INSERT INTO `smartphones` VALUES (1,1,'Redmi Note 13','redmi-note-13',NULL,'Android','6.67\" AMOLED',NULL,NULL,'120 Hz','Snapdragon 685','8 GB','256 GB','5000 mAh','33 W',0,'108 MP','8 MP','—','16 MP','188 g',NULL,'IP54','normal',0,1,0,2,60,55,50,80,65,90,179.00,220.00,105.00,165.00,1,'2026-09-16',0,1,'2026-09-16 21:43:40','2026-09-16 21:43:40'),(2,2,'Galaxy A15','galaxy-a15',NULL,'Android','6.5\" AMOLED',NULL,NULL,'90 Hz','Helio G99','6 GB','128 GB','5000 mAh','25 W',0,'50 MP','5 MP','—','13 MP','200 g',NULL,'No','normal',0,1,0,4,55,50,45,78,60,85,110.00,190.00,65.00,145.00,1,'2026-09-16',0,1,'2026-09-16 21:43:40','2026-09-16 21:43:40'),(3,3,'Moto G54','moto-g54',NULL,'Android','6.5\" IPS',NULL,NULL,'120 Hz','Dimensity 7020','8 GB','256 GB','5000 mAh','33 W',0,'50 MP','8 MP','—','16 MP','191 g',NULL,'IP52','normal',1,1,0,2,58,52,55,82,58,88,125.00,220.00,75.00,165.00,1,'2026-09-16',0,1,'2026-09-16 21:43:40','2026-09-16 21:43:40'),(4,2,'Galaxy A35','galaxy-a35',NULL,'Android','6.6\" AMOLED',NULL,NULL,'120 Hz','Exynos 1380','8 GB','256 GB','5000 mAh','25 W',0,'50 MP','8 MP','—','13 MP','209 g',NULL,'IP67','normal',1,1,0,4,68,60,58,75,72,85,245.00,380.00,145.00,285.00,1,'2026-09-16',0,1,'2026-09-16 21:43:40','2026-09-16 21:43:40'),(5,4,'Phone (2a)','nothing-phone-2a',NULL,'Android','6.7\" AMOLED',NULL,NULL,'120 Hz','Dimensity 7200 Pro','8 GB','256 GB','5000 mAh','45 W',0,'50 MP','50 MP','—','32 MP','190 g',NULL,'IP54','normal',1,1,0,3,70,65,60,80,75,84,329.00,377.69,175.00,295.00,1,'2026-09-21',0,1,'2026-09-16 21:43:40','2026-09-21 12:47:45'),(6,5,'Pixel 8a','pixel-8a',NULL,'Android','6.1\" OLED',NULL,NULL,'120 Hz','Google Tensor G3','8 GB','128 GB','4492 mAh','18 W',1,'64 MP','13 MP','—','13 MP','188 g',NULL,'IP67','compacto',1,1,1,6,90,75,65,72,78,82,362.90,362.90,190.00,325.00,1,'2026-09-21',0,1,'2026-09-16 21:43:40','2026-09-21 12:47:45'),(7,2,'Galaxy A55','galaxy-a55',NULL,'Android','6.6\" AMOLED',NULL,NULL,'120 Hz','Exynos 1480','8 GB','256 GB','5000 mAh','25 W',0,'50 MP','12 MP','5 MP','32 MP','213 g',NULL,'IP67','normal',1,1,0,4,75,68,62,78,80,80,349.00,379.99,205.00,345.00,1,'2026-09-21',0,1,'2026-09-16 21:43:40','2026-09-21 12:47:45'),(8,6,'Nord 4','nord-4',NULL,'Android','6.74\" AMOLED',NULL,NULL,'120 Hz','Snapdragon 7+ Gen 3','8 GB','256 GB','5500 mAh','100 W',0,'50 MP','8 MP','—','16 MP','199 g',NULL,'IP65','normal',1,1,0,3,76,82,80,85,78,83,366.00,614.00,230.00,390.00,1,'2026-09-21',0,1,'2026-09-16 21:43:40','2026-09-21 12:47:45'),(9,2,'Galaxy S24 FE','galaxy-s24-fe',NULL,'Android','6.7\" AMOLED',NULL,NULL,'120 Hz','Exynos 2400e','8 GB','256 GB','4700 mAh','25 W',1,'50 MP','12 MP','8 MP','10 MP','213 g',NULL,'IP68','normal',1,1,1,5,85,82,78,80,85,78,432.83,439.99,295.00,495.00,1,'2026-09-21',0,1,'2026-09-16 21:43:40','2026-09-21 12:47:45'),(10,7,'iPhone SE (3ª gen)','iphone-se',NULL,'iOS','4.7\" IPS',NULL,NULL,'60 Hz','A15 Bionic','4 GB','128 GB','2018 mAh','20 W',1,'12 MP','—','—','7 MP','144 g',NULL,'IP67','compacto',1,1,1,5,65,80,75,60,55,68,430.00,570.00,260.00,430.00,0,NULL,1,1,'2026-09-16 21:43:40','2026-09-16 21:43:40'),(11,7,'iPhone 15','iphone-15',NULL,'iOS','6.1\" OLED',NULL,NULL,'60 Hz','A16 Bionic','6 GB','128 GB','3349 mAh','20 W',1,'48 MP','12 MP','—','12 MP','171 g',NULL,'IP68','compacto',1,1,1,6,88,88,82,78,82,70,669.00,669.00,420.00,625.00,1,'2026-09-21',0,1,'2026-09-16 21:43:40','2026-09-21 12:47:45'),(12,5,'Pixel 9','pixel-9',NULL,'Android','6.3\" OLED',NULL,NULL,'120 Hz','Google Tensor G4','12 GB','128 GB','4700 mAh','27 W',1,'50 MP','48 MP','—','10.5 MP','198 g',NULL,'IP68','normal',1,1,1,7,95,85,78,80,85,75,474.99,919.00,410.00,615.00,1,'2026-09-21',0,1,'2026-09-16 21:43:40','2026-09-21 12:47:45'),(13,2,'Galaxy S24','galaxy-s24',NULL,'Android','6.2\" AMOLED',NULL,NULL,'120 Hz','Snapdragon 8 Gen 3','8 GB','256 GB','4000 mAh','25 W',1,'50 MP','12 MP','10 MP','12 MP','167 g',NULL,'IP68','compacto',1,1,1,7,90,88,85,82,90,75,499.00,526.00,420.00,655.00,1,'2026-09-21',0,1,'2026-09-16 21:43:40','2026-09-21 12:47:45'),(14,7,'iPhone 15 Pro','iphone-15-pro',NULL,'iOS','6.1\" OLED',NULL,NULL,'120 Hz','A17 Pro','8 GB','256 GB','3274 mAh','27 W',1,'48 MP','12 MP','12 MP','12 MP','187 g',NULL,'IP68','normal',1,1,1,7,94,96,92,80,90,65,900.00,1060.00,540.00,795.00,0,NULL,1,1,'2026-09-16 21:43:40','2026-09-16 21:43:40'),(15,2,'Galaxy S24 Ultra','galaxy-s24-ultra',NULL,'Android','6.8\" AMOLED',NULL,NULL,'120 Hz','Snapdragon 8 Gen 3','12 GB','256 GB','5000 mAh','45 W',1,'200 MP','12 MP','50 MP','12 MP','233 g',NULL,'IP68','grande',1,1,1,7,98,95,90,85,96,68,749.99,759.99,630.00,970.00,1,'2026-09-21',0,1,'2026-09-16 21:43:40','2026-09-21 12:47:45'),(16,7,'iPhone 16','iphone-16',NULL,'iOS','6.1\" OLED',NULL,NULL,'60 Hz','Apple A18','8 GB','128 GB','3561 mAh','20 W',1,'48 MP','12 MP','—','12 MP','170 g',NULL,'IP68','compacto',1,1,1,6,90,92,88,80,82,68,809.00,819.00,540.00,750.00,1,'2026-09-21',0,1,'2026-09-17 12:02:38','2026-09-21 12:47:45'),(17,2,'Galaxy Z Flip6','galaxy-z-flip6',NULL,'Android','6.7\" AMOLED plegable',NULL,NULL,'120 Hz','Snapdragon 8 Gen 3 for Galaxy','12 GB','256 GB','4000 mAh','25 W',1,'50 MP','12 MP','—','10 MP','187 g',NULL,'IPX8','compacto',1,1,1,7,82,85,80,72,85,60,599.99,599.99,630.00,900.00,1,'2026-09-21',0,1,'2026-09-17 12:02:38','2026-09-21 12:47:45'),(18,1,'14T','xiaomi-14t',NULL,'Android','6.67\" AMOLED',NULL,NULL,'120 Hz','Dimensity 8300-Ultra','12 GB','256 GB','5000 mAh','67 W',0,'50 MP','12 MP','50 MP','32 MP','193 g',NULL,'IP68','normal',1,1,0,4,84,78,75,82,78,82,352.98,583.70,240.00,360.00,1,'2026-09-21',0,1,'2026-09-17 12:02:38','2026-09-21 12:47:45'),(19,5,'Pixel 9a','pixel-9a',NULL,'Android','6.3\" OLED',NULL,NULL,'120 Hz','Google Tensor G4','8 GB','128 GB','5100 mAh','23 W',1,'48 MP','13 MP','—','13 MP','186 g',NULL,'IP68','compacto',1,1,1,7,87,78,68,82,80,85,487.13,489.99,290.00,410.00,1,'2026-09-21',0,1,'2026-09-17 12:02:38','2026-09-21 12:47:45'),(20,6,'12','oneplus-12',NULL,'Android','6.82\" AMOLED',NULL,NULL,'120 Hz','Snapdragon 8 Gen 3','16 GB','256 GB','5400 mAh','100 W',1,'50 MP','48 MP','64 MP','32 MP','220 g',NULL,'IP65','normal',1,1,0,4,88,92,90,88,90,78,479.97,709.00,480.00,710.00,1,'2026-09-21',0,1,'2026-09-17 12:02:38','2026-09-21 12:47:45'),(21,3,'Razr 50','moto-razr-50',NULL,'Android','6.9\" pOLED plegable',NULL,NULL,'120 Hz','Dimensity 7300X','8 GB','256 GB','4200 mAh','30 W',1,'50 MP','13 MP','—','32 MP','189 g',NULL,'IPX8','compacto',1,1,0,3,75,68,62,75,80,74,449.00,469.99,330.00,490.00,1,'2026-09-21',0,1,'2026-09-17 12:02:38','2026-09-21 12:47:45'),(22,15,'Reno 12','oppo-reno-12',NULL,'Android','6.7\" AMOLED',NULL,NULL,'120 Hz','Dimensity 7300-Energy','12 GB','256 GB','5800 mAh','80 W',0,'50 MP','8 MP','32 MP','50 MP','186 g',NULL,'IP65','normal',1,1,0,3,78,70,65,85,78,80,314.99,314.99,260.00,375.00,1,'2026-09-21',0,1,'2026-09-17 12:02:38','2026-09-21 12:47:45'),(23,16,'200','honor-200',NULL,'Android','6.7\" AMOLED',NULL,NULL,'120 Hz','Snapdragon 7 Gen 3','12 GB','512 GB','5200 mAh','66 W',0,'50 MP','12 MP','50 MP','50 MP','187 g',NULL,'IP54','normal',1,1,0,4,82,74,68,80,80,82,339.19,339.19,290.00,410.00,1,'2026-09-21',0,1,'2026-09-17 12:02:38','2026-09-21 12:47:45'),(24,4,'Phone (2)','nothing-phone-2',NULL,'Android','6.7\" AMOLED',NULL,NULL,'120 Hz','Snapdragon 8+ Gen 1','12 GB','256 GB','4700 mAh','45 W',1,'50 MP','50 MP','—','32 MP','201 g',NULL,'IP54','normal',1,1,0,3,78,80,78,78,82,76,289.00,289.00,300.00,450.00,1,'2026-09-21',0,1,'2026-09-17 12:02:38','2026-09-21 12:47:45'),(25,17,'Xperia 1 VI','sony-xperia-1-vi',NULL,'Android','6.5\" OLED 21:9',NULL,NULL,'120 Hz','Snapdragon 8 Gen 3','12 GB','256 GB','5000 mAh','30 W',1,'48 MP','48 MP','48 MP','12 MP','192 g',NULL,'IP68','normal',1,1,0,4,90,88,82,78,88,55,1195.00,1429.66,750.00,1050.00,1,'2026-09-21',0,1,'2026-09-17 12:02:38','2026-09-21 12:47:45'),(26,7,'iPhone 18 Pro','iphone-18-pro',NULL,'iOS','6.3\" OLED',NULL,NULL,'120 Hz','A20 Pro','12 GB','256 GB','4288 mAh','27 W',1,'48 MP','48 MP','48 MP','18 MP','206 g',NULL,'IP68','normal',1,1,1,7,96,97,94,84,92,62,1319.00,1569.00,790.00,1175.00,0,'2026-09-17',0,1,'2026-09-17 13:01:43','2026-09-17 13:02:19'),(27,7,'iPhone 18 Pro Max','iphone-18-pro-max',NULL,'iOS','6.9\" OLED',NULL,NULL,'120 Hz','A20 Pro','12 GB','256 GB','5567 mAh','27 W',1,'48 MP','48 MP','48 MP','18 MP','226 g',NULL,'IP68','grande',1,1,1,7,97,97,94,90,95,60,1619.00,1899.00,970.00,1425.00,1,'2026-09-17',0,1,'2026-09-17 13:01:43','2026-09-17 13:02:19'),(28,7,'iPhone Air','iphone-air',NULL,'iOS','6.6\" OLED',NULL,NULL,'120 Hz','A19','8 GB','256 GB','2800 mAh','20 W',1,'48 MP','—','—','18 MP','165 g',NULL,'IP68','normal',1,1,1,7,82,90,82,65,88,58,1099.00,1329.00,660.00,995.00,0,'2026-09-17',0,1,'2026-09-17 13:01:43','2026-09-17 13:01:43'),(29,7,'iPhone 17','iphone-17',NULL,'iOS','6.3\" OLED',NULL,NULL,'120 Hz','A19','8 GB','256 GB','3692 mAh','20 W',1,'48 MP','48 MP','—','18 MP','177 g',NULL,'IP68','normal',1,1,1,7,88,89,83,78,84,68,959.00,1109.00,575.00,830.00,1,'2026-09-17',0,1,'2026-09-17 13:01:43','2026-09-17 13:02:19'),(30,7,'iPhone 17e','iphone-17e',NULL,'iOS','6.1\" OLED',NULL,NULL,'60 Hz','A19','8 GB','256 GB','4005 mAh','20 W',1,'48 MP','—','—','12 MP','167 g',NULL,'IP68','compacto',1,1,1,7,68,82,76,80,68,78,649.00,849.00,390.00,635.00,0,'2026-09-17',0,1,'2026-09-17 13:01:43','2026-09-17 13:02:19'),(31,2,'Galaxy S26','galaxy-s26',NULL,'Android','6.3\" AMOLED',NULL,NULL,'120 Hz','Snapdragon 8 Elite Gen 5','12 GB','256 GB','4300 mAh','25 W',1,'50 MP','12 MP','10 MP','12 MP','197 g',NULL,'IP68','normal',1,1,1,7,88,90,87,80,88,74,999.00,1119.00,600.00,840.00,1,'2026-09-17',0,1,'2026-09-17 13:01:43','2026-09-17 13:01:43'),(32,2,'Galaxy S26 Ultra','galaxy-s26-ultra',NULL,'Android','6.9\" AMOLED',NULL,NULL,'120 Hz','Snapdragon 8 Elite Gen 5','12 GB','256 GB','5000 mAh','60 W',1,'200 MP','50 MP','50 MP','12 MP','232 g',NULL,'IP68','grande',1,1,1,7,99,96,92,86,97,64,1449.00,1749.00,870.00,1310.00,1,'2026-09-17',0,1,'2026-09-17 13:01:43','2026-09-17 13:01:43'),(33,2,'Galaxy Z Flip7','galaxy-z-flip7',NULL,'Android','6.9\" AMOLED plegable',NULL,NULL,'120 Hz','Exynos 2500','12 GB','256 GB','4174 mAh','25 W',1,'50 MP','12 MP','—','10 MP','188 g',NULL,'IP48','compacto',1,1,1,7,78,78,72,78,82,76,695.00,820.00,415.00,615.00,1,'2026-09-17',0,1,'2026-09-17 13:01:43','2026-09-17 13:01:43'),(34,5,'Pixel 11','pixel-11',NULL,'Android','6.3\" OLED',NULL,NULL,'120 Hz','Google Tensor G6','12 GB','256 GB','4985 mAh','30 W',1,'48 MP','13 MP','10.8 MP','10.5 MP','207 g',NULL,'IP68','normal',1,1,1,7,92,84,74,82,85,78,999.00,1099.00,600.00,825.00,1,'2026-09-17',0,1,'2026-09-17 13:01:43','2026-09-17 13:01:43'),(35,5,'Pixel 11 Pro','pixel-11-pro',NULL,'Android','6.3\" LTPO OLED',NULL,NULL,'120 Hz','Google Tensor G6','12 GB','256 GB','4850 mAh','30 W',1,'50 MP','48 MP','48 MP','42 MP','210 g',NULL,'IP68','normal',1,1,1,7,97,86,76,80,90,68,1229.00,1349.00,735.00,1010.00,0,'2026-09-17',0,1,'2026-09-17 13:01:43','2026-09-17 13:01:43'),(36,7,'iPhone 16 Pro','iphone-16-pro',NULL,'iOS','6.3\" OLED',NULL,NULL,'120 Hz','A18 Pro','8 GB','128 GB','3582 mAh','27 W',1,'48 MP','48 MP','12 MP','12 MP','199 g',NULL,'IP68','normal',1,1,1,7,93,95,90,82,88,64,1219.00,1489.00,730.00,1090.00,0,'2026-09-20',0,1,'2026-09-20 21:00:00','2026-09-20 21:00:00');
/*!40000 ALTER TABLE `smartphones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-21 12:47:54
