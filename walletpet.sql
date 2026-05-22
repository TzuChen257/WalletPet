CREATE DATABASE  IF NOT EXISTS `walletpet` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `walletpet`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: walletpet
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `account_transactions`
--

DROP TABLE IF EXISTS `account_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_transactions` (
  `account_trans_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_account_id` int NOT NULL,
  `to_account_id` int NOT NULL,
  `transaction_amount` decimal(12,2) NOT NULL,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_trans_id`),
  KEY `idx_account_trans_user_id` (`user_id`),
  KEY `idx_account_trans_from_account_id` (`from_account_id`),
  KEY `idx_account_trans_to_account_id` (`to_account_id`),
  CONSTRAINT `fk_account_trans_from` FOREIGN KEY (`from_account_id`) REFERENCES `accounts` (`account_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_account_trans_to` FOREIGN KEY (`to_account_id`) REFERENCES `accounts` (`account_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_account_trans_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_transactions`
--

LOCK TABLES `account_transactions` WRITE;
/*!40000 ALTER TABLE `account_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `is_liability` tinyint(1) NOT NULL DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `is_saving_account` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`),
  KEY `idx_accounts_user_id` (`user_id`),
  KEY `idx_accounts_is_saving_account` (`is_saving_account`),
  CONSTRAINT `fk_accounts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'demo_streak_9','現金',3305.00,0,0,0,'2026-05-18 08:30:00'),(2,'demo_streak_9','銀行',47850.00,0,0,0,'2026-05-18 08:30:00'),(3,'demo_streak_9','信用卡',-2329.00,1,0,0,'2026-05-18 08:30:00'),(4,'demo_absent_7','現金',5000.00,0,0,0,'2026-05-10 08:30:00'),(5,'demo_absent_7','銀行',30000.00,0,0,0,'2026-05-10 08:30:00'),(6,'demo_absent_7','信用卡',0.00,1,0,0,'2026-05-10 08:30:00');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `budget`
--

DROP TABLE IF EXISTS `budget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budget` (
  `budget_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `budget_scope` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `budget_amount` decimal(12,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`budget_id`),
  KEY `idx_budget_user_id` (`user_id`),
  KEY `idx_budget_category_id` (`category_id`),
  KEY `idx_budget_period` (`start_date`,`end_date`),
  CONSTRAINT `fk_budget_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_budget_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `budget`
--

LOCK TABLES `budget` WRITE;
/*!40000 ALTER TABLE `budget` DISABLE KEYS */;
/*!40000 ALTER TABLE `budget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `color` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_disable` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`category_id`),
  KEY `idx_categories_user_id` (`user_id`),
  KEY `idx_categories_type` (`category_type`),
  CONSTRAINT `fk_categories_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('CAT_DEMO_ABSENT_EXP_ENTERTAIN','demo_absent_7','娛樂','EXPENSE','game','#9C27B0',1,'2026-05-10 08:30:00',0),('CAT_DEMO_ABSENT_EXP_FOOD','demo_absent_7','餐飲','EXPENSE','food','#FF9800',1,'2026-05-10 08:30:00',0),('CAT_DEMO_ABSENT_EXP_SHOPPING','demo_absent_7','購物','EXPENSE','shopping','#E91E63',1,'2026-05-10 08:30:00',0),('CAT_DEMO_ABSENT_EXP_TRAFFIC','demo_absent_7','交通','EXPENSE','traffic','#03A9F4',1,'2026-05-10 08:30:00',0),('CAT_DEMO_ABSENT_INC_BONUS','demo_absent_7','獎金','INCOME','bonus','#8BC34A',1,'2026-05-10 08:30:00',0),('CAT_DEMO_ABSENT_INC_SALARY','demo_absent_7','薪資','INCOME','salary','#4CAF50',1,'2026-05-10 08:30:00',0),('CAT_DEMO_STREAK_EXP_ENTERTAIN','demo_streak_9','娛樂','EXPENSE','game','#9C27B0',1,'2026-05-18 08:30:00',0),('CAT_DEMO_STREAK_EXP_FOOD','demo_streak_9','餐飲','EXPENSE','food','#FF9800',1,'2026-05-18 08:30:00',0),('CAT_DEMO_STREAK_EXP_SHOPPING','demo_streak_9','購物','EXPENSE','shopping','#E91E63',1,'2026-05-18 08:30:00',0),('CAT_DEMO_STREAK_EXP_TRAFFIC','demo_streak_9','交通','EXPENSE','traffic','#03A9F4',1,'2026-05-18 08:30:00',0),('CAT_DEMO_STREAK_INC_BONUS','demo_streak_9','獎金','INCOME','bonus','#8BC34A',1,'2026-05-18 08:30:00',0),('CAT_DEMO_STREAK_INC_SALARY','demo_streak_9','薪資','INCOME','salary','#4CAF50',1,'2026-05-18 08:30:00',0);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_record_rewards`
--

DROP TABLE IF EXISTS `daily_record_rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_record_rewards` (
  `daily_reward_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reward_date` date NOT NULL,
  `qualified` tinyint(1) NOT NULL DEFAULT '0',
  `transaction_count` int NOT NULL DEFAULT '0',
  `streak_days` int NOT NULL DEFAULT '0',
  `reward_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reward_value` int DEFAULT NULL,
  `mood_delta` int NOT NULL DEFAULT '0',
  `cancan_delta` int NOT NULL DEFAULT '0',
  `claimed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`daily_reward_id`),
  UNIQUE KEY `uk_daily_reward_user_date` (`user_id`,`reward_date`),
  KEY `idx_daily_reward_user_id` (`user_id`),
  KEY `idx_daily_reward_reward_date` (`reward_date`),
  CONSTRAINT `fk_daily_reward_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_record_rewards`
--

LOCK TABLES `daily_record_rewards` WRITE;
/*!40000 ALTER TABLE `daily_record_rewards` DISABLE KEYS */;
INSERT INTO `daily_record_rewards` VALUES (1,'demo_streak_9','2026-05-18',1,3,1,'DAILY_RECORD',1,0,1,'2026-05-18 23:00:00','2026-05-18 23:00:00','2026-05-18 23:00:00'),(2,'demo_streak_9','2026-05-19',1,4,2,'DAILY_RECORD',1,0,1,'2026-05-19 23:00:00','2026-05-19 23:00:00','2026-05-19 23:00:00'),(3,'demo_streak_9','2026-05-20',1,2,3,'DAILY_RECORD_LOGIN_STREAK_3',6,0,6,'2026-05-20 23:00:00','2026-05-20 23:00:00','2026-05-20 23:00:00'),(4,'demo_streak_9','2026-05-21',1,5,4,'DAILY_RECORD',1,0,1,'2026-05-21 23:00:00','2026-05-21 23:00:00','2026-05-21 23:00:00'),(5,'demo_streak_9','2026-05-22',1,3,5,'DAILY_RECORD',1,0,1,'2026-05-22 23:00:00','2026-05-22 23:00:00','2026-05-22 23:00:00'),(6,'demo_streak_9','2026-05-23',1,4,6,'DAILY_RECORD',0,0,0,'2026-05-23 23:00:00','2026-05-23 23:00:00','2026-05-23 23:00:00'),(7,'demo_streak_9','2026-05-24',1,2,7,'DAILY_RECORD_LOGIN_STREAK_7',10,0,10,'2026-05-24 23:00:00','2026-05-24 23:00:00','2026-05-24 23:00:00'),(8,'demo_streak_9','2026-05-25',1,4,8,'DAILY_RECORD',0,0,0,'2026-05-25 23:00:00','2026-05-25 23:00:00','2026-05-25 23:00:00'),(9,'demo_streak_9','2026-05-26',1,3,9,'DAILY_RECORD',0,0,0,'2026-05-26 23:00:00','2026-05-26 23:00:00','2026-05-26 23:00:00');
/*!40000 ALTER TABLE `daily_record_rewards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet_events`
--

DROP TABLE IF EXISTS `pet_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_events` (
  `pet_event_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pet_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mood_delta` int DEFAULT NULL,
  `cancan_delta` int NOT NULL DEFAULT '0',
  `reward` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pet_event_id`),
  KEY `idx_pet_events_user_id` (`user_id`),
  KEY `idx_pet_events_pet_id` (`pet_id`),
  CONSTRAINT `fk_pet_events_pet` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`pet_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pet_events_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_events`
--

LOCK TABLES `pet_events` WRITE;
/*!40000 ALTER TABLE `pet_events` DISABLE KEYS */;
INSERT INTO `pet_events` VALUES (1,'demo_streak_9','PET_DEMO_STREAK_9','DAILY_RECORD_REWARD',0,1,'每日記帳獎勵：食物量 cancan +1','2026-05-18 23:00:00'),(2,'demo_streak_9','PET_DEMO_STREAK_9','DAILY_RECORD_REWARD',0,1,'每日記帳獎勵：食物量 cancan +1','2026-05-19 23:00:00'),(3,'demo_streak_9','PET_DEMO_STREAK_9','DAILY_RECORD_REWARD',0,1,'每日記帳獎勵：食物量 cancan +1','2026-05-20 23:00:00'),(4,'demo_streak_9','PET_DEMO_STREAK_9','LOGIN_STREAK_3',0,5,'連續登入第 3 天獎勵：食物量 cancan +5','2026-05-20 08:31:00'),(5,'demo_streak_9','PET_DEMO_STREAK_9','DAILY_RECORD_REWARD',0,1,'每日記帳獎勵：食物量 cancan +1','2026-05-21 23:00:00'),(6,'demo_streak_9','PET_DEMO_STREAK_9','DAILY_RECORD_REWARD',0,1,'每日記帳獎勵：食物量 cancan +1','2026-05-22 23:00:00'),(7,'demo_streak_9','PET_DEMO_STREAK_9','LOGIN_STREAK_7',0,10,'連續登入第 7 天獎勵：食物量 cancan +10','2026-05-24 08:31:00');
/*!40000 ALTER TABLE `pet_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet_model`
--

DROP TABLE IF EXISTS `pet_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_model` (
  `petmodel_id` int NOT NULL AUTO_INCREMENT,
  `rive_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`petmodel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet_model`
--

LOCK TABLES `pet_model` WRITE;
/*!40000 ALTER TABLE `pet_model` DISABLE KEYS */;
INSERT INTO `pet_model` VALUES (1,'基本貓咪','系統預設寵物模型');
/*!40000 ALTER TABLE `pet_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pets`
--

DROP TABLE IF EXISTS `pets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pets` (
  `pet_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pet_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mood` int NOT NULL DEFAULT '60',
  `cancan` int NOT NULL DEFAULT '0',
  `last_update_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_displayed` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `model_id` int NOT NULL,
  PRIMARY KEY (`pet_id`),
  KEY `idx_pets_user_id` (`user_id`),
  KEY `fk_pets_model_idx` (`model_id`),
  CONSTRAINT `fk_pets_model` FOREIGN KEY (`model_id`) REFERENCES `pet_model` (`petmodel_id`),
  CONSTRAINT `fk_pets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pets`
--

LOCK TABLES `pets` WRITE;
/*!40000 ALTER TABLE `pets` DISABLE KEYS */;
INSERT INTO `pets` VALUES ('PET_DEMO_ABSENT_7','demo_absent_7','缺席喵',60,0,'2026-05-19 08:30:00',1,'2026-05-10 08:30:00',1),('PET_DEMO_STREAK_9','demo_streak_9','Demo喵',60,20,'2026-05-26 20:05:00',1,'2026-05-18 08:30:00',1);
/*!40000 ALTER TABLE `pets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saving_goals`
--

DROP TABLE IF EXISTS `saving_goals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saving_goals` (
  `saving_goal_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `goal_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_amount` decimal(12,2) NOT NULL,
  `final_account_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `final_amount` decimal(12,2) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` int NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`saving_goal_id`),
  UNIQUE KEY `uk_saving_goals_account_id` (`account_id`),
  KEY `idx_saving_goals_user_id` (`user_id`),
  CONSTRAINT `fk_saving_goals_account` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_saving_goals_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saving_goals`
--

LOCK TABLES `saving_goals` WRITE;
/*!40000 ALTER TABLE `saving_goals` DISABLE KEYS */;
/*!40000 ALTER TABLE `saving_goals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` int NOT NULL,
  `category_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_amount` decimal(12,2) NOT NULL,
  `transaction_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `idx_transactions_user_id` (`user_id`),
  KEY `idx_transactions_account_id` (`account_id`),
  KEY `idx_transactions_category_id` (`category_id`),
  KEY `idx_transactions_date` (`transaction_date`),
  CONSTRAINT `fk_transactions_account` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_transactions_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_transactions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES ('TXN_DEMO_001','demo_streak_9',2,'CAT_DEMO_STREAK_INC_SALARY',30000.00,'INCOME','五月薪資入帳','2026-05-18','2026-05-18 09:00:00'),('TXN_DEMO_002','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_FOOD',120.00,'EXPENSE','早餐與咖啡','2026-05-18','2026-05-18 12:10:00'),('TXN_DEMO_003','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_TRAFFIC',50.00,'EXPENSE','捷運加值','2026-05-18','2026-05-18 18:20:00'),('TXN_DEMO_004','demo_streak_9',2,'CAT_DEMO_STREAK_EXP_SHOPPING',8000.00,'EXPENSE','房租','2026-05-19','2026-05-19 09:30:00'),('TXN_DEMO_005','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_FOOD',180.00,'EXPENSE','午餐','2026-05-19','2026-05-19 12:30:00'),('TXN_DEMO_006','demo_streak_9',3,'CAT_DEMO_STREAK_EXP_SHOPPING',690.00,'EXPENSE','生活用品','2026-05-19','2026-05-19 20:00:00'),('TXN_DEMO_007','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_TRAFFIC',35.00,'EXPENSE','公車','2026-05-19','2026-05-19 21:00:00'),('TXN_DEMO_008','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_FOOD',95.00,'EXPENSE','早餐','2026-05-20','2026-05-20 08:50:00'),('TXN_DEMO_009','demo_streak_9',2,'CAT_DEMO_STREAK_EXP_ENTERTAIN',320.00,'EXPENSE','電影票','2026-05-20','2026-05-20 19:40:00'),('TXN_DEMO_010','demo_streak_9',2,'CAT_DEMO_STREAK_EXP_SHOPPING',1500.00,'EXPENSE','課程教材','2026-05-21','2026-05-21 10:15:00'),('TXN_DEMO_011','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_FOOD',150.00,'EXPENSE','午餐','2026-05-21','2026-05-21 12:20:00'),('TXN_DEMO_012','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_TRAFFIC',60.00,'EXPENSE','交通費','2026-05-21','2026-05-21 18:15:00'),('TXN_DEMO_013','demo_streak_9',3,'CAT_DEMO_STREAK_EXP_ENTERTAIN',250.00,'EXPENSE','手遊小額消費','2026-05-21','2026-05-21 21:30:00'),('TXN_DEMO_014','demo_streak_9',2,'CAT_DEMO_STREAK_INC_BONUS',500.00,'INCOME','專案小獎金','2026-05-21','2026-05-21 22:00:00'),('TXN_DEMO_015','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_FOOD',130.00,'EXPENSE','早餐','2026-05-22','2026-05-22 09:10:00'),('TXN_DEMO_016','demo_streak_9',2,'CAT_DEMO_STREAK_EXP_SHOPPING',780.00,'EXPENSE','日用品補貨','2026-05-22','2026-05-22 15:20:00'),('TXN_DEMO_017','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_FOOD',220.00,'EXPENSE','晚餐','2026-05-22','2026-05-22 19:00:00'),('TXN_DEMO_018','demo_streak_9',2,'CAT_DEMO_STREAK_EXP_TRAFFIC',1200.00,'EXPENSE','高鐵票','2026-05-23','2026-05-23 08:00:00'),('TXN_DEMO_019','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_FOOD',160.00,'EXPENSE','便當','2026-05-23','2026-05-23 12:10:00'),('TXN_DEMO_020','demo_streak_9',3,'CAT_DEMO_STREAK_EXP_SHOPPING',990.00,'EXPENSE','線上購物','2026-05-23','2026-05-23 16:50:00'),('TXN_DEMO_021','demo_streak_9',2,'CAT_DEMO_STREAK_INC_BONUS',1500.00,'INCOME','兼職收入','2026-05-23','2026-05-23 22:20:00'),('TXN_DEMO_022','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_FOOD',200.00,'EXPENSE','早午餐','2026-05-24','2026-05-24 10:45:00'),('TXN_DEMO_023','demo_streak_9',2,'CAT_DEMO_STREAK_EXP_ENTERTAIN',450.00,'EXPENSE','展覽門票','2026-05-24','2026-05-24 15:30:00'),('TXN_DEMO_024','demo_streak_9',2,'CAT_DEMO_STREAK_EXP_SHOPPING',2300.00,'EXPENSE','家用品','2026-05-25','2026-05-25 11:10:00'),('TXN_DEMO_025','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_FOOD',110.00,'EXPENSE','早餐','2026-05-25','2026-05-25 08:20:00'),('TXN_DEMO_026','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_TRAFFIC',45.00,'EXPENSE','公車','2026-05-25','2026-05-25 18:00:00'),('TXN_DEMO_027','demo_streak_9',3,'CAT_DEMO_STREAK_EXP_ENTERTAIN',399.00,'EXPENSE','串流訂閱','2026-05-25','2026-05-25 20:30:00'),('TXN_DEMO_028','demo_streak_9',1,'CAT_DEMO_STREAK_EXP_FOOD',140.00,'EXPENSE','午餐','2026-05-26','2026-05-26 12:00:00'),('TXN_DEMO_029','demo_streak_9',2,'CAT_DEMO_STREAK_EXP_TRAFFIC',600.00,'EXPENSE','油錢','2026-05-26','2026-05-26 17:30:00'),('TXN_DEMO_030','demo_streak_9',2,'CAT_DEMO_STREAK_INC_BONUS',1000.00,'INCOME','臨時收入','2026-05-26','2026-05-26 20:00:00');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login_logs`
--

DROP TABLE IF EXISTS `user_login_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login_logs` (
  `login_log_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `login_date` date NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`login_log_id`),
  UNIQUE KEY `uk_user_login_logs_user_date` (`user_id`,`login_date`),
  KEY `idx_user_login_logs_user_id` (`user_id`),
  KEY `idx_user_login_logs_login_date` (`login_date`),
  CONSTRAINT `fk_user_login_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login_logs`
--

LOCK TABLES `user_login_logs` WRITE;
/*!40000 ALTER TABLE `user_login_logs` DISABLE KEYS */;
INSERT INTO `user_login_logs` VALUES (1,'demo_streak_9','2026-05-18','2026-05-18 08:30:00'),(2,'demo_streak_9','2026-05-19','2026-05-19 08:30:00'),(3,'demo_streak_9','2026-05-20','2026-05-20 08:30:00'),(4,'demo_streak_9','2026-05-21','2026-05-21 08:30:00'),(5,'demo_streak_9','2026-05-22','2026-05-22 08:30:00'),(6,'demo_streak_9','2026-05-23','2026-05-23 08:30:00'),(7,'demo_streak_9','2026-05-24','2026-05-24 08:30:00'),(8,'demo_streak_9','2026-05-25','2026-05-25 08:30:00'),(9,'demo_streak_9','2026-05-26','2026-05-26 08:30:00'),(10,'demo_absent_7','2026-05-19','2026-05-19 08:30:00');
/*!40000 ALTER TABLE `user_login_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USER',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uk_users_user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin123','admin','admin123@gmail.com','1234','2026-05-05 03:14:32','ADMIN'),('demo_absent_7','absent','demo_absent_7@walletpet.test','123456','2026-05-10 08:30:00','USER'),('demo_streak_9','demo','demo_streak_9@walletpet.test','123456','2026-05-18 08:30:00','USER');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-21 16:57:01
