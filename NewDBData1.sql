-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: errandcatcher
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `applicationID` int NOT NULL AUTO_INCREMENT,
  `applicationErrandID` int DEFAULT NULL,
  `catcherID` int DEFAULT NULL,
  `applicationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `applicationStatus` varchar(10) DEFAULT 'Pending',
  `applicationQualification` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`applicationID`),
  KEY `userID_idx` (`catcherID`) /*!80000 INVISIBLE */,
  KEY `applicationErrandID_idx` (`applicationErrandID`),
  CONSTRAINT `applicationErrandID` FOREIGN KEY (`applicationErrandID`) REFERENCES `commission` (`commissionID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catcherID` FOREIGN KEY (`catcherID`) REFERENCES `useraccount` (`userID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commission`
--

DROP TABLE IF EXISTS `commission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commission` (
  `commissionID` int NOT NULL AUTO_INCREMENT,
  `employerID` int DEFAULT NULL,
  `commissionTitle` varchar(100) DEFAULT NULL,
  `commissionStartDate` date DEFAULT NULL,
  `commissionDeadline` date DEFAULT NULL,
  `commissionLocation` text,
  `commissionTo` text COMMENT 'if delivery, end place',
  `commissionType` varchar(50) DEFAULT NULL,
  `commissionDesc` text,
  `commissionPay` double DEFAULT NULL,
  `commissionStatus` varchar(30) DEFAULT 'Available',
  `DatePosted` date DEFAULT NULL,
  `ContactNumber` varchar(30) DEFAULT NULL COMMENT 'Additional contact number',
  `commissionLong` double DEFAULT NULL,
  `commissionLat` double DEFAULT NULL,
  `commissionDestLong` double DEFAULT NULL,
  `commissionDestLat` double DEFAULT NULL,
  `commissionTags` text,
  PRIMARY KEY (`commissionID`),
  KEY `userID_idx` (`employerID`),
  CONSTRAINT `userID` FOREIGN KEY (`employerID`) REFERENCES `useraccount` (`userID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_verification_tokens`
--

DROP TABLE IF EXISTS `email_verification_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_verification_tokens` (
  `verID` int NOT NULL AUTO_INCREMENT,
  `verUserID` int DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`verID`),
  KEY `verUserID_idx` (`verUserID`),
  CONSTRAINT `verUserID` FOREIGN KEY (`verUserID`) REFERENCES `useraccount` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `errandtransaction`
--

DROP TABLE IF EXISTS `errandtransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `errandtransaction` (
  `transactID` int NOT NULL AUTO_INCREMENT,
  `transErrandID` int DEFAULT NULL,
  `transCatcherID` int DEFAULT NULL,
  `errandStatus` varchar(45) DEFAULT 'Ongoing',
  `transDateAccepted` datetime DEFAULT CURRENT_TIMESTAMP,
  `transDateComplete` datetime DEFAULT NULL,
  `transReciept` varchar(100) DEFAULT NULL,
  `transStatus` varchar(45) DEFAULT 'Ongoing',
  PRIMARY KEY (`transactID`),
  KEY `transErrandID_idx` (`transErrandID`),
  KEY `transCatcherID_idx` (`transCatcherID`),
  CONSTRAINT `transCatcherID` FOREIGN KEY (`transCatcherID`) REFERENCES `useraccount` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transErrandID` FOREIGN KEY (`transErrandID`) REFERENCES `commission` (`commissionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feedbackcommission`
--

DROP TABLE IF EXISTS `feedbackcommission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedbackcommission` (
  `feedbackID` int NOT NULL AUTO_INCREMENT,
  `feedbackPosterID` int DEFAULT NULL,
  `feedbackCatcherID` int DEFAULT NULL,
  `feedbackRate` int DEFAULT '0',
  `feedbackDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `feedbackComment` text,
  `feedbackErrandID` int DEFAULT NULL,
  PRIMARY KEY (`feedbackID`),
  KEY `commissionID_idx` (`feedbackErrandID`),
  KEY `catcherID_idx` (`feedbackCatcherID`),
  KEY `employerID_idx` (`feedbackPosterID`),
  CONSTRAINT `feedbackCatcherID` FOREIGN KEY (`feedbackCatcherID`) REFERENCES `useraccount` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `feedbackCommissionID` FOREIGN KEY (`feedbackErrandID`) REFERENCES `commission` (`commissionID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `feedbackPosterID` FOREIGN KEY (`feedbackPosterID`) REFERENCES `useraccount` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `invoiceID` int NOT NULL AUTO_INCREMENT,
  `invoiceErrandID` int DEFAULT NULL,
  `invoiceCatcherID` int DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL COMMENT 'Total amount in centavos',
  `type` varchar(255) DEFAULT NULL,
  `description` text,
  `checkoutId` varchar(255) DEFAULT NULL,
  `invoiceemployerID` int DEFAULT NULL,
  `paymentId` varchar(255) DEFAULT NULL,
  `paid` datetime DEFAULT NULL,
  PRIMARY KEY (`invoiceID`),
  KEY `invoiceErrandID_idx` (`invoiceErrandID`),
  KEY `invoiceCatcherID_idx` (`invoiceCatcherID`),
  KEY `invoiceemployerID_idx` (`invoiceemployerID`),
  CONSTRAINT `invoiceCatcherID` FOREIGN KEY (`invoiceCatcherID`) REFERENCES `useraccount` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoiceemployerID` FOREIGN KEY (`invoiceemployerID`) REFERENCES `useraccount` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoiceErrandID` FOREIGN KEY (`invoiceErrandID`) REFERENCES `commission` (`commissionID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `notificationID` int NOT NULL AUTO_INCREMENT,
  `notifUserID` int DEFAULT NULL,
  `notificationType` varchar(50) DEFAULT NULL,
  `notifDesc` text,
  `isRead` varchar(5) DEFAULT 'no',
  `notifDate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notificationID`),
  KEY `userID_idx` (`notifUserID`),
  CONSTRAINT `notifUserID` FOREIGN KEY (`notifUserID`) REFERENCES `useraccount` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `useraccount`
--

DROP TABLE IF EXISTS `useraccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `useraccount` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `userLastname` varchar(30) DEFAULT NULL,
  `userFirstname` varchar(45) DEFAULT NULL,
  `userGender` varchar(10) DEFAULT NULL,
  `userEmail` varchar(40) DEFAULT NULL,
  `userContactNum` varchar(20) DEFAULT NULL,
  `userAge` int DEFAULT NULL,
  `userBirthday` date DEFAULT NULL,
  `userAddress` text,
  `userDesc` text,
  `accountStatus` varchar(20) DEFAULT 'Unverified',
  `accountType` varchar(20) DEFAULT NULL,
  `dateCreated` datetime DEFAULT CURRENT_TIMESTAMP,
  `profileImage` varchar(100) DEFAULT NULL,
  `userQualification` text,
  `userHasErrand` varchar(10) DEFAULT 'false',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userexperience`
--

DROP TABLE IF EXISTS `userexperience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userexperience` (
  `expID` int NOT NULL AUTO_INCREMENT,
  `expUserID` int DEFAULT NULL,
  `expJobTitle` varchar(45) DEFAULT NULL,
  `expEmployer` varchar(45) DEFAULT NULL,
  `expStartDate` varchar(45) DEFAULT NULL,
  `expEndDate` varchar(45) DEFAULT NULL,
  `expDesc` text,
  `expLocation` text,
  PRIMARY KEY (`expID`),
  KEY `userID_idx` (`expUserID`),
  CONSTRAINT `expUserID` FOREIGN KEY (`expUserID`) REFERENCES `useraccount` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `verification_request`
--

DROP TABLE IF EXISTS `verification_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_request` (
  `requestID` int NOT NULL AUTO_INCREMENT,
  `requestUserID` int DEFAULT NULL,
  `id_picture_front` varchar(100) DEFAULT NULL,
  `id_picture_back` varchar(100) DEFAULT NULL,
  `docu_1` varchar(45) DEFAULT NULL,
  `docu_2` varchar(45) DEFAULT NULL,
  `driversLicense1` varchar(45) DEFAULT NULL,
  `driversLicense2` varchar(45) DEFAULT NULL,
  `requestStatus` varchar(45) DEFAULT 'Pending',
  PRIMARY KEY (`requestID`),
  KEY `requestUserID_idx` (`requestUserID`),
  CONSTRAINT `requestUserID` FOREIGN KEY (`requestUserID`) REFERENCES `useraccount` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-26 15:07:43
