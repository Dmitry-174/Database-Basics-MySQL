-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: booking
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `properties_rooms_id` int unsigned NOT NULL COMMENT 'Ссылка на номер в объекте размещения',
  `user_id` int unsigned NOT NULL COMMENT 'Ссылка на путешественника',
  `check_in_date` date NOT NULL COMMENT 'Дата прибытия',
  `nights` int unsigned NOT NULL COMMENT 'Количество забронированных ночей',
  `guests` int unsigned NOT NULL COMMENT 'Количество гостей',
  `children` int unsigned NOT NULL DEFAULT '0' COMMENT 'Дополнительно количество детей',
  `meal_type_id` int unsigned NOT NULL DEFAULT '1' COMMENT 'Ссылка на тип питания, по умолчанию тип 1 (без питания)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `bookings_properties_rooms_id` (`properties_rooms_id`),
  KEY `bookings_user_id` (`user_id`),
  KEY `bookings_meal_type_id` (`meal_type_id`),
  CONSTRAINT `bookings_meal_type_id` FOREIGN KEY (`meal_type_id`) REFERENCES `meals` (`id`),
  CONSTRAINT `bookings_properties_rooms_id` FOREIGN KEY (`properties_rooms_id`) REFERENCES `properties_rooms` (`id`),
  CONSTRAINT `bookings_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Бронирования';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,1,1,'1987-05-21',2,2,1,1,'1980-04-14 16:13:26','2008-11-25 13:31:49'),(2,2,6,'1986-08-02',8,3,0,2,'1973-11-12 14:54:49','1986-08-23 00:33:53'),(3,7,3,'2003-02-10',6,1,1,3,'2007-06-18 11:06:33','2020-01-03 17:08:06'),(4,4,2,'1992-08-11',8,2,0,4,'1998-10-10 20:58:58','2019-02-14 09:16:56'),(5,4,5,'2015-10-20',6,3,2,5,'1994-07-25 17:50:08','2020-11-03 23:04:11'),(6,6,1,'1998-04-05',9,2,2,6,'1997-08-06 13:19:38','1999-01-18 15:04:40'),(7,2,7,'1999-01-12',2,2,1,1,'2004-07-04 10:05:45','1971-04-25 20:34:54'),(8,8,4,'1985-05-04',8,1,1,3,'1984-10-20 18:12:13','2000-01-19 07:00:40'),(9,9,9,'1974-09-15',7,3,0,4,'1980-04-29 05:32:59','2003-09-08 09:11:34'),(10,10,3,'1979-12-27',7,1,1,5,'1978-10-31 16:55:19','2010-04-15 13:21:55');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `currency_name` varchar(255) NOT NULL COMMENT 'Название валюты',
  `currency_code` varchar(3) DEFAULT NULL COMMENT 'Код валюты',
  `exchange_rate_to_usd` decimal(8,4) DEFAULT NULL COMMENT 'Курс к доллару',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Валюты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'United States dollar','USD',1.0000,'1986-06-24 14:24:40','1996-12-07 15:06:32'),(2,'Euro','EUR',1.1700,'2003-11-29 08:14:51','1999-10-14 22:59:30'),(3,'Israeli new shekel','ILS',0.3130,'2012-11-27 00:46:48','1979-06-28 04:07:15'),(4,'Japanese yen','JPY',0.0090,'2001-08-02 09:18:02','2016-04-27 11:58:27'),(5,'Russian ruble','RUB',0.0140,'2001-01-19 15:05:04','1999-06-09 01:55:00'),(6,'Qatari riyal','QAR',0.2700,'1995-08-04 23:11:31','2014-05-03 18:53:03');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `hotels`
--

DROP TABLE IF EXISTS `hotels`;
/*!50001 DROP VIEW IF EXISTS `hotels`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `hotels` AS SELECT 
 1 AS `property_name`,
 1 AS `country`,
 1 AS `city`,
 1 AS `address`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `meals`
--

DROP TABLE IF EXISTS `meals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meals` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `meal_type` varchar(255) NOT NULL COMMENT 'Название объекта размещения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Типы питания';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meals`
--

LOCK TABLES `meals` WRITE;
/*!40000 ALTER TABLE `meals` DISABLE KEYS */;
INSERT INTO `meals` VALUES (1,'Without meal','2001-05-02 19:00:42','1991-12-07 02:51:59'),(2,'Breakfast','1975-06-18 06:26:57','2013-01-21 01:38:08'),(3,'Half board','1989-07-05 10:16:41','2005-11-21 13:50:14'),(4,'Full board','1999-11-27 10:22:49','2001-05-29 01:17:02'),(5,'All inclusive','1987-05-20 13:33:04','1996-09-21 22:30:56'),(6,'Ultra All inclusive','1988-06-29 00:47:23','2006-06-14 06:19:43');
/*!40000 ALTER TABLE `meals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owners_properties`
--

DROP TABLE IF EXISTS `owners_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owners_properties` (
  `user_id` int unsigned NOT NULL COMMENT 'Ссылка на аккаун собственника',
  `property_id` int unsigned NOT NULL COMMENT 'Ссылка на объект размещения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`user_id`,`property_id`) COMMENT 'Составной первичный ключ',
  KEY `owners_properties_property_id` (`property_id`),
  CONSTRAINT `owners_properties_property_id` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  CONSTRAINT `owners_properties_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица связи аккаунтов собственников и объектов размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owners_properties`
--

LOCK TABLES `owners_properties` WRITE;
/*!40000 ALTER TABLE `owners_properties` DISABLE KEYS */;
INSERT INTO `owners_properties` VALUES (1,1,'1989-03-28 09:01:53','1971-05-17 13:54:54'),(2,2,'1988-01-02 18:12:14','2003-11-18 11:33:11'),(3,3,'2014-11-16 09:51:17','2003-12-04 10:29:18'),(4,4,'1984-02-16 18:08:20','1995-11-25 06:42:50'),(5,4,'2016-01-29 12:15:44','2001-12-02 10:47:16'),(6,4,'1993-11-12 04:29:30','2011-01-23 04:47:39'),(7,7,'2009-11-12 02:36:07','2018-04-04 18:30:12'),(8,8,'1985-05-15 02:58:15','2009-05-02 17:12:48'),(9,2,'1979-12-03 18:46:58','1984-07-30 20:14:42'),(10,10,'2003-09-18 10:47:12','1997-05-01 07:29:40');
/*!40000 ALTER TABLE `owners_properties` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_account_type` BEFORE INSERT ON `owners_properties` FOR EACH ROW BEGIN
	DECLARE ac_t VARCHAR(14);
    SELECT account_type INTO ac_t FROM users WHERE id = NEW.user_id;
    IF ac_t != 'owner' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account type is invalid';
	END IF;
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
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_account_type_update` BEFORE UPDATE ON `owners_properties` FOR EACH ROW BEGIN
	DECLARE ac_t VARCHAR(14);
    SELECT account_type INTO ac_t FROM users WHERE id = NEW.user_id;
    IF ac_t != 'owner' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account type is invalid';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `user_id` int unsigned NOT NULL,
  `country` varchar(100) NOT NULL COMMENT 'Старана проживания',
  `city` varchar(100) DEFAULT NULL COMMENT 'Город проживания',
  `postcode` varchar(10) DEFAULT NULL COMMENT 'Индекс для доставки корреспонденции',
  `address` varchar(255) DEFAULT NULL COMMENT 'Адрес выставления счета',
  `currency_id` int unsigned NOT NULL DEFAULT '1' COMMENT 'Ссылка на валюту пользователя, по умолчанию 1 (USD)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `profiles_currency_id` (`currency_id`),
  CONSTRAINT `profiles_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `profiles_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Профили пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'Venezuela','New Sabryna','803','728 Wyman Path Apt. 535\nGunnarland, ME 99480-8566',1,'2009-01-03 04:17:42','2021-09-16 14:11:58'),(2,'Cote d\'Ivoire','Rennerburgh','016','358 Tia Oval\nWest Eli, MA 78660-0308',2,'1974-06-20 00:02:56','2017-07-19 02:14:46'),(3,'Ukraine','East Kurtisland','969','1562 McGlynn Meadows Apt. 900\nBogisichfort, CT 71841',3,'2006-01-02 23:16:33','2000-04-11 12:56:54'),(4,'Wallis and Futuna','North Sammy','902','45638 Stamm View\nGissellechester, TX 32099',4,'2010-07-15 02:25:14','1971-01-04 22:24:42'),(5,'Macedonia','Ronaldoside','202','808 Runolfsson Square Apt. 875\nLaishaborough, VT 55416-8315',5,'1988-07-29 10:24:17','1975-01-12 00:01:24'),(6,'Syrian Arab Republic','South Claudport','631','03018 Breitenberg Forge Apt. 432\nWest Olliemouth, OR 66568-4118',6,'1980-09-06 06:09:08','1978-11-27 20:51:07'),(7,'Djibouti','Rossstad','979','774 Pouros Cliff Suite 019\nWest Anita, AZ 19329',4,'1995-01-08 03:57:09','1978-03-15 04:12:59'),(8,'Burundi','West Rosalyn','638','734 Stacey Run\nPort Kamille, MD 64546',5,'2021-02-13 20:45:08','1976-06-19 18:01:19'),(9,'British Indian Ocean Territory (Chagos Archipelago)','DuBuquehaven','298','5445 Schiller Spurs\nNorth Dagmarburgh, RI 70441-2703',2,'1970-04-10 17:02:16','2015-04-21 07:22:04'),(10,'Malaysia','Roderickberg','114','8002 Rau Heights Suite 624\nWest Delaney, GA 88214',4,'1982-12-14 01:56:05','2002-12-04 16:13:03');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `property_name` varchar(255) NOT NULL COMMENT 'Название объекта размещения',
  `property_type_id` int unsigned NOT NULL COMMENT 'Ссылка на тип объекта размещения',
  `country` varchar(100) DEFAULT NULL COMMENT 'Старана объекта размещения',
  `city` varchar(100) DEFAULT NULL COMMENT 'Город объекта размещения',
  `postcode` varchar(10) DEFAULT NULL COMMENT 'Индекс объекта размещения',
  `address` varchar(255) DEFAULT NULL COMMENT 'Адрес объекта размещения',
  `currency_id` int unsigned NOT NULL DEFAULT '1' COMMENT 'Ссылка на валюту объекта размещения, по умолчанию 1 (USD)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `properties_property_type_id` (`property_type_id`),
  KEY `properties_currency_id` (`currency_id`),
  CONSTRAINT `properties_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `properties_property_type_id` FOREIGN KEY (`property_type_id`) REFERENCES `property_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Объекты размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,'est',1,'Niue','Leoraland','705','3867 Litzy Extension\nKubport, AR 34748',1,'2016-05-16 19:19:47','2005-05-26 11:26:42'),(2,'molestiae',2,'Hong Kong','Hoegerview','107','93147 Schamberger River Apt. 132\nSouth Leda, KY 22493-5662',2,'2019-09-13 18:41:10','1974-04-22 06:58:38'),(3,'adipisci',3,'Mauritania','Loyalborough','555','94571 Rubye Unions Apt. 258\nSouth Sebastianstad, CT 53885-6043',3,'1991-02-27 06:47:31','2019-06-27 15:03:02'),(4,'at',4,'Guatemala','South Rosemarieview','771','74872 Mohr Grove Apt. 637\nNorth Delores, WI 30348-1018',4,'1987-04-07 18:03:04','2017-06-04 21:19:15'),(5,'culpa',5,'Burkina Faso','Port Dominichaven','836','86434 Heaney Vista\nWest Elenor, OR 87426-4218',5,'1981-08-07 23:48:02','1971-10-26 10:41:14'),(6,'eos',6,'Saint Pierre and Miquelon','Elinorland','414','5668 Leuschke Parks Apt. 047\nJedidiahborough, NH 96433-1728',6,'1979-12-24 05:32:47','1982-12-12 01:29:41'),(7,'eaque',7,'Palestinian Territory','Brantland','315','8253 Tabitha Valleys\nSouth Wilhelmine, ND 05698-8961',5,'2015-01-31 18:42:13','2008-07-30 20:31:12'),(8,'adipisci',8,'Syrian Arab Republic','New Keonhaven','382','5108 Koss Union\nNew Domingo, IA 77610-6825',1,'2021-02-23 01:17:06','1981-07-12 11:14:48'),(9,'voluptatem',9,'American Samoa','Port Alejandrafort','929','815 Erin Creek Apt. 732\nWest Fletcherchester, MN 18117',4,'1975-07-12 05:48:03','1993-06-15 03:08:40'),(10,'voluptates',10,'Macao','South Sinceremouth','295','196 Vallie Village Apt. 432\nNorth Mathilde, WI 17847',6,'1997-01-17 16:34:49','2009-05-21 16:56:19'),(11,'brininfat',2,'Macao','South Sinceremouth','233','123 Vallie Village Apt. 4452\nNorth Mathilde, WI 17847',6,'2005-01-17 16:34:49','2010-05-21 16:56:19');
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties_meals`
--

DROP TABLE IF EXISTS `properties_meals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties_meals` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `property_id` int unsigned NOT NULL COMMENT 'Ссылка на объект размещения',
  `meal_type_id` int unsigned NOT NULL DEFAULT '1' COMMENT 'Ссылка на тип питания, по умолчанию тип 1 (без питания)',
  `price` float unsigned NOT NULL COMMENT 'Стоимость за ночь в валюте объекта размещения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `properties_meals_property_id` (`property_id`),
  KEY `properties_meals_meal_type_id` (`meal_type_id`),
  CONSTRAINT `properties_meals_meal_type_id` FOREIGN KEY (`meal_type_id`) REFERENCES `meals` (`id`),
  CONSTRAINT `properties_meals_property_id` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица связи типов питания и объектов размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties_meals`
--

LOCK TABLES `properties_meals` WRITE;
/*!40000 ALTER TABLE `properties_meals` DISABLE KEYS */;
INSERT INTO `properties_meals` VALUES (1,1,1,2,'2000-06-23 22:00:42','2016-11-12 11:52:02'),(2,2,2,72596900,'1989-10-02 02:39:00','2001-11-28 04:22:08'),(3,2,1,0,'1992-10-26 09:29:19','2003-09-13 05:20:04'),(4,2,2,5,'1978-04-13 23:40:10','1988-05-22 02:31:01'),(5,5,1,38496300,'2003-12-04 04:05:37','2000-02-12 22:40:58'),(6,5,2,121,'2015-10-07 21:29:19','1980-03-27 23:14:16'),(7,7,5,64,'1991-08-16 12:16:06','1990-05-17 05:45:51'),(8,8,6,38118,'1991-01-11 23:39:03','1997-06-28 21:40:21'),(9,9,2,10981500,'2013-06-29 05:16:34','1980-07-21 01:17:22'),(10,10,4,353963000,'2006-12-15 04:19:14','2013-08-05 20:38:45'),(11,4,2,365,'2008-11-15 04:19:14','2013-08-05 20:38:45');
/*!40000 ALTER TABLE `properties_meals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties_rooms`
--

DROP TABLE IF EXISTS `properties_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties_rooms` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `property_id` int unsigned NOT NULL COMMENT 'Ссылка на объект размещения',
  `room_type_id` int unsigned NOT NULL COMMENT 'Ссылка на тип номера',
  `room_size` int unsigned NOT NULL COMMENT 'Площадь номера данного типа в данном объекте размещения',
  `price` float unsigned NOT NULL COMMENT 'Стоимость за ночь в валюте объекта размещения',
  `quantity` int unsigned NOT NULL COMMENT 'Количество номеров данного типа в данном объекте размещения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `properties_rooms_property_id` (`property_id`),
  KEY `properties_rooms_room_type_id` (`room_type_id`),
  CONSTRAINT `properties_rooms_property_id` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  CONSTRAINT `properties_rooms_room_type_id` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица связи типов номеров и объектов размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties_rooms`
--

LOCK TABLES `properties_rooms` WRITE;
/*!40000 ALTER TABLE `properties_rooms` DISABLE KEYS */;
INSERT INTO `properties_rooms` VALUES (1,1,1,2424970,45,2514,'1992-01-02 14:04:43','2018-06-10 01:09:36'),(2,4,2,73,3401320,162,'2000-08-23 05:39:40','1979-04-11 10:34:20'),(3,3,3,8656,1249970,37469,'1986-01-28 14:32:53','1974-05-11 18:42:53'),(4,4,4,1,1,26309386,'2013-10-11 13:44:22','1993-11-03 06:13:19'),(5,8,5,1876029,7889,4,'1998-09-07 13:23:17','1986-02-01 22:19:18'),(6,6,6,528,26,741,'1979-01-20 02:53:29','1972-01-23 18:08:35'),(7,7,5,40731190,10609500,56,'1988-01-08 20:04:30','1984-12-15 19:02:23'),(8,8,8,656627,7881,2815,'1971-04-01 08:56:16','2008-06-28 15:27:45'),(9,4,9,989,3,4938,'1999-04-10 04:01:10','1978-10-02 02:34:13'),(10,10,10,5758293,45,3,'1989-05-13 08:02:43','1984-11-04 17:25:38'),(11,11,4,57,56677,2,'1990-05-13 08:02:43','2009-11-04 17:25:38');
/*!40000 ALTER TABLE `properties_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property_types`
--

DROP TABLE IF EXISTS `property_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `property_type` varchar(255) NOT NULL COMMENT 'Тип объекта размещения',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Типы объектов размещения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_types`
--

LOCK TABLES `property_types` WRITE;
/*!40000 ALTER TABLE `property_types` DISABLE KEYS */;
INSERT INTO `property_types` VALUES (1,'Apartament','2017-10-07 12:44:37','1991-01-09 05:05:34'),(2,'Hotel','2004-10-28 12:07:30','2001-04-21 23:58:30'),(3,'Hostel','2015-08-12 22:00:40','1994-12-16 06:28:34'),(4,'Motel','1994-11-05 22:33:18','2012-05-24 13:23:21'),(5,'Guesthouse','1970-09-04 16:47:43','2017-11-02 00:29:31'),(6,'Resort','2013-08-27 14:38:28','1988-07-09 14:35:52'),(7,'Villa','1979-11-16 14:56:26','1972-08-15 18:02:38'),(8,'Bed and Breakfast','1977-05-18 09:49:07','1982-09-17 10:13:27'),(9,'Chalet','1981-02-10 19:43:12','1985-02-12 22:52:43'),(10,'Vacation Home','1979-03-30 04:10:29','2020-02-19 19:32:01');
/*!40000 ALTER TABLE `property_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!50001 DROP VIEW IF EXISTS `rating`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `rating` AS SELECT 
 1 AS `property_name`,
 1 AS `avg_rating`,
 1 AS `city`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `property_id` int unsigned NOT NULL COMMENT 'Ссылка на объект размещения',
  `user_id` int unsigned NOT NULL COMMENT 'Ссылка на путешественника',
  `rating` int unsigned NOT NULL COMMENT 'Оценка от 1 до 10',
  `benefits` text COMMENT 'Описание преимуществ',
  `disadvantages` text COMMENT 'Описание недостатков',
  `is_moderated` tinyint(1) DEFAULT NULL COMMENT 'Прошло проверку модератора',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `reviews_property_id` (`property_id`),
  KEY `reviews_user_id` (`user_id`),
  CONSTRAINT `reviews_property_id` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`),
  CONSTRAINT `reviews_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `сheck_rating` CHECK (((`rating` >= 1) or (`rating` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Отзывы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,1,9,'Hic soluta nemo ipsa asperiores voluptatibus inventore magnam. Ipsam eveniet repudiandae accusantium suscipit enim qui. Quisquam explicabo temporibus ut explicabo quo magni maiores.','Est cupiditate rem praesentium odio nam alias. At in assumenda aut molestiae. Sed accusamus ut veniam consequatur aperiam est.',1,'2007-02-13 00:23:52','1989-03-12 14:43:21'),(2,2,2,9,'Dolor ullam labore aut quia illum quia laborum. Sed harum incidunt debitis incidunt corporis dicta. Saepe cumque autem enim magni.','Vel minima animi perspiciatis. Rerum eos ex est enim. Est labore cum excepturi. Aut quae explicabo ex ducimus dolor.',0,'1972-06-21 23:56:50','1988-11-14 12:02:11'),(3,3,6,7,'Est dolores minus aperiam laudantium doloribus vero soluta. Veniam reprehenderit molestias voluptas in ad temporibus blanditiis. Dolor aut et incidunt consequatur minus cupiditate laborum.','Quo libero est rerum expedita minus laboriosam ipsa sit. Consequatur et possimus quia ut aut. Ratione amet facere facere sed. Architecto quia error tempora quam magnam.',0,'1996-04-17 08:03:40','1998-10-04 06:38:22'),(4,6,4,5,'Sit libero esse aperiam et numquam illum sed. Dolores repudiandae alias et aut. Qui tempore aut qui sit.','Rem voluptatem voluptas rerum illum eaque amet ut. Eius dicta ea dolorem quis deserunt voluptas. Sapiente placeat nihil et eius labore.',1,'1982-05-01 20:29:25','2018-07-03 03:08:10'),(5,5,5,7,'Sint et corporis autem aliquid et. Ea quos enim nihil iste suscipit sed ipsam. In cum alias cumque enim sed illo rem dolor.','Deleniti aliquam dicta deleniti. Harum unde earum cupiditate inventore consectetur. Harum velit dolorum expedita quod corrupti et.',1,'2018-03-23 13:26:24','1986-10-29 04:34:11'),(6,6,6,8,'Fugit quisquam sit esse eaque. Delectus dicta eius fuga aut sint quia consequuntur. Qui mollitia cumque aut suscipit vel sed est quisquam. Voluptas eius saepe molestiae unde quos voluptatem hic.','Temporibus cum beatae et dolorem ratione. Beatae accusantium fugiat odit voluptatem vero dolorem exercitationem libero. Ab quam nostrum quos non deleniti qui. Quis sint est ab fugiat porro dolor.',1,'1991-09-05 17:03:16','1989-12-17 07:33:59'),(7,6,7,2,'Aut voluptatibus repudiandae facere quas laudantium rem. Facere debitis enim maiores fuga quia. Suscipit rem commodi vero. Eos a tenetur aliquid vel minima minus.','Dolor est consequatur voluptate et odit. Et sequi voluptatem inventore esse omnis quas debitis. Eveniet quod molestias reiciendis quidem accusantium reiciendis voluptas.',1,'2017-11-03 20:23:26','1997-11-04 15:50:07'),(8,8,8,9,'In cum alias sit ab sapiente laudantium vero. Nulla non exercitationem sit fuga temporibus ut vel. Voluptas modi aut aut non vel consequuntur. Et eaque earum dolore aliquam.','Repellendus ea dolorem quis nemo nam rerum necessitatibus. Laudantium vitae dolor numquam voluptas corrupti et non accusamus. Ab provident hic necessitatibus.',0,'2007-06-24 20:01:26','1989-08-10 11:24:18'),(9,9,1,6,'Quia dolorum consectetur est voluptates at laborum aut. Tenetur atque doloremque aut ab cumque quia. Deleniti aut doloremque eum eum et libero quas.','Exercitationem aspernatur est et officia qui culpa quae. Enim sunt eaque magni eveniet et necessitatibus. Molestias illo eligendi perferendis libero exercitationem. Eum quae voluptatem enim nemo numquam corporis cumque.',1,'1983-12-09 16:56:09','2013-08-16 14:18:25'),(10,10,10,10,'Iure quas sit omnis dolorum doloremque doloremque eum. Omnis aut aut voluptatem nisi. Minima dolore et blanditiis dolor sit in quo. Est quam deleniti aut aspernatur voluptatem qui beatae.','Soluta corrupti dolores dolores repudiandae nihil non est. Voluptas nulla error repellat et numquam perspiciatis. Minus corrupti molestiae quibusdam cupiditate aspernatur adipisci.',0,'2012-06-02 05:03:41','2008-07-29 08:52:14');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_types`
--

DROP TABLE IF EXISTS `room_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `room_type` varchar(255) NOT NULL COMMENT 'Тип номера',
  `guests` int unsigned NOT NULL COMMENT 'Вместимость номера',
  `additonal_children` int unsigned NOT NULL COMMENT 'Скольких детей дополнительно возможно разместить',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Типы номеров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_types`
--

LOCK TABLES `room_types` WRITE;
/*!40000 ALTER TABLE `room_types` DISABLE KEYS */;
INSERT INTO `room_types` VALUES (1,'Standart double',2,1,'1988-08-18 02:59:24','1982-09-09 04:55:07'),(2,'Standart twin',2,1,'2002-08-30 12:09:17','1988-05-30 22:42:42'),(3,'Comfort double',2,2,'2003-02-22 00:13:13','1975-11-04 23:45:26'),(4,'Comfort twin',2,2,'1982-06-18 07:06:56','1984-01-12 10:37:26'),(5,'Deluxe double',2,2,'2000-01-30 10:33:05','1997-01-16 04:49:26'),(6,'Deluxe triple',3,2,'1988-07-21 04:23:18','1980-05-14 20:39:02'),(7,'Family room',3,2,'2002-05-11 03:31:19','2016-09-11 09:02:18'),(8,'Studio',2,1,'1996-06-06 23:44:08','1972-11-23 21:09:59'),(9,'Standart single',1,0,'2014-09-16 14:53:36','1974-07-19 14:03:41'),(10,'Comfort single',1,1,'2019-10-09 14:07:37','1971-02-01 07:02:26');
/*!40000 ALTER TABLE `room_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'Имя пользователя',
  `surname` varchar(100) NOT NULL COMMENT 'Фамилия пользователя',
  `email` varchar(255) NOT NULL COMMENT 'Электронная почта пользователя',
  `phone` varchar(14) NOT NULL COMMENT 'Номер телефона пользователя',
  `birthday_at` date NOT NULL COMMENT 'Дата рождения пользователя',
  `sex` enum('male','female') DEFAULT NULL COMMENT 'Пол пользователя',
  `account_type` enum('owner','travaler') DEFAULT NULL COMMENT 'Тип аккаунта',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  CONSTRAINT `сheck_phone` CHECK (regexp_like(`phone`,_utf8mb4'^\\+[0-9]{1,3}[0-9]{10}$'))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Пользователи';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Michael','Christiansen','green.kelly@example.com','+498903554618','1996-09-03','female','travaler','1972-05-23 10:21:30','1977-12-26 15:12:44'),(2,'Michele','Jones','nicolas.scotty@example.com','+15477344140','2004-04-23','female','owner','2004-06-17 13:51:49','2008-10-03 18:07:13'),(3,'Forrest','Thiel','katrine.stamm@example.org','+219162712823','2013-11-27','female','travaler','1999-12-03 13:10:17','2016-02-12 18:16:36'),(4,'Wilma','Runolfsson','jessie.rodriguez@example.net','+721898436569','1992-04-30','female','travaler','2014-10-20 15:47:28','2010-05-05 18:33:12'),(5,'Dena','Christiansen','dolores.weissnat@example.com','+74110177789','2019-10-28','female','owner','1980-08-05 01:45:10','2015-11-14 00:32:40'),(6,'Stella','Blanda','kayleigh60@example.org','+108213366984','2021-07-11','male','travaler','1989-12-22 10:08:39','2001-06-11 03:08:38'),(7,'Monserrat','Abbott','gleason.courtney@example.com','+170255495861','1986-12-16','male','travaler','1997-06-09 06:46:30','1995-07-13 00:30:30'),(8,'Omer','Corkery','mozelle60@example.net','+117726393025','2002-10-06','female','travaler','2016-11-16 09:54:38','1994-11-29 20:27:45'),(9,'Rick','Spinka','casper.bart@example.org','+850621389789','1979-04-16','female','travaler','1990-01-16 15:49:59','2003-11-21 05:37:49'),(10,'Ernest','Douglas','dicki.salvador@example.org','+5617073973073','1990-06-27','female','owner','2008-09-07 23:28:07','1991-04-25 07:02:45');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `hotels`
--

/*!50001 DROP VIEW IF EXISTS `hotels`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `hotels` AS select `properties`.`property_name` AS `property_name`,`properties`.`country` AS `country`,`properties`.`city` AS `city`,`properties`.`address` AS `address` from `properties` where (`properties`.`property_type_id` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rating`
--

/*!50001 DROP VIEW IF EXISTS `rating`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rating` AS select `properties`.`property_name` AS `property_name`,avg(`reviews`.`rating`) AS `avg_rating`,`properties`.`city` AS `city` from (`properties` join `reviews` on((`properties`.`id` = `reviews`.`property_id`))) group by `reviews`.`property_id` order by `avg_rating` desc */;
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

-- Dump completed on 2021-10-10 15:19:02
