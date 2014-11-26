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
-- Table structure for table `xk_dhcp_host`
--

DROP TABLE IF EXISTS `xk_dhcp_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xk_dhcp_host` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(50) DEFAULT NULL COMMENT '主机名',
  `mac` varchar(20) DEFAULT NULL COMMENT 'MAC地址',
  `ip` varchar(15) DEFAULT NULL COMMENT 'IP地址',
  `comment` varchar(30) DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `status` varchar(3) NOT NULL DEFAULT 'yes' COMMENT '规则状态',
  `action` varchar(10) NOT NULL DEFAULT 'allow' COMMENT '规则动作',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xk_dhcp_host`
--

LOCK TABLES `xk_dhcp_host` WRITE;
/*!40000 ALTER TABLE `xk_dhcp_host` DISABLE KEYS */;
INSERT INTO `xk_dhcp_host` VALUES (3,'rhel65xx','00:0c:29:f6:04:34','192.168.1.60','rhel 6.5xfff','2014-11-26 14:17:12','yes','allow'),(4,'test','00:0c:29:f6:04:35','192.168.1.61','dd','2014-11-26 14:27:22','yes','allow'),(5,'win7','00:0c:29:f6:04:29','192.168.1.7','win7x64','2014-11-26 14:39:51','yes','allow'),(6,'winxp','00:0c:29:f6:04:33','192.168.1.33','33xp','2014-11-26 15:29:01','yes','allow');
/*!40000 ALTER TABLE `xk_dhcp_host` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xk_domain`
--

LOCK TABLES `xk_domain` WRITE;
/*!40000 ALTER TABLE `xk_domain` DISABLE KEYS */;
INSERT INTO `xk_domain` VALUES (1,'luxiaok.com','luxiaok.com.conf','5dcd3226a211b004c9376d864ab99d7f','2014-11-22 22:25:26','2014-11-24 14:28:25','测试域名','yes'),(2,'test.com','test.com.conf','6f91829bebd8663db73498090ab69557','2014-11-22 22:34:00','2014-11-22 19:47:02','测试域名2','yes'),(3,'qq.com','qq.com.conf','4228386eafc1a2f3dc4c908f84d34a6b','2014-11-23 17:58:32','2014-11-23 09:58:32','QQ域名','yes'),(4,'google.com','google.com.conf','1023883e5729868925ffca6032eb5300','2014-11-24 22:48:07','2014-11-24 15:34:25','Google','yes');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xk_login_logs`
--

LOCK TABLES `xk_login_logs` WRITE;
/*!40000 ALTER TABLE `xk_login_logs` DISABLE KEYS */;
INSERT INTO `xk_login_logs` VALUES (1,1,'luxiaok','2014-11-22 09:03:00','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(2,1,'luxiaok','2014-11-22 09:03:08','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(3,1,'luxiaok','2014-11-22 09:06:16','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(4,2,'admin','2014-11-22 09:06:40','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(5,1,'luxiaok','2014-11-22 09:58:03','192.168.1.7',NULL,0,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)'),(6,1,'luxiaok','2014-11-22 10:03:53','192.168.1.7',NULL,0,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)'),(7,1,'luxiaok','2014-11-22 10:05:19','192.168.1.7',NULL,0,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)'),(8,1,'luxiaok','2014-11-22 10:20:29','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(9,1,'luxiaok','2014-11-23 02:38:29','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(10,1,'luxiaok','2014-11-23 03:20:17','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(11,1,'luxiaok','2014-11-23 03:25:42','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(12,1,'luxiaok','2014-11-23 04:16:41','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(13,1,'luxiaok','2014-11-23 04:20:18','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(14,1,'luxiaok','2014-11-23 04:27:27','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(15,1,'luxiaok','2014-11-23 08:03:08','192.168.1.7',NULL,0,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)'),(16,1,'luxiaok','2014-11-23 12:23:00','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(17,1,'luxiaok','2014-11-24 14:20:54','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(18,1,'luxiaok','2014-11-25 14:34:16','192.168.1.7',NULL,0,'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)'),(19,1,'luxiaok','2014-11-25 15:10:21','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36'),(20,1,'luxiaok','2014-11-26 12:51:41','192.168.1.7',NULL,0,'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36');
/*!40000 ALTER TABLE `xk_login_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xk_options`
--

DROP TABLE IF EXISTS `xk_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xk_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xk_options`
--

LOCK TABLES `xk_options` WRITE;
/*!40000 ALTER TABLE `xk_options` DISABLE KEYS */;
INSERT INTO `xk_options` VALUES (1,'dhcp','xk_dhcp_status','yes','DHCP开关'),(2,'dhcp','xk_dhcp_pool_start','192.168.1.11','DHCP地址池开始地址'),(3,'dhcp','xk_dhcp_pool_stop','192.168.1.101','DHCP地址池结束地址'),(4,'dhcp','xk_dhcp_pool_netmask','255.255.255.0','DHCP地址池子网掩码'),(5,'dhcp','xk_dhcp_pool_lease','6h','DHCP租约'),(6,'dhcp','xk_dhcp_pool_gw','192.168.1.254','DHCP默认网关'),(7,'dhcp','xk_dhcp_pool_dns1','114.114.114.114','DHCP主DNS服务器'),(8,'dhcp','xk_dhcp_pool_dns2','8.8.8.8','DHCP辅助DNS服务器'),(9,'dhcp','xk_dhcp_pool_domain','luxiaok.com','DHCP缺省域名'),(10,'dhcp','xk_dhcp_pool_ntp','','DHCP时间服务器'),(11,'dhcp','xk_dhcp_pool_comment','test','DHCP地址池备注'),(12,'dhcp','xk_dhcp_conf_md5','','DHCP配置文件的MD5值');
/*!40000 ALTER TABLE `xk_options` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xk_record`
--

LOCK TABLES `xk_record` WRITE;
/*!40000 ALTER TABLE `xk_record` DISABLE KEYS */;
INSERT INTO `xk_record` VALUES (1,1,'www2','A','192.168.1.12',NULL,'2014-11-22 23:23:00','2014-11-23 11:32:51','2222','yes'),(2,2,'blog','A','192.168.1.1',NULL,'2014-11-22 23:29:06','2014-11-22 16:59:01','测试博客','yes'),(4,2,'news','A','192.168.1.2',NULL,'2014-11-22 23:32:23','2014-11-22 17:02:03','新网页','yes'),(5,2,'mail','A','113.108.16.61',NULL,'2014-11-23 00:08:09','2014-11-22 16:08:09','','yes'),(7,2,'www','A','192.168.2.9',NULL,'2014-11-23 01:57:21','2014-11-22 17:57:21','','yes'),(8,1,'blog','A','192.168.1.99',NULL,'2014-11-23 02:06:54','2014-11-22 18:06:54','','yes'),(9,1,'@','MX','mail.luxiaok.com',50,'2014-11-23 03:05:35','2014-11-22 19:19:40','MX记录','yes'),(10,1,'mail','A','192.168.2.28',NULL,'2014-11-23 03:05:57','2014-11-22 19:05:57','','yes'),(11,2,'@','MX','mail.test.com',12,'2014-11-23 03:20:14','2014-11-22 19:20:14','','yes'),(12,2,'@','TXT','Hello World',NULL,'2014-11-23 03:24:57','2014-11-22 19:24:57','','yes'),(13,2,'hello','TXT','Hello Luxiaok',NULL,'2014-11-23 03:28:26','2014-11-22 19:28:26','','yes'),(14,2,'mail3','CNAME','mail.test.com',NULL,'2014-11-23 03:46:55','2014-11-22 19:46:55','','yes'),(15,1,'host1','CNAME','www.luxiaok.com',NULL,'2014-11-23 17:58:04','2014-11-24 14:28:24','','yes'),(16,3,'www','A','180.96.86.192',NULL,'2014-11-23 17:59:19','2014-11-23 09:59:19','','yes'),(17,1,'www','A','192.168.1.118',NULL,'2014-11-24 22:24:17','2014-11-24 14:24:17','','yes'),(18,4,'','A','192.88.1.88',NULL,'2014-11-24 22:48:33','2014-11-24 15:33:27','测试泛解析','yes'),(19,4,'www','A','192.168.1.1',NULL,'2014-11-24 23:34:21','2014-11-24 15:34:21','www','yes');
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

-- Dump completed on 2014-11-26 23:31:55
