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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chuyenbay`
--

LOCK TABLES `chuyenbay` WRITE;
/*!40000 ALTER TABLE `chuyenbay` DISABLE KEYS */;
INSERT INTO `chuyenbay` VALUES (1,1,1,'2020-11-15 18:53:45','08:00:00');
/*!40000 ALTER TABLE `chuyenbay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dondatve`
--

DROP TABLE IF EXISTS `dondatve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dondatve` (
  `id_don_dat_ve` int NOT NULL AUTO_INCREMENT,
  `id_khach_hang` int NOT NULL,
  `id_nhan_vien` int NOT NULL,
  `ngay_dat_ve` datetime DEFAULT NULL,
  PRIMARY KEY (`id_don_dat_ve`),
  KEY `id_khach_hang` (`id_khach_hang`),
  KEY `id_nhan_vien` (`id_nhan_vien`),
  CONSTRAINT `dondatve_ibfk_1` FOREIGN KEY (`id_khach_hang`) REFERENCES `khachhang` (`id`),
  CONSTRAINT `dondatve_ibfk_2` FOREIGN KEY (`id_nhan_vien`) REFERENCES `nhanvien` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dondatve`
--

LOCK TABLES `dondatve` WRITE;
/*!40000 ALTER TABLE `dondatve` DISABLE KEYS */;
INSERT INTO `dondatve` VALUES (1,1,2,'2020-11-15 18:53:45');
/*!40000 ALTER TABLE `dondatve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `duongbay`
--

DROP TABLE IF EXISTS `duongbay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `duongbay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `san_bay_di` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `san_bay_den` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `san_bay_trung_gian` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thoi_gian_dung` time DEFAULT NULL,
  `khoang_cach` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duongbay`
--

LOCK TABLES `duongbay` WRITE;
/*!40000 ALTER TABLE `duongbay` DISABLE KEYS */;
INSERT INTO `duongbay` VALUES (1,'Tân Sơn Nhất','Nội Bài','Cam Ranh','00:40:00',1616);
/*!40000 ALTER TABLE `duongbay` ENABLE KEYS */;
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
INSERT INTO `khachhang` VALUES (1,'Trần Phấn Huy','123456789101','371 Nguyễn Kiệm, Q. Gò Vấp','0303033034','huybelta1234@gmail.com');
/*!40000 ALTER TABLE `khachhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loaive`
--

DROP TABLE IF EXISTS `loaive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loaive` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `don_gia` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loaive`
--

LOCK TABLES `loaive` WRITE;
/*!40000 ALTER TABLE `loaive` DISABLE KEYS */;
INSERT INTO `loaive` VALUES (1,'Vé hạng 1',1000000),(2,'Vé hạng 2',500000);
/*!40000 ALTER TABLE `loaive` ENABLE KEYS */;
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
  `ghe_hang_1` int DEFAULT NULL,
  `ghe_hang_2` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maybay`
--

LOCK TABLES `maybay` WRITE;
/*!40000 ALTER TABLE `maybay` DISABLE KEYS */;
INSERT INTO `maybay` VALUES (1,'AK47 GDucky',25,40);
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
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `role` (`role`),
  CONSTRAINT `nhanvien_ibfk_1` FOREIGN KEY (`role`) REFERENCES `userrole` (`id`),
  CONSTRAINT `nhanvien_chk_1` CHECK ((`active` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nhanvien`
--

LOCK TABLES `nhanvien` WRITE;
/*!40000 ALTER TABLE `nhanvien` DISABLE KEYS */;
INSERT INTO `nhanvien` VALUES (1,'Đặng Hoàng Bửu','hoangbuu2000','25f9e794323b453885f5181f1b624d0b',1,2),(2,'Dương Văn Tư','duongtu2000','25f9e794323b453885f5181f1b624d0b',1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanbay`
--

LOCK TABLES `sanbay` WRITE;
/*!40000 ALTER TABLE `sanbay` DISABLE KEYS */;
INSERT INTO `sanbay` VALUES (1,'Tân Sơn Nhất','Hồ Chí Minh'),(2,'Nội Bài','Hà Nội'),(3,'Cam Ranh','Khánh Hòa');
/*!40000 ALTER TABLE `sanbay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sanbay_duongbay`
--

DROP TABLE IF EXISTS `sanbay_duongbay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sanbay_duongbay` (
  `id_san_bay` int NOT NULL,
  `id_duong_bay` int NOT NULL,
  PRIMARY KEY (`id_san_bay`,`id_duong_bay`),
  KEY `id_duong_bay` (`id_duong_bay`),
  CONSTRAINT `sanbay_duongbay_ibfk_1` FOREIGN KEY (`id_san_bay`) REFERENCES `sanbay` (`id`),
  CONSTRAINT `sanbay_duongbay_ibfk_2` FOREIGN KEY (`id_duong_bay`) REFERENCES `duongbay` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanbay_duongbay`
--

LOCK TABLES `sanbay_duongbay` WRITE;
/*!40000 ALTER TABLE `sanbay_duongbay` DISABLE KEYS */;
INSERT INTO `sanbay_duongbay` VALUES (1,1),(2,1),(3,1);
/*!40000 ALTER TABLE `sanbay_duongbay` ENABLE KEYS */;
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
INSERT INTO `userrole` VALUES (1,'Nhân viên'),(2,'Quản trị');
/*!40000 ALTER TABLE `userrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ve`
--

DROP TABLE IF EXISTS `ve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ve` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_loai_ve` int NOT NULL,
  `id_chuyen_bay` int NOT NULL,
  `id_don_dat_ve` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_loai_ve` (`id_loai_ve`),
  KEY `id_chuyen_bay` (`id_chuyen_bay`),
  KEY `id_don_dat_ve` (`id_don_dat_ve`),
  CONSTRAINT `ve_ibfk_1` FOREIGN KEY (`id_loai_ve`) REFERENCES `loaive` (`id`),
  CONSTRAINT `ve_ibfk_2` FOREIGN KEY (`id_chuyen_bay`) REFERENCES `chuyenbay` (`id_chuyen_bay`),
  CONSTRAINT `ve_ibfk_3` FOREIGN KEY (`id_don_dat_ve`) REFERENCES `dondatve` (`id_don_dat_ve`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ve`
--

LOCK TABLES `ve` WRITE;
/*!40000 ALTER TABLE `ve` DISABLE KEYS */;
INSERT INTO `ve` VALUES (1,'TICKTUHUY1',1,1,1),(2,'TICKTUHUY2',1,1,1),(3,'TICKTUHUY3',2,1,1);
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

-- Dump completed on 2020-11-15 20:02:22
