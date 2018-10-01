-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: us-cdbr-iron-east-01.cleardb.net    Database: heroku_65d1aa2fb6c88c0
-- ------------------------------------------------------
-- Server version	5.5.56-log

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
-- Table structure for table `bbq`
--

DROP TABLE IF EXISTS `bbq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bbq` (
  `idBBQ` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `model` varchar(45) NOT NULL,
  `photo` longtext,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `favorite` tinyint(1) NOT NULL,
  `placeId` longtext NOT NULL,
  PRIMARY KEY (`idBBQ`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbq`
--

LOCK TABLES `bbq` WRITE;
/*!40000 ALTER TABLE `bbq` DISABLE KEYS */;
INSERT INTO `bbq` VALUES (4,'Grill-Service-Center','Infrared grills','',51.7017,7.82422,0,'ChIJj1RcvT50uUcRSGGuRYYZep0'),(11,'name 32222','model3','photo',1.11,2.22,0,'111312312'),(21,'MANU\'S RESTÓ BAR & GRILL','Infrared grills','CmRaAAAA6TMmfTtjkBIRm717F5GE0umXDS-uNOg5x6_7rvIEbMw5wQF6U2zKcVlC9ph-lqVLXF2hYBjJHCS5C_ha8b4GXC-S0DwO8P5JZR2kQMnEqt8Kyb-YlG_2G8Ee_GWWIv0iEhDmbKzNJ8kYP2sw2fIP5iWZGhS6MqMNzuQ6bg_ynXR5aHCFf6YpUw',8.93169,-79.699,0,'ChIJKfVTCDajrI8R5tnOwj9McwY'),(31,'Vera\'s Grill','Gas grills','CmRaAAAAug5ZQ5l_w1W0W_q3lqM6XsaWhWJc127oM2FU0Z1cxztSyMa2d1U-51dB95Wlhb1WZaLfndhNVIAd6lNflzs2fggRVWbJJrT5ZpRhwfM7YOH67OOwCUvL2AJwsVdX29WxEhD6XqnM91aTJkJAR1m8YgxuGhQ6T1lPW-I_OMgOp793taM_8ITPtA',9.01155,-79.5273,0,'ChIJGZGjuGmorI8RfwXjjV2YJ3I'),(41,'Brutto Restaurant','Gas grills','CmRaAAAABObrUBNDFRqoP035MlLGb45ohVD6oGvvsrT3IHJqRLb6F9RINr2AEOThWWpJ9Y-TQRjq1tdgh3dH4pkbMb0746IPL7SMOVlswNA55LmsrRrUKg291KzLbV8V-muABktkEhC6soT9uWkS6AXqy_ow9vTiGhQqXP3BMJZwoPoB6zIFgeUyff5aJg',8.99132,-79.5054,0,'ChIJVdgMPgaprI8RXlR4caqRPOc');
/*!40000 ALTER TABLE `bbq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rent`
--

DROP TABLE IF EXISTS `rent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rent` (
  `User_idUser` int(11) NOT NULL,
  `BBQ_idBBQ` int(11) NOT NULL,
  PRIMARY KEY (`User_idUser`,`BBQ_idBBQ`),
  KEY `fk_User_has_BBQ_BBQ1_idx` (`BBQ_idBBQ`),
  KEY `fk_User_has_BBQ_User_idx` (`User_idUser`),
  CONSTRAINT `fk_User_has_BBQ_BBQ1` FOREIGN KEY (`BBQ_idBBQ`) REFERENCES `bbq` (`idBBQ`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_BBQ_User` FOREIGN KEY (`User_idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rent`
--

LOCK TABLES `rent` WRITE;
/*!40000 ALTER TABLE `rent` DISABLE KEYS */;
INSERT INTO `rent` VALUES (2,4),(21,11),(2,21),(31,31),(31,41);
/*!40000 ALTER TABLE `rent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `age` int(255) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` longtext NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'efrain','perez',22,'efra@gmail.com','90a3ed9e32b2aaf4c61c410eb925426119e1a9dc53d4286ade99a809',8.9496,-79.6608),(3,'test','test',22,'test@gmail.com','90a3ed9e32b2aaf4c61c410eb925426119e1a9dc53d4286ade99a809',8.95061,-79.6556),(11,'Efrain332','Perez323',22,'test@rootstack.com','871ce144069ea0816545f52f09cd135d1182262c3b235808fa5a3281',1.1,1.1),(21,'Efrain332','Perez323',22,'test2@rootstack.com','871ce144069ea0816545f52f09cd135d1182262c3b235808fa5a3281',1.1,1.1),(31,'efrain','perez',22,'efra@rootstack.com','78d8045d684abd2eece923758f3cd781489df3a48e1278982466017f',9.01003,-79.5117);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'heroku_65d1aa2fb6c88c0'
--

--
-- Dumping routines for database 'heroku_65d1aa2fb6c88c0'
--
/*!50003 DROP PROCEDURE IF EXISTS `deleteRent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`bf5d98fb7a8b73`@`%` PROCEDURE `deleteRent`(IN idBbq INT, IN idUser INT)
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`bf5d98fb7a8b73`@`%` PROCEDURE `getUserRents`(In id INT)
BEGIN
SELECT 
        `BBQ`.`idBBQ` AS `idBBQ`,
        `BBQ`.`name` AS `name`,
        `BBQ`.`favorite` AS `favorite`,
        `BBQ`.`latitude` AS `latitude`,
        `BBQ`.`longitude` AS `longitude`,
        `BBQ`.`model` AS `model`,
        `BBQ`.`photo` AS `photo`,
        `BBQ`.`placeId` AS `placeId`
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`bf5d98fb7a8b73`@`%` PROCEDURE `rentBBQ`(IN _name VARCHAR(45), IN model VARCHAR(45), IN photo LONGTEXT, IN latitude FLOAT, IN longitude FLOAT, IN favorite BOOLEAN, 
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

-- Dump completed on 2018-10-01  3:38:03
