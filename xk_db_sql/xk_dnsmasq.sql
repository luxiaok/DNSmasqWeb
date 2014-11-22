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
-- Table structure for table `xk_domain`
--

DROP TABLE IF EXISTS `xk_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xk_domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(60) NOT NULL COMMENT '域名',
  `file` varchar(200) NOT NULL COMMENT '配置文件',
  `file_md5` varchar(64) NOT NULL COMMENT 'MD5值',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `up_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `comment` varchar(200) NOT NULL COMMENT '备注',
  `status` varchar(3) NOT NULL DEFAULT 'yes' COMMENT '状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xk_domain`
--

LOCK TABLES `xk_domain` WRITE;
/*!40000 ALTER TABLE `xk_domain` DISABLE KEYS */;
INSERT INTO `xk_domain` VALUES (1,'luxiaok.com','luxiaok.com.conf','7d6fc11ff30026ce769b1ecc6a7cde15','2014-11-22 22:25:26','2014-11-22 14:33:39','测试域名','yes'),(2,'test.com','test.com.conf','438fb7dc59af5a8fc9b0e4ba53be7294','2014-11-22 22:34:00','2014-11-22 14:34:00','测试域名2','yes'),(3,'qq.com','qq.com.conf','4228386eafc1a2f3dc4c908f84d34a6b','2014-11-22 22:40:14','2014-11-22 14:40:14','','yes');
/*!40000 ALTER TABLE `xk_domain` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xk_login_logs`
--

LOCK TABLES `xk_login_logs` WRITE;
/*!40000 ALTER TABLE `xk_login_logs` DISABLE KEYS */;
INSERT INTO `xk_login_logs` VALUES (1,1,'luxiaok','2014-11-22 09:03:00','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(2,1,'luxiaok','2014-11-22 09:03:08','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(3,1,'luxiaok','2014-11-22 09:06:16','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(4,2,'admin','2014-11-22 09:06:40','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(5,1,'luxiaok','2014-11-22 09:58:03','192.168.1.7',NULL,0,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)'),(6,1,'luxiaok','2014-11-22 10:03:53','192.168.1.7',NULL,0,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)'),(7,1,'luxiaok','2014-11-22 10:05:19','192.168.1.7',NULL,0,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)'),(8,1,'luxiaok','2014-11-22 10:20:29','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36');
/*!40000 ALTER TABLE `xk_login_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xk_record`
--

DROP TABLE IF EXISTS `xk_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xk_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `did` int(11) NOT NULL COMMENT '域名ID',
  `record` varchar(50) NOT NULL COMMENT '主机记录',
  `type` varchar(10) NOT NULL COMMENT '记录类型',
  `value` varchar(50) NOT NULL COMMENT '记录值',
  `priority` int(11) DEFAULT NULL COMMENT 'MX优先级',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `up_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `comment` varchar(100) DEFAULT NULL COMMENT '备注',
  `status` varchar(3) NOT NULL DEFAULT 'yes' COMMENT '状态值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xk_record`
--

LOCK TABLES `xk_record` WRITE;
/*!40000 ALTER TABLE `xk_record` DISABLE KEYS */;
INSERT INTO `xk_record` VALUES (1,1,'www','A','192.168.1.11',NULL,'2014-11-22 23:23:00','2014-11-22 15:23:00','网站','yes'),(2,2,'blog','A','192.168.1.1',NULL,'2014-11-22 23:29:06','2014-11-22 15:29:06','测试博客','yes'),(3,3,'www','A','180.96.86.192',NULL,'2014-11-22 23:29:44','2014-11-22 15:29:44','腾讯门户网','yes'),(4,2,'news','A','192.168.1.2',NULL,'2014-11-22 23:32:23','2014-11-22 15:32:23','新网页','yes'),(5,2,'mail','A','113.108.16.61',NULL,'2014-11-23 00:08:09','2014-11-22 16:08:09','','yes'),(6,2,'mail','MX','mail.test.com',10,'2014-11-23 00:08:42','2014-11-22 16:08:42','MX记录','yes');
/*!40000 ALTER TABLE `xk_record` ENABLE KEYS */;
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

-- Dump completed on 2014-11-23  0:33:35
