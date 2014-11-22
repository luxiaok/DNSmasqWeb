-- MySQL dump 10.13  Distrib 5.5.36-34.1, for Linux (x86_64)
--
-- Host: localhost    Database: xk_dnsmasq
-- ------------------------------------------------------
-- Server version	5.5.36-34.1-log

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
-- Table structure for table `xk_login_logs`
--

DROP TABLE IF EXISTS `xk_login_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xk_login_logs` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `uid` int(3) NOT NULL COMMENT '用户ID',
  `username` varchar(30) DEFAULT NULL COMMENT '登录用户名',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登录时间',
  `login_host` varchar(15) DEFAULT NULL COMMENT '登录IP',
  `login_location` varchar(20) DEFAULT NULL COMMENT '登录地区',
  `login_status` int(1) NOT NULL DEFAULT '0' COMMENT '0:成功，1:失败，2:用户被禁用，3:用户名错误，4:密码错误，5:异常，6:未知状态',
  `user_agent` varchar(200) DEFAULT NULL COMMENT '用户代理',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xk_login_logs`
--

LOCK TABLES `xk_login_logs` WRITE;
/*!40000 ALTER TABLE `xk_login_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `xk_login_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xk_users`
--

DROP TABLE IF EXISTS `xk_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xk_users` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `password` varchar(64) NOT NULL,
  `mobile` varchar(15) DEFAULT NULL COMMENT '电话号码',
  `email` varchar(50) DEFAULT NULL COMMENT '电子邮件',
  `cdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `mdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mask` varchar(3) NOT NULL DEFAULT '999',
  `is_admin` varchar(3) NOT NULL DEFAULT 'no' COMMENT '是否为管理员',
  `status` varchar(3) NOT NULL DEFAULT 'yes',
  `comment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xk_users`
--

LOCK TABLES `xk_users` WRITE;
/*!40000 ALTER TABLE `xk_users` DISABLE KEYS */;
INSERT INTO `xk_users` VALUES (1,'luxiaok','陆小K','6b1230a362a507f432b56d4694cb7846',NULL,NULL,'2014-11-22 16:37:50','2014-11-22 08:37:50','999','yes','yes','陆小K'),(2,'admin','管理员','21232f297a57a5a743894a0e4a801fc3',NULL,NULL,'2014-11-22 16:37:50','2014-11-22 08:37:50','999','yes','yes','系统管理员'),(3,'test','测试用户','098f6bcd4621d373cade4e832627b4f6',NULL,NULL,'2014-11-22 16:46:18','2014-11-22 08:46:18','999','no','no','测试用户');
/*!40000 ALTER TABLE `xk_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-22 16:55:58
