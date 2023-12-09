CREATE DATABASE  IF NOT EXISTS `eventbuzz` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `eventbuzz`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (arm64)
--
-- Host: localhost    Database: eventbuzz
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `ErrorLog`
--

DROP TABLE IF EXISTS `ErrorLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ErrorLog` (
  `error_id` int NOT NULL AUTO_INCREMENT,
  `error_timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `error_source` varchar(255) DEFAULT NULL,
  `error_message` text,
  `error_context` text,
  `user_id` int DEFAULT NULL,
  `event_name` varchar(255) DEFAULT NULL,
  `additional_info` text,
  PRIMARY KEY (`error_id`),
  KEY `idx_errorlog_timestamp` (`error_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ErrorLog`
--

LOCK TABLES `ErrorLog` WRITE;
/*!40000 ALTER TABLE `ErrorLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `ErrorLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `errorlogview`
--

DROP TABLE IF EXISTS `errorlogview`;
/*!50001 DROP VIEW IF EXISTS `errorlogview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `errorlogview` AS SELECT 
 1 AS `error_id`,
 1 AS `error_timestamp`,
 1 AS `error_source`,
 1 AS `error_message`,
 1 AS `error_context`,
 1 AS `user_id`,
 1 AS `event_name`,
 1 AS `additional_info`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `EventCategories`
--

DROP TABLE IF EXISTS `EventCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EventCategories` (
  `category_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventCategories`
--

LOCK TABLES `EventCategories` WRITE;
/*!40000 ALTER TABLE `EventCategories` DISABLE KEYS */;
INSERT INTO `EventCategories` VALUES ('Arts & Theatre','Arts & Theatre events'),('Business & Networking','Business-related events including networking meetups, seminars, and conferences'),('Education','Educational events including workshops, seminars, and conferences'),('Family','Family events'),('Food & Drink','Culinary events such as food festivals, wine tastings, and cooking classes'),('Health & Wellness','Events focused on health, wellness, and fitness, including workshops and health fairs'),('Miscellaneous','Miscellaneous events'),('Music','Music events'),('Sports','Sports events'),('Technology','Events related to technology, such as tech expos, seminars, and workshops');
/*!40000 ALTER TABLE `EventCategories` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_event_category_insert` AFTER INSERT ON `eventcategories` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_event_category_insert', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.category_name, 'insert', CONCAT('category_name: ', NEW.category_name, ', description: ', NEW.description));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_event_category_update` AFTER UPDATE ON `eventcategories` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_event_category_update', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.category_name, 'update', CONCAT('category_name: ', NEW.category_name, ', description: ', NEW.description));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_event_category_delete` AFTER DELETE ON `eventcategories` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_event_category_delete', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.category_name, 'delete', CONCAT('category_name: ', OLD.category_name, ', description: ', OLD.description));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `eventcategoriesview`
--

DROP TABLE IF EXISTS `eventcategoriesview`;
/*!50001 DROP VIEW IF EXISTS `eventcategoriesview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `eventcategoriesview` AS SELECT 
 1 AS `category_name`,
 1 AS `description`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Events`
--

DROP TABLE IF EXISTS `Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Events` (
  `event_name` varchar(255) NOT NULL,
  `event_description` varchar(255) DEFAULT NULL,
  `event_date` varchar(255) DEFAULT NULL,
  `event_time` varchar(255) DEFAULT NULL,
  `event_status` enum('scheduled','cancelled','completed') NOT NULL DEFAULT 'scheduled',
  `event_image_url` varchar(255) DEFAULT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  `venue_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`event_name`),
  KEY `idx_events_date_status` (`event_date`,`event_status`),
  KEY `idx_events_category` (`category_name`),
  KEY `idx_events_venue` (`venue_name`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`category_name`) REFERENCES `EventCategories` (`category_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`venue_name`) REFERENCES `Venues` (`venue_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

LOCK TABLES `Events` WRITE;
/*!40000 ALTER TABLE `Events` DISABLE KEYS */;
INSERT INTO `Events` VALUES ('Business Networking Event','Meet and connect with business professionals','2023-11-25','17:00:00','scheduled','url_to_networking_image','Business & Networking','Riverside Theater'),('Culinary Delights Festival','Festival showcasing local and international cuisine','2023-06-18','11:00:00','scheduled','url_to_culinaryfest_image','Food & Drink','Harbor View Gallery'),('Educational Workshop Series','Series of educational and skill-building workshops','2023-12-05','10:00:00','scheduled','url_to_workshop_image','Education','Forest Lodge'),('Health and Wellness Fair','Event focusing on health and wellness','2023-08-15','09:30:00','scheduled','url_to_healthfair_image','Health & Wellness','Oceanfront Pavilion'),('Indie Film Nights','Screening of independent films','2023-08-30','19:00:00','scheduled','url_to_indiefilm_image','Arts & Theatre','Crystal Palace'),('Marathon City Run','Annual marathon through the city','2023-10-10','07:00:00','scheduled','url_to_marathon_image','Sports','Sunshine Auditorium'),('Spring Music Fest','Annual Spring Music Festival','2023-05-15','18:00:00','scheduled','url_to_event_image','Music','The Grand Hall'),('Summer Art Exhibition','Exhibition of contemporary art','2023-07-20','10:00:00','scheduled','url_to_art_image','Arts & Theatre','City Center Convention Hall'),('Tech Expo 2023','Technology and Innovation Expo','2023-09-05','09:00:00','scheduled','url_to_techexpo_image','Technology','Mountain View Arena'),('Winter Family Carnival','Fun and games for the entire family','2023-12-15','15:00:00','scheduled','url_to_carnival_image','Family','Starlight Ballroom');
/*!40000 ALTER TABLE `Events` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_event_insert` AFTER INSERT ON `events` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_event_insert', 'Error occurred', CONCAT('event_name: ', NEW.event_name, ', event_description: ', NEW.event_description, ', event_date: ', NEW.event_date, ', event_time: ', NEW.event_time, ', event_status: ', NEW.event_status, ', event_image_url: ', NEW.event_image_url, ', category_name: ', NEW.category_name, ', venue_name: ', NEW.venue_name));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.event_name, 'insert', CONCAT('event_name: ', NEW.event_name, ', event_description: ', NEW.event_description, ', event_date: ', NEW.event_date, ', event_time: ', NEW.event_time, ', event_status: ', NEW.event_status, ', event_image_url: ', NEW.event_image_url, ', category_name: ', NEW.category_name, ', venue_name: ', NEW.venue_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_event_update` AFTER UPDATE ON `events` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_event_update', 'Error occurred', CONCAT('event_name: ', NEW.event_name, ', event_description: ', NEW.event_description, ', event_date: ', NEW.event_date, ', event_time: ', NEW.event_time, ', event_status: ', NEW.event_status, ', event_image_url: ', NEW.event_image_url, ', category_name: ', NEW.category_name, ', venue_name: ', NEW.venue_name));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.event_name, 'update', CONCAT('event_name: ', NEW.event_name, ', event_description: ', NEW.event_description, ', event_date: ', NEW.event_date, ', event_time: ', NEW.event_time, ', event_status: ', NEW.event_status, ', event_image_url: ', NEW.event_image_url, ', category_name: ', NEW.category_name, ', venue_name: ', NEW.venue_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_event_delete` AFTER DELETE ON `events` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_event_delete', 'Error occurred', CONCAT('event_name: ', OLD.event_name, ', event_description: ', OLD.event_description, ', event_date: ', OLD.event_date, ', event_time: ', OLD.event_time, ', event_status: ', OLD.event_status, ', event_image_url: ', OLD.event_image_url, ', category_name: ', OLD.category_name, ', venue_name: ', OLD.venue_name));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.event_name, 'delete', CONCAT('event_name: ', OLD.event_name, ', event_description: ', OLD.event_description, ', event_date: ', OLD.event_date, ', event_time: ', OLD.event_time, ', event_status: ', OLD.event_status, ', event_image_url: ', OLD.event_image_url, ', category_name: ', OLD.category_name, ', venue_name: ', OLD.venue_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `EventsFundedBySponsors`
--

DROP TABLE IF EXISTS `EventsFundedBySponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EventsFundedBySponsors` (
  `event_name` varchar(255) NOT NULL,
  `sponsor_name` varchar(255) NOT NULL,
  `sponsorship_amount` double NOT NULL DEFAULT '0',
  `sponsorship_date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`event_name`,`sponsor_name`),
  KEY `sponsor_name` (`sponsor_name`),
  KEY `idx_events_fundedby_sponsors` (`event_name`,`sponsor_name`),
  CONSTRAINT `eventsfundedbysponsors_ibfk_1` FOREIGN KEY (`event_name`) REFERENCES `Events` (`event_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventsfundedbysponsors_ibfk_2` FOREIGN KEY (`sponsor_name`) REFERENCES `Sponsors` (`sponsor_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventsfundedbysponsors_chk_1` CHECK ((`sponsorship_amount` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventsFundedBySponsors`
--

LOCK TABLES `EventsFundedBySponsors` WRITE;
/*!40000 ALTER TABLE `EventsFundedBySponsors` DISABLE KEYS */;
INSERT INTO `EventsFundedBySponsors` VALUES ('Business Networking Event','BizNetwork',4500,'2023-09-30'),('Culinary Delights Festival','Foodie Heaven',3500,'2023-04-22'),('Educational Workshop Series','EduMinds',5000,'2023-10-11'),('Health and Wellness Fair','HealthFirst',2500,'2023-06-10'),('Indie Film Nights','Artistic Minds',3000,'2023-07-20'),('Marathon City Run','HealthFirst',3000,'2023-08-05'),('Spring Music Fest','Sponsor Inc',5000,'2023-11-09'),('Summer Art Exhibition','Tech Giants',4000,'2023-05-20'),('Tech Expo 2023','Tech Giants',6000,'2023-07-15'),('Winter Family Carnival','Family Fun Time',2000,'2023-11-01');
/*!40000 ALTER TABLE `EventsFundedBySponsors` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_sponsorship_insert` AFTER INSERT ON `eventsfundedbysponsors` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_sponsorship_insert', 'Error occurred',CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount), NEW.event_name);
    END;
    UPDATE Sponsors
    SET total_sponsorship_amount = total_sponsorship_amount + NEW.sponsorship_amount
    WHERE sponsor_name = NEW.sponsor_name;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_events_sponsors_insert` AFTER INSERT ON `eventsfundedbysponsors` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_message, error_context, event_name)
        VALUES ('after_events_sponsors_insert', 'Error occurred',CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount), NEW.event_name);
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.event_name, '&&', NEW.sponsor_name), 'insert', CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_sponsorship_update` AFTER UPDATE ON `eventsfundedbysponsors` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_sponsorship_update', 'Error occurred',CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount), NEW.event_name);
    END;
    UPDATE Sponsors
    SET total_sponsorship_amount = total_sponsorship_amount - OLD.sponsorship_amount + NEW.sponsorship_amount
    WHERE sponsor_name = NEW.sponsor_name;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_events_sponsors_update` AFTER UPDATE ON `eventsfundedbysponsors` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_message, error_context, event_name)
        VALUES ('after_events_sponsors_update', 'Error occurred',CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount), NEW.event_name);
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.event_name, '&&', NEW.sponsor_name), 'update', CONCAT('sponsor_name: ', NEW.sponsor_name, ', sponsorship_amount: ', NEW.sponsorship_amount, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_sponsorship_delete` AFTER DELETE ON `eventsfundedbysponsors` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_sponsorship_delete', 'Error occurred',CONCAT('sponsor_name: ', OLD.sponsor_name, ', sponsorship_amount: ', OLD.sponsorship_amount), OLD.event_name);
    END;
    UPDATE Sponsors
    SET total_sponsorship_amount = total_sponsorship_amount - OLD.sponsorship_amount
    WHERE sponsor_name = OLD.sponsor_name;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_events_sponsors_delete` AFTER DELETE ON `eventsfundedbysponsors` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_context, event_name)
        VALUES ('after_events_sponsors_delete', 'Error occurred',CONCAT('sponsor_name: ', OLD.sponsor_name, ', sponsorship_amount: ', OLD.sponsorship_amount), OLD.event_name);
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.event_name, '&&', OLD.sponsor_name), 'delete', CONCAT('sponsor_name: ', OLD.sponsor_name, ', sponsorship_amount: ', OLD.sponsorship_amount, ', event_name: ', OLD.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `eventsfundedbysponsorsview`
--

DROP TABLE IF EXISTS `eventsfundedbysponsorsview`;
/*!50001 DROP VIEW IF EXISTS `eventsfundedbysponsorsview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `eventsfundedbysponsorsview` AS SELECT 
 1 AS `event_name`,
 1 AS `sponsor_name`,
 1 AS `sponsorship_amount`,
 1 AS `sponsorship_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `EventsOrganisedByOrganisers`
--

DROP TABLE IF EXISTS `EventsOrganisedByOrganisers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EventsOrganisedByOrganisers` (
  `event_name` varchar(255) NOT NULL,
  `organiser_name` varchar(255) NOT NULL,
  `organiser_role` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`event_name`,`organiser_name`),
  KEY `organiser_name` (`organiser_name`),
  KEY `idx_events_organisedby_organisers` (`event_name`,`organiser_name`),
  CONSTRAINT `eventsorganisedbyorganisers_ibfk_1` FOREIGN KEY (`event_name`) REFERENCES `Events` (`event_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `eventsorganisedbyorganisers_ibfk_2` FOREIGN KEY (`organiser_name`) REFERENCES `Organisers` (`organiser_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EventsOrganisedByOrganisers`
--

LOCK TABLES `EventsOrganisedByOrganisers` WRITE;
/*!40000 ALTER TABLE `EventsOrganisedByOrganisers` DISABLE KEYS */;
INSERT INTO `EventsOrganisedByOrganisers` VALUES ('Business Networking Event','Artistic Ventures','Event Planner'),('Culinary Delights Festival','Gourmet Gatherings','Main Organiser'),('Educational Workshop Series','EduEvents','Coordinator'),('Health and Wellness Fair','Health Horizons','Coordinator'),('Indie Film Nights','Showtime Events','Event Planner'),('Marathon City Run','SportsMania Org','Event Planner'),('Spring Music Fest','Organiser Pro','Main Organiser'),('Summer Art Exhibition','Event Masters','Coordinator'),('Tech Expo 2023','Tech Conventions','Main Organiser'),('Winter Family Carnival','Family Fest Organisers','Main Organiser');
/*!40000 ALTER TABLE `EventsOrganisedByOrganisers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_events_organiser_insert` AFTER INSERT ON `eventsorganisedbyorganisers` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_context, event_name)
        VALUES ('after_events_organiser_insert', 'Error occurred',CONCAT('organiser_name: ', NEW.organiser_name), NEW.event_name);
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.event_name, '&&', NEW.organiser_name), 'insert', CONCAT('organiser_name: ', NEW.organiser_name, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_events_organiser_update` AFTER UPDATE ON `eventsorganisedbyorganisers` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_context, event_name)
        VALUES ('after_events_organiser_update', 'Error occurred',CONCAT('organiser_name: ', NEW.organiser_name), NEW.event_name);
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.event_name, '&&', NEW.organiser_name), 'update', CONCAT('organiser_name: ', NEW.organiser_name, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_events_organiser_delete` AFTER DELETE ON `eventsorganisedbyorganisers` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_context, event_name)
        VALUES ('after_events_organiser_delete', 'Error occurred',CONCAT('organiser_name: ', OLD.organiser_name), OLD.event_name);
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.event_name, '&&', OLD.organiser_name), 'delete', CONCAT('organiser_name: ', OLD.organiser_name, ', event_name: ', OLD.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `eventsorganisedbyorganisersview`
--

DROP TABLE IF EXISTS `eventsorganisedbyorganisersview`;
/*!50001 DROP VIEW IF EXISTS `eventsorganisedbyorganisersview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `eventsorganisedbyorganisersview` AS SELECT 
 1 AS `event_name`,
 1 AS `organiser_name`,
 1 AS `organiser_role`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `eventsview`
--

DROP TABLE IF EXISTS `eventsview`;
/*!50001 DROP VIEW IF EXISTS `eventsview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `eventsview` AS SELECT 
 1 AS `event_name`,
 1 AS `event_description`,
 1 AS `event_date`,
 1 AS `event_time`,
 1 AS `event_status`,
 1 AS `event_image_url`,
 1 AS `category_name`,
 1 AS `venue_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Notifications`
--

DROP TABLE IF EXISTS `Notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Notifications` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `notification_text` varchar(255) DEFAULT NULL,
  `notification_date` varchar(255) DEFAULT NULL,
  `event_name` varchar(255) NOT NULL,
  PRIMARY KEY (`notification_id`,`event_name`),
  KEY `idx_notifications_event` (`event_name`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`event_name`) REFERENCES `Events` (`event_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notifications`
--

LOCK TABLES `Notifications` WRITE;
/*!40000 ALTER TABLE `Notifications` DISABLE KEYS */;
INSERT INTO `Notifications` VALUES (1,'New event Spring Music Fest is available!','2023-09-15','Spring Music Fest'),(2,'Summer Art Exhibition tickets now on sale!','2023-06-01','Summer Art Exhibition'),(3,'Tech Expo 2023 coming this fall','2023-08-20','Tech Expo 2023'),(4,'Join us for the Marathon City Run!','2023-09-05','Marathon City Run'),(5,'Health and Wellness Fair this weekend','2023-07-10','Health and Wellness Fair'),(6,'Don’t miss the Culinary Delights Festival','2023-05-15','Culinary Delights Festival'),(7,'Network at the Business Networking Event','2023-10-30','Business Networking Event'),(8,'Register for Educational Workshop Series','2023-11-10','Educational Workshop Series'),(9,'Winter Family Carnival - Fun for all ages','2023-11-25','Winter Family Carnival'),(10,'Experience unique films at Indie Film Nights','2023-08-01','Indie Film Nights');
/*!40000 ALTER TABLE `Notifications` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_notification_insert` AFTER INSERT ON `notifications` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_insert', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.notification_id, '&&', NEW.event_name), 'insert', CONCAT('notification_text: ', NEW.notification_text, ', notification_date: ', NEW.notification_date, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_notification_update` AFTER UPDATE ON `notifications` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_update', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.notification_id, '&&', NEW.event_name), 'update', CONCAT('notification_text: ', NEW.notification_text, ', notification_date: ', NEW.notification_date, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_notification_delete` AFTER DELETE ON `notifications` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_delete', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.notification_id, '&&', OLD.event_name), 'delete', CONCAT('notification_text: ', OLD.notification_text, ', notification_date: ', OLD.notification_date, ', event_name: ', OLD.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `NotificationsSendToUsers`
--

DROP TABLE IF EXISTS `NotificationsSendToUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NotificationsSendToUsers` (
  `user_id` int NOT NULL,
  `notification_id` int NOT NULL,
  `priority` enum('high','medium','low') NOT NULL DEFAULT 'low',
  PRIMARY KEY (`user_id`,`notification_id`),
  KEY `notification_id` (`notification_id`),
  KEY `idx_notifications_sendto_users` (`user_id`,`notification_id`),
  CONSTRAINT `notificationssendtousers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notificationssendtousers_ibfk_2` FOREIGN KEY (`notification_id`) REFERENCES `Notifications` (`notification_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NotificationsSendToUsers`
--

LOCK TABLES `NotificationsSendToUsers` WRITE;
/*!40000 ALTER TABLE `NotificationsSendToUsers` DISABLE KEYS */;
INSERT INTO `NotificationsSendToUsers` VALUES (1,1,'medium'),(2,2,'high'),(3,3,'low'),(4,4,'medium'),(5,5,'high'),(6,6,'low'),(7,7,'medium'),(8,8,'high'),(9,9,'low'),(10,10,'medium');
/*!40000 ALTER TABLE `NotificationsSendToUsers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_notification_user_insert` AFTER INSERT ON `notificationssendtousers` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_user_insert', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.notification_id), 'insert', CONCAT('priority: ', NEW.priority, ', notification_id: ', NEW.notification_id, ', user_id: ', NEW.user_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_notification_user_update` AFTER UPDATE ON `notificationssendtousers` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_user_update', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.notification_id), 'update', CONCAT('priority: ', NEW.priority, ', notification_id: ', NEW.notification_id, ', user_id: ', NEW.user_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_notification_user_delete` AFTER DELETE ON `notificationssendtousers` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_notification_user_delete', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.user_id, '&&', OLD.notification_id), 'delete', CONCAT('priority: ', OLD.priority, ', notification_id: ', OLD.notification_id, ', user_id: ', OLD.user_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `notificationssendtousersview`
--

DROP TABLE IF EXISTS `notificationssendtousersview`;
/*!50001 DROP VIEW IF EXISTS `notificationssendtousersview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `notificationssendtousersview` AS SELECT 
 1 AS `user_id`,
 1 AS `notification_id`,
 1 AS `priority`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `notificationsview`
--

DROP TABLE IF EXISTS `notificationsview`;
/*!50001 DROP VIEW IF EXISTS `notificationsview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `notificationsview` AS SELECT 
 1 AS `notification_id`,
 1 AS `notification_text`,
 1 AS `notification_date`,
 1 AS `event_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_date` varchar(255) DEFAULT NULL,
  `payment_type` enum('credit_card','debit_card','paypal','other') NOT NULL DEFAULT 'credit_card',
  `payment_status` enum('paid','pending','failed') NOT NULL DEFAULT 'pending',
  `total_amount` double DEFAULT '0',
  `user_id` int DEFAULT NULL,
  `event_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `idx_orders_user` (`user_id`),
  KEY `idx_orders_event` (`event_name`),
  KEY `idx_orders_date_status` (`order_date`,`payment_status`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`event_name`) REFERENCES `Events` (`event_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_chk_1` CHECK ((`total_amount` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` VALUES (1,'2023-02-11','credit_card','paid',50,1,'Spring Music Fest'),(2,'2023-03-15','debit_card','paid',120,2,'Summer Art Exhibition'),(3,'2023-04-20','paypal','pending',50,3,'Tech Expo 2023'),(4,'2023-05-25','credit_card','paid',60,4,'Marathon City Run'),(5,'2023-06-30','other','failed',30,5,'Health and Wellness Fair'),(6,'2023-07-05','debit_card','paid',200,6,'Culinary Delights Festival'),(7,'2023-08-10','credit_card','pending',70,7,'Business Networking Event'),(8,'2023-09-15','paypal','paid',45,8,'Educational Workshop Series'),(9,'2023-10-21','credit_card','paid',100,9,'Winter Family Carnival'),(10,'2023-11-30','debit_card','paid',120,10,'Indie Film Nights');
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_order_insert` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_order_insert', 'Error occurred', CONCAT('order_date: ', NEW.order_date, ', payment_type: ', NEW.payment_type, ', payment_status: ', NEW.payment_status, ', total_amount: ', NEW.total_amount, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.order_id, 'insert', CONCAT('order_date: ', NEW.order_date, ', payment_type: ', NEW.payment_type, ', payment_status: ', NEW.payment_status, ', total_amount: ', NEW.total_amount, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_order_update` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_order_update', 'Error occurred', CONCAT('order_date: ', NEW.order_date, ', payment_type: ', NEW.payment_type, ', payment_status: ', NEW.payment_status, ', total_amount: ', NEW.total_amount, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.order_id, 'update', CONCAT('order_date: ', NEW.order_date, ', payment_type: ', NEW.payment_type, ', payment_status: ', NEW.payment_status, ', total_amount: ', NEW.total_amount, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_order_delete` AFTER DELETE ON `orders` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_order_delete', 'Error occurred', CONCAT('order_date: ', OLD.order_date, ', payment_type: ', OLD.payment_type, ', payment_status: ', OLD.payment_status, ', total_amount: ', OLD.total_amount, ', user_id: ', OLD.user_id, ', event_name: ', OLD.event_name));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.order_id, 'delete', CONCAT('order_date: ', OLD.order_date, ', payment_type: ', OLD.payment_type, ', payment_status: ', OLD.payment_status, ', total_amount: ', OLD.total_amount, ', user_id: ', OLD.user_id, ', event_name: ', OLD.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `ordersview`
--

DROP TABLE IF EXISTS `ordersview`;
/*!50001 DROP VIEW IF EXISTS `ordersview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ordersview` AS SELECT 
 1 AS `order_id`,
 1 AS `order_date`,
 1 AS `payment_type`,
 1 AS `payment_status`,
 1 AS `total_amount`,
 1 AS `user_id`,
 1 AS `event_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Organisers`
--

DROP TABLE IF EXISTS `Organisers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Organisers` (
  `organiser_name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`organiser_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Organisers`
--

LOCK TABLES `Organisers` WRITE;
/*!40000 ALTER TABLE `Organisers` DISABLE KEYS */;
INSERT INTO `Organisers` VALUES ('Artistic Ventures','Art and Theatre Event Specialists','url_to_artisticventures_logo','arts@artisticventures.com','1091092109'),('EduEvents','Focused on Educational and Workshop Events','url_to_eduevents_logo','support@eduevents.com','6546547654'),('Event Masters','Expert in Corporate Event Planning','url_to_eventmasters_logo','info@eventmasters.com','4324325432'),('Family Fest Organisers','Creating Memorable Family Events','url_to_familyfest_logo','family@familyfestorganisers.com','2102103210'),('Gourmet Gatherings','Food and Culinary Event Experts','url_to_gourmetgatherings_logo','hello@gourmetgatherings.com','9879870987'),('Health Horizons','Health and Wellness Event Organisers','url_to_healthhorizons_logo','wellness@healthhorizons.com','7657658765'),('Organiser Pro','Top Event Organiser','url_to_organiser_logo','contact@organiserpro.com','3213214321'),('Showtime Events','Specialists in Entertainment and Shows','url_to_showtime_logo','contact@showtimeevents.com','5435436543'),('SportsMania Org','Organising Sports Events and Tournaments','url_to_sportsmania_logo','sports@sportsmaniaorg.com','0980981098'),('Tech Conventions','Organising Tech and Innovation Conferences','url_to_techconventions_logo','tech@techconventions.com','8768769876');
/*!40000 ALTER TABLE `Organisers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_organiser_insert` AFTER INSERT ON `organisers` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source)
        VALUES ('after_organiser_insert', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.organiser_name, 'insert', CONCAT('organiser_name: ', NEW.organiser_name, ', organiser_email: ', NEW.contact_email, ', organiser_phone: ', NEW.contact_phone, ', organiser_description: ', NEW.description));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_organiser_update` AFTER UPDATE ON `organisers` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source)
        VALUES ('after_organiser_update', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.organiser_name, 'update', CONCAT('organiser_name: ', NEW.organiser_name, ', organiser_email: ', NEW.contact_email, ', organiser_phone: ', NEW.contact_phone, ', organiser_description: ', NEW.description));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_organiser_delete` AFTER DELETE ON `organisers` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source)
        VALUES ('after_organiser_delete', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.organiser_name, 'delete', CONCAT('organiser_name: ', OLD.organiser_name, ', organiser_email: ', OLD.contact_email, ', organiser_phone: ', OLD.contact_phone, ', organiser_description: ', OLD.description));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Reviews`
--

DROP TABLE IF EXISTS `Reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reviews` (
  `rating` tinyint NOT NULL DEFAULT '1',
  `comment` varchar(255) DEFAULT NULL,
  `review_date` varchar(255) DEFAULT NULL,
  `user_id` int NOT NULL,
  `event_name` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`,`event_name`),
  KEY `event_name` (`event_name`),
  KEY `idx_reviews_user_event` (`user_id`,`event_name`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`event_name`) REFERENCES `Events` (`event_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_chk_1` CHECK ((`rating` between 1 and 5))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reviews`
--

LOCK TABLES `Reviews` WRITE;
/*!40000 ALTER TABLE `Reviews` DISABLE KEYS */;
INSERT INTO `Reviews` VALUES (5,'Great event!','2023-02-11',1,'Spring Music Fest'),(4,'Really enjoyed the exhibition.','2023-07-21',2,'Summer Art Exhibition'),(3,'Interesting expo, but could be better.','2023-09-06',3,'Tech Expo 2023'),(5,'Loved the marathon! Well organized.','2023-10-11',4,'Marathon City Run'),(2,'Fair was okay, not many activities.','2023-08-16',5,'Health and Wellness Fair'),(5,'Amazing food, great atmosphere!','2023-06-19',6,'Culinary Delights Festival'),(4,'Great networking opportunities.','2023-11-26',7,'Business Networking Event'),(5,'The workshops were very informative.','2023-12-06',8,'Educational Workshop Series'),(3,'Fun family event but quite crowded.','2023-12-16',9,'Winter Family Carnival'),(4,'Loved the indie films, great selection.','2023-08-31',10,'Indie Film Nights');
/*!40000 ALTER TABLE `Reviews` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_review_insert` AFTER INSERT ON `reviews` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_review_insert', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.event_name), 'insert', CONCAT('rating: ', NEW.rating, ', comment: ', NEW.comment, ', review_date: ', NEW.review_date, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_review_update` AFTER UPDATE ON `reviews` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_review_update', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.event_name), 'update', CONCAT('rating: ', NEW.rating, ', comment: ', NEW.comment, ', review_date: ', NEW.review_date, ', user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_review_delete` AFTER DELETE ON `reviews` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_review_delete', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.user_id, '&&', OLD.event_name), 'delete', CONCAT('rating: ', OLD.rating, ', comment: ', OLD.comment, ', review_date: ', OLD.review_date, ', user_id: ', OLD.user_id, ', event_name: ', OLD.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `reviewsview`
--

DROP TABLE IF EXISTS `reviewsview`;
/*!50001 DROP VIEW IF EXISTS `reviewsview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reviewsview` AS SELECT 
 1 AS `rating`,
 1 AS `comment`,
 1 AS `review_date`,
 1 AS `user_id`,
 1 AS `event_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Sponsors`
--

DROP TABLE IF EXISTS `Sponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sponsors` (
  `sponsor_name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `website_url` varchar(255) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(255) DEFAULT NULL,
  `total_sponsorship_amount` double DEFAULT '0',
  PRIMARY KEY (`sponsor_name`),
  CONSTRAINT `sponsors_chk_1` CHECK ((`total_sponsorship_amount` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sponsors`
--

LOCK TABLES `Sponsors` WRITE;
/*!40000 ALTER TABLE `Sponsors` DISABLE KEYS */;
INSERT INTO `Sponsors` VALUES ('Artistic Minds','Supporting Arts and Theatre','https://artisticminds.com','url_to_artisticminds_logo','creativity@artisticminds.com','9019019012',3000),('BizNetwork','Business Networking and Corporate Events','https://biznetwork.com','url_to_biznetwork_logo','connect@biznetwork.com','7897897890',4500),('EduMinds','Education and Learning Sponsor','https://eduminds.com','url_to_eduminds_logo','support@eduminds.com','4564564567',5000),('Family Fun Time','Family and Community Events','https://familyfuntime.com','url_to_familyfuntime_logo','family@funtime.com','0120120123',2000),('Foodie Heaven','Culinary Arts and Food Festivals','https://foodieheaven.com','url_to_foodieheaven_logo','yum@foodieheaven.com','6786786789',3500),('Green Earth','Eco-friendly Initiatives and Sustainability','https://greenearth.com','url_to_greenearth_logo','green@earth.com','5675675678',0),('HealthFirst','Healthcare and Wellness Sponsor','https://healthfirst.com','url_to_healthfirst_logo','info@healthfirst.com','3453453456',5500),('Sponsor Inc','Leading Event Sponsor','https://sponsorinc.com','url_to_logo','info@sponsorinc.com','1231231234',5000),('Sportify','Sports Events and Athletic Sponsor','https://sportify.com','url_to_sportify_logo','sports@sportify.com','8908908901',0),('Tech Giants','Technology and Innovation Leaders','https://techgiants.com','url_to_techgiants_logo','contact@techgiants.com','2342342345',10000);
/*!40000 ALTER TABLE `Sponsors` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_sponsor_insert` AFTER INSERT ON `sponsors` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_sponsor_insert', 'Error occurred', CONCAT('sponsor_name: ', NEW.sponsor_name, ', description: ', NEW.description));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.sponsor_name, 'insert', CONCAT('sponsor_name: ', NEW.sponsor_name, ', description: ', NEW.description));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_sponsor_update` AFTER UPDATE ON `sponsors` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_sponsor_update', 'Error occurred', CONCAT('sponsor_name: ', NEW.sponsor_name, ', description: ', NEW.description));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.sponsor_name, 'update', CONCAT('sponsor_name: ', NEW.sponsor_name, ', description: ', NEW.description));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_sponsor_delete` AFTER DELETE ON `sponsors` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_sponsor_delete', 'Error occurred', CONCAT('sponsor_name: ', OLD.sponsor_name, ', description: ', OLD.description));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.sponsor_name, 'delete', CONCAT('sponsor_name: ', OLD.sponsor_name, ', description: ', OLD.description));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `sponsorsview`
--

DROP TABLE IF EXISTS `sponsorsview`;
/*!50001 DROP VIEW IF EXISTS `sponsorsview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sponsorsview` AS SELECT 
 1 AS `sponsor_name`,
 1 AS `description`,
 1 AS `website_url`,
 1 AS `logo_url`,
 1 AS `contact_email`,
 1 AS `contact_phone`,
 1 AS `total_sponsorship_amount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Tickets`
--

DROP TABLE IF EXISTS `Tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tickets` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `ticket_price` double NOT NULL DEFAULT '0',
  `ticket_quantity` int NOT NULL DEFAULT '0',
  `start_sale_date` varchar(255) DEFAULT NULL,
  `end_sale_date` varchar(255) DEFAULT NULL,
  `event_name` varchar(255) DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `idx_tickets_event` (`event_name`),
  KEY `idx_tickets_order` (`order_id`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`event_name`) REFERENCES `Events` (`event_name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `Orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tickets_chk_1` CHECK ((`ticket_price` >= 0)),
  CONSTRAINT `tickets_chk_2` CHECK ((`ticket_quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tickets`
--

LOCK TABLES `Tickets` WRITE;
/*!40000 ALTER TABLE `Tickets` DISABLE KEYS */;
INSERT INTO `Tickets` VALUES (1,25,2,'2023-04-01','2023-05-01','Spring Music Fest',1),(2,30,4,'2023-06-01','2023-07-01','Summer Art Exhibition',2),(3,50,1,'2023-07-15','2023-09-01','Tech Expo 2023',3),(4,20,3,'2023-09-10','2023-10-05','Marathon City Run',4),(5,15,2,'2023-07-20','2023-08-10','Health and Wellness Fair',5),(6,40,5,'2023-05-25','2023-06-18','Culinary Delights Festival',6),(7,35,2,'2023-10-20','2023-11-20','Business Networking Event',7),(8,45,1,'2023-11-01','2023-12-01','Educational Workshop Series',8),(9,25,4,'2023-11-15','2023-12-10','Winter Family Carnival',9),(10,60,2,'2023-07-30','2023-08-25','Indie Film Nights',10);
/*!40000 ALTER TABLE `Tickets` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_ticket_insert_total_sum` AFTER INSERT ON `tickets` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_ticket_insert_total_sum', 'Error occurred',CONCAT('ticket_id' + NEW.ticket_id + 'ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity), NEW.event_name);
    END;
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = NEW.order_id)
    WHERE order_id = NEW.order_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_ticket_insert` AFTER INSERT ON `tickets` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_ticket_insert', 'Error occurred', CONCAT('ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity, ', start_sale_date: ', NEW.start_sale_date, ', end_sale_date: ', NEW.end_sale_date, ', event_name: ', NEW.event_name, ', order_id: ', NEW.order_id));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.ticket_id, 'insert', CONCAT('ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity, ', start_sale_date: ', NEW.start_sale_date, ', end_sale_date: ', NEW.end_sale_date, ', event_name: ', NEW.event_name, ', order_id: ', NEW.order_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_ticket_update_total_sum` AFTER UPDATE ON `tickets` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_ticket_update_total_sum', 'Error occurred',CONCAT('ticket_id' + NEW.ticket_id + 'ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity), NEW.event_name);
    END;
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = NEW.order_id)
    WHERE order_id = NEW.order_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_ticket_update` AFTER UPDATE ON `tickets` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_ticket_update', 'Error occurred', CONCAT('ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity, ', start_sale_date: ', NEW.start_sale_date, ', end_sale_date: ', NEW.end_sale_date, ', event_name: ', NEW.event_name, ', order_id: ', NEW.order_id));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.ticket_id, 'update', CONCAT('ticket_price: ', NEW.ticket_price, ', ticket_quantity: ', NEW.ticket_quantity, ', start_sale_date: ', NEW.start_sale_date, ', end_sale_date: ', NEW.end_sale_date, ', event_name: ', NEW.event_name, ', order_id: ', NEW.order_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_ticket_delete_total_sum` AFTER DELETE ON `tickets` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context, event_name)
        VALUES ('after_ticket_delete_total_sum', 'Error occurred',CONCAT('ticket_id' + OLD.ticket_id + 'ticket_price: ', OLD.ticket_price, ', ticket_quantity: ', OLD.ticket_quantity), OLD.event_name);
    END;
    UPDATE Orders
    SET total_amount = (SELECT SUM(ticket_price * ticket_quantity) FROM Tickets WHERE order_id = OLD.order_id)
    WHERE order_id = OLD.order_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_ticket_delete` AFTER DELETE ON `tickets` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message, error_context)
        VALUES ('after_ticket_delete', 'Error occurred', CONCAT('ticket_price: ', OLD.ticket_price, ', ticket_quantity: ', OLD.ticket_quantity, ', start_sale_date: ', OLD.start_sale_date, ', end_sale_date: ', OLD.end_sale_date, ', event_name: ', OLD.event_name, ', order_id: ', OLD.order_id));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.ticket_id, 'delete', CONCAT('ticket_price: ', OLD.ticket_price, ', ticket_quantity: ', OLD.ticket_quantity, ', start_sale_date: ', OLD.start_sale_date, ', end_sale_date: ', OLD.end_sale_date, ', event_name: ', OLD.event_name, ', order_id: ', OLD.order_id));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `ticketsview`
--

DROP TABLE IF EXISTS `ticketsview`;
/*!50001 DROP VIEW IF EXISTS `ticketsview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ticketsview` AS SELECT 
 1 AS `ticket_id`,
 1 AS `ticket_price`,
 1 AS `ticket_quantity`,
 1 AS `start_sale_date`,
 1 AS `end_sale_date`,
 1 AS `event_name`,
 1 AS `order_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `UserLog`
--

DROP TABLE IF EXISTS `UserLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserLog` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `general_id` varchar(255) DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `action_timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `details` text,
  PRIMARY KEY (`log_id`),
  KEY `idx_userlog_timestamp` (`action_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserLog`
--

LOCK TABLES `UserLog` WRITE;
/*!40000 ALTER TABLE `UserLog` DISABLE KEYS */;
INSERT INTO `UserLog` VALUES (1,'1','registration','2023-12-08 23:14:38','user_id: 1, user_name: johndoe'),(2,'2','registration','2023-12-08 23:14:38','user_id: 2, user_name: vandit'),(3,'3','registration','2023-12-08 23:14:38','user_id: 3, user_name: emilyross'),(4,'4','registration','2023-12-08 23:14:38','user_id: 4, user_name: alexsmith'),(5,'5','registration','2023-12-08 23:14:38','user_id: 5, user_name: sarahlee'),(6,'6','registration','2023-12-08 23:14:38','user_id: 6, user_name: michaelbrown'),(7,'7','registration','2023-12-08 23:14:38','user_id: 7, user_name: lucywhite'),(8,'8','registration','2023-12-08 23:14:38','user_id: 8, user_name: davidthomas'),(9,'9','registration','2023-12-08 23:14:38','user_id: 9, user_name: jenniferwilson'),(10,'10','registration','2023-12-08 23:14:38','user_id: 10, user_name: kevinmartin'),(11,'Music','insert','2023-12-08 23:14:38','category_name: Music, description: Music events'),(12,'Sports','insert','2023-12-08 23:14:38','category_name: Sports, description: Sports events'),(13,'Arts & Theatre','insert','2023-12-08 23:14:38','category_name: Arts & Theatre, description: Arts & Theatre events'),(14,'Family','insert','2023-12-08 23:14:38','category_name: Family, description: Family events'),(15,'Miscellaneous','insert','2023-12-08 23:14:38','category_name: Miscellaneous, description: Miscellaneous events'),(16,'Technology','insert','2023-12-08 23:14:38','category_name: Technology, description: Events related to technology, such as tech expos, seminars, and workshops'),(17,'Education','insert','2023-12-08 23:14:38','category_name: Education, description: Educational events including workshops, seminars, and conferences'),(18,'Health & Wellness','insert','2023-12-08 23:14:38','category_name: Health & Wellness, description: Events focused on health, wellness, and fitness, including workshops and health fairs'),(19,'Food & Drink','insert','2023-12-08 23:14:38','category_name: Food & Drink, description: Culinary events such as food festivals, wine tastings, and cooking classes'),(20,'Business & Networking','insert','2023-12-08 23:14:38','category_name: Business & Networking, description: Business-related events including networking meetups, seminars, and conferences'),(21,'The Grand Hall','insert','2023-12-08 23:14:38','venue_name: The Grand Hall, street_no: 456, street_name: Broadway, unit_no: 101, city: Metropolis, state: State, zip_code: 67890, max_capacity: 500, contact_email: contact@grandhall.com, contact_phone: 0987654321'),(22,'Riverside Theater','insert','2023-12-08 23:14:38','venue_name: Riverside Theater, street_no: 789, street_name: River Rd, unit_no: 202, city: Lakeside, state: StateB, zip_code: 12345, max_capacity: 350, contact_email: info@riversidetheater.com, contact_phone: 1234567890'),(23,'Sunshine Auditorium','insert','2023-12-08 23:14:38','venue_name: Sunshine Auditorium, street_no: 321, street_name: Sunset Blvd, unit_no: 303, city: Sunnyville, state: StateC, zip_code: 23456, max_capacity: 750, contact_email: contact@sunshineauditorium.com, contact_phone: 2345678901'),(24,'Mountain View Arena','insert','2023-12-08 23:14:38','venue_name: Mountain View Arena, street_no: 654, street_name: Highland Ave, unit_no: 404, city: Hilltown, state: StateD, zip_code: 34567, max_capacity: 1000, contact_email: info@mountainviewarena.com, contact_phone: 3456789012'),(25,'Starlight Ballroom','insert','2023-12-08 23:14:38','venue_name: Starlight Ballroom, street_no: 987, street_name: Star St, unit_no: 505, city: Nightcity, state: StateE, zip_code: 45678, max_capacity: 600, contact_email: contact@starlightballroom.com, contact_phone: 4567890123'),(26,'Oceanfront Pavilion','insert','2023-12-08 23:14:38','venue_name: Oceanfront Pavilion, street_no: 123, street_name: Beach Blvd, unit_no: 606, city: Seaside, state: StateF, zip_code: 56789, max_capacity: 450, contact_email: info@oceanfrontpavilion.com, contact_phone: 5678901234'),(27,'City Center Convention Hall','insert','2023-12-08 23:14:38','venue_name: City Center Convention Hall, street_no: 456, street_name: Central Ave, unit_no: 707, city: Downtown, state: StateG, zip_code: 67890, max_capacity: 1200, contact_email: contact@citycenterconvention.com, contact_phone: 6789012345'),(28,'Forest Lodge','insert','2023-12-08 23:14:38','venue_name: Forest Lodge, street_no: 789, street_name: Woodland Rd, unit_no: 808, city: Forestville, state: StateH, zip_code: 78901, max_capacity: 300, contact_email: info@forestlodge.com, contact_phone: 7890123456'),(29,'Harbor View Gallery','insert','2023-12-08 23:14:38','venue_name: Harbor View Gallery, street_no: 321, street_name: Harbor Way, unit_no: 909, city: Portside, state: StateI, zip_code: 89012, max_capacity: 400, contact_email: contact@harborviewgallery.com, contact_phone: 8901234567'),(30,'Crystal Palace','insert','2023-12-08 23:14:38','venue_name: Crystal Palace, street_no: 654, street_name: Crystal Rd, unit_no: 1010, city: Gemtown, state: StateJ, zip_code: 90123, max_capacity: 550, contact_email: info@crystalpalace.com, contact_phone: 9012345678'),(31,'Spring Music Fest','insert','2023-12-08 23:14:38','event_name: Spring Music Fest, event_description: Annual Spring Music Festival, event_date: 2023-05-15, event_time: 18:00:00, event_status: scheduled, event_image_url: url_to_event_image, category_name: Music, venue_name: The Grand Hall'),(32,'Summer Art Exhibition','insert','2023-12-08 23:14:38','event_name: Summer Art Exhibition, event_description: Exhibition of contemporary art, event_date: 2023-07-20, event_time: 10:00:00, event_status: scheduled, event_image_url: url_to_art_image, category_name: Arts & Theatre, venue_name: City Center Convention Hall'),(33,'Tech Expo 2023','insert','2023-12-08 23:14:38','event_name: Tech Expo 2023, event_description: Technology and Innovation Expo, event_date: 2023-09-05, event_time: 09:00:00, event_status: scheduled, event_image_url: url_to_techexpo_image, category_name: Technology, venue_name: Mountain View Arena'),(34,'Marathon City Run','insert','2023-12-08 23:14:38','event_name: Marathon City Run, event_description: Annual marathon through the city, event_date: 2023-10-10, event_time: 07:00:00, event_status: scheduled, event_image_url: url_to_marathon_image, category_name: Sports, venue_name: Sunshine Auditorium'),(35,'Health and Wellness Fair','insert','2023-12-08 23:14:38','event_name: Health and Wellness Fair, event_description: Event focusing on health and wellness, event_date: 2023-08-15, event_time: 09:30:00, event_status: scheduled, event_image_url: url_to_healthfair_image, category_name: Health & Wellness, venue_name: Oceanfront Pavilion'),(36,'Culinary Delights Festival','insert','2023-12-08 23:14:38','event_name: Culinary Delights Festival, event_description: Festival showcasing local and international cuisine, event_date: 2023-06-18, event_time: 11:00:00, event_status: scheduled, event_image_url: url_to_culinaryfest_image, category_name: Food & Drink, venue_name: Harbor View Gallery'),(37,'Business Networking Event','insert','2023-12-08 23:14:38','event_name: Business Networking Event, event_description: Meet and connect with business professionals, event_date: 2023-11-25, event_time: 17:00:00, event_status: scheduled, event_image_url: url_to_networking_image, category_name: Business & Networking, venue_name: Riverside Theater'),(38,'Educational Workshop Series','insert','2023-12-08 23:14:38','event_name: Educational Workshop Series, event_description: Series of educational and skill-building workshops, event_date: 2023-12-05, event_time: 10:00:00, event_status: scheduled, event_image_url: url_to_workshop_image, category_name: Education, venue_name: Forest Lodge'),(39,'Winter Family Carnival','insert','2023-12-08 23:14:38','event_name: Winter Family Carnival, event_description: Fun and games for the entire family, event_date: 2023-12-15, event_time: 15:00:00, event_status: scheduled, event_image_url: url_to_carnival_image, category_name: Family, venue_name: Starlight Ballroom'),(40,'Indie Film Nights','insert','2023-12-08 23:14:38','event_name: Indie Film Nights, event_description: Screening of independent films, event_date: 2023-08-30, event_time: 19:00:00, event_status: scheduled, event_image_url: url_to_indiefilm_image, category_name: Arts & Theatre, venue_name: Crystal Palace'),(41,'1','insert','2023-12-08 23:14:38','order_date: 2023-02-11, payment_type: credit_card, payment_status: paid, total_amount: 0, user_id: 1, event_name: Spring Music Fest'),(42,'2','insert','2023-12-08 23:14:38','order_date: 2023-03-15, payment_type: debit_card, payment_status: paid, total_amount: 0, user_id: 2, event_name: Summer Art Exhibition'),(43,'3','insert','2023-12-08 23:14:38','order_date: 2023-04-20, payment_type: paypal, payment_status: pending, total_amount: 0, user_id: 3, event_name: Tech Expo 2023'),(44,'4','insert','2023-12-08 23:14:38','order_date: 2023-05-25, payment_type: credit_card, payment_status: paid, total_amount: 0, user_id: 4, event_name: Marathon City Run'),(45,'5','insert','2023-12-08 23:14:38','order_date: 2023-06-30, payment_type: other, payment_status: failed, total_amount: 0, user_id: 5, event_name: Health and Wellness Fair'),(46,'6','insert','2023-12-08 23:14:38','order_date: 2023-07-05, payment_type: debit_card, payment_status: paid, total_amount: 0, user_id: 6, event_name: Culinary Delights Festival'),(47,'7','insert','2023-12-08 23:14:38','order_date: 2023-08-10, payment_type: credit_card, payment_status: pending, total_amount: 0, user_id: 7, event_name: Business Networking Event'),(48,'8','insert','2023-12-08 23:14:38','order_date: 2023-09-15, payment_type: paypal, payment_status: paid, total_amount: 0, user_id: 8, event_name: Educational Workshop Series'),(49,'9','insert','2023-12-08 23:14:38','order_date: 2023-10-21, payment_type: credit_card, payment_status: paid, total_amount: 0, user_id: 9, event_name: Winter Family Carnival'),(50,'10','insert','2023-12-08 23:14:38','order_date: 2023-11-30, payment_type: debit_card, payment_status: paid, total_amount: 0, user_id: 10, event_name: Indie Film Nights'),(51,'1','update','2023-12-08 23:14:38','order_date: 2023-02-11, payment_type: credit_card, payment_status: paid, total_amount: 50, user_id: 1, event_name: Spring Music Fest'),(52,'1','insert','2023-12-08 23:14:38','ticket_price: 25, ticket_quantity: 2, start_sale_date: 2023-04-01, end_sale_date: 2023-05-01, event_name: Spring Music Fest, order_id: 1'),(53,'2','update','2023-12-08 23:14:38','order_date: 2023-03-15, payment_type: debit_card, payment_status: paid, total_amount: 120, user_id: 2, event_name: Summer Art Exhibition'),(54,'2','insert','2023-12-08 23:14:38','ticket_price: 30, ticket_quantity: 4, start_sale_date: 2023-06-01, end_sale_date: 2023-07-01, event_name: Summer Art Exhibition, order_id: 2'),(55,'3','update','2023-12-08 23:14:38','order_date: 2023-04-20, payment_type: paypal, payment_status: pending, total_amount: 50, user_id: 3, event_name: Tech Expo 2023'),(56,'3','insert','2023-12-08 23:14:38','ticket_price: 50, ticket_quantity: 1, start_sale_date: 2023-07-15, end_sale_date: 2023-09-01, event_name: Tech Expo 2023, order_id: 3'),(57,'4','update','2023-12-08 23:14:38','order_date: 2023-05-25, payment_type: credit_card, payment_status: paid, total_amount: 60, user_id: 4, event_name: Marathon City Run'),(58,'4','insert','2023-12-08 23:14:38','ticket_price: 20, ticket_quantity: 3, start_sale_date: 2023-09-10, end_sale_date: 2023-10-05, event_name: Marathon City Run, order_id: 4'),(59,'5','update','2023-12-08 23:14:38','order_date: 2023-06-30, payment_type: other, payment_status: failed, total_amount: 30, user_id: 5, event_name: Health and Wellness Fair'),(60,'5','insert','2023-12-08 23:14:38','ticket_price: 15, ticket_quantity: 2, start_sale_date: 2023-07-20, end_sale_date: 2023-08-10, event_name: Health and Wellness Fair, order_id: 5'),(61,'6','update','2023-12-08 23:14:38','order_date: 2023-07-05, payment_type: debit_card, payment_status: paid, total_amount: 200, user_id: 6, event_name: Culinary Delights Festival'),(62,'6','insert','2023-12-08 23:14:38','ticket_price: 40, ticket_quantity: 5, start_sale_date: 2023-05-25, end_sale_date: 2023-06-18, event_name: Culinary Delights Festival, order_id: 6'),(63,'7','update','2023-12-08 23:14:38','order_date: 2023-08-10, payment_type: credit_card, payment_status: pending, total_amount: 70, user_id: 7, event_name: Business Networking Event'),(64,'7','insert','2023-12-08 23:14:38','ticket_price: 35, ticket_quantity: 2, start_sale_date: 2023-10-20, end_sale_date: 2023-11-20, event_name: Business Networking Event, order_id: 7'),(65,'8','update','2023-12-08 23:14:38','order_date: 2023-09-15, payment_type: paypal, payment_status: paid, total_amount: 45, user_id: 8, event_name: Educational Workshop Series'),(66,'8','insert','2023-12-08 23:14:38','ticket_price: 45, ticket_quantity: 1, start_sale_date: 2023-11-01, end_sale_date: 2023-12-01, event_name: Educational Workshop Series, order_id: 8'),(67,'9','update','2023-12-08 23:14:38','order_date: 2023-10-21, payment_type: credit_card, payment_status: paid, total_amount: 100, user_id: 9, event_name: Winter Family Carnival'),(68,'9','insert','2023-12-08 23:14:38','ticket_price: 25, ticket_quantity: 4, start_sale_date: 2023-11-15, end_sale_date: 2023-12-10, event_name: Winter Family Carnival, order_id: 9'),(69,'10','update','2023-12-08 23:14:38','order_date: 2023-11-30, payment_type: debit_card, payment_status: paid, total_amount: 120, user_id: 10, event_name: Indie Film Nights'),(70,'10','insert','2023-12-08 23:14:38','ticket_price: 60, ticket_quantity: 2, start_sale_date: 2023-07-30, end_sale_date: 2023-08-25, event_name: Indie Film Nights, order_id: 10'),(71,'1&&Spring Music Fest','insert','2023-12-08 23:14:38','rating: 5, comment: Great event!, review_date: 2023-02-11, user_id: 1, event_name: Spring Music Fest'),(72,'2&&Summer Art Exhibition','insert','2023-12-08 23:14:38','rating: 4, comment: Really enjoyed the exhibition., review_date: 2023-07-21, user_id: 2, event_name: Summer Art Exhibition'),(73,'3&&Tech Expo 2023','insert','2023-12-08 23:14:38','rating: 3, comment: Interesting expo, but could be better., review_date: 2023-09-06, user_id: 3, event_name: Tech Expo 2023'),(74,'4&&Marathon City Run','insert','2023-12-08 23:14:38','rating: 5, comment: Loved the marathon! Well organized., review_date: 2023-10-11, user_id: 4, event_name: Marathon City Run'),(75,'5&&Health and Wellness Fair','insert','2023-12-08 23:14:38','rating: 2, comment: Fair was okay, not many activities., review_date: 2023-08-16, user_id: 5, event_name: Health and Wellness Fair'),(76,'6&&Culinary Delights Festival','insert','2023-12-08 23:14:38','rating: 5, comment: Amazing food, great atmosphere!, review_date: 2023-06-19, user_id: 6, event_name: Culinary Delights Festival'),(77,'7&&Business Networking Event','insert','2023-12-08 23:14:38','rating: 4, comment: Great networking opportunities., review_date: 2023-11-26, user_id: 7, event_name: Business Networking Event'),(78,'8&&Educational Workshop Series','insert','2023-12-08 23:14:38','rating: 5, comment: The workshops were very informative., review_date: 2023-12-06, user_id: 8, event_name: Educational Workshop Series'),(79,'9&&Winter Family Carnival','insert','2023-12-08 23:14:38','rating: 3, comment: Fun family event but quite crowded., review_date: 2023-12-16, user_id: 9, event_name: Winter Family Carnival'),(80,'10&&Indie Film Nights','insert','2023-12-08 23:14:38','rating: 4, comment: Loved the indie films, great selection., review_date: 2023-08-31, user_id: 10, event_name: Indie Film Nights'),(81,'Sponsor Inc','insert','2023-12-08 23:14:38','sponsor_name: Sponsor Inc, description: Leading Event Sponsor'),(82,'Tech Giants','insert','2023-12-08 23:14:38','sponsor_name: Tech Giants, description: Technology and Innovation Leaders'),(83,'HealthFirst','insert','2023-12-08 23:14:38','sponsor_name: HealthFirst, description: Healthcare and Wellness Sponsor'),(84,'EduMinds','insert','2023-12-08 23:14:38','sponsor_name: EduMinds, description: Education and Learning Sponsor'),(85,'Green Earth','insert','2023-12-08 23:14:38','sponsor_name: Green Earth, description: Eco-friendly Initiatives and Sustainability'),(86,'Foodie Heaven','insert','2023-12-08 23:14:38','sponsor_name: Foodie Heaven, description: Culinary Arts and Food Festivals'),(87,'BizNetwork','insert','2023-12-08 23:14:38','sponsor_name: BizNetwork, description: Business Networking and Corporate Events'),(88,'Sportify','insert','2023-12-08 23:14:38','sponsor_name: Sportify, description: Sports Events and Athletic Sponsor'),(89,'Artistic Minds','insert','2023-12-08 23:14:38','sponsor_name: Artistic Minds, description: Supporting Arts and Theatre'),(90,'Family Fun Time','insert','2023-12-08 23:14:38','sponsor_name: Family Fun Time, description: Family and Community Events'),(91,'Organiser Pro','insert','2023-12-08 23:14:38','organiser_name: Organiser Pro, organiser_email: contact@organiserpro.com, organiser_phone: 3213214321, organiser_description: Top Event Organiser'),(92,'Event Masters','insert','2023-12-08 23:14:38','organiser_name: Event Masters, organiser_email: info@eventmasters.com, organiser_phone: 4324325432, organiser_description: Expert in Corporate Event Planning'),(93,'Showtime Events','insert','2023-12-08 23:14:38','organiser_name: Showtime Events, organiser_email: contact@showtimeevents.com, organiser_phone: 5435436543, organiser_description: Specialists in Entertainment and Shows'),(94,'EduEvents','insert','2023-12-08 23:14:38','organiser_name: EduEvents, organiser_email: support@eduevents.com, organiser_phone: 6546547654, organiser_description: Focused on Educational and Workshop Events'),(95,'Health Horizons','insert','2023-12-08 23:14:38','organiser_name: Health Horizons, organiser_email: wellness@healthhorizons.com, organiser_phone: 7657658765, organiser_description: Health and Wellness Event Organisers'),(96,'Tech Conventions','insert','2023-12-08 23:14:38','organiser_name: Tech Conventions, organiser_email: tech@techconventions.com, organiser_phone: 8768769876, organiser_description: Organising Tech and Innovation Conferences'),(97,'Gourmet Gatherings','insert','2023-12-08 23:14:38','organiser_name: Gourmet Gatherings, organiser_email: hello@gourmetgatherings.com, organiser_phone: 9879870987, organiser_description: Food and Culinary Event Experts'),(98,'SportsMania Org','insert','2023-12-08 23:14:38','organiser_name: SportsMania Org, organiser_email: sports@sportsmaniaorg.com, organiser_phone: 0980981098, organiser_description: Organising Sports Events and Tournaments'),(99,'Artistic Ventures','insert','2023-12-08 23:14:38','organiser_name: Artistic Ventures, organiser_email: arts@artisticventures.com, organiser_phone: 1091092109, organiser_description: Art and Theatre Event Specialists'),(100,'Family Fest Organisers','insert','2023-12-08 23:14:38','organiser_name: Family Fest Organisers, organiser_email: family@familyfestorganisers.com, organiser_phone: 2102103210, organiser_description: Creating Memorable Family Events'),(101,'1&&Spring Music Fest','insert','2023-12-08 23:14:38','notification_text: New event Spring Music Fest is available!, notification_date: 2023-09-15, event_name: Spring Music Fest'),(102,'2&&Summer Art Exhibition','insert','2023-12-08 23:14:38','notification_text: Summer Art Exhibition tickets now on sale!, notification_date: 2023-06-01, event_name: Summer Art Exhibition'),(103,'3&&Tech Expo 2023','insert','2023-12-08 23:14:38','notification_text: Tech Expo 2023 coming this fall, notification_date: 2023-08-20, event_name: Tech Expo 2023'),(104,'4&&Marathon City Run','insert','2023-12-08 23:14:38','notification_text: Join us for the Marathon City Run!, notification_date: 2023-09-05, event_name: Marathon City Run'),(105,'5&&Health and Wellness Fair','insert','2023-12-08 23:14:38','notification_text: Health and Wellness Fair this weekend, notification_date: 2023-07-10, event_name: Health and Wellness Fair'),(106,'6&&Culinary Delights Festival','insert','2023-12-08 23:14:38','notification_text: Don’t miss the Culinary Delights Festival, notification_date: 2023-05-15, event_name: Culinary Delights Festival'),(107,'7&&Business Networking Event','insert','2023-12-08 23:14:38','notification_text: Network at the Business Networking Event, notification_date: 2023-10-30, event_name: Business Networking Event'),(108,'8&&Educational Workshop Series','insert','2023-12-08 23:14:38','notification_text: Register for Educational Workshop Series, notification_date: 2023-11-10, event_name: Educational Workshop Series'),(109,'9&&Winter Family Carnival','insert','2023-12-08 23:14:38','notification_text: Winter Family Carnival - Fun for all ages, notification_date: 2023-11-25, event_name: Winter Family Carnival'),(110,'10&&Indie Film Nights','insert','2023-12-08 23:14:38','notification_text: Experience unique films at Indie Film Nights, notification_date: 2023-08-01, event_name: Indie Film Nights'),(111,'1&&1','insert','2023-12-08 23:14:38','priority: medium, notification_id: 1, user_id: 1'),(112,'2&&2','insert','2023-12-08 23:14:38','priority: high, notification_id: 2, user_id: 2'),(113,'3&&3','insert','2023-12-08 23:14:38','priority: low, notification_id: 3, user_id: 3'),(114,'4&&4','insert','2023-12-08 23:14:38','priority: medium, notification_id: 4, user_id: 4'),(115,'5&&5','insert','2023-12-08 23:14:38','priority: high, notification_id: 5, user_id: 5'),(116,'6&&6','insert','2023-12-08 23:14:38','priority: low, notification_id: 6, user_id: 6'),(117,'7&&7','insert','2023-12-08 23:14:38','priority: medium, notification_id: 7, user_id: 7'),(118,'8&&8','insert','2023-12-08 23:14:38','priority: high, notification_id: 8, user_id: 8'),(119,'9&&9','insert','2023-12-08 23:14:38','priority: low, notification_id: 9, user_id: 9'),(120,'10&&10','insert','2023-12-08 23:14:38','priority: medium, notification_id: 10, user_id: 10'),(121,'1&&Spring Music Fest','insert','2023-12-08 23:14:38','user_id: 1, event_name: Spring Music Fest'),(122,'2&&Summer Art Exhibition','insert','2023-12-08 23:14:38','user_id: 2, event_name: Summer Art Exhibition'),(123,'3&&Tech Expo 2023','insert','2023-12-08 23:14:38','user_id: 3, event_name: Tech Expo 2023'),(124,'4&&Marathon City Run','insert','2023-12-08 23:14:38','user_id: 4, event_name: Marathon City Run'),(125,'5&&Health and Wellness Fair','insert','2023-12-08 23:14:38','user_id: 5, event_name: Health and Wellness Fair'),(126,'6&&Culinary Delights Festival','insert','2023-12-08 23:14:38','user_id: 6, event_name: Culinary Delights Festival'),(127,'7&&Business Networking Event','insert','2023-12-08 23:14:38','user_id: 7, event_name: Business Networking Event'),(128,'8&&Educational Workshop Series','insert','2023-12-08 23:14:38','user_id: 8, event_name: Educational Workshop Series'),(129,'9&&Winter Family Carnival','insert','2023-12-08 23:14:38','user_id: 9, event_name: Winter Family Carnival'),(130,'10&&Indie Film Nights','insert','2023-12-08 23:14:38','user_id: 10, event_name: Indie Film Nights'),(131,'Sponsor Inc','update','2023-12-08 23:14:38','sponsor_name: Sponsor Inc, description: Leading Event Sponsor'),(132,'Spring Music Fest&&Sponsor Inc','insert','2023-12-08 23:14:38','sponsor_name: Sponsor Inc, sponsorship_amount: 5000, event_name: Spring Music Fest'),(133,'Tech Giants','update','2023-12-08 23:14:38','sponsor_name: Tech Giants, description: Technology and Innovation Leaders'),(134,'Summer Art Exhibition&&Tech Giants','insert','2023-12-08 23:14:38','sponsor_name: Tech Giants, sponsorship_amount: 4000, event_name: Summer Art Exhibition'),(135,'Tech Giants','update','2023-12-08 23:14:38','sponsor_name: Tech Giants, description: Technology and Innovation Leaders'),(136,'Tech Expo 2023&&Tech Giants','insert','2023-12-08 23:14:38','sponsor_name: Tech Giants, sponsorship_amount: 6000, event_name: Tech Expo 2023'),(137,'HealthFirst','update','2023-12-08 23:14:38','sponsor_name: HealthFirst, description: Healthcare and Wellness Sponsor'),(138,'Marathon City Run&&HealthFirst','insert','2023-12-08 23:14:38','sponsor_name: HealthFirst, sponsorship_amount: 3000, event_name: Marathon City Run'),(139,'HealthFirst','update','2023-12-08 23:14:38','sponsor_name: HealthFirst, description: Healthcare and Wellness Sponsor'),(140,'Health and Wellness Fair&&HealthFirst','insert','2023-12-08 23:14:38','sponsor_name: HealthFirst, sponsorship_amount: 2500, event_name: Health and Wellness Fair'),(141,'Foodie Heaven','update','2023-12-08 23:14:38','sponsor_name: Foodie Heaven, description: Culinary Arts and Food Festivals'),(142,'Culinary Delights Festival&&Foodie Heaven','insert','2023-12-08 23:14:38','sponsor_name: Foodie Heaven, sponsorship_amount: 3500, event_name: Culinary Delights Festival'),(143,'BizNetwork','update','2023-12-08 23:14:38','sponsor_name: BizNetwork, description: Business Networking and Corporate Events'),(144,'Business Networking Event&&BizNetwork','insert','2023-12-08 23:14:38','sponsor_name: BizNetwork, sponsorship_amount: 4500, event_name: Business Networking Event'),(145,'EduMinds','update','2023-12-08 23:14:38','sponsor_name: EduMinds, description: Education and Learning Sponsor'),(146,'Educational Workshop Series&&EduMinds','insert','2023-12-08 23:14:38','sponsor_name: EduMinds, sponsorship_amount: 5000, event_name: Educational Workshop Series'),(147,'Family Fun Time','update','2023-12-08 23:14:38','sponsor_name: Family Fun Time, description: Family and Community Events'),(148,'Winter Family Carnival&&Family Fun Time','insert','2023-12-08 23:14:38','sponsor_name: Family Fun Time, sponsorship_amount: 2000, event_name: Winter Family Carnival'),(149,'Artistic Minds','update','2023-12-08 23:14:38','sponsor_name: Artistic Minds, description: Supporting Arts and Theatre'),(150,'Indie Film Nights&&Artistic Minds','insert','2023-12-08 23:14:38','sponsor_name: Artistic Minds, sponsorship_amount: 3000, event_name: Indie Film Nights'),(151,'Spring Music Fest&&Organiser Pro','insert','2023-12-08 23:14:38','organiser_name: Organiser Pro, event_name: Spring Music Fest'),(152,'Summer Art Exhibition&&Event Masters','insert','2023-12-08 23:14:38','organiser_name: Event Masters, event_name: Summer Art Exhibition'),(153,'Tech Expo 2023&&Tech Conventions','insert','2023-12-08 23:14:38','organiser_name: Tech Conventions, event_name: Tech Expo 2023'),(154,'Marathon City Run&&SportsMania Org','insert','2023-12-08 23:14:38','organiser_name: SportsMania Org, event_name: Marathon City Run'),(155,'Health and Wellness Fair&&Health Horizons','insert','2023-12-08 23:14:38','organiser_name: Health Horizons, event_name: Health and Wellness Fair'),(156,'Culinary Delights Festival&&Gourmet Gatherings','insert','2023-12-08 23:14:38','organiser_name: Gourmet Gatherings, event_name: Culinary Delights Festival'),(157,'Business Networking Event&&Artistic Ventures','insert','2023-12-08 23:14:38','organiser_name: Artistic Ventures, event_name: Business Networking Event'),(158,'Educational Workshop Series&&EduEvents','insert','2023-12-08 23:14:38','organiser_name: EduEvents, event_name: Educational Workshop Series'),(159,'Winter Family Carnival&&Family Fest Organisers','insert','2023-12-08 23:14:38','organiser_name: Family Fest Organisers, event_name: Winter Family Carnival'),(160,'Indie Film Nights&&Showtime Events','insert','2023-12-08 23:14:38','organiser_name: Showtime Events, event_name: Indie Film Nights'),(161,'1&&Indie Film Nights','insert','2023-12-08 23:14:38','user_id: 1, event_name: Indie Film Nights'),(162,'2&&Tech Expo 2023','insert','2023-12-08 23:14:38','user_id: 2, event_name: Tech Expo 2023'),(163,'3&&Business Networking Event','insert','2023-12-08 23:14:38','user_id: 3, event_name: Business Networking Event'),(164,'4&&Health and Wellness Fair','insert','2023-12-08 23:14:38','user_id: 4, event_name: Health and Wellness Fair'),(165,'5&&Culinary Delights Festival','insert','2023-12-08 23:14:38','user_id: 5, event_name: Culinary Delights Festival');
/*!40000 ALTER TABLE `UserLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `userlogview`
--

DROP TABLE IF EXISTS `userlogview`;
/*!50001 DROP VIEW IF EXISTS `userlogview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `userlogview` AS SELECT 
 1 AS `log_id`,
 1 AS `general_id`,
 1 AS `action_type`,
 1 AS `action_timestamp`,
 1 AS `details`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `sex` enum('male','female','other') NOT NULL DEFAULT 'female',
  `contact_phone` varchar(20) DEFAULT NULL,
  `street_no` int DEFAULT NULL,
  `street_name` varchar(255) DEFAULT NULL,
  `unit_no` int DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip_code` varchar(10) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `profile_picture_url` varchar(255) DEFAULT NULL,
  `role` enum('admin','user','organizer') NOT NULL DEFAULT 'user',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_users_username` (`username`),
  KEY `idx_users_email` (`email`),
  KEY `idx_users_role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'johndoe','johndoe@example.com','hashed_password','John','Doe','1990-01-01','male','1234567890',123,'Main St',1,'Anytown','Anystate','12345','Country','url_to_picture','user','active'),(2,'vandit','vandit@example.com','hashed_pwd','Vandit','Gupta','1999-02-22','male','1234567890',123,'Washington St',3,'town','state','02210','USA','url','user','active'),(3,'emilyross','emilyross@example.com','hashed_password123','Emily','Ross','1985-07-12','female','2345678901',321,'Pine St',10,'Springfield','StateX','54321','CountryX','url_to_emilypic','user','active'),(4,'alexsmith','alexsmith@example.com','hashed_password456','Alex','Smith','1992-05-30','male','3456789012',456,'Oak St',15,'Rivertown','StateY','65432','CountryY','url_to_alexpic','admin','active'),(5,'sarahlee','sarahlee@example.com','hashed_password789','Sarah','Lee','1988-11-23','female','4567890123',789,'Elm St',20,'Laketown','StateZ','76543','CountryZ','url_to_sarahpic','user','inactive'),(6,'michaelbrown','michaelbrown@example.com','hashed_pwd_mike','Michael','Brown','1993-04-15','male','5678901234',147,'Maple St',25,'Hilltown','StateA','87654','CountryA','url_to_mikepic','user','active'),(7,'lucywhite','lucywhite@example.com','hashed_pwd_lucy','Lucy','White','1991-09-19','female','6789012345',258,'Birch St',30,'Forest City','StateB','98765','CountryB','url_to_lucypic','user','active'),(8,'davidthomas','davidthomas@example.com','hashed_pwd_dave','David','Thomas','1984-03-27','male','7890123456',369,'Cedar St',35,'Mountain View','StateC','11223','CountryC','url_to_davepic','user','inactive'),(9,'jenniferwilson','jenniferwilson@example.com','hashed_pwd_jenn','Jennifer','Wilson','1987-06-04','female','8901234567',741,'Aspen St',40,'Sunnyvale','StateD','22334','CountryD','url_to_jennpic','admin','active'),(10,'kevinmartin','kevinmartin@example.com','hashed_pwd_kevin','Kevin','Martin','1995-12-20','male','9012345678',852,'Willow St',45,'Beachside','StateE','33445','CountryE','url_to_kevinpic','user','active');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_user_insert` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_user_insert', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.user_id, 'registration', CONCAT('user_id: ', NEW.user_id, ', user_name: ', NEW.username));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_user_update` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_user_update', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.user_id, 'update', CONCAT('user_id: ', NEW.user_id, ', user_name: ', NEW.username));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_user_delete` AFTER DELETE ON `users` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_user_delete', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.user_id, 'delete', CONCAT('user_id: ', OLD.user_id, ', user_name: ', OLD.username));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `UsersRegisterForEvents`
--

DROP TABLE IF EXISTS `UsersRegisterForEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UsersRegisterForEvents` (
  `user_id` int NOT NULL,
  `event_name` varchar(255) NOT NULL,
  `registration_date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`event_name`),
  KEY `event_name` (`event_name`),
  KEY `idx_users_registerfor_events` (`user_id`,`event_name`),
  CONSTRAINT `usersregisterforevents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usersregisterforevents_ibfk_2` FOREIGN KEY (`event_name`) REFERENCES `Events` (`event_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UsersRegisterForEvents`
--

LOCK TABLES `UsersRegisterForEvents` WRITE;
/*!40000 ALTER TABLE `UsersRegisterForEvents` DISABLE KEYS */;
INSERT INTO `UsersRegisterForEvents` VALUES (1,'Indie Film Nights','2023-09-19'),(1,'Spring Music Fest','2022-09-18'),(2,'Summer Art Exhibition','2023-06-01'),(2,'Tech Expo 2023','2023-06-02'),(3,'Business Networking Event','2023-08-16'),(3,'Tech Expo 2023','2023-08-15'),(4,'Health and Wellness Fair','2023-09-02'),(4,'Marathon City Run','2023-09-01'),(5,'Culinary Delights Festival','2023-07-06'),(5,'Health and Wellness Fair','2023-07-05'),(6,'Culinary Delights Festival','2023-05-10'),(7,'Business Networking Event','2023-10-20'),(8,'Educational Workshop Series','2023-11-05'),(9,'Winter Family Carnival','2023-11-20'),(10,'Indie Film Nights','2023-08-01');
/*!40000 ALTER TABLE `UsersRegisterForEvents` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_user_event_insert` AFTER INSERT ON `usersregisterforevents` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_message, error_context)
        VALUES ('after_user_event_insert', 'Error occurred', CONCAT('user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.event_name), 'insert', CONCAT('user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_user_event_update` AFTER UPDATE ON `usersregisterforevents` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_message, error_context)
        VALUES ('after_user_event_update', 'Error occurred', CONCAT('user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(NEW.user_id, '&&', NEW.event_name), 'update', CONCAT('user_id: ', NEW.user_id, ', event_name: ', NEW.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_user_event_delete` AFTER DELETE ON `usersregisterforevents` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_message, error_context)
        VALUES ('after_user_event_delete', 'Error occurred', CONCAT('user_id: ', OLD.user_id, ', event_name: ', OLD.event_name));
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (CONCAT(OLD.user_id, '&&', OLD.event_name), 'delete', CONCAT('user_id: ', OLD.user_id, ', event_name: ', OLD.event_name));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `usersregisterforeventsview`
--

DROP TABLE IF EXISTS `usersregisterforeventsview`;
/*!50001 DROP VIEW IF EXISTS `usersregisterforeventsview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usersregisterforeventsview` AS SELECT 
 1 AS `user_id`,
 1 AS `event_name`,
 1 AS `registration_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `usersview`
--

DROP TABLE IF EXISTS `usersview`;
/*!50001 DROP VIEW IF EXISTS `usersview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usersview` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `email`,
 1 AS `password`,
 1 AS `first_name`,
 1 AS `last_name`,
 1 AS `date_of_birth`,
 1 AS `sex`,
 1 AS `contact_phone`,
 1 AS `street_no`,
 1 AS `street_name`,
 1 AS `unit_no`,
 1 AS `city`,
 1 AS `state`,
 1 AS `zip_code`,
 1 AS `country`,
 1 AS `profile_picture_url`,
 1 AS `role`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Venues`
--

DROP TABLE IF EXISTS `Venues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Venues` (
  `venue_name` varchar(255) NOT NULL,
  `street_no` int DEFAULT NULL,
  `street_name` varchar(255) DEFAULT NULL,
  `unit_no` int DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip_code` int DEFAULT NULL,
  `max_capacity` int DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`venue_name`),
  CONSTRAINT `venues_chk_1` CHECK ((`max_capacity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Venues`
--

LOCK TABLES `Venues` WRITE;
/*!40000 ALTER TABLE `Venues` DISABLE KEYS */;
INSERT INTO `Venues` VALUES ('City Center Convention Hall',456,'Central Ave',707,'Downtown','StateG',67890,1200,'contact@citycenterconvention.com','6789012345'),('Crystal Palace',654,'Crystal Rd',1010,'Gemtown','StateJ',90123,550,'info@crystalpalace.com','9012345678'),('Forest Lodge',789,'Woodland Rd',808,'Forestville','StateH',78901,300,'info@forestlodge.com','7890123456'),('Harbor View Gallery',321,'Harbor Way',909,'Portside','StateI',89012,400,'contact@harborviewgallery.com','8901234567'),('Mountain View Arena',654,'Highland Ave',404,'Hilltown','StateD',34567,1000,'info@mountainviewarena.com','3456789012'),('Oceanfront Pavilion',123,'Beach Blvd',606,'Seaside','StateF',56789,450,'info@oceanfrontpavilion.com','5678901234'),('Riverside Theater',789,'River Rd',202,'Lakeside','StateB',12345,350,'info@riversidetheater.com','1234567890'),('Starlight Ballroom',987,'Star St',505,'Nightcity','StateE',45678,600,'contact@starlightballroom.com','4567890123'),('Sunshine Auditorium',321,'Sunset Blvd',303,'Sunnyville','StateC',23456,750,'contact@sunshineauditorium.com','2345678901'),('The Grand Hall',456,'Broadway',101,'Metropolis','State',67890,500,'contact@grandhall.com','0987654321');
/*!40000 ALTER TABLE `Venues` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_venue_insert` AFTER INSERT ON `venues` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_venue_insert', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.venue_name, 'insert', CONCAT('venue_name: ', NEW.venue_name, ', street_no: ', NEW.street_no, ', street_name: ', NEW.street_name, ', unit_no: ', NEW.unit_no, ', city: ', NEW.city, ', state: ', NEW.state, ', zip_code: ', NEW.zip_code, ', max_capacity: ', NEW.max_capacity, ', contact_email: ', NEW.contact_email, ', contact_phone: ', NEW.contact_phone));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_venue_update` AFTER UPDATE ON `venues` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_venue_update', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (NEW.venue_name, 'update', CONCAT('venue_name: ', NEW.venue_name, ', street_no: ', NEW.street_no, ', street_name: ', NEW.street_name, ', unit_no: ', NEW.unit_no, ', city: ', NEW.city, ', state: ', NEW.state, ', zip_code: ', NEW.zip_code, ', max_capacity: ', NEW.max_capacity, ', contact_email: ', NEW.contact_email, ', contact_phone: ', NEW.contact_phone));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_venue_delete` AFTER DELETE ON `venues` FOR EACH ROW BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        INSERT INTO eventbuzz.ErrorLog (error_source, error_message)
        VALUES ('after_venue_delete', 'Error occurred');
    END;
    INSERT INTO eventbuzz.UserLog (general_id, action_type, details)
    VALUES (OLD.venue_name, 'delete', CONCAT('venue_name: ', OLD.venue_name, ', street_no: ', OLD.street_no, ', street_name: ', OLD.street_name, ', unit_no: ', OLD.unit_no, ', city: ', OLD.city, ', state: ', OLD.state, ', zip_code: ', OLD.zip_code, ', max_capacity: ', OLD.max_capacity, ', contact_email: ', OLD.contact_email, ', contact_phone: ', OLD.contact_phone));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `venuesview`
--

DROP TABLE IF EXISTS `venuesview`;
/*!50001 DROP VIEW IF EXISTS `venuesview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `venuesview` AS SELECT 
 1 AS `venue_name`,
 1 AS `street_no`,
 1 AS `street_name`,
 1 AS `unit_no`,
 1 AS `city`,
 1 AS `state`,
 1 AS `zip_code`,
 1 AS `max_capacity`,
 1 AS `contact_email`,
 1 AS `contact_phone`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'eventbuzz'
--

--
-- Dumping routines for database 'eventbuzz'
--
/*!50003 DROP FUNCTION IF EXISTS `CalculateAge` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateAge`(birthDate DATE) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE currentDate DATE;
    SET currentDate = CURDATE();
    IF birthDate IS NULL OR birthDate > currentDate THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid birth date';
    END IF;
    RETURN TIMESTAMPDIFF(YEAR, birthDate, currentDate);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CalculateDuration` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateDuration`(startDateTime DATETIME, endDateTime DATETIME) RETURNS int
    DETERMINISTIC
BEGIN
    IF startDateTime IS NULL OR endDateTime IS NULL OR endDateTime < startDateTime THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid start or end date or start-date greater than end-date';
    END IF;
    RETURN TIMESTAMPDIFF(HOUR, startDateTime, endDateTime);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CalculateNumberOfEventsBooked` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateNumberOfEventsBooked`(userId INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE numberOfEventsBooked INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT COUNT(*) FROM UsersRegisterForEvents WHERE user_id = userId;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO numberOfEventsBooked;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur;
    RETURN numberOfEventsBooked;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CalculateNumberOfOrganizers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateNumberOfOrganizers`(eventName VARCHAR(255)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE numberOfOrganizers INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT COUNT(*) FROM EventsOrganisedByOrganisers WHERE event_name = eventName;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO numberOfOrganizers;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur;
    RETURN numberOfOrganizers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CalculateNumberOfPaymentsDone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateNumberOfPaymentsDone`(paymentType VARCHAR(255)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE numberOfPaymentsDone INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT COUNT(*) FROM Orders WHERE payment_type = paymentType;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO numberOfPaymentsDone;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur;
    RETURN numberOfPaymentsDone;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CalculateNumberOfTimesVenueBooked` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateNumberOfTimesVenueBooked`(venueName VARCHAR(255)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE numberOfTimesVenueBooked INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT COUNT(*) FROM Events WHERE venue_name = venueName;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO numberOfTimesVenueBooked;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur;
    RETURN numberOfTimesVenueBooked;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CalculateTotalAmount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateTotalAmount`(userId INT) RETURNS double
    DETERMINISTIC
BEGIN
    DECLARE totalAmount DOUBLE DEFAULT 0;
    DECLARE ticketPrice DOUBLE DEFAULT 0;
    DECLARE ticketQuantity INT DEFAULT 0;
    DECLARE eventId INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT ticket_price, ticket_quantity, event_name FROM Tickets WHERE order_id IN (SELECT order_id FROM Orders WHERE user_id = userId);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO ticketPrice, ticketQuantity, eventId;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET totalAmount = totalAmount + (ticketPrice * ticketQuantity);
    END LOOP;
    CLOSE cur;
    RETURN totalAmount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CalculateTotalAmountSponsorSpends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CalculateTotalAmountSponsorSpends`(sponsorName VARCHAR(255)) RETURNS double
    DETERMINISTIC
BEGIN
    DECLARE totalAmountSpent DOUBLE DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT SUM(sponsorship_amount) FROM EventsFundedBySponsors WHERE sponsor_name = sponsorName;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO totalAmountSpent;
        IF done THEN
            LEAVE read_loop;
        END IF;
    END LOOP;
    CLOSE cur;
    RETURN totalAmountSpent;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteEvent`(
    IN p_event_name VARCHAR(255)
)
BEGIN
    DELETE FROM Events WHERE event_name = p_event_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteEventCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteEventCategory`(
    IN p_category_name VARCHAR(50)
)
BEGIN
    DELETE FROM EventCategories WHERE category_name = p_category_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteEventFundedBySponsors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteEventFundedBySponsors`(
    IN p_event_name VARCHAR(255),
    IN p_sponsor_name VARCHAR(255)
)
BEGIN
    DELETE FROM EventsFundedBySponsors WHERE event_name = p_event_name AND sponsor_name = p_sponsor_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteEventOrganisedByOrganisers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteEventOrganisedByOrganisers`(
    IN p_event_name VARCHAR(255),
    IN p_organiser_name VARCHAR(255)
)
BEGIN
    DELETE FROM EventsOrganisedByOrganisers WHERE event_name = p_event_name AND organiser_name = p_organiser_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteNotification`(
    IN p_notification_id INT
)
BEGIN
    DELETE FROM Notifications WHERE notification_id = p_notification_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteNotificationSendToUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteNotificationSendToUsers`(
    IN p_user_id INT,
    IN p_notification_id INT
)
BEGIN
    DELETE FROM NotificationsSendToUsers WHERE user_id = p_user_id AND notification_id = p_notification_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteOrder`(
    IN p_order_id INT
)
BEGIN
    DELETE FROM Orders WHERE order_id = p_order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteOrganiser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteOrganiser`(
    IN p_organiser_name VARCHAR(255)
)
BEGIN
    DELETE FROM Organisers WHERE organiser_name = p_organiser_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteReview` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteReview`(
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    DELETE FROM Reviews WHERE user_id = p_user_id AND event_name = p_event_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteSponsor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteSponsor`(
    IN p_sponsor_name VARCHAR(255)
)
BEGIN
    DELETE FROM Sponsors WHERE sponsor_name = p_sponsor_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteTicket`(
    IN p_ticket_id INT
)
BEGIN
    DELETE FROM Tickets WHERE ticket_id = p_ticket_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser`(
    IN p_user_id INT
)
BEGIN
    DELETE FROM Users WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteUserRegisterForEvents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUserRegisterForEvents`(
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    DELETE FROM UsersRegisterForEvents WHERE user_id = p_user_id AND event_name = p_event_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteVenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteVenue`(
    IN p_venue_name VARCHAR(255)
)
BEGIN
    DELETE FROM Venues WHERE venue_name = p_venue_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GenerateEventSummary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateEventSummary`(eventName VARCHAR(255))
BEGIN

    IF eventName IS NULL OR eventName = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Event name is not valid';
    END IF;
    SELECT 
        (SELECT COUNT(*) FROM Orders WHERE event_name = eventName) AS TotalAttendees,
        (SELECT SUM(total_amount) FROM Orders WHERE event_name = eventName) AS TotalRevenue,
        (SELECT COUNT(*) FROM Tickets WHERE event_name = eventName) AS TotalTicketsSold,
        (SELECT SUM(ticket_quantity) FROM Tickets WHERE event_name = eventName) AS TotalTickets,
        (SELECT COUNT(*) FROM Reviews WHERE event_name = eventName) AS TotalReviews,
        (SELECT AVG(rating) FROM Reviews WHERE event_name = eventName) AS AverageRating,
        (SELECT COUNT(*) FROM Notifications WHERE event_name = eventName) AS TotalNotifications,
        (SELECT COUNT(*) FROM UsersRegisterForEvents WHERE event_name = eventName) AS TotalRegistrations,
        (SELECT COUNT(*) FROM EventsFundedBySponsors WHERE event_name = eventName) AS TotalSponsors,
        (SELECT SUM(sponsorship_amount) FROM EventsFundedBySponsors WHERE event_name = eventName) AS TotalSponsorshipAmount,
        (SELECT COUNT(*) FROM EventsOrganisedByOrganisers WHERE event_name = eventName) AS TotalOrganisers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetErrorLog` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetErrorLog`()
BEGIN
    SELECT * FROM ErrorLog;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEventCategories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEventCategories`()
BEGIN
    SELECT * FROM EventCategories;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEvents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEvents`()
BEGIN
    SELECT * FROM Events;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEventsFundedBySponsors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEventsFundedBySponsors`()
BEGIN
    SELECT * FROM EventsFundedBySponsors;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEventsOrganisedByOrganisers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetEventsOrganisedByOrganisers`()
BEGIN
    SELECT * FROM EventsOrganisedByOrganisers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetNotifications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetNotifications`()
BEGIN
    SELECT * FROM Notifications;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetNotificationsSendToUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetNotificationsSendToUsers`()
BEGIN
    SELECT * FROM NotificationsSendToUsers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrders`()
BEGIN
    SELECT * FROM Orders;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetOrganisers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOrganisers`()
BEGIN
    SELECT * FROM Organisers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetReviews` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetReviews`()
BEGIN
    SELECT * FROM Reviews;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetSponsors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSponsors`()
BEGIN
    SELECT * FROM Sponsors;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetTickets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetTickets`()
BEGIN
    SELECT * FROM Tickets;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserLog` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserLog`()
BEGIN
    SELECT * FROM UserLog;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUsers`()
BEGIN
    SELECT * FROM Users;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUsersRegisterForEvents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUsersRegisterForEvents`()
BEGIN
    SELECT * FROM UsersRegisterForEvents;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetVenues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetVenues`()
BEGIN
    SELECT * FROM Venues;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertEvent`(
    IN p_event_name VARCHAR(255),
    IN p_event_description VARCHAR(255),
    IN p_event_date VARCHAR(255),
    IN p_event_time VARCHAR(255),
    IN p_event_status ENUM('scheduled', 'cancelled', 'completed'),
    IN p_event_image_url VARCHAR(255),
    IN p_category_name VARCHAR(50),
    IN p_venue_name VARCHAR(255)
)
BEGIN
    INSERT INTO Events (
        event_name,
        event_description,
        event_date,
        event_time,
        event_status,
        event_image_url,
        category_name,
        venue_name
    ) VALUES (
        p_event_name,
        p_event_description,
        p_event_date,
        p_event_time,
        p_event_status,
        p_event_image_url,
        p_category_name,
        p_venue_name
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertEventCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertEventCategory`(
    IN p_category_name VARCHAR(50),
    IN p_description VARCHAR(255)
)
BEGIN
    INSERT INTO EventCategories (
        category_name,
        description
    ) VALUES (
        p_category_name,
        p_description
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertEventFundedBySponsors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertEventFundedBySponsors`(
    IN p_event_name VARCHAR(255),
    IN p_sponsor_name VARCHAR(255),
    IN p_sponsorship_amount DOUBLE,
    IN p_sponsorship_date VARCHAR(255)
)
BEGIN
    INSERT INTO EventsFundedBySponsors (
        event_name,
        sponsor_name,
        sponsorship_amount,
        sponsorship_date
    ) VALUES (
        p_event_name,
        p_sponsor_name,
        p_sponsorship_amount,
        p_sponsorship_date
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertEventOrganisedByOrganisers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertEventOrganisedByOrganisers`(
    IN p_event_name VARCHAR(255),
    IN p_organiser_name VARCHAR(255),
    IN p_organiser_role VARCHAR(100)
)
BEGIN
    INSERT INTO EventsOrganisedByOrganisers (
        event_name,
        organiser_name,
        organiser_role
    ) VALUES (
        p_event_name,
        p_organiser_name,
        p_organiser_role
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNotification`(
    IN p_notification_id INT,
    IN p_notification_text VARCHAR(255),
    IN p_notification_date VARCHAR(255),
    IN p_event_name VARCHAR(255)
)
BEGIN
    INSERT INTO Notifications (
        notification_id,
        notification_text,
        notification_date,
        event_name
    ) VALUES (
        p_notification_id,
        p_notification_text,
        p_notification_date,
        p_event_name
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertNotificationSendToUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNotificationSendToUsers`(
    IN p_user_id INT,
    IN p_notification_id INT,
    IN p_priority ENUM('high', 'medium', 'low')
)
BEGIN
    INSERT INTO NotificationsSendToUsers (
        user_id,
        notification_id,
        priority
    ) VALUES (
        p_user_id,
        p_notification_id,
        p_priority
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertOrder`(
    IN p_order_id INT,
    IN p_order_date VARCHAR(255),
    IN p_payment_type ENUM('credit_card', 'debit_card', 'paypal', 'other'),
    IN p_payment_status ENUM('paid', 'pending', 'failed'),
    IN total_amount DOUBLE,
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    INSERT INTO Orders (
        order_id,
        order_date,
        payment_type,
        payment_status,
        total_amount,
        user_id,
        event_name
    ) VALUES (
        p_order_id,
        p_order_date,
        p_payment_type,
        p_payment_status,
        total_amount,
        p_user_id,
        p_event_name
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertOrganiser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertOrganiser`(
    IN p_organiser_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_logo_url VARCHAR(255),
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20)
)
BEGIN
    INSERT INTO Organisers (
        organiser_name,
        description,
        logo_url,
        contact_email,
        contact_phone
    ) VALUES (
        p_organiser_name,
        p_description,
        p_logo_url,
        p_contact_email,
        p_contact_phone
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertReview` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertReview`(
    IN p_rating TINYINT,
    IN p_comment VARCHAR(255),
    IN p_review_date VARCHAR(255),
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    INSERT INTO Reviews (
        rating,
        comment,
        review_date,
        user_id,
        event_name
    ) VALUES (
        p_rating,
        p_comment,
        p_review_date,
        p_user_id,
        p_event_name
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertSponsor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertSponsor`(
    IN p_sponsor_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_website_url VARCHAR(255),
    IN p_logo_url VARCHAR(255),
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20),
    IN p_total_sponsorship_amount DOUBLE
)
BEGIN
    INSERT INTO Sponsors (
        sponsor_name,
        description,
        website_url,
        logo_url,
        contact_email,
        contact_phone,
        total_sponsorship_amount
    ) VALUES (
        p_sponsor_name,
        p_description,
        p_website_url,
        p_logo_url,
        p_contact_email,
        p_contact_phone,
        p_total_sponsorship_amount
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertTicket`(
    IN p_ticket_id INT,
    IN p_ticket_price DOUBLE,
    IN p_ticket_quantity INT,
    IN p_order_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    INSERT INTO Tickets (
        ticket_id,
        ticket_price,
        ticket_quantity,
        order_id,
        event_name
    ) VALUES (
        p_ticket_id,
        p_ticket_price,
        p_ticket_quantity,
        p_order_id,
        p_event_name
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertUser`(
    IN p_username VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_first_name VARCHAR(255),
    IN p_last_name VARCHAR(255),
    IN p_date_of_birth VARCHAR(255),
    IN p_sex ENUM('male', 'female', 'other'),
    IN p_contact_phone VARCHAR(20),
    IN p_street_no INT,
    IN p_street_name VARCHAR(255),
    IN p_unit_no INT,
    IN p_city VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_zip_code VARCHAR(10),
    IN p_country VARCHAR(255),
    IN p_profile_picture_url VARCHAR(255),
    IN p_role ENUM('admin', 'user', 'organizer'),
    IN p_status ENUM('active', 'inactive')
)
BEGIN
    INSERT INTO Users (
        username,
        email,
        password,
        first_name,
        last_name,
        date_of_birth,
        sex,
        contact_phone,
        street_no,
        street_name,
        unit_no,
        city,
        state,
        zip_code,
        country,
        profile_picture_url,
        role,
        status
    ) VALUES (
        p_username,
        p_email,
        p_password,
        p_first_name,
        p_last_name,
        p_date_of_birth,
        p_sex,
        p_contact_phone,
        p_street_no,
        p_street_name,
        p_unit_no,
        p_city,
        p_state,
        p_zip_code,
        p_country,
        p_profile_picture_url,
        p_role,
        p_status
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertUserRegisterForEvents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertUserRegisterForEvents`(
    IN p_user_id INT,
    IN p_event_name VARCHAR(255),
    IN p_registration_date VARCHAR(255)
)
BEGIN
    INSERT INTO UsersRegisterForEvents (
        user_id,
        event_name,
        registration_date
    ) VALUES (
        p_user_id,
        p_event_name,
        p_registration_date
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertVenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertVenue`(
    IN p_venue_name VARCHAR(255),
    IN p_street_no INT,
    IN p_street_name VARCHAR(255),
    IN p_unit_no INT,
    IN p_city VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_zip_code INT,
    IN p_max_capacity INT,
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20)
)
BEGIN
    INSERT INTO Venues (
        venue_name,
        street_no,
        street_name,
        unit_no,
        city,
        state,
        zip_code,
        max_capacity,
        contact_email,
        contact_phone
    ) VALUES (
        p_venue_name,
        p_street_no,
        p_street_name,
        p_unit_no,
        p_city,
        p_state,
        p_zip_code,
        p_max_capacity,
        p_contact_email,
        p_contact_phone
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateEvent`(
    IN p_event_name VARCHAR(255),
    IN p_event_description VARCHAR(255),
    IN p_event_date VARCHAR(255),
    IN p_event_time VARCHAR(255),
    IN p_event_status ENUM('scheduled', 'cancelled', 'completed'),
    IN p_event_image_url VARCHAR(255),
    IN p_category_name VARCHAR(50),
    IN p_venue_name VARCHAR(255)
)
BEGIN
    UPDATE Events SET
        event_description = p_event_description,
        event_date = p_event_date,
        event_time = p_event_time,
        event_status = p_event_status,
        event_image_url = p_event_image_url,
        category_name = p_category_name,
        venue_name = p_venue_name
    WHERE event_name = p_event_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateEventCategory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateEventCategory`(
    IN p_category_name VARCHAR(50),
    IN p_description VARCHAR(255)
)
BEGIN
    UPDATE EventCategories SET
        description = p_description
    WHERE category_name = p_category_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateEventFundedBySponsors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateEventFundedBySponsors`(
    IN p_event_name VARCHAR(255),
    IN p_sponsor_name VARCHAR(255),
    IN p_sponsorship_amount DOUBLE,
    IN p_sponsorship_date VARCHAR(255)
)
BEGIN
    UPDATE EventsFundedBySponsors SET
        sponsorship_amount = p_sponsorship_amount,
        sponsorship_date = p_sponsorship_date
    WHERE event_name = p_event_name AND sponsor_name = p_sponsor_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateEventOrganisedByOrganisers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateEventOrganisedByOrganisers`(
    IN p_event_name VARCHAR(255),
    IN p_organiser_name VARCHAR(255),
    IN p_organiser_role VARCHAR(100)
)
BEGIN
    UPDATE EventsOrganisedByOrganisers SET
        organiser_role = p_organiser_role
    WHERE event_name = p_event_name AND organiser_name = p_organiser_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateNotification`(
    IN p_notification_id INT,
    IN p_notification_text VARCHAR(255),
    IN p_notification_date VARCHAR(255),
    IN p_event_name VARCHAR(255)
)
BEGIN
    UPDATE Notifications SET
        notification_text = p_notification_text,
        notification_date = p_notification_date,
        event_name = p_event_name
    WHERE notification_id = p_notification_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateNotificationSendToUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateNotificationSendToUsers`(
    IN p_user_id INT,
    IN p_notification_id INT,
    IN p_priority ENUM('high', 'medium', 'low')
)
BEGIN
    UPDATE NotificationsSendToUsers SET
        priority = p_priority
    WHERE user_id = p_user_id AND notification_id = p_notification_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateOrder`(
    IN p_order_id INT,
    IN p_order_date VARCHAR(255),
    IN p_payment_type ENUM('credit_card', 'debit_card', 'paypal', 'other'),
    IN p_payment_status ENUM('paid', 'pending', 'failed'),
    IN total_amount DOUBLE,
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    UPDATE Orders SET
        order_date = p_order_date,
        payment_type = p_payment_type,
        payment_status = p_payment_status,
        total_amount = total_amount,
        user_id = p_user_id,
        event_name = p_event_name
    WHERE order_id = p_order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateOrganiser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateOrganiser`(
    IN p_organiser_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_logo_url VARCHAR(255),
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20)
)
BEGIN
    UPDATE Organisers SET
        description = p_description,
        logo_url = p_logo_url,
        contact_email = p_contact_email,
        contact_phone = p_contact_phone
    WHERE organiser_name = p_organiser_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateReview` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateReview`(
    IN p_rating TINYINT,
    IN p_comment VARCHAR(255),
    IN p_review_date VARCHAR(255),
    IN p_user_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    UPDATE Reviews SET
        rating = p_rating,
        comment = p_comment,
        review_date = p_review_date,
        user_id = p_user_id,
        event_name = p_event_name
    WHERE user_id = p_user_id AND event_name = p_event_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateSponsor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateSponsor`(
    IN p_sponsor_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_website_url VARCHAR(255),
    IN p_logo_url VARCHAR(255),
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20),
    IN p_total_sponsorship_amount DOUBLE
)
BEGIN
    UPDATE Sponsors SET
        description = p_description,
        website_url = p_website_url,
        logo_url = p_logo_url,
        contact_email = p_contact_email,
        contact_phone = p_contact_phone,
        total_sponsorship_amount = p_total_sponsorship_amount
    WHERE sponsor_name = p_sponsor_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateTicket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateTicket`(
    IN p_ticket_id INT,
    IN p_ticket_price DOUBLE,
    IN p_ticket_quantity INT,
    IN start_sale_date VARCHAR(255),
    IN end_sale_date VARCHAR(255),
    IN p_order_id INT,
    IN p_event_name VARCHAR(255)
)
BEGIN
    UPDATE Tickets SET
        ticket_price = p_ticket_price,
        ticket_quantity = p_ticket_quantity,
        start_sale_date = start_sale_date,
        end_sale_date = end_sale_date,
        order_id = p_order_id,
        event_name = p_event_name
    WHERE ticket_id = p_ticket_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUser`(
    IN p_user_id INT,
    IN p_username VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_first_name VARCHAR(255),
    IN p_last_name VARCHAR(255),
    IN p_date_of_birth VARCHAR(255),
    IN p_sex ENUM('male', 'female', 'other'),
    IN p_contact_phone VARCHAR(20),
    IN p_street_no INT,
    IN p_street_name VARCHAR(255),
    IN p_unit_no INT,
    IN p_city VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_zip_code VARCHAR(10),
    IN p_country VARCHAR(255),
    IN p_profile_picture_url VARCHAR(255),
    IN p_role ENUM('admin', 'user', 'organizer'),
    IN p_status ENUM('active', 'inactive')
)
BEGIN
    UPDATE Users SET
        username = p_username,
        email = p_email,
        first_name = p_first_name,
        last_name = p_last_name,
        date_of_birth = p_date_of_birth,
        sex = p_sex,
        contact_phone = p_contact_phone,
        street_no = p_street_no,
        street_name = p_street_name,
        unit_no = p_unit_no,
        city = p_city,
        state = p_state,
        zip_code = p_zip_code,
        country = p_country,
        profile_picture_url = p_profile_picture_url,
        role = p_role,
        status = p_status
    WHERE user_id = p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateUserRegisterForEvents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUserRegisterForEvents`(
    IN p_user_id INT,
    IN p_event_name VARCHAR(255),
    IN p_registration_date VARCHAR(255)
)
BEGIN
    UPDATE UsersRegisterForEvents SET
        registration_date = p_registration_date
    WHERE user_id = p_user_id AND event_name = p_event_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateVenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateVenue`(
    IN p_venue_name VARCHAR(255),
    IN p_street_no INT,
    IN p_street_name VARCHAR(255),
    IN p_unit_no INT,
    IN p_city VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_zip_code INT,
    IN p_max_capacity INT,
    IN p_contact_email VARCHAR(255),
    IN p_contact_phone VARCHAR(20)
)
BEGIN
    UPDATE Venues SET
        street_no = p_street_no,
        street_name = p_street_name,
        unit_no = p_unit_no,
        city = p_city,
        state = p_state,
        zip_code = p_zip_code,
        max_capacity = p_max_capacity,
        contact_email = p_contact_email,
        contact_phone = p_contact_phone
    WHERE venue_name = p_venue_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `errorlogview`
--

/*!50001 DROP VIEW IF EXISTS `errorlogview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `errorlogview` AS select `errorlog`.`error_id` AS `error_id`,`errorlog`.`error_timestamp` AS `error_timestamp`,`errorlog`.`error_source` AS `error_source`,`errorlog`.`error_message` AS `error_message`,`errorlog`.`error_context` AS `error_context`,`errorlog`.`user_id` AS `user_id`,`errorlog`.`event_name` AS `event_name`,`errorlog`.`additional_info` AS `additional_info` from `errorlog` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `eventcategoriesview`
--

/*!50001 DROP VIEW IF EXISTS `eventcategoriesview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `eventcategoriesview` AS select `eventcategories`.`category_name` AS `category_name`,`eventcategories`.`description` AS `description` from `eventcategories` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `eventsfundedbysponsorsview`
--

/*!50001 DROP VIEW IF EXISTS `eventsfundedbysponsorsview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `eventsfundedbysponsorsview` AS select `eventsfundedbysponsors`.`event_name` AS `event_name`,`eventsfundedbysponsors`.`sponsor_name` AS `sponsor_name`,`eventsfundedbysponsors`.`sponsorship_amount` AS `sponsorship_amount`,`eventsfundedbysponsors`.`sponsorship_date` AS `sponsorship_date` from `eventsfundedbysponsors` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `eventsorganisedbyorganisersview`
--

/*!50001 DROP VIEW IF EXISTS `eventsorganisedbyorganisersview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `eventsorganisedbyorganisersview` AS select `eventsorganisedbyorganisers`.`event_name` AS `event_name`,`eventsorganisedbyorganisers`.`organiser_name` AS `organiser_name`,`eventsorganisedbyorganisers`.`organiser_role` AS `organiser_role` from `eventsorganisedbyorganisers` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `eventsview`
--

/*!50001 DROP VIEW IF EXISTS `eventsview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `eventsview` AS select `events`.`event_name` AS `event_name`,`events`.`event_description` AS `event_description`,`events`.`event_date` AS `event_date`,`events`.`event_time` AS `event_time`,`events`.`event_status` AS `event_status`,`events`.`event_image_url` AS `event_image_url`,`events`.`category_name` AS `category_name`,`events`.`venue_name` AS `venue_name` from `events` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `notificationssendtousersview`
--

/*!50001 DROP VIEW IF EXISTS `notificationssendtousersview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `notificationssendtousersview` AS select `notificationssendtousers`.`user_id` AS `user_id`,`notificationssendtousers`.`notification_id` AS `notification_id`,`notificationssendtousers`.`priority` AS `priority` from `notificationssendtousers` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `notificationsview`
--

/*!50001 DROP VIEW IF EXISTS `notificationsview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `notificationsview` AS select `notifications`.`notification_id` AS `notification_id`,`notifications`.`notification_text` AS `notification_text`,`notifications`.`notification_date` AS `notification_date`,`notifications`.`event_name` AS `event_name` from `notifications` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ordersview`
--

/*!50001 DROP VIEW IF EXISTS `ordersview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ordersview` AS select `orders`.`order_id` AS `order_id`,`orders`.`order_date` AS `order_date`,`orders`.`payment_type` AS `payment_type`,`orders`.`payment_status` AS `payment_status`,`orders`.`total_amount` AS `total_amount`,`orders`.`user_id` AS `user_id`,`orders`.`event_name` AS `event_name` from `orders` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `reviewsview`
--

/*!50001 DROP VIEW IF EXISTS `reviewsview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reviewsview` AS select `reviews`.`rating` AS `rating`,`reviews`.`comment` AS `comment`,`reviews`.`review_date` AS `review_date`,`reviews`.`user_id` AS `user_id`,`reviews`.`event_name` AS `event_name` from `reviews` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sponsorsview`
--

/*!50001 DROP VIEW IF EXISTS `sponsorsview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sponsorsview` AS select `sponsors`.`sponsor_name` AS `sponsor_name`,`sponsors`.`description` AS `description`,`sponsors`.`website_url` AS `website_url`,`sponsors`.`logo_url` AS `logo_url`,`sponsors`.`contact_email` AS `contact_email`,`sponsors`.`contact_phone` AS `contact_phone`,`sponsors`.`total_sponsorship_amount` AS `total_sponsorship_amount` from `sponsors` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ticketsview`
--

/*!50001 DROP VIEW IF EXISTS `ticketsview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ticketsview` AS select `tickets`.`ticket_id` AS `ticket_id`,`tickets`.`ticket_price` AS `ticket_price`,`tickets`.`ticket_quantity` AS `ticket_quantity`,`tickets`.`start_sale_date` AS `start_sale_date`,`tickets`.`end_sale_date` AS `end_sale_date`,`tickets`.`event_name` AS `event_name`,`tickets`.`order_id` AS `order_id` from `tickets` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `userlogview`
--

/*!50001 DROP VIEW IF EXISTS `userlogview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `userlogview` AS select `userlog`.`log_id` AS `log_id`,`userlog`.`general_id` AS `general_id`,`userlog`.`action_type` AS `action_type`,`userlog`.`action_timestamp` AS `action_timestamp`,`userlog`.`details` AS `details` from `userlog` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `usersregisterforeventsview`
--

/*!50001 DROP VIEW IF EXISTS `usersregisterforeventsview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usersregisterforeventsview` AS select `usersregisterforevents`.`user_id` AS `user_id`,`usersregisterforevents`.`event_name` AS `event_name`,`usersregisterforevents`.`registration_date` AS `registration_date` from `usersregisterforevents` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `usersview`
--

/*!50001 DROP VIEW IF EXISTS `usersview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usersview` AS select `users`.`user_id` AS `user_id`,`users`.`username` AS `username`,`users`.`email` AS `email`,`users`.`password` AS `password`,`users`.`first_name` AS `first_name`,`users`.`last_name` AS `last_name`,`users`.`date_of_birth` AS `date_of_birth`,`users`.`sex` AS `sex`,`users`.`contact_phone` AS `contact_phone`,`users`.`street_no` AS `street_no`,`users`.`street_name` AS `street_name`,`users`.`unit_no` AS `unit_no`,`users`.`city` AS `city`,`users`.`state` AS `state`,`users`.`zip_code` AS `zip_code`,`users`.`country` AS `country`,`users`.`profile_picture_url` AS `profile_picture_url`,`users`.`role` AS `role`,`users`.`status` AS `status` from `users` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `venuesview`
--

/*!50001 DROP VIEW IF EXISTS `venuesview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `venuesview` AS select `venues`.`venue_name` AS `venue_name`,`venues`.`street_no` AS `street_no`,`venues`.`street_name` AS `street_name`,`venues`.`unit_no` AS `unit_no`,`venues`.`city` AS `city`,`venues`.`state` AS `state`,`venues`.`zip_code` AS `zip_code`,`venues`.`max_capacity` AS `max_capacity`,`venues`.`contact_email` AS `contact_email`,`venues`.`contact_phone` AS `contact_phone` from `venues` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-08 23:16:53
