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
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chuyenbay`
--

LOCK TABLES `chuyenbay` WRITE;
/*!40000 ALTER TABLE `chuyenbay` DISABLE KEYS */;
INSERT INTO `chuyenbay` VALUES (2,1,1,'2020-12-09 10:00:00','03:30:00'),(7,2,2,'2020-12-08 16:00:00','00:30:00'),(8,4,4,'2020-12-11 19:00:00','03:00:00'),(9,5,6,'2020-12-15 21:30:00','03:00:00');
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
INSERT INTO `duongbay` VALUES (1,1,2,1616),(2,1,4,80),(3,1,8,1424),(4,2,20,1600),(6,14,22,1200);
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
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `available` tinyint(1) NOT NULL,
  `id_loai_ghe` int NOT NULL,
  `id_may_bay` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_loai_ghe` (`id_loai_ghe`),
  KEY `id_may_bay` (`id_may_bay`),
  CONSTRAINT `ghe_ibfk_1` FOREIGN KEY (`id_loai_ghe`) REFERENCES `loaighe` (`id`),
  CONSTRAINT `ghe_ibfk_2` FOREIGN KEY (`id_may_bay`) REFERENCES `maybay` (`id`),
  CONSTRAINT `ghe_chk_1` CHECK ((`available` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ghe`
--

LOCK TABLES `ghe` WRITE;
/*!40000 ALTER TABLE `ghe` DISABLE KEYS */;
INSERT INTO `ghe` VALUES (1,'Ghế số 1',1,1,1),(2,'Ghế số 2',1,1,1),(3,'Ghế số 3',1,1,1),(4,'Ghế số 4',1,1,1),(5,'Ghế số 5',1,1,1),(6,'Ghế số 6',1,1,1),(7,'Ghế số 7',1,1,1),(8,'Ghế số 8',1,1,1),(9,'Ghế số 9',1,1,1),(10,'Ghế số 10',1,1,1),(11,'Ghế số 11',1,1,1),(12,'Ghế số 12',1,1,1),(13,'Ghế số 13',1,1,1),(14,'Ghế số 14',1,1,1),(15,'Ghế số 15',1,1,1),(16,'Ghế số 16',1,1,1),(17,'Ghế số 17',1,1,1),(18,'Ghế số 18',1,1,1),(19,'Ghế số 19',1,1,1),(20,'Ghế số 20',1,1,1),(21,'Ghế số 21',1,2,1),(22,'Ghế số 22',1,2,1),(23,'Ghế số 23',1,2,1),(24,'Ghế số 24',1,2,1),(25,'Ghế số 25',1,2,1),(26,'Ghế số 26',1,2,1),(27,'Ghế số 27',1,2,1),(28,'Ghế số 28',1,2,1),(29,'Ghế số 29',1,2,1),(30,'Ghế số 30',1,2,1),(31,'Ghế số 31',1,2,1),(32,'Ghế số 32',1,2,1),(33,'Ghế số 33',1,2,1),(34,'Ghế số 34',1,2,1),(35,'Ghế số 35',1,2,1),(36,'Ghế số 36',1,2,1),(37,'Ghế số 37',1,2,1),(38,'Ghế số 38',1,2,1),(39,'Ghế số 39',1,2,1),(40,'Ghế số 40',1,2,1),(45,'Ghế số 1',1,1,2),(46,'Ghế số 2',1,1,2),(47,'Ghế số 3',1,1,2),(48,'Ghế số 4',1,1,2),(49,'Ghế số 5',1,1,2),(50,'Ghế số 6',1,1,2),(51,'Ghế số 7',1,1,2),(52,'Ghế số 8',1,1,2),(53,'Ghế số 9',1,1,2),(54,'Ghế số 10',1,1,2),(55,'Ghế số 11',1,1,2),(56,'Ghế số 12',1,1,2),(57,'Ghế số 13',1,2,2),(58,'Ghế số 14',1,2,2),(59,'Ghế số 15',1,2,2),(60,'Ghế số 16',1,2,2),(61,'Ghế số 17',1,2,2),(62,'Ghế số 18',1,2,2),(63,'Ghế số 19',1,2,2),(64,'Ghế số 20',1,2,2),(65,'Ghế số 21',1,2,2),(66,'Ghế số 22',1,2,2),(67,'Ghế số 23',1,2,2),(68,'Ghế số 24',1,2,2),(69,'Ghế số 25',1,2,2),(70,'Ghế số 26',1,2,2),(71,'Ghế số 27',1,2,2),(72,'Ghế số 28',1,2,2),(73,'Ghế số 29',1,2,2),(74,'Ghế số 30',1,2,2),(75,'Ghế số 31',1,2,2),(76,'Ghế số 32',1,2,2),(89,'Ghế số 1',1,1,4),(90,'Ghế số 2',1,1,4),(91,'Ghế số 3',1,1,4),(92,'Ghế số 4',1,1,4),(93,'Ghế số 5',1,1,4),(94,'Ghế số 6',1,1,4),(95,'Ghế số 7',1,1,4),(96,'Ghế số 8',1,1,4),(97,'Ghế số 9',1,1,4),(98,'Ghế số 10',1,1,4),(99,'Ghế số 11',1,2,4),(100,'Ghế số 12',1,2,4),(101,'Ghế số 13',1,2,4),(102,'Ghế số 14',1,2,4),(103,'Ghế số 15',1,2,4),(104,'Ghế số 16',1,2,4),(105,'Ghế số 17',1,2,4),(106,'Ghế số 18',1,2,4),(107,'Ghế số 19',1,2,4),(108,'Ghế số 20',1,2,4),(109,'Ghế số 21',1,2,4),(110,'Ghế số 22',1,2,4),(111,'Ghế số 23',1,2,4),(112,'Ghế số 24',1,2,4),(113,'Ghế số 25',1,2,4),(114,'Ghế số 26',1,2,4),(115,'Ghế số 27',1,2,4),(116,'Ghế số 28',1,2,4),(117,'Ghế số 29',1,2,4),(118,'Ghế số 30',1,2,4),(119,'Ghế số 1',0,1,5),(120,'Ghế số 2',0,1,5),(121,'Ghế số 3',0,1,5),(122,'Ghế số 4',0,1,5),(123,'Ghế số 5',1,1,5),(124,'Ghế số 6',1,1,5),(125,'Ghế số 7',1,1,5),(126,'Ghế số 8',1,1,5),(127,'Ghế số 9',1,1,5),(128,'Ghế số 10',1,1,5),(129,'Ghế số 11',1,1,5),(130,'Ghế số 12',1,1,5),(131,'Ghế số 13',1,1,5),(132,'Ghế số 14',1,1,5),(133,'Ghế số 15',1,1,5),(134,'Ghế số 16',1,1,5),(135,'Ghế số 17',1,1,5),(136,'Ghế số 18',1,1,5),(137,'Ghế số 19',1,1,5),(138,'Ghế số 20',1,1,5),(139,'Ghế số 21',1,2,5),(140,'Ghế số 22',1,2,5),(141,'Ghế số 23',1,2,5),(142,'Ghế số 24',1,2,5),(143,'Ghế số 25',1,2,5),(144,'Ghế số 26',1,2,5),(145,'Ghế số 27',1,2,5),(146,'Ghế số 28',1,2,5),(147,'Ghế số 29',1,2,5),(148,'Ghế số 30',1,2,5),(149,'Ghế số 31',1,2,5),(150,'Ghế số 32',1,2,5),(151,'Ghế số 33',1,2,5),(152,'Ghế số 34',1,2,5),(153,'Ghế số 35',1,2,5),(154,'Ghế số 36',1,2,5),(155,'Ghế số 37',1,2,5),(156,'Ghế số 38',1,2,5),(157,'Ghế số 39',1,2,5),(158,'Ghế số 40',1,2,5),(159,'Ghế số 41',1,2,5),(160,'Ghế số 42',1,2,5),(161,'Ghế số 43',1,2,5),(162,'Ghế số 44',1,2,5),(163,'Ghế số 45',1,2,5),(164,'Ghế số 46',1,2,5),(165,'Ghế số 47',1,2,5),(166,'Ghế số 48',1,2,5),(167,'Ghế số 49',1,2,5),(168,'Ghế số 50',1,2,5),(169,'Ghế số 51',1,2,5),(170,'Ghế số 52',1,2,5),(171,'Ghế số 53',1,2,5),(172,'Ghế số 54',1,2,5),(173,'Ghế số 55',1,2,5),(174,'Ghế số 56',1,2,5),(175,'Ghế số 57',1,2,5),(176,'Ghế số 58',1,2,5),(177,'Ghế số 59',1,2,5),(178,'Ghế số 60',1,2,5);
/*!40000 ALTER TABLE `ghe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khachhang`
--

DROP TABLE IF EXISTS `khachhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khachhang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gioi_tinh` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngay_sinh` date NOT NULL,
  `Cmnd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dia_chi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sdt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Cmnd` (`Cmnd`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khachhang`
--

LOCK TABLES `khachhang` WRITE;
/*!40000 ALTER TABLE `khachhang` DISABLE KEYS */;
INSERT INTO `khachhang` VALUES (1,'Trần Phấn Huy','Nam','2000-02-04','123456789101','371 Nguyễn Kiệm, Q. Gò Vấp','0768107705','huybelta1234@gmail.com'),(2,'Nguyễn Đỗ Trọng','Nam','2000-05-05','079211115643','371 Nguyễn Kiệm, Q. Gò Vấp','0303033034','trongdo11@gmail.com');
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
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ghe_hang_1` int NOT NULL,
  `ghe_hang_2` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maybay`
--

LOCK TABLES `maybay` WRITE;
/*!40000 ALTER TABLE `maybay` DISABLE KEYS */;
INSERT INTO `maybay` VALUES (1,'AK47 GDucky',20,20),(2,'ZUKABU YOYO',12,20),(4,'HNA33 TIGER',10,20),(5,'SGN44 OCOC',20,40);
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
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gioi_tinh` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngay_sinh` date NOT NULL,
  `dia_chi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `que_quan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dien_thoai` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
INSERT INTO `nhanvien` VALUES (1,'Đặng Hoàng Bửu','Nam','2000-02-04','371 Nguyễn Kiệm','Tiền Giang','0768107704','images/avatar1.jpg',1),(2,'Dương Văn Tư','Nam','2000-12-13','371 Nguyễn Kiệm, Q. Gò Vấp','Tây Ninh','0935492342','images/avatar2.jpg',2);
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
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `vi_tri` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanbay`
--

LOCK TABLES `sanbay` WRITE;
/*!40000 ALTER TABLE `sanbay` DISABLE KEYS */;
INSERT INTO `sanbay` VALUES (1,'Tân Sơn Nhất','Hồ Chí Minh'),(2,'Nội Bài','Hà Nội'),(3,'Cam Ranh','Khánh Hòa'),(4,'Long Thành','Đồng Nai'),(5,'Cát Bi','Hải Phòng'),(6,'Điện Biên Phủ','Điện Biên'),(7,'Thọ Xuân','Thanh Hóa'),(8,'Vinh','Nghệ An'),(9,'Đồng Hới','Quảng Bình'),(10,'Phú Bài','Thừa Thiên - Huế'),(11,'Đà Nẵng','Đà Nẵng'),(12,'Chu Lai','Quảng Nam'),(13,'Phù Cát','Bình Định'),(14,'Tuy Hòa','Phú Yên'),(15,'Buôn Ma Thuột','Đắk Lắk'),(16,'Liên Khương','Lâm Đồng'),(17,'Pleiku','Gia Lai'),(18,'Cà Mau','Cà Mau'),(19,'Côn Đảo','Bà Rịa - Vũng Tàu'),(20,'Cần Thơ','Cần Thơ'),(21,'Rạch Giá','Kiên Giang'),(22,'Phú Quốc','Kiên Giang'),(23,'Vân Đồn','Quảng Ninh');
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
INSERT INTO `sanbaytrunggian` VALUES (1,1,'00:30:00'),(1,6,'00:20:00');
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
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngay_xuat_ve` datetime NOT NULL,
  `id_chuyen_bay` int NOT NULL,
  `id_nhan_vien` int NOT NULL,
  `id_khach_hang` int NOT NULL,
  `id_ghe` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_chuyen_bay` (`id_chuyen_bay`),
  KEY `id_nhan_vien` (`id_nhan_vien`),
  KEY `id_khach_hang` (`id_khach_hang`),
  KEY `id_ghe` (`id_ghe`),
  CONSTRAINT `ve_ibfk_1` FOREIGN KEY (`id_chuyen_bay`) REFERENCES `chuyenbay` (`id_chuyen_bay`),
  CONSTRAINT `ve_ibfk_2` FOREIGN KEY (`id_nhan_vien`) REFERENCES `nhanvien` (`id`),
  CONSTRAINT `ve_ibfk_3` FOREIGN KEY (`id_khach_hang`) REFERENCES `khachhang` (`id`),
  CONSTRAINT `ve_ibfk_4` FOREIGN KEY (`id_ghe`) REFERENCES `ghe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ve`
--

LOCK TABLES `ve` WRITE;
/*!40000 ALTER TABLE `ve` DISABLE KEYS */;
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

-- Dump completed on 2020-12-08 16:13:39
