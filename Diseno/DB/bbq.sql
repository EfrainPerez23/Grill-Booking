-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BBQ`
--

DROP TABLE IF EXISTS `BBQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BBQ` (
  `idBBQ` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `model` varchar(45) NOT NULL,
  `photo` longtext,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `favorite` tinyint(1) NOT NULL,
  `placeId` longtext NOT NULL,
  PRIMARY KEY (`idBBQ`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BBQ`
--

LOCK TABLES `BBQ` WRITE;
/*!40000 ALTER TABLE `BBQ` DISABLE KEYS */;
INSERT INTO `BBQ` VALUES (4,'Grill-Service-Center','Infrared grills','',51.7017,7.82422,0,'ChIJj1RcvT50uUcRSGGuRYYZep0');
/*!40000 ALTER TABLE `BBQ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rent`
--

DROP TABLE IF EXISTS `Rent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rent` (
  `User_idUser` int(11) NOT NULL,
  `BBQ_idBBQ` int(11) NOT NULL,
  PRIMARY KEY (`User_idUser`,`BBQ_idBBQ`),
  KEY `fk_User_has_BBQ_BBQ1_idx` (`BBQ_idBBQ`),
  KEY `fk_User_has_BBQ_User_idx` (`User_idUser`),
  CONSTRAINT `fk_User_has_BBQ_BBQ1` FOREIGN KEY (`BBQ_idBBQ`) REFERENCES `BBQ` (`idBBQ`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_BBQ_User` FOREIGN KEY (`User_idUser`) REFERENCES `User` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rent`
--

LOCK TABLES `Rent` WRITE;
/*!40000 ALTER TABLE `Rent` DISABLE KEYS */;
INSERT INTO `Rent` VALUES (2,4);
/*!40000 ALTER TABLE `Rent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `age` int(255) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` longtext NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (2,'efrain','perez',22,'efra@gmail.com','90a3ed9e32b2aaf4c61c410eb925426119e1a9dc53d4286ade99a809',8.9496,-79.6608),(3,'test','test',22,'test@gmail.com','90a3ed9e32b2aaf4c61c410eb925426119e1a9dc53d4286ade99a809',8.95061,-79.6556);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mydb'
--

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP PROCEDURE IF EXISTS `deleteRent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteRent`(IN idBbq INT, IN idUser INT)
BEGIN
	DELETE FROM Rent WHERE BBQ_idBBQ = idBbq AND User_idUser = idUser;
    DELETE FROM BBQ WHERE idBBQ = idBbq;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getUserRents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserRents`(In id INT)
BEGIN
SELECT 
        `mydb`.`BBQ`.`idBBQ` AS `idBBQ`,
        `mydb`.`BBQ`.`name` AS `name`,
        `mydb`.`BBQ`.`favorite` AS `favorite`,
        `mydb`.`BBQ`.`latitude` AS `latitude`,
        `mydb`.`BBQ`.`longitude` AS `longitude`,
        `mydb`.`BBQ`.`model` AS `model`,
        `mydb`.`BBQ`.`photo` AS `photo`,
        `mydb`.`BBQ`.`placeId` AS `placeId`
    FROM
        ((`mydb`.`User`
        JOIN `mydb`.`Rent` ON ((`mydb`.`User`.`idUser` = `mydb`.`Rent`.`User_idUser`)))
        JOIN `mydb`.`BBQ` ON ((`mydb`.`BBQ`.`idBBQ` = `mydb`.`Rent`.`BBQ_idBBQ`)))
	WHERE User.idUser = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rentBBQ` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rentBBQ`(IN _name VARCHAR(45), IN model VARCHAR(45), IN photo LONGTEXT, IN latitude FLOAT, IN longitude FLOAT, IN favorite BOOLEAN, 
IN placeId LONGTEXT, IN idUser INT)
BEGIN
	INSERT INTO BBQ VALUES(NULL, _name, model, photo, latitude, longitude, favorite, placeId);
	INSERT INTO Rent VALUES (idUser, LAST_INSERT_ID());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-30  3:53:47
