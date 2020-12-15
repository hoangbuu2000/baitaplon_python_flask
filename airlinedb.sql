-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: airlinedb
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` int NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`id`) REFERENCES `nhanvien` (`id`),
  CONSTRAINT `account_chk_1` CHECK ((`active` in (0,1)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'hoangbuu2000','e10adc3949ba59abbe56e057f20f883e',1);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chitietdatcho`
--

DROP TABLE IF EXISTS `chitietdatcho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chitietdatcho` (
  `ghe_id` int NOT NULL,
  `phieudatcho_id` int NOT NULL,
  PRIMARY KEY (`ghe_id`,`phieudatcho_id`),
  KEY `phieudatcho_id` (`phieudatcho_id`),
  CONSTRAINT `chitietdatcho_ibfk_1` FOREIGN KEY (`ghe_id`) REFERENCES `ghe` (`id`),
  CONSTRAINT `chitietdatcho_ibfk_2` FOREIGN KEY (`phieudatcho_id`) REFERENCES `phieudatcho` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chitietdatcho`
--

LOCK TABLES `chitietdatcho` WRITE;
/*!40000 ALTER TABLE `chitietdatcho` DISABLE KEYS */;
INSERT INTO `chitietdatcho` VALUES (201,29),(300,30),(511,34),(310,36),(310,37),(294,38),(522,39),(522,40),(522,41),(522,42),(522,43),(522,44),(522,45),(523,46);
/*!40000 ALTER TABLE `chitietdatcho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chuyenbay`
--

DROP TABLE IF EXISTS `chuyenbay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chuyenbay` (
  `id_chuyen_bay` int NOT NULL AUTO_INCREMENT,
  `id_may_bay` int NOT NULL,
  `id_duong_bay` int NOT NULL,
  `ngay_khoi_hanh` datetime NOT NULL,
  `thoi_gian_bay` time NOT NULL,
  PRIMARY KEY (`id_chuyen_bay`),
  KEY `id_may_bay` (`id_may_bay`),
  KEY `id_duong_bay` (`id_duong_bay`),
  CONSTRAINT `chuyenbay_ibfk_1` FOREIGN KEY (`id_may_bay`) REFERENCES `maybay` (`id`),
  CONSTRAINT `chuyenbay_ibfk_2` FOREIGN KEY (`id_duong_bay`) REFERENCES `duongbay` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chuyenbay`
--

LOCK TABLES `chuyenbay` WRITE;
/*!40000 ALTER TABLE `chuyenbay` DISABLE KEYS */;
INSERT INTO `chuyenbay` VALUES (1,1,1,'2020-12-24 19:00:00','03:00:00'),(2,2,2,'2020-12-23 10:00:00','03:00:00'),(3,3,3,'2020-12-24 14:00:00','03:00:00'),(4,4,4,'2020-12-24 10:00:00','03:30:00'),(5,5,5,'2020-12-24 10:00:00','03:00:00'),(6,6,6,'2020-12-24 02:00:00','01:00:00');
/*!40000 ALTER TABLE `chuyenbay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duongbay`
--

DROP TABLE IF EXISTS `duongbay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `duongbay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_san_bay_di` int NOT NULL,
  `id_san_bay_den` int NOT NULL,
  `khoang_cach` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_san_bay_di` (`id_san_bay_di`),
  KEY `id_san_bay_den` (`id_san_bay_den`),
  CONSTRAINT `duongbay_ibfk_1` FOREIGN KEY (`id_san_bay_di`) REFERENCES `sanbay` (`id`),
  CONSTRAINT `duongbay_ibfk_2` FOREIGN KEY (`id_san_bay_den`) REFERENCES `sanbay` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duongbay`
--

LOCK TABLES `duongbay` WRITE;
/*!40000 ALTER TABLE `duongbay` DISABLE KEYS */;
INSERT INTO `duongbay` VALUES (1,1,2,1616),(2,1,3,1424),(3,4,5,1000),(4,6,7,1200),(5,2,1,1616),(6,8,1,400);
/*!40000 ALTER TABLE `duongbay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ghe`
--

DROP TABLE IF EXISTS `ghe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ghe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `available` tinyint(1) NOT NULL,
  `id_loai_ghe` int NOT NULL,
  `id_may_bay` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_loai_ghe` (`id_loai_ghe`),
  KEY `id_may_bay` (`id_may_bay`),
  CONSTRAINT `ghe_ibfk_1` FOREIGN KEY (`id_loai_ghe`) REFERENCES `loaighe` (`id`),
  CONSTRAINT `ghe_ibfk_2` FOREIGN KEY (`id_may_bay`) REFERENCES `maybay` (`id`),
  CONSTRAINT `ghe_chk_1` CHECK ((`available` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=601 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ghe`
--

LOCK TABLES `ghe` WRITE;
/*!40000 ALTER TABLE `ghe` DISABLE KEYS */;
INSERT INTO `ghe` VALUES (1,'Ghế số 1',1,1,1),(2,'Ghế số 2',1,1,1),(3,'Ghế số 3',1,1,1),(4,'Ghế số 4',1,1,1),(5,'Ghế số 5',1,1,1),(6,'Ghế số 6',1,1,1),(7,'Ghế số 7',1,1,1),(8,'Ghế số 8',1,1,1),(9,'Ghế số 9',1,1,1),(10,'Ghế số 10',1,1,1),(11,'Ghế số 11',1,1,1),(12,'Ghế số 12',1,1,1),(13,'Ghế số 13',1,1,1),(14,'Ghế số 14',1,1,1),(15,'Ghế số 15',1,1,1),(16,'Ghế số 16',1,1,1),(17,'Ghế số 17',1,1,1),(18,'Ghế số 18',1,1,1),(19,'Ghế số 19',1,1,1),(20,'Ghế số 20',1,1,1),(21,'Ghế số 21',1,1,1),(22,'Ghế số 22',1,1,1),(23,'Ghế số 23',1,1,1),(24,'Ghế số 24',1,1,1),(25,'Ghế số 25',1,1,1),(26,'Ghế số 26',1,1,1),(27,'Ghế số 27',1,1,1),(28,'Ghế số 28',1,1,1),(29,'Ghế số 29',1,1,1),(30,'Ghế số 30',1,1,1),(31,'Ghế số 31',1,1,1),(32,'Ghế số 32',1,1,1),(33,'Ghế số 33',1,1,1),(34,'Ghế số 34',1,1,1),(35,'Ghế số 35',1,1,1),(36,'Ghế số 36',1,1,1),(37,'Ghế số 37',1,1,1),(38,'Ghế số 38',1,1,1),(39,'Ghế số 39',1,1,1),(40,'Ghế số 40',1,1,1),(41,'Ghế số 41',1,2,1),(42,'Ghế số 42',1,2,1),(43,'Ghế số 43',1,2,1),(44,'Ghế số 44',1,2,1),(45,'Ghế số 45',1,2,1),(46,'Ghế số 46',1,2,1),(47,'Ghế số 47',1,2,1),(48,'Ghế số 48',1,2,1),(49,'Ghế số 49',1,2,1),(50,'Ghế số 50',1,2,1),(51,'Ghế số 51',1,2,1),(52,'Ghế số 52',1,2,1),(53,'Ghế số 53',1,2,1),(54,'Ghế số 54',1,2,1),(55,'Ghế số 55',1,2,1),(56,'Ghế số 56',1,2,1),(57,'Ghế số 57',1,2,1),(58,'Ghế số 58',1,2,1),(59,'Ghế số 59',1,2,1),(60,'Ghế số 60',1,2,1),(61,'Ghế số 61',1,2,1),(62,'Ghế số 62',1,2,1),(63,'Ghế số 63',1,2,1),(64,'Ghế số 64',1,2,1),(65,'Ghế số 65',1,2,1),(66,'Ghế số 66',1,2,1),(67,'Ghế số 67',1,2,1),(68,'Ghế số 68',1,2,1),(69,'Ghế số 69',1,2,1),(70,'Ghế số 70',1,2,1),(71,'Ghế số 71',1,2,1),(72,'Ghế số 72',1,2,1),(73,'Ghế số 73',1,2,1),(74,'Ghế số 74',1,2,1),(75,'Ghế số 75',1,2,1),(76,'Ghế số 76',1,2,1),(77,'Ghế số 77',1,2,1),(78,'Ghế số 78',1,2,1),(79,'Ghế số 79',1,2,1),(80,'Ghế số 80',1,2,1),(81,'Ghế số 81',1,2,1),(82,'Ghế số 82',1,2,1),(83,'Ghế số 83',1,2,1),(84,'Ghế số 84',1,2,1),(85,'Ghế số 85',1,2,1),(86,'Ghế số 86',1,2,1),(87,'Ghế số 87',1,2,1),(88,'Ghế số 88',1,2,1),(89,'Ghế số 89',1,2,1),(90,'Ghế số 90',1,2,1),(91,'Ghế số 91',1,2,1),(92,'Ghế số 92',1,2,1),(93,'Ghế số 93',1,2,1),(94,'Ghế số 94',1,2,1),(95,'Ghế số 95',1,2,1),(96,'Ghế số 96',1,2,1),(97,'Ghế số 97',1,2,1),(98,'Ghế số 98',1,2,1),(99,'Ghế số 99',1,2,1),(100,'Ghế số 100',1,2,1),(101,'Ghế số 1',1,1,2),(102,'Ghế số 2',1,1,2),(103,'Ghế số 3',1,1,2),(104,'Ghế số 4',1,1,2),(105,'Ghế số 5',1,1,2),(106,'Ghế số 6',1,1,2),(107,'Ghế số 7',1,1,2),(108,'Ghế số 8',1,1,2),(109,'Ghế số 9',1,1,2),(110,'Ghế số 10',1,1,2),(111,'Ghế số 11',1,1,2),(112,'Ghế số 12',1,1,2),(113,'Ghế số 13',1,1,2),(114,'Ghế số 14',1,1,2),(115,'Ghế số 15',1,1,2),(116,'Ghế số 16',1,1,2),(117,'Ghế số 17',1,1,2),(118,'Ghế số 18',1,1,2),(119,'Ghế số 19',1,1,2),(120,'Ghế số 20',1,1,2),(121,'Ghế số 21',1,1,2),(122,'Ghế số 22',1,1,2),(123,'Ghế số 23',1,1,2),(124,'Ghế số 24',1,1,2),(125,'Ghế số 25',1,1,2),(126,'Ghế số 26',1,1,2),(127,'Ghế số 27',1,1,2),(128,'Ghế số 28',1,1,2),(129,'Ghế số 29',1,1,2),(130,'Ghế số 30',1,1,2),(131,'Ghế số 31',1,1,2),(132,'Ghế số 32',1,1,2),(133,'Ghế số 33',1,1,2),(134,'Ghế số 34',1,1,2),(135,'Ghế số 35',1,1,2),(136,'Ghế số 36',1,1,2),(137,'Ghế số 37',1,1,2),(138,'Ghế số 38',1,1,2),(139,'Ghế số 39',1,1,2),(140,'Ghế số 40',1,1,2),(141,'Ghế số 41',1,2,2),(142,'Ghế số 42',1,2,2),(143,'Ghế số 43',1,2,2),(144,'Ghế số 44',1,2,2),(145,'Ghế số 45',1,2,2),(146,'Ghế số 46',1,2,2),(147,'Ghế số 47',1,2,2),(148,'Ghế số 48',1,2,2),(149,'Ghế số 49',0,2,2),(150,'Ghế số 50',0,2,2),(151,'Ghế số 51',1,2,2),(152,'Ghế số 52',1,2,2),(153,'Ghế số 53',1,2,2),(154,'Ghế số 54',1,2,2),(155,'Ghế số 55',1,2,2),(156,'Ghế số 56',1,2,2),(157,'Ghế số 57',1,2,2),(158,'Ghế số 58',1,2,2),(159,'Ghế số 59',1,2,2),(160,'Ghế số 60',1,2,2),(161,'Ghế số 61',1,2,2),(162,'Ghế số 62',1,2,2),(163,'Ghế số 63',1,2,2),(164,'Ghế số 64',1,2,2),(165,'Ghế số 65',1,2,2),(166,'Ghế số 66',1,2,2),(167,'Ghế số 67',1,2,2),(168,'Ghế số 68',1,2,2),(169,'Ghế số 69',1,2,2),(170,'Ghế số 70',1,2,2),(171,'Ghế số 71',1,2,2),(172,'Ghế số 72',1,2,2),(173,'Ghế số 73',1,2,2),(174,'Ghế số 74',1,2,2),(175,'Ghế số 75',1,2,2),(176,'Ghế số 76',1,2,2),(177,'Ghế số 77',1,2,2),(178,'Ghế số 78',1,2,2),(179,'Ghế số 79',1,2,2),(180,'Ghế số 80',1,2,2),(181,'Ghế số 81',1,2,2),(182,'Ghế số 82',1,2,2),(183,'Ghế số 83',1,2,2),(184,'Ghế số 84',1,2,2),(185,'Ghế số 85',1,2,2),(186,'Ghế số 86',1,2,2),(187,'Ghế số 87',1,2,2),(188,'Ghế số 88',1,2,2),(189,'Ghế số 89',1,2,2),(190,'Ghế số 90',1,2,2),(191,'Ghế số 91',1,2,2),(192,'Ghế số 92',1,2,2),(193,'Ghế số 93',1,2,2),(194,'Ghế số 94',1,2,2),(195,'Ghế số 95',1,2,2),(196,'Ghế số 96',1,2,2),(197,'Ghế số 97',1,2,2),(198,'Ghế số 98',1,2,2),(199,'Ghế số 99',1,2,2),(200,'Ghế số 100',1,2,2),(201,'Ghế số 1',0,1,3),(202,'Ghế số 2',1,1,3),(203,'Ghế số 3',1,1,3),(204,'Ghế số 4',1,1,3),(205,'Ghế số 5',1,1,3),(206,'Ghế số 6',1,1,3),(207,'Ghế số 7',1,1,3),(208,'Ghế số 8',1,1,3),(209,'Ghế số 9',1,1,3),(210,'Ghế số 10',1,1,3),(211,'Ghế số 11',1,1,3),(212,'Ghế số 12',1,1,3),(213,'Ghế số 13',1,1,3),(214,'Ghế số 14',1,1,3),(215,'Ghế số 15',1,1,3),(216,'Ghế số 16',1,1,3),(217,'Ghế số 17',1,1,3),(218,'Ghế số 18',1,1,3),(219,'Ghế số 19',1,1,3),(220,'Ghế số 20',1,1,3),(221,'Ghế số 21',1,1,3),(222,'Ghế số 22',1,1,3),(223,'Ghế số 23',1,1,3),(224,'Ghế số 24',1,1,3),(225,'Ghế số 25',1,1,3),(226,'Ghế số 26',1,1,3),(227,'Ghế số 27',1,1,3),(228,'Ghế số 28',1,1,3),(229,'Ghế số 29',1,1,3),(230,'Ghế số 30',1,1,3),(231,'Ghế số 31',1,1,3),(232,'Ghế số 32',1,1,3),(233,'Ghế số 33',1,1,3),(234,'Ghế số 34',1,1,3),(235,'Ghế số 35',1,1,3),(236,'Ghế số 36',1,1,3),(237,'Ghế số 37',1,1,3),(238,'Ghế số 38',1,1,3),(239,'Ghế số 39',1,1,3),(240,'Ghế số 40',1,1,3),(241,'Ghế số 41',1,2,3),(242,'Ghế số 42',1,2,3),(243,'Ghế số 43',1,2,3),(244,'Ghế số 44',1,2,3),(245,'Ghế số 45',1,2,3),(246,'Ghế số 46',1,2,3),(247,'Ghế số 47',1,2,3),(248,'Ghế số 48',1,2,3),(249,'Ghế số 49',1,2,3),(250,'Ghế số 50',1,2,3),(251,'Ghế số 51',1,2,3),(252,'Ghế số 52',1,2,3),(253,'Ghế số 53',1,2,3),(254,'Ghế số 54',1,2,3),(255,'Ghế số 55',1,2,3),(256,'Ghế số 56',1,2,3),(257,'Ghế số 57',1,2,3),(258,'Ghế số 58',1,2,3),(259,'Ghế số 59',1,2,3),(260,'Ghế số 60',1,2,3),(261,'Ghế số 61',1,2,3),(262,'Ghế số 62',1,2,3),(263,'Ghế số 63',1,2,3),(264,'Ghế số 64',1,2,3),(265,'Ghế số 65',1,2,3),(266,'Ghế số 66',1,2,3),(267,'Ghế số 67',1,2,3),(268,'Ghế số 68',1,2,3),(269,'Ghế số 69',1,2,3),(270,'Ghế số 70',1,2,3),(271,'Ghế số 71',1,2,3),(272,'Ghế số 72',1,2,3),(273,'Ghế số 73',1,2,3),(274,'Ghế số 74',1,2,3),(275,'Ghế số 75',1,2,3),(276,'Ghế số 76',1,2,3),(277,'Ghế số 77',1,2,3),(278,'Ghế số 78',1,2,3),(279,'Ghế số 79',1,2,3),(280,'Ghế số 80',1,2,3),(281,'Ghế số 81',1,2,3),(282,'Ghế số 82',1,2,3),(283,'Ghế số 83',1,2,3),(284,'Ghế số 84',1,2,3),(285,'Ghế số 85',1,2,3),(286,'Ghế số 86',1,2,3),(287,'Ghế số 87',1,2,3),(288,'Ghế số 88',1,2,3),(289,'Ghế số 89',1,2,3),(290,'Ghế số 90',1,2,3),(291,'Ghế số 91',1,2,3),(292,'Ghế số 92',1,2,3),(293,'Ghế số 93',1,2,3),(294,'Ghế số 94',0,2,3),(295,'Ghế số 95',1,2,3),(296,'Ghế số 96',1,2,3),(297,'Ghế số 97',1,2,3),(298,'Ghế số 98',1,2,3),(299,'Ghế số 99',1,2,3),(300,'Ghế số 100',0,2,3),(301,'Ghế số 1',0,1,4),(302,'Ghế số 2',0,1,4),(303,'Ghế số 3',1,1,4),(304,'Ghế số 4',1,1,4),(305,'Ghế số 5',1,1,4),(306,'Ghế số 6',1,1,4),(307,'Ghế số 7',1,1,4),(308,'Ghế số 8',1,1,4),(309,'Ghế số 9',1,1,4),(310,'Ghế số 10',0,1,4),(311,'Ghế số 11',1,1,4),(312,'Ghế số 12',1,1,4),(313,'Ghế số 13',1,1,4),(314,'Ghế số 14',1,1,4),(315,'Ghế số 15',1,1,4),(316,'Ghế số 16',1,1,4),(317,'Ghế số 17',1,1,4),(318,'Ghế số 18',1,1,4),(319,'Ghế số 19',1,1,4),(320,'Ghế số 20',1,1,4),(321,'Ghế số 21',1,1,4),(322,'Ghế số 22',1,1,4),(323,'Ghế số 23',1,1,4),(324,'Ghế số 24',1,1,4),(325,'Ghế số 25',1,1,4),(326,'Ghế số 26',1,1,4),(327,'Ghế số 27',1,1,4),(328,'Ghế số 28',1,1,4),(329,'Ghế số 29',1,1,4),(330,'Ghế số 30',1,1,4),(331,'Ghế số 31',1,1,4),(332,'Ghế số 32',1,1,4),(333,'Ghế số 33',1,1,4),(334,'Ghế số 34',1,1,4),(335,'Ghế số 35',1,1,4),(336,'Ghế số 36',1,1,4),(337,'Ghế số 37',1,1,4),(338,'Ghế số 38',1,1,4),(339,'Ghế số 39',1,1,4),(340,'Ghế số 40',1,1,4),(341,'Ghế số 41',1,2,4),(342,'Ghế số 42',1,2,4),(343,'Ghế số 43',1,2,4),(344,'Ghế số 44',1,2,4),(345,'Ghế số 45',1,2,4),(346,'Ghế số 46',1,2,4),(347,'Ghế số 47',1,2,4),(348,'Ghế số 48',1,2,4),(349,'Ghế số 49',1,2,4),(350,'Ghế số 50',1,2,4),(351,'Ghế số 51',1,2,4),(352,'Ghế số 52',1,2,4),(353,'Ghế số 53',1,2,4),(354,'Ghế số 54',1,2,4),(355,'Ghế số 55',1,2,4),(356,'Ghế số 56',1,2,4),(357,'Ghế số 57',1,2,4),(358,'Ghế số 58',1,2,4),(359,'Ghế số 59',1,2,4),(360,'Ghế số 60',1,2,4),(361,'Ghế số 61',1,2,4),(362,'Ghế số 62',1,2,4),(363,'Ghế số 63',1,2,4),(364,'Ghế số 64',1,2,4),(365,'Ghế số 65',1,2,4),(366,'Ghế số 66',1,2,4),(367,'Ghế số 67',1,2,4),(368,'Ghế số 68',1,2,4),(369,'Ghế số 69',1,2,4),(370,'Ghế số 70',1,2,4),(371,'Ghế số 71',1,2,4),(372,'Ghế số 72',1,2,4),(373,'Ghế số 73',1,2,4),(374,'Ghế số 74',1,2,4),(375,'Ghế số 75',1,2,4),(376,'Ghế số 76',1,2,4),(377,'Ghế số 77',1,2,4),(378,'Ghế số 78',1,2,4),(379,'Ghế số 79',1,2,4),(380,'Ghế số 80',1,2,4),(381,'Ghế số 81',1,2,4),(382,'Ghế số 82',1,2,4),(383,'Ghế số 83',1,2,4),(384,'Ghế số 84',1,2,4),(385,'Ghế số 85',1,2,4),(386,'Ghế số 86',1,2,4),(387,'Ghế số 87',1,2,4),(388,'Ghế số 88',1,2,4),(389,'Ghế số 89',1,2,4),(390,'Ghế số 90',1,2,4),(391,'Ghế số 91',1,2,4),(392,'Ghế số 92',1,2,4),(393,'Ghế số 93',1,2,4),(394,'Ghế số 94',1,2,4),(395,'Ghế số 95',1,2,4),(396,'Ghế số 96',1,2,4),(397,'Ghế số 97',1,2,4),(398,'Ghế số 98',1,2,4),(399,'Ghế số 99',1,2,4),(400,'Ghế số 100',1,2,4),(401,'Ghế số 1',1,1,5),(402,'Ghế số 2',1,1,5),(403,'Ghế số 3',1,1,5),(404,'Ghế số 4',1,1,5),(405,'Ghế số 5',1,1,5),(406,'Ghế số 6',1,1,5),(407,'Ghế số 7',1,1,5),(408,'Ghế số 8',1,1,5),(409,'Ghế số 9',1,1,5),(410,'Ghế số 10',1,1,5),(411,'Ghế số 11',1,1,5),(412,'Ghế số 12',1,1,5),(413,'Ghế số 13',1,1,5),(414,'Ghế số 14',1,1,5),(415,'Ghế số 15',1,1,5),(416,'Ghế số 16',1,1,5),(417,'Ghế số 17',1,1,5),(418,'Ghế số 18',1,1,5),(419,'Ghế số 19',1,1,5),(420,'Ghế số 20',1,1,5),(421,'Ghế số 21',1,1,5),(422,'Ghế số 22',1,1,5),(423,'Ghế số 23',1,1,5),(424,'Ghế số 24',1,1,5),(425,'Ghế số 25',1,1,5),(426,'Ghế số 26',1,1,5),(427,'Ghế số 27',1,1,5),(428,'Ghế số 28',1,1,5),(429,'Ghế số 29',1,1,5),(430,'Ghế số 30',1,1,5),(431,'Ghế số 31',1,1,5),(432,'Ghế số 32',1,1,5),(433,'Ghế số 33',1,1,5),(434,'Ghế số 34',1,1,5),(435,'Ghế số 35',1,1,5),(436,'Ghế số 36',1,1,5),(437,'Ghế số 37',1,1,5),(438,'Ghế số 38',1,1,5),(439,'Ghế số 39',1,1,5),(440,'Ghế số 40',1,1,5),(441,'Ghế số 41',0,2,5),(442,'Ghế số 42',0,2,5),(443,'Ghế số 43',0,2,5),(444,'Ghế số 44',0,2,5),(445,'Ghế số 45',1,2,5),(446,'Ghế số 46',1,2,5),(447,'Ghế số 47',1,2,5),(448,'Ghế số 48',1,2,5),(449,'Ghế số 49',1,2,5),(450,'Ghế số 50',1,2,5),(451,'Ghế số 51',1,2,5),(452,'Ghế số 52',1,2,5),(453,'Ghế số 53',1,2,5),(454,'Ghế số 54',1,2,5),(455,'Ghế số 55',1,2,5),(456,'Ghế số 56',1,2,5),(457,'Ghế số 57',1,2,5),(458,'Ghế số 58',1,2,5),(459,'Ghế số 59',1,2,5),(460,'Ghế số 60',1,2,5),(461,'Ghế số 61',1,2,5),(462,'Ghế số 62',1,2,5),(463,'Ghế số 63',1,2,5),(464,'Ghế số 64',1,2,5),(465,'Ghế số 65',1,2,5),(466,'Ghế số 66',1,2,5),(467,'Ghế số 67',1,2,5),(468,'Ghế số 68',1,2,5),(469,'Ghế số 69',1,2,5),(470,'Ghế số 70',1,2,5),(471,'Ghế số 71',1,2,5),(472,'Ghế số 72',1,2,5),(473,'Ghế số 73',1,2,5),(474,'Ghế số 74',1,2,5),(475,'Ghế số 75',1,2,5),(476,'Ghế số 76',1,2,5),(477,'Ghế số 77',1,2,5),(478,'Ghế số 78',1,2,5),(479,'Ghế số 79',1,2,5),(480,'Ghế số 80',1,2,5),(481,'Ghế số 81',1,2,5),(482,'Ghế số 82',1,2,5),(483,'Ghế số 83',1,2,5),(484,'Ghế số 84',1,2,5),(485,'Ghế số 85',1,2,5),(486,'Ghế số 86',1,2,5),(487,'Ghế số 87',1,2,5),(488,'Ghế số 88',1,2,5),(489,'Ghế số 89',1,2,5),(490,'Ghế số 90',1,2,5),(491,'Ghế số 91',1,2,5),(492,'Ghế số 92',1,2,5),(493,'Ghế số 93',1,2,5),(494,'Ghế số 94',1,2,5),(495,'Ghế số 95',1,2,5),(496,'Ghế số 96',1,2,5),(497,'Ghế số 97',1,2,5),(498,'Ghế số 98',1,2,5),(499,'Ghế số 99',1,2,5),(500,'Ghế số 100',1,2,5),(501,'Ghế số 1',1,1,6),(502,'Ghế số 2',1,1,6),(503,'Ghế số 3',1,1,6),(504,'Ghế số 4',1,1,6),(505,'Ghế số 5',1,1,6),(506,'Ghế số 6',1,1,6),(507,'Ghế số 7',1,1,6),(508,'Ghế số 8',1,1,6),(509,'Ghế số 9',0,1,6),(510,'Ghế số 10',0,1,6),(511,'Ghế số 11',0,1,6),(512,'Ghế số 12',1,1,6),(513,'Ghế số 13',1,1,6),(514,'Ghế số 14',1,1,6),(515,'Ghế số 15',1,1,6),(516,'Ghế số 16',1,1,6),(517,'Ghế số 17',1,1,6),(518,'Ghế số 18',1,1,6),(519,'Ghế số 19',1,1,6),(520,'Ghế số 20',1,1,6),(521,'Ghế số 21',1,1,6),(522,'Ghế số 22',0,1,6),(523,'Ghế số 23',0,1,6),(524,'Ghế số 24',1,1,6),(525,'Ghế số 25',1,1,6),(526,'Ghế số 26',1,1,6),(527,'Ghế số 27',1,1,6),(528,'Ghế số 28',1,1,6),(529,'Ghế số 29',1,1,6),(530,'Ghế số 30',1,1,6),(531,'Ghế số 31',1,1,6),(532,'Ghế số 32',1,1,6),(533,'Ghế số 33',1,1,6),(534,'Ghế số 34',1,1,6),(535,'Ghế số 35',1,1,6),(536,'Ghế số 36',1,1,6),(537,'Ghế số 37',1,1,6),(538,'Ghế số 38',1,1,6),(539,'Ghế số 39',1,1,6),(540,'Ghế số 40',1,1,6),(541,'Ghế số 41',1,2,6),(542,'Ghế số 42',1,2,6),(543,'Ghế số 43',1,2,6),(544,'Ghế số 44',1,2,6),(545,'Ghế số 45',1,2,6),(546,'Ghế số 46',1,2,6),(547,'Ghế số 47',1,2,6),(548,'Ghế số 48',1,2,6),(549,'Ghế số 49',1,2,6),(550,'Ghế số 50',1,2,6),(551,'Ghế số 51',1,2,6),(552,'Ghế số 52',1,2,6),(553,'Ghế số 53',1,2,6),(554,'Ghế số 54',1,2,6),(555,'Ghế số 55',1,2,6),(556,'Ghế số 56',1,2,6),(557,'Ghế số 57',1,2,6),(558,'Ghế số 58',1,2,6),(559,'Ghế số 59',1,2,6),(560,'Ghế số 60',1,2,6),(561,'Ghế số 61',1,2,6),(562,'Ghế số 62',1,2,6),(563,'Ghế số 63',1,2,6),(564,'Ghế số 64',1,2,6),(565,'Ghế số 65',1,2,6),(566,'Ghế số 66',1,2,6),(567,'Ghế số 67',1,2,6),(568,'Ghế số 68',1,2,6),(569,'Ghế số 69',1,2,6),(570,'Ghế số 70',1,2,6),(571,'Ghế số 71',1,2,6),(572,'Ghế số 72',1,2,6),(573,'Ghế số 73',1,2,6),(574,'Ghế số 74',1,2,6),(575,'Ghế số 75',1,2,6),(576,'Ghế số 76',1,2,6),(577,'Ghế số 77',1,2,6),(578,'Ghế số 78',1,2,6),(579,'Ghế số 79',1,2,6),(580,'Ghế số 80',1,2,6),(581,'Ghế số 81',1,2,6),(582,'Ghế số 82',1,2,6),(583,'Ghế số 83',1,2,6),(584,'Ghế số 84',1,2,6),(585,'Ghế số 85',1,2,6),(586,'Ghế số 86',1,2,6),(587,'Ghế số 87',1,2,6),(588,'Ghế số 88',1,2,6),(589,'Ghế số 89',1,2,6),(590,'Ghế số 90',1,2,6),(591,'Ghế số 91',1,2,6),(592,'Ghế số 92',1,2,6),(593,'Ghế số 93',1,2,6),(594,'Ghế số 94',1,2,6),(595,'Ghế số 95',1,2,6),(596,'Ghế số 96',1,2,6),(597,'Ghế số 97',1,2,6),(598,'Ghế số 98',1,2,6),(599,'Ghế số 99',1,2,6),(600,'Ghế số 100',1,2,6);
/*!40000 ALTER TABLE `ghe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoadon`
--

DROP TABLE IF EXISTS `hoadon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hoadon` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngay_xuat_hoa_don` datetime NOT NULL,
  `id_nhan_vien` int NOT NULL,
  `id_khach_hang` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_nhan_vien` (`id_nhan_vien`),
  KEY `id_khach_hang` (`id_khach_hang`),
  CONSTRAINT `hoadon_ibfk_1` FOREIGN KEY (`id_nhan_vien`) REFERENCES `nhanvien` (`id`),
  CONSTRAINT `hoadon_ibfk_2` FOREIGN KEY (`id_khach_hang`) REFERENCES `khachhang` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoadon`
--

LOCK TABLES `hoadon` WRITE;
/*!40000 ALTER TABLE `hoadon` DISABLE KEYS */;
INSERT INTO `hoadon` VALUES ('H23 - Trọng','2020-12-13 13:48:51',1,9),('H24 - Trọng','2020-12-13 13:48:51',1,9),('H25 - Trọng','2020-12-13 13:48:51',1,9),('H26 - Trọng','2020-12-13 13:48:51',1,9),('H27 - Huy','2020-12-13 20:20:34',1,10),('H28 - Huy','2020-12-13 20:20:34',1,10),('H31 - Tư','2020-12-13 20:52:44',1,8),('H32 - Tư','2020-12-13 20:52:44',1,8);
/*!40000 ALTER TABLE `hoadon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khachhang`
--

DROP TABLE IF EXISTS `khachhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khachhang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gioi_tinh` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngay_sinh` date NOT NULL,
  `Cmnd` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dia_chi` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sdt` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Cmnd` (`Cmnd`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khachhang`
--

LOCK TABLES `khachhang` WRITE;
/*!40000 ALTER TABLE `khachhang` DISABLE KEYS */;
INSERT INTO `khachhang` VALUES (8,'Tư','Nam','2000-11-13','079200008902','371 Nguyễn Kiệm, Q. Gò Vấp','(+84) 768107704','hoangnhoc@gmail.com'),(9,'Trọng','Nam','2000-07-26','077200009902','371 Nguyễn Kiệm, Q. Gò Vấp','(+84) 935492342','dotrong@gmail.com'),(10,'Huy','Nam','2000-02-15','079200008113','371 Nguyễn Kiệm, Q. Gò Vấp','(+84) 768107704','huybeta25@gmail.com'),(11,'Thành','Nam','2000-10-25','079200003456','371 Nguyễn Kiệm, Q. Gò Vấp','(+84) 768107704','dhthanh@ou.edu.vn'),(12,'Phúc','Nam','2020-12-17','079200007652','371 Nguyễn Kiệm, Q. Gò Vấp','(+84) 768107704','1851050010buu@ou.edu.vn'),(13,'Phúc','Nam','2000-04-14','079200008312','371 Nguyễn Kiệm, Q. Gò Vấp','(+84) 768107704','1851050115phuc@ou.edu.vn'),(14,'Dúi','Nam','2020-12-16','079211118902','371 Nguyễn Kiệm, Q. Gò Vấp','(+84) 768107704','thaidui@gmail.com'),(15,'Bành','Nam','2000-07-06','085100008902','371 Nguyễn Kiệm, Q. Gò Vấp','(+84) 768107704','cuoikhakha@gmail.com'),(17,'Trí','Nam','2000-03-13','079200009908','371 Nguyễn Kiệm, Q. Gò Vấp','(+84) 768107704','trilenguyenphuc@gmail.com'),(18,'Phước','Nam','2000-04-14','081200008902','371 Nguyễn Kiệm, Q. Gò Vấp','(+84) 768107704','phuoclehuu@gmail.com');
/*!40000 ALTER TABLE `khachhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loaighe`
--

DROP TABLE IF EXISTS `loaighe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loaighe` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `don_gia` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loaighe`
--

LOCK TABLES `loaighe` WRITE;
/*!40000 ALTER TABLE `loaighe` DISABLE KEYS */;
INSERT INTO `loaighe` VALUES (1,'Ghế hạng 1',1000),(2,'Ghế hạng 2',500);
/*!40000 ALTER TABLE `loaighe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maybay`
--

DROP TABLE IF EXISTS `maybay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maybay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ghe_hang_1` int NOT NULL,
  `ghe_hang_2` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maybay`
--

LOCK TABLES `maybay` WRITE;
/*!40000 ALTER TABLE `maybay` DISABLE KEYS */;
INSERT INTO `maybay` VALUES (1,'AK47 GDucky',40,60),(2,'SNG44 OCOC',40,60),(3,'HNA33 TIGER',40,60),(4,'M4A1 KHAKHA',40,60),(5,'16TYPH GAREN',40,60),(6,'JHIN 3ZFLY',40,60);
/*!40000 ALTER TABLE `maybay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nhanvien`
--

DROP TABLE IF EXISTS `nhanvien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nhanvien` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gioi_tinh` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngay_sinh` date NOT NULL,
  `dia_chi` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `que_quan` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dien_thoai` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role` (`role`),
  CONSTRAINT `nhanvien_ibfk_1` FOREIGN KEY (`role`) REFERENCES `userrole` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhanvien`
--

LOCK TABLES `nhanvien` WRITE;
/*!40000 ALTER TABLE `nhanvien` DISABLE KEYS */;
INSERT INTO `nhanvien` VALUES (1,'Đặng Hoàng Bửu','Nam','2000-02-04','371 Nguyễn Kiệm','Tiền Giang','0768107704','images/avatar1.jpg',1);
/*!40000 ALTER TABLE `nhanvien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phieudatcho`
--

DROP TABLE IF EXISTS `phieudatcho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phieudatcho` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ngay_xuat_phieu` date NOT NULL,
  `id_khach_hang` int NOT NULL,
  `confirm` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_khach_hang` (`id_khach_hang`),
  CONSTRAINT `phieudatcho_ibfk_1` FOREIGN KEY (`id_khach_hang`) REFERENCES `khachhang` (`id`),
  CONSTRAINT `phieudatcho_chk_1` CHECK ((`confirm` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phieudatcho`
--

LOCK TABLES `phieudatcho` WRITE;
/*!40000 ALTER TABLE `phieudatcho` DISABLE KEYS */;
INSERT INTO `phieudatcho` VALUES (29,'2020-12-13',11,1),(30,'2020-12-13',11,1),(34,'2020-12-15',13,1),(36,'2020-12-15',14,0),(37,'2020-12-15',14,0),(38,'2020-12-15',15,0),(39,'2020-12-15',17,0),(40,'2020-12-15',17,0),(41,'2020-12-15',17,0),(42,'2020-12-15',17,0),(43,'2020-12-15',17,0),(44,'2020-12-15',17,0),(45,'2020-12-15',17,0),(46,'2020-12-15',18,0);
/*!40000 ALTER TABLE `phieudatcho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sanbay`
--

DROP TABLE IF EXISTS `sanbay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sanbay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vi_tri` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanbay`
--

LOCK TABLES `sanbay` WRITE;
/*!40000 ALTER TABLE `sanbay` DISABLE KEYS */;
INSERT INTO `sanbay` VALUES (1,'Tân Sơn Nhất','Hồ Chí Minh'),(2,'Nội Bài','Hà Nội'),(3,'Vinh','Nghệ An'),(4,'Phú Quốc','Kiên Giang'),(5,'Đà Nẵng','Đà Nẵng'),(6,'Cam Ranh','Khánh Hòa'),(7,'Cà Mau','Cà Mau'),(8,'Cần Thơ','Cần Thơ');
/*!40000 ALTER TABLE `sanbay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sanbaytrunggian`
--

DROP TABLE IF EXISTS `sanbaytrunggian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sanbaytrunggian` (
  `id_san_bay` int NOT NULL,
  `id_duong_bay` int NOT NULL,
  `thoi_gian_dung` time NOT NULL,
  PRIMARY KEY (`id_san_bay`,`id_duong_bay`),
  KEY `id_duong_bay` (`id_duong_bay`),
  CONSTRAINT `sanbaytrunggian_ibfk_1` FOREIGN KEY (`id_san_bay`) REFERENCES `sanbay` (`id`),
  CONSTRAINT `sanbaytrunggian_ibfk_2` FOREIGN KEY (`id_duong_bay`) REFERENCES `duongbay` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanbaytrunggian`
--

LOCK TABLES `sanbaytrunggian` WRITE;
/*!40000 ALTER TABLE `sanbaytrunggian` DISABLE KEYS */;
/*!40000 ALTER TABLE `sanbaytrunggian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userrole`
--

DROP TABLE IF EXISTS `userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userrole` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userrole`
--

LOCK TABLES `userrole` WRITE;
/*!40000 ALTER TABLE `userrole` DISABLE KEYS */;
INSERT INTO `userrole` VALUES (1,'Quản trị');
/*!40000 ALTER TABLE `userrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ve`
--

DROP TABLE IF EXISTS `ve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ve` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngay_xuat_ve` datetime NOT NULL,
  `id_chuyen_bay` int NOT NULL,
  `id_ghe` int NOT NULL,
  `id_hoa_don` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_chuyen_bay` (`id_chuyen_bay`),
  KEY `id_ghe` (`id_ghe`),
  KEY `id_hoa_don` (`id_hoa_don`),
  CONSTRAINT `ve_ibfk_1` FOREIGN KEY (`id_chuyen_bay`) REFERENCES `chuyenbay` (`id_chuyen_bay`),
  CONSTRAINT `ve_ibfk_2` FOREIGN KEY (`id_ghe`) REFERENCES `ghe` (`id`),
  CONSTRAINT `ve_ibfk_3` FOREIGN KEY (`id_hoa_don`) REFERENCES `hoadon` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ve`
--

LOCK TABLES `ve` WRITE;
/*!40000 ALTER TABLE `ve` DISABLE KEYS */;
INSERT INTO `ve` VALUES ('V23 - Trọng','2020-12-13 13:48:51',5,441,'H23 - Trọng'),('V24 - Trọng','2020-12-13 13:48:51',5,442,'H24 - Trọng'),('V25 - Trọng','2020-12-13 13:48:51',5,443,'H25 - Trọng'),('V26 - Trọng','2020-12-13 13:48:51',5,444,'H26 - Trọng'),('V27 - Huy','2020-12-13 20:20:34',6,509,'H27 - Huy'),('V28 - Huy','2020-12-13 20:20:34',6,510,'H28 - Huy'),('V31 - Tư','2020-12-13 20:52:44',2,149,'H31 - Tư'),('V32 - Tư','2020-12-13 20:52:44',2,150,'H32 - Tư');
/*!40000 ALTER TABLE `ve` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-15 12:52:56
