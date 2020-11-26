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
  PRIMARY KEY (`id_chuyen_bay`,`id_may_bay`,`id_duong_bay`,`ngay_khoi_hanh`),
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
INSERT INTO `chuyenbay` VALUES (1,1,1,'2020-11-27 20:00:00','08:00:00'),(2,2,2,'2020-11-26 21:00:00','01:00:00');
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
INSERT INTO `duongbay` VALUES (1,1,2,1616),(2,1,4,80);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ghe`
--

LOCK TABLES `ghe` WRITE;
/*!40000 ALTER TABLE `ghe` DISABLE KEYS */;
INSERT INTO `ghe` VALUES (1,'Ghế số 1',1,1,1),(2,'Ghế số 2',1,1,1),(3,'Ghế số 3',1,1,1),(4,'Ghế số 4',1,1,1),(5,'Ghế số 5',1,1,1),(6,'Ghế số 6',1,2,1),(7,'Ghế số 7',1,2,1),(8,'Ghế số 8',1,2,1),(9,'Ghế số 9',1,2,1),(10,'Ghế số 10',1,2,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khachhang`
--

LOCK TABLES `khachhang` WRITE;
/*!40000 ALTER TABLE `khachhang` DISABLE KEYS */;
INSERT INTO `khachhang` VALUES (1,'Trần Phấn Huy','Nam','2000-02-04','123456789101','371 Nguyễn Kiệm, Q. Gò Vấp','0768107705','huybelta1234@gmail.com');
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
INSERT INTO `loaighe` VALUES (1,'Ghế hạng 1',1000000),(2,'Ghế hạng 2',500000);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maybay`
--

LOCK TABLES `maybay` WRITE;
/*!40000 ALTER TABLE `maybay` DISABLE KEYS */;
INSERT INTO `maybay` VALUES (1,'AK47 GDucky',40,60),(2,'ZUKABU YOYO',30,50);
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
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
INSERT INTO `nhanvien` VALUES (1,'Đặng Hoàng Bửu','Nam','2020-02-04','371 Nguyễn Kiệm','Tiền Giang','0768107704','jpeg',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanbay`
--

LOCK TABLES `sanbay` WRITE;
/*!40000 ALTER TABLE `sanbay` DISABLE KEYS */;
INSERT INTO `sanbay` VALUES (1,'Tân Sơn Nhất','Hồ Chí Minh'),(2,'Nội Bài','Hà Nội'),(3,'Cam Ranh','Khánh Hòa'),(4,'Long Thành','Đồng Nai');
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
INSERT INTO `sanbaytrunggian` VALUES (3,1,'00:45:00');
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

-- Dump completed on 2020-11-26 22:10:31
