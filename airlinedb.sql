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
INSERT INTO `account` VALUES (1,'hoangbuu2000','e10adc3949ba59abbe56e057f20f883e',1),(2,'duongtu2000','e10adc3949ba59abbe56e057f20f883e',1);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chuyenbay`
--

LOCK TABLES `chuyenbay` WRITE;
/*!40000 ALTER TABLE `chuyenbay` DISABLE KEYS */;
INSERT INTO `chuyenbay` VALUES (1,2,1,'2020-12-11 20:00:00','03:00:00'),(2,3,2,'2020-12-10 10:00:00','03:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duongbay`
--

LOCK TABLES `duongbay` WRITE;
/*!40000 ALTER TABLE `duongbay` DISABLE KEYS */;
INSERT INTO `duongbay` VALUES (1,1,2,1616),(2,1,3,1131);
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
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ghe`
--

LOCK TABLES `ghe` WRITE;
/*!40000 ALTER TABLE `ghe` DISABLE KEYS */;
INSERT INTO `ghe` VALUES (2,'Ghế số 1',0,1,2),(3,'Ghế số 2',0,1,2),(4,'Ghế số 3',0,1,2),(5,'Ghế số 4',0,1,2),(6,'Ghế số 5',1,1,2),(7,'Ghế số 6',1,1,2),(8,'Ghế số 7',1,1,2),(9,'Ghế số 8',1,1,2),(10,'Ghế số 9',1,1,2),(11,'Ghế số 10',1,1,2),(12,'Ghế số 11',1,1,2),(13,'Ghế số 12',1,1,2),(14,'Ghế số 13',1,1,2),(15,'Ghế số 14',1,1,2),(16,'Ghế số 15',1,1,2),(17,'Ghế số 16',1,1,2),(18,'Ghế số 17',1,1,2),(19,'Ghế số 18',1,1,2),(20,'Ghế số 19',1,1,2),(21,'Ghế số 20',1,1,2),(22,'Ghế số 21',1,1,2),(23,'Ghế số 22',1,1,2),(24,'Ghế số 23',1,1,2),(25,'Ghế số 24',1,1,2),(26,'Ghế số 25',1,1,2),(27,'Ghế số 26',1,1,2),(28,'Ghế số 27',1,1,2),(29,'Ghế số 28',1,1,2),(30,'Ghế số 29',1,1,2),(31,'Ghế số 30',1,1,2),(32,'Ghế số 31',1,2,2),(33,'Ghế số 32',0,2,2),(34,'Ghế số 33',1,2,2),(35,'Ghế số 34',1,2,2),(36,'Ghế số 35',1,2,2),(37,'Ghế số 36',1,2,2),(38,'Ghế số 37',1,2,2),(39,'Ghế số 38',1,2,2),(40,'Ghế số 39',1,2,2),(41,'Ghế số 40',1,2,2),(42,'Ghế số 41',1,2,2),(43,'Ghế số 42',1,2,2),(44,'Ghế số 43',1,2,2),(45,'Ghế số 44',1,2,2),(46,'Ghế số 45',1,2,2),(47,'Ghế số 46',1,2,2),(48,'Ghế số 47',1,2,2),(49,'Ghế số 48',1,2,2),(50,'Ghế số 49',1,2,2),(51,'Ghế số 50',1,2,2),(52,'Ghế số 51',1,2,2),(53,'Ghế số 52',1,2,2),(54,'Ghế số 53',1,2,2),(55,'Ghế số 54',1,2,2),(56,'Ghế số 55',1,2,2),(57,'Ghế số 56',1,2,2),(58,'Ghế số 57',1,2,2),(59,'Ghế số 58',1,2,2),(60,'Ghế số 59',1,2,2),(61,'Ghế số 60',1,2,2),(62,'Ghế số 61',1,2,2),(63,'Ghế số 62',1,2,2),(64,'Ghế số 63',1,2,2),(65,'Ghế số 64',1,2,2),(66,'Ghế số 65',1,2,2),(67,'Ghế số 66',1,2,2),(68,'Ghế số 67',1,2,2),(69,'Ghế số 68',1,2,2),(70,'Ghế số 69',1,2,2),(71,'Ghế số 70',1,2,2),(72,'Ghế số 71',1,2,2),(73,'Ghế số 72',1,2,2),(74,'Ghế số 73',1,2,2),(75,'Ghế số 74',1,2,2),(76,'Ghế số 75',1,2,2),(77,'Ghế số 76',1,2,2),(78,'Ghế số 77',1,2,2),(79,'Ghế số 78',1,2,2),(80,'Ghế số 79',0,2,2),(81,'Ghế số 80',1,2,2),(82,'Ghế số 1',0,1,3),(83,'Ghế số 2',0,1,3),(84,'Ghế số 3',1,1,3),(85,'Ghế số 4',1,1,3),(86,'Ghế số 5',1,1,3),(87,'Ghế số 6',0,1,3),(88,'Ghế số 7',1,1,3),(89,'Ghế số 8',1,1,3),(90,'Ghế số 9',1,1,3),(91,'Ghế số 10',1,1,3),(92,'Ghế số 11',1,1,3),(93,'Ghế số 12',1,1,3),(94,'Ghế số 13',1,1,3),(95,'Ghế số 14',1,1,3),(96,'Ghế số 15',1,1,3),(97,'Ghế số 16',1,1,3),(98,'Ghế số 17',1,1,3),(99,'Ghế số 18',0,1,3),(100,'Ghế số 19',1,1,3),(101,'Ghế số 20',1,1,3),(102,'Ghế số 21',1,1,3),(103,'Ghế số 22',1,1,3),(104,'Ghế số 23',1,1,3),(105,'Ghế số 24',1,1,3),(106,'Ghế số 25',1,1,3),(107,'Ghế số 26',1,1,3),(108,'Ghế số 27',1,1,3),(109,'Ghế số 28',1,1,3),(110,'Ghế số 29',1,1,3),(111,'Ghế số 30',1,1,3),(112,'Ghế số 31',1,1,3),(113,'Ghế số 32',1,1,3),(114,'Ghế số 33',1,1,3),(115,'Ghế số 34',1,1,3),(116,'Ghế số 35',1,1,3),(117,'Ghế số 36',1,1,3),(118,'Ghế số 37',1,1,3),(119,'Ghế số 38',1,1,3),(120,'Ghế số 39',1,1,3),(121,'Ghế số 40',1,1,3),(122,'Ghế số 41',1,2,3),(123,'Ghế số 42',1,2,3),(124,'Ghế số 43',1,2,3),(125,'Ghế số 44',1,2,3),(126,'Ghế số 45',1,2,3),(127,'Ghế số 46',1,2,3),(128,'Ghế số 47',1,2,3),(129,'Ghế số 48',1,2,3),(130,'Ghế số 49',1,2,3),(131,'Ghế số 50',1,2,3),(132,'Ghế số 51',1,2,3),(133,'Ghế số 52',1,2,3),(134,'Ghế số 53',1,2,3),(135,'Ghế số 54',1,2,3),(136,'Ghế số 55',1,2,3),(137,'Ghế số 56',1,2,3),(138,'Ghế số 57',1,2,3),(139,'Ghế số 58',0,2,3),(140,'Ghế số 59',1,2,3),(141,'Ghế số 60',1,2,3),(142,'Ghế số 61',1,2,3),(143,'Ghế số 62',1,2,3),(144,'Ghế số 63',1,2,3),(145,'Ghế số 64',1,2,3),(146,'Ghế số 65',1,2,3),(147,'Ghế số 66',1,2,3),(148,'Ghế số 67',1,2,3),(149,'Ghế số 68',1,2,3),(150,'Ghế số 69',1,2,3),(151,'Ghế số 70',0,2,3),(152,'Ghế số 71',0,2,3),(153,'Ghế số 72',1,2,3),(154,'Ghế số 73',1,2,3),(155,'Ghế số 74',1,2,3),(156,'Ghế số 75',1,2,3),(157,'Ghế số 76',1,2,3),(158,'Ghế số 77',1,2,3),(159,'Ghế số 78',1,2,3),(160,'Ghế số 79',1,2,3),(161,'Ghế số 80',1,2,3),(162,'Ghế số 81',1,2,3),(163,'Ghế số 82',1,2,3),(164,'Ghế số 83',1,2,3),(165,'Ghế số 84',1,2,3),(166,'Ghế số 85',1,2,3),(167,'Ghế số 86',1,2,3),(168,'Ghế số 87',1,2,3),(169,'Ghế số 88',1,2,3),(170,'Ghế số 89',1,2,3),(171,'Ghế số 90',1,2,3),(172,'Ghế số 91',1,2,3),(173,'Ghế số 92',1,2,3),(174,'Ghế số 93',1,2,3),(175,'Ghế số 94',1,2,3),(176,'Ghế số 95',0,2,3),(177,'Ghế số 96',1,2,3),(178,'Ghế số 97',1,2,3),(179,'Ghế số 98',1,2,3),(180,'Ghế số 99',1,2,3),(181,'Ghế số 100',1,2,3);
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
INSERT INTO `hoadon` VALUES ('2020-12-09-8902','2020-12-09 14:26:39',1,32),('2020-12-09-8905','2020-12-09 14:26:39',1,33);
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khachhang`
--

LOCK TABLES `khachhang` WRITE;
/*!40000 ALTER TABLE `khachhang` DISABLE KEYS */;
INSERT INTO `khachhang` VALUES (32,'Nhóc Hi','Nam','2020-12-12','079200008902','371 Nguyễn Kiệm, Q. Gò Vấp','0768107704','hoangnhoc@gmail.com'),(33,'Khùng Lùm','Nam','2020-12-13','079200008905','371 Nguyễn Kiệm, Q. Gò Vấp','0768107703','huybelta1234@gmail.com');
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
INSERT INTO `loaighe` VALUES (1,'Ghế hạng 1',10000),(2,'Ghế hạng 2',5000);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maybay`
--

LOCK TABLES `maybay` WRITE;
/*!40000 ALTER TABLE `maybay` DISABLE KEYS */;
INSERT INTO `maybay` VALUES (2,'AK47 GDucky',30,50),(3,'SNG44 OCOC',40,60);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhanvien`
--

LOCK TABLES `nhanvien` WRITE;
/*!40000 ALTER TABLE `nhanvien` DISABLE KEYS */;
INSERT INTO `nhanvien` VALUES (1,'Đặng Hoàng Bửu','Nam','2000-02-04','371 Nguyễn Kiệm','Tiền Giang','0768107704','images/avatar1.jpg',1),(2,'Dương Văn Tư','Nam','2000-11-16','371 Nguyễn Kiệm, Q. Gò Vấp','Tây Ninh','0935492342','images/avatar2.jpg',2);
/*!40000 ALTER TABLE `nhanvien` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanbay`
--

LOCK TABLES `sanbay` WRITE;
/*!40000 ALTER TABLE `sanbay` DISABLE KEYS */;
INSERT INTO `sanbay` VALUES (1,'Tân Sơn Nhất','Hồ Chí Minh'),(2,'Nội Bài','Hà Nội'),(3,'Phú Quốc','Kiên Giang'),(4,'Cam Ranh','Khánh Hòa'),(5,'Cà Mau','Cà Mau'),(6,'Côn Đảo','Bà Rịa - Vũng Tàu'),(7,'Vinh','Nghệ An'),(8,'Rạch Giá','Kiên Giang'),(9,'Rạch Giá','Kiên Giang'),(10,'Đà Nẵng','Đà Nẵng');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userrole`
--

LOCK TABLES `userrole` WRITE;
/*!40000 ALTER TABLE `userrole` DISABLE KEYS */;
INSERT INTO `userrole` VALUES (1,'Quản trị'),(2,'Nhân viên');
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
INSERT INTO `ve` VALUES ('Hồ Chí Minh - Hà Nội[Ghế số 79]','2020-12-09 14:26:39',1,80,'2020-12-09-8905'),('Hồ Chí Minh - Kiên Giang[Ghế số 18]','2020-12-09 14:26:39',2,99,'2020-12-09-8902'),('Hồ Chí Minh - Kiên Giang[Ghế số 70]','2020-12-09 14:26:39',2,151,'2020-12-09-8902'),('Hồ Chí Minh - Kiên Giang[Ghế số 71]','2020-12-09 14:26:39',2,152,'2020-12-09-8902');
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

-- Dump completed on 2020-12-09 19:31:50
