-- MySQL dump 10.13  Distrib 8.0.16, for osx10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: acrsupply
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acr_assetindexdata`
--

DROP TABLE IF EXISTS `acr_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `acr_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `acr_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `acr_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_assets`
--

DROP TABLE IF EXISTS `acr_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_assets_folderId_idx` (`folderId`),
  KEY `acr_assets_volumeId_idx` (`volumeId`),
  KEY `acr_assets_volumeId_keptFile_idx` (`volumeId`,`keptFile`),
  CONSTRAINT `acr_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `acr_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `acr_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_assettransformindex`
--

DROP TABLE IF EXISTS `acr_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_assettransforms`
--

DROP TABLE IF EXISTS `acr_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `acr_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_calendar_calendar_sites`
--

DROP TABLE IF EXISTS `acr_calendar_calendar_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_calendar_calendar_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `calendarId` int(11) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `enabledByDefault` tinyint(1) DEFAULT '1',
  `hasUrls` tinyint(1) DEFAULT '0',
  `uriFormat` varchar(255) DEFAULT NULL,
  `template` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `calendar_calendar_sites_calendarId_siteId_unq_idx` (`calendarId`,`siteId`),
  KEY `calendar_calendar_sites_siteId_fk` (`siteId`),
  CONSTRAINT `calendar_calendar_sites_calendarId_fk` FOREIGN KEY (`calendarId`) REFERENCES `acr_calendar_calendars` (`id`) ON DELETE CASCADE,
  CONSTRAINT `calendar_calendar_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_calendar_calendars`
--

DROP TABLE IF EXISTS `acr_calendar_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_calendar_calendars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `handle` varchar(100) NOT NULL,
  `description` text,
  `color` varchar(10) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `titleFormat` varchar(255) DEFAULT NULL,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `descriptionFieldHandle` varchar(255) DEFAULT NULL,
  `locationFieldHandle` varchar(255) DEFAULT NULL,
  `icsHash` varchar(255) DEFAULT NULL,
  `icsTimezone` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`),
  UNIQUE KEY `calendar_calendars_name_unq_idx` (`name`),
  UNIQUE KEY `calendar_calendars_handle_unq_idx` (`handle`),
  UNIQUE KEY `calendar_calendars_icsHash_unq_idx` (`icsHash`),
  KEY `calendar_calendars_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `calendar_calendars_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_calendar_events`
--

DROP TABLE IF EXISTS `acr_calendar_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_calendar_events` (
  `id` int(11) NOT NULL,
  `calendarId` int(11) DEFAULT NULL,
  `authorId` int(11) DEFAULT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `allDay` tinyint(1) DEFAULT NULL,
  `rrule` varchar(255) DEFAULT NULL,
  `freq` varchar(255) DEFAULT NULL,
  `interval` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `until` datetime DEFAULT NULL,
  `byMonth` varchar(255) DEFAULT NULL,
  `byYearDay` varchar(255) DEFAULT NULL,
  `byMonthDay` varchar(255) DEFAULT NULL,
  `byDay` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  UNIQUE KEY `calendar_events_id_unq_idx` (`id`),
  KEY `calendar_events_calendarId_idx` (`calendarId`),
  KEY `calendar_events_authorId_idx` (`authorId`),
  KEY `calendar_events_startDate_idx` (`startDate`),
  KEY `calendar_events_endDate_idx` (`endDate`),
  KEY `calendar_events_startDate_endDate_idx` (`startDate`,`endDate`),
  KEY `calendar_events_until_idx` (`until`),
  CONSTRAINT `calendar_events_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `acr_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `calendar_events_calendarId_fk` FOREIGN KEY (`calendarId`) REFERENCES `acr_calendar_calendars` (`id`) ON DELETE CASCADE,
  CONSTRAINT `calendar_events_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_calendar_exceptions`
--

DROP TABLE IF EXISTS `acr_calendar_exceptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_calendar_exceptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `eventId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `calendar_exceptions_exceptions_eventId_date_idx` (`eventId`,`date`),
  CONSTRAINT `calendar_exceptions_eventId_fk` FOREIGN KEY (`eventId`) REFERENCES `acr_calendar_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_calendar_select_dates`
--

DROP TABLE IF EXISTS `acr_calendar_select_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_calendar_select_dates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `eventId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `calendar_select_dates_select_dates_eventId_date_idx` (`eventId`,`date`),
  CONSTRAINT `calendar_select_dates_eventId_fk` FOREIGN KEY (`eventId`) REFERENCES `acr_calendar_events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_categories`
--

DROP TABLE IF EXISTS `acr_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_categories_groupId_idx` (`groupId`),
  KEY `acr_categories_parentId_fk` (`parentId`),
  CONSTRAINT `acr_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `acr_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `acr_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_categorygroups`
--

DROP TABLE IF EXISTS `acr_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_categorygroups_structureId_idx` (`structureId`),
  KEY `acr_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_categorygroups_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_categorygroups_name_idx` (`name`),
  KEY `acr_categorygroups_handle_idx` (`handle`),
  CONSTRAINT `acr_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `acr_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `acr_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_categorygroups_sites`
--

DROP TABLE IF EXISTS `acr_categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `acr_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `acr_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `acr_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_content`
--

DROP TABLE IF EXISTS `acr_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_pageLink` text,
  `field_notificationText` text,
  `field_notificationLink` text,
  `field_servicesTitle` text,
  `field_servicesDescription` text,
  `field_testimonialAuthor` text,
  `field_testimonalcontent` text,
  `field_newsletterTitle` text,
  `field_newsletterDescription` text,
  `field_externalLink` varchar(255) DEFAULT NULL,
  `field_appleStoreLink` varchar(255) DEFAULT NULL,
  `field_googlePlayStoreLink` varchar(255) DEFAULT NULL,
  `field_facebookLink` varchar(255) DEFAULT NULL,
  `field_footerTagline` text,
  `field_connectedForm` int(11) DEFAULT NULL,
  `field_location` text,
  `field_description` text,
  `field_eventPrice` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_content_siteId_idx` (`siteId`),
  KEY `acr_content_title_idx` (`title`),
  CONSTRAINT `acr_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_craftidtokens`
--

DROP TABLE IF EXISTS `acr_craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `acr_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `acr_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_deprecationerrors`
--

DROP TABLE IF EXISTS `acr_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_elementindexsettings`
--

DROP TABLE IF EXISTS `acr_elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_elements`
--

DROP TABLE IF EXISTS `acr_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_elements_type_idx` (`type`),
  KEY `acr_elements_enabled_idx` (`enabled`),
  KEY `acr_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `acr_elements_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `acr_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_elements_sites`
--

DROP TABLE IF EXISTS `acr_elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_elements_sites_siteId_idx` (`siteId`),
  KEY `acr_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `acr_elements_sites_enabled_idx` (`enabled`),
  KEY `acr_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `acr_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=316 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_entries`
--

DROP TABLE IF EXISTS `acr_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_entries_postDate_idx` (`postDate`),
  KEY `acr_entries_expiryDate_idx` (`expiryDate`),
  KEY `acr_entries_authorId_idx` (`authorId`),
  KEY `acr_entries_sectionId_idx` (`sectionId`),
  KEY `acr_entries_typeId_idx` (`typeId`),
  KEY `acr_entries_parentId_fk` (`parentId`),
  CONSTRAINT `acr_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `acr_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `acr_entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `acr_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `acr_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `acr_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_entrydrafts`
--

DROP TABLE IF EXISTS `acr_entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_entrydrafts_sectionId_idx` (`sectionId`),
  KEY `acr_entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `acr_entrydrafts_siteId_idx` (`siteId`),
  KEY `acr_entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `acr_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `acr_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `acr_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `acr_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_entrytypes`
--

DROP TABLE IF EXISTS `acr_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_entrytypes_sectionId_idx` (`sectionId`),
  KEY `acr_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_entrytypes_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `acr_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  CONSTRAINT `acr_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `acr_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `acr_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_entryversions`
--

DROP TABLE IF EXISTS `acr_entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_entryversions_sectionId_idx` (`sectionId`),
  KEY `acr_entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `acr_entryversions_siteId_idx` (`siteId`),
  KEY `acr_entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `acr_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `acr_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `acr_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `acr_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `acr_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_fieldgroups`
--

DROP TABLE IF EXISTS `acr_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_fieldlayoutfields`
--

DROP TABLE IF EXISTS `acr_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `acr_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `acr_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `acr_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `acr_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `acr_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `acr_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_fieldlayouts`
--

DROP TABLE IF EXISTS `acr_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_fieldlayouts_type_idx` (`type`),
  KEY `acr_fieldlayouts_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_fieldlayouttabs`
--

DROP TABLE IF EXISTS `acr_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `acr_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `acr_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_fields`
--

DROP TABLE IF EXISTS `acr_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `acr_fields_groupId_idx` (`groupId`),
  KEY `acr_fields_context_idx` (`context`),
  CONSTRAINT `acr_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `acr_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_crm_fields`
--

DROP TABLE IF EXISTS `acr_freeform_crm_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_crm_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `integrationId` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `freeform_crm_fields_type_idx` (`type`),
  KEY `freeform_crm_fields_integrationId_fk` (`integrationId`),
  CONSTRAINT `freeform_crm_fields_integrationId_fk` FOREIGN KEY (`integrationId`) REFERENCES `acr_freeform_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_fields`
--

DROP TABLE IF EXISTS `acr_freeform_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `required` tinyint(1) DEFAULT '0',
  `instructions` text,
  `metaProperties` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`),
  KEY `freeform_fields_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_forms`
--

DROP TABLE IF EXISTS `acr_freeform_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `handle` varchar(100) NOT NULL,
  `spamBlockCount` int(11) unsigned NOT NULL DEFAULT '0',
  `submissionTitleFormat` varchar(255) NOT NULL,
  `description` text,
  `layoutJson` mediumtext,
  `returnUrl` varchar(255) DEFAULT NULL,
  `defaultStatus` int(11) unsigned DEFAULT NULL,
  `formTemplateId` int(11) unsigned DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  `optInDataStorageTargetHash` varchar(20) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_integrations`
--

DROP TABLE IF EXISTS `acr_freeform_integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_integrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `class` varchar(255) DEFAULT NULL,
  `accessToken` varchar(255) DEFAULT NULL,
  `settings` text,
  `forceUpdate` tinyint(1) DEFAULT '0',
  `lastUpdate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`),
  KEY `freeform_integrations_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_integrations_queue`
--

DROP TABLE IF EXISTS `acr_freeform_integrations_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_integrations_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submissionId` int(11) NOT NULL,
  `integrationType` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `fieldHash` varchar(20) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `freeform_integrations_queue_status_unq_idx` (`status`),
  KEY `freeform_integrations_queue_submissionId_fk` (`submissionId`),
  CONSTRAINT `freeform_integrations_queue_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_freeform_mailing_list_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_integrations_queue_submissionId_fk` FOREIGN KEY (`submissionId`) REFERENCES `acr_freeform_submissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_mailing_list_fields`
--

DROP TABLE IF EXISTS `acr_freeform_mailing_list_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_mailing_list_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mailingListId` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `freeform_mailing_list_fields_type_idx` (`type`),
  KEY `freeform_mailing_list_fields_mailingListId_fk` (`mailingListId`),
  CONSTRAINT `freeform_mailing_list_fields_mailingListId_fk` FOREIGN KEY (`mailingListId`) REFERENCES `acr_freeform_mailing_lists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_mailing_lists`
--

DROP TABLE IF EXISTS `acr_freeform_mailing_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_mailing_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `integrationId` int(11) NOT NULL,
  `resourceId` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `memberCount` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `freeform_mailing_lists_integrationId_resourceId_unq_idx` (`integrationId`,`resourceId`),
  CONSTRAINT `freeform_mailing_lists_integrationId_fk` FOREIGN KEY (`integrationId`) REFERENCES `acr_freeform_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_notifications`
--

DROP TABLE IF EXISTS `acr_freeform_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `description` text,
  `fromName` varchar(255) NOT NULL,
  `fromEmail` varchar(255) NOT NULL,
  `replyToEmail` varchar(255) DEFAULT NULL,
  `bodyHtml` text,
  `bodyText` text,
  `includeAttachments` tinyint(1) DEFAULT '1',
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_payment_gateway_fields`
--

DROP TABLE IF EXISTS `acr_freeform_payment_gateway_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_payment_gateway_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `integrationId` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `required` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `freeform_payment_gateway_fields_type_idx` (`type`),
  KEY `freeform_payment_gateway_fields_integrationId_fk` (`integrationId`),
  CONSTRAINT `freeform_payment_gateway_fields_integrationId_fk` FOREIGN KEY (`integrationId`) REFERENCES `acr_freeform_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_statuses`
--

DROP TABLE IF EXISTS `acr_freeform_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `color` varchar(30) DEFAULT NULL,
  `isDefault` tinyint(1) DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `handle` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_submissions`
--

DROP TABLE IF EXISTS `acr_freeform_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_submissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incrementalId` int(11) NOT NULL,
  `statusId` int(11) DEFAULT NULL,
  `formId` int(11) NOT NULL,
  `token` varchar(100) NOT NULL,
  `ip` varchar(46) DEFAULT NULL,
  `isSpam` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_1` varchar(100) DEFAULT NULL,
  `field_2` varchar(100) DEFAULT NULL,
  `field_3` text,
  `field_4` varchar(100) DEFAULT NULL,
  `field_5` varchar(100) DEFAULT NULL,
  `field_6` varchar(100) DEFAULT NULL,
  `field_7` varchar(100) DEFAULT NULL,
  `field_8` text,
  `field_9` varchar(100) DEFAULT NULL,
  `field_10` varchar(100) DEFAULT NULL,
  `field_11` varchar(100) DEFAULT NULL,
  `field_12` text,
  `field_13` varchar(100) DEFAULT NULL,
  `field_14` varchar(100) DEFAULT NULL,
  `field_15` text,
  `field_16` varchar(100) DEFAULT NULL,
  `field_17` varchar(100) DEFAULT NULL,
  `field_18` text,
  `field_19` varchar(100) DEFAULT NULL,
  `field_20` varchar(100) DEFAULT NULL,
  `field_21` varchar(100) DEFAULT NULL,
  `field_22` varchar(100) DEFAULT NULL,
  `field_23` varchar(100) DEFAULT NULL,
  `field_24` text,
  `field_25` varchar(100) DEFAULT NULL,
  `field_27` varchar(100) DEFAULT NULL,
  `field_28` varchar(100) DEFAULT NULL,
  `field_29` varchar(100) DEFAULT NULL,
  `field_30` varchar(100) DEFAULT NULL,
  `field_31` varchar(100) DEFAULT NULL,
  `field_32` varchar(100) DEFAULT NULL,
  `field_33` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `freeform_submissions_incrementalId_unq_idx` (`incrementalId`),
  UNIQUE KEY `freeform_submissions_token_unq_idx` (`token`),
  KEY `freeform_submissions_formId_fk` (`formId`),
  KEY `freeform_submissions_statusId_fk` (`statusId`),
  CONSTRAINT `freeform_submissions_formId_fk` FOREIGN KEY (`formId`) REFERENCES `acr_freeform_forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_submissions_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `freeform_submissions_statusId_fk` FOREIGN KEY (`statusId`) REFERENCES `acr_freeform_statuses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_unfinalized_files`
--

DROP TABLE IF EXISTS `acr_freeform_unfinalized_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_freeform_unfinalized_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_globalsets`
--

DROP TABLE IF EXISTS `acr_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_globalsets_name_idx` (`name`),
  KEY `acr_globalsets_handle_idx` (`handle`),
  CONSTRAINT `acr_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `acr_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_info`
--

DROP TABLE IF EXISTS `acr_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixblocks`
--

DROP TABLE IF EXISTS `acr_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `acr_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `acr_matrixblocks_typeId_idx` (`typeId`),
  KEY `acr_matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `acr_matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `acr_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `acr_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `acr_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `acr_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixblocktypes`
--

DROP TABLE IF EXISTS `acr_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `acr_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `acr_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `acr_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `acr_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `acr_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixcontent_acrcaresinitiatives`
--

DROP TABLE IF EXISTS `acr_matrixcontent_acrcaresinitiatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_matrixcontent_acrcaresinitiatives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_initiative_initiativeTitle` text,
  `field_initiative_initiativeDescription` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_matrixcontent_acrcaresinitiatives_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_matrixcontent_acrcaresinitiatives_siteId_fk` (`siteId`),
  CONSTRAINT `acr_matrixcontent_acrcaresinitiatives_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixcontent_acrcaresinitiatives_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixcontent_ctas`
--

DROP TABLE IF EXISTS `acr_matrixcontent_ctas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_matrixcontent_ctas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_callToAction_callToActionTitle` text,
  `field_callToAction_callToActionDescription` text,
  `field_callToAction_callToActionBackgroundColor` varchar(255) DEFAULT NULL,
  `field_callToAction_callToActionLink` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_matrixcontent_ctas_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_matrixcontent_ctas_siteId_fk` (`siteId`),
  CONSTRAINT `acr_matrixcontent_ctas_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixcontent_ctas_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixcontent_locations`
--

DROP TABLE IF EXISTS `acr_matrixcontent_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_matrixcontent_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_storeLocation_locationName` text,
  `field_storeLocation_address` text,
  `field_storeLocation_phoneNumber` text,
  `field_storeLocation_googleMapLink` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_matrixcontent_locations_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_matrixcontent_locations_siteId_fk` (`siteId`),
  CONSTRAINT `acr_matrixcontent_locations_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixcontent_locations_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixcontent_scholarshiprecipients`
--

DROP TABLE IF EXISTS `acr_matrixcontent_scholarshiprecipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_matrixcontent_scholarshiprecipients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_recipient_recipientName` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_matrixcontent_scholarshiprecipients_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_matrixcontent_scholarshiprecipients_siteId_fk` (`siteId`),
  CONSTRAINT `acr_matrixcontent_scholarshiprecipients_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixcontent_scholarshiprecipients_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixcontent_services`
--

DROP TABLE IF EXISTS `acr_matrixcontent_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_matrixcontent_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_service_serviceTitle` text,
  `field_service_serviceDescription` text,
  `field_service_serviceLink` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_matrixcontent_services_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_matrixcontent_services_siteId_fk` (`siteId`),
  CONSTRAINT `acr_matrixcontent_services_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixcontent_services_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixcontent_surveyresults`
--

DROP TABLE IF EXISTS `acr_matrixcontent_surveyresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_matrixcontent_surveyresults` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_result_resultContent` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_matrixcontent_surveyresults_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_matrixcontent_surveyresults_siteId_fk` (`siteId`),
  CONSTRAINT `acr_matrixcontent_surveyresults_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixcontent_surveyresults_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixcontent_teammemberinitiatives`
--

DROP TABLE IF EXISTS `acr_matrixcontent_teammemberinitiatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_matrixcontent_teammemberinitiatives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_teamInitiative_initiativeTitle` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_matrixcontent_teammemberinitiatives_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_matrixcontent_teammemberinitiatives_siteId_fk` (`siteId`),
  CONSTRAINT `acr_matrixcontent_teammemberinitiatives_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixcontent_teammemberinitiatives_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixcontent_vendors`
--

DROP TABLE IF EXISTS `acr_matrixcontent_vendors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_matrixcontent_vendors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_vendor_vendorName` text,
  `field_vendor_vendorDescription` text,
  `field_vendor_vendorLink` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_matrixcontent_vendors_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_matrixcontent_vendors_siteId_fk` (`siteId`),
  CONSTRAINT `acr_matrixcontent_vendors_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_matrixcontent_vendors_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_migrations`
--

DROP TABLE IF EXISTS `acr_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_migrations_pluginId_idx` (`pluginId`),
  KEY `acr_migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `acr_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `acr_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_plugins`
--

DROP TABLE IF EXISTS `acr_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_queue`
--

DROP TABLE IF EXISTS `acr_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `acr_queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `acr_queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_relations`
--

DROP TABLE IF EXISTS `acr_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `acr_relations_sourceId_idx` (`sourceId`),
  KEY `acr_relations_targetId_idx` (`targetId`),
  KEY `acr_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `acr_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `acr_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `acr_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_resourcepaths`
--

DROP TABLE IF EXISTS `acr_resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_searchindex`
--

DROP TABLE IF EXISTS `acr_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `acr_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_sections`
--

DROP TABLE IF EXISTS `acr_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_sections_structureId_idx` (`structureId`),
  KEY `acr_sections_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_sections_name_idx` (`name`),
  KEY `acr_sections_handle_idx` (`handle`),
  CONSTRAINT `acr_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `acr_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_sections_sites`
--

DROP TABLE IF EXISTS `acr_sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `acr_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `acr_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `acr_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_sequences`
--

DROP TABLE IF EXISTS `acr_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_sessions`
--

DROP TABLE IF EXISTS `acr_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_sessions_uid_idx` (`uid`),
  KEY `acr_sessions_token_idx` (`token`),
  KEY `acr_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `acr_sessions_userId_idx` (`userId`),
  CONSTRAINT `acr_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `acr_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_shunnedmessages`
--

DROP TABLE IF EXISTS `acr_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `acr_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `acr_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_sitegroups`
--

DROP TABLE IF EXISTS `acr_sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_sitegroups_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_sites`
--

DROP TABLE IF EXISTS `acr_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_sites_sortOrder_idx` (`sortOrder`),
  KEY `acr_sites_groupId_fk` (`groupId`),
  KEY `acr_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_sites_handle_idx` (`handle`),
  CONSTRAINT `acr_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `acr_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_structureelements`
--

DROP TABLE IF EXISTS `acr_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `acr_structureelements_root_idx` (`root`),
  KEY `acr_structureelements_lft_idx` (`lft`),
  KEY `acr_structureelements_rgt_idx` (`rgt`),
  KEY `acr_structureelements_level_idx` (`level`),
  KEY `acr_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `acr_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `acr_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_structures`
--

DROP TABLE IF EXISTS `acr_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_systemmessages`
--

DROP TABLE IF EXISTS `acr_systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `acr_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_taggroups`
--

DROP TABLE IF EXISTS `acr_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  KEY `acr_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_taggroups_name_idx` (`name`),
  KEY `acr_taggroups_handle_idx` (`handle`),
  CONSTRAINT `acr_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_tags`
--

DROP TABLE IF EXISTS `acr_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_tags_groupId_idx` (`groupId`),
  CONSTRAINT `acr_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `acr_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_templatecacheelements`
--

DROP TABLE IF EXISTS `acr_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `acr_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `acr_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `acr_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `acr_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_templatecachequeries`
--

DROP TABLE IF EXISTS `acr_templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `acr_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `acr_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `acr_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `acr_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_templatecaches`
--

DROP TABLE IF EXISTS `acr_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `acr_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `acr_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `acr_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `acr_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_tokens`
--

DROP TABLE IF EXISTS `acr_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_tokens_token_unq_idx` (`token`),
  KEY `acr_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_usergroups`
--

DROP TABLE IF EXISTS `acr_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `acr_usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_usergroups_users`
--

DROP TABLE IF EXISTS `acr_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `acr_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `acr_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `acr_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `acr_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_userpermissions`
--

DROP TABLE IF EXISTS `acr_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `acr_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `acr_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `acr_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `acr_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `acr_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_userpermissions_users`
--

DROP TABLE IF EXISTS `acr_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `acr_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `acr_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `acr_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `acr_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_userpreferences`
--

DROP TABLE IF EXISTS `acr_userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `acr_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `acr_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_users`
--

DROP TABLE IF EXISTS `acr_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_users_uid_idx` (`uid`),
  KEY `acr_users_verificationCode_idx` (`verificationCode`),
  KEY `acr_users_email_idx` (`email`),
  KEY `acr_users_username_idx` (`username`),
  KEY `acr_users_photoId_fk` (`photoId`),
  CONSTRAINT `acr_users_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `acr_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_volumefolders`
--

DROP TABLE IF EXISTS `acr_volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `acr_volumefolders_parentId_idx` (`parentId`),
  KEY `acr_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `acr_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `acr_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `acr_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_volumes`
--

DROP TABLE IF EXISTS `acr_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_volumes_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_volumes_name_idx` (`name`),
  KEY `acr_volumes_handle_idx` (`handle`),
  CONSTRAINT `acr_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_widgets`
--

DROP TABLE IF EXISTS `acr_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `acr_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `acr_widgets_userId_idx` (`userId`),
  CONSTRAINT `acr_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `acr_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrydrafts`
--

DROP TABLE IF EXISTS `entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entryversions`
--

DROP TABLE IF EXISTS `entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'acrsupply'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-11 11:36:03
-- MySQL dump 10.13  Distrib 8.0.16, for osx10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: acrsupply
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `acr_assets`
--

LOCK TABLES `acr_assets` WRITE;
/*!40000 ALTER TABLE `acr_assets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_assets` VALUES (5,1,1,'white-logo-notag.png','image',175,60,42214,NULL,NULL,NULL,'2018-10-08 23:50:14','2018-10-08 23:50:14','2018-10-08 23:50:14','40fe6249-57c2-473b-926c-f1d52dda789f'),(9,1,1,'Oct-18-Web-Promo.jpg','image',2500,917,816039,NULL,NULL,NULL,'2018-10-24 01:14:03','2018-10-24 01:14:03','2018-10-24 01:14:03','fbb81cda-b24d-41e6-9979-902b4ac54037'),(15,1,1,'building-lights-bw.png','image',721,475,333096,NULL,NULL,NULL,'2018-12-08 01:31:52','2018-12-08 01:31:52','2018-12-08 01:31:52','32cc588c-239b-49c1-be46-bfa9cc4919e0'),(61,1,4,'slider.png','image',1440,449,481175,NULL,NULL,NULL,'2019-01-27 17:55:11','2019-01-27 17:55:02','2019-01-27 17:55:11','ddefc3c6-86aa-4229-8b24-02ccfdfe19d3'),(62,2,5,'slider.png','image',1440,449,481175,NULL,NULL,NULL,'2019-01-27 18:01:58','2019-01-27 18:01:58','2019-01-27 18:01:58','262bbd08-ee0b-41e1-85b0-6a1340786595'),(63,2,5,'DEC18-Web-Promo.jpg','image',2500,917,1163743,NULL,NULL,NULL,'2019-01-27 18:14:58','2019-01-27 18:14:58','2019-01-27 18:14:58','16560535-21f7-42a1-89da-a4f704a89bd3'),(65,2,5,'Warehouse.jpg','image',900,550,171123,NULL,NULL,NULL,'2019-01-27 18:23:01','2019-01-27 18:23:01','2019-01-27 18:23:01','05acca82-7c99-47c7-8473-ef7d48b9fc3f'),(66,2,5,'Training-Lab.jpg','image',900,550,103454,NULL,NULL,NULL,'2019-01-27 18:23:12','2019-01-27 18:23:12','2019-01-27 18:23:12','9611b3a5-d634-43b5-a831-781eb21c778a'),(147,1,4,'BCWI_Certified_2018_Clear-e1533605047308.png','image',100,85,8631,NULL,NULL,NULL,'2019-02-09 21:37:07','2019-02-09 21:37:07','2019-02-09 21:37:07','af675d19-75e1-4980-88fc-f988f8b3f769');
/*!40000 ALTER TABLE `acr_assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_assettransforms`
--

LOCK TABLES `acr_assettransforms` WRITE;
/*!40000 ALTER TABLE `acr_assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_calendar_calendar_sites`
--

LOCK TABLES `acr_calendar_calendar_sites` WRITE;
/*!40000 ALTER TABLE `acr_calendar_calendar_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_calendar_calendar_sites` VALUES (1,1,1,1,1,'calendar/event/{slug}','calendar/event','2019-03-24 19:23:12','2019-05-11 14:04:29','49d643b4-e661-4341-8420-c299f9018bad');
/*!40000 ALTER TABLE `acr_calendar_calendar_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_calendar_calendars`
--

LOCK TABLES `acr_calendar_calendars` WRITE;
/*!40000 ALTER TABLE `acr_calendar_calendars` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_calendar_calendars` VALUES (1,'ACR Supply Events','events','The calendar for all ACR Supply events','#0EFCD9',26,'','Title',1,'0','0',NULL,'floating','2019-03-24 19:23:12','2019-05-11 14:04:29','6ef5064d-c54f-4d33-ac69-4989df2710c3');
/*!40000 ALTER TABLE `acr_calendar_calendars` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_calendar_events`
--

LOCK TABLES `acr_calendar_events` WRITE;
/*!40000 ALTER TABLE `acr_calendar_events` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_calendar_events` VALUES (220,1,1,'2019-03-26 17:30:00','2019-03-26 19:30:00',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-24 19:27:06','2019-05-11 14:04:31','f1f21ecb-660c-4c87-bf6d-fe0ffa66a531'),(221,1,1,'2019-03-27 17:30:00','2019-03-27 19:30:00',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-24 19:27:43','2019-05-11 14:04:31','84ed88b5-28c5-4729-b4e0-1e5ed11eab2f'),(222,1,1,'2019-04-03 09:00:00','2019-04-03 15:30:00',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2019-03-24 19:28:32','2019-05-11 14:08:40','e63e53ed-6c88-46bf-bf67-00cb4665ef68');
/*!40000 ALTER TABLE `acr_calendar_events` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_calendar_exceptions`
--

LOCK TABLES `acr_calendar_exceptions` WRITE;
/*!40000 ALTER TABLE `acr_calendar_exceptions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_calendar_exceptions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_calendar_select_dates`
--

LOCK TABLES `acr_calendar_select_dates` WRITE;
/*!40000 ALTER TABLE `acr_calendar_select_dates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_calendar_select_dates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_categories`
--

LOCK TABLES `acr_categories` WRITE;
/*!40000 ALTER TABLE `acr_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_categorygroups`
--

LOCK TABLES `acr_categorygroups` WRITE;
/*!40000 ALTER TABLE `acr_categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_categorygroups_sites`
--

LOCK TABLES `acr_categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `acr_categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_content`
--

LOCK TABLES `acr_content` WRITE;
/*!40000 ALTER TABLE `acr_content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_content` VALUES (1,1,1,NULL,'2018-09-30 15:22:58','2018-09-30 15:22:58','126b03bb-4f6f-4da6-95e8-b516b4843e4a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,1,'Test Event','2018-09-30 15:31:33','2018-09-30 15:33:39','74aaff84-3f3b-499a-951a-c06366a92336',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,3,1,NULL,'2018-10-08 23:42:03','2018-10-08 23:50:21','060089bf-8076-475b-8e9e-245ca3d656bd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,5,1,'White Logo Notag','2018-10-08 23:50:14','2018-10-08 23:50:14','31f00bde-fe0d-4f0b-9ccc-ab9dd7e9f5b7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,6,1,'About','2018-10-08 23:53:17','2019-02-05 02:46:19','ac503cda-7999-4a43-9f1f-388957cafa38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,8,1,'Home','2018-10-10 23:42:21','2019-01-27 18:25:14','a5690118-e065-4a43-a698-b62eb7751172',NULL,NULL,NULL,'What We Do Best','As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:',NULL,NULL,'Stay Updated With ACR','Get VIP access for early announcements for all our events and sales.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9,9,1,'Oct 18 Web Promo','2018-10-24 01:14:03','2018-10-24 01:14:03','eb104e53-b7cd-4f0a-9a36-21003be8fbb4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,10,1,'Sure Comfort Promotion','2018-10-24 01:14:25','2019-01-27 18:02:05','9354b2e8-a3ee-44ec-9c92-b7ffb738c852','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"url\",\"value\":\"http://s7098.pcdn.co/wp-content/uploads/2018/07/Sure-Summer-of-Fun-Flyer_HR.pdf\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,11,1,'Best Christian Workplaces','2018-11-02 01:21:37','2019-02-09 21:39:17','2201726b-45c2-49da-9821-a5b6ee99e732',NULL,'ACR Supply honored as <strong>\"Certified Best Christian Workplace\"</strong> for 2018!','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Learn More!\",\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://blog.bcwinstitute.org/87-organizations-honored-as-certified-best-christian-workplaces-2018/\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,15,1,'Building Lights Bw','2018-12-08 01:31:48','2018-12-08 01:31:48','38690095-df00-48a9-a17e-dabcf402f0ff',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,18,1,'Mark Webster Testimonial','2018-12-30 16:13:20','2018-12-30 16:13:20','d062c3b0-d937-49c7-aae5-1811c6b1dd62',NULL,NULL,NULL,NULL,NULL,'Mark Webster','Mark Macurdy was working at a job site over the weekend (emergency call) and needed some parts to get a 600 ton chiller up for a customer. Mark called the after hours number and got Jeff. Mark said that he not only got the part for him, he dropped it off at the job site so Mark never had to stop working but he also dropped off some water for Mark as well. Mark could not say enough about the professional manner in how he handled having to come out on Sunday (102 degrees) but he went the extra step to make sure Mark was hydrated! Please recognize this young man in front of your group for going the extra mile. Troy, you know as well as anyone that parts are parts and everyone has them BUT, very few companies find people who go the extra mile. This guy will help ACR keep customers for life!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,22,1,NULL,'2018-12-30 16:43:46','2019-05-11 15:35:34','4c99e85d-27f7-422c-864e-69033787cee9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://itunes.apple.com/app/acr-supply-store/id1122845601','https://play.google.com/store/apps/details?id=io.gonative.android.pdzwn','https://www.facebook.com/acrsupply/','North Carolina\'s leading HVAC and Refrigeration wholesale distributor.',NULL,NULL,NULL,NULL),(19,24,1,'Locations','2019-01-02 01:08:25','2019-01-21 18:24:32','ccc5af04-fbb4-4f0e-8a10-3998c46d9e08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,34,1,'ACR Cares','2019-01-23 02:23:36','2019-01-23 03:05:07','0024ef52-551a-4c17-90a0-277651c6a3e5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,50,1,'Contact','2019-01-24 01:56:00','2019-01-24 01:56:00','2dae5592-4eb1-4164-98e9-a92c0b960a33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,51,1,'2019-01-23 21:00:21','2019-01-24 02:00:21','2019-01-24 02:00:21','3eb7d961-bea7-45a0-800a-f2295b1b23c1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,52,1,'Request E-Store Account','2019-01-24 02:30:36','2019-01-24 02:30:43','0122a429-089f-49bb-812f-bb0712210d6d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,53,1,'E-Store Credit Application','2019-01-24 02:36:46','2019-01-24 02:36:47','bdd0d516-0489-4e46-b655-3f27e5f22938',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,54,1,'Pay Online','2019-01-24 03:20:09','2019-01-24 03:20:09','78478e50-dfc0-400b-bbdb-637db811306b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,55,1,'Training and Education','2019-01-25 02:16:36','2019-01-25 02:16:36','7f7057c5-74c3-444a-bbdd-523609d234ae',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,56,1,'Scholarships','2019-01-25 02:27:28','2019-05-11 14:33:41','db111192-3b61-479d-93de-718338999f80',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,57,1,'Careers','2019-01-25 02:29:08','2019-01-25 02:29:08','93da3b90-0981-43b7-9f96-da197e9c5bef',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,58,1,'Associates','2019-01-25 02:30:45','2019-01-25 02:30:45','7f049576-9ede-4da5-a218-289075d52093',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,59,1,'The Story','2019-01-25 02:32:27','2019-01-25 02:33:02','1f12df39-d3ac-41d5-a8bf-55495b4b02f3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,60,1,'About Us','2019-01-25 02:42:54','2019-01-25 02:42:54','add0639f-2329-4d53-8b4d-34ef7515b943',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,61,1,'Slider','2019-01-27 17:54:55','2019-01-27 17:55:11','332c8e43-39fa-4f39-8cda-2f607da2d101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,62,1,'Slider','2019-01-27 18:01:51','2019-01-27 18:01:51','7e6fa1a8-de54-4bce-b989-99d33d7bdc24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,63,1,'DEC18-Web-Promo','2019-01-27 18:14:58','2019-01-27 18:14:58','c935ad52-5acf-4e45-ba5c-b4e40e4473ef',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,64,1,'DEC18 Promotion','2019-01-27 18:15:14','2019-01-27 18:17:46','a26584c5-c6ad-40ab-a6d5-b1e4ee6f539f','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":null}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(36,65,1,'Warehouse','2019-01-27 18:23:01','2019-01-27 18:23:01','ef17445d-ad8b-4c81-8e14-daa171af56ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,66,1,'Training-Lab','2019-01-27 18:23:12','2019-01-27 18:23:12','7111b094-1a15-4081-8054-6ed66d517860',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,67,1,NULL,'2019-01-27 18:29:04','2019-02-01 01:54:10','d3eba8ab-dab6-4f63-ad32-e60d03fa06f6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Stay Updated With ACR','Get VIP access for early announcements for all our events and sales.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(39,147,1,'BCWI_Certified_2018_Clear-e1533605047308','2019-02-09 21:37:07','2019-02-09 21:37:07','e0307ada-a6aa-47c8-b0eb-908108a3992f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(40,148,1,'Vendors','2019-02-10 01:28:33','2019-02-10 15:01:02','e136f652-3c47-48b7-8d1c-5abb61641d30',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(41,220,1,'Emerson/Copeland Teardown Class - Durham ACR','2019-03-24 19:27:06','2019-05-11 14:04:30','907285ce-3696-41a9-9ede-dfccd8d6d5f8',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"lat\":\"\",\"lng\":\"\",\"location\":\"\",\"placeid\":\"\",\"locationData\":\"\"}',NULL,NULL),(42,221,1,'Emerson/Copeland Teardown Class - Raleigh ACR','2019-03-24 19:27:43','2019-05-11 14:04:31','b43fd3ed-6f56-40a8-b506-6596e0ba9788',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'{\"lat\":\"\",\"lng\":\"\",\"location\":\"\",\"placeid\":\"\",\"locationData\":\"\"}',NULL,NULL),(43,222,1,'2019 ACR HVAC & Refrigeration Expo','2019-03-24 19:28:32','2019-05-11 14:08:40','29d9eac6-e123-4a50-84dc-c12a0ae5a41c',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4,'4040 S. Alston Ave, Durham, NC','This is the calendar event description. It can be added or left blank, but it will be a great place to add some information about the event that will be beneficial to site visitors.',20.00),(44,223,1,'John Smith','2019-05-11 14:24:49','2019-05-11 14:24:49','89b30489-58f6-4c06-8473-44ca5329b198',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(45,224,1,'2009 - 2010 School Year','2019-05-11 14:36:59','2019-05-11 15:00:35','f8ade49e-5922-4f69-8dc9-5f7ef5e79017',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(46,226,1,'2010 - 2011 School Year','2019-05-11 14:46:39','2019-05-11 15:01:17','d2fafc61-3a55-4a1c-baac-1217aa8a62bc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(47,241,1,'2011 - 2012 School Year','2019-05-11 15:02:03','2019-05-11 15:02:03','21702b58-8487-4e86-8caa-3fda0d4d7af1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(48,248,1,'2012 - 2013 School Year','2019-05-11 15:03:48','2019-05-11 15:03:48','97f75d8b-163f-472c-96ad-3195dbd9fb0b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(49,256,1,'2013 - 2014 School Year','2019-05-11 15:04:47','2019-05-11 15:04:47','0be0f2db-7688-48ee-8fae-4e82f191cc2a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(50,262,1,'2014 - 2015 School Year','2019-05-11 15:05:30','2019-05-11 15:05:30','5d56bb7a-6c26-4993-a533-8bf5c0714ff6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,271,1,'2015 - 2016 School Year','2019-05-11 15:06:17','2019-05-11 15:06:17','1c123920-5690-4437-8471-2a5b55d75237',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,280,1,'2016 - 2017 School Year','2019-05-11 15:07:00','2019-05-11 15:07:00','5faa95a4-98b4-45a2-982c-6eb2a5f64789',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(53,289,1,'2017 - 2018 School Year','2019-05-11 15:07:43','2019-05-11 15:07:43','66af69e4-e5f9-42c2-b79b-2e85701c3afd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(54,298,1,'2018-2019 School Year','2019-05-11 15:08:25','2019-05-11 15:08:25','4bb7ff22-1448-4919-8ac6-e069720f9cf7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(55,307,1,'2019-2020 School Year','2019-05-11 15:09:10','2019-05-11 15:09:10','94a41bee-9eaa-485b-9f97-b452e9c3e421',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `acr_content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_craftidtokens`
--

LOCK TABLES `acr_craftidtokens` WRITE;
/*!40000 ALTER TABLE `acr_craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_deprecationerrors`
--

LOCK TABLES `acr_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `acr_deprecationerrors` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_deprecationerrors` VALUES (1,'ElementQuery::getIterator()','/Users/wesleycole/AcrSupply/acrsupply/templates/scholarships/index.html:26','2019-05-11 14:38:44','/Users/wesleycole/AcrSupply/acrsupply/templates/scholarships/index.html',26,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\MatrixBlockQuery\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/b3/b3cf16dfac4f2819a8b65c5c6c05b12687a6fb0ffa2735368bef0bd1b24434a1.php\",\"line\":66,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":184,\"class\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"method\":\"block_main\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/15/15c83943f38b572f43fd7dfd497840f6cf120f8b8a9090aa124f208cff9476f7.php\",\"line\":144,\"class\":\"Twig\\\\Template\",\"method\":\"displayBlock\",\"args\":\"\\\"main\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":184,\"class\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"method\":\"block_body\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/2a/2ab94e9563ea3e34a2fa0841a5a3ee41d5bc0c3dcc227e3b353697568fac7a68.php\",\"line\":61,\"class\":\"Twig\\\\Template\",\"method\":\"displayBlock\",\"args\":\"\\\"body\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/15/15c83943f38b572f43fd7dfd497840f6cf120f8b8a9090aa124f208cff9476f7.php\",\"line\":62,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/b3/b3cf16dfac4f2819a8b65c5c6c05b12687a6fb0ffa2735368bef0bd1b24434a1.php\",\"line\":43,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":364,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Environment.php\",\"line\":319,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/wesleycole/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/wesleycole/AcrSupply/acrsupply/web/index.php\\\"\"}]','2019-05-11 14:38:44','2019-05-11 14:38:44','b55da089-7751-40bd-a18b-2e545d7eeaa1'),(2,'ElementQuery::getIterator()','/Users/wesleycole/AcrSupply/acrsupply/templates/scholarships/index.html:28','2019-05-11 14:40:24','/Users/wesleycole/AcrSupply/acrsupply/templates/scholarships/index.html',28,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\MatrixBlockQuery\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/b3/b3cf16dfac4f2819a8b65c5c6c05b12687a6fb0ffa2735368bef0bd1b24434a1.php\",\"line\":71,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":184,\"class\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"method\":\"block_main\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/15/15c83943f38b572f43fd7dfd497840f6cf120f8b8a9090aa124f208cff9476f7.php\",\"line\":144,\"class\":\"Twig\\\\Template\",\"method\":\"displayBlock\",\"args\":\"\\\"main\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":184,\"class\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"method\":\"block_body\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/2a/2ab94e9563ea3e34a2fa0841a5a3ee41d5bc0c3dcc227e3b353697568fac7a68.php\",\"line\":61,\"class\":\"Twig\\\\Template\",\"method\":\"displayBlock\",\"args\":\"\\\"body\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/15/15c83943f38b572f43fd7dfd497840f6cf120f8b8a9090aa124f208cff9476f7.php\",\"line\":62,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/b3/b3cf16dfac4f2819a8b65c5c6c05b12687a6fb0ffa2735368bef0bd1b24434a1.php\",\"line\":43,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":364,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Environment.php\",\"line\":319,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/wesleycole/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/wesleycole/AcrSupply/acrsupply/web/index.php\\\"\"}]','2019-05-11 14:40:24','2019-05-11 14:40:24','0080acd1-286e-4223-b055-87f909150ba2'),(4,'ElementQuery::getIterator()','/Users/wesleycole/AcrSupply/acrsupply/templates/scholarships/index.html:30','2019-05-11 14:55:36','/Users/wesleycole/AcrSupply/acrsupply/templates/scholarships/index.html',30,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\MatrixBlockQuery\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/b3/b3cf16dfac4f2819a8b65c5c6c05b12687a6fb0ffa2735368bef0bd1b24434a1.php\",\"line\":76,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":184,\"class\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"method\":\"block_main\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/15/15c83943f38b572f43fd7dfd497840f6cf120f8b8a9090aa124f208cff9476f7.php\",\"line\":144,\"class\":\"Twig\\\\Template\",\"method\":\"displayBlock\",\"args\":\"\\\"main\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":184,\"class\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"method\":\"block_body\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/2a/2ab94e9563ea3e34a2fa0841a5a3ee41d5bc0c3dcc227e3b353697568fac7a68.php\",\"line\":61,\"class\":\"Twig\\\\Template\",\"method\":\"displayBlock\",\"args\":\"\\\"body\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/15/15c83943f38b572f43fd7dfd497840f6cf120f8b8a9090aa124f208cff9476f7.php\",\"line\":62,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/b3/b3cf16dfac4f2819a8b65c5c6c05b12687a6fb0ffa2735368bef0bd1b24434a1.php\",\"line\":43,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":364,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Environment.php\",\"line\":319,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/wesleycole/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/wesleycole/AcrSupply/acrsupply/web/index.php\\\"\"}]','2019-05-11 14:55:36','2019-05-11 14:55:36','3eb81095-c1de-4869-aacc-fe873750c028'),(10,'ElementQuery::getIterator()','/Users/wesleycole/AcrSupply/acrsupply/templates/scholarships/index.html:31','2019-05-11 15:09:12','/Users/wesleycole/AcrSupply/acrsupply/templates/scholarships/index.html',31,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\MatrixBlockQuery\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/b3/b3cf16dfac4f2819a8b65c5c6c05b12687a6fb0ffa2735368bef0bd1b24434a1.php\",\"line\":78,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":184,\"class\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"method\":\"block_main\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/15/15c83943f38b572f43fd7dfd497840f6cf120f8b8a9090aa124f208cff9476f7.php\",\"line\":144,\"class\":\"Twig\\\\Template\",\"method\":\"displayBlock\",\"args\":\"\\\"main\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":184,\"class\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"method\":\"block_body\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/2a/2ab94e9563ea3e34a2fa0841a5a3ee41d5bc0c3dcc227e3b353697568fac7a68.php\",\"line\":61,\"class\":\"Twig\\\\Template\",\"method\":\"displayBlock\",\"args\":\"\\\"body\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"head\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_head\\\"], \\\"customHead\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_customHead\\\"], \\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"foot\\\" => [__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729, \\\"block_foot\\\"], ...]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_b1af1c9063790d4a3751ed92abe2784e918b677d28a2df6f4697959faabb0729\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/15/15c83943f38b572f43fd7dfd497840f6cf120f8b8a9090aa124f208cff9476f7.php\",\"line\":62,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"body\\\" => [__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251, \\\"block_body\\\"], \\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_5ef0c4836423d6e750512f064f80b62dd8d58376a9e59570eb621c3dd1590251\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/storage/runtime/compiled_templates/b3/b3cf16dfac4f2819a8b65c5c6c05b12687a6fb0ffa2735368bef0bd1b24434a1.php\",\"line\":43,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":379,\"class\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":356,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], [\\\"main\\\" => [__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5, \\\"block_main\\\"]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Template.php\",\"line\":364,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_ce4e53c234f10a46f6c04403184818681dcd8a6db279dd04d45f89acde2b3ef5\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/twig/twig/src/Environment.php\",\"line\":319,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"scholarships\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"scholarships\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/wesleycole/AcrSupply/acrsupply/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/wesleycole/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/wesleycole/AcrSupply/acrsupply/web/index.php\\\"\"}]','2019-05-11 15:09:12','2019-05-11 15:09:12','b2344bf3-7089-48a6-8f5a-bedad22a81b5');
/*!40000 ALTER TABLE `acr_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_elementindexsettings`
--

LOCK TABLES `acr_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `acr_elementindexsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_elementindexsettings` VALUES (1,'craft\\elements\\Asset','{\"sources\":{\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\":{\"tableAttributes\":{\"1\":\"filename\",\"2\":\"size\",\"3\":\"dateModified\",\"4\":\"imageSize\"}}}}','2018-10-08 23:50:08','2018-10-08 23:50:08','9f6cdefd-bd48-418d-b90f-ece768b80a53'),(2,'craft\\elements\\Entry','{\"sources\":{\"section:c3c14b51-1050-404a-b79d-ac586030e8a4\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}}}}','2019-01-02 01:09:32','2019-01-02 01:09:32','e53996c4-2209-4439-9b66-59d99150f6a7');
/*!40000 ALTER TABLE `acr_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_elements`
--

LOCK TABLES `acr_elements` WRITE;
/*!40000 ALTER TABLE `acr_elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2018-09-30 15:22:58','2018-09-30 15:22:58',NULL,'bafa4cf8-b725-49b9-8267-677b9fab9c59'),(2,1,'Solspace\\Calendar\\Elements\\Event',1,0,'2018-09-30 15:31:33','2018-09-30 15:33:39',NULL,'569e5b0a-505a-40bf-b419-67f9af89a395'),(3,2,'craft\\elements\\GlobalSet',1,0,'2018-10-08 23:42:03','2018-10-08 23:50:21',NULL,'2fd6bbb7-140d-4547-8232-fd576b3c3b6f'),(5,3,'craft\\elements\\Asset',1,0,'2018-10-08 23:50:14','2018-10-08 23:50:14',NULL,'9388817f-ab4f-4696-a078-8dffe96a6e82'),(6,5,'craft\\elements\\Entry',1,0,'2018-10-08 23:53:17','2019-02-05 02:46:19',NULL,'ea3d0231-9ff7-49f6-ae40-fad3197a19e0'),(8,7,'craft\\elements\\Entry',1,0,'2018-10-10 23:42:21','2019-01-27 18:25:14',NULL,'0c039a82-d3ca-4200-b090-ecf9b176d8eb'),(9,3,'craft\\elements\\Asset',1,0,'2018-10-24 01:14:03','2018-10-24 01:14:03',NULL,'1b2c20af-0fdc-405c-981a-86f6c310cec6'),(10,6,'craft\\elements\\Entry',1,0,'2018-10-24 01:14:25','2019-01-27 18:02:05','2019-01-27 18:14:05','f2fbf0d0-1785-480c-81fb-d9cba2e61f8e'),(11,8,'craft\\elements\\Entry',1,0,'2018-11-02 01:21:37','2019-02-09 21:39:17',NULL,'63f7fe29-ef0e-4cf3-b23a-722f528236fb'),(12,9,'craft\\elements\\MatrixBlock',1,0,'2018-11-02 02:36:30','2019-01-27 18:25:14',NULL,'ec939812-cb63-45d3-89e5-d08617d098f8'),(13,9,'craft\\elements\\MatrixBlock',1,0,'2018-11-02 02:36:30','2019-01-27 18:25:14',NULL,'1847d4c9-ee26-42fe-b2c4-3006603d55d7'),(14,9,'craft\\elements\\MatrixBlock',1,0,'2018-11-02 02:36:30','2019-01-27 18:25:14',NULL,'486bdff8-e75e-4a72-8a7a-c1a5a07f8933'),(15,3,'craft\\elements\\Asset',1,0,'2018-12-08 01:31:48','2018-12-08 01:31:48',NULL,'657b2267-7c08-42d9-893b-160c7d952fce'),(16,10,'craft\\elements\\MatrixBlock',1,0,'2018-12-08 01:32:00','2019-01-27 18:25:14',NULL,'c48aa2c6-7d74-4d95-8384-775c0461a4cc'),(17,10,'craft\\elements\\MatrixBlock',1,0,'2018-12-08 01:32:00','2019-01-27 18:25:14',NULL,'8d9ab4ad-7111-4a69-95a9-5406a3a306bd'),(18,11,'craft\\elements\\Entry',1,0,'2018-12-30 16:13:20','2018-12-30 16:13:20',NULL,'8ac4ea2c-5e50-4a52-9732-29a277c4d09a'),(22,15,'craft\\elements\\GlobalSet',1,0,'2018-12-30 16:43:46','2019-05-11 15:35:34',NULL,'6e7b131e-ba3a-433e-9169-915f557b3867'),(24,17,'craft\\elements\\Entry',1,0,'2019-01-02 01:08:25','2019-01-21 18:24:32',NULL,'702aab3a-81a6-4ded-98f1-046c5bb252e4'),(25,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:14:24','2019-01-21 18:24:32',NULL,'4bfde363-cf68-4324-b938-2d5eff736410'),(26,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:15:08','2019-01-21 18:24:32',NULL,'8586919c-b969-4ef8-ae84-0399da245706'),(27,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'189cbd60-3615-42a8-9274-c1ed189212f2'),(28,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'b489708c-0f90-483d-af1c-5af584c085ba'),(29,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'feaa9dbd-961a-4502-87d9-ff05b4d22fe3'),(30,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'2a46a71c-f705-4d38-a204-9343ce2d3118'),(31,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'afc44762-5859-44b9-8e8d-aa1a613d787a'),(32,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'3a8e3695-8e3d-4cc1-9f4a-95e2eb0171f3'),(33,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'4da6e408-e661-49f7-8d65-39180e33a637'),(34,20,'craft\\elements\\Entry',1,0,'2019-01-23 02:23:36','2019-01-23 03:05:07',NULL,'b6ee7d23-9459-4431-826d-6be77a390b7b'),(35,19,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 02:51:12','2019-01-23 03:05:07',NULL,'7cdd8f51-247c-42ab-ab7c-febe5d630ce3'),(36,19,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 02:51:12','2019-01-23 03:05:07',NULL,'353b1742-bea9-487d-a34c-47d3c58292c3'),(37,19,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 02:56:28','2019-01-23 03:05:07',NULL,'116a548e-4970-47c2-b0b7-bc39a9ec97c2'),(38,19,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 02:56:29','2019-01-23 03:05:07',NULL,'04203da1-d42c-479f-a91b-d219b38491f0'),(39,19,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 02:56:29','2019-01-23 03:05:07',NULL,'c93ab961-c1a9-4a66-8364-4f904a750296'),(40,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'0a8bf146-96ad-47fa-9b88-2fa6a5995324'),(41,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'0361d796-ae9f-4215-a217-f8fb8a696562'),(42,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'1ba3ee7c-93b0-4641-825c-0d6b3df819bd'),(43,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'e5161378-3c58-411c-b3bf-866bdf4b7f0d'),(44,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'9d5415ba-16f7-4148-8c8c-6ab8e9d29dd6'),(45,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'506b1cd2-758c-4ce4-9056-d60ca0876ce8'),(46,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'5695fb7f-05f1-4dfc-9d69-4a07643c59ef'),(47,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'eaed28b4-2b40-4608-a167-b71d06a24a39'),(48,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'cf783ce1-9014-4ea3-a554-5130ed25f4a8'),(49,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'4bf73f14-b4a4-4973-bdcb-2c1769f397fe'),(50,NULL,'craft\\elements\\Entry',1,0,'2019-01-24 01:56:00','2019-01-24 01:56:00',NULL,'bc31dc5d-be67-4367-a467-3345570366bc'),(51,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-01-24 02:00:21','2019-01-24 02:00:21','2019-01-24 02:00:38','4c01c633-5972-4456-8a7d-93f2d083e96f'),(52,NULL,'craft\\elements\\Entry',1,0,'2019-01-24 02:30:36','2019-01-24 02:30:43',NULL,'cc580f4d-1579-4f73-b16e-d65d9adca1ff'),(53,NULL,'craft\\elements\\Entry',1,0,'2019-01-24 02:36:46','2019-01-24 02:36:47',NULL,'9afca978-0470-4259-a195-4c47ce30ec79'),(54,NULL,'craft\\elements\\Entry',1,0,'2019-01-24 03:20:09','2019-01-24 03:20:09',NULL,'8e7bdb01-d249-4f28-bbca-f9203b151779'),(55,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:16:36','2019-01-25 02:16:36',NULL,'ab00af6c-b028-46de-894e-c2d6b4d82806'),(56,28,'craft\\elements\\Entry',1,0,'2019-01-25 02:27:28','2019-05-11 14:33:41',NULL,'0089ba8c-2d2d-4b69-8699-f2c9d52eb7dc'),(57,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:29:08','2019-01-25 02:29:08',NULL,'af5e2262-ef73-4dfa-a35a-e35fb1c90969'),(58,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:30:45','2019-01-25 02:30:45',NULL,'b24d04cc-d98c-4afe-a678-86fac3c5acc5'),(59,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:32:27','2019-01-25 02:33:02','2019-01-25 02:33:03','2bc2addc-32ec-4194-908c-158fece1276b'),(60,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:42:54','2019-01-25 02:42:54',NULL,'7e5dcf42-d09f-4236-b14c-c54dd3144a2a'),(61,3,'craft\\elements\\Asset',1,0,'2019-01-27 17:54:55','2019-01-27 17:55:11',NULL,'7c8a9f49-dd5a-47f8-8209-2f9e6b8936ab'),(62,NULL,'craft\\elements\\Asset',1,0,'2019-01-27 18:01:51','2019-01-27 18:01:51',NULL,'040e433b-1eac-4c8f-965f-4904d1645239'),(63,NULL,'craft\\elements\\Asset',1,0,'2019-01-27 18:14:58','2019-01-27 18:14:58',NULL,'0d393b8a-9d1b-47d3-94cf-f9139dcc9463'),(64,6,'craft\\elements\\Entry',1,0,'2019-01-27 18:15:14','2019-01-27 18:17:46',NULL,'f8e0768e-0080-43ac-991b-fc40b8733b9d'),(65,NULL,'craft\\elements\\Asset',1,0,'2019-01-27 18:23:01','2019-01-27 18:23:01',NULL,'828b631a-35b8-40bd-97b2-3a51a6a9e2e3'),(66,NULL,'craft\\elements\\Asset',1,0,'2019-01-27 18:23:12','2019-01-27 18:23:12',NULL,'90b70428-25ee-4586-bcc1-bfaf89607338'),(67,22,'craft\\elements\\GlobalSet',1,0,'2019-01-27 18:29:04','2019-02-01 01:54:10',NULL,'b4388c1c-535d-4c91-ba62-3de564eb8eff'),(68,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:19','2019-02-05 02:46:19',NULL,'ad0d8e09-9069-4756-b6ea-859ccb68c89e'),(69,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:19','2019-02-05 02:46:19',NULL,'51c80486-213d-4797-9388-d5740b91eda2'),(70,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:19','2019-02-05 02:46:19',NULL,'5f44704a-032b-40a2-90d4-3acf686abbcc'),(71,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:19','2019-02-05 02:46:19',NULL,'6e217018-5355-43a1-8cc1-4e6ec4686d5f'),(72,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:19','2019-02-05 02:46:19',NULL,'20f05b45-c9a9-413c-a101-4ff5a9c035f3'),(73,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:19','2019-02-05 02:46:19',NULL,'b66cdc51-e0b2-4fcd-ac7f-0f1db02032ad'),(74,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:19','2019-02-05 02:46:19',NULL,'242cf880-7664-43af-9967-ff33c8aab61c'),(75,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:19','2019-02-05 02:46:19',NULL,'7bf4399d-a21b-424d-8bc7-0d5f5483c3ea'),(76,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:19','2019-02-05 02:46:19',NULL,'c8a85103-8e9c-4c6d-8e30-3cf79e900b0f'),(77,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:19','2019-02-05 02:46:19',NULL,'9881e4bc-9407-4c8c-bb22-b6d21786365a'),(78,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'577cbe4e-5361-4f85-9687-1f9ee82f984b'),(79,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'3a1a96a1-36b8-4870-8347-20392d4edacc'),(80,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'a07b7011-aade-4cd8-a33b-5e9170728dd2'),(81,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'a69bfb09-1c06-4b0c-b959-6618abe5008c'),(82,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'297618a7-ad97-4d0a-99e7-10fc834e9cfa'),(83,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'c595e8fb-d61c-4d21-8c30-743d0b8f160e'),(84,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'108af2e4-20f6-4962-ab1b-8fd15d59d091'),(85,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'64b62998-e778-4a6b-a819-7440dd94dc89'),(86,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'8c6aa841-5c95-413f-a995-df27cfca50cd'),(87,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'c97dec67-5c5f-466a-a2bd-12a4bc84392e'),(88,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'cd51f4a5-e265-47b4-9594-62b524c7a4b7'),(89,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'1761a001-b5bd-4fb2-a31e-eb21b0470924'),(90,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'77f79688-f80a-45a6-b9c8-924b551ec4b5'),(91,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'2a965248-601f-4194-afba-d391bb2d32ac'),(92,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'e1adac0b-8843-4aa5-bb65-a5e54797404d'),(93,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'8f8e42a6-b182-43cf-9bc2-a3c21eaa1d0d'),(94,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'f651f5fc-dc2a-4c15-835d-ec8b2144acdf'),(95,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'3937afe4-cd8b-4ef5-ab1e-677cc9335ef8'),(96,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'741e80dc-700f-4f44-80d7-1a276b2d9335'),(97,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'8937367e-17ef-45db-bda8-b4d1b0fa2f87'),(98,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'6ed2c6fc-5afe-46ce-9ecd-0703d682d484'),(99,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'b4da0fa6-9630-421f-b8f1-7200b4911867'),(100,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'bae43bb4-6183-412d-9ad6-087be4c676ee'),(101,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'b20a0f0f-c586-4c48-8565-4bead0c6b53f'),(102,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'b7320da8-b174-489b-83d4-31da6679de81'),(103,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'7cdf7e67-4245-4111-9e20-4ff2959bad40'),(104,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'8f5c13bf-3dee-4729-9afa-cbb6e8c6c99c'),(105,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'2b9d450a-05b5-480a-9baf-54d7e6fb6f63'),(106,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'ee3072cd-1bd4-4afb-8bc1-134896b68421'),(107,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'b70457bd-d61a-4c7e-9c81-e0437bb11f91'),(108,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'e229dce1-84e4-4005-8054-1b0e351f3ee8'),(109,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'1d461261-b39c-45e2-bd59-7be9311b156e'),(110,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'8a309e9b-f791-4754-ad36-a21b5f08c54f'),(111,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'8582bc4a-f792-4209-b8e4-e104ea1585d6'),(112,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'4f283ad0-b0ee-4e56-b00c-ed235c876112'),(113,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'76843bf2-202c-4de0-a86a-65c716878aeb'),(114,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'963d63b1-109a-40a6-9624-dd61bf05b990'),(115,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'c444b75e-1aa2-4267-a97f-5557c5f34931'),(116,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'530d48e8-e913-4754-8a0b-911e24b804da'),(117,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'bfdab686-ed92-439f-b04f-99ae848360ea'),(118,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'6ec9fc1d-8424-4029-aad5-87c47206a3fa'),(119,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'fbee4fa8-6d69-4207-a584-22cd76bcfa8e'),(120,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'98887ebb-ad74-4a0b-b218-34574d3e0ef1'),(121,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'80ffe666-967b-4749-a64e-cc058aa383e5'),(122,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'d68cca23-fa48-4928-b4f9-bf700bca19ee'),(123,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'becdc94e-5815-454c-b508-da712d29d64f'),(124,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'b049b295-fef7-4f56-90b9-d9cf97f04815'),(125,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'b1bffaaf-9217-4265-91c5-9ee03027fc20'),(126,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'674b044f-55b5-4353-b598-7e1cda13bf80'),(127,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'158490b2-dd0f-410f-8847-b4229405cea1'),(128,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'a95388bf-97c0-437c-862b-f02b03aced65'),(129,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'346869cd-09a3-4ff3-aceb-ed4f989ea4c0'),(130,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'f3146d02-2d31-4bd9-bf8a-5b93f2c34312'),(131,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'a09869d7-6177-4909-9852-5de56543e065'),(132,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'0c5a0a95-8c81-4b5d-9eed-2cf613852cbc'),(133,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'486d3594-555a-4572-a956-734aee0c7ee4'),(134,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'e8ef155c-7686-4e0f-a1ff-0602fec6d06c'),(135,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'137a5641-1959-433a-8b57-2da3633c9127'),(136,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'00a9103d-0e82-427c-840d-b30756a8c239'),(137,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:20','2019-02-05 02:46:20',NULL,'cc14316b-eb6c-41a7-8986-28e661d65cee'),(138,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:21','2019-02-05 02:46:21',NULL,'aca94984-94fb-4163-9807-c07a06b5f55f'),(139,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:21','2019-02-05 02:46:21',NULL,'27477cb0-23d6-4ddb-bde5-f7178bfee94c'),(140,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:21','2019-02-05 02:46:21',NULL,'45ba035b-b4e6-4333-8e40-4a2bdd2d7b0f'),(141,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:21','2019-02-05 02:46:21',NULL,'dac93096-d6d0-48b2-8aba-dfaabdc0f67e'),(142,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:21','2019-02-05 02:46:21',NULL,'e60983ef-92c4-4f76-8d23-13af09f90fdf'),(143,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:21','2019-02-05 02:46:21',NULL,'e88bc452-ebad-4c10-8141-cc3cd1a20824'),(144,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:21','2019-02-05 02:46:21',NULL,'1817e15b-bd33-4015-9ada-e33ae28a03a4'),(145,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:21','2019-02-05 02:46:21',NULL,'a0fa9757-96a9-4b11-961c-f73715f01943'),(146,23,'craft\\elements\\MatrixBlock',1,0,'2019-02-05 02:46:21','2019-02-05 02:46:21',NULL,'fd97529d-e6bc-4820-8d79-326127b669f1'),(147,NULL,'craft\\elements\\Asset',1,0,'2019-02-09 21:37:07','2019-02-09 21:37:07',NULL,'cc289d5c-2087-419d-8a0d-54eef444a178'),(148,25,'craft\\elements\\Entry',1,0,'2019-02-10 01:28:33','2019-02-10 15:01:02',NULL,'5103b1df-6177-4030-8298-122d97c386c7'),(149,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:33:17','2019-02-10 01:33:17','2019-02-10 01:33:18','a52864f0-d3d9-48b4-8a2b-d5568972d996'),(150,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:33:17','2019-02-10 01:33:17','2019-02-10 01:33:19','31f55407-f49c-43ac-a176-7e9c09bc4e61'),(151,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:33:18','2019-02-10 01:33:18','2019-02-10 01:33:19','9b376242-8f92-4c1d-98d8-2038b02ec120'),(152,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:33:18','2019-02-10 01:33:18','2019-02-10 01:33:19','56932b7a-8f73-4244-a109-7bc64bbde796'),(153,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:33:18','2019-02-10 15:01:02',NULL,'45a6820b-83a7-4cdc-acf6-f9967d4b8e74'),(154,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:33:18','2019-02-10 15:01:02',NULL,'98420617-03b0-4ad1-8df3-6eb32777e8db'),(155,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:33:18','2019-02-10 15:01:02',NULL,'28e36d41-2846-43f0-a49d-800de595e23e'),(156,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:33:18','2019-02-10 15:01:02',NULL,'fd940bb4-b7a4-40cd-b81f-1fb98cdac281'),(157,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:33:49','2019-02-10 15:01:02',NULL,'133431a0-fcc5-4ad7-9698-cee4ed2d5fa5'),(158,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:38:23','2019-02-10 15:01:02',NULL,'ec9ed363-ea00-4ae9-8022-ef3714c1e760'),(159,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:38:23','2019-02-10 15:01:02',NULL,'8b1180d1-2412-4fd7-835c-77860205fd51'),(160,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:38:24','2019-02-10 15:01:02',NULL,'41aa75ea-abcd-4223-8b51-cb39e5605117'),(161,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:38:24','2019-02-10 15:01:02',NULL,'f409efbd-bc30-4008-9cd0-f727d9ee47ad'),(162,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:38:24','2019-02-10 15:01:02',NULL,'8bc82f11-a8dd-46fe-b7ee-af0164ac6c2b'),(163,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:38:24','2019-02-10 15:01:02',NULL,'38fbfa0f-250b-49b9-8860-581e7f6e3344'),(164,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:38:24','2019-02-10 15:01:02',NULL,'ea792b64-615a-48c7-a6c7-b799d227fd48'),(165,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:38:24','2019-02-10 15:01:03',NULL,'05a58c02-28e6-4438-bfc6-8a581fa286a1'),(166,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:38:24','2019-02-10 15:01:03',NULL,'9fb3a950-844d-4d7e-8f72-911f51effac8'),(167,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:38:24','2019-02-10 15:01:03',NULL,'ce9a18be-0734-4c2b-ac24-63e4494385a5'),(168,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:42:49','2019-02-10 15:01:03',NULL,'0de38aa2-da4b-4b43-a959-6f9e3eb9d381'),(169,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:42:49','2019-02-10 15:01:03',NULL,'1f45b895-373b-40c3-a4ce-3911adadf96a'),(170,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:42:49','2019-02-10 15:01:03',NULL,'69864373-bcd9-40dc-b88f-3e8ffdbf1436'),(171,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:42:49','2019-02-10 15:01:03',NULL,'04c207bc-d9a4-489c-88a0-7323201714a8'),(172,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:42:49','2019-02-10 15:01:03',NULL,'31591afd-2f9f-4ed2-a6b6-89d62a1ea50a'),(173,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:42:49','2019-02-10 15:01:03',NULL,'337e24c5-0471-4118-b1bf-71e74531e7c9'),(174,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:42:49','2019-02-10 15:01:03',NULL,'f3b7e033-2932-46bc-a9d4-e35ca61e1373'),(175,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 01:42:49','2019-02-10 15:01:03',NULL,'4f05f1d3-1ad5-4c06-b39f-338a7fa96489'),(176,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'fb07bb9b-5663-4645-81eb-7d02c1d6d319'),(177,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'d2175f94-6c4d-49a9-8b20-a7d8983c5f93'),(178,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'b546a9d8-e094-48f0-bdd9-1f35047cdb35'),(179,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'4a5075f0-1cf0-4998-b215-a1d60fa23fc5'),(180,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'400eb221-996e-4292-b05d-d352854e0f77'),(181,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'0cad23f0-18de-44ff-b00b-776a0993b82f'),(182,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'1cb9db6d-6e35-485d-9861-d3a5fdf29e70'),(183,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'fef542c0-09d4-4642-8d83-707ed04e247a'),(184,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'5fe34367-25d9-4dd7-b442-d52bfb5241ec'),(185,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'92802069-fa5f-46be-8361-cf5369c87f64'),(186,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'9d1d12ca-fbb0-426a-892e-23c46b532a73'),(187,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'873c9dd5-a4e4-4893-bd39-92494aad3289'),(188,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'4402e8bd-f571-4de8-8014-725b3d093115'),(189,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'36dca4de-7902-4717-9e39-520f4b06169a'),(190,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'03f19c37-ae74-441a-add8-7ad02fb20b66'),(191,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'653500ab-d96b-4e92-93d5-bee8f91a04e0'),(192,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'53cdbee3-9b61-4521-8073-92f0adc0a664'),(193,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'ed1349c2-65b5-4e77-96de-38606f80ed64'),(194,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'80081ec0-b5c8-4990-8a08-aff9d1b4c25c'),(195,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'792c7afa-2ccc-4f3e-944a-588267fe82f8'),(196,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'c5d2c1ff-ef19-4397-b9c4-59510865f8e2'),(197,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'eace0c28-e54c-44a0-ad71-fdbfcb4aee7c'),(198,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'91d3ddca-3a1b-4af9-9f33-2eddbf84e99d'),(199,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'d7f9bffc-c2ef-420d-92d2-fa152734494a'),(200,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'40a515cf-2448-494e-95d1-e964b1474353'),(201,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'0cf235d0-03f8-4e78-a59a-85aae8e3645e'),(202,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'3d21de36-dfe5-4189-968f-ffe604368f78'),(203,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'fb8d18cc-71ed-46fd-b37b-f0894b123fab'),(204,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'a355ead4-67a5-4611-a8b1-5826874c3f62'),(205,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'e4e4409c-f980-4fa7-868d-fa23353ed037'),(206,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'b05faad0-47d4-44b1-af0c-c5f2dbe34a06'),(207,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 02:02:42','2019-02-10 15:01:03',NULL,'5b151ed3-7dfd-461e-8738-6f8b282a740f'),(208,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 14:50:02','2019-02-10 15:01:03',NULL,'35dbe9d7-8a85-489b-8f61-bb8768ef7a66'),(209,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 14:50:02','2019-02-10 15:01:03',NULL,'bf78b3c1-ca1a-4e9a-8d51-c36cc57f7bed'),(210,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 14:51:49','2019-02-10 15:01:03',NULL,'0efe5b33-abf9-4bdd-8c83-6b25744e4d1d'),(211,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 14:51:49','2019-02-10 15:01:03',NULL,'ec96d37c-7744-42a6-a342-c8f61171960b'),(212,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 14:51:49','2019-02-10 15:01:03',NULL,'276e4c22-959a-4d03-8462-d555510f5d96'),(213,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 14:51:49','2019-02-10 15:01:03',NULL,'78ec0f04-550e-492a-adc9-f70eb10987de'),(214,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 14:51:49','2019-02-10 15:01:03',NULL,'ddf1afb2-5f47-412a-baab-9d18e9fd0063'),(215,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 15:01:03','2019-02-10 15:01:03',NULL,'a3347a85-ca85-4c5e-abad-91a9276768d1'),(216,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 15:01:03','2019-02-10 15:01:03',NULL,'2d0a3361-d017-4abb-9086-6374d14b4c6b'),(217,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 15:01:03','2019-02-10 15:01:03',NULL,'576a0e67-db8b-4ffd-aa79-23bcf4d3e3f4'),(218,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 15:01:03','2019-02-10 15:01:03',NULL,'92ea060c-c617-4268-bcf1-993412052f36'),(219,24,'craft\\elements\\MatrixBlock',1,0,'2019-02-10 15:01:04','2019-02-10 15:01:04',NULL,'de0a5662-7a8a-4711-89f8-be495f54559d'),(220,26,'Solspace\\Calendar\\Elements\\Event',1,0,'2019-03-24 19:27:06','2019-05-11 14:04:30',NULL,'be7467e3-14db-47a6-b154-af9cabf76e3e'),(221,26,'Solspace\\Calendar\\Elements\\Event',1,0,'2019-03-24 19:27:43','2019-05-11 14:04:31',NULL,'3fba96cf-ebd3-4b5f-88fc-361bfbb40cf8'),(222,26,'Solspace\\Calendar\\Elements\\Event',1,0,'2019-03-24 19:28:32','2019-05-11 14:08:40',NULL,'7a74af80-a6b5-4d55-856d-e8a09da30330'),(223,NULL,'craft\\elements\\Entry',1,0,'2019-05-11 14:24:49','2019-05-11 14:24:49','2019-05-11 14:34:20','44c02d60-a4fe-4e2c-92d0-553112347687'),(224,30,'craft\\elements\\Entry',1,0,'2019-05-11 14:36:59','2019-05-11 15:00:35',NULL,'cf5ffd56-e07d-40d4-a690-024c2a815f17'),(225,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 14:36:59','2019-05-11 15:00:35',NULL,'17f8b643-373b-4d7f-b029-9cb908ed4755'),(226,30,'craft\\elements\\Entry',1,0,'2019-05-11 14:46:39','2019-05-11 15:01:17',NULL,'efd69d00-efeb-48af-ad75-703f889eff45'),(227,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 14:46:39','2019-05-11 15:01:18',NULL,'f7bcb4c8-c3c5-4f15-9a7a-02ba14c14d69'),(228,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 14:58:07','2019-05-11 15:01:18',NULL,'1a3dfc42-8cc4-497b-b211-7f7168e0c4b7'),(229,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:00:35','2019-05-11 15:00:35',NULL,'19d49ddc-870c-45da-87c1-c3227a6c5d5c'),(230,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:00:35','2019-05-11 15:00:35',NULL,'5b18f48e-00e2-4784-bafe-378a31e5763a'),(231,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:00:35','2019-05-11 15:00:35',NULL,'3af83231-c1dc-462f-9271-99e45e10e73a'),(232,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:00:35','2019-05-11 15:00:35',NULL,'e2844644-d89d-4fe5-b9ea-d8e48217acba'),(233,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:00:35','2019-05-11 15:00:35',NULL,'df8bd0a0-585b-4905-be24-b059432d65b0'),(234,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:00:35','2019-05-11 15:00:35',NULL,'879a2aa1-7358-4742-905b-4fc257fd10af'),(235,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:00:35','2019-05-11 15:00:35',NULL,'7570f588-ef62-497b-9dfd-7a13453a1888'),(236,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:00:35','2019-05-11 15:00:35',NULL,'9af81dbf-986f-470b-8b73-e3ccbd042c98'),(237,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:00:35','2019-05-11 15:00:35',NULL,'d875ad91-22d2-444f-a24d-f5f4f861f2ba'),(238,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:01:18','2019-05-11 15:01:18',NULL,'0f9ed213-26db-4814-9960-a8d6f0b7ef78'),(239,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:01:18','2019-05-11 15:01:18',NULL,'88159d97-cdd6-4ebe-92be-c6c50cab818c'),(240,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:01:18','2019-05-11 15:01:18',NULL,'95bee8a4-ff8d-4eba-83e1-56d2461519e3'),(241,30,'craft\\elements\\Entry',1,0,'2019-05-11 15:02:03','2019-05-11 15:02:03',NULL,'3268f658-8cfe-41d9-9eaf-87d0f6e40f19'),(242,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:02:03','2019-05-11 15:02:03',NULL,'f04436ac-74dc-4135-9136-34b51118adaf'),(243,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:02:03','2019-05-11 15:02:03',NULL,'65b64599-b3cb-4053-8864-cc3742640539'),(244,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:02:03','2019-05-11 15:02:03',NULL,'2e516616-283f-4fbd-ae92-3a89adbf900a'),(245,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:02:03','2019-05-11 15:02:03',NULL,'90df0a95-0b1c-40f5-8915-8fd0df445ba2'),(246,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:02:03','2019-05-11 15:02:03',NULL,'8dfc71fb-074f-4655-81d4-9d8e4ecaaec9'),(247,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:02:03','2019-05-11 15:02:03',NULL,'954c18a0-033b-4ac0-8d96-67788c474e92'),(248,30,'craft\\elements\\Entry',1,0,'2019-05-11 15:03:48','2019-05-11 15:03:48',NULL,'52c46a42-a8e3-477f-a3ff-b8ec9dc4bf32'),(249,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:03:48','2019-05-11 15:03:48',NULL,'aad144c6-482f-4fa2-a2e3-2c066b829ae9'),(250,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:03:48','2019-05-11 15:03:48',NULL,'a90ad75f-f33e-47ce-96f7-635699725201'),(251,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:03:48','2019-05-11 15:03:48',NULL,'4ca6f4f6-b365-400d-9212-1b7628e7b231'),(252,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:03:48','2019-05-11 15:03:48',NULL,'8fb716ee-c68f-4ba2-9048-46172da854d6'),(253,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:03:48','2019-05-11 15:03:48',NULL,'f26d9fd9-0151-41ab-ad2b-aa45ba8dcfc0'),(254,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:03:48','2019-05-11 15:03:48',NULL,'3d32318e-9318-41d6-a0ed-7faa853b852e'),(255,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:03:48','2019-05-11 15:03:48',NULL,'e88e11df-d6fd-4f67-a5a2-3efca5e1f04b'),(256,30,'craft\\elements\\Entry',1,0,'2019-05-11 15:04:47','2019-05-11 15:04:47',NULL,'699d30f6-3886-4fd9-88e3-444f7a3c07ee'),(257,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:04:48','2019-05-11 15:04:48',NULL,'9b56f926-c7c1-4edb-ae6c-1afc064d9b43'),(258,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:04:48','2019-05-11 15:04:48',NULL,'9be27702-4823-4e2f-a80c-41b2b187821a'),(259,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:04:48','2019-05-11 15:04:48',NULL,'351d60f7-068a-49db-8704-aa78040d6096'),(260,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:04:48','2019-05-11 15:04:48',NULL,'c9bb8bf3-fc79-4572-821d-0acb9d62f29d'),(261,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:04:48','2019-05-11 15:04:48',NULL,'e5e3c547-9888-47ab-8386-6bef23faf5b2'),(262,30,'craft\\elements\\Entry',1,0,'2019-05-11 15:05:29','2019-05-11 15:05:29',NULL,'c4fe1cfd-c294-4458-905e-92bbcf064c4b'),(263,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:05:30','2019-05-11 15:05:30',NULL,'24aa06b6-1274-40db-b3dd-87b2107ae572'),(264,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:05:30','2019-05-11 15:05:30',NULL,'40a516e5-239d-4f04-a363-e1a7974fc4a5'),(265,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:05:30','2019-05-11 15:05:30',NULL,'3b1cd22c-080f-4f2c-b19d-b1a0a913d058'),(266,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:05:30','2019-05-11 15:05:30',NULL,'31a7ae45-def9-4a64-a831-4224418558d8'),(267,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:05:30','2019-05-11 15:05:30',NULL,'e02c51f4-71fc-4066-aec0-81af11fd92fd'),(268,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:05:30','2019-05-11 15:05:30',NULL,'346efda7-5355-46b0-8506-809beac0d1e5'),(269,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:05:30','2019-05-11 15:05:30',NULL,'10dac8ae-1f8d-405b-b02f-dc368af00456'),(270,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:05:30','2019-05-11 15:05:30',NULL,'fd297aa5-310e-4765-86a1-1c8e23ef70c8'),(271,30,'craft\\elements\\Entry',1,0,'2019-05-11 15:06:17','2019-05-11 15:06:17',NULL,'5ac0eef6-9bc6-4760-9b23-b7dc4c49923d'),(272,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:06:17','2019-05-11 15:06:17',NULL,'62a25495-5a7e-44a4-835e-10952651a95f'),(273,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:06:18','2019-05-11 15:06:18',NULL,'a3fd1013-16e7-451d-8ced-7501aab9d0c8'),(274,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:06:18','2019-05-11 15:06:18',NULL,'c2ff984d-1a94-4047-91cd-d5685fe2681c'),(275,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:06:18','2019-05-11 15:06:18',NULL,'7cb46624-40dd-4be4-888c-ab5fedc99f51'),(276,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:06:18','2019-05-11 15:06:18',NULL,'bd7c3eb1-840b-48cd-b888-73c98f0e85ad'),(277,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:06:18','2019-05-11 15:06:18',NULL,'19fc31f6-8b9f-49de-a856-3667f7ccfb77'),(278,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:06:18','2019-05-11 15:06:18',NULL,'2413fb1e-62ae-4990-b3cf-ad0e26bd7b5a'),(279,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:06:18','2019-05-11 15:06:18',NULL,'66641b42-297f-43b1-81f0-ee779da87d25'),(280,30,'craft\\elements\\Entry',1,0,'2019-05-11 15:06:59','2019-05-11 15:06:59',NULL,'06801a68-685c-461c-9a8e-34555058e915'),(281,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:00','2019-05-11 15:07:00',NULL,'27c60c3c-1023-48d5-b776-85245a6422a0'),(282,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:00','2019-05-11 15:07:00',NULL,'ba8da24d-825c-41de-ac05-a76c24c9ee71'),(283,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:00','2019-05-11 15:07:00',NULL,'e42f5fdf-2bad-49a6-9c7d-58b77eafaa82'),(284,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:00','2019-05-11 15:07:00',NULL,'96145ea3-3370-4145-82dc-5b38a73ceef7'),(285,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:00','2019-05-11 15:07:00',NULL,'62730dd9-7b48-413f-8dd0-2530cc9683c0'),(286,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:00','2019-05-11 15:07:00',NULL,'959caa72-083a-47a4-bac5-d738f6fe71b4'),(287,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:00','2019-05-11 15:07:00',NULL,'e377282b-cf9e-4682-82f7-c7628616e4ac'),(288,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:00','2019-05-11 15:07:00',NULL,'44860304-826a-41cc-93bc-9be21d073cfc'),(289,30,'craft\\elements\\Entry',1,0,'2019-05-11 15:07:43','2019-05-11 15:07:43',NULL,'5a44fa16-27a0-4d90-9f1e-5f4cef98fb02'),(290,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:44','2019-05-11 15:07:44',NULL,'c0e16952-3e5e-4924-9f15-72e42301f3ed'),(291,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:44','2019-05-11 15:07:44',NULL,'cb7a1997-1c7a-4896-9caf-1833dd6bd426'),(292,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:44','2019-05-11 15:07:44',NULL,'49bafb3f-a60a-42e1-8938-e15e4878cef2'),(293,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:44','2019-05-11 15:07:44',NULL,'80b88ad5-ffef-4fd4-90f6-bac0d2eb0c53'),(294,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:44','2019-05-11 15:07:44',NULL,'562376ef-9f44-49ad-9bde-927b2ac3def8'),(295,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:44','2019-05-11 15:07:44',NULL,'ebc845de-07a3-4198-bc05-df7cecbd10dd'),(296,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:44','2019-05-11 15:07:44',NULL,'a2aa6e7b-53aa-4ae3-8d76-822fd3b8f514'),(297,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:07:44','2019-05-11 15:07:44',NULL,'13eeace3-1f5c-4cd8-a164-66221555c018'),(298,30,'craft\\elements\\Entry',1,0,'2019-05-11 15:08:25','2019-05-11 15:08:25',NULL,'2c7541c7-b3f7-4d43-b436-0bb558a07b31'),(299,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:08:25','2019-05-11 15:08:25',NULL,'790c3269-d900-48cc-9434-9679b426feb5'),(300,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:08:26','2019-05-11 15:08:26',NULL,'ceee9553-d29d-494d-82ec-fb01de2d4fd6'),(301,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:08:26','2019-05-11 15:08:26',NULL,'24e58073-5dfa-4fb0-bbd2-6d773bc4c3fe'),(302,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:08:26','2019-05-11 15:08:26',NULL,'3976c8a5-8062-4ba3-8d98-18626e1df8e4'),(303,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:08:26','2019-05-11 15:08:26',NULL,'482ed425-684b-4d5b-9105-146c02620b1c'),(304,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:08:26','2019-05-11 15:08:26',NULL,'67df81ef-38a1-4760-b87f-1e2077886530'),(305,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:08:26','2019-05-11 15:08:26',NULL,'600efde7-df9d-440e-9eac-d3169a920e7a'),(306,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:08:26','2019-05-11 15:08:26',NULL,'deca47c9-062c-4c4b-8e29-c623612707e5'),(307,30,'craft\\elements\\Entry',1,0,'2019-05-11 15:09:10','2019-05-11 15:09:10',NULL,'38b9c9f2-588c-41cb-b064-e5cd22d8ed70'),(308,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:09:10','2019-05-11 15:09:10',NULL,'505b43f2-49ce-4ce8-aab8-dd5cea805ced'),(309,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:09:10','2019-05-11 15:09:10',NULL,'358edb14-6afa-459e-b4bf-c89fb37dd0bf'),(310,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:09:10','2019-05-11 15:09:10',NULL,'e49866e1-7f89-403b-8543-a480d3644060'),(311,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:09:10','2019-05-11 15:09:10',NULL,'88fb787b-6f65-4bef-9498-6516986ea44c'),(312,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:09:10','2019-05-11 15:09:10',NULL,'160c1b03-aa0e-4627-b814-d24ce94e6720'),(313,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:09:10','2019-05-11 15:09:10',NULL,'b6e6c510-b807-4b59-97bd-11408a493010'),(314,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:09:10','2019-05-11 15:09:10',NULL,'3e350c57-725e-4cf8-8a1a-47628705c10d'),(315,31,'craft\\elements\\MatrixBlock',1,0,'2019-05-11 15:09:10','2019-05-11 15:09:10',NULL,'fca668a0-fdb5-41f5-8d11-abafeeb85f3c');
/*!40000 ALTER TABLE `acr_elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_elements_sites`
--

LOCK TABLES `acr_elements_sites` WRITE;
/*!40000 ALTER TABLE `acr_elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2018-09-30 15:22:58','2018-09-30 15:22:58','8bbc4622-8196-4e56-80a4-a968526be9c4'),(2,2,1,'test-event',NULL,1,'2018-09-30 15:31:33','2018-09-30 15:33:39','36992236-7e84-445f-8f47-d24ac6767d8d'),(3,3,1,NULL,NULL,1,'2018-10-08 23:42:03','2018-10-08 23:50:21','b34f533a-cce7-4c3f-aecf-8a8555a4a032'),(5,5,1,NULL,NULL,1,'2018-10-08 23:50:14','2018-10-08 23:50:14','cfdc4b8a-4174-4898-a0ce-d7274acf217a'),(6,6,1,'about','about',1,'2018-10-08 23:53:17','2019-02-05 02:46:19','ce44c268-1787-4211-b206-c6acb1e3dc59'),(8,8,1,'home','__home__',1,'2018-10-10 23:42:21','2019-01-27 18:25:14','388e0d47-87cb-417d-a9a6-75dc7f882fb5'),(9,9,1,NULL,NULL,1,'2018-10-24 01:14:03','2018-10-24 01:14:03','8efe39ca-9a51-4a8b-96a7-d933d42a8810'),(10,10,1,'sure-comfort-promotion','promotions/sure-comfort-promotion',1,'2018-10-24 01:14:25','2019-01-27 18:02:05','98e425f7-6dd3-4590-848a-e444ea5bc4fa'),(11,11,1,'new-store-hours','notifications/new-store-hours',1,'2018-11-02 01:21:37','2019-02-09 21:39:17','a95463ed-db16-45db-b65a-f57f420bb9e6'),(12,12,1,NULL,NULL,1,'2018-11-02 02:36:30','2019-01-27 18:25:14','a840a50c-1706-4f56-8d5a-8a134630e409'),(13,13,1,NULL,NULL,1,'2018-11-02 02:36:30','2019-01-27 18:25:14','2adcaa2c-67ef-4aad-9ab4-9d4602782f8d'),(14,14,1,NULL,NULL,1,'2018-11-02 02:36:30','2019-01-27 18:25:14','3e256002-a1b9-4df1-a656-c0b45093bd97'),(15,15,1,NULL,NULL,1,'2018-12-08 01:31:48','2018-12-08 01:31:48','3e092c46-e383-42e5-9b65-c1bb87e70a65'),(16,16,1,NULL,NULL,1,'2018-12-08 01:32:00','2019-01-27 18:25:14','ecd29ad5-20ab-49f9-805f-0ca2c1f2a81b'),(17,17,1,NULL,NULL,1,'2018-12-08 01:32:00','2019-01-27 18:25:14','4e1b460a-6a2c-49e5-9d9b-ba283e7c1cab'),(18,18,1,'mark-webster-testimonial','testimonials/mark-webster-testimonial',1,'2018-12-30 16:13:20','2018-12-30 16:13:20','bd10e5fc-21ea-40f9-9813-d67ff6d8267d'),(22,22,1,NULL,NULL,1,'2018-12-30 16:43:46','2019-05-11 15:35:34','dc85844b-343f-4182-854b-c4448b9f2670'),(24,24,1,'locations','locations',1,'2019-01-02 01:08:25','2019-01-21 18:24:32','66e9017d-d106-4f4a-956f-e322fc01b1fb'),(25,25,1,NULL,NULL,1,'2019-01-02 01:14:24','2019-01-21 18:24:32','fe130109-2ad6-46f4-b776-1b89d4a0f4fb'),(26,26,1,NULL,NULL,1,'2019-01-02 01:15:08','2019-01-21 18:24:32','f0bb3f17-d74b-48b0-8d07-87e3bf2fd868'),(27,27,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','e2117512-1871-4a77-a548-b6a86f0db300'),(28,28,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','e346fd94-fcaf-42e4-b75b-5868bbaf5ae3'),(29,29,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','304b9916-3f26-44c0-9042-17f79d3e46e1'),(30,30,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','376bb6d7-147c-4465-bde2-f8a06f13de8d'),(31,31,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','ae06855e-2dc3-471b-83af-a22ed5aaf0c0'),(32,32,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','7061c9f9-96a2-40f8-889f-f1d0ef4f639e'),(33,33,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','184c8bff-a14c-44d6-8db9-c72f3ff6255d'),(34,34,1,'acr-cares','acr-cares',1,'2019-01-23 02:23:36','2019-01-23 03:05:07','f8e9985e-83f1-4187-93c5-4631b622aa7f'),(35,35,1,NULL,NULL,1,'2019-01-23 02:51:12','2019-01-23 03:05:07','be7d53c6-420c-4763-a3af-2d227f2662da'),(36,36,1,NULL,NULL,1,'2019-01-23 02:51:12','2019-01-23 03:05:07','9d19c43c-0a48-474c-829e-0e09c6d55fa6'),(37,37,1,NULL,NULL,1,'2019-01-23 02:56:28','2019-01-23 03:05:07','3c9dc43e-98d1-4354-9cfc-56cfe940477a'),(38,38,1,NULL,NULL,1,'2019-01-23 02:56:29','2019-01-23 03:05:07','13b0a491-b635-4ff8-83a7-4a2c95108c6d'),(39,39,1,NULL,NULL,1,'2019-01-23 02:56:29','2019-01-23 03:05:07','2c290840-f5b6-405c-a198-4b55c883a466'),(40,40,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','e5e33e9a-5f1a-4388-b7fd-4d830042d80f'),(41,41,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','53347df3-540a-4040-8071-810396c50b4e'),(42,42,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','e627d22c-1e1c-4c38-b5ad-f84a167a4136'),(43,43,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','7ee706be-cf8d-4a95-932c-fb1a226aeaf1'),(44,44,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','8a5e381c-1429-4750-afd0-5127f17c155f'),(45,45,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','d5ca4fc3-154f-485c-b5d7-a734947797e4'),(46,46,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','42da810d-7d84-458a-a270-259707733164'),(47,47,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','4838d8a2-d8af-4165-ae27-53318644c3c4'),(48,48,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','2cd2af72-6ae1-4805-af8f-c85dcf43d1a2'),(49,49,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','e4651b3d-ed0b-45e3-a9a4-10b778454d55'),(50,50,1,'contact','contact',1,'2019-01-24 01:56:00','2019-01-24 01:56:00','cc94f76c-2e9e-4cb9-a65c-d4f048e77bac'),(51,51,1,NULL,NULL,1,'2019-01-24 02:00:21','2019-01-24 02:00:21','198dcbc3-b162-43d7-a3b8-babfe49016b9'),(52,52,1,'request-e-store-account','request-e-store-account',1,'2019-01-24 02:30:36','2019-01-24 02:30:43','64d679f2-03ca-472b-b05d-98a0614f5314'),(53,53,1,'e-store-credit-application','estore-credit-application',1,'2019-01-24 02:36:46','2019-01-24 02:36:47','1d335c4a-bc14-4e33-9b69-0ac586a813cb'),(54,54,1,'pay-online','pay-online',1,'2019-01-24 03:20:09','2019-01-24 03:20:09','36541050-1264-4afa-8b27-d1e5cc9f676e'),(55,55,1,'training-and-education','training-and-education',1,'2019-01-25 02:16:36','2019-01-25 02:16:36','9d3d7c68-e4c2-4aca-a11e-b7e18e96208b'),(56,56,1,'scholarships','scholarships',1,'2019-01-25 02:27:28','2019-05-11 14:33:41','130e8730-c025-4f8e-a3be-699713b5a3bc'),(57,57,1,'careers','careers',1,'2019-01-25 02:29:08','2019-01-25 02:29:08','f00f63e3-6d35-47e6-a277-a9d26355119e'),(58,58,1,'associates','associates',1,'2019-01-25 02:30:45','2019-01-25 02:30:45','9e648024-5a5e-4960-ae35-2f862e8f2921'),(59,59,1,'the-story','the-story',1,'2019-01-25 02:32:27','2019-01-25 02:33:02','339734ac-ea58-4b26-80e1-1096e00c28ac'),(60,60,1,'about-us','pages/about-us',1,'2019-01-25 02:42:54','2019-01-25 02:42:54','f122838f-6c4f-4f5a-a2de-bcb02e69050d'),(61,61,1,NULL,NULL,1,'2019-01-27 17:54:55','2019-01-27 17:55:11','eba08130-c4a3-4b1b-8101-1e29dd486903'),(62,62,1,NULL,NULL,1,'2019-01-27 18:01:51','2019-01-27 18:01:51','81d7c632-a0e7-4885-91a7-e13335eb1f28'),(63,63,1,NULL,NULL,1,'2019-01-27 18:14:58','2019-01-27 18:14:58','ba16f177-b175-45cf-b3bb-9bd05c9fcd42'),(64,64,1,'dec18-promotion','promotions/dec18-promotion',1,'2019-01-27 18:15:14','2019-01-27 18:17:46','2d863177-8ee0-43ad-b7f4-977f757a2c9a'),(65,65,1,NULL,NULL,1,'2019-01-27 18:23:01','2019-01-27 18:23:01','08f769df-08d5-4b8b-b48a-3922ab9622ba'),(66,66,1,NULL,NULL,1,'2019-01-27 18:23:12','2019-01-27 18:23:12','fba7b1f6-c05b-4080-95b4-810cd427dddb'),(67,67,1,NULL,NULL,1,'2019-01-27 18:29:04','2019-02-01 01:54:10','8a769fce-d900-4d19-a3d3-916a1ecfc89f'),(68,68,1,NULL,NULL,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','b2364e15-9c1c-4ef8-9e98-93c2051a58f9'),(69,69,1,NULL,NULL,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','38d44bab-11d2-4536-b7c3-07c185150b20'),(70,70,1,NULL,NULL,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','b21f0d62-0d5c-45bf-82e2-13a31f5cc3be'),(71,71,1,NULL,NULL,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','e7e0796f-8183-455a-b742-a6ea619f53bd'),(72,72,1,NULL,NULL,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','6fe57822-f381-4b12-b72e-70809b6309f8'),(73,73,1,NULL,NULL,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','d29afc0e-2b88-4ae8-894d-494f550d1c15'),(74,74,1,NULL,NULL,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','73fe9c97-6692-49d9-a9d7-0ddcba7ee054'),(75,75,1,NULL,NULL,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','ffe1fde8-b26c-4637-ad20-ef358e55b111'),(76,76,1,NULL,NULL,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','ddb2ee36-f531-45f8-8085-ee3e503a7a67'),(77,77,1,NULL,NULL,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','f4b3a398-3004-4c39-9541-aeb0b88f326d'),(78,78,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','246b06cc-34e6-4516-83db-228f5df4306f'),(79,79,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','e14b3e1b-5eb3-499e-aba3-2bc2baddeeb0'),(80,80,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','5d51a0f2-7cff-4d74-962f-c54d225cd25d'),(81,81,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','d8c2a15a-0d30-477e-9f01-28ee9abf4e11'),(82,82,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','e1d2b58a-19d0-4e43-b9fc-c2f3695ec401'),(83,83,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','8e326960-dbfb-4b00-b19d-58abaa9c4918'),(84,84,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','e570c0c9-3dc1-4641-af74-2d08cb859cc1'),(85,85,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','a22549aa-ebfc-4cdc-9053-0302d10700ac'),(86,86,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','ff1f885e-06d7-4cda-bf70-0774668d9194'),(87,87,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','57ff9dd5-dcbd-4326-9886-597cad87190c'),(88,88,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','ce05e13f-ce23-4301-a49d-fe79687e58fc'),(89,89,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','eb46aae3-0518-4fc5-ac9c-e15265db04fb'),(90,90,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','4aa36be1-b771-40dc-873e-a18c8c6b73a8'),(91,91,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','af2dd6b4-f255-4ea5-ab11-91a642a5a879'),(92,92,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','05dd3fae-a75b-44b9-b48c-02b429f93a0c'),(93,93,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','fcf70ab7-7311-487d-b41d-60f9f5a983fe'),(94,94,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','e6d4442a-8142-4b28-9423-704a8bf1d47d'),(95,95,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','2bf3b2a0-f630-4726-be51-ec6c6a0f97cc'),(96,96,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','2b67047b-389c-4ba3-8114-1ce9c577e152'),(97,97,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','899a3463-ebab-4400-87ca-a5ae9d050dc3'),(98,98,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','3be1aea3-f534-4c6e-a93a-4b09eec9cb5c'),(99,99,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','65af43fd-113b-4d9e-8e50-895178fc03c7'),(100,100,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','4d467b72-cb61-4175-9773-cb2c530ae831'),(101,101,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','cc9b31e5-acef-44bf-95c2-b8cd0af3b019'),(102,102,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','4920cb78-73b7-43ee-a7f5-f08a3e6f06ce'),(103,103,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','81e11f8c-2b93-447c-b858-c8169b5283ca'),(104,104,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','30bba75f-39e6-48a9-ae3a-0e05ba309bad'),(105,105,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','f486f002-8db9-489a-979b-ccd8787edf12'),(106,106,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','4c4c067e-8bae-403e-87a7-a61ac870c463'),(107,107,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','594d8d96-0d48-48bd-be8d-b1672c6ee1f3'),(108,108,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','9f845155-04d5-4053-af8e-702126f131de'),(109,109,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','fc1648fc-156f-44ff-b079-5fd1c7b43908'),(110,110,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','85fdf7ce-8bc0-4eb1-acdb-3806107d59d9'),(111,111,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','4183ced5-514d-4f42-ae1b-b3ac176e49a6'),(112,112,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','7acc9f7b-9b63-4540-a999-e8d9d17df005'),(113,113,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','3210b6a0-6e8f-4185-b9f7-d683bb1ea43f'),(114,114,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','2cd45af1-6796-44a0-a6b7-bf51c79fe040'),(115,115,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','6aae0d92-42b8-4514-8361-0f540ebb4581'),(116,116,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','d9e8a74a-6d18-4ab4-9386-4fddcf62670d'),(117,117,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','202a4be7-de99-4603-9f66-b2e7333065f4'),(118,118,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','58ed3594-e38b-4ff9-ab0f-f84f99df7481'),(119,119,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','7d6a6c28-7dad-4c76-8ab2-ca85d2328b2f'),(120,120,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','89d3a34c-1eb5-4a09-b3ae-d3f058772620'),(121,121,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','c7e7ac92-4e48-47cf-8ec7-dd08cd703b19'),(122,122,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','a80fe882-361b-4730-bdbc-c5171f54e8e8'),(123,123,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','64eb45e1-a3ca-433a-972c-c33a139a93ea'),(124,124,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','f261ef6b-f83e-4f78-86e4-9af6cc2aa277'),(125,125,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','fbbc992c-59c8-46a5-a631-ab8b22522ddc'),(126,126,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','bcf60850-f905-4125-a927-e4398fdfd8d6'),(127,127,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','17df4355-7792-4549-a9ea-d5b5dc8169c7'),(128,128,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','6ed0fa4b-7bfd-43f8-9f9b-cbfd81047e27'),(129,129,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','914c1472-3da7-4de5-8386-9a5e2254a79f'),(130,130,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','9c71bbac-fc5f-4068-9b6e-ab3626b10c94'),(131,131,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','e1b48535-c773-4d7d-85d6-5709dee65dd9'),(132,132,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','b12556ac-3de1-4e94-979b-0b5cc812a48c'),(133,133,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','3176b126-3b23-49fa-9e4b-89eb0b45995b'),(134,134,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','515f9139-c713-4612-9591-245743251721'),(135,135,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','33343bc8-159b-4642-9df0-1e1e257c616c'),(136,136,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','62278c96-aff7-40f6-b482-087130ddf511'),(137,137,1,NULL,NULL,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','da3d3f51-6a81-4595-a7ce-9df44baa017f'),(138,138,1,NULL,NULL,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','298594d2-9046-488c-b000-c4177482abae'),(139,139,1,NULL,NULL,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','2b00ace8-9722-4a57-9c34-666851b1e659'),(140,140,1,NULL,NULL,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','852f8281-2d53-4716-9766-8044800c9783'),(141,141,1,NULL,NULL,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','b9c0b192-010a-4a7d-aa81-91207137bea5'),(142,142,1,NULL,NULL,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','a8968628-41a3-43ac-b574-6569de63f907'),(143,143,1,NULL,NULL,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','c1914cac-bff0-4ab1-8055-0a323fc7835f'),(144,144,1,NULL,NULL,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','87d9731b-c558-4331-a49f-b9321057715d'),(145,145,1,NULL,NULL,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','a5b12af6-70b2-4656-b04a-27f8b7129393'),(146,146,1,NULL,NULL,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','116fbc52-0f90-4e1a-9087-478fc72cc24e'),(147,147,1,NULL,NULL,1,'2019-02-09 21:37:07','2019-02-09 21:37:07','ca826c29-dac0-47cf-95e1-0037640cd3f4'),(148,148,1,'vendors','vendors',1,'2019-02-10 01:28:33','2019-02-10 15:01:02','e0387819-74c1-4958-9cc0-e35546442998'),(149,149,1,NULL,NULL,1,'2019-02-10 01:33:17','2019-02-10 01:33:17','c4b91f02-a0fa-4d9f-bda0-1d97e6206c9e'),(150,150,1,NULL,NULL,1,'2019-02-10 01:33:17','2019-02-10 01:33:17','8eac8460-d21c-44ba-9c03-767366020a69'),(151,151,1,NULL,NULL,1,'2019-02-10 01:33:18','2019-02-10 01:33:18','25bf2ccc-b943-4e83-bbab-fcdbf6d4b7c4'),(152,152,1,NULL,NULL,1,'2019-02-10 01:33:18','2019-02-10 01:33:18','62f3c284-ecc2-41e8-8b4d-b7cbe87c6182'),(153,153,1,NULL,NULL,1,'2019-02-10 01:33:18','2019-02-10 15:01:02','49491fb7-e55b-4eda-92ed-d57f872a8156'),(154,154,1,NULL,NULL,1,'2019-02-10 01:33:18','2019-02-10 15:01:02','10996cfd-fadf-4922-86c5-41772266e4ee'),(155,155,1,NULL,NULL,1,'2019-02-10 01:33:18','2019-02-10 15:01:02','712873ab-709a-45eb-b730-1097c22acd18'),(156,156,1,NULL,NULL,1,'2019-02-10 01:33:18','2019-02-10 15:01:02','07eecfd3-108a-4d2c-84cd-c6417a2699e9'),(157,157,1,NULL,NULL,1,'2019-02-10 01:33:49','2019-02-10 15:01:02','6d46f8f5-0a0a-48a8-8389-9252952ee7c3'),(158,158,1,NULL,NULL,1,'2019-02-10 01:38:23','2019-02-10 15:01:02','a7042381-07ca-4f75-b910-c69c0d419c48'),(159,159,1,NULL,NULL,1,'2019-02-10 01:38:23','2019-02-10 15:01:02','ac653260-1f55-4a43-a01d-52bdff3107a9'),(160,160,1,NULL,NULL,1,'2019-02-10 01:38:24','2019-02-10 15:01:02','9ad8f4fe-7ee0-4757-bc10-84ed0555aed5'),(161,161,1,NULL,NULL,1,'2019-02-10 01:38:24','2019-02-10 15:01:02','4fece8a3-1dfc-49aa-ae25-985be8defbe7'),(162,162,1,NULL,NULL,1,'2019-02-10 01:38:24','2019-02-10 15:01:02','bfb6e0fb-429d-4141-a54b-492270811c97'),(163,163,1,NULL,NULL,1,'2019-02-10 01:38:24','2019-02-10 15:01:02','d4490446-0a0e-4d3b-b28f-de986686186b'),(164,164,1,NULL,NULL,1,'2019-02-10 01:38:24','2019-02-10 15:01:02','f2e55078-bff9-4000-8fa6-026d3937ff0a'),(165,165,1,NULL,NULL,1,'2019-02-10 01:38:24','2019-02-10 15:01:03','1be479c1-2163-488a-99c9-107548f75290'),(166,166,1,NULL,NULL,1,'2019-02-10 01:38:24','2019-02-10 15:01:03','ed5bf741-5a85-466b-b9cb-ba883fbe6c49'),(167,167,1,NULL,NULL,1,'2019-02-10 01:38:24','2019-02-10 15:01:03','b7c347b5-b6ec-460c-bf9e-f713020a32fb'),(168,168,1,NULL,NULL,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','914c9c13-d2c8-48ac-b336-36c1f012bed1'),(169,169,1,NULL,NULL,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','7425c5fa-331b-4923-b9d9-56763944d726'),(170,170,1,NULL,NULL,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','68dc9c0a-665e-4d2a-97dd-47ca06930a04'),(171,171,1,NULL,NULL,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','f4a89dba-cff7-40b4-a3b9-c0a6cc00f9b5'),(172,172,1,NULL,NULL,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','1a73e742-de90-44ad-bc0c-d8df88298680'),(173,173,1,NULL,NULL,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','18a2e427-c7ad-467f-9d75-04e6023088f1'),(174,174,1,NULL,NULL,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','d37f11ef-2f6c-4d9a-80e8-ecd8fd70815b'),(175,175,1,NULL,NULL,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','fcafa72a-a344-48c4-948d-5d7f6318b3a4'),(176,176,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','0340a576-a283-47e0-b1db-93965eb54ee8'),(177,177,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','c0caa904-2cd6-4b17-8711-75d7b8da3797'),(178,178,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','3f5bad8d-28ea-4e72-ba35-3fb00b3d0d65'),(179,179,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','3184bd1e-639c-4f3e-8309-602fc77a47d4'),(180,180,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','8f112377-5039-4a03-8246-a9b01cc63a1a'),(181,181,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','6d03a709-2df1-43ec-9e9a-692dff1ba12c'),(182,182,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','3561885c-c52e-463e-ba0f-b69be7eab184'),(183,183,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','94a50d6a-6c2e-4d7b-944d-90677f6a48cf'),(184,184,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','9663f013-7929-44cf-9b95-4b7c5fc8c5fd'),(185,185,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','cc60ca5b-7dd2-45fc-bbc0-579fd286ef76'),(186,186,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','e8c9a88e-601c-4882-abca-fbaa2ef4c705'),(187,187,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','d3a7385e-091c-49b9-a6a3-b91188b5d96b'),(188,188,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','589d8354-b102-4985-bc74-0510cbd70202'),(189,189,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','9cbd61e7-8eca-4c97-ab02-24e4447b58be'),(190,190,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','dcffb37e-96ee-4b50-98b0-fad5d76c5db9'),(191,191,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','d1a1419a-d08b-49fd-8410-f97608e39508'),(192,192,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','135f3212-b029-433c-8737-f50ec0f12b55'),(193,193,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','9d88a26d-2604-4ddb-a6d7-22ef0a93c89c'),(194,194,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','3e3bc5a7-23bf-4298-b372-1349188395ee'),(195,195,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','045a870d-57f9-4706-8fc1-63e329caa2ed'),(196,196,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','83aa3fff-f7d4-4df9-b4e6-1a52e3add587'),(197,197,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','8a546777-df9e-4e80-9de1-febf2f04f82d'),(198,198,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','5f74356e-9938-4bed-b0d4-dd7a9a740982'),(199,199,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','1aabc555-b395-4356-bbd9-7fe52ae77b6b'),(200,200,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','2b75a4f0-ccc3-4e5a-95a5-4e58014f6d87'),(201,201,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','46940980-e2fb-4bfa-a01d-0247d929ef64'),(202,202,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','ea8f17d7-9776-4273-9714-8078ac507bb6'),(203,203,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','60ff6edc-610d-4460-b938-8df71b1d7e57'),(204,204,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','878fd0e6-3c57-4451-a758-26e903d11c8b'),(205,205,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','a247964f-7dbb-47b8-b2f0-9f98713294dd'),(206,206,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','073559f5-1e80-4881-bdcf-dd0dad1c6b79'),(207,207,1,NULL,NULL,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','723ec53a-bde4-4461-8e60-e00c38180ba2'),(208,208,1,NULL,NULL,1,'2019-02-10 14:50:02','2019-02-10 15:01:03','9b5490d2-8706-4120-8e51-2baeea41dd16'),(209,209,1,NULL,NULL,1,'2019-02-10 14:50:02','2019-02-10 15:01:03','3ded82b0-6f54-4489-93cb-835d2a1871b3'),(210,210,1,NULL,NULL,1,'2019-02-10 14:51:49','2019-02-10 15:01:03','4c2326cc-a7ea-4d38-8259-776f1ce9b622'),(211,211,1,NULL,NULL,1,'2019-02-10 14:51:49','2019-02-10 15:01:03','9b847b3e-977f-4f4c-81ef-1abb3cdb2889'),(212,212,1,NULL,NULL,1,'2019-02-10 14:51:49','2019-02-10 15:01:03','1f24d308-9b76-4c6a-940e-faf319d29e20'),(213,213,1,NULL,NULL,1,'2019-02-10 14:51:49','2019-02-10 15:01:03','4520a6ff-69fd-4f67-9743-a428e4e19713'),(214,214,1,NULL,NULL,1,'2019-02-10 14:51:49','2019-02-10 15:01:03','89ff31ff-94af-47d0-86d3-ffe8597334cb'),(215,215,1,NULL,NULL,1,'2019-02-10 15:01:03','2019-02-10 15:01:03','52b4c280-2d06-4c91-af82-bbe66f59f3d0'),(216,216,1,NULL,NULL,1,'2019-02-10 15:01:03','2019-02-10 15:01:03','9b3fb640-98b6-43db-a5dc-c0b9df82c175'),(217,217,1,NULL,NULL,1,'2019-02-10 15:01:03','2019-02-10 15:01:03','f4f76185-cbd0-4fab-b79b-d3fa583f7b41'),(218,218,1,NULL,NULL,1,'2019-02-10 15:01:03','2019-02-10 15:01:03','fa181e31-62ff-4c67-9a2e-f155fbd88685'),(219,219,1,NULL,NULL,1,'2019-02-10 15:01:04','2019-02-10 15:01:04','c50ff1a9-37d8-4afa-8043-89ce249723cf'),(220,220,1,'emerson-copeland-teardown-class-durham-acr','calendar/event/emerson-copeland-teardown-class-durham-acr',1,'2019-03-24 19:27:06','2019-05-11 14:04:30','358d181b-8b26-4888-b980-a670593a4217'),(221,221,1,'emerson-copeland-teardown-class-raleigh-acr','calendar/event/emerson-copeland-teardown-class-raleigh-acr',1,'2019-03-24 19:27:43','2019-05-11 14:04:31','5146f653-8976-4dda-8794-e7ce81f5b32a'),(222,222,1,'2019-acr-hvac-refrigeration-expo','calendar/event/2019-acr-hvac-refrigeration-expo',1,'2019-03-24 19:28:32','2019-05-11 14:08:40','cb676cae-bd6e-4283-8fae-64e917cbf4b3'),(223,223,1,'john-smith','scholarships/john-smith',1,'2019-05-11 14:24:49','2019-05-11 14:24:49','bf46fafd-3a55-46b4-9e9d-d75a225681e7'),(224,224,1,'2009-2010','scholarship-years-recipients/2009-2010',1,'2019-05-11 14:36:59','2019-05-11 15:00:35','cc59eb1e-ae8b-40b0-a86e-28409addb5eb'),(225,225,1,NULL,NULL,1,'2019-05-11 14:36:59','2019-05-11 15:00:35','13781543-942a-4c39-b871-6ec371a8f4a9'),(226,226,1,'2010-2011','scholarship-years-recipients/2010-2011',1,'2019-05-11 14:46:39','2019-05-11 15:01:17','8a0ec50e-ef70-464d-ae3e-0c0b2855c7a5'),(227,227,1,NULL,NULL,1,'2019-05-11 14:46:39','2019-05-11 15:01:18','f034a9af-205a-452d-807f-5a8ace80ffc1'),(228,228,1,NULL,NULL,1,'2019-05-11 14:58:07','2019-05-11 15:01:18','4b141a21-edd5-46f4-9fe1-8e678a7aee38'),(229,229,1,NULL,NULL,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','f0b02a82-a997-4af9-b51f-e18d6b56872a'),(230,230,1,NULL,NULL,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','67378885-d26f-4f11-895f-c49c4563c61e'),(231,231,1,NULL,NULL,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','82acc7c3-0775-4c23-ac4a-f024479b0bdc'),(232,232,1,NULL,NULL,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','51100b4d-2cb0-4b7f-86b3-254847e48764'),(233,233,1,NULL,NULL,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','c2b67a72-c678-4d20-a0ad-993674f83813'),(234,234,1,NULL,NULL,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','0949756f-c8e4-4d9f-b4ba-d10ddb7e48c6'),(235,235,1,NULL,NULL,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','4bf5b8a1-cf49-4a84-8f7b-1f960cb1e504'),(236,236,1,NULL,NULL,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','7b10aa57-8c24-4bed-b604-9972dec188e5'),(237,237,1,NULL,NULL,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','29f2347f-3554-45ee-8982-9f49b9463415'),(238,238,1,NULL,NULL,1,'2019-05-11 15:01:18','2019-05-11 15:01:18','7f627afb-4047-402f-a203-fa54734f7a54'),(239,239,1,NULL,NULL,1,'2019-05-11 15:01:18','2019-05-11 15:01:18','5f4e650b-3d10-4d26-b34e-cd2f27ec2aaa'),(240,240,1,NULL,NULL,1,'2019-05-11 15:01:18','2019-05-11 15:01:18','0f67babb-7526-4b05-88c6-ddd18e31cc21'),(241,241,1,'2011-2012-school-year','scholarship-years-recipients/2011-2012-school-year',1,'2019-05-11 15:02:03','2019-05-11 15:02:03','c2de0583-0487-454d-9a37-b99a5f24a855'),(242,242,1,NULL,NULL,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','5e4135a0-d3d0-4ce3-9658-c43e36c8e80c'),(243,243,1,NULL,NULL,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','36a8c51c-bb5e-4cb7-8d42-769fa1b49e80'),(244,244,1,NULL,NULL,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','f5e065dc-fcba-4163-a969-96963233eac7'),(245,245,1,NULL,NULL,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','db497121-d11f-4024-b9f6-4b3b4f5861e8'),(246,246,1,NULL,NULL,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','0d6f8867-c7b9-4d75-a681-2470ef1c7011'),(247,247,1,NULL,NULL,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','892f5ec4-c0fe-4502-b96e-10be3ed03ab1'),(248,248,1,'2012-2013-school-year','scholarship-years-recipients/2012-2013-school-year',1,'2019-05-11 15:03:48','2019-05-11 15:03:48','64b85d0b-e0dd-4c4f-bd0e-4a477380545c'),(249,249,1,NULL,NULL,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','59a09da3-1aaf-4ef5-8ad5-c710d40c98cc'),(250,250,1,NULL,NULL,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','f81b2ad6-668e-4ca6-82bc-a59eb41800a2'),(251,251,1,NULL,NULL,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','07b471ef-3a94-490b-8a8f-a7f50b0cd014'),(252,252,1,NULL,NULL,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','ed09da7c-7f65-4c4e-94a5-0919d69f5b83'),(253,253,1,NULL,NULL,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','117d2988-e5b7-40e6-b19e-d74e5412014a'),(254,254,1,NULL,NULL,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','6113ad0e-97bf-4222-9e1e-71d7b35b8df9'),(255,255,1,NULL,NULL,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','dad3236f-2236-4036-b613-b181e1d4d8c4'),(256,256,1,'2013-2014-school-year','scholarship-years-recipients/2013-2014-school-year',1,'2019-05-11 15:04:47','2019-05-11 15:04:47','131e4424-1b9d-4bce-8124-99e765b87807'),(257,257,1,NULL,NULL,1,'2019-05-11 15:04:48','2019-05-11 15:04:48','40f9d0c2-3b7b-46ae-a27d-3ef3e94a57c2'),(258,258,1,NULL,NULL,1,'2019-05-11 15:04:48','2019-05-11 15:04:48','ff5264f4-8450-4ad7-a4fa-001a5ca553b5'),(259,259,1,NULL,NULL,1,'2019-05-11 15:04:48','2019-05-11 15:04:48','0f24a005-6b5b-41bd-9a88-cf194cd4d37d'),(260,260,1,NULL,NULL,1,'2019-05-11 15:04:48','2019-05-11 15:04:48','ce6967fd-7a56-4e37-b73d-03ecbfa7010a'),(261,261,1,NULL,NULL,1,'2019-05-11 15:04:48','2019-05-11 15:04:48','6be7ac89-c7b5-4c72-907b-dd59fa5d9532'),(262,262,1,'2014-2015-school-year','scholarship-years-recipients/2014-2015-school-year',1,'2019-05-11 15:05:30','2019-05-11 15:05:30','74bd6066-54d3-4d13-b4cf-f2f50970ce45'),(263,263,1,NULL,NULL,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','638fa92a-9ef8-4865-a943-d599aa7515d2'),(264,264,1,NULL,NULL,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','5238bf63-37bd-43e1-a84e-247cda570dff'),(265,265,1,NULL,NULL,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','ca72aea0-644c-410c-a5d2-f048a968dfb1'),(266,266,1,NULL,NULL,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','4e3c530a-f45c-4e4f-9ac9-9ad18bbf5ae1'),(267,267,1,NULL,NULL,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','6c7a2e7a-951a-4cb4-b672-faf970191b88'),(268,268,1,NULL,NULL,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','3f915375-f3a3-4846-b24b-324c02076a41'),(269,269,1,NULL,NULL,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','489c1f4d-306e-42c5-be75-e26d4538752b'),(270,270,1,NULL,NULL,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','1a25899c-ec90-4553-9af1-b48ed5402099'),(271,271,1,'2015-2016-school-year','scholarship-years-recipients/2015-2016-school-year',1,'2019-05-11 15:06:17','2019-05-11 15:06:17','12c79720-b64c-4253-b47c-32401a14c623'),(272,272,1,NULL,NULL,1,'2019-05-11 15:06:17','2019-05-11 15:06:17','a9ffe3c0-bf43-4ba0-a765-65b4079de310'),(273,273,1,NULL,NULL,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','1636e659-c0f9-422c-b206-7135635c71b3'),(274,274,1,NULL,NULL,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','b5825dce-bf8f-447f-a593-bb48790b5fd1'),(275,275,1,NULL,NULL,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','42601532-1fb1-410d-b3c6-9d37536e993c'),(276,276,1,NULL,NULL,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','66032724-d0c3-449c-99aa-5af3a4d50f2c'),(277,277,1,NULL,NULL,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','2ac5c4ef-ef75-406c-bed6-478f7e7ea47b'),(278,278,1,NULL,NULL,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','6cdcb6e9-ffa6-46fa-b2aa-c88169fceaac'),(279,279,1,NULL,NULL,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','3ba7196f-3419-4771-b274-1348223bf4a0'),(280,280,1,'2016-2017-school-year','scholarship-years-recipients/2016-2017-school-year',1,'2019-05-11 15:07:00','2019-05-11 15:07:00','8038e58d-0c95-4d31-9cdb-f1485b586821'),(281,281,1,NULL,NULL,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','4f50536d-0ada-4e7a-a86f-3bbb916bf3c0'),(282,282,1,NULL,NULL,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','5033d304-2c4f-4be1-b682-99ca43ec451e'),(283,283,1,NULL,NULL,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','334dff94-4995-45f7-88e6-fa7c56c32469'),(284,284,1,NULL,NULL,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','c52022d5-1572-4c52-be30-1166cb6f6943'),(285,285,1,NULL,NULL,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','13ddf730-30be-4c03-87b4-586f15f8eff5'),(286,286,1,NULL,NULL,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','b7c3d370-d184-433f-a6bd-4b82762ed800'),(287,287,1,NULL,NULL,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','5a9235fd-41bf-4626-9ac9-6b922c0baba3'),(288,288,1,NULL,NULL,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','741139e8-d3f5-495a-ac71-4e1a25bd40d4'),(289,289,1,'2017-2018-school-year','scholarship-years-recipients/2017-2018-school-year',1,'2019-05-11 15:07:43','2019-05-11 15:07:43','8686d3fc-54f7-4219-8bf7-3316fabf92ac'),(290,290,1,NULL,NULL,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','d808ffa8-0c91-4337-8299-6bdb50e95b86'),(291,291,1,NULL,NULL,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','b7998194-3b0b-4edc-bc26-b320d1cab459'),(292,292,1,NULL,NULL,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','e9afce16-98c9-41f6-bb07-0f45b41c32b5'),(293,293,1,NULL,NULL,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','ca5d19d0-6311-4f16-9463-17db3e2158ea'),(294,294,1,NULL,NULL,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','d5c0ee05-172b-4cd6-b228-12e0884b57b6'),(295,295,1,NULL,NULL,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','cde605c7-05d6-4880-9ba6-9c498bae2aa9'),(296,296,1,NULL,NULL,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','2ec242cd-0c91-4bc3-9984-57856bb77f9d'),(297,297,1,NULL,NULL,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','7a01a13a-2b5b-47ac-95ad-bfc59e9e4d5a'),(298,298,1,'2018-2019-school-year','scholarship-years-recipients/2018-2019-school-year',1,'2019-05-11 15:08:25','2019-05-11 15:08:25','b340dcf4-c5c4-403f-ab2f-315c7f1856a1'),(299,299,1,NULL,NULL,1,'2019-05-11 15:08:25','2019-05-11 15:08:25','118896af-813c-438b-ae4b-f06e5c081803'),(300,300,1,NULL,NULL,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','8d86e5ff-af56-457c-99b8-ff5f3b71e52e'),(301,301,1,NULL,NULL,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','d27290a8-c225-4e72-9443-e4c3e607dd4f'),(302,302,1,NULL,NULL,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','3335e7fe-e3fe-419f-932d-75f26f6a392c'),(303,303,1,NULL,NULL,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','ac2e47a9-3b8e-4c2f-a0d9-c9ee649f85f9'),(304,304,1,NULL,NULL,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','a3520f37-6c22-4a6c-b9a3-5b23b28a0f09'),(305,305,1,NULL,NULL,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','5153ae2f-a921-41e7-b70d-3604f967227d'),(306,306,1,NULL,NULL,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','7d393eb9-6839-438e-a3ad-e2fdf7d49354'),(307,307,1,'2019-2020-school-year','scholarship-years-recipients/2019-2020-school-year',1,'2019-05-11 15:09:10','2019-05-11 15:09:10','572466b2-9131-46e3-8ef2-cc80c47410b5'),(308,308,1,NULL,NULL,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','b323d7e9-eede-444a-ae1e-5cd3bbfd8a97'),(309,309,1,NULL,NULL,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','53941890-d317-4e07-975b-d21e0da92da3'),(310,310,1,NULL,NULL,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','20a55ffd-fbe6-48fb-a517-c4022b150821'),(311,311,1,NULL,NULL,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','7732fe3b-b08c-41e8-9337-b97ef1ce6913'),(312,312,1,NULL,NULL,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','f4ee7a53-6c1f-4285-8c4d-0c179502f143'),(313,313,1,NULL,NULL,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','de4d6bcd-5ab5-45b2-ab98-776dbdb81e28'),(314,314,1,NULL,NULL,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','b22ade7d-11a0-45c9-8ba5-e081a4f413c7'),(315,315,1,NULL,NULL,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','fd2cb4ab-fdea-46fd-8bd8-a4b6e0e96792');
/*!40000 ALTER TABLE `acr_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_entries`
--

LOCK TABLES `acr_entries` WRITE;
/*!40000 ALTER TABLE `acr_entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_entries` VALUES (6,2,NULL,2,NULL,'2018-10-08 23:53:00',NULL,NULL,'2018-10-08 23:53:17','2019-02-05 02:46:19','40261008-ec5f-4819-8096-eb7a5e85d82b'),(8,4,NULL,4,NULL,'2018-10-10 23:42:00',NULL,NULL,'2018-10-10 23:42:21','2019-01-27 18:25:14','eaaf27c6-41c3-49f2-8999-458fe83541d4'),(10,3,NULL,3,1,'2018-10-24 01:14:00',NULL,0,'2018-10-24 01:14:25','2019-01-27 18:02:05','3d540864-6415-4308-9d96-9b8c0bd6c7d8'),(11,5,NULL,5,1,'2018-11-02 01:21:00',NULL,NULL,'2018-11-02 01:21:37','2019-02-09 21:39:17','7d3688ad-8e1d-4e97-b4b8-0cd23648b462'),(18,6,NULL,6,1,'2018-12-30 16:13:00',NULL,NULL,'2018-12-30 16:13:20','2018-12-30 16:13:20','146641be-52f5-4381-aef4-a32d03d44b0f'),(24,8,NULL,8,NULL,'2019-01-02 01:08:00',NULL,NULL,'2019-01-02 01:08:25','2019-01-21 18:24:32','b0c38622-6d9f-4f5f-a88c-3f4910fe1449'),(34,9,NULL,9,NULL,'2019-01-23 02:23:00',NULL,NULL,'2019-01-23 02:23:36','2019-01-23 03:05:07','37f84c46-1032-4b5b-b0e0-d99f4b44784d'),(50,10,NULL,10,NULL,'2019-01-24 01:56:00',NULL,NULL,'2019-01-24 01:56:00','2019-01-24 01:56:00','f0973a1e-47f5-443f-8304-f9e0c4d0ce46'),(52,11,NULL,11,NULL,'2019-01-24 02:30:00',NULL,NULL,'2019-01-24 02:30:36','2019-01-24 02:30:43','1cf1b7e9-058c-4af0-afa5-fca1e9703520'),(53,12,NULL,12,NULL,'2019-01-24 02:36:00',NULL,NULL,'2019-01-24 02:36:46','2019-01-24 02:36:47','c62457ad-e00c-4f61-a435-ada84d913eac'),(54,13,NULL,13,NULL,'2019-01-24 03:20:00',NULL,NULL,'2019-01-24 03:20:09','2019-01-24 03:20:09','0521fc8b-8bfd-4f06-aafb-7080c645636a'),(55,14,NULL,14,NULL,'2019-01-25 02:16:00',NULL,NULL,'2019-01-25 02:16:36','2019-01-25 02:16:36','b6524440-8d7b-4606-94d8-c005d481b4b7'),(56,15,NULL,15,NULL,'2019-01-25 02:27:00',NULL,NULL,'2019-01-25 02:27:28','2019-05-11 14:33:41','b31b060b-8eab-41ae-9098-28c4b4ea74fb'),(57,16,NULL,16,NULL,'2019-01-25 02:29:00',NULL,NULL,'2019-01-25 02:29:08','2019-01-25 02:29:08','9be6058c-d024-4618-9776-706433fcedf8'),(58,17,NULL,17,NULL,'2019-01-25 02:30:00',NULL,NULL,'2019-01-25 02:30:45','2019-01-25 02:30:45','ec16de7a-ecd1-4ebe-ae6b-7106e8d3db76'),(59,18,NULL,18,NULL,'2019-01-25 02:32:00',NULL,1,'2019-01-25 02:32:27','2019-01-25 02:33:02','e34cdadc-63f9-402c-993f-18508e2617a8'),(60,19,NULL,19,1,'2019-01-25 02:42:00',NULL,NULL,'2019-01-25 02:42:54','2019-01-25 02:42:54','7fdefda0-e334-416e-97a6-682e20934a14'),(64,3,NULL,3,1,'2019-01-27 18:15:00',NULL,NULL,'2019-01-27 18:15:14','2019-01-27 18:17:46','1493351e-9ede-4f4c-a0f2-6697972c263c'),(148,20,NULL,20,NULL,'2019-02-10 01:28:00',NULL,NULL,'2019-02-10 01:28:33','2019-02-10 15:01:02','9dc0f352-95e3-4e42-9d49-794ad7a8c118'),(223,21,NULL,21,1,'2019-05-11 14:24:00',NULL,1,'2019-05-11 14:24:49','2019-05-11 14:24:49','522a60f2-e929-4072-b0b7-0bb9fb203253'),(224,22,NULL,22,1,'2019-05-11 14:36:00',NULL,NULL,'2019-05-11 14:36:59','2019-05-11 15:00:35','25ba80c7-2371-4d4b-9feb-aea4002654dc'),(226,22,NULL,22,1,'2019-05-11 14:46:00',NULL,NULL,'2019-05-11 14:46:39','2019-05-11 15:01:18','6e3e0e74-6bf2-4e21-b7e3-bf69680fd47a'),(241,22,NULL,22,1,'2019-05-11 15:02:00',NULL,NULL,'2019-05-11 15:02:03','2019-05-11 15:02:03','4db1e9ad-9bff-40d6-ad2e-f8a38d94b36b'),(248,22,NULL,22,1,'2019-05-11 15:03:00',NULL,NULL,'2019-05-11 15:03:48','2019-05-11 15:03:48','6e97b5e4-a195-406e-a298-76772d58d167'),(256,22,NULL,22,1,'2019-05-11 15:04:00',NULL,NULL,'2019-05-11 15:04:48','2019-05-11 15:04:48','e555b460-f099-47bc-b010-16389f7d59c2'),(262,22,NULL,22,1,'2019-05-11 15:05:00',NULL,NULL,'2019-05-11 15:05:30','2019-05-11 15:05:30','25b8d6d0-82e6-4ed9-affa-a38290cd1e88'),(271,22,NULL,22,1,'2019-05-11 15:06:00',NULL,NULL,'2019-05-11 15:06:17','2019-05-11 15:06:17','b4518f10-557c-47be-aab0-45051d32193c'),(280,22,NULL,22,1,'2019-05-11 15:06:00',NULL,NULL,'2019-05-11 15:07:00','2019-05-11 15:07:00','9c111c06-db6c-42cd-a6a5-95e8866de145'),(289,22,NULL,22,1,'2019-05-11 15:07:00',NULL,NULL,'2019-05-11 15:07:44','2019-05-11 15:07:44','93c6678e-a932-415b-8bdc-a80fdd80a677'),(298,22,NULL,22,1,'2019-05-11 15:08:00',NULL,NULL,'2019-05-11 15:08:25','2019-05-11 15:08:25','07f2c4ac-de23-4e29-a594-6eff2ca9dee9'),(307,22,NULL,22,1,'2019-05-11 15:09:00',NULL,NULL,'2019-05-11 15:09:10','2019-05-11 15:09:10','6ea628a7-e96c-4759-bcb7-da53000e6f76');
/*!40000 ALTER TABLE `acr_entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_entrydrafts`
--

LOCK TABLES `acr_entrydrafts` WRITE;
/*!40000 ALTER TABLE `acr_entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_entrytypes`
--

LOCK TABLES `acr_entrytypes` WRITE;
/*!40000 ALTER TABLE `acr_entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_entrytypes` VALUES (2,2,5,'About','about',1,'Page Title','',1,'2018-10-08 23:53:17','2019-02-05 02:34:16',NULL,'3763008a-e976-465a-b92f-9309836c9be0'),(3,3,6,'Promotions','promotions',1,'Title','',1,'2018-10-09 00:13:24','2019-01-27 18:17:45',NULL,'b4a92b05-e940-4b60-b063-e03b8e8ed290'),(4,4,7,'Home','home',0,NULL,'{section.name|raw}',1,'2018-10-10 23:42:21','2018-12-30 16:32:20',NULL,'89e916b0-48ff-4c47-b285-bea42a6de1eb'),(5,5,8,'Notifications','notifications',1,'Title','',1,'2018-11-02 01:16:09','2019-02-09 21:36:20',NULL,'cc5c88c2-6256-43b6-accc-6866de536e42'),(6,6,11,'Testimonials','testimonials',1,'Title',NULL,1,'2018-12-17 01:13:58','2018-12-30 16:10:48',NULL,'4aecf25f-7fd2-4fac-86f9-571abb544b3b'),(8,8,17,'Locations','locations',0,NULL,'{section.name|raw}',1,'2019-01-02 01:08:25','2019-01-02 01:15:39',NULL,'6158f0a0-0d2b-4e2c-a79e-ae3ae8ef5498'),(9,9,20,'ACR Cares','acrCares',0,'','{section.name|raw}',1,'2019-01-23 02:23:36','2019-01-23 03:04:05',NULL,'43601a53-dddf-44fd-96ff-e5034fe169d1'),(10,10,NULL,'Contact','contact',0,NULL,'{section.name|raw}',1,'2019-01-24 01:56:00','2019-01-24 01:56:00',NULL,'6ce85c89-9cc3-4180-9af7-0f2109ab5dde'),(11,11,NULL,'Request E-Store Account','eStore',0,NULL,'{section.name|raw}',1,'2019-01-24 02:30:36','2019-01-24 02:30:42',NULL,'2228d5f0-f6f0-4be9-af9b-b14f7c9a65ff'),(12,12,NULL,'E-Store Credit Application','eStoreCreditApplication',1,'Title',NULL,1,'2019-01-24 02:35:59','2019-01-24 02:35:59',NULL,'e0180887-e30e-4628-aa32-08b1842ee5f0'),(13,13,NULL,'Pay Online','payOnline',0,NULL,'{section.name|raw}',1,'2019-01-24 03:20:09','2019-01-24 03:20:09',NULL,'2cc1817d-2570-4954-a8aa-b57c5e5eeda1'),(14,14,NULL,'Training and Education','trainingAndEducation',0,NULL,'{section.name|raw}',1,'2019-01-25 02:16:36','2019-01-25 02:16:36',NULL,'78c5241d-877a-4e91-8ac5-836bb161279b'),(15,15,28,'Scholarships','scholarships',0,'','{section.name|raw}',1,'2019-01-25 02:27:28','2019-05-11 14:33:41',NULL,'ff374fa6-3141-4a64-be08-6fcae035a8fe'),(16,16,NULL,'Careers','careers',0,NULL,'{section.name|raw}',1,'2019-01-25 02:29:08','2019-01-25 02:29:08',NULL,'d28af146-9297-4753-8222-0708a5cbf5aa'),(17,17,NULL,'Associates','associates',0,NULL,'{section.name|raw}',1,'2019-01-25 02:30:45','2019-01-25 02:30:45',NULL,'47bb783e-b48b-4ed6-9e79-b1a308939085'),(18,18,NULL,'The Story','theStory',0,NULL,'{section.name|raw}',1,'2019-01-25 02:32:27','2019-01-25 02:32:27','2019-01-25 02:33:03','77af3a61-c5e8-4d48-ac1f-25ebe9c9c254'),(19,19,NULL,'Pages','pages',1,'Title',NULL,1,'2019-01-25 02:42:26','2019-01-25 02:42:26',NULL,'6fcb7060-ebde-4e32-963e-b9a094be6ab7'),(20,20,25,'Vendors','vendors',0,'','{section.name|raw}',1,'2019-02-10 01:28:33','2019-02-10 01:30:11',NULL,'f6806f33-ca1c-410a-829c-9b387979a77a'),(21,21,NULL,'Scholarship Recipients','scholarshipRecipients',1,'Name','',1,'2019-05-11 14:24:16','2019-05-11 14:24:38','2019-05-11 14:34:21','72f9df3b-8b42-43db-8807-fe597efb098d'),(22,22,30,'Scholarship Years & Recipients','scholarshipYearsRecipients',1,'Title','',1,'2019-05-11 14:34:47','2019-05-11 14:35:41',NULL,'3baae86f-420d-4e96-9011-5eb5f80041e5');
/*!40000 ALTER TABLE `acr_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_entryversions`
--

LOCK TABLES `acr_entryversions` WRITE;
/*!40000 ALTER TABLE `acr_entryversions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_entryversions` VALUES (2,10,3,1,1,1,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Sure Comfort Promotion\",\"slug\":\"sure-comfort-promotion\",\"postDate\":1540343640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"ariaLabel\":\"\",\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"url\",\"value\":\"http://s7098.pcdn.co/wp-content/uploads/2018/07/Sure-Summer-of-Fun-Flyer_HR.pdf\"},\"2\":[\"9\"]}}','2018-10-24 01:14:25','2018-10-24 01:14:25','b8075956-795c-41bc-94d1-dc1de0702c15'),(3,11,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"New Store Hours\",\"slug\":\"new-store-hours\",\"postDate\":1541121660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"7\":{\"ariaLabel\":null,\"customText\":\"Locations\",\"target\":\"\",\"title\":null,\"type\":\"entry\",\"value\":\"7\"},\"6\":\"<strong>We have new store hours,</strong> to better serve you!\"}}','2018-11-02 01:21:37','2018-11-02 01:21:37','206d16fb-2666-4ac7-ac07-2c16e732e2b2'),(4,8,4,1,1,1,'Revision from Nov 1, 2018, 10:25:33 PM','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":[]}','2018-11-02 02:25:49','2018-11-02 02:25:49','b66f1d67-34b8-411e-b7c9-2b650d2b6f9c'),(5,8,4,1,1,2,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"9\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"8\":\"What We Do Best\"}}','2018-11-02 02:25:49','2018-11-02 02:25:49','0682cc06-6b66-46f5-a744-53b97273953c'),(6,8,4,1,1,3,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"10\":\"What We Do Best\"}}','2018-11-02 02:28:42','2018-11-02 02:28:42','9fb60083-44d9-472b-8bb7-532381109cac'),(7,8,4,1,1,4,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"10\":\"What We Do Best\"}}','2018-11-02 02:36:30','2018-11-02 02:36:30','c2095489-a14f-477c-ac02-6959c05f3a09'),(8,8,4,1,1,5,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"description\":\"Explore our catalog of products\",\"image\":[\"15\"]}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"description\":\"Quickly request an account to shop with us\",\"image\":[\"15\"]}}},\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"10\":\"What We Do Best\"}}','2018-12-08 01:32:00','2018-12-08 01:32:00','2faac918-7023-4f34-ba02-34ec74fccac8'),(9,8,4,1,1,6,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"description\":\"Explore our catalog of products\",\"image\":[\"15\"],\"backgroundColor\":\"#c22c25\"}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"description\":\"Quickly request an account to shop with us\",\"image\":[\"15\"],\"backgroundColor\":\"#276aa6\"}}},\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"10\":\"What We Do Best\"}}','2018-12-08 01:33:03','2018-12-08 01:33:03','c82bce89-4db9-4046-ac79-812ede3203ad'),(10,8,4,1,1,7,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"callToActionDescription\":\"Explore our catalog of products\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"#c22c25\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"callToActionDescription\":\"Quickly request an account to shop with us\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"#276aa6\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"10\":\"What We Do Best\"}}','2018-12-08 01:45:29','2018-12-08 01:45:29','ef5a78c8-da19-4ce9-9df8-fb6af1ee0cfe'),(11,8,4,1,1,8,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"callToActionDescription\":\"Explore our catalog of products\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"red\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"callToActionDescription\":\"Quickly request an account to shop with us\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"blue\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"10\":\"What We Do Best\"}}','2018-12-08 01:55:56','2018-12-08 01:55:56','e98aed21-2ec9-4920-b5bd-460b46b61c46'),(12,18,6,1,1,1,'','{\"typeId\":\"6\",\"authorId\":\"1\",\"title\":\"Mark Webster Testimonial\",\"slug\":\"mark-webster-testimonial\",\"postDate\":1546186380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"23\":\"Mark Webster\",\"24\":\"Mark Macurdy was working at a job site over the weekend (emergency call) and needed some parts to get a 600 ton chiller up for a customer. Mark called the after hours number and got Jeff. Mark said that he not only got the part for him, he dropped it off at the job site so Mark never had to stop working but he also dropped off some water for Mark as well. Mark could not say enough about the professional manner in how he handled having to come out on Sunday (102 degrees) but he went the extra step to make sure Mark was hydrated! Please recognize this young man in front of your group for going the extra mile. Troy, you know as well as anyone that parts are parts and everyone has them BUT, very few companies find people who go the extra mile. This guy will help ACR keep customers for life!\"}}','2018-12-30 16:13:20','2018-12-30 16:13:20','3675ffb4-5185-4d12-87dc-1204be3e8f60'),(13,8,4,1,1,9,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"callToActionDescription\":\"Explore our catalog of products\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"red\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"callToActionDescription\":\"Quickly request an account to shop with us\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"blue\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"27\":\"Get VIP access for early announcements for all our events and sales.\",\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"25\":[\"15\"],\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"26\":\"Stay Updated With ACR\",\"10\":\"What We Do Best\"}}','2018-12-30 16:33:13','2018-12-30 16:33:13','10ce871b-3acd-4548-91f5-1a9f6a704993'),(14,24,8,1,1,1,'Revision from Jan 1, 2019, 8:12:18 PM','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"34\":[]}}','2019-01-02 01:12:52','2019-01-02 01:12:52','16b72151-ce33-4a64-bb3b-64c57acc50f8'),(15,24,8,1,1,2,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd. Burlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}}}}}','2019-01-02 01:14:24','2019-01-02 01:14:24','078c58e3-f97e-4c8c-b327-56a577008efa'),(16,24,8,1,1,3,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd. Burlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St. Carrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\"}}}}}','2019-01-02 01:15:08','2019-01-02 01:15:08','fcc55863-18a0-435a-bf81-c1c6a70368cf'),(17,24,8,1,1,4,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd.<br>Burlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St.<br>Carrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\"}}}}}','2019-01-02 01:24:02','2019-01-02 01:24:02','7e4bd32f-98eb-475e-a913-d60005be2b6a'),(18,24,8,1,1,5,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd. \\\\nBurlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St. \\\\nCarrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\"}}}}}','2019-01-02 01:25:49','2019-01-02 01:25:49','d4ababd2-c829-4db0-80b8-30b541ebd9eb'),(19,24,8,1,1,6,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd.\\nBurlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St.\\nCarrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\"}}}}}','2019-01-02 01:27:55','2019-01-02 01:27:55','32ff1f38-5763-4dda-9c49-7a7036b5dd45'),(20,24,8,1,1,7,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd.\\nBurlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St.\\nCarrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\"}},\"27\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Durham\",\"address\":\"2719 Hillsborough Rd.\\nDurham, NC 27705\",\"phoneNumber\":\"(919) 286 - 2228\"}},\"28\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Greensboro\",\"address\":\"2201 Binford St.\\nGreensboro, NC 27407\",\"phoneNumber\":\"(336) 854 - 5800\"}},\"29\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Raleigh\",\"address\":\"2416 Alwin Ct.\\nRaleigh, NC 27604\",\"phoneNumber\":\"(919) 861 - 2277\"}},\"30\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Wilmington\",\"address\":\"3207 Burnt Mill Dr.\\nWilmington, NC 28403\",\"phoneNumber\":\"(910) 442 - 3303\"}},\"31\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Winston-Salem\",\"address\":\"1735 Link Rd.\\nWinston-Salem, NC 27103\",\"phoneNumber\":\"(336) 831 - 0505\"}},\"32\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Winterville\",\"address\":\"4125 Bayswater Rd.\\nWinterville, NC 28590\",\"phoneNumber\":\"(252) 754 - 2653\"}},\"33\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Central Services\",\"address\":\"4040 S. Alston Ave.\\nDurham, NC 27713\",\"phoneNumber\":\"(919) 765 - 8081\"}}}}}','2019-01-02 01:30:33','2019-01-02 01:30:33','6434c97a-0ecd-4f50-bcdf-6ed64b4b67da'),(21,24,8,1,1,8,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd.\\nBurlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\",\"googleMapLink\":\"https://goo.gl/maps/3EGEq92J2t72\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St.\\nCarrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\",\"googleMapLink\":\"https://goo.gl/maps/PrdhT1bGbgm\"}},\"27\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Durham\",\"address\":\"2719 Hillsborough Rd.\\nDurham, NC 27705\",\"phoneNumber\":\"(919) 286 - 2228\",\"googleMapLink\":\"https://goo.gl/maps/2KLv6FA1XYJ2\"}},\"28\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Greensboro\",\"address\":\"2201 Binford St.\\nGreensboro, NC 27407\",\"phoneNumber\":\"(336) 854 - 5800\",\"googleMapLink\":\"https://goo.gl/maps/QyVYuMKfoXy\"}},\"29\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Raleigh\",\"address\":\"2416 Alwin Ct.\\nRaleigh, NC 27604\",\"phoneNumber\":\"(919) 861 - 2277\",\"googleMapLink\":\"https://goo.gl/maps/9EeSxoVCQut\"}},\"30\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Wilmington\",\"address\":\"3207 Burnt Mill Dr.\\nWilmington, NC 28403\",\"phoneNumber\":\"(910) 442 - 3303\",\"googleMapLink\":\"https://goo.gl/maps/gQgGihH59uT2\"}},\"31\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Winston-Salem\",\"address\":\"1735 Link Rd.\\nWinston-Salem, NC 27103\",\"phoneNumber\":\"(336) 831 - 0505\",\"googleMapLink\":\"https://goo.gl/maps/zR6HSX5wqmK2\"}},\"32\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Winterville\",\"address\":\"4125 Bayswater Rd.\\nWinterville, NC 28590\",\"phoneNumber\":\"(252) 754 - 2653\",\"googleMapLink\":\"https://goo.gl/maps/Ux9UmLTbdsB2\"}},\"33\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Central Services\",\"address\":\"4040 S. Alston Ave.\\nDurham, NC 27713\",\"phoneNumber\":\"(919) 765 - 8081\",\"googleMapLink\":\"https://goo.gl/maps/Rmo31C2wPC92\"}}}}}','2019-01-21 18:24:32','2019-01-21 18:24:32','9c70cc7a-7c74-412d-98be-95af9b8538a7'),(22,34,9,1,1,1,'Revision from Jan 22, 2019, 9:50:36 PM','{\"typeId\":\"9\",\"authorId\":null,\"title\":\"ACR Cares\",\"slug\":\"acr-cares\",\"postDate\":1548210180,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"39\":[]}}','2019-01-23 02:51:12','2019-01-23 02:51:12','960b7f36-6538-4446-822a-0af5f5d6c48b'),(23,34,9,1,1,2,'','{\"typeId\":\"9\",\"authorId\":null,\"title\":\"ACR Cares\",\"slug\":\"acr-cares\",\"postDate\":1548210180,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"39\":{\"35\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Roc Solid Foundations\",\"initiativeDescription\":\"Roc Solid Foundation® builds hope for children battling cancer and their families by offering opportunities for them to do what they do best – play. Roc Solid partners with local groups to build playsets and remodel the rooms of children battling cancer. ACR Cares will be building a playset with Roc Solid October 2018.\"}},\"36\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Ronald McDonald House\",\"initiativeDescription\":\"Providing stability and resources for families everywhere. ACR Cares partners with the local Ronald McDonald House’s to cook meals, provide gifts and needed materials at Christmas time, and sponsors a family every Christmas.\"}}}}}','2019-01-23 02:51:12','2019-01-23 02:51:12','7a3d609c-81eb-4f78-96e5-f9919e4b81a4'),(24,34,9,1,1,3,'','{\"typeId\":\"9\",\"authorId\":null,\"title\":\"ACR Cares\",\"slug\":\"acr-cares\",\"postDate\":1548210180,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"39\":{\"35\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Roc Solid Foundations\",\"initiativeDescription\":\"Roc Solid Foundation® builds hope for children battling cancer and their families by offering opportunities for them to do what they do best – play. Roc Solid partners with local groups to build playsets and remodel the rooms of children battling cancer. ACR Cares will be building a playset with Roc Solid October 2018.\"}},\"36\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Ronald McDonald House\",\"initiativeDescription\":\"Providing stability and resources for families everywhere. ACR Cares partners with the local Ronald McDonald House’s to cook meals, provide gifts and needed materials at Christmas time, and sponsors a family every Christmas.\"}},\"37\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Operation Resolute\",\"initiativeDescription\":\"Operation Resolute® is a non-profit organization based in North Carolina that is dedicated to sustaining and strengthening families within the US Armed Forces by serving with and working through military chaplains. By partnering with chaplains, Operation Resolute® works within the parameters of the US military while adorning the Gospel by being salt and light. ACR Cares partners with Operation Resolute by hosting Daddy Daughter dances, spouse retreats, and other events.\"}},\"38\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Burkina Faso\",\"initiativeDescription\":\"ACR Cares is currently building an Orphanage in the country of Burkina Faso.\"}},\"39\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Human Coalition\",\"initiativeDescription\":\"Human Coalition is a group dedicated to helping women at risk of having an abortion see the beauty of choosing life. ACR Cares takes part in the annual  fundraising event, 4000 Steps.\"}}}}}','2019-01-23 02:56:29','2019-01-23 02:56:29','5b73c17f-9ada-4bec-9ede-6f8492b95dc3'),(25,34,9,1,1,4,'','{\"typeId\":\"9\",\"authorId\":null,\"title\":\"ACR Cares\",\"slug\":\"acr-cares\",\"postDate\":1548210180,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"39\":{\"35\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Roc Solid Foundations\",\"initiativeDescription\":\"Roc Solid Foundation® builds hope for children battling cancer and their families by offering opportunities for them to do what they do best – play. Roc Solid partners with local groups to build playsets and remodel the rooms of children battling cancer. ACR Cares will be building a playset with Roc Solid October 2018.\"}},\"36\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Ronald McDonald House\",\"initiativeDescription\":\"Providing stability and resources for families everywhere. ACR Cares partners with the local Ronald McDonald House’s to cook meals, provide gifts and needed materials at Christmas time, and sponsors a family every Christmas.\"}},\"37\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Operation Resolute\",\"initiativeDescription\":\"Operation Resolute® is a non-profit organization based in North Carolina that is dedicated to sustaining and strengthening families within the US Armed Forces by serving with and working through military chaplains. By partnering with chaplains, Operation Resolute® works within the parameters of the US military while adorning the Gospel by being salt and light. ACR Cares partners with Operation Resolute by hosting Daddy Daughter dances, spouse retreats, and other events.\"}},\"38\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Burkina Faso\",\"initiativeDescription\":\"ACR Cares is currently building an Orphanage in the country of Burkina Faso.\"}},\"39\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Human Coalition\",\"initiativeDescription\":\"Human Coalition is a group dedicated to helping women at risk of having an abortion see the beauty of choosing life. ACR Cares takes part in the annual  fundraising event, 4000 Steps.\"}}},\"43\":{\"40\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Annual Scholarship to our team members’ children\"}},\"41\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Benevolence fund for team members going through difficult times\"}},\"42\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Corporate Chaplains\"}},\"43\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Ministry pamphlets in all our locations\"}},\"44\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Annual Awards Banquet\"}},\"45\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Annual Family Fun Day\"}},\"46\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Marriage Retreats for team members and their spouses\"}},\"47\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Volunteer Policy\"}},\"48\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Mission Trip Policy\"}},\"49\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Disaster Relief Policy\"}}}}}','2019-01-23 03:05:07','2019-01-23 03:05:07','565628c8-185e-449c-9648-742381bb94b9'),(26,60,19,1,1,1,'','{\"typeId\":\"19\",\"authorId\":\"1\",\"title\":\"About Us\",\"slug\":\"about-us\",\"postDate\":1548384120,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2019-01-25 02:42:54','2019-01-25 02:42:54','78be6c73-1f84-4fbb-834f-c673f24a5817'),(27,10,3,1,1,2,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Sure Comfort Promotion\",\"slug\":\"sure-comfort-promotion\",\"postDate\":1540343640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"url\",\"value\":\"http://s7098.pcdn.co/wp-content/uploads/2018/07/Sure-Summer-of-Fun-Flyer_HR.pdf\"},\"2\":[\"61\"]}}','2019-01-27 17:55:11','2019-01-27 17:55:11','febdc7fd-4b73-4e71-9741-66d00f7108fb'),(28,10,3,1,1,3,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Sure Comfort Promotion\",\"slug\":\"sure-comfort-promotion\",\"postDate\":1540343640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"url\",\"value\":\"http://s7098.pcdn.co/wp-content/uploads/2018/07/Sure-Summer-of-Fun-Flyer_HR.pdf\"},\"45\":[\"62\"]}}','2019-01-27 18:02:05','2019-01-27 18:02:05','249724e7-006c-417f-8860-c15996be6c00'),(29,64,3,1,1,1,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"DEC18 Promotion\",\"slug\":\"dec18-promotion\",\"postDate\":1548612900,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":null},\"45\":[\"63\"]}}','2019-01-27 18:15:14','2019-01-27 18:15:14','c9a55d13-5775-4776-b53e-f3d417395845'),(30,8,4,1,1,10,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"callToActionDescription\":\"Explore our catalog of products\",\"callToActionImage\":[\"65\"],\"callToActionBackgroundColor\":\"red\",\"callToActionLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"callToActionDescription\":\"Quickly request an account to shop with us\",\"callToActionImage\":[\"66\"],\"callToActionBackgroundColor\":\"blue\",\"callToActionLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}}}},\"27\":\"Get VIP access for early announcements for all our events and sales.\",\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"25\":[\"15\"],\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}}}},\"26\":\"Stay Updated With ACR\",\"10\":\"What We Do Best\"}}','2019-01-27 18:23:14','2019-01-27 18:23:14','d3f0696e-c773-4db2-8d53-25c318c773ec'),(31,8,4,1,1,11,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"callToActionDescription\":\"Explore our catalog of products\",\"callToActionImage\":[\"65\"],\"callToActionBackgroundColor\":\"red\",\"callToActionLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"callToActionDescription\":\"Quickly request an account to shop with us\",\"callToActionImage\":[\"66\"],\"callToActionBackgroundColor\":\"blue\",\"callToActionLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"52\"}}}},\"27\":\"Get VIP access for early announcements for all our events and sales.\",\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"25\":[\"15\"],\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}}}},\"26\":\"Stay Updated With ACR\",\"10\":\"What We Do Best\"}}','2019-01-27 18:25:14','2019-01-27 18:25:14','f9cfed4b-1beb-4770-8ee7-a687957e31e5'),(32,6,2,1,1,1,'Revision from Feb 4, 2019, 9:34:17 PM','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"About\",\"slug\":\"about\",\"postDate\":1539042780,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"46\":[]}}','2019-02-05 02:46:19','2019-02-05 02:46:19','a0df6091-3135-42ac-966b-55f487070f76'),(33,6,2,1,1,2,'','{\"typeId\":\"2\",\"authorId\":null,\"title\":\"About\",\"slug\":\"about\",\"postDate\":1539042780,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"46\":{\"68\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"A culture of family\"}},\"69\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"A culture that truly does try to serve others over self.\"}},\"70\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"A customer focused culture of respect, open communication and, resolving conflict in a healthy manor.\"}},\"71\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"A GREAT ENVIRONMENT WITH POSITIVE ATTITUDES.\"}},\"72\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"ACR is a customer focused company that cares deeply about its employees.\"}},\"73\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"ACR is a place that creates an environment where team members want to get up and come to work everyday. If you have ever dreaded going to a job, then you know why this is soooo important.\"}},\"74\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"ACR is family and it is a place where you do not have to worry about weather or not you will have a job the next day if something happens in your life becasue ACR has your back no matter what\"}},\"75\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"ACR\'s culture reflects our guiding principles.\"}},\"76\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Amazing couldn\'t ask for a better family.\"}},\"77\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"AMAZING CULTURE\"}},\"78\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Awesome culture when people buy in team work\"}},\"79\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Awesome!\"}},\"80\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Balance of team work and customer service - with integrity\"}},\"81\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Big Family\"}},\"82\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"CARING ABOUT PEOPLE PASSIONATE ABOUT SOLUTIONS AND TO GLORIFY GOD\"}},\"83\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"caring god based culture\"}},\"84\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Christ-centered, customer-focused, associate-friendly\"}},\"85\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Close family\"}},\"86\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Customer Focused\"}},\"87\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"CUSTOMER DRIVEN\"}},\"88\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"effective, diverse, accepted, encouraged\"}},\"89\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"It feels like a family - all the staff are great to work with.employee and customer based, something on a level I haven\'t seen in previous jobs\"}},\"90\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Encouraging, supportive, and happy\"}},\"91\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Everybody acts like a big family and you can tell when we have meetings that everyone genuinely gets along\"}},\"92\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"everyone willing to help\"}},\"93\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Excellent culture. It’s awesome being at a workplace where everyone actually wants to be at work and genuinely cares about the big picture\"}},\"94\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Family\"}},\"95\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Family atmosphere. Everyone gets along great.\"}},\"96\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Family business\"}},\"97\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Family oriented, honest, ethical.\"}},\"98\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"family/community\"}},\"99\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"For me it\'s simple. It is a culture that loves people and makes a difference in their lives.\"}},\"100\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"friendly\"}},\"101\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"friendly atmosphere where you want to come to work\"}},\"102\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"friendly, helpful, loving, Christ centered.\"}},\"103\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"GOOD\"}},\"104\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Good , place work like the people. healthy team work.\"}},\"105\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"good culture that bring honor and glory to God\"}},\"106\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Great culture where everyone wants to help out and be apart of a team.\"}},\"107\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Great family atmosphere\"}},\"108\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Great work environment .\"}},\"109\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Happy, Happy Happy\"}},\"110\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Honest and trustworthy, very little drama\"}},\"111\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"I believe that a culture has been built where people are treated and embraced like family. I have confidence that I can go to anyone at anytime and have a discussion, ask a question, or be vulnerable about my personal life.\"}},\"112\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"I think of importance of family and God when I think of ACR.\"}},\"113\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"I would describe the ACR culture as one of INTEGRITY. From that well, all the other characteristics of a great place to work flow.\"}},\"114\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"I would describe the culture as Helpful and fun.\"}},\"115\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"It is a good place to work that allows people to excel in their life through their work and outside life balance. There is a genuine care for employees well-being not just at work but outside of work too.\"}},\"116\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Its a second family\"}},\"117\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Its an awesome culture at ACR. Would be better if everyone followed it.\"}},\"118\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"It\'s refreshing and attractive among all the other culture\'s in our industry.\"}},\"119\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"It\'s tight-knit group of people who strive to make a difference in the marketplace and in the community.\"}},\"120\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Living and working for a common goal, to achieve success in business, work and play. To pay homage to God and give thanks for what we have.\"}},\"121\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"loving and fun-loving; productive and professional.\"}},\"122\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"ok\"}},\"123\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"One of family and friends.\"}},\"124\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"One that values relationships with customers and team members alike.\"}},\"125\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Open and Caring\"}},\"126\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Our culture at work provides a road map for life.\"}},\"127\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Our culture is positive, forward thinking and we truly care about one another and the impact we have on each other\'s lives and each other\'s families.\"}},\"128\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"People liking and respecting one another, with the end goal to satisfy our customers.\"}},\"129\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"professional, unique, kind, smart, trust\"}},\"130\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Refreshing\"}},\"131\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Rewarding personally and professionally\"}},\"132\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Spiritual\"}},\"133\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"take care of customer at all cost\"}},\"134\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"The ACR Culture is phenomenal, I have never worked at a place like this before. Everyone seems to be very helpful, Family oriented and has a Purpose for doing whats best for ACR.\"}},\"135\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"The culture at ACR is amazing I love the fact that the companies principal includes to glorify god.\"}},\"136\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"The culture at ACR is one of serving customers first by working together and also by helping its employees to be better trained within their own fields.\"}},\"137\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"The culture at ACR Supply is like we\'re all a family.\"}},\"138\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"The culture has improved over the past few years.\"}},\"139\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"The culture is not always applied the same\"}},\"140\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"The culture of this company is awesome. Everyone is loved, and part of the team.\"}},\"141\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Unique, I treasure this place, best job I\'ve ever had.\"}},\"142\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Values, beliefs, attitudes, and behaviors share each day at work.\"}},\"143\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"VISIONARY\"}},\"144\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"Visionary leaders everywhere with a humble servant leadership mindset with a mission to fulfill God\'s purposes in our sphere\'s of influence while making a profit for the future!  SEE BIG while thinking SMALL\"}},\"145\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"We are a family that loves, cares for, and prays for one another and our communities.\"}},\"146\":{\"type\":\"result\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"resultContent\":\"We care for each other\"}}}}}','2019-02-05 02:46:21','2019-02-05 02:46:21','3e77cb65-715a-471c-8455-0489f6b2403b'),(34,11,5,1,1,2,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Best Christian Workplaces\",\"slug\":\"new-store-hours\",\"postDate\":1541121660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"7\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Learn More!\",\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://blog.bcwinstitute.org/87-organizations-honored-as-certified-best-christian-workplaces-2018/\"},\"6\":\"ACR Supply honored as <strong>\\\"Certified Best Christian Workplace\\\"</strong> for 2018!\",\"2\":[\"147\"]}}','2019-02-09 21:37:10','2019-02-09 21:37:10','20e07fee-5c44-4c8b-8756-739381a5d24c'),(35,11,5,1,1,3,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Best Christian Workplaces\",\"slug\":\"new-store-hours\",\"postDate\":1541121660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"7\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Learn More!\",\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://blog.bcwinstitute.org/87-organizations-honored-as-certified-best-christian-workplaces-2018/\"},\"6\":\"ACR Supply honored as <strong>\\\"Certified Best Christian Workplace\\\"</strong> for 2018!\",\"2\":[]}}','2019-02-09 21:39:05','2019-02-09 21:39:05','d1205aaf-2c8a-4643-ac3f-52c7a444f318'),(36,11,5,1,1,4,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"Best Christian Workplaces\",\"slug\":\"new-store-hours\",\"postDate\":1541121660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"7\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Learn More!\",\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://blog.bcwinstitute.org/87-organizations-honored-as-certified-best-christian-workplaces-2018/\"},\"6\":\"ACR Supply honored as <strong>\\\"Certified Best Christian Workplace\\\"</strong> for 2018!\",\"2\":[\"147\"]}}','2019-02-09 21:39:17','2019-02-09 21:39:17','01d12254-466a-40eb-91e3-69736a1710a4'),(37,148,20,1,1,1,'Revision from Feb 9, 2019, 8:30:14 PM','{\"typeId\":\"20\",\"authorId\":null,\"title\":\"Vendors\",\"slug\":\"vendors\",\"postDate\":1549762080,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"48\":[]}}','2019-02-10 01:33:17','2019-02-10 01:33:17','b601e07d-2c57-4269-b6f6-89f7eb0a7487'),(38,148,20,1,1,2,'','{\"typeId\":\"20\",\"authorId\":null,\"title\":\"Vendors\",\"slug\":\"vendors\",\"postDate\":1549762080,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"48\":{\"149\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A.O. Smith\",\"vendorDescription\":\"Electric Motors-Fractional and Integral Horsepower\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}}},\"150\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A1 Components\",\"vendorDescription\":\"A/C and Refrigeration Components, Camstat Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}}},\"151\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Amprobe\",\"vendorDescription\":\"Instruments for Measuring Volts, Amps, Ohms, Temperature\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}}},\"152\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Antunes\",\"vendorDescription\":null,\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"\"}}}}}}','2019-02-10 01:33:18','2019-02-10 01:33:18','0a6e671d-6f6e-40ef-bf68-aeddbd8722f9'),(39,148,20,1,1,3,'','{\"typeId\":\"20\",\"authorId\":null,\"title\":\"Vendors\",\"slug\":\"vendors\",\"postDate\":1549762080,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"48\":{\"153\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A.O. Smith\",\"vendorDescription\":\"Electric Motors-Fractional and Integral Horsepower\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}}},\"154\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A1 Components\",\"vendorDescription\":\"A/C and Refrigeration Components, Camstat Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}}},\"155\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Amprobe\",\"vendorDescription\":\"Instruments for Measuring Volts, Amps, Ohms, Temperature\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}}},\"156\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Antunes\",\"vendorDescription\":null,\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"\"}}}}}}','2019-02-10 01:33:19','2019-02-10 01:33:19','7eea4d14-e860-4be3-a1cf-e09d45705ce4'),(40,148,20,1,1,4,'','{\"typeId\":\"20\",\"authorId\":null,\"title\":\"Vendors\",\"slug\":\"vendors\",\"postDate\":1549762080,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"48\":{\"153\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A.O. Smith\",\"vendorDescription\":\"Electric Motors-Fractional and Integral Horsepower\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}}},\"154\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A1 Components\",\"vendorDescription\":\"A/C and Refrigeration Components, Camstat Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}}},\"155\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Amprobe\",\"vendorDescription\":\"Instruments for Measuring Volts, Amps, Ohms, Temperature\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}}},\"156\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Antunes\",\"vendorDescription\":\"Pressure Switches for Gas and Air\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.antunescontrols.com/\"}}},\"157\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"AquaGuard\",\"vendorDescription\":\"Conservation Technologies\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/index.php/products-4/\"}}}}}}','2019-02-10 01:33:49','2019-02-10 01:33:49','81af2241-ed85-4241-b06c-7283533c4754'),(41,148,20,1,1,5,'','{\"typeId\":\"20\",\"authorId\":null,\"title\":\"Vendors\",\"slug\":\"vendors\",\"postDate\":1549762080,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"48\":{\"153\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A.O. Smith\",\"vendorDescription\":\"Electric Motors-Fractional and Integral Horsepower\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}}},\"154\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A1 Components\",\"vendorDescription\":\"A/C and Refrigeration Components, Camstat Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}}},\"155\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Amprobe\",\"vendorDescription\":\"Instruments for Measuring Volts, Amps, Ohms, Temperature\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}}},\"156\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Antunes\",\"vendorDescription\":\"Pressure Switches for Gas and Air\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.antunescontrols.com/\"}}},\"157\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"AquaGuard\",\"vendorDescription\":\"Conservation Technologies\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/index.php/products-4/\"}}},\"158\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Armacell\",\"vendorDescription\":\"Closed Cell Insulation for Refrigerant Lines\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.armacell.com/\"}}},\"159\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"ASCO\",\"vendorDescription\":\"Solenoid Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.asco.com/\"}}},\"160\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Bacharach\",\"vendorDescription\":\"Combustion Analyzers, Leak Detectors and Refrigerant Recovery/Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.bacharach-inc.com/\"}}},\"161\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Baron Wire\",\"vendorDescription\":\"Thermostat Cable-UL, Plenum, Shielded, Extension Cords\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.colemancable.com/Home\"}}},\"162\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Belimo\",\"vendorDescription\":\"Direct Mounted Actuators and Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.belimo.com/english/index.cfm\"}}},\"163\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Browning Belts\",\"vendorDescription\":\"V-belt drives and power transmission products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonindustrial.com/en-US/powertransmissionsolutions/Pages/home.aspx\"}}},\"164\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Cooper-Atkins\",\"vendorDescription\":\"Thermometers-Digital/Bi-metal/Liquid Filled\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooper-atkins.com/\"}}},\"165\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Copeland\",\"vendorDescription\":\"Hermetic and Semi-Hermetic Compressors for Refrigeration and Air Conditioning\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonclimate.com/en-US/Pages/home.aspx\"}}},\"166\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Crown Boiler\",\"vendorDescription\":\"Heating Parts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.crownboiler.com/\"}}},\"167\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Diversitech\",\"vendorDescription\":\"Air Conditioning Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.diversitech.com/\"}}}}}}','2019-02-10 01:38:24','2019-02-10 01:38:24','1382f709-a6eb-4daa-8d51-cea962c6de77'),(42,148,20,1,1,6,'','{\"typeId\":\"20\",\"authorId\":null,\"title\":\"Vendors\",\"slug\":\"vendors\",\"postDate\":1549762080,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"48\":{\"153\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A.O. Smith\",\"vendorDescription\":\"Electric Motors-Fractional and Integral Horsepower\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}}},\"154\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A1 Components\",\"vendorDescription\":\"A/C and Refrigeration Components, Camstat Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}}},\"155\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Amprobe\",\"vendorDescription\":\"Instruments for Measuring Volts, Amps, Ohms, Temperature\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}}},\"156\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Antunes\",\"vendorDescription\":\"Pressure Switches for Gas and Air\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.antunescontrols.com/\"}}},\"157\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"AquaGuard\",\"vendorDescription\":\"Conservation Technologies\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/index.php/products-4/\"}}},\"158\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Armacell\",\"vendorDescription\":\"Closed Cell Insulation for Refrigerant Lines\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.armacell.com/\"}}},\"159\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"ASCO\",\"vendorDescription\":\"Solenoid Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.asco.com/\"}}},\"160\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Bacharach\",\"vendorDescription\":\"Combustion Analyzers, Leak Detectors and Refrigerant Recovery/Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.bacharach-inc.com/\"}}},\"161\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Baron Wire\",\"vendorDescription\":\"Thermostat Cable-UL, Plenum, Shielded, Extension Cords\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.colemancable.com/Home\"}}},\"162\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Belimo\",\"vendorDescription\":\"Direct Mounted Actuators and Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.belimo.com/english/index.cfm\"}}},\"163\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Browning Belts\",\"vendorDescription\":\"V-belt drives and power transmission products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonindustrial.com/en-US/powertransmissionsolutions/Pages/home.aspx\"}}},\"164\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Cooper-Atkins\",\"vendorDescription\":\"Thermometers-Digital/Bi-metal/Liquid Filled\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooper-atkins.com/\"}}},\"165\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Copeland\",\"vendorDescription\":\"Hermetic and Semi-Hermetic Compressors for Refrigeration and Air Conditioning\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonclimate.com/en-US/Pages/home.aspx\"}}},\"166\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Crown Boiler\",\"vendorDescription\":\"Heating Parts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.crownboiler.com/\"}}},\"167\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Diversitech\",\"vendorDescription\":\"Air Conditioning Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.diversitech.com/\"}}},\"168\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dupont Refrigerants\",\"vendorDescription\":\"Refrigerant, filters\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www2.dupont.com/Refrigerants/en_US/\"}}},\"169\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dust Free\",\"vendorDescription\":\"Indoor Air Quality Solutions\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dustfree.com/\"}}},\"170\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dwyer\",\"vendorDescription\":\"Magnehelic Gages\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dwyer-inst.com/\"}}},\"171\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ecobee\",\"vendorDescription\":\"Programmable Thermostats\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ecobee.com/\"}}},\"172\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Edison Fusegear\",\"vendorDescription\":\"Electrical Fuses\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooperindustries.com/content/public/en/bussmann.html\"}}},\"173\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Federal Process\",\"vendorDescription\":\"Specialty Chemicals\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.federalprocess.com/\"}}},\"174\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Fluke\",\"vendorDescription\":\"Electrical Test Instruments\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.fluke.com/\"}}},\"175\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Functional Devices\",\"vendorDescription\":\"Electronic devices\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.functionaldevices.com/\"}}}}}}','2019-02-10 01:42:50','2019-02-10 01:42:50','04daa69c-ab38-4059-b5d3-e8b7f4f7efec'),(43,148,20,1,1,7,'','{\"typeId\":\"20\",\"authorId\":null,\"title\":\"Vendors\",\"slug\":\"vendors\",\"postDate\":1549762080,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"48\":{\"153\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A.O. Smith\",\"vendorDescription\":\"Electric Motors-Fractional and Integral Horsepower\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}}},\"154\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A1 Components\",\"vendorDescription\":\"A/C and Refrigeration Components, Camstat Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}}},\"155\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Amprobe\",\"vendorDescription\":\"Instruments for Measuring Volts, Amps, Ohms, Temperature\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}}},\"156\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Antunes\",\"vendorDescription\":\"Pressure Switches for Gas and Air\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.antunescontrols.com/\"}}},\"157\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"AquaGuard\",\"vendorDescription\":\"Conservation Technologies\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/index.php/products-4/\"}}},\"158\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Armacell\",\"vendorDescription\":\"Closed Cell Insulation for Refrigerant Lines\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.armacell.com/\"}}},\"159\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"ASCO\",\"vendorDescription\":\"Solenoid Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.asco.com/\"}}},\"160\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Bacharach\",\"vendorDescription\":\"Combustion Analyzers, Leak Detectors and Refrigerant Recovery/Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.bacharach-inc.com/\"}}},\"161\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Baron Wire\",\"vendorDescription\":\"Thermostat Cable-UL, Plenum, Shielded, Extension Cords\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.colemancable.com/Home\"}}},\"162\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Belimo\",\"vendorDescription\":\"Direct Mounted Actuators and Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.belimo.com/english/index.cfm\"}}},\"163\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Browning Belts\",\"vendorDescription\":\"V-belt drives and power transmission products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonindustrial.com/en-US/powertransmissionsolutions/Pages/home.aspx\"}}},\"164\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Cooper-Atkins\",\"vendorDescription\":\"Thermometers-Digital/Bi-metal/Liquid Filled\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooper-atkins.com/\"}}},\"165\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Copeland\",\"vendorDescription\":\"Hermetic and Semi-Hermetic Compressors for Refrigeration and Air Conditioning\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonclimate.com/en-US/Pages/home.aspx\"}}},\"166\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Crown Boiler\",\"vendorDescription\":\"Heating Parts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.crownboiler.com/\"}}},\"167\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Diversitech\",\"vendorDescription\":\"Air Conditioning Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.diversitech.com/\"}}},\"168\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dupont Refrigerants\",\"vendorDescription\":\"Refrigerant, filters\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www2.dupont.com/Refrigerants/en_US/\"}}},\"169\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dust Free\",\"vendorDescription\":\"Indoor Air Quality Solutions\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dustfree.com/\"}}},\"170\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dwyer\",\"vendorDescription\":\"Magnehelic Gages\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dwyer-inst.com/\"}}},\"171\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ecobee\",\"vendorDescription\":\"Programmable Thermostats\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ecobee.com/\"}}},\"172\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Edison Fusegear\",\"vendorDescription\":\"Electrical Fuses\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooperindustries.com/content/public/en/bussmann.html\"}}},\"173\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Federal Process\",\"vendorDescription\":\"Specialty Chemicals\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.federalprocess.com/\"}}},\"174\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Fluke\",\"vendorDescription\":\"Electrical Test Instruments\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.fluke.com/\"}}},\"175\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Functional Devices\",\"vendorDescription\":\"Electronic devices\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.functionaldevices.com/\"}}},\"176\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Gates\",\"vendorDescription\":\"V-Belts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.gates.com/\"}}},\"177\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Hays Fluid\",\"vendorDescription\":\"Automatic Flow Control Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.haysfluidcontrols.com/index.html\"}}},\"178\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"HeatCraft\",\"vendorDescription\":\"Refrigeration Evaporators and Condensing Units\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.heatcraftrpd.com/\"}}},\"179\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Henry Valve\",\"vendorDescription\":\"Refrigerant Control Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.henrytech.com/\"}}},\"180\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Highside\",\"vendorDescription\":\"Chemicals\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.highsidechem.com/\"}}},\"181\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Honeywell\",\"vendorDescription\":\"Burner and Boiler Controls, Commercial Building Controls, Environmental Controls, Hydronic Controls Pneumatic Controls, Residential HVAC Controls, Perfect Climate Humidifiers, Air Cleaners, UV Air Treatment, Digital Thermostats, Communicating Thermostats, Equipment Monitoring\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.customer.honeywell.com/\"}}},\"182\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Imperial (Stride Tools)\",\"vendorDescription\":\"Tube Working Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://imperial-tools.com/\"}}},\"183\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Inficon\",\"vendorDescription\":\"Refrigerant Leak Detectors\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.inficon.com/default.aspx?language=en-us\"}}},\"184\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"J.W. Harris\",\"vendorDescription\":\"Soldering and Brazing Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.harrisproductsgroup.com/\"}}},\"185\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"JB Industries\",\"vendorDescription\":\"Vacuum Pumps and Charging Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.jbind.com/\"}}},\"186\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Johnson Controls\",\"vendorDescription\":\"Pneumatic Controls, Refrigeration Controls and Leak Detectors, Commercial Air Conditioning Controls, BASO Gas Ignition Products, Valves and Actuators\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://cgproducts.johnsoncontrols.com/default.aspx?topframe.aspx&0\"}}},\"187\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"KE2 Thermal\",\"vendorDescription\":\"Advanced energy saving technology\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ke2therm.com/\"}}},\"188\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Klein\",\"vendorDescription\":\"Hand Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.kleintools.com/\"}}},\"189\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Koch Filter\",\"vendorDescription\":\"Commercial and Industrial Air Filtration Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.kochfilter.com/\"}}},\"190\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Lau\",\"vendorDescription\":\"Blower Wheels and Fan Blades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.lauparts.com/\"}}},\"191\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Lenox\",\"vendorDescription\":\"Saw Blades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.lenoxtools.com/Pages/home.aspx\"}}},\"192\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Little Giant\",\"vendorDescription\":\"Condensate Pumps\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://franklin-electric.com/hvac.aspx\"}}},\"193\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Malco\",\"vendorDescription\":\"Hand Tools For HVAC Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://malcoproducts.com/\"}}},\"194\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Mars\",\"vendorDescription\":\"Motors & Armatures\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.marsm-a.com/\"}}},\"195\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Mueller\",\"vendorDescription\":\"Copper Tube and Fitting for HVAC/R\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.muellerindustries.com/\"}}},\"196\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NSI\",\"vendorDescription\":\"Connectors\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nsiindustries.com/products/electrical.aspx\"}}},\"197\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NTI\",\"vendorDescription\":\"High Efficiency Boilers\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nythermal.com/trinity_ti\"}}},\"198\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NuCalgon\",\"vendorDescription\":\"Coil Cleaners and Chemicals for the HVAC/R Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nucalgon.com/\"}}},\"199\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Parker\",\"vendorDescription\":\"Brass Fittings, Refrigeration Control Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.parker.com/portal/site/PARKER/menuitem.b90576e27a4d71ae1bfcc510237ad1ca/?vgnextoid=c38888b5bd16e010VgnVCM1000000308a8c0RCRD&vgnextfmt=default\"}}},\"200\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Polyken Tape\",\"vendorDescription\":\"Pressure sensitive tapes and adhesives\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://tapes.berryplastics.com/\"}}},\"201\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ranco\",\"vendorDescription\":\"Refrigeration Temperature and Pressure Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.uni-line.com/common/ranco.aspx\"}}},\"202\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"RCD Mastics\",\"vendorDescription\":\"Home Weatherization Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rcdmastics.com/\"}}},\"203\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"RectorSeal\",\"vendorDescription\":\"Chemicals for the HVAC/R Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/\"}}},\"204\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ritchie\",\"vendorDescription\":\"Charging Hoses and Manifolds\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.yellowjacket.com/\"}}},\"205\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Schneider Electric\",\"vendorDescription\":\"Energy Management\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.schneider-electric.com/site/home/index.cfm/ww/?selectCountry=true\"}}},\"206\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Scotsman Ice Machines\",\"vendorDescription\":\"Leaders in ice machine innovation\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.scotsman-ice.com/?xhtml=xhtml/sct/us/en/homepage/default.html&xsl=homepage.xsl\"}}},\"207\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Sealed Unit Parts\",\"vendorDescription\":\"SUPCO Accessories for the HVAC/R Trade\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.supco.com/web/supco_live/\"}}}}}}','2019-02-10 02:02:43','2019-02-10 02:02:43','fb8a98eb-818e-483d-9bd6-42a47aa56a76'),(44,148,20,1,1,8,'','{\"typeId\":\"20\",\"authorId\":null,\"title\":\"Vendors\",\"slug\":\"vendors\",\"postDate\":1549762080,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"48\":{\"153\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A.O. Smith\",\"vendorDescription\":\"Electric Motors-Fractional and Integral Horsepower\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}}},\"154\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A1 Components\",\"vendorDescription\":\"A/C and Refrigeration Components, Camstat Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}}},\"155\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Amprobe\",\"vendorDescription\":\"Instruments for Measuring Volts, Amps, Ohms, Temperature\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}}},\"156\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Antunes\",\"vendorDescription\":\"Pressure Switches for Gas and Air\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.antunescontrols.com/\"}}},\"157\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"AquaGuard\",\"vendorDescription\":\"Conservation Technologies\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/index.php/products-4/\"}}},\"158\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Armacell\",\"vendorDescription\":\"Closed Cell Insulation for Refrigerant Lines\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.armacell.com/\"}}},\"159\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"ASCO\",\"vendorDescription\":\"Solenoid Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.asco.com/\"}}},\"160\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Bacharach\",\"vendorDescription\":\"Combustion Analyzers, Leak Detectors and Refrigerant Recovery/Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.bacharach-inc.com/\"}}},\"161\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Baron Wire\",\"vendorDescription\":\"Thermostat Cable-UL, Plenum, Shielded, Extension Cords\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.colemancable.com/Home\"}}},\"162\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Belimo\",\"vendorDescription\":\"Direct Mounted Actuators and Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.belimo.com/english/index.cfm\"}}},\"163\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Browning Belts\",\"vendorDescription\":\"V-belt drives and power transmission products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonindustrial.com/en-US/powertransmissionsolutions/Pages/home.aspx\"}}},\"164\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Cooper-Atkins\",\"vendorDescription\":\"Thermometers-Digital/Bi-metal/Liquid Filled\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooper-atkins.com/\"}}},\"165\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Copeland\",\"vendorDescription\":\"Hermetic and Semi-Hermetic Compressors for Refrigeration and Air Conditioning\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonclimate.com/en-US/Pages/home.aspx\"}}},\"166\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Crown Boiler\",\"vendorDescription\":\"Heating Parts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.crownboiler.com/\"}}},\"167\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Diversitech\",\"vendorDescription\":\"Air Conditioning Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.diversitech.com/\"}}},\"168\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dupont Refrigerants\",\"vendorDescription\":\"Refrigerant, filters\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www2.dupont.com/Refrigerants/en_US/\"}}},\"169\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dust Free\",\"vendorDescription\":\"Indoor Air Quality Solutions\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dustfree.com/\"}}},\"170\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dwyer\",\"vendorDescription\":\"Magnehelic Gages\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dwyer-inst.com/\"}}},\"171\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ecobee\",\"vendorDescription\":\"Programmable Thermostats\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ecobee.com/\"}}},\"172\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Edison Fusegear\",\"vendorDescription\":\"Electrical Fuses\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooperindustries.com/content/public/en/bussmann.html\"}}},\"173\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Federal Process\",\"vendorDescription\":\"Specialty Chemicals\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.federalprocess.com/\"}}},\"174\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Fluke\",\"vendorDescription\":\"Electrical Test Instruments\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.fluke.com/\"}}},\"175\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Functional Devices\",\"vendorDescription\":\"Electronic devices\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.functionaldevices.com/\"}}},\"176\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Gates\",\"vendorDescription\":\"V-Belts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.gates.com/\"}}},\"177\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Hays Fluid\",\"vendorDescription\":\"Automatic Flow Control Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.haysfluidcontrols.com/index.html\"}}},\"178\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"HeatCraft\",\"vendorDescription\":\"Refrigeration Evaporators and Condensing Units\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.heatcraftrpd.com/\"}}},\"179\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Henry Valve\",\"vendorDescription\":\"Refrigerant Control Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.henrytech.com/\"}}},\"180\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Highside\",\"vendorDescription\":\"Chemicals\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.highsidechem.com/\"}}},\"181\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Honeywell\",\"vendorDescription\":\"Burner and Boiler Controls, Commercial Building Controls, Environmental Controls, Hydronic Controls Pneumatic Controls, Residential HVAC Controls, Perfect Climate Humidifiers, Air Cleaners, UV Air Treatment, Digital Thermostats, Communicating Thermostats, Equipment Monitoring\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.customer.honeywell.com/\"}}},\"182\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Imperial (Stride Tools)\",\"vendorDescription\":\"Tube Working Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://imperial-tools.com/\"}}},\"183\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Inficon\",\"vendorDescription\":\"Refrigerant Leak Detectors\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.inficon.com/default.aspx?language=en-us\"}}},\"184\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"J.W. Harris\",\"vendorDescription\":\"Soldering and Brazing Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.harrisproductsgroup.com/\"}}},\"185\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"JB Industries\",\"vendorDescription\":\"Vacuum Pumps and Charging Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.jbind.com/\"}}},\"186\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Johnson Controls\",\"vendorDescription\":\"Pneumatic Controls, Refrigeration Controls and Leak Detectors, Commercial Air Conditioning Controls, BASO Gas Ignition Products, Valves and Actuators\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://cgproducts.johnsoncontrols.com/default.aspx?topframe.aspx&0\"}}},\"187\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"KE2 Thermal\",\"vendorDescription\":\"Advanced energy saving technology\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ke2therm.com/\"}}},\"188\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Klein\",\"vendorDescription\":\"Hand Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.kleintools.com/\"}}},\"189\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Koch Filter\",\"vendorDescription\":\"Commercial and Industrial Air Filtration Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.kochfilter.com/\"}}},\"190\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Lau\",\"vendorDescription\":\"Blower Wheels and Fan Blades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.lauparts.com/\"}}},\"191\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Lenox\",\"vendorDescription\":\"Saw Blades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.lenoxtools.com/Pages/home.aspx\"}}},\"192\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Little Giant\",\"vendorDescription\":\"Condensate Pumps\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://franklin-electric.com/hvac.aspx\"}}},\"193\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Malco\",\"vendorDescription\":\"Hand Tools For HVAC Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://malcoproducts.com/\"}}},\"194\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Mars\",\"vendorDescription\":\"Motors & Armatures\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.marsm-a.com/\"}}},\"195\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Mueller\",\"vendorDescription\":\"Copper Tube and Fitting for HVAC/R\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.muellerindustries.com/\"}}},\"196\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NSI\",\"vendorDescription\":\"Connectors\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nsiindustries.com/products/electrical.aspx\"}}},\"197\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NTI\",\"vendorDescription\":\"High Efficiency Boilers\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nythermal.com/trinity_ti\"}}},\"198\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NuCalgon\",\"vendorDescription\":\"Coil Cleaners and Chemicals for the HVAC/R Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nucalgon.com/\"}}},\"199\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Parker\",\"vendorDescription\":\"Brass Fittings, Refrigeration Control Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.parker.com/portal/site/PARKER/menuitem.b90576e27a4d71ae1bfcc510237ad1ca/?vgnextoid=c38888b5bd16e010VgnVCM1000000308a8c0RCRD&vgnextfmt=default\"}}},\"200\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Polyken Tape\",\"vendorDescription\":\"Pressure sensitive tapes and adhesives\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://tapes.berryplastics.com/\"}}},\"201\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ranco\",\"vendorDescription\":\"Refrigeration Temperature and Pressure Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.uni-line.com/common/ranco.aspx\"}}},\"202\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"RCD Mastics\",\"vendorDescription\":\"Home Weatherization Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rcdmastics.com/\"}}},\"203\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"RectorSeal\",\"vendorDescription\":\"Chemicals for the HVAC/R Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/\"}}},\"204\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ritchie\",\"vendorDescription\":\"Charging Hoses and Manifolds\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.yellowjacket.com/\"}}},\"205\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Schneider Electric\",\"vendorDescription\":\"Energy Management\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.schneider-electric.com/site/home/index.cfm/ww/?selectCountry=true\"}}},\"206\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Scotsman Ice Machines\",\"vendorDescription\":\"Leaders in ice machine innovation\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.scotsman-ice.com/?xhtml=xhtml/sct/us/en/homepage/default.html&xsl=homepage.xsl\"}}},\"207\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Sealed Unit Parts\",\"vendorDescription\":\"SUPCO Accessories for the HVAC/R Trade\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.supco.com/web/supco_live/\"}}},\"208\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Siemens\",\"vendorDescription\":\"Pneumatic Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nsiindustries.com/products/electrical.aspx\"}}},\"209\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Sporlan\",\"vendorDescription\":null,\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"\"}}}}}}','2019-02-10 14:50:02','2019-02-10 14:50:02','5f3cf262-49f5-489d-a9cb-a233b09068c8'),(45,148,20,1,1,9,'','{\"typeId\":\"20\",\"authorId\":null,\"title\":\"Vendors\",\"slug\":\"vendors\",\"postDate\":1549762080,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"48\":{\"153\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A.O. Smith\",\"vendorDescription\":\"Electric Motors-Fractional and Integral Horsepower\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}}},\"154\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A1 Components\",\"vendorDescription\":\"A/C and Refrigeration Components, Camstat Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}}},\"155\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Amprobe\",\"vendorDescription\":\"Instruments for Measuring Volts, Amps, Ohms, Temperature\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}}},\"156\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Antunes\",\"vendorDescription\":\"Pressure Switches for Gas and Air\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.antunescontrols.com/\"}}},\"157\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"AquaGuard\",\"vendorDescription\":\"Conservation Technologies\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/index.php/products-4/\"}}},\"158\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Armacell\",\"vendorDescription\":\"Closed Cell Insulation for Refrigerant Lines\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.armacell.com/\"}}},\"159\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"ASCO\",\"vendorDescription\":\"Solenoid Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.asco.com/\"}}},\"160\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Bacharach\",\"vendorDescription\":\"Combustion Analyzers, Leak Detectors and Refrigerant Recovery/Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.bacharach-inc.com/\"}}},\"161\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Baron Wire\",\"vendorDescription\":\"Thermostat Cable-UL, Plenum, Shielded, Extension Cords\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.colemancable.com/Home\"}}},\"162\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Belimo\",\"vendorDescription\":\"Direct Mounted Actuators and Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.belimo.com/english/index.cfm\"}}},\"163\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Browning Belts\",\"vendorDescription\":\"V-belt drives and power transmission products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonindustrial.com/en-US/powertransmissionsolutions/Pages/home.aspx\"}}},\"164\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Cooper-Atkins\",\"vendorDescription\":\"Thermometers-Digital/Bi-metal/Liquid Filled\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooper-atkins.com/\"}}},\"165\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Copeland\",\"vendorDescription\":\"Hermetic and Semi-Hermetic Compressors for Refrigeration and Air Conditioning\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonclimate.com/en-US/Pages/home.aspx\"}}},\"166\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Crown Boiler\",\"vendorDescription\":\"Heating Parts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.crownboiler.com/\"}}},\"167\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Diversitech\",\"vendorDescription\":\"Air Conditioning Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.diversitech.com/\"}}},\"168\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dupont Refrigerants\",\"vendorDescription\":\"Refrigerant, filters\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www2.dupont.com/Refrigerants/en_US/\"}}},\"169\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dust Free\",\"vendorDescription\":\"Indoor Air Quality Solutions\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dustfree.com/\"}}},\"170\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dwyer\",\"vendorDescription\":\"Magnehelic Gages\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dwyer-inst.com/\"}}},\"171\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ecobee\",\"vendorDescription\":\"Programmable Thermostats\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ecobee.com/\"}}},\"172\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Edison Fusegear\",\"vendorDescription\":\"Electrical Fuses\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooperindustries.com/content/public/en/bussmann.html\"}}},\"173\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Federal Process\",\"vendorDescription\":\"Specialty Chemicals\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.federalprocess.com/\"}}},\"174\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Fluke\",\"vendorDescription\":\"Electrical Test Instruments\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.fluke.com/\"}}},\"175\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Functional Devices\",\"vendorDescription\":\"Electronic devices\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.functionaldevices.com/\"}}},\"176\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Gates\",\"vendorDescription\":\"V-Belts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.gates.com/\"}}},\"177\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Hays Fluid\",\"vendorDescription\":\"Automatic Flow Control Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.haysfluidcontrols.com/index.html\"}}},\"178\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"HeatCraft\",\"vendorDescription\":\"Refrigeration Evaporators and Condensing Units\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.heatcraftrpd.com/\"}}},\"179\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Henry Valve\",\"vendorDescription\":\"Refrigerant Control Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.henrytech.com/\"}}},\"180\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Highside\",\"vendorDescription\":\"Chemicals\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.highsidechem.com/\"}}},\"181\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Honeywell\",\"vendorDescription\":\"Burner and Boiler Controls, Commercial Building Controls, Environmental Controls, Hydronic Controls Pneumatic Controls, Residential HVAC Controls, Perfect Climate Humidifiers, Air Cleaners, UV Air Treatment, Digital Thermostats, Communicating Thermostats, Equipment Monitoring\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.customer.honeywell.com/\"}}},\"182\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Imperial (Stride Tools)\",\"vendorDescription\":\"Tube Working Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://imperial-tools.com/\"}}},\"183\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Inficon\",\"vendorDescription\":\"Refrigerant Leak Detectors\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.inficon.com/default.aspx?language=en-us\"}}},\"184\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"J.W. Harris\",\"vendorDescription\":\"Soldering and Brazing Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.harrisproductsgroup.com/\"}}},\"185\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"JB Industries\",\"vendorDescription\":\"Vacuum Pumps and Charging Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.jbind.com/\"}}},\"186\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Johnson Controls\",\"vendorDescription\":\"Pneumatic Controls, Refrigeration Controls and Leak Detectors, Commercial Air Conditioning Controls, BASO Gas Ignition Products, Valves and Actuators\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://cgproducts.johnsoncontrols.com/default.aspx?topframe.aspx&0\"}}},\"187\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"KE2 Thermal\",\"vendorDescription\":\"Advanced energy saving technology\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ke2therm.com/\"}}},\"188\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Klein\",\"vendorDescription\":\"Hand Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.kleintools.com/\"}}},\"189\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Koch Filter\",\"vendorDescription\":\"Commercial and Industrial Air Filtration Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.kochfilter.com/\"}}},\"190\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Lau\",\"vendorDescription\":\"Blower Wheels and Fan Blades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.lauparts.com/\"}}},\"191\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Lenox\",\"vendorDescription\":\"Saw Blades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.lenoxtools.com/Pages/home.aspx\"}}},\"192\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Little Giant\",\"vendorDescription\":\"Condensate Pumps\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://franklin-electric.com/hvac.aspx\"}}},\"193\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Malco\",\"vendorDescription\":\"Hand Tools For HVAC Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://malcoproducts.com/\"}}},\"194\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Mars\",\"vendorDescription\":\"Motors & Armatures\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.marsm-a.com/\"}}},\"195\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Mueller\",\"vendorDescription\":\"Copper Tube and Fitting for HVAC/R\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.muellerindustries.com/\"}}},\"196\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NSI\",\"vendorDescription\":\"Connectors\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nsiindustries.com/products/electrical.aspx\"}}},\"197\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NTI\",\"vendorDescription\":\"High Efficiency Boilers\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nythermal.com/trinity_ti\"}}},\"198\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NuCalgon\",\"vendorDescription\":\"Coil Cleaners and Chemicals for the HVAC/R Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nucalgon.com/\"}}},\"199\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Parker\",\"vendorDescription\":\"Brass Fittings, Refrigeration Control Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.parker.com/portal/site/PARKER/menuitem.b90576e27a4d71ae1bfcc510237ad1ca/?vgnextoid=c38888b5bd16e010VgnVCM1000000308a8c0RCRD&vgnextfmt=default\"}}},\"200\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Polyken Tape\",\"vendorDescription\":\"Pressure sensitive tapes and adhesives\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://tapes.berryplastics.com/\"}}},\"201\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ranco\",\"vendorDescription\":\"Refrigeration Temperature and Pressure Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.uni-line.com/common/ranco.aspx\"}}},\"202\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"RCD Mastics\",\"vendorDescription\":\"Home Weatherization Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rcdmastics.com/\"}}},\"203\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"RectorSeal\",\"vendorDescription\":\"Chemicals for the HVAC/R Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/\"}}},\"204\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ritchie\",\"vendorDescription\":\"Charging Hoses and Manifolds\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.yellowjacket.com/\"}}},\"205\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Schneider Electric\",\"vendorDescription\":\"Energy Management\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.schneider-electric.com/site/home/index.cfm/ww/?selectCountry=true\"}}},\"206\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Scotsman Ice Machines\",\"vendorDescription\":\"Leaders in ice machine innovation\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.scotsman-ice.com/?xhtml=xhtml/sct/us/en/homepage/default.html&xsl=homepage.xsl\"}}},\"207\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Sealed Unit Parts\",\"vendorDescription\":\"SUPCO Accessories for the HVAC/R Trade\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.supco.com/web/supco_live/\"}}},\"208\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Siemens\",\"vendorDescription\":\"Pneumatic Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nsiindustries.com/products/electrical.aspx\"}}},\"209\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Sporlan\",\"vendorDescription\":\"Catch-All Driers, Solenoid Valves, Thermostatic Expansion Valves, Refrigerant Pressure Regulators\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.parker.com/portal/site/PARKER/menuitem.223a4a3cce02eb6315731910237ad1ca/?vgnextoid=47f9724fe7a5e210VgnVCM10000048021dacRCRD&vgnextfmt=EN\"}}},\"210\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Suntec\",\"vendorDescription\":\"Fuel Oil Pumps\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.suntecpumps.com/\"}}},\"211\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"System Sensor\",\"vendorDescription\":\"Duct Smoke Detectors\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.systemsensor.com/en-us/Pages/welcome.aspx\"}}},\"212\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Temprite\",\"vendorDescription\":\"Oil Separators\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.temprite.com/main_content.asp?pagename=home\"}}},\"213\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"UEI\",\"vendorDescription\":\"Electrical and Temperature Test Instruments\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ueitest.com/\"}}},\"214\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ultravation\",\"vendorDescription\":\"Ultraviolet Disinfection Systems and Indoor Air Quality Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ultravation.com/\"}}}}}}','2019-02-10 14:51:49','2019-02-10 14:51:49','4f62a48f-537c-4346-8402-cc3c9ef66ebb'),(46,148,20,1,1,10,'','{\"typeId\":\"20\",\"authorId\":null,\"title\":\"Vendors\",\"slug\":\"vendors\",\"postDate\":1549762080,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"48\":{\"153\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A.O. Smith\",\"vendorDescription\":\"Electric Motors-Fractional and Integral Horsepower\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}}},\"154\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"A1 Components\",\"vendorDescription\":\"A/C and Refrigeration Components, Camstat Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}}},\"155\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Amprobe\",\"vendorDescription\":\"Instruments for Measuring Volts, Amps, Ohms, Temperature\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}}},\"156\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Antunes\",\"vendorDescription\":\"Pressure Switches for Gas and Air\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.antunescontrols.com/\"}}},\"157\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"AquaGuard\",\"vendorDescription\":\"Conservation Technologies\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/index.php/products-4/\"}}},\"158\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Armacell\",\"vendorDescription\":\"Closed Cell Insulation for Refrigerant Lines\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.armacell.com/\"}}},\"159\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"ASCO\",\"vendorDescription\":\"Solenoid Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.asco.com/\"}}},\"160\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Bacharach\",\"vendorDescription\":\"Combustion Analyzers, Leak Detectors and Refrigerant Recovery/Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.bacharach-inc.com/\"}}},\"161\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Baron Wire\",\"vendorDescription\":\"Thermostat Cable-UL, Plenum, Shielded, Extension Cords\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.colemancable.com/Home\"}}},\"162\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Belimo\",\"vendorDescription\":\"Direct Mounted Actuators and Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.belimo.com/english/index.cfm\"}}},\"163\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Browning Belts\",\"vendorDescription\":\"V-belt drives and power transmission products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonindustrial.com/en-US/powertransmissionsolutions/Pages/home.aspx\"}}},\"164\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Cooper-Atkins\",\"vendorDescription\":\"Thermometers-Digital/Bi-metal/Liquid Filled\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooper-atkins.com/\"}}},\"165\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Copeland\",\"vendorDescription\":\"Hermetic and Semi-Hermetic Compressors for Refrigeration and Air Conditioning\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonclimate.com/en-US/Pages/home.aspx\"}}},\"166\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Crown Boiler\",\"vendorDescription\":\"Heating Parts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.crownboiler.com/\"}}},\"167\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Diversitech\",\"vendorDescription\":\"Air Conditioning Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.diversitech.com/\"}}},\"168\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dupont Refrigerants\",\"vendorDescription\":\"Refrigerant, filters\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www2.dupont.com/Refrigerants/en_US/\"}}},\"169\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dust Free\",\"vendorDescription\":\"Indoor Air Quality Solutions\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dustfree.com/\"}}},\"170\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Dwyer\",\"vendorDescription\":\"Magnehelic Gages\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dwyer-inst.com/\"}}},\"171\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ecobee\",\"vendorDescription\":\"Programmable Thermostats\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ecobee.com/\"}}},\"172\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Edison Fusegear\",\"vendorDescription\":\"Electrical Fuses\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooperindustries.com/content/public/en/bussmann.html\"}}},\"173\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Federal Process\",\"vendorDescription\":\"Specialty Chemicals\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.federalprocess.com/\"}}},\"174\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Fluke\",\"vendorDescription\":\"Electrical Test Instruments\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.fluke.com/\"}}},\"175\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Functional Devices\",\"vendorDescription\":\"Electronic devices\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.functionaldevices.com/\"}}},\"176\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Gates\",\"vendorDescription\":\"V-Belts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.gates.com/\"}}},\"177\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Hays Fluid\",\"vendorDescription\":\"Automatic Flow Control Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.haysfluidcontrols.com/index.html\"}}},\"178\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"HeatCraft\",\"vendorDescription\":\"Refrigeration Evaporators and Condensing Units\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.heatcraftrpd.com/\"}}},\"179\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Henry Valve\",\"vendorDescription\":\"Refrigerant Control Valves\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.henrytech.com/\"}}},\"180\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Highside\",\"vendorDescription\":\"Chemicals\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.highsidechem.com/\"}}},\"181\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Honeywell\",\"vendorDescription\":\"Burner and Boiler Controls, Commercial Building Controls, Environmental Controls, Hydronic Controls Pneumatic Controls, Residential HVAC Controls, Perfect Climate Humidifiers, Air Cleaners, UV Air Treatment, Digital Thermostats, Communicating Thermostats, Equipment Monitoring\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.customer.honeywell.com/\"}}},\"182\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Imperial (Stride Tools)\",\"vendorDescription\":\"Tube Working Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://imperial-tools.com/\"}}},\"183\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Inficon\",\"vendorDescription\":\"Refrigerant Leak Detectors\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.inficon.com/default.aspx?language=en-us\"}}},\"184\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"J.W. Harris\",\"vendorDescription\":\"Soldering and Brazing Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.harrisproductsgroup.com/\"}}},\"185\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"JB Industries\",\"vendorDescription\":\"Vacuum Pumps and Charging Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.jbind.com/\"}}},\"186\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Johnson Controls\",\"vendorDescription\":\"Pneumatic Controls, Refrigeration Controls and Leak Detectors, Commercial Air Conditioning Controls, BASO Gas Ignition Products, Valves and Actuators\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://cgproducts.johnsoncontrols.com/default.aspx?topframe.aspx&0\"}}},\"187\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"KE2 Thermal\",\"vendorDescription\":\"Advanced energy saving technology\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ke2therm.com/\"}}},\"188\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Klein\",\"vendorDescription\":\"Hand Tools\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.kleintools.com/\"}}},\"189\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Koch Filter\",\"vendorDescription\":\"Commercial and Industrial Air Filtration Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.kochfilter.com/\"}}},\"190\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Lau\",\"vendorDescription\":\"Blower Wheels and Fan Blades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.lauparts.com/\"}}},\"191\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Lenox\",\"vendorDescription\":\"Saw Blades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.lenoxtools.com/Pages/home.aspx\"}}},\"192\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Little Giant\",\"vendorDescription\":\"Condensate Pumps\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://franklin-electric.com/hvac.aspx\"}}},\"193\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Malco\",\"vendorDescription\":\"Hand Tools For HVAC Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://malcoproducts.com/\"}}},\"194\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Mars\",\"vendorDescription\":\"Motors & Armatures\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.marsm-a.com/\"}}},\"195\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Mueller\",\"vendorDescription\":\"Copper Tube and Fitting for HVAC/R\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.muellerindustries.com/\"}}},\"196\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NSI\",\"vendorDescription\":\"Connectors\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nsiindustries.com/products/electrical.aspx\"}}},\"197\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NTI\",\"vendorDescription\":\"High Efficiency Boilers\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nythermal.com/trinity_ti\"}}},\"198\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"NuCalgon\",\"vendorDescription\":\"Coil Cleaners and Chemicals for the HVAC/R Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nucalgon.com/\"}}},\"199\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Parker\",\"vendorDescription\":\"Brass Fittings, Refrigeration Control Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.parker.com/portal/site/PARKER/menuitem.b90576e27a4d71ae1bfcc510237ad1ca/?vgnextoid=c38888b5bd16e010VgnVCM1000000308a8c0RCRD&vgnextfmt=default\"}}},\"200\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Polyken Tape\",\"vendorDescription\":\"Pressure sensitive tapes and adhesives\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://tapes.berryplastics.com/\"}}},\"201\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ranco\",\"vendorDescription\":\"Refrigeration Temperature and Pressure Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.uni-line.com/common/ranco.aspx\"}}},\"202\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"RCD Mastics\",\"vendorDescription\":\"Home Weatherization Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rcdmastics.com/\"}}},\"203\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"RectorSeal\",\"vendorDescription\":\"Chemicals for the HVAC/R Trades\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/\"}}},\"204\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ritchie\",\"vendorDescription\":\"Charging Hoses and Manifolds\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.yellowjacket.com/\"}}},\"205\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Schneider Electric\",\"vendorDescription\":\"Energy Management\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.schneider-electric.com/site/home/index.cfm/ww/?selectCountry=true\"}}},\"206\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Scotsman Ice Machines\",\"vendorDescription\":\"Leaders in ice machine innovation\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.scotsman-ice.com/?xhtml=xhtml/sct/us/en/homepage/default.html&xsl=homepage.xsl\"}}},\"207\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Sealed Unit Parts\",\"vendorDescription\":\"SUPCO Accessories for the HVAC/R Trade\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.supco.com/web/supco_live/\"}}},\"208\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Siemens\",\"vendorDescription\":\"Pneumatic Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nsiindustries.com/products/electrical.aspx\"}}},\"209\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Sporlan\",\"vendorDescription\":\"Catch-All Driers, Solenoid Valves, Thermostatic Expansion Valves, Refrigerant Pressure Regulators\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.parker.com/portal/site/PARKER/menuitem.223a4a3cce02eb6315731910237ad1ca/?vgnextoid=47f9724fe7a5e210VgnVCM10000048021dacRCRD&vgnextfmt=EN\"}}},\"210\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Suntec\",\"vendorDescription\":\"Fuel Oil Pumps\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.suntecpumps.com/\"}}},\"211\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"System Sensor\",\"vendorDescription\":\"Duct Smoke Detectors\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.systemsensor.com/en-us/Pages/welcome.aspx\"}}},\"212\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Temprite\",\"vendorDescription\":\"Oil Separators\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.temprite.com/main_content.asp?pagename=home\"}}},\"213\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"UEI\",\"vendorDescription\":\"Electrical and Temperature Test Instruments\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ueitest.com/\"}}},\"214\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Ultravation\",\"vendorDescription\":\"Ultraviolet Disinfection Systems and Indoor Air Quality Products\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ultravation.com/\"}}},\"215\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Uniweld\",\"vendorDescription\":\"Welding Outfits and Accessories\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://uniweld.com/\"}}},\"216\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Victor-Turbo Torch\",\"vendorDescription\":\"Self Lighting Torches\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://victortechnologies.com/\"}}},\"217\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Watts\",\"vendorDescription\":\"Backflow Preventer Repair Parts\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.watts.com/\"}}},\"218\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"Weiss\",\"vendorDescription\":\"Thermometers and Pressure Gauges\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.weissinstruments.com/\"}}},\"219\":{\"type\":\"vendor\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"vendorName\":\"White Rogers\",\"vendorDescription\":\"Thermostats and Gas Controls\",\"vendorLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonclimate.com/en-us/brands/white_rodgers/pages/white_rodgers.aspx\"}}}}}}','2019-02-10 15:01:04','2019-02-10 15:01:04','fa8526a9-28a6-40c5-a743-9070da930e4b'),(47,223,21,1,1,1,'','{\"typeId\":\"21\",\"authorId\":\"1\",\"title\":\"John Smith\",\"slug\":\"john-smith\",\"postDate\":1557584640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":[]}','2019-05-11 14:24:49','2019-05-11 14:24:49','cb0f4157-6332-4bf7-9640-e1d35bf620a7'),(48,224,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2009 - 2010\",\"slug\":\"2009-2010\",\"postDate\":1557585360,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"225\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"John Smith\"}}}}}','2019-05-11 14:37:00','2019-05-11 14:37:00','75e20ddc-5628-4a66-8f10-b1194eb6c93c'),(49,226,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2010 - 2011\",\"slug\":\"2010-2011\",\"postDate\":1557585960,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"227\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Jane Smith\"}}}}}','2019-05-11 14:46:39','2019-05-11 14:46:39','99ca3f20-47e1-4c10-92dd-7b61c31cff98'),(50,226,22,1,1,2,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2010 - 2011\",\"slug\":\"2010-2011\",\"postDate\":1557585960,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"227\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Jane Smith\"}},\"228\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Willis\"}}}}}','2019-05-11 14:58:07','2019-05-11 14:58:07','9675a42f-938c-416a-b2c4-774ea793655a'),(51,224,22,1,1,2,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2009 - 2010 School Year\",\"slug\":\"2009-2010\",\"postDate\":1557585360,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"225\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Lexie Smith\"}},\"229\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Lindsey Smith\"}},\"230\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"John Richardson\"}},\"231\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"John Cappello\"}},\"232\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Anthony Cappello\"}},\"233\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Scottie Garner\"}},\"234\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Brittany Barbour\"}},\"235\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Lindsey Cook\"}},\"236\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Kevin Buckman\"}},\"237\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Brian Buckman\"}}}}}','2019-05-11 15:00:36','2019-05-11 15:00:36','24663bb7-7db6-4030-8a82-a2132094889a'),(52,226,22,1,1,3,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2010 - 2011 School Year\",\"slug\":\"2010-2011\",\"postDate\":1557585960,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"227\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Lindsey Cook\"}},\"228\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"John Richardson\"}},\"238\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Lindsey Smith\"}},\"239\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Anthony Cappello\"}},\"240\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"John Cappello\"}}}}}','2019-05-11 15:01:18','2019-05-11 15:01:18','d2d1441a-1759-48a9-af6b-715d212b73b1'),(53,241,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2011 - 2012 School Year\",\"slug\":\"2011-2012-school-year\",\"postDate\":1557586920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"242\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Thomas Aiken\"}},\"243\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Bryan Richardson\"}},\"244\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"John Richardson\"}},\"245\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"John Cappello\"}},\"246\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Anthony Cappello\"}},\"247\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Lindsey Smith\"}}}}}','2019-05-11 15:02:03','2019-05-11 15:02:03','3c6802dd-e24e-4340-896a-64cade542215'),(54,248,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2012 - 2013 School Year\",\"slug\":\"2012-2013-school-year\",\"postDate\":1557586980,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"249\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Thomas Aiken\"}},\"250\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"John Cappello\"}},\"251\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"John Richardson\"}},\"252\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Bryan Richardson\"}},\"253\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Nicholas Cicero\"}},\"254\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Aaron Cook\"}},\"255\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Allison Cook\"}}}}}','2019-05-11 15:03:49','2019-05-11 15:03:49','186e9f31-2fe3-493a-b393-1df4dcf45d83'),(55,256,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2013 - 2014 School Year\",\"slug\":\"2013-2014-school-year\",\"postDate\":1557587040,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"257\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Thomas Aiken\"}},\"258\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Aaron Cook\"}},\"259\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Allison Cook\"}},\"260\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Bryan Richardson\"}},\"261\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Allie Smith\"}}}}}','2019-05-11 15:04:48','2019-05-11 15:04:48','0c45d886-a80e-40f9-bae3-d60c434c1eca'),(56,262,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2014 - 2015 School Year\",\"slug\":\"2014-2015-school-year\",\"postDate\":1557587100,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"263\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Thomas Aiken\"}},\"264\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Hayden Brumley\"}},\"265\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Matthew Cappello\"}},\"266\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Aaron Cook\"}},\"267\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Allison Cook\"}},\"268\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Allie Smith\"}},\"269\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Caleb Smith\"}},\"270\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Madison Smith\"}}}}}','2019-05-11 15:05:30','2019-05-11 15:05:30','56f78c1b-940d-494a-8b39-9314ccc71267'),(57,271,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2015 - 2016 School Year\",\"slug\":\"2015-2016-school-year\",\"postDate\":1557587160,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"272\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Matthew Cappello\"}},\"273\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Aaron Cook\"}},\"274\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Allison Cook\"}},\"275\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Hannah Gardner\"}},\"276\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Alyssa Hayes\"}},\"277\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Megan Shepherd\"}},\"278\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Madison Smith\"}},\"279\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Christopher Terreault\"}}}}}','2019-05-11 15:06:18','2019-05-11 15:06:18','32b80536-f13b-41fd-b4ef-6f09efa8b716'),(58,280,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2016 - 2017 School Year\",\"slug\":\"2016-2017-school-year\",\"postDate\":1557587160,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"281\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Cassandra Cappello\"}},\"282\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Meghan Dempsey\"}},\"283\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Hannah Gardner\"}},\"284\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Megan Shepherd\"}},\"285\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Allie Smith\"}},\"286\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Madison Smith\"}},\"287\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Andrew Terreault\"}},\"288\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Christopher Terreault\"}}}}}','2019-05-11 15:07:00','2019-05-11 15:07:00','e36be517-4600-43e8-9183-f835340a95b3'),(59,289,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2017 - 2018 School Year\",\"slug\":\"2017-2018-school-year\",\"postDate\":1557587220,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"290\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Cassandra Cappello\"}},\"291\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Matthew Cappello\"}},\"292\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Meghan Dempsey\"}},\"293\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Hannah Gardner\"}},\"294\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Bailey McCann\"}},\"295\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Megan Shepherd\"}},\"296\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Madison Smith\"}},\"297\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Christopher Terreault\"}}}}}','2019-05-11 15:07:44','2019-05-11 15:07:44','efd4c3a3-4835-40f6-a4c5-0c32ee6c67b5'),(60,298,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2018-2019 School Year\",\"slug\":\"2018-2019-school-year\",\"postDate\":1557587280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"299\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Cassandra Cappello\"}},\"300\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Matthew Cappello\"}},\"301\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Meghan Dempsey\"}},\"302\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Hannah Gardner\"}},\"303\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Megan Shepherd\"}},\"304\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Christopher Terreault\"}},\"305\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Dylan Thompson\"}},\"306\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Robert Ursery\"}}}}}','2019-05-11 15:08:26','2019-05-11 15:08:26','ba97232f-e235-46d7-adf4-ed370ac27d59'),(61,307,22,1,1,1,'','{\"typeId\":\"22\",\"authorId\":\"1\",\"title\":\"2019-2020 School Year\",\"slug\":\"2019-2020-school-year\",\"postDate\":1557587340,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"56\":{\"308\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Anna Brumley\"}},\"309\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Sophia Brzezinski\"}},\"310\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Ethan Butler\"}},\"311\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Cassandra Cappello\"}},\"312\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Meghan Dempsey\"}},\"313\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Micaela Dempsey\"}},\"314\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Chandler Gardner\"}},\"315\":{\"type\":\"recipient\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"recipientName\":\"Robert Ursery\"}}}}}','2019-05-11 15:09:10','2019-05-11 15:09:10','9a5bcecd-2aac-494b-91e3-da65c1fad741');
/*!40000 ALTER TABLE `acr_entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldgroups`
--

LOCK TABLES `acr_fieldgroups` WRITE;
/*!40000 ALTER TABLE `acr_fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fieldgroups` VALUES (1,'Common','2018-09-30 15:22:58','2019-01-17 02:45:22','d1b2d3e0-caff-4265-8c15-310da7c6b14f'),(3,'Notifications','2018-11-02 01:19:21','2019-01-17 02:45:22','75772b73-5f13-442a-b9a8-8c5a6015f039'),(5,'Services','2018-11-02 02:27:54','2019-01-17 02:45:22','d0819d73-9155-4ac5-9995-9fe3d7c32c74'),(7,'Home','2018-12-08 01:26:41','2019-01-17 02:45:22','28b86dd3-c932-453a-ad70-b5c437d0c06b'),(8,'Testimonials','2018-12-30 16:09:03','2019-01-17 02:45:22','3a435df0-e9ed-4290-a496-2073b7800d15'),(9,'Newsletter','2018-12-30 16:31:14','2019-01-17 02:45:22','77926385-cc33-4146-a9d8-bb682af7623a'),(10,'Global','2018-12-30 16:42:19','2019-01-17 02:45:22','7a86ba31-dc42-491b-9a15-47a006756d8b'),(11,'Culture Survey','2019-02-05 02:31:22','2019-02-05 02:31:22','0b8de195-d37c-4f38-aa45-654e5aadd202'),(12,'Vendors','2019-02-10 01:28:51','2019-02-10 01:28:51','385df8b4-d6e4-4969-afda-8aece985aaa0'),(13,'Events','2019-04-24 00:22:53','2019-04-24 00:22:53','bc26c1a0-4632-4aa7-b379-350cf7c768b7');
/*!40000 ALTER TABLE `acr_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldlayoutfields`
--

LOCK TABLES `acr_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `acr_fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fieldlayoutfields` VALUES (2,2,2,2,0,1,'2018-10-08 23:48:12','2018-10-08 23:48:12','b1772bbf-f9be-4f2d-84a8-5a2fd8451210'),(54,11,20,23,0,1,'2018-12-30 16:10:48','2018-12-30 16:10:48','e75f687f-ca0e-4124-a1dd-87c113917776'),(55,11,20,24,0,2,'2018-12-30 16:10:48','2018-12-30 16:10:48','6f337ced-fc8e-4f55-80eb-e47b5de9144f'),(56,7,21,10,0,1,'2018-12-30 16:32:20','2018-12-30 16:32:20','0e3965a8-e3a4-439c-9b05-d7876b7ed13b'),(57,7,21,11,0,2,'2018-12-30 16:32:20','2018-12-30 16:32:20','9f2b94d7-e782-4e48-9a15-e01b1edce0f8'),(58,7,21,12,0,3,'2018-12-30 16:32:20','2018-12-30 16:32:20','5b229b3b-6688-4920-8322-0c8585d6e2c1'),(59,7,22,16,0,1,'2018-12-30 16:32:20','2018-12-30 16:32:20','3ad8696a-6c13-4c76-811d-5ed9bcd3ee92'),(60,7,23,26,0,1,'2018-12-30 16:32:20','2018-12-30 16:32:20','8d704420-f373-428a-a24d-0ae0690d0eeb'),(61,7,23,27,0,2,'2018-12-30 16:32:20','2018-12-30 16:32:20','7f873951-5969-48f9-8576-988a634e4b16'),(62,7,23,25,0,3,'2018-12-30 16:32:20','2018-12-30 16:32:20','6f237ada-e103-488b-b06e-12fb522e98a6'),(72,15,28,33,0,1,'2019-01-02 00:46:22','2019-01-02 00:46:22','19e39c39-23d3-488b-8ca5-f675b5269f35'),(73,15,29,29,0,1,'2019-01-02 00:46:22','2019-01-02 00:46:22','a1e45ee9-edde-4326-b2c9-977bf012897b'),(74,15,29,30,0,2,'2019-01-02 00:46:22','2019-01-02 00:46:22','75a1c14b-1148-41d8-a7d9-b1b7f2bc117e'),(75,15,29,31,0,3,'2019-01-02 00:46:22','2019-01-02 00:46:22','0f5762d4-15fc-42f7-99f7-3eda119389f9'),(83,17,33,34,0,1,'2019-01-02 01:15:39','2019-01-02 01:15:39','fdd0af8a-64c5-4112-9a53-22415fe499b3'),(98,9,38,13,0,1,'2019-01-17 02:45:24','2019-01-17 02:45:24','4b09023b-b4fc-4c32-ade5-032869e80f01'),(99,9,38,14,0,2,'2019-01-17 02:45:24','2019-01-17 02:45:24','fe9c1d22-021a-4a23-930e-0eea7a1e60d6'),(100,9,38,15,0,3,'2019-01-17 02:45:24','2019-01-17 02:45:24','6367b3f9-5d32-4a4a-901f-bab0a5712cce'),(101,10,39,17,1,1,'2019-01-17 02:45:24','2019-01-17 02:45:24','16581a99-947d-4607-a2fb-4ac3ef502fc5'),(102,10,39,18,0,2,'2019-01-17 02:45:24','2019-01-17 02:45:24','dfe35ebd-d406-482e-9188-eec122673d49'),(103,10,39,19,0,3,'2019-01-17 02:45:24','2019-01-17 02:45:24','b49ed67f-17bb-4b39-8928-34dc985639e6'),(104,10,39,20,0,4,'2019-01-17 02:45:24','2019-01-17 02:45:24','4ef0016a-cf14-48d9-83d3-456fbfcc2fc5'),(105,10,39,22,0,5,'2019-01-17 02:45:24','2019-01-17 02:45:24','fc010d2c-91b6-4431-b4aa-6436a33738fc'),(109,18,41,35,0,1,'2019-01-21 18:21:58','2019-01-21 18:21:58','2109c579-ac80-402b-88e1-3c29966c1938'),(110,18,41,36,0,2,'2019-01-21 18:21:58','2019-01-21 18:21:58','3e54ac48-42bd-45cb-ad93-c0eb3c716e42'),(111,18,41,37,0,3,'2019-01-21 18:21:58','2019-01-21 18:21:58','193fc413-c967-4e28-8a18-b3ba39dedffc'),(112,18,41,38,0,4,'2019-01-21 18:21:58','2019-01-21 18:21:58','b16925a4-1608-40f7-98e3-ff0eeda85c91'),(117,19,44,41,0,1,'2019-01-23 02:57:52','2019-01-23 02:57:52','283deab4-c51c-4fd5-b69d-2d142f46ac8c'),(118,19,44,42,0,2,'2019-01-23 02:57:52','2019-01-23 02:57:52','64afab87-50ab-4d62-baf8-209ddb1b2c1a'),(119,21,45,44,0,1,'2019-01-23 03:03:52','2019-01-23 03:03:52','07deb8b2-becf-48b6-82eb-6aa1cf5599f9'),(120,20,46,39,0,1,'2019-01-23 03:04:05','2019-01-23 03:04:05','ce48e776-488e-4a14-b505-b17e309420b2'),(121,20,46,43,0,2,'2019-01-23 03:04:05','2019-01-23 03:04:05','8dba1fd8-1745-44a9-a1a6-192bb3a61001'),(124,6,48,45,1,1,'2019-01-27 18:17:45','2019-01-27 18:17:45','1588142c-4418-4651-b05b-a96c42cde8fa'),(125,6,48,4,0,2,'2019-01-27 18:17:45','2019-01-27 18:17:45','3c852616-e9a8-43e6-8b9c-85e6c2eb88eb'),(129,22,50,25,0,1,'2019-01-27 18:29:22','2019-01-27 18:29:22','56058c09-761b-461a-b9a4-d23a3decfc5b'),(130,22,50,26,0,2,'2019-01-27 18:29:22','2019-01-27 18:29:22','3ea931d4-f60d-4c36-913e-a460ece1e420'),(131,22,50,27,0,3,'2019-01-27 18:29:22','2019-01-27 18:29:22','2a79b08d-3624-4e9c-b935-13708ce16154'),(132,23,51,47,0,1,'2019-02-05 02:31:48','2019-02-05 02:31:48','9c138d04-e5b5-45d2-aabf-a86b42e31636'),(133,5,52,46,0,1,'2019-02-05 02:34:16','2019-02-05 02:34:16','e6b30384-1638-4d2c-a6f7-8f3707f98680'),(134,8,53,7,0,1,'2019-02-09 21:36:20','2019-02-09 21:36:20','9c280197-220f-4e1a-9fee-899f164e2da7'),(135,8,53,6,0,2,'2019-02-09 21:36:20','2019-02-09 21:36:20','b55a63af-2bbd-463a-a7a0-63036dea55b5'),(136,8,53,2,0,3,'2019-02-09 21:36:20','2019-02-09 21:36:20','e004d102-9e1a-4f45-ad9a-aa3458961f9f'),(137,24,54,49,1,1,'2019-02-10 01:29:56','2019-02-10 01:29:56','816cbc4f-3679-4d3a-a750-d3f711811f40'),(138,24,54,50,0,2,'2019-02-10 01:29:56','2019-02-10 01:29:56','88b8b20b-33ec-48bc-b6c1-76296dbee73f'),(139,24,54,51,0,3,'2019-02-10 01:29:56','2019-02-10 01:29:56','c8830100-2bcd-438b-8f9f-248d6f0072ec'),(140,25,55,48,0,1,'2019-02-10 01:30:11','2019-02-10 01:30:11','92fa43b1-b8ee-431e-b67a-867daaa93966'),(150,26,61,54,0,1,'2019-05-11 14:04:29','2019-05-11 14:04:29','c79e096a-02c6-425e-9c6d-d376b4323b9f'),(151,26,61,52,0,2,'2019-05-11 14:04:29','2019-05-11 14:04:29','b632f17b-fac4-416b-93bb-6a9b685d1202'),(152,26,61,53,0,3,'2019-05-11 14:04:29','2019-05-11 14:04:29','0e247e5d-8a64-4092-96ff-4f283e53e6e4'),(153,26,61,55,0,4,'2019-05-11 14:04:29','2019-05-11 14:04:29','d07116d8-3d20-4de0-83d5-2305cef21958'),(158,28,65,56,0,2,'2019-05-11 14:33:41','2019-05-11 14:33:41','9b58169e-d8ad-4694-8995-1af6ebea8f6b'),(159,30,66,56,0,1,'2019-05-11 14:35:41','2019-05-11 14:35:41','7fd807d7-9897-455e-8f1e-31429f2a124b'),(160,31,67,60,1,1,'2019-05-11 14:36:36','2019-05-11 14:36:36','a9ff961b-3cad-4e21-b521-ba9e88c0b233');
/*!40000 ALTER TABLE `acr_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldlayouts`
--

LOCK TABLES `acr_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `acr_fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fieldlayouts` VALUES (1,'Solspace\\Calendar\\Elements\\Event','2018-09-30 15:33:39','2018-09-30 15:33:39',NULL,'40210270-1b0e-461b-a5aa-319d69ea7819'),(2,'craft\\elements\\GlobalSet','2018-10-08 23:42:03','2018-10-08 23:48:12',NULL,'54e4880b-8f72-49a9-8732-0bacdc5c96b7'),(3,'craft\\elements\\Asset','2018-10-08 23:46:31','2018-10-08 23:46:31','2019-01-27 18:19:02','06fbf1cf-6c60-49ab-9fc6-e1d9640c01bc'),(5,'craft\\elements\\Entry','2018-10-08 23:53:17','2019-02-05 02:34:16',NULL,'d54ded79-c194-433a-ab8f-688521561942'),(6,'craft\\elements\\Entry','2018-10-09 00:13:24','2019-01-27 18:17:45',NULL,'416230ab-5b37-4f4c-8ede-32e9fba6164b'),(7,'craft\\elements\\Entry','2018-10-10 23:42:21','2018-12-30 16:32:20',NULL,'50e9b4f2-ddf3-409f-be4f-cd314baaee51'),(8,'craft\\elements\\Entry','2018-11-02 01:16:09','2019-02-09 21:36:20',NULL,'e9678a4c-360c-483a-a91f-9dff15e607c8'),(9,'craft\\elements\\MatrixBlock','2018-11-02 02:34:57','2019-01-17 02:45:24',NULL,'bbb4f2b3-f970-48bc-b558-4c21dcf0d911'),(10,'craft\\elements\\MatrixBlock','2018-12-08 01:29:41','2019-01-17 02:45:24',NULL,'6d5c94c9-83a9-4be7-af5f-8189aeb32f4c'),(11,'craft\\elements\\Entry','2018-12-17 01:13:58','2018-12-30 16:10:48',NULL,'fbe40f7a-faae-4d94-b250-3f1c367c966e'),(15,'craft\\elements\\GlobalSet','2018-12-30 16:43:46','2019-01-02 00:46:22',NULL,'160be074-78ff-4339-b327-91a2f57bf793'),(17,'craft\\elements\\Entry','2019-01-02 01:08:25','2019-01-02 01:15:39',NULL,'dbb7b849-058e-4556-8ed1-440fed40ef31'),(18,'craft\\elements\\MatrixBlock','2019-01-02 01:11:47','2019-01-21 18:21:58',NULL,'5ea35531-4f32-434f-8ab9-27d853b46432'),(19,'craft\\elements\\MatrixBlock','2019-01-23 02:50:14','2019-01-23 02:57:52',NULL,'8e770b24-247e-49ec-978f-1cbe2a2d8bec'),(20,'craft\\elements\\Entry','2019-01-23 02:50:36','2019-01-23 03:04:05',NULL,'5a96d75b-bcb5-45a8-b004-87efea6204ec'),(21,'craft\\elements\\MatrixBlock','2019-01-23 03:03:52','2019-01-23 03:03:52',NULL,'e2264f39-c7a9-4baa-b4a8-e1add7ff7a89'),(22,'craft\\elements\\GlobalSet','2019-01-27 18:29:04','2019-01-27 18:29:22',NULL,'928d3988-5927-4713-b134-fad5ce7b6342'),(23,'craft\\elements\\MatrixBlock','2019-02-05 02:31:48','2019-02-05 02:31:48',NULL,'cae6135c-cb59-4d08-9d85-52480a4f917a'),(24,'craft\\elements\\MatrixBlock','2019-02-10 01:29:56','2019-02-10 01:29:56',NULL,'03ec905a-edcb-49cf-a232-cd75003091e0'),(25,'craft\\elements\\Entry','2019-02-10 01:30:11','2019-02-10 01:30:11',NULL,'8819c6cc-ba36-4a84-a478-2f87ee9c27ab'),(26,'Solspace\\Calendar\\Elements\\Event','2019-03-24 19:31:49','2019-05-11 14:04:29',NULL,'7b68b9e8-ea8a-45cb-b944-0074ba309fbd'),(27,'craft\\elements\\MatrixBlock','2019-05-11 14:18:41','2019-05-11 14:18:41','2019-05-11 14:36:35','af8e9032-6fa4-404c-a256-a67f34db9327'),(28,'craft\\elements\\Entry','2019-05-11 14:19:15','2019-05-11 14:33:41',NULL,'34393a6d-219e-4b6f-bf64-e4fe179d6970'),(29,'craft\\elements\\MatrixBlock','2019-05-11 14:33:22','2019-05-11 14:33:22','2019-05-11 14:36:13','b50d3198-50ba-432c-bb1d-d1ad897228e0'),(30,'craft\\elements\\Entry','2019-05-11 14:35:41','2019-05-11 14:35:41',NULL,'b1453ee0-13ac-4ef2-86f6-7ad0bb193ba4'),(31,'craft\\elements\\MatrixBlock','2019-05-11 14:36:36','2019-05-11 14:36:36',NULL,'ef8c2f7d-a520-47b0-893c-c81cf5833442');
/*!40000 ALTER TABLE `acr_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldlayouttabs`
--

LOCK TABLES `acr_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `acr_fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fieldlayouttabs` VALUES (1,1,'Registration',1,'2018-09-30 15:33:39','2018-09-30 15:33:39','edf45c2a-0266-4d40-adcc-71c41c433b89'),(2,2,'General Site Information',1,'2018-10-08 23:48:12','2018-10-08 23:48:12','0b0b9220-5011-4fe9-97f0-a1112fccd5e7'),(20,11,'Testimonial Content',1,'2018-12-30 16:10:48','2018-12-30 16:10:48','bbe87f5e-aace-4f1a-becf-d805793abbba'),(21,7,'Services',1,'2018-12-30 16:32:20','2018-12-30 16:32:20','0cbf05d0-3fe6-46c2-bb87-e6b2d7d764e5'),(22,7,'50/50 Section',2,'2018-12-30 16:32:20','2018-12-30 16:32:20','097ba52b-eecd-4e54-86bc-8e22eed43e55'),(23,7,'Newsletter',3,'2018-12-30 16:32:20','2018-12-30 16:32:20','c0dad566-77f7-4860-acce-74f7257788a1'),(28,15,'General',1,'2019-01-02 00:46:22','2019-01-02 00:46:22','bce2e1bc-8ad7-4ec3-9bec-449ffa49d891'),(29,15,'Links',2,'2019-01-02 00:46:22','2019-01-02 00:46:22','b29a6940-60b7-4bdb-9cb8-31d095fe55cf'),(33,17,'Locations Listing',1,'2019-01-02 01:15:39','2019-01-02 01:15:39','b23fc828-c980-4cc5-be49-59298910c307'),(38,9,'Content',1,'2019-01-17 02:45:24','2019-01-17 02:45:24','10ca28cf-afad-4feb-8fa7-63483ce54c64'),(39,10,'Content',1,'2019-01-17 02:45:24','2019-01-17 02:45:24','7ce805f0-9127-4f2e-90fb-589499e58e00'),(41,18,'Content',1,'2019-01-21 18:21:58','2019-01-21 18:21:58','d8fc9c95-b1dd-46e6-bc62-aedfbc978b5a'),(44,19,'Content',1,'2019-01-23 02:57:52','2019-01-23 02:57:52','d8a43a64-27f0-40de-98ad-dd19e0121487'),(45,21,'Content',1,'2019-01-23 03:03:52','2019-01-23 03:03:52','9754dfae-142b-452d-bd1d-08322728fabb'),(46,20,'Initiatives',1,'2019-01-23 03:04:05','2019-01-23 03:04:05','f9a25e47-c053-4b60-bfc1-248283e17b2a'),(48,6,'Settings',1,'2019-01-27 18:17:45','2019-01-27 18:17:45','04147e39-e982-4d70-9dd0-b17a5b96b0c2'),(50,22,'Settings',1,'2019-01-27 18:29:22','2019-01-27 18:29:22','abeaab63-5395-40e3-a751-b230ffe6fb58'),(51,23,'Content',1,'2019-02-05 02:31:48','2019-02-05 02:31:48','ad81caf0-b7f3-4ee3-83ff-adb4499aa519'),(52,5,'Culture Survey',1,'2019-02-05 02:34:16','2019-02-05 02:34:16','e62605d3-c7c3-43d3-a3c4-9785959b02a8'),(53,8,'Notification Information',1,'2019-02-09 21:36:20','2019-02-09 21:36:20','1e57c6b6-023f-41ff-ac29-96f1ffd31953'),(54,24,'Content',1,'2019-02-10 01:29:56','2019-02-10 01:29:56','20efff54-01e1-4b51-90f1-f5ed7badb1e4'),(55,25,'Vendors',1,'2019-02-10 01:30:11','2019-02-10 01:30:11','f53942d5-69bb-4842-8934-c849283041f7'),(61,26,'Registration Form',1,'2019-05-11 14:04:29','2019-05-11 14:04:29','60d446d4-e07c-40cc-b070-71d92e8c26e3'),(62,27,'Content',1,'2019-05-11 14:18:41','2019-05-11 14:18:41','a73a1cb7-4f96-4a66-9710-37933e646e1a'),(64,29,'Content',1,'2019-05-11 14:33:22','2019-05-11 14:33:22','87b2ea1c-efcb-4765-b09f-44658c3778aa'),(65,28,'Scholarship Years',1,'2019-05-11 14:33:41','2019-05-11 14:33:41','02921b0c-97a2-41f0-aa09-05c605ca1215'),(66,30,'Year Recipients',1,'2019-05-11 14:35:41','2019-05-11 14:35:41','bbdfdd6e-0c66-4c21-93ad-2e850f2054fb'),(67,31,'Content',1,'2019-05-11 14:36:36','2019-05-11 14:36:36','61c8d125-be89-4c08-8633-fc9aa3cc4dbe');
/*!40000 ALTER TABLE `acr_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fields`
--

LOCK TABLES `acr_fields` WRITE;
/*!40000 ALTER TABLE `acr_fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fields` VALUES (2,1,'Single Image','singleImage','global','Add a single image to the page.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"singleUploadLocationSubpath\":\"promotions\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an image\",\"localizeRelations\":false}','2018-10-08 23:47:50','2019-01-27 17:54:12','f988b15f-c79d-4498-8900-22b3859c00cc'),(4,1,'Page Link','pageLink','global','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"3\":\"entry\",\"4\":\"site\",\"7\":\"email\",\"8\":\"tel\",\"9\":\"url\"},\"allowTarget\":\"1\",\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAriaLabel\":\"1\",\"enableTitle\":\"1\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-10-09 00:15:41','2018-10-09 00:15:41','a207db43-6f70-4166-9f80-4694e159fd67'),(6,3,'Notification Text','notificationText','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-02 01:19:37','2018-11-02 01:19:37','6ecf8a37-13bc-46bc-afd1-e9505338259d'),(7,3,'Notification Link','notificationLink','global','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"3\":\"entry\",\"9\":\"url\"},\"allowTarget\":\"1\",\"defaultLinkName\":\"url\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-11-02 01:20:22','2018-11-02 01:20:22','e7ff456f-d45d-43e0-bc06-9c9ffe9468f2'),(10,5,'Title','servicesTitle','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-02 02:28:06','2018-11-02 02:28:06','d1e02aa7-b33b-49c4-a198-dae3f462e65a'),(11,5,'Description','servicesDescription','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-02 02:28:15','2018-11-02 02:28:15','a07789b8-1f0d-4fae-ac9c-52f01e112769'),(12,5,'Services','services','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"1\",\"maxBlocks\":\"6\",\"contentTable\":\"{{%matrixcontent_services}}\",\"localizeBlocks\":false}','2018-11-02 02:34:57','2018-11-02 02:34:57','a4ac9646-eeb8-4757-99be-592e59cf2acb'),(13,NULL,'Title','serviceTitle','matrixBlockType:ad0dc2b4-7b01-48f6-9596-8c8dad66a4b1','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-02 02:34:57','2019-01-17 02:45:23','54f564b2-6d31-46e7-a148-ca738ab72142'),(14,NULL,'Description','serviceDescription','matrixBlockType:ad0dc2b4-7b01-48f6-9596-8c8dad66a4b1','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-02 02:34:57','2019-01-17 02:45:23','28cf2be5-8f7e-4677-b055-7b02264a5217'),(15,NULL,'Link','serviceLink','matrixBlockType:ad0dc2b4-7b01-48f6-9596-8c8dad66a4b1','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"3\":\"entry\",\"9\":\"url\"},\"allowTarget\":\"\",\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-11-02 02:34:57','2019-01-17 02:45:24','2e5417ea-9053-4e0f-9f16-0301f26dcf2a'),(16,7,'CTAs','ctas','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_ctas}}\",\"localizeBlocks\":false}','2018-12-08 01:29:41','2018-12-08 01:55:43','f4c519dd-a990-40e1-a0c9-696bbe1ab8fc'),(17,NULL,'Call to Action Title','callToActionTitle','matrixBlockType:a18a4a20-6a90-4d48-8995-8ab7941dcc11','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-08 01:29:41','2019-01-17 02:45:24','3dee8338-1e08-4d25-bdde-b00ee509d056'),(18,NULL,'Description','callToActionDescription','matrixBlockType:a18a4a20-6a90-4d48-8995-8ab7941dcc11','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-08 01:29:41','2019-01-17 02:45:24','fce33d4d-1efd-4868-8cbe-9f00ddbb8fa6'),(19,NULL,'Image','callToActionImage','matrixBlockType:a18a4a20-6a90-4d48-8995-8ab7941dcc11','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-12-08 01:29:41','2019-01-17 02:45:24','9938542d-a4f6-4f92-96a8-c8bcc7818139'),(20,NULL,'Background Color','callToActionBackgroundColor','matrixBlockType:a18a4a20-6a90-4d48-8995-8ab7941dcc11','',1,'none',NULL,'craft\\fields\\RadioButtons','{\"options\":[{\"label\":\"Red\",\"value\":\"red\",\"default\":\"\"},{\"label\":\"Blue\",\"value\":\"blue\",\"default\":\"\"}]}','2018-12-08 01:32:38','2019-01-17 02:45:24','93c4bbd8-db6c-4a65-987f-b31e3462b6c4'),(22,NULL,'Link','callToActionLink','matrixBlockType:a18a4a20-6a90-4d48-8995-8ab7941dcc11','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"3\":\"entry\",\"4\":\"site\",\"6\":\"custom\",\"7\":\"email\",\"8\":\"tel\",\"9\":\"url\"},\"allowTarget\":\"\",\"defaultLinkName\":\"asset\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-12-08 01:43:03','2019-01-17 02:45:24','16531a44-dbf0-4400-bcdd-ecdad520a697'),(23,8,'Author','testimonialAuthor','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-30 16:09:18','2018-12-30 16:09:26','4de3e644-b5ec-4104-89c5-3449fa4175b2'),(24,8,'Content','testimonalcontent','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-30 16:09:57','2018-12-30 16:11:19','06a1d088-9aea-4440-8997-c731e1282b28'),(25,9,'Image','newsletterImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an image\",\"localizeRelations\":false}','2018-12-30 16:31:40','2019-01-27 18:32:46','c56d653e-9e7d-4ef9-aa84-7ec8606d088c'),(26,9,'Title','newsletterTitle','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-30 16:31:49','2018-12-30 16:31:49','1bc2be8f-63f9-4d51-8d5c-3d07b7c84ed5'),(27,9,'Description','newsletterDescription','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-30 16:31:58','2018-12-30 16:31:58','c2b3d873-50c8-4e57-820d-6aa965f39b79'),(28,1,'External Link','externalLink','global','',1,'none',NULL,'craft\\fields\\Url','{\"placeholder\":\"\"}','2018-12-30 16:41:33','2018-12-30 16:41:54','2454409f-dfb2-45e4-b6fc-3ef708639b05'),(29,10,'Apple Store LInk','appleStoreLink','global','',1,'none',NULL,'craft\\fields\\Url','{\"placeholder\":\"\"}','2018-12-30 16:42:30','2018-12-30 16:42:30','009e6ae8-8fde-401d-a29e-784a1170ebfd'),(30,10,'Google Play Store LInk','googlePlayStoreLink','global','',1,'none',NULL,'craft\\fields\\Url','{\"placeholder\":\"\"}','2018-12-30 16:42:43','2018-12-30 16:42:43','654aca73-0f2c-4695-89ba-4bd3e6db1e42'),(31,10,'Facebook Link','facebookLink','global','',1,'none',NULL,'craft\\fields\\Url','{\"placeholder\":\"\"}','2018-12-30 16:42:55','2018-12-30 16:42:55','13e8e656-c68f-463c-86e6-b51e83c7d2a1'),(32,10,'Footer Logo','footerLogo','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-12-30 16:44:05','2019-01-17 02:45:23','d43389b3-5eea-455f-8ea2-d05f6a5ec556'),(33,10,'Footer Tagline','footerTagline','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-30 16:44:11','2018-12-30 16:44:11','877d25f5-76f5-467b-9739-03e87cdffbbe'),(34,1,'Locations','locations','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_locations}}\",\"localizeBlocks\":false}','2019-01-02 01:11:47','2019-01-21 18:21:57','ede61ed2-c66a-4d59-8ef2-a5b1f3630dda'),(35,NULL,'Name','locationName','matrixBlockType:c773ee36-d4bd-4d3c-8a25-e904a163d34e','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-02 01:11:47','2019-01-21 18:21:57','5d063c02-f819-4258-82df-5a5ec9568e0a'),(36,NULL,'Address','address','matrixBlockType:c773ee36-d4bd-4d3c-8a25-e904a163d34e','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-02 01:11:47','2019-01-21 18:21:57','701fee08-7b80-4ba0-981f-7212238bb0d5'),(37,NULL,'Phone Number','phoneNumber','matrixBlockType:c773ee36-d4bd-4d3c-8a25-e904a163d34e','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-02 01:11:47','2019-01-21 18:21:57','cf1d4f60-e469-4979-89db-5395eeacf025'),(38,NULL,'Google Map Link','googleMapLink','matrixBlockType:c773ee36-d4bd-4d3c-8a25-e904a163d34e','',1,'none',NULL,'craft\\fields\\Url','{\"placeholder\":\"\"}','2019-01-21 18:21:58','2019-01-21 18:21:58','ecdf0853-6e09-413b-b63f-2a03ea7a9a1b'),(39,1,'ACR Cares Initiatives','acrCaresInitiatives','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_acrcaresinitiatives}}\",\"localizeBlocks\":false}','2019-01-23 02:50:14','2019-01-23 02:57:52','afceddc5-9590-4182-abf6-bb387268c36d'),(41,NULL,'Title','initiativeTitle','matrixBlockType:cd5cbfa7-0720-49c3-8c87-eca987b0e498','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-23 02:50:14','2019-01-23 02:57:52','5004af34-6543-4cb8-a1c3-157bf57abd95'),(42,NULL,'Description','initiativeDescription','matrixBlockType:cd5cbfa7-0720-49c3-8c87-eca987b0e498','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-23 02:50:14','2019-01-23 02:57:52','8c95b6b9-ce93-4231-942f-7d44e4a0d9a8'),(43,1,'Team Member Initiatives','teamMemberInitiatives','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_teammemberinitiatives}}\",\"localizeBlocks\":false}','2019-01-23 03:03:51','2019-01-23 03:03:51','68d45d5a-b25d-4eba-9741-54d6ab9ff499'),(44,NULL,'Title','initiativeTitle','matrixBlockType:3334d866-45d7-4fa3-b627-7c7470d3687a','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-23 03:03:52','2019-01-23 03:03:52','9f53424a-206a-4123-bd8f-9ab550dbf4d8'),(45,1,'Promotion Image','promotionImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"volume:98af559e-fbd3-426a-aada-0f8e6fe41d61\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:98af559e-fbd3-426a-aada-0f8e6fe41d61\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2019-01-27 18:01:17','2019-01-27 18:01:17','301600aa-e3fc-4ac2-9dfc-7b599eb1f1fc'),(46,11,'Survey Results','surveyResults','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_surveyresults}}\",\"localizeBlocks\":false}','2019-02-05 02:31:48','2019-02-05 02:31:48','b127582a-bb04-47a7-b881-1ecfd3499eac'),(47,NULL,'Result Content','resultContent','matrixBlockType:2b703ea5-e694-4433-8977-1b00f3a9259a','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-02-05 02:31:48','2019-02-05 02:31:48','0202c89c-046d-4d22-bdd2-9c933f2d13d7'),(48,12,'Vendors','vendors','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_vendors}}\",\"localizeBlocks\":false}','2019-02-10 01:29:55','2019-02-10 01:29:55','2f250de5-f055-4843-84d3-2d9f866ed888'),(49,NULL,'Vendor Name','vendorName','matrixBlockType:8cd2da25-6028-4e91-aceb-25283dbdf155','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-02-10 01:29:56','2019-02-10 01:29:56','37c33a47-e59c-4e8e-9c60-ac535f437113'),(50,NULL,'Vendor Description','vendorDescription','matrixBlockType:8cd2da25-6028-4e91-aceb-25283dbdf155','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-02-10 01:29:56','2019-02-10 01:29:56','2dff0473-bcc2-40cf-8442-78ebd5fec7e8'),(51,NULL,'Vendor Link','vendorLink','matrixBlockType:8cd2da25-6028-4e91-aceb-25283dbdf155','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"\",\"allowedLinkNames\":{\"9\":\"url\"},\"allowTarget\":\"1\",\"autoNoReferrer\":\"\",\"defaultLinkName\":\"url\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\",\"allowCustomQuery\":\"\"},\"category\":{\"sources\":\"*\",\"allowCustomQuery\":\"\"},\"entry\":{\"sources\":\"*\",\"allowCustomQuery\":\"\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\",\"allowCustomQuery\":\"\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2019-02-10 01:29:56','2019-02-10 01:29:56','110f068c-c2a8-423c-bd11-3b164f3f2bda'),(52,1,'Connected Form','connectedForm','global','',1,'none',NULL,'Solspace\\Freeform\\FieldTypes\\FormFieldType',NULL,'2019-04-24 00:29:34','2019-04-24 00:29:34','063c7f84-92b6-4c76-b1de-1d8f9a914e5e'),(53,1,'Location','location','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-04-24 01:14:47','2019-04-24 01:31:46','eb838f91-6771-4599-adec-5808e3d72e56'),(54,1,'Description','description','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-04-24 01:34:59','2019-04-24 01:34:59','53537675-602f-4e8f-bdea-81335b24c7f9'),(55,13,'Event Price','eventPrice','global','',1,'none',NULL,'craft\\fields\\Number','{\"defaultValue\":null,\"min\":\"0\",\"max\":null,\"decimals\":\"2\",\"size\":null,\"prefix\":\"$\",\"suffix\":\"\"}','2019-05-11 14:04:11','2019-05-11 14:04:11','fb1dfb25-2f79-4569-a04a-5aa6f10c823f'),(56,1,'Scholarship Recipients','scholarshipRecipients','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_scholarshiprecipients}}\",\"localizeBlocks\":false}','2019-05-11 14:18:40','2019-05-11 14:36:35','38df0a62-08cf-4dc3-9ae2-03b0b2807e2a'),(60,NULL,'Name','recipientName','matrixBlockType:ccfa9a8b-8bbd-4c93-b9ef-437d2260aa8f','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-05-11 14:36:36','2019-05-11 14:36:36','4ee6f98c-88cc-49e8-bb1d-19b68fd9cd74');
/*!40000 ALTER TABLE `acr_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_crm_fields`
--

LOCK TABLES `acr_freeform_crm_fields` WRITE;
/*!40000 ALTER TABLE `acr_freeform_crm_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_freeform_crm_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_fields`
--

LOCK TABLES `acr_freeform_fields` WRITE;
/*!40000 ALTER TABLE `acr_freeform_fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_freeform_fields` VALUES (1,'text','firstName','First Name',0,NULL,NULL,'2019-01-24 01:47:30','2019-01-24 01:47:30','0ba8b562-44f2-470d-89c6-737f68d1ad58'),(2,'text','lastName','Last Name',0,NULL,NULL,'2019-01-24 01:47:30','2019-01-24 01:47:30','ad7d7f63-bba0-4298-acd8-f8e4b66f0c48'),(3,'email','email','Email',0,NULL,NULL,'2019-01-24 01:47:30','2019-01-24 01:47:30','e9e18192-2e0e-4331-82cd-27985c44d121'),(4,'text','website','Website',0,NULL,NULL,'2019-01-24 01:47:30','2019-01-24 01:47:30','1a896aa0-3602-40c7-a190-e6fdc0c52901'),(5,'text','cellPhone','Cell Phone',0,NULL,NULL,'2019-01-24 01:47:31','2019-01-24 01:47:31','5b83a78b-c9c1-40cb-837b-1b11996733e5'),(6,'text','homePhone','Home Phone',0,NULL,NULL,'2019-01-24 01:47:31','2019-01-24 01:47:31','df8d8b6b-707d-45fd-a34f-82db34f409c2'),(7,'text','companyName','Company Name',0,NULL,NULL,'2019-01-24 01:47:31','2019-01-24 01:47:31','3c9b5cfc-7001-4f80-b0e8-984f1dc58375'),(8,'textarea','address','Address',0,NULL,'{\"rows\":2}','2019-01-24 01:47:31','2019-01-24 01:47:31','8f81a1ba-dfcb-4a37-8d9c-38ca0539e01a'),(9,'text','city','City',0,NULL,NULL,'2019-01-24 01:47:31','2019-01-24 01:47:31','d4fcb016-1619-4fc6-8e8b-0ed91af64776'),(10,'select','state','State',0,NULL,'{\"options\":[{\"value\":\"\",\"label\":\"Select a State\"},{\"value\":\"AL\",\"label\":\"Alabama\"},{\"value\":\"AK\",\"label\":\"Alaska\"},{\"value\":\"AZ\",\"label\":\"Arizona\"},{\"value\":\"AR\",\"label\":\"Arkansas\"},{\"value\":\"CA\",\"label\":\"California\"},{\"value\":\"CO\",\"label\":\"Colorado\"},{\"value\":\"CT\",\"label\":\"Connecticut\"},{\"value\":\"DE\",\"label\":\"Delaware\"},{\"value\":\"DC\",\"label\":\"District of Columbia\"},{\"value\":\"FL\",\"label\":\"Florida\"},{\"value\":\"GA\",\"label\":\"Georgia\"},{\"value\":\"HI\",\"label\":\"Hawaii\"},{\"value\":\"ID\",\"label\":\"Idaho\"},{\"value\":\"IL\",\"label\":\"Illinois\"},{\"value\":\"IN\",\"label\":\"Indiana\"},{\"value\":\"IA\",\"label\":\"Iowa\"},{\"value\":\"KS\",\"label\":\"Kansas\"},{\"value\":\"KY\",\"label\":\"Kentucky\"},{\"value\":\"LA\",\"label\":\"Louisiana\"},{\"value\":\"ME\",\"label\":\"Maine\"},{\"value\":\"MD\",\"label\":\"Maryland\"},{\"value\":\"MA\",\"label\":\"Massachusetts\"},{\"value\":\"MI\",\"label\":\"Michigan\"},{\"value\":\"MN\",\"label\":\"Minnesota\"},{\"value\":\"MS\",\"label\":\"Mississippi\"},{\"value\":\"MO\",\"label\":\"Missouri\"},{\"value\":\"MT\",\"label\":\"Montana\"},{\"value\":\"NE\",\"label\":\"Nebraska\"},{\"value\":\"NV\",\"label\":\"Nevada\"},{\"value\":\"NH\",\"label\":\"New Hampshire\"},{\"value\":\"NJ\",\"label\":\"New Jersey\"},{\"value\":\"NM\",\"label\":\"New Mexico\"},{\"value\":\"NY\",\"label\":\"New York\"},{\"value\":\"NC\",\"label\":\"North Carolina\"},{\"value\":\"ND\",\"label\":\"North Dakota\"},{\"value\":\"OH\",\"label\":\"Ohio\"},{\"value\":\"OK\",\"label\":\"Oklahoma\"},{\"value\":\"OR\",\"label\":\"Oregon\"},{\"value\":\"PA\",\"label\":\"Pennsylvania\"},{\"value\":\"RI\",\"label\":\"Rhode Island\"},{\"value\":\"SC\",\"label\":\"South Carolina\"},{\"value\":\"SD\",\"label\":\"South Dakota\"},{\"value\":\"TN\",\"label\":\"Tennessee\"},{\"value\":\"TX\",\"label\":\"Texas\"},{\"value\":\"UT\",\"label\":\"Utah\"},{\"value\":\"VT\",\"label\":\"Vermont\"},{\"value\":\"VA\",\"label\":\"Virginia\"},{\"value\":\"WA\",\"label\":\"Washington\"},{\"value\":\"WV\",\"label\":\"West Virginia\"},{\"value\":\"WI\",\"label\":\"Wisconsin\"},{\"value\":\"WY\",\"label\":\"Wyoming\"}]}','2019-01-24 01:47:31','2019-01-24 01:47:31','c881672f-c5dd-42ce-b055-9361b08e3ccf'),(11,'text','zipCode','Zip Code',0,NULL,NULL,'2019-01-24 01:47:31','2019-01-24 01:47:31','db57a941-ea08-4547-9e2f-96940952cca4'),(12,'textarea','message','Message',0,NULL,'{\"rows\":5}','2019-01-24 01:47:31','2019-01-24 01:47:31','b2bb9089-8d2d-4672-b2fe-dca29e4fc2cd'),(13,'number','number','Number',0,NULL,NULL,'2019-01-24 01:47:31','2019-01-24 01:47:31','e06159d8-8710-49ae-980e-da66e759aa8a'),(14,'select','reasonForContacting','Reason for Contacting',0,NULL,NULL,'2019-01-24 01:50:58','2019-01-24 01:50:58','873a3085-7341-4342-989d-56b97f849ab3'),(15,'textarea','comments','Comments',0,NULL,NULL,'2019-01-24 01:51:55','2019-01-24 01:51:55','6ffec7a9-d744-4b73-af8a-363f3c81a467'),(16,'text','position','Position',0,NULL,NULL,'2019-01-24 02:27:38','2019-01-24 02:27:38','fa1478fc-ddd9-4f29-87b5-e251ceae9341'),(17,'text','accountNumber','Account Number',0,NULL,NULL,'2019-01-24 02:28:01','2019-01-24 02:28:01','178084ed-a33f-4279-a9b9-02529f447a05'),(18,'textarea','shippingAddress','Shipping Address',0,NULL,NULL,'2019-01-24 02:40:02','2019-01-24 02:40:02','fe8ebd95-bce1-4f13-99b0-3c4dd0f89149'),(19,'text','dateBusinessWasEstablished','Date Business Was Established',0,NULL,NULL,'2019-01-24 02:42:26','2019-01-24 02:42:26','d78d0453-1ad5-4bf1-92d4-0e7640092a01'),(20,'dynamic_recipients','principals','Principals',0,NULL,NULL,'2019-01-24 02:42:54','2019-01-24 02:42:54','ea5c0760-42cd-453c-89ab-f9b64a4e628c'),(21,'radio_group','organizationType','Organization Type',0,NULL,NULL,'2019-01-24 02:43:42','2019-01-24 02:43:42','3b311172-d784-4789-ba31-7d774139b8f4'),(22,'radio_group','serviceFocus','Service Focus',0,NULL,NULL,'2019-01-24 02:44:52','2019-01-24 02:44:52','06ab0618-a53f-466d-b0c2-dd08710cbd3c'),(23,'text','accountsPayableContactPhone','accountsPayableContactPhone',0,NULL,NULL,'2019-01-24 02:47:39','2019-01-24 02:47:39','1d68842a-78f5-4b88-bcf2-eaedb85cd870'),(24,'email','accountsPayableContactEmail','Accounts Payable Contact Email',0,NULL,NULL,'2019-01-24 02:48:07','2019-01-24 02:48:07','7213f3ab-32d1-4455-a14a-7b85c78c9090'),(25,'text','accountsPayableContactFax','Accounts Payable Contact Fax',0,NULL,NULL,'2019-01-24 02:48:35','2019-01-24 02:48:35','90d5f05c-837b-45c4-9382-a14c87874ad5'),(27,'radio_group','doYouRequirePurchaseOrderNumbersForPurchases','Do you require purchase order numbers for purchases?',0,NULL,NULL,'2019-01-24 02:50:03','2019-01-24 02:50:03','ac2325c9-8399-4355-8c82-ffdfe0ef4fef'),(28,'radio_group','areYouTaxExemptE595E','Are you tax exempt? (E-595E)',0,NULL,NULL,'2019-01-24 02:50:30','2019-01-24 02:50:30','5d519aa5-f5dd-407b-b998-adae0afdf10c'),(29,'text','salesTaxNumber','Sales Tax Number',0,NULL,NULL,'2019-01-24 02:50:51','2019-01-24 02:50:51','276982e1-2722-4220-9d8e-43a918e32490'),(30,'radio_group','wouldYouBeInterestedInShoppingOnOurEStore','Would you be interested in shopping on our E-Store?',0,NULL,NULL,'2019-01-24 02:51:10','2019-01-24 02:51:10','84f1e21c-046f-41ed-ac83-b8019fb0ca5a'),(31,'radio_group','aCRSupplyLocation','ACR Supply Location',0,NULL,NULL,'2019-01-24 02:51:33','2019-01-24 02:51:33','9a7abb96-1acf-4a80-8ad0-198664e57f85'),(32,'radio_group','invoiceDeliveryPreference','Invoice Delivery Preference',0,NULL,NULL,'2019-01-24 02:52:39','2019-01-24 02:52:39','fba6e881-222b-4e41-881f-cfc2015a31b6'),(33,'textarea','references','References',0,NULL,NULL,'2019-01-24 03:00:57','2019-01-24 03:00:57','2963069d-e3ac-4cf2-bca8-40729c7df6e8');
/*!40000 ALTER TABLE `acr_freeform_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_forms`
--

LOCK TABLES `acr_freeform_forms` WRITE;
/*!40000 ALTER TABLE `acr_freeform_forms` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_freeform_forms` VALUES (1,'Contact Form','contactForm',0,'{{ dateCreated|date(\"Y-m-d H:i:s\") }}','','{\"composer\":{\"layout\":[[{\"id\":\"DqvAAWGd9\",\"columns\":[\"8oWe9jZpP\",\"5KM0OK02p\"]},{\"id\":\"pqOLL6Pnr\",\"columns\":[\"d1EeG8Z68\"]},{\"id\":\"DqvAAWvmV\",\"columns\":[\"mgEePYZor\"]},{\"id\":\"WrP779pkb\",\"columns\":[\"Bb10jE4K3\"]},{\"id\":\"pqOLL7j8R\",\"columns\":[\"pqOLL7j8R\"]}]],\"properties\":{\"page0\":{\"type\":\"page\",\"label\":\"Page 1\"},\"form\":{\"type\":\"form\",\"name\":\"Contact Form\",\"handle\":\"contactForm\",\"color\":\"#7303f9\",\"submissionTitleFormat\":\"{{ dateCreated|date(\\\"Y-m-d H:i:s\\\") }}\",\"description\":\"\",\"formTemplate\":\"grid.html\",\"returnUrl\":\"\",\"storeData\":true,\"defaultStatus\":2},\"integration\":{\"type\":\"integration\",\"integrationId\":0,\"mapping\":[]},\"connections\":{\"type\":\"connections\",\"list\":null},\"rules\":{\"type\":\"rules\",\"list\":[]},\"admin_notifications\":{\"type\":\"admin_notifications\",\"notificationId\":0,\"recipients\":\"\"},\"payment\":{\"type\":\"payment\",\"integrationId\":0,\"mapping\":[]},\"8oWe9jZpP\":{\"hash\":\"8oWe9jZpP\",\"id\":1,\"type\":\"text\",\"handle\":\"firstName\",\"label\":\"First Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"5KM0OK02p\":{\"hash\":\"5KM0OK02p\",\"id\":2,\"type\":\"text\",\"handle\":\"lastName\",\"label\":\"Last Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"d1EeG8Z68\":{\"hash\":\"d1EeG8Z68\",\"id\":3,\"type\":\"email\",\"handle\":\"email\",\"label\":\"Email\",\"required\":true,\"instructions\":\"\",\"notificationId\":0,\"values\":[],\"placeholder\":\"\"},\"mgEePYZor\":{\"hash\":\"mgEePYZor\",\"id\":14,\"type\":\"select\",\"handle\":\"reasonForContacting\",\"label\":\"Reason for Contacting\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"General Questions\",\"options\":[{\"label\":\"General Questions\",\"value\":\"General Questions\"},{\"label\":\"Engineering Solutions\",\"value\":\"Engineering Solutions\"},{\"label\":\"Comment or Feedback\",\"value\":\"Comment or Feedback\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"values\":[]},\"Bb10jE4K3\":{\"hash\":\"Bb10jE4K3\",\"id\":15,\"type\":\"textarea\",\"handle\":\"comments\",\"label\":\"Comments\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"pqOLL7j8R\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"}}},\"context\":{\"page\":0,\"hash\":\"form\"}}','',2,NULL,'#7303f9',NULL,'2019-01-24 01:52:16','2019-01-24 01:54:20','5f436f3d-8963-4453-80e9-b847e3fef09a'),(2,'E-Store Account Request Form','eStoreAccountRequestForm',0,'{{ dateCreated|date(\"Y-m-d H:i:s\") }}','','{\"composer\":{\"layout\":[[{\"id\":\"15rWWp9rP\",\"columns\":[\"8oWe9jZpP\",\"5KM0OK02p\"]},{\"id\":\"Bm211nxwn\",\"columns\":[\"AV34dy07p\",\"d1EeG8Z68\"]},{\"id\":\"RqA11VRjA\",\"columns\":[\"1wq0WR4bD\",\"Va34kjZPq\"]},{\"id\":\"rM3LLBPlV\",\"columns\":[\"EGv0Y2ed7\"]},{\"id\":\"ndwLL8KqD\",\"columns\":[\"KNn41Q4x3\"]},{\"id\":\"LLG99D22a\",\"columns\":[\"DBk0Xw4YJ\"]},{\"id\":\"bvNyyAEva\",\"columns\":[\"Bb10jE4K3\"]},{\"id\":\"P21kkJAxN\",\"columns\":[\"rM3LLrAB6\"]}]],\"properties\":{\"page0\":{\"type\":\"page\",\"label\":\"Page 1\"},\"form\":{\"type\":\"form\",\"name\":\"E-Store Account Request Form\",\"handle\":\"eStoreAccountRequestForm\",\"color\":\"#5727dc\",\"submissionTitleFormat\":\"{{ dateCreated|date(\\\"Y-m-d H:i:s\\\") }}\",\"description\":\"\",\"formTemplate\":\"grid.html\",\"returnUrl\":\"\",\"storeData\":true,\"defaultStatus\":2},\"integration\":{\"type\":\"integration\",\"integrationId\":0,\"mapping\":[]},\"connections\":{\"type\":\"connections\",\"list\":null},\"rules\":{\"type\":\"rules\",\"list\":[]},\"admin_notifications\":{\"type\":\"admin_notifications\",\"notificationId\":0,\"recipients\":\"\"},\"payment\":{\"type\":\"payment\",\"integrationId\":0,\"mapping\":[]},\"8oWe9jZpP\":{\"hash\":\"8oWe9jZpP\",\"id\":1,\"type\":\"text\",\"handle\":\"firstName\",\"label\":\"First Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"5KM0OK02p\":{\"hash\":\"5KM0OK02p\",\"id\":2,\"type\":\"text\",\"handle\":\"lastName\",\"label\":\"Last Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"AV34dy07p\":{\"hash\":\"AV34dy07p\",\"id\":16,\"type\":\"text\",\"handle\":\"position\",\"label\":\"Position\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"d1EeG8Z68\":{\"hash\":\"d1EeG8Z68\",\"id\":3,\"type\":\"email\",\"handle\":\"email\",\"label\":\"Email\",\"required\":true,\"instructions\":\"\",\"notificationId\":0,\"values\":[],\"placeholder\":\"\"},\"DBk0Xw4YJ\":{\"hash\":\"DBk0Xw4YJ\",\"id\":17,\"type\":\"text\",\"handle\":\"accountNumber\",\"label\":\"Account Number\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"inputAttributes\":[]},\"KNn41Q4x3\":{\"hash\":\"KNn41Q4x3\",\"id\":7,\"type\":\"text\",\"handle\":\"companyName\",\"label\":\"Company Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"1wq0WR4bD\":{\"hash\":\"1wq0WR4bD\",\"id\":6,\"type\":\"text\",\"handle\":\"phone\",\"label\":\"Phone\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"Va34kjZPq\":{\"hash\":\"Va34kjZPq\",\"id\":5,\"type\":\"text\",\"handle\":\"fax\",\"label\":\"Fax\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"EGv0Y2ed7\":{\"hash\":\"EGv0Y2ed7\",\"id\":8,\"type\":\"textarea\",\"handle\":\"address\",\"label\":\"Address\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"Bb10jE4K3\":{\"hash\":\"Bb10jE4K3\",\"id\":15,\"type\":\"textarea\",\"handle\":\"comments\",\"label\":\"Comments\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"rM3LLrAB6\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"}}},\"context\":{\"page\":0,\"hash\":\"EGv0Y2ed7\"}}','',2,NULL,'#5727dc',NULL,'2019-01-24 02:27:05','2019-01-24 02:33:33','dab224ac-cbf3-4829-941e-b98338a57f53'),(3,'E-Store Credit Application Form','eStoreCreditApplicationForm',0,'{{ dateCreated|date(\"Y-m-d H:i:s\") }}','','{\"composer\":{\"layout\":[[{\"id\":\"P21kLqrnq\",\"columns\":[\"KNn41Q4x3\"]},{\"id\":\"OkW3NKYa7\",\"columns\":[\"EGv0Y2ed7\"]},{\"id\":\"RqA1NbRxB\",\"columns\":[\"VgLeAg426\",\"jDMZQLe3y\",\"A21ZpweEr\"]},{\"id\":\"GRy7KRWvm\",\"columns\":[\"gGp461ZwQ\"]},{\"id\":\"91RPMEEEK\",\"columns\":[\"1wq0WR4bD\",\"Va34kjZPq\"]},{\"id\":\"XzjrwoAvo\",\"columns\":[\"d1EeG8Z68\"]},{\"id\":\"dvBy7PqJp\",\"columns\":[\"Jvb4m946X\"]},{\"id\":\"Aj5WMVlEL\",\"columns\":[\"qlRZRw4XA\"]},{\"id\":\"jRlyxMjEM\",\"columns\":[\"dV8ZM8eob\"]},{\"id\":\"rM3LxOpJx\",\"columns\":[\"Nlj0BV07x\"]},{\"id\":\"jRlyxnVjb\",\"columns\":[\"gB1enGZYl\"]},{\"id\":\"E2lQMGq2w\",\"columns\":[\"vAoe5ye6P\"]},{\"id\":\"yqpzKlAY1\",\"columns\":[\"2yV42xeLY\"]},{\"id\":\"91RPMBG9E\",\"columns\":[\"N5r0JM4Xa\"]},{\"id\":\"gR2yjOzyg\",\"columns\":[\"arWeva0vy\"]},{\"id\":\"jRlyxbMQ1\",\"columns\":[\"N6n0lVZGa\"]},{\"id\":\"qlGKxkrVP\",\"columns\":[\"qlGKxkrVP\"]}]],\"properties\":{\"page0\":{\"type\":\"page\",\"label\":\"Page 1\"},\"form\":{\"type\":\"form\",\"name\":\"E-Store Credit Application Form\",\"handle\":\"eStoreCreditApplicationForm\",\"color\":\"#1e5385\",\"submissionTitleFormat\":\"{{ dateCreated|date(\\\"Y-m-d H:i:s\\\") }}\",\"description\":\"\",\"formTemplate\":\"grid.html\",\"returnUrl\":\"\",\"storeData\":true,\"defaultStatus\":2},\"integration\":{\"type\":\"integration\",\"integrationId\":0,\"mapping\":[]},\"connections\":{\"type\":\"connections\",\"list\":null},\"rules\":{\"type\":\"rules\",\"list\":[]},\"admin_notifications\":{\"type\":\"admin_notifications\",\"notificationId\":0,\"recipients\":\"\"},\"payment\":{\"type\":\"payment\",\"integrationId\":0,\"mapping\":[]},\"KNn41Q4x3\":{\"hash\":\"KNn41Q4x3\",\"id\":7,\"type\":\"text\",\"handle\":\"companyName\",\"label\":\"Company Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"EGv0Y2ed7\":{\"hash\":\"EGv0Y2ed7\",\"id\":8,\"type\":\"textarea\",\"handle\":\"mailingAddress\",\"label\":\"Mailing Address\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"VgLeAg426\":{\"hash\":\"VgLeAg426\",\"id\":9,\"type\":\"text\",\"handle\":\"mailingAddressCity\",\"label\":\"City\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"jDMZQLe3y\":{\"hash\":\"jDMZQLe3y\",\"id\":10,\"type\":\"select\",\"handle\":\"mailingAddressState\",\"label\":\"State\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":true,\"value\":\"\",\"options\":[{\"value\":\"\",\"label\":\"Select a State\"},{\"value\":\"AL\",\"label\":\"Alabama\"},{\"value\":\"AK\",\"label\":\"Alaska\"},{\"value\":\"AZ\",\"label\":\"Arizona\"},{\"value\":\"AR\",\"label\":\"Arkansas\"},{\"value\":\"CA\",\"label\":\"California\"},{\"value\":\"CO\",\"label\":\"Colorado\"},{\"value\":\"CT\",\"label\":\"Connecticut\"},{\"value\":\"DE\",\"label\":\"Delaware\"},{\"value\":\"DC\",\"label\":\"District of Columbia\"},{\"value\":\"FL\",\"label\":\"Florida\"},{\"value\":\"GA\",\"label\":\"Georgia\"},{\"value\":\"HI\",\"label\":\"Hawaii\"},{\"value\":\"ID\",\"label\":\"Idaho\"},{\"value\":\"IL\",\"label\":\"Illinois\"},{\"value\":\"IN\",\"label\":\"Indiana\"},{\"value\":\"IA\",\"label\":\"Iowa\"},{\"value\":\"KS\",\"label\":\"Kansas\"},{\"value\":\"KY\",\"label\":\"Kentucky\"},{\"value\":\"LA\",\"label\":\"Louisiana\"},{\"value\":\"ME\",\"label\":\"Maine\"},{\"value\":\"MD\",\"label\":\"Maryland\"},{\"value\":\"MA\",\"label\":\"Massachusetts\"},{\"value\":\"MI\",\"label\":\"Michigan\"},{\"value\":\"MN\",\"label\":\"Minnesota\"},{\"value\":\"MS\",\"label\":\"Mississippi\"},{\"value\":\"MO\",\"label\":\"Missouri\"},{\"value\":\"MT\",\"label\":\"Montana\"},{\"value\":\"NE\",\"label\":\"Nebraska\"},{\"value\":\"NV\",\"label\":\"Nevada\"},{\"value\":\"NH\",\"label\":\"New Hampshire\"},{\"value\":\"NJ\",\"label\":\"New Jersey\"},{\"value\":\"NM\",\"label\":\"New Mexico\"},{\"value\":\"NY\",\"label\":\"New York\"},{\"value\":\"NC\",\"label\":\"North Carolina\"},{\"value\":\"ND\",\"label\":\"North Dakota\"},{\"value\":\"OH\",\"label\":\"Ohio\"},{\"value\":\"OK\",\"label\":\"Oklahoma\"},{\"value\":\"OR\",\"label\":\"Oregon\"},{\"value\":\"PA\",\"label\":\"Pennsylvania\"},{\"value\":\"RI\",\"label\":\"Rhode Island\"},{\"value\":\"SC\",\"label\":\"South Carolina\"},{\"value\":\"SD\",\"label\":\"South Dakota\"},{\"value\":\"TN\",\"label\":\"Tennessee\"},{\"value\":\"TX\",\"label\":\"Texas\"},{\"value\":\"UT\",\"label\":\"Utah\"},{\"value\":\"VT\",\"label\":\"Vermont\"},{\"value\":\"VA\",\"label\":\"Virginia\"},{\"value\":\"WA\",\"label\":\"Washington\"},{\"value\":\"WV\",\"label\":\"West Virginia\"},{\"value\":\"WI\",\"label\":\"Wisconsin\"},{\"value\":\"WY\",\"label\":\"Wyoming\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"values\":[]},\"A21ZpweEr\":{\"hash\":\"A21ZpweEr\",\"id\":11,\"type\":\"text\",\"handle\":\"mailingAddressZipCode\",\"label\":\"Zip Code\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"gGp461ZwQ\":{\"hash\":\"gGp461ZwQ\",\"id\":18,\"type\":\"textarea\",\"handle\":\"shippingAddress\",\"label\":\"Shipping Address\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"1wq0WR4bD\":{\"hash\":\"1wq0WR4bD\",\"id\":6,\"type\":\"text\",\"handle\":\"phone\",\"label\":\"Phone\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"d1EeG8Z68\":{\"hash\":\"d1EeG8Z68\",\"id\":3,\"type\":\"email\",\"handle\":\"email\",\"label\":\"Email\",\"required\":true,\"instructions\":\"\",\"notificationId\":0,\"values\":[],\"placeholder\":\"\"},\"Va34kjZPq\":{\"hash\":\"Va34kjZPq\",\"id\":5,\"type\":\"text\",\"handle\":\"fax\",\"label\":\"Fax\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"Jvb4m946X\":{\"hash\":\"Jvb4m946X\",\"id\":19,\"type\":\"text\",\"handle\":\"dateBusinessWasEstablished\",\"label\":\"Date Business Was Established\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"qlRZRw4XA\":{\"id\":21,\"hash\":\"qlRZRw4XA\",\"type\":\"radio_group\",\"handle\":\"organizationType\",\"label\":\"Organization Type\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Corporation\",\"options\":[{\"label\":\"Corporation\",\"value\":\"Corporation\"},{\"label\":\"Partnership\",\"value\":\"Partnership\"},{\"label\":\"Individual\",\"value\":\"Individual\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"values\":[],\"oneLine\":true},\"dV8ZM8eob\":{\"id\":22,\"hash\":\"dV8ZM8eob\",\"type\":\"radio_group\",\"handle\":\"serviceFocus\",\"label\":\"Service Focus\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Distributor\",\"options\":[{\"label\":\"Distributor\",\"value\":\"Distributor\"},{\"label\":\"Buying Group\",\"value\":\"Buying Group\"},{\"label\":\"Building Automation DDC\",\"value\":\"Building Automation DDC\"},{\"label\":\"C Stores \\/ Food Services\",\"value\":\"C Stores \\/ Food Services\"},{\"label\":\"Commercial Refrigeration\",\"value\":\"Commercial Refrigeration\"},{\"label\":\"Commercial HVAC\",\"value\":\"Commercial HVAC\"},{\"label\":\"Hydronics \\/ Plumbing Contractors\",\"value\":\"Hydronics \\/ Plumbing Contractors\"},{\"label\":\"Industrial \\/ Electrical\",\"value\":\"Industrial \\/ Electrical\"},{\"label\":\"Institutional \\/ Health Care\",\"value\":\"Institutional \\/ Health Care\"},{\"label\":\"Municipalities \\/ Governmental\",\"value\":\"Municipalities \\/ Governmental\"},{\"label\":\"OEM \\/ End Users\",\"value\":\"OEM \\/ End Users\"},{\"label\":\"Residential HVAC\",\"value\":\"Residential HVAC\"},{\"label\":\"Supermarket Contractors\",\"value\":\"Supermarket Contractors\"},{\"label\":\"Supermarkets\",\"value\":\"Supermarkets\"},{\"label\":\"Universities \\/ Schools\",\"value\":\"Universities \\/ Schools\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"values\":[],\"oneLine\":false},\"Nlj0BV07x\":{\"id\":27,\"hash\":\"Nlj0BV07x\",\"type\":\"radio_group\",\"handle\":\"doYouRequirePurchaseOrderNumbersForPurchases\",\"label\":\"Do you require purchase order numbers for purchases?\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Yes\",\"options\":[{\"label\":\"Yes\",\"value\":\"Yes\"},{\"label\":\"No\",\"value\":\"No\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"oneLine\":true},\"gB1enGZYl\":{\"id\":28,\"hash\":\"gB1enGZYl\",\"type\":\"radio_group\",\"handle\":\"areYouTaxExemptE595E\",\"label\":\"Are you tax exempt? (E-595E)\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Yes\",\"options\":[{\"label\":\"Yes\",\"value\":\"Yes\"},{\"label\":\"No\",\"value\":\"No\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"oneLine\":true},\"vAoe5ye6P\":{\"id\":29,\"hash\":\"vAoe5ye6P\",\"type\":\"text\",\"handle\":\"salesTaxNumber\",\"label\":\"Sales Tax Number\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"2yV42xeLY\":{\"id\":30,\"hash\":\"2yV42xeLY\",\"type\":\"radio_group\",\"handle\":\"wouldYouBeInterestedInShoppingOnOurEStore\",\"label\":\"Would you be interested in shopping on our E-Store?\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Yes\",\"options\":[{\"label\":\"Yes\",\"value\":\"Yes\"},{\"label\":\"No\",\"value\":\"No\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"oneLine\":true},\"N5r0JM4Xa\":{\"id\":31,\"hash\":\"N5r0JM4Xa\",\"type\":\"radio_group\",\"handle\":\"aCRSupplyLocation\",\"label\":\"ACR Supply Location\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Durham\",\"options\":[{\"label\":\"Durham\",\"value\":\"Durham\"},{\"label\":\"Carrboro\",\"value\":\"Carrboro\"},{\"label\":\"Burlington\",\"value\":\"Burlington\"},{\"label\":\"Greensboro\",\"value\":\"Greensboro\"},{\"label\":\"Raleigh\",\"value\":\"Raleigh\"},{\"label\":\"Winston-Salem\",\"value\":\"Winston-Salem\"},{\"label\":\"Greenville\",\"value\":\"Greenville\"},{\"label\":\"Wilmington\",\"value\":\"Wilmington\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"values\":[]},\"arWeva0vy\":{\"id\":32,\"hash\":\"arWeva0vy\",\"type\":\"radio_group\",\"handle\":\"invoiceDeliveryPreference\",\"label\":\"Invoice Delivery Preference\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Email\",\"options\":[{\"label\":\"Email\",\"value\":\"Email\"},{\"label\":\"Fax\",\"value\":\"Fax\"},{\"label\":\"No invoice copies, Statements only\",\"value\":\"No invoice copies, Statements only\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"oneLine\":true,\"values\":[]},\"N6n0lVZGa\":{\"id\":33,\"hash\":\"N6n0lVZGa\",\"type\":\"textarea\",\"handle\":\"references\",\"label\":\"References\",\"required\":false,\"instructions\":\"Please add a minimum of 3 references.\\n\\nPlease give full name and address of businesses where you have purchased goods using an open account.\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2,\"instructionAttributes\":[{\"attribute\":\"class\",\"value\":\"input-description\"}]},\"qlGKxkrVP\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"}}},\"context\":{\"page\":0,\"hash\":\"N6n0lVZGa\"}}','',2,NULL,'#1e5385',NULL,'2019-01-24 02:35:03','2019-01-24 03:02:07','3ee8975c-964e-4643-95e3-eddc04cf16e4'),(4,'Registration Test Form','registrationTestForm',0,'{{ dateCreated|date(\"Y-m-d H:i:s\") }}','','{\"composer\":{\"layout\":[[{\"id\":\"kykK3zk8x\",\"columns\":[\"8oWe9jZpP\",\"d1EeG8Z68\"]},{\"id\":\"158Mlvowy\",\"columns\":[\"EGv0Y2ed7\"]},{\"id\":\"bvxbwzA75\",\"columns\":[\"mE19pzbA9\"]}]],\"properties\":{\"page0\":{\"type\":\"page\",\"label\":\"Page 1\"},\"form\":{\"type\":\"form\",\"name\":\"Registration Test Form\",\"handle\":\"registrationTestForm\",\"color\":\"#794ff1\",\"submissionTitleFormat\":\"{{ dateCreated|date(\\\"Y-m-d H:i:s\\\") }}\",\"description\":\"\",\"formTemplate\":\"flexbox.html\",\"returnUrl\":\"\",\"storeData\":true,\"defaultStatus\":2},\"integration\":{\"type\":\"integration\",\"integrationId\":0,\"mapping\":[]},\"connections\":{\"type\":\"connections\",\"list\":null},\"rules\":{\"type\":\"rules\",\"list\":[]},\"admin_notifications\":{\"type\":\"admin_notifications\",\"notificationId\":0,\"recipients\":\"\"},\"payment\":{\"type\":\"payment\",\"integrationId\":0,\"mapping\":[]},\"EGv0Y2ed7\":{\"hash\":\"EGv0Y2ed7\",\"id\":8,\"type\":\"textarea\",\"handle\":\"address\",\"label\":\"Address\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"8oWe9jZpP\":{\"hash\":\"8oWe9jZpP\",\"id\":1,\"type\":\"text\",\"handle\":\"firstName\",\"label\":\"First Name\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"d1EeG8Z68\":{\"hash\":\"d1EeG8Z68\",\"id\":3,\"type\":\"email\",\"handle\":\"email\",\"label\":\"Email\",\"required\":false,\"instructions\":\"\",\"notificationId\":0,\"values\":[],\"placeholder\":\"\"},\"mE19pzbA9\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"}}},\"context\":{\"page\":0,\"hash\":\"form\"}}','',2,NULL,'#794ff1',NULL,'2019-04-24 00:30:51','2019-04-24 01:33:02','185b88f9-0724-4db7-a1c3-0ea6d212cf22');
/*!40000 ALTER TABLE `acr_freeform_forms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_integrations`
--

LOCK TABLES `acr_freeform_integrations` WRITE;
/*!40000 ALTER TABLE `acr_freeform_integrations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_freeform_integrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_integrations_queue`
--

LOCK TABLES `acr_freeform_integrations_queue` WRITE;
/*!40000 ALTER TABLE `acr_freeform_integrations_queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_freeform_integrations_queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_mailing_list_fields`
--

LOCK TABLES `acr_freeform_mailing_list_fields` WRITE;
/*!40000 ALTER TABLE `acr_freeform_mailing_list_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_freeform_mailing_list_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_mailing_lists`
--

LOCK TABLES `acr_freeform_mailing_lists` WRITE;
/*!40000 ALTER TABLE `acr_freeform_mailing_lists` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_freeform_mailing_lists` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_notifications`
--

LOCK TABLES `acr_freeform_notifications` WRITE;
/*!40000 ALTER TABLE `acr_freeform_notifications` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_freeform_notifications` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_payment_gateway_fields`
--

LOCK TABLES `acr_freeform_payment_gateway_fields` WRITE;
/*!40000 ALTER TABLE `acr_freeform_payment_gateway_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_freeform_payment_gateway_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_statuses`
--

LOCK TABLES `acr_freeform_statuses` WRITE;
/*!40000 ALTER TABLE `acr_freeform_statuses` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_freeform_statuses` VALUES (1,'Pending','pending','light',NULL,1,'2019-01-24 01:47:31','2019-01-24 01:47:31','5935cfe2-d3ae-46fe-a100-fe96aa30a71a'),(2,'Open','open','green',1,2,'2019-01-24 01:47:31','2019-01-24 01:47:31','36ff5c4e-4e82-4298-b985-3b39569c5855'),(3,'Closed','closed','grey',NULL,3,'2019-01-24 01:47:31','2019-01-24 01:47:31','93bb8c45-573d-416b-bedd-c25b244d1a51');
/*!40000 ALTER TABLE `acr_freeform_statuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_submissions`
--

LOCK TABLES `acr_freeform_submissions` WRITE;
/*!40000 ALTER TABLE `acr_freeform_submissions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_freeform_submissions` VALUES (51,1,2,1,'7hYtiJmh4tSFwXqPHglnkwq3lUGYv1NRpNVlgTmdLkD7Qva4ovEPqO4S8pEu9NhJnLn1cwSmvVWRtlIfvzOFPeaQLKdgCduwv9b4','127.0.0.1',0,'2019-01-24 02:00:21','2019-01-24 02:00:21','af61118c-7509-4369-bf47-2fa4be20973e','Wesle','Cole','[\"wesley.cole87@gmail.com\"]',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'General Questions','Testing',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `acr_freeform_submissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_freeform_unfinalized_files`
--

LOCK TABLES `acr_freeform_unfinalized_files` WRITE;
/*!40000 ALTER TABLE `acr_freeform_unfinalized_files` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_freeform_unfinalized_files` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_globalsets`
--

LOCK TABLES `acr_globalsets` WRITE;
/*!40000 ALTER TABLE `acr_globalsets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_globalsets` VALUES (3,'Site Information','siteInformation',2,'2018-10-08 23:42:03','2018-10-08 23:48:12','a864a755-a5b5-4afd-8cfa-e091c506065e'),(22,'Footer Information','footerInformation',15,'2018-12-30 16:43:46','2019-01-02 00:46:22','7ef45d2a-aba2-4285-a33c-7fe1f360634e'),(67,'Newsletter','newsletter',22,'2019-01-27 18:29:04','2019-01-27 18:29:22','457c7d37-f5db-462b-9cde-df74024ec539');
/*!40000 ALTER TABLE `acr_globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_info`
--

LOCK TABLES `acr_info` WRITE;
/*!40000 ALTER TABLE `acr_info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_info` VALUES (1,'3.1.23','3.1.27',0,'a:17:{s:12:\"dateModified\";i:1557585395;s:10:\"siteGroups\";a:1:{s:36:\"29730c2c-25c9-4557-aa1a-247b9f593b50\";a:1:{s:4:\"name\";s:14:\"ACR Supply Co.\";}}s:5:\"sites\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:8:{s:4:\"name\";s:14:\"ACR Supply Co.\";s:6:\"handle\";s:7:\"default\";s:8:\"language\";s:5:\"en-US\";s:7:\"hasUrls\";s:1:\"1\";s:7:\"baseUrl\";s:5:\"@web/\";s:9:\"sortOrder\";s:1:\"1\";s:7:\"primary\";s:1:\"1\";s:9:\"siteGroup\";s:36:\"29730c2c-25c9-4557-aa1a-247b9f593b50\";}}s:8:\"sections\";a:18:{s:36:\"fc6457f4-0483-4d21-a704-9f47893b5ada\";a:7:{s:4:\"name\";s:5:\"About\";s:6:\"handle\";s:5:\"about\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"3763008a-e976-465a-b92f-9309836c9be0\";a:7:{s:4:\"name\";s:5:\"About\";s:6:\"handle\";s:5:\"about\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:10:\"Page Title\";s:11:\"titleFormat\";s:0:\"\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"d54ded79-c194-433a-ab8f-688521561942\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:14:\"Culture Survey\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"b127582a-bb04-47a7-b881-1ecfd3499eac\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:5:\"about\";s:8:\"template\";s:5:\"about\";}}}s:36:\"deefb807-a3f2-4b77-9b48-aa6bd8864f7f\";a:7:{s:4:\"name\";s:10:\"Promotions\";s:6:\"handle\";s:10:\"promotions\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"b4a92b05-e940-4b60-b063-e03b8e8ed290\";a:7:{s:4:\"name\";s:10:\"Promotions\";s:6:\"handle\";s:10:\"promotions\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";s:0:\"\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"416230ab-5b37-4f4c-8ede-32e9fba6164b\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:8:\"Settings\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"301600aa-e3fc-4ac2-9dfc-7b599eb1f1fc\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"a207db43-6f70-4166-9f80-4694e159fd67\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:17:\"promotions/{slug}\";s:8:\"template\";s:17:\"promotions/_entry\";}}}s:36:\"148a408c-a3e0-469e-aa18-46200336c446\";a:7:{s:4:\"name\";s:4:\"Home\";s:6:\"handle\";s:4:\"home\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"89e916b0-48ff-4c47-b285-bea42a6de1eb\";a:7:{s:4:\"name\";s:4:\"Home\";s:6:\"handle\";s:4:\"home\";s:13:\"hasTitleField\";s:1:\"0\";s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"50e9b4f2-ddf3-409f-be4f-cd314baaee51\";a:1:{s:4:\"tabs\";a:3:{i:0;a:3:{s:4:\"name\";s:8:\"Services\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:3:{s:36:\"d1e02aa7-b33b-49c4-a198-dae3f462e65a\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"a07789b8-1f0d-4fae-ac9c-52f01e112769\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"a4ac9646-eeb8-4757-99be-592e59cf2acb\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}}}i:1;a:3:{s:4:\"name\";s:13:\"50/50 Section\";s:9:\"sortOrder\";s:1:\"2\";s:6:\"fields\";a:1:{s:36:\"f4c519dd-a990-40e1-a0c9-696bbe1ab8fc\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}}}i:2;a:3:{s:4:\"name\";s:10:\"Newsletter\";s:9:\"sortOrder\";s:1:\"3\";s:6:\"fields\";a:3:{s:36:\"1bc2be8f-63f9-4d51-8d5c-3d07b7c84ed5\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"c2b3d873-50c8-4e57-820d-6aa965f39b79\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"c56d653e-9e7d-4ef9-aa84-7ec8606d088c\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:8:\"__home__\";s:8:\"template\";s:10:\"index.html\";}}}s:36:\"c3c14b51-1050-404a-b79d-ac586030e8a4\";a:7:{s:4:\"name\";s:13:\"Notifications\";s:6:\"handle\";s:13:\"notifications\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"cc5c88c2-6256-43b6-accc-6866de536e42\";a:7:{s:4:\"name\";s:13:\"Notifications\";s:6:\"handle\";s:13:\"notifications\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";s:0:\"\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"e9678a4c-360c-483a-a91f-9dff15e607c8\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:24:\"Notification Information\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:3:{s:36:\"e7ff456f-d45d-43e0-bc06-9c9ffe9468f2\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"6ecf8a37-13bc-46bc-afd1-e9505338259d\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"f988b15f-c79d-4498-8900-22b3859c00cc\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:20:\"notifications/{slug}\";s:8:\"template\";s:20:\"notifications/_entry\";}}}s:36:\"33cd06cd-ae75-4b06-ae73-5ab87ecf2963\";a:7:{s:4:\"name\";s:12:\"Testimonials\";s:6:\"handle\";s:12:\"testimonials\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"4aecf25f-7fd2-4fac-86f9-571abb544b3b\";a:7:{s:4:\"name\";s:12:\"Testimonials\";s:6:\"handle\";s:12:\"testimonials\";s:13:\"hasTitleField\";s:1:\"1\";s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"fbe40f7a-faae-4d94-b250-3f1c367c966e\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:19:\"Testimonial Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:2:{s:36:\"4de3e644-b5ec-4104-89c5-3449fa4175b2\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"06a1d088-9aea-4440-8997-c731e1282b28\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:19:\"testimonials/{slug}\";s:8:\"template\";s:19:\"testimonials/_entry\";}}}s:36:\"b19546f5-4ea4-4336-8cd0-1623e4279468\";a:7:{s:4:\"name\";s:9:\"Locations\";s:6:\"handle\";s:9:\"locations\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"6158f0a0-0d2b-4e2c-a79e-ae3ae8ef5498\";a:7:{s:4:\"name\";s:9:\"Locations\";s:6:\"handle\";s:9:\"locations\";s:13:\"hasTitleField\";s:1:\"0\";s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"dbb7b849-058e-4556-8ed1-440fed40ef31\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:17:\"Locations Listing\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:1:{s:36:\"ede61ed2-c66a-4d59-8ef2-a5b1f3630dda\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:9:\"locations\";s:8:\"template\";s:9:\"locations\";}}}s:36:\"8b99fb28-9536-4c55-8adc-cff3e561baff\";a:7:{s:4:\"name\";s:9:\"ACR Cares\";s:6:\"handle\";s:8:\"acrCares\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:9:\"acr-cares\";s:8:\"template\";s:8:\"acrCares\";}}s:10:\"entryTypes\";a:1:{s:36:\"43601a53-dddf-44fd-96ff-e5034fe169d1\";a:7:{s:4:\"name\";s:9:\"ACR Cares\";s:6:\"handle\";s:8:\"acrCares\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";s:0:\"\";s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"5a96d75b-bcb5-45a8-b004-87efea6204ec\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:11:\"Initiatives\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"afceddc5-9590-4182-abf6-bb387268c36d\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"68d45d5a-b25d-4eba-9741-54d6ab9ff499\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}}}}}}}}s:36:\"720bf92c-3db9-49d3-8814-2a047cb85e8c\";a:7:{s:4:\"name\";s:7:\"Contact\";s:6:\"handle\";s:7:\"contact\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:7:\"contact\";s:8:\"template\";s:7:\"contact\";}}s:10:\"entryTypes\";a:1:{s:36:\"6ce85c89-9cc3-4180-9af7-0f2109ab5dde\";a:6:{s:4:\"name\";s:7:\"Contact\";s:6:\"handle\";s:7:\"contact\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"6fbf9061-9641-4350-9e34-a974e674a2e9\";a:7:{s:4:\"name\";s:23:\"Request E-Store Account\";s:6:\"handle\";s:6:\"eStore\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:23:\"request-e-store-account\";s:8:\"template\";s:6:\"eStore\";}}s:10:\"entryTypes\";a:1:{s:36:\"2228d5f0-f6f0-4be9-af9b-b14f7c9a65ff\";a:6:{s:4:\"name\";s:23:\"Request E-Store Account\";s:6:\"handle\";s:6:\"eStore\";s:13:\"hasTitleField\";s:1:\"0\";s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"4d4a42c3-dac6-4331-8d12-fe4460f697d1\";a:7:{s:4:\"name\";s:26:\"E-Store Credit Application\";s:6:\"handle\";s:23:\"eStoreCreditApplication\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:25:\"estore-credit-application\";s:8:\"template\";s:12:\"eStoreCredit\";}}s:10:\"entryTypes\";a:1:{s:36:\"e0180887-e30e-4628-aa32-08b1842ee5f0\";a:6:{s:4:\"name\";s:26:\"E-Store Credit Application\";s:6:\"handle\";s:23:\"eStoreCreditApplication\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";i:1;}}}s:36:\"f7d15cfa-53c3-4526-ab2d-84124c9f1d2f\";a:7:{s:4:\"name\";s:10:\"Pay Online\";s:6:\"handle\";s:9:\"payOnline\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:10:\"pay-online\";s:8:\"template\";s:9:\"payOnline\";}}s:10:\"entryTypes\";a:1:{s:36:\"2cc1817d-2570-4954-a8aa-b57c5e5eeda1\";a:6:{s:4:\"name\";s:10:\"Pay Online\";s:6:\"handle\";s:9:\"payOnline\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"ab2deffb-873a-4836-82c1-42b602c2b02f\";a:7:{s:4:\"name\";s:22:\"Training and Education\";s:6:\"handle\";s:20:\"trainingAndEducation\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:22:\"training-and-education\";s:8:\"template\";s:20:\"trainingAndEducation\";}}s:10:\"entryTypes\";a:1:{s:36:\"78c5241d-877a-4e91-8ac5-836bb161279b\";a:6:{s:4:\"name\";s:22:\"Training and Education\";s:6:\"handle\";s:20:\"trainingAndEducation\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"b94ea8c9-c5ce-4409-b4d6-1bce2ead4787\";a:7:{s:4:\"name\";s:12:\"Scholarships\";s:6:\"handle\";s:12:\"scholarships\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:12:\"scholarships\";s:8:\"template\";s:12:\"scholarships\";}}s:10:\"entryTypes\";a:1:{s:36:\"ff374fa6-3141-4a64-be08-6fcae035a8fe\";a:7:{s:4:\"name\";s:12:\"Scholarships\";s:6:\"handle\";s:12:\"scholarships\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";s:0:\"\";s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"34393a6d-219e-4b6f-bf64-e4fe179d6970\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:17:\"Scholarship Years\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"38df0a62-08cf-4dc3-9ae2-03b0b2807e2a\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}}}}}}}}s:36:\"b766f97e-4a11-4234-b7a0-86790e70977e\";a:7:{s:4:\"name\";s:7:\"Careers\";s:6:\"handle\";s:7:\"careers\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:7:\"careers\";s:8:\"template\";s:7:\"careers\";}}s:10:\"entryTypes\";a:1:{s:36:\"d28af146-9297-4753-8222-0708a5cbf5aa\";a:6:{s:4:\"name\";s:7:\"Careers\";s:6:\"handle\";s:7:\"careers\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"2ab94a27-43de-4c5d-99b7-f5a5667c2fde\";a:7:{s:4:\"name\";s:10:\"Associates\";s:6:\"handle\";s:10:\"associates\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:10:\"associates\";s:8:\"template\";s:10:\"associates\";}}s:10:\"entryTypes\";a:1:{s:36:\"47bb783e-b48b-4ed6-9e79-b1a308939085\";a:6:{s:4:\"name\";s:10:\"Associates\";s:6:\"handle\";s:10:\"associates\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"aa8de52f-f0b3-4669-b39b-86de1ea3266e\";a:8:{s:4:\"name\";s:5:\"Pages\";s:6:\"handle\";s:5:\"pages\";s:4:\"type\";s:9:\"structure\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:12:\"pages/{slug}\";s:8:\"template\";s:0:\"\";}}s:9:\"structure\";a:2:{s:3:\"uid\";s:36:\"f07ef9da-1139-41e6-b5a3-e61c6fef2735\";s:9:\"maxLevels\";s:1:\"2\";}s:10:\"entryTypes\";a:1:{s:36:\"6fcb7060-ebde-4e32-963e-b9a094be6ab7\";a:6:{s:4:\"name\";s:5:\"Pages\";s:6:\"handle\";s:5:\"pages\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";i:1;}}}s:36:\"f698d717-24dd-43e6-b94e-68128fd55f6c\";a:7:{s:4:\"name\";s:7:\"Vendors\";s:6:\"handle\";s:7:\"vendors\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:7:\"vendors\";s:8:\"template\";s:7:\"vendors\";}}s:10:\"entryTypes\";a:1:{s:36:\"f6806f33-ca1c-410a-829c-9b387979a77a\";a:7:{s:4:\"name\";s:7:\"Vendors\";s:6:\"handle\";s:7:\"vendors\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";s:0:\"\";s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"8819c6cc-ba36-4a84-a478-2f87ee9c27ab\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Vendors\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"2f250de5-f055-4843-84d3-2d9f866ed888\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}}}}}}}}s:36:\"39adccaf-5f1e-48ec-834d-5ccfe0d3c1a4\";a:7:{s:4:\"name\";s:30:\"Scholarship Years & Recipients\";s:6:\"handle\";s:26:\"scholarshipYearsRecipients\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:35:\"scholarship-years-recipients/{slug}\";s:8:\"template\";s:0:\"\";}}s:10:\"entryTypes\";a:1:{s:36:\"3baae86f-420d-4e96-9011-5eb5f80041e5\";a:7:{s:4:\"name\";s:30:\"Scholarship Years & Recipients\";s:6:\"handle\";s:26:\"scholarshipYearsRecipients\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";s:0:\"\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"b1453ee0-13ac-4ef2-86f6-7ad0bb193ba4\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:15:\"Year Recipients\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"38df0a62-08cf-4dc3-9ae2-03b0b2807e2a\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}}}}}}}}}s:11:\"fieldGroups\";a:10:{s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";a:1:{s:4:\"name\";s:6:\"Common\";}s:36:\"75772b73-5f13-442a-b9a8-8c5a6015f039\";a:1:{s:4:\"name\";s:13:\"Notifications\";}s:36:\"d0819d73-9155-4ac5-9995-9fe3d7c32c74\";a:1:{s:4:\"name\";s:8:\"Services\";}s:36:\"28b86dd3-c932-453a-ad70-b5c437d0c06b\";a:1:{s:4:\"name\";s:4:\"Home\";}s:36:\"3a435df0-e9ed-4290-a496-2073b7800d15\";a:1:{s:4:\"name\";s:12:\"Testimonials\";}s:36:\"77926385-cc33-4146-a9d8-bb682af7623a\";a:1:{s:4:\"name\";s:10:\"Newsletter\";}s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";a:1:{s:4:\"name\";s:6:\"Global\";}s:36:\"0b8de195-d37c-4f38-aa45-654e5aadd202\";a:1:{s:4:\"name\";s:14:\"Culture Survey\";}s:36:\"385df8b4-d6e4-4969-afda-8aece985aaa0\";a:1:{s:4:\"name\";s:7:\"Vendors\";}s:36:\"bc26c1a0-4632-4aa7-b379-350cf7c768b7\";a:1:{s:4:\"name\";s:6:\"Events\";}}s:6:\"fields\";a:30:{s:36:\"f988b15f-c79d-4498-8900-22b3859c00cc\";a:10:{s:4:\"name\";s:12:\"Single Image\";s:6:\"handle\";s:11:\"singleImage\";s:12:\"instructions\";s:31:\"Add a single image to the page.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:1:\"1\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:27:\"singleUploadLocationSubpath\";s:10:\"promotions\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:12:\"Add an image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"a207db43-6f70-4166-9f80-4694e159fd67\";a:10:{s:4:\"name\";s:9:\"Page Link\";s:6:\"handle\";s:8:\"pageLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:8:{s:15:\"allowCustomText\";s:1:\"1\";s:16:\"allowedLinkNames\";a:5:{i:3;s:5:\"entry\";i:4;s:4:\"site\";i:7;s:5:\"email\";i:8;s:3:\"tel\";i:9;s:3:\"url\";}s:11:\"allowTarget\";s:1:\"1\";s:15:\"defaultLinkName\";s:5:\"entry\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:1:\"1\";s:11:\"enableTitle\";s:1:\"1\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:1:{s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:1:{s:7:\"sources\";s:1:\"*\";}s:5:\"entry\";a:1:{s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:1:{s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"6ecf8a37-13bc-46bc-afd1-e9505338259d\";a:10:{s:4:\"name\";s:17:\"Notification Text\";s:6:\"handle\";s:16:\"notificationText\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"75772b73-5f13-442a-b9a8-8c5a6015f039\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"e7ff456f-d45d-43e0-bc06-9c9ffe9468f2\";a:10:{s:4:\"name\";s:17:\"Notification Link\";s:6:\"handle\";s:16:\"notificationLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:8:{s:15:\"allowCustomText\";s:1:\"1\";s:16:\"allowedLinkNames\";a:2:{i:3;s:5:\"entry\";i:9;s:3:\"url\";}s:11:\"allowTarget\";s:1:\"1\";s:15:\"defaultLinkName\";s:3:\"url\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:0:\"\";s:11:\"enableTitle\";s:0:\"\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:1:{s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:1:{s:7:\"sources\";s:1:\"*\";}s:5:\"entry\";a:1:{s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:1:{s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:10:\"fieldGroup\";s:36:\"75772b73-5f13-442a-b9a8-8c5a6015f039\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"d1e02aa7-b33b-49c4-a198-dae3f462e65a\";a:10:{s:4:\"name\";s:5:\"Title\";s:6:\"handle\";s:13:\"servicesTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"d0819d73-9155-4ac5-9995-9fe3d7c32c74\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"a07789b8-1f0d-4fae-ac9c-52f01e112769\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:19:\"servicesDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"d0819d73-9155-4ac5-9995-9fe3d7c32c74\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"a4ac9646-eeb8-4757-99be-592e59cf2acb\";a:10:{s:4:\"name\";s:8:\"Services\";s:6:\"handle\";s:8:\"services\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:1:\"1\";s:9:\"maxBlocks\";s:1:\"6\";s:12:\"contentTable\";s:27:\"{{%matrixcontent_services}}\";s:14:\"localizeBlocks\";b:0;}s:10:\"fieldGroup\";s:36:\"d0819d73-9155-4ac5-9995-9fe3d7c32c74\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"f4c519dd-a990-40e1-a0c9-696bbe1ab8fc\";a:10:{s:4:\"name\";s:4:\"CTAs\";s:6:\"handle\";s:4:\"ctas\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:23:\"{{%matrixcontent_ctas}}\";s:14:\"localizeBlocks\";b:0;}s:10:\"fieldGroup\";s:36:\"28b86dd3-c932-453a-ad70-b5c437d0c06b\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"4de3e644-b5ec-4104-89c5-3449fa4175b2\";a:10:{s:4:\"name\";s:6:\"Author\";s:6:\"handle\";s:17:\"testimonialAuthor\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"3a435df0-e9ed-4290-a496-2073b7800d15\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"06a1d088-9aea-4440-8997-c731e1282b28\";a:10:{s:4:\"name\";s:7:\"Content\";s:6:\"handle\";s:17:\"testimonalcontent\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:1:\"1\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"3a435df0-e9ed-4290-a496-2073b7800d15\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"c56d653e-9e7d-4ef9-aa84-7ec8606d088c\";a:10:{s:4:\"name\";s:5:\"Image\";s:6:\"handle\";s:15:\"newsletterImage\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:12:\"Add an image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"77926385-cc33-4146-a9d8-bb682af7623a\";}s:36:\"1bc2be8f-63f9-4d51-8d5c-3d07b7c84ed5\";a:10:{s:4:\"name\";s:5:\"Title\";s:6:\"handle\";s:15:\"newsletterTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"77926385-cc33-4146-a9d8-bb682af7623a\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"c2b3d873-50c8-4e57-820d-6aa965f39b79\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:21:\"newsletterDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"77926385-cc33-4146-a9d8-bb682af7623a\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"2454409f-dfb2-45e4-b6fc-3ef708639b05\";a:10:{s:4:\"name\";s:13:\"External Link\";s:6:\"handle\";s:12:\"externalLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:16:\"craft\\fields\\Url\";s:8:\"settings\";a:1:{s:11:\"placeholder\";s:0:\"\";}s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"009e6ae8-8fde-401d-a29e-784a1170ebfd\";a:10:{s:4:\"name\";s:16:\"Apple Store LInk\";s:6:\"handle\";s:14:\"appleStoreLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:16:\"craft\\fields\\Url\";s:8:\"settings\";a:1:{s:11:\"placeholder\";s:0:\"\";}s:10:\"fieldGroup\";s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"654aca73-0f2c-4695-89ba-4bd3e6db1e42\";a:10:{s:4:\"name\";s:22:\"Google Play Store LInk\";s:6:\"handle\";s:19:\"googlePlayStoreLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:16:\"craft\\fields\\Url\";s:8:\"settings\";a:1:{s:11:\"placeholder\";s:0:\"\";}s:10:\"fieldGroup\";s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"13e8e656-c68f-463c-86e6-b51e83c7d2a1\";a:10:{s:4:\"name\";s:13:\"Facebook Link\";s:6:\"handle\";s:12:\"facebookLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:16:\"craft\\fields\\Url\";s:8:\"settings\";a:1:{s:11:\"placeholder\";s:0:\"\";}s:10:\"fieldGroup\";s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"d43389b3-5eea-455f-8ea2-d05f6a5ec556\";a:10:{s:4:\"name\";s:11:\"Footer Logo\";s:6:\"handle\";s:10:\"footerLogo\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:0:\"\";s:12:\"allowedKinds\";N;s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:0:\"\";s:17:\"localizeRelations\";b:0;}s:10:\"fieldGroup\";s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"877d25f5-76f5-467b-9739-03e87cdffbbe\";a:10:{s:4:\"name\";s:14:\"Footer Tagline\";s:6:\"handle\";s:13:\"footerTagline\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"ede61ed2-c66a-4d59-8ef2-a5b1f3630dda\";a:10:{s:4:\"name\";s:9:\"Locations\";s:6:\"handle\";s:9:\"locations\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:28:\"{{%matrixcontent_locations}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"afceddc5-9590-4182-abf6-bb387268c36d\";a:10:{s:4:\"name\";s:21:\"ACR Cares Initiatives\";s:6:\"handle\";s:19:\"acrCaresInitiatives\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:38:\"{{%matrixcontent_acrcaresinitiatives}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"68d45d5a-b25d-4eba-9741-54d6ab9ff499\";a:10:{s:4:\"name\";s:23:\"Team Member Initiatives\";s:6:\"handle\";s:21:\"teamMemberInitiatives\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:40:\"{{%matrixcontent_teammemberinitiatives}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"301600aa-e3fc-4ac2-9dfc-7b599eb1f1fc\";a:10:{s:4:\"name\";s:15:\"Promotion Image\";s:6:\"handle\";s:14:\"promotionImage\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:1:\"1\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:98af559e-fbd3-426a-aada-0f8e6fe41d61\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:98af559e-fbd3-426a-aada-0f8e6fe41d61\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:12:\"Add an Image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"b127582a-bb04-47a7-b881-1ecfd3499eac\";a:10:{s:4:\"name\";s:14:\"Survey Results\";s:6:\"handle\";s:13:\"surveyResults\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:32:\"{{%matrixcontent_surveyresults}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"0b8de195-d37c-4f38-aa45-654e5aadd202\";}s:36:\"2f250de5-f055-4843-84d3-2d9f866ed888\";a:10:{s:4:\"name\";s:7:\"Vendors\";s:6:\"handle\";s:7:\"vendors\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:26:\"{{%matrixcontent_vendors}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"385df8b4-d6e4-4969-afda-8aece985aaa0\";}s:36:\"063c7f84-92b6-4c76-b1de-1d8f9a914e5e\";a:9:{s:4:\"name\";s:14:\"Connected Form\";s:6:\"handle\";s:13:\"connectedForm\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:42:\"Solspace\\Freeform\\FieldTypes\\FormFieldType\";s:17:\"contentColumnType\";s:7:\"integer\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"eb838f91-6771-4599-adec-5808e3d72e56\";a:10:{s:4:\"name\";s:8:\"Location\";s:6:\"handle\";s:8:\"location\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"53537675-602f-4e8f-bdea-81335b24c7f9\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:11:\"description\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"fb1dfb25-2f79-4569-a04a-5aa6f10c823f\";a:10:{s:4:\"name\";s:11:\"Event Price\";s:6:\"handle\";s:10:\"eventPrice\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Number\";s:8:\"settings\";a:7:{s:12:\"defaultValue\";N;s:3:\"min\";s:1:\"0\";s:3:\"max\";N;s:8:\"decimals\";s:1:\"2\";s:4:\"size\";N;s:6:\"prefix\";s:1:\"$\";s:6:\"suffix\";s:0:\"\";}s:17:\"contentColumnType\";s:13:\"decimal(12,2)\";s:10:\"fieldGroup\";s:36:\"bc26c1a0-4632-4aa7-b379-350cf7c768b7\";}s:36:\"38df0a62-08cf-4dc3-9ae2-03b0b2807e2a\";a:10:{s:4:\"name\";s:22:\"Scholarship Recipients\";s:6:\"handle\";s:21:\"scholarshipRecipients\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:40:\"{{%matrixcontent_scholarshiprecipients}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}}s:16:\"matrixBlockTypes\";a:8:{s:36:\"ad0dc2b4-7b01-48f6-9596-8c8dad66a4b1\";a:6:{s:4:\"name\";s:7:\"Service\";s:6:\"handle\";s:7:\"service\";s:9:\"sortOrder\";s:1:\"1\";s:5:\"field\";s:36:\"a4ac9646-eeb8-4757-99be-592e59cf2acb\";s:12:\"fieldLayouts\";a:1:{s:36:\"bbb4f2b3-f970-48bc-b558-4c21dcf0d911\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:3:{s:36:\"54f564b2-6d31-46e7-a148-ca738ab72142\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"28cf2be5-8f7e-4677-b055-7b02264a5217\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"2e5417ea-9053-4e0f-9f16-0301f26dcf2a\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}}}}}}s:6:\"fields\";a:3:{s:36:\"54f564b2-6d31-46e7-a148-ca738ab72142\";a:10:{s:4:\"name\";s:5:\"Title\";s:6:\"handle\";s:12:\"serviceTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"28cf2be5-8f7e-4677-b055-7b02264a5217\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:18:\"serviceDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"2e5417ea-9053-4e0f-9f16-0301f26dcf2a\";a:10:{s:4:\"name\";s:4:\"Link\";s:6:\"handle\";s:11:\"serviceLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:8:{s:15:\"allowCustomText\";s:1:\"1\";s:16:\"allowedLinkNames\";a:2:{i:3;s:5:\"entry\";i:9;s:3:\"url\";}s:11:\"allowTarget\";s:0:\"\";s:15:\"defaultLinkName\";s:5:\"entry\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:0:\"\";s:11:\"enableTitle\";s:0:\"\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:1:{s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:1:{s:7:\"sources\";s:1:\"*\";}s:5:\"entry\";a:1:{s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:1:{s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}}}s:36:\"a18a4a20-6a90-4d48-8995-8ab7941dcc11\";a:6:{s:4:\"name\";s:14:\"Call To Action\";s:6:\"handle\";s:12:\"callToAction\";s:9:\"sortOrder\";s:1:\"1\";s:5:\"field\";s:36:\"f4c519dd-a990-40e1-a0c9-696bbe1ab8fc\";s:12:\"fieldLayouts\";a:1:{s:36:\"6d5c94c9-83a9-4be7-af5f-8189aeb32f4c\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:5:{s:36:\"3dee8338-1e08-4d25-bdde-b00ee509d056\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"fce33d4d-1efd-4868-8cbe-9f00ddbb8fa6\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"9938542d-a4f6-4f92-96a8-c8bcc7818139\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"93c4bbd8-db6c-4a65-987f-b31e3462b6c4\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}s:36:\"16531a44-dbf0-4400-bcdd-ecdad520a697\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"5\";}}}}}}s:6:\"fields\";a:5:{s:36:\"3dee8338-1e08-4d25-bdde-b00ee509d056\";a:10:{s:4:\"name\";s:20:\"Call to Action Title\";s:6:\"handle\";s:17:\"callToActionTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"fce33d4d-1efd-4868-8cbe-9f00ddbb8fa6\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:23:\"callToActionDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"9938542d-a4f6-4f92-96a8-c8bcc7818139\";a:10:{s:4:\"name\";s:5:\"Image\";s:6:\"handle\";s:17:\"callToActionImage\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:0:\"\";s:12:\"allowedKinds\";N;s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:0:\"\";s:14:\"selectionLabel\";s:0:\"\";s:17:\"localizeRelations\";b:0;}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"93c4bbd8-db6c-4a65-987f-b31e3462b6c4\";a:10:{s:4:\"name\";s:16:\"Background Color\";s:6:\"handle\";s:27:\"callToActionBackgroundColor\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:25:\"craft\\fields\\RadioButtons\";s:8:\"settings\";a:1:{s:7:\"options\";a:2:{i:0;a:3:{s:5:\"label\";s:3:\"Red\";s:5:\"value\";s:3:\"red\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:4:\"Blue\";s:5:\"value\";s:4:\"blue\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"16531a44-dbf0-4400-bcdd-ecdad520a697\";a:10:{s:4:\"name\";s:4:\"Link\";s:6:\"handle\";s:16:\"callToActionLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:8:{s:15:\"allowCustomText\";s:1:\"1\";s:16:\"allowedLinkNames\";a:6:{i:3;s:5:\"entry\";i:4;s:4:\"site\";i:6;s:6:\"custom\";i:7;s:5:\"email\";i:8;s:3:\"tel\";i:9;s:3:\"url\";}s:11:\"allowTarget\";s:0:\"\";s:15:\"defaultLinkName\";s:5:\"asset\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:0:\"\";s:11:\"enableTitle\";s:0:\"\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:1:{s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:1:{s:7:\"sources\";s:1:\"*\";}s:5:\"entry\";a:1:{s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:1:{s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}}}s:36:\"c773ee36-d4bd-4d3c-8a25-e904a163d34e\";a:6:{s:5:\"field\";s:36:\"ede61ed2-c66a-4d59-8ef2-a5b1f3630dda\";s:4:\"name\";s:14:\"Store Location\";s:6:\"handle\";s:13:\"storeLocation\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:4:{s:36:\"5d063c02-f819-4258-82df-5a5ec9568e0a\";a:10:{s:4:\"name\";s:4:\"Name\";s:6:\"handle\";s:12:\"locationName\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"701fee08-7b80-4ba0-981f-7212238bb0d5\";a:10:{s:4:\"name\";s:7:\"Address\";s:6:\"handle\";s:7:\"address\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:1:\"1\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"cf1d4f60-e469-4979-89db-5395eeacf025\";a:10:{s:4:\"name\";s:12:\"Phone Number\";s:6:\"handle\";s:11:\"phoneNumber\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"ecdf0853-6e09-413b-b63f-2a03ea7a9a1b\";a:10:{s:4:\"name\";s:15:\"Google Map Link\";s:6:\"handle\";s:13:\"googleMapLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:16:\"craft\\fields\\Url\";s:8:\"settings\";a:1:{s:11:\"placeholder\";s:0:\"\";}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"5ea35531-4f32-434f-8ab9-27d853b46432\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:4:{s:36:\"5d063c02-f819-4258-82df-5a5ec9568e0a\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"701fee08-7b80-4ba0-981f-7212238bb0d5\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"cf1d4f60-e469-4979-89db-5395eeacf025\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"ecdf0853-6e09-413b-b63f-2a03ea7a9a1b\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}}}}}}}s:36:\"cd5cbfa7-0720-49c3-8c87-eca987b0e498\";a:6:{s:5:\"field\";s:36:\"afceddc5-9590-4182-abf6-bb387268c36d\";s:4:\"name\";s:10:\"Initiative\";s:6:\"handle\";s:10:\"initiative\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"5004af34-6543-4cb8-a1c3-157bf57abd95\";a:10:{s:4:\"name\";s:5:\"Title\";s:6:\"handle\";s:15:\"initiativeTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"8c95b6b9-ce93-4231-942f-7d44e4a0d9a8\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:21:\"initiativeDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"8e770b24-247e-49ec-978f-1cbe2a2d8bec\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"5004af34-6543-4cb8-a1c3-157bf57abd95\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"8c95b6b9-ce93-4231-942f-7d44e4a0d9a8\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}}}}}}s:36:\"3334d866-45d7-4fa3-b627-7c7470d3687a\";a:6:{s:5:\"field\";s:36:\"68d45d5a-b25d-4eba-9741-54d6ab9ff499\";s:4:\"name\";s:10:\"Initiative\";s:6:\"handle\";s:14:\"teamInitiative\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"9f53424a-206a-4123-bd8f-9ab550dbf4d8\";a:10:{s:4:\"name\";s:5:\"Title\";s:6:\"handle\";s:15:\"initiativeTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"e2264f39-c7a9-4baa-b4a8-e1add7ff7a89\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"9f53424a-206a-4123-bd8f-9ab550dbf4d8\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}}}}}}s:36:\"2b703ea5-e694-4433-8977-1b00f3a9259a\";a:6:{s:5:\"field\";s:36:\"b127582a-bb04-47a7-b881-1ecfd3499eac\";s:4:\"name\";s:6:\"Result\";s:6:\"handle\";s:6:\"result\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"0202c89c-046d-4d22-bdd2-9c933f2d13d7\";a:10:{s:4:\"name\";s:14:\"Result Content\";s:6:\"handle\";s:13:\"resultContent\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"cae6135c-cb59-4d08-9d85-52480a4f917a\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"0202c89c-046d-4d22-bdd2-9c933f2d13d7\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}}}}}}s:36:\"8cd2da25-6028-4e91-aceb-25283dbdf155\";a:6:{s:5:\"field\";s:36:\"2f250de5-f055-4843-84d3-2d9f866ed888\";s:4:\"name\";s:6:\"Vendor\";s:6:\"handle\";s:6:\"vendor\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:3:{s:36:\"37c33a47-e59c-4e8e-9c60-ac535f437113\";a:10:{s:4:\"name\";s:11:\"Vendor Name\";s:6:\"handle\";s:10:\"vendorName\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"2dff0473-bcc2-40cf-8442-78ebd5fec7e8\";a:10:{s:4:\"name\";s:18:\"Vendor Description\";s:6:\"handle\";s:17:\"vendorDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"110f068c-c2a8-423c-bd11-3b164f3f2bda\";a:10:{s:4:\"name\";s:11:\"Vendor Link\";s:6:\"handle\";s:10:\"vendorLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:9:{s:15:\"allowCustomText\";s:0:\"\";s:16:\"allowedLinkNames\";a:1:{i:9;s:3:\"url\";}s:11:\"allowTarget\";s:1:\"1\";s:14:\"autoNoReferrer\";s:0:\"\";s:15:\"defaultLinkName\";s:3:\"url\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:0:\"\";s:11:\"enableTitle\";s:0:\"\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:2:{s:7:\"sources\";s:1:\"*\";s:16:\"allowCustomQuery\";s:0:\"\";}s:8:\"category\";a:2:{s:7:\"sources\";s:1:\"*\";s:16:\"allowCustomQuery\";s:0:\"\";}s:5:\"entry\";a:2:{s:7:\"sources\";s:1:\"*\";s:16:\"allowCustomQuery\";s:0:\"\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:2:{s:7:\"sources\";s:1:\"*\";s:16:\"allowCustomQuery\";s:0:\"\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"03ec905a-edcb-49cf-a232-cd75003091e0\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:3:{s:36:\"37c33a47-e59c-4e8e-9c60-ac535f437113\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"2dff0473-bcc2-40cf-8442-78ebd5fec7e8\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"110f068c-c2a8-423c-bd11-3b164f3f2bda\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}}}}}}}s:36:\"ccfa9a8b-8bbd-4c93-b9ef-437d2260aa8f\";a:6:{s:5:\"field\";s:36:\"38df0a62-08cf-4dc3-9ae2-03b0b2807e2a\";s:4:\"name\";s:9:\"Recipient\";s:6:\"handle\";s:9:\"recipient\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"4ee6f98c-88cc-49e8-bb1d-19b68fd9cd74\";a:10:{s:4:\"name\";s:4:\"Name\";s:6:\"handle\";s:13:\"recipientName\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"ef8c2f7d-a520-47b0-893c-c81cf5833442\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"4ee6f98c-88cc-49e8-bb1d-19b68fd9cd74\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}}}}}}}}s:7:\"volumes\";a:2:{s:36:\"0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";a:7:{s:4:\"name\";s:6:\"Global\";s:6:\"handle\";s:6:\"global\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";b:1;s:3:\"url\";s:14:\"/assets/images\";s:8:\"settings\";a:1:{s:4:\"path\";s:22:\"@webroot/assets/images\";}s:9:\"sortOrder\";s:1:\"1\";}s:36:\"98af559e-fbd3-426a-aada-0f8e6fe41d61\";a:7:{s:4:\"name\";s:10:\"Promotions\";s:6:\"handle\";s:10:\"promotions\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";b:1;s:3:\"url\";s:25:\"/assets/images/promotions\";s:8:\"settings\";a:1:{s:4:\"path\";s:33:\"@webroot/assets/images/promotions\";}s:9:\"sortOrder\";N;}}s:14:\"categoryGroups\";a:0:{}s:9:\"tagGroups\";a:0:{}s:5:\"users\";a:5:{s:24:\"requireEmailVerification\";b:1;s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:14:\"photoVolumeUid\";N;s:12:\"photoSubpath\";s:0:\"\";}s:10:\"globalSets\";a:3:{s:36:\"a864a755-a5b5-4afd-8cfa-e091c506065e\";a:3:{s:4:\"name\";s:16:\"Site Information\";s:6:\"handle\";s:15:\"siteInformation\";s:12:\"fieldLayouts\";a:1:{s:36:\"54e4880b-8f72-49a9-8732-0bacdc5c96b7\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:24:\"General Site Information\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:1:{s:36:\"f988b15f-c79d-4498-8900-22b3859c00cc\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}}}}}}}s:36:\"7ef45d2a-aba2-4285-a33c-7fe1f360634e\";a:3:{s:4:\"name\";s:18:\"Footer Information\";s:6:\"handle\";s:17:\"footerInformation\";s:12:\"fieldLayouts\";a:1:{s:36:\"160be074-78ff-4339-b327-91a2f57bf793\";a:1:{s:4:\"tabs\";a:2:{i:0;a:3:{s:4:\"name\";s:7:\"General\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:1:{s:36:\"877d25f5-76f5-467b-9739-03e87cdffbbe\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}}}i:1;a:3:{s:4:\"name\";s:5:\"Links\";s:9:\"sortOrder\";s:1:\"2\";s:6:\"fields\";a:3:{s:36:\"009e6ae8-8fde-401d-a29e-784a1170ebfd\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"654aca73-0f2c-4695-89ba-4bd3e6db1e42\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"13e8e656-c68f-463c-86e6-b51e83c7d2a1\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}}}}}}}s:36:\"457c7d37-f5db-462b-9cde-df74024ec539\";a:3:{s:4:\"name\";s:10:\"Newsletter\";s:6:\"handle\";s:10:\"newsletter\";s:12:\"fieldLayouts\";a:1:{s:36:\"928d3988-5927-4713-b134-fad5ce7b6342\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:8:\"Settings\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:3:{s:36:\"c56d653e-9e7d-4ef9-aa84-7ec8606d088c\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"1bc2be8f-63f9-4d51-8d5c-3d07b7c84ed5\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"c2b3d873-50c8-4e57-820d-6aa965f39b79\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}}}}}}}}s:7:\"plugins\";a:6:{s:11:\"element-api\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:6:\"locate\";a:4:{s:8:\"settings\";a:2:{s:16:\"googleMapsApiKey\";s:39:\"AIzaSyAk6zLZpAFtgZGHt7IThIhAeqihEckOIrQ\";s:19:\"autocompleteOptions\";s:0:\"\";}s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"2.1.1\";}s:14:\"typedlinkfield\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:8:\"freeform\";a:4:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"2.1.3\";s:8:\"settings\";a:34:{s:10:\"pluginName\";s:5:\"Forms\";s:21:\"formTemplateDirectory\";N;s:22:\"emailTemplateDirectory\";N;s:20:\"emailTemplateStorage\";s:2:\"db\";s:11:\"defaultView\";s:9:\"dashboard\";s:17:\"fieldDisplayOrder\";s:4:\"name\";s:12:\"showTutorial\";b:0;s:14:\"removeNewlines\";s:0:\"\";s:16:\"defaultTemplates\";s:1:\"1\";s:13:\"footerScripts\";s:1:\"0\";s:17:\"formSubmitDisable\";s:0:\"\";s:16:\"freeformHoneypot\";b:1;s:23:\"spamProtectionBehaviour\";s:16:\"simulate_success\";s:25:\"submissionThrottlingCount\";N;s:29:\"submissionThrottlingTimeFrame\";N;s:13:\"blockedEmails\";N;s:15:\"blockedKeywords\";N;s:20:\"blockedKeywordsError\";s:18:\"Invalid Entry Data\";s:18:\"blockedEmailsError\";s:21:\"Invalid Email Address\";s:26:\"showErrorsForBlockedEmails\";b:0;s:28:\"showErrorsForBlockedKeywords\";b:0;s:18:\"blockedIpAddresses\";N;s:27:\"purgableSubmissionAgeInDays\";s:1:\"0\";s:21:\"purgableSpamAgeInDays\";N;s:20:\"salesforce_client_id\";N;s:24:\"salesforce_client_secret\";N;s:19:\"salesforce_username\";N;s:19:\"salesforce_password\";N;s:17:\"spamFolderEnabled\";b:0;s:16:\"recaptchaEnabled\";b:0;s:12:\"recaptchaKey\";N;s:15:\"recaptchaSecret\";N;s:23:\"renderFormHtmlInCpViews\";s:1:\"1\";s:18:\"autoScrollToErrors\";s:1:\"1\";}}s:4:\"copy\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:8:\"calendar\";a:4:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"2.0.5\";s:8:\"settings\";a:13:{s:16:\"overlapThreshold\";i:5;s:12:\"timeInterval\";i:30;s:13:\"eventDuration\";i:60;s:6:\"allDay\";b:0;s:18:\"demoBannerDisabled\";b:1;s:11:\"showMiniCal\";s:0:\"\";s:18:\"showDisabledEvents\";s:1:\"1\";s:18:\"quickCreateEnabled\";s:1:\"1\";s:11:\"defaultView\";s:5:\"month\";s:11:\"guestAccess\";N;s:22:\"descriptionFieldHandle\";N;s:19:\"locationFieldHandle\";N;s:21:\"authoredEventEditOnly\";s:0:\"\";}}}s:5:\"email\";a:3:{s:9:\"fromEmail\";s:23:\"wesley.cole87@gmail.com\";s:8:\"fromName\";s:14:\"ACR Supply Co.\";s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";}s:6:\"system\";a:5:{s:7:\"edition\";s:4:\"solo\";s:4:\"live\";b:1;s:4:\"name\";s:14:\"ACR Supply Co.\";s:8:\"timeZone\";s:16:\"America/New_York\";s:13:\"schemaVersion\";s:6:\"3.1.27\";}s:15:\"imageTransforms\";a:0:{}s:6:\"routes\";a:20:{s:36:\"31417624-a451-493f-9d49-400e65fc23e2\";a:5:{s:8:\"template\";s:18:\"/calendar/mini_cal\";s:8:\"uriParts\";a:4:{i:0;s:18:\"calendar/mini_cal/\";i:1;a:2:{i:0;s:4:\"year\";i:1;s:5:\"\\d{4}\";}i:2;s:1:\"/\";i:3;a:2:{i:0;s:5:\"month\";i:1;s:18:\"(?:0?[1-9]|1[012])\";}}s:10:\"uriPattern\";s:57:\"calendar/mini_cal/<year:\\d{4}>/<month:(?:0?[1-9]|1[012])>\";s:9:\"sortOrder\";i:1;s:7:\"siteUid\";N;}s:36:\"b1810c38-bc9e-41bc-91e0-635176cdcb29\";a:5:{s:8:\"template\";s:15:\"/calendar/month\";s:8:\"uriParts\";a:4:{i:0;s:15:\"calendar/month/\";i:1;a:2:{i:0;s:4:\"year\";i:1;s:5:\"\\d{4}\";}i:2;s:1:\"/\";i:3;a:2:{i:0;s:5:\"month\";i:1;s:18:\"(?:0?[1-9]|1[012])\";}}s:10:\"uriPattern\";s:54:\"calendar/month/<year:\\d{4}>/<month:(?:0?[1-9]|1[012])>\";s:9:\"sortOrder\";i:2;s:7:\"siteUid\";N;}s:36:\"b2acc5df-7267-47ac-a877-22eaa0089147\";a:5:{s:8:\"template\";s:15:\"/calendar/month\";s:8:\"uriParts\";a:2:{i:0;s:24:\"calendar/month/calendar/\";i:1;a:2:{i:0;s:4:\"slug\";i:1;s:6:\"[^\\/]+\";}}s:10:\"uriPattern\";s:37:\"calendar/month/calendar/<slug:[^\\/]+>\";s:9:\"sortOrder\";i:3;s:7:\"siteUid\";N;}s:36:\"c5b29c7f-fece-4d73-8102-ab9606e84fa9\";a:5:{s:8:\"template\";s:15:\"/calendar/month\";s:8:\"uriParts\";a:6:{i:0;s:24:\"calendar/month/calendar/\";i:1;a:2:{i:0;s:4:\"slug\";i:1;s:6:\"[^\\/]+\";}i:2;s:1:\"/\";i:3;a:2:{i:0;s:4:\"year\";i:1;s:5:\"\\d{4}\";}i:4;s:1:\"/\";i:5;a:2:{i:0;s:5:\"month\";i:1;s:18:\"(?:0?[1-9]|1[012])\";}}s:10:\"uriPattern\";s:77:\"calendar/month/calendar/<slug:[^\\/]+>/<year:\\d{4}>/<month:(?:0?[1-9]|1[012])>\";s:9:\"sortOrder\";i:4;s:7:\"siteUid\";N;}s:36:\"9b28770e-1823-4594-b0fa-111d7a2f8ba6\";a:5:{s:8:\"template\";s:14:\"/calendar/week\";s:8:\"uriParts\";a:6:{i:0;s:14:\"calendar/week/\";i:1;a:2:{i:0;s:4:\"year\";i:1;s:5:\"\\d{4}\";}i:2;s:1:\"/\";i:3;a:2:{i:0;s:5:\"month\";i:1;s:18:\"(?:0?[1-9]|1[012])\";}i:4;s:1:\"/\";i:5;a:2:{i:0;s:3:\"day\";i:1;s:27:\"(?:0?[1-9]|[12][0-9]|3[01])\";}}s:10:\"uriPattern\";s:87:\"calendar/week/<year:\\d{4}>/<month:(?:0?[1-9]|1[012])>/<day:(?:0?[1-9]|[12][0-9]|3[01])>\";s:9:\"sortOrder\";i:5;s:7:\"siteUid\";N;}s:36:\"682430ff-7846-4ddd-af04-74725958b2b0\";a:5:{s:8:\"template\";s:14:\"/calendar/week\";s:8:\"uriParts\";a:2:{i:0;s:23:\"calendar/week/calendar/\";i:1;a:2:{i:0;s:4:\"slug\";i:1;s:6:\"[^\\/]+\";}}s:10:\"uriPattern\";s:36:\"calendar/week/calendar/<slug:[^\\/]+>\";s:9:\"sortOrder\";i:6;s:7:\"siteUid\";N;}s:36:\"5e6767cc-f676-4888-a9f5-3eeae6c7ead8\";a:5:{s:8:\"template\";s:14:\"/calendar/week\";s:8:\"uriParts\";a:8:{i:0;s:23:\"calendar/week/calendar/\";i:1;a:2:{i:0;s:4:\"slug\";i:1;s:6:\"[^\\/]+\";}i:2;s:1:\"/\";i:3;a:2:{i:0;s:4:\"year\";i:1;s:5:\"\\d{4}\";}i:4;s:1:\"/\";i:5;a:2:{i:0;s:5:\"month\";i:1;s:18:\"(?:0?[1-9]|1[012])\";}i:6;s:1:\"/\";i:7;a:2:{i:0;s:3:\"day\";i:1;s:27:\"(?:0?[1-9]|[12][0-9]|3[01])\";}}s:10:\"uriPattern\";s:110:\"calendar/week/calendar/<slug:[^\\/]+>/<year:\\d{4}>/<month:(?:0?[1-9]|1[012])>/<day:(?:0?[1-9]|[12][0-9]|3[01])>\";s:9:\"sortOrder\";i:7;s:7:\"siteUid\";N;}s:36:\"70279ce9-310a-4bc7-913d-600de5aee460\";a:5:{s:8:\"template\";s:13:\"/calendar/day\";s:8:\"uriParts\";a:6:{i:0;s:13:\"calendar/day/\";i:1;a:2:{i:0;s:4:\"year\";i:1;s:5:\"\\d{4}\";}i:2;s:1:\"/\";i:3;a:2:{i:0;s:5:\"month\";i:1;s:18:\"(?:0?[1-9]|1[012])\";}i:4;s:1:\"/\";i:5;a:2:{i:0;s:3:\"day\";i:1;s:27:\"(?:0?[1-9]|[12][0-9]|3[01])\";}}s:10:\"uriPattern\";s:86:\"calendar/day/<year:\\d{4}>/<month:(?:0?[1-9]|1[012])>/<day:(?:0?[1-9]|[12][0-9]|3[01])>\";s:9:\"sortOrder\";i:8;s:7:\"siteUid\";N;}s:36:\"57c1a74d-fd5f-4897-a9c2-21818487731f\";a:5:{s:8:\"template\";s:13:\"/calendar/day\";s:8:\"uriParts\";a:2:{i:0;s:22:\"calendar/day/calendar/\";i:1;a:2:{i:0;s:4:\"slug\";i:1;s:6:\"[^\\/]+\";}}s:10:\"uriPattern\";s:35:\"calendar/day/calendar/<slug:[^\\/]+>\";s:9:\"sortOrder\";i:9;s:7:\"siteUid\";N;}s:36:\"2044cd13-7fc2-44b7-89cd-05be6c125714\";a:5:{s:8:\"template\";s:13:\"/calendar/day\";s:8:\"uriParts\";a:8:{i:0;s:22:\"calendar/day/calendar/\";i:1;a:2:{i:0;s:4:\"slug\";i:1;s:6:\"[^\\/]+\";}i:2;s:1:\"/\";i:3;a:2:{i:0;s:4:\"year\";i:1;s:5:\"\\d{4}\";}i:4;s:1:\"/\";i:5;a:2:{i:0;s:5:\"month\";i:1;s:18:\"(?:0?[1-9]|1[012])\";}i:6;s:1:\"/\";i:7;a:2:{i:0;s:3:\"day\";i:1;s:27:\"(?:0?[1-9]|[12][0-9]|3[01])\";}}s:10:\"uriPattern\";s:109:\"calendar/day/calendar/<slug:[^\\/]+>/<year:\\d{4}>/<month:(?:0?[1-9]|1[012])>/<day:(?:0?[1-9]|[12][0-9]|3[01])>\";s:9:\"sortOrder\";i:10;s:7:\"siteUid\";N;}s:36:\"2124ff78-66c4-4a6c-bf4f-e180ebb5f7de\";a:5:{s:8:\"template\";s:19:\"/calendar/calendars\";s:8:\"uriParts\";a:2:{i:0;s:19:\"calendar/calendars/\";i:1;a:2:{i:0;s:4:\"slug\";i:1;s:6:\"[^\\/]+\";}}s:10:\"uriPattern\";s:32:\"calendar/calendars/<slug:[^\\/]+>\";s:9:\"sortOrder\";i:11;s:7:\"siteUid\";N;}s:36:\"9c124e29-750d-4470-9046-d31fd1cc350c\";a:5:{s:8:\"template\";s:15:\"/calendar/event\";s:8:\"uriParts\";a:2:{i:0;s:15:\"calendar/event/\";i:1;a:2:{i:0;s:6:\"number\";i:1;s:3:\"\\d+\";}}s:10:\"uriPattern\";s:27:\"calendar/event/<number:\\d+>\";s:9:\"sortOrder\";i:12;s:7:\"siteUid\";N;}s:36:\"05c714cf-1f36-4db6-8535-4ee0a748988e\";a:5:{s:8:\"template\";s:15:\"/calendar/event\";s:8:\"uriParts\";a:8:{i:0;s:15:\"calendar/event/\";i:1;a:2:{i:0;s:6:\"number\";i:1;s:3:\"\\d+\";}i:2;s:1:\"/\";i:3;a:2:{i:0;s:4:\"year\";i:1;s:5:\"\\d{4}\";}i:4;s:1:\"/\";i:5;a:2:{i:0;s:5:\"month\";i:1;s:18:\"(?:0?[1-9]|1[012])\";}i:6;s:1:\"/\";i:7;a:2:{i:0;s:3:\"day\";i:1;s:27:\"(?:0?[1-9]|[12][0-9]|3[01])\";}}s:10:\"uriPattern\";s:101:\"calendar/event/<number:\\d+>/<year:\\d{4}>/<month:(?:0?[1-9]|1[012])>/<day:(?:0?[1-9]|[12][0-9]|3[01])>\";s:9:\"sortOrder\";i:13;s:7:\"siteUid\";N;}s:36:\"9c56860f-663d-4f60-9bb9-8dc8f088cbd6\";a:5:{s:8:\"template\";s:16:\"/calendar/events\";s:8:\"uriParts\";a:6:{i:0;s:16:\"calendar/events/\";i:1;a:2:{i:0;s:4:\"year\";i:1;s:5:\"\\d{4}\";}i:2;s:1:\"/\";i:3;a:2:{i:0;s:5:\"month\";i:1;s:18:\"(?:0?[1-9]|1[012])\";}i:4;s:1:\"/\";i:5;a:2:{i:0;s:3:\"day\";i:1;s:27:\"(?:0?[1-9]|[12][0-9]|3[01])\";}}s:10:\"uriPattern\";s:89:\"calendar/events/<year:\\d{4}>/<month:(?:0?[1-9]|1[012])>/<day:(?:0?[1-9]|[12][0-9]|3[01])>\";s:9:\"sortOrder\";i:14;s:7:\"siteUid\";N;}s:36:\"bcccd694-b8d4-4183-8eee-2b6e0bf5f8dd\";a:5:{s:8:\"template\";s:16:\"/calendar/export\";s:8:\"uriParts\";a:2:{i:0;s:22:\"calendar/export/event/\";i:1;a:2:{i:0;s:6:\"number\";i:1;s:3:\"\\d+\";}}s:10:\"uriPattern\";s:34:\"calendar/export/event/<number:\\d+>\";s:9:\"sortOrder\";i:15;s:7:\"siteUid\";N;}s:36:\"a85bea90-94cc-4b35-98f6-f8d04860ccd5\";a:5:{s:8:\"template\";s:14:\"/calendar/edit\";s:8:\"uriParts\";a:2:{i:0;s:20:\"calendar/edit/event/\";i:1;a:2:{i:0;s:6:\"number\";i:1;s:3:\"\\d+\";}}s:10:\"uriPattern\";s:32:\"calendar/edit/event/<number:\\d+>\";s:9:\"sortOrder\";i:16;s:7:\"siteUid\";N;}s:36:\"a6af8c29-898a-40f4-9de2-84a2ff8eb202\";a:5:{s:8:\"template\";s:14:\"/calendar/edit\";s:8:\"uriParts\";a:1:{i:0;s:23:\"calendar/edit/event/new\";}s:10:\"uriPattern\";s:23:\"calendar/edit/event/new\";s:9:\"sortOrder\";i:17;s:7:\"siteUid\";N;}s:36:\"4da8b3e5-f882-4148-aaf9-2389f359a19e\";a:5:{s:8:\"template\";s:16:\"/calendar/export\";s:8:\"uriParts\";a:2:{i:0;s:25:\"calendar/export/calendar/\";i:1;a:2:{i:0;s:6:\"number\";i:1;s:3:\"\\d+\";}}s:10:\"uriPattern\";s:37:\"calendar/export/calendar/<number:\\d+>\";s:9:\"sortOrder\";i:18;s:7:\"siteUid\";N;}s:36:\"20afceae-d739-414f-ac50-6e9c248cf201\";a:5:{s:8:\"template\";s:22:\"/calendar/fullcalendar\";s:8:\"uriParts\";a:8:{i:0;s:22:\"calendar/fullcalendar/\";i:1;a:2:{i:0;s:4:\"slug\";i:1;s:6:\"[^\\/]+\";}i:2;s:1:\"/\";i:3;a:2:{i:0;s:4:\"year\";i:1;s:5:\"\\d{4}\";}i:4;s:1:\"/\";i:5;a:2:{i:0;s:5:\"month\";i:1;s:18:\"(?:0?[1-9]|1[012])\";}i:6;s:1:\"/\";i:7;a:2:{i:0;s:3:\"day\";i:1;s:27:\"(?:0?[1-9]|[12][0-9]|3[01])\";}}s:10:\"uriPattern\";s:109:\"calendar/fullcalendar/<slug:[^\\/]+>/<year:\\d{4}>/<month:(?:0?[1-9]|1[012])>/<day:(?:0?[1-9]|[12][0-9]|3[01])>\";s:9:\"sortOrder\";i:19;s:7:\"siteUid\";N;}s:36:\"73bf1d7a-020d-4f4f-b058-624d0fb92033\";a:5:{s:8:\"template\";s:30:\"/calendar/resources/event_data\";s:8:\"uriParts\";a:2:{i:0;s:30:\"calendar/resources/event_data/\";i:1;a:2:{i:0;s:6:\"number\";i:1;s:3:\"\\d+\";}}s:10:\"uriPattern\";s:42:\"calendar/resources/event_data/<number:\\d+>\";s:9:\"sortOrder\";i:20;s:7:\"siteUid\";N;}}}',NULL,'QRvPWFymXnoB','2018-09-30 15:22:58','2019-05-11 14:36:36','0434ff09-c766-4fea-a06a-d65d74f8e9f4');
/*!40000 ALTER TABLE `acr_info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixblocks`
--

LOCK TABLES `acr_matrixblocks` WRITE;
/*!40000 ALTER TABLE `acr_matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixblocks` VALUES (12,8,NULL,12,1,1,NULL,'2018-11-02 02:36:30','2019-01-27 18:25:14','2653883a-9a10-4689-92b3-5be2c7a88b9e'),(13,8,NULL,12,1,2,NULL,'2018-11-02 02:36:30','2019-01-27 18:25:14','6eb1fa73-5340-4f7e-8d98-d4f95f7e0b75'),(14,8,NULL,12,1,3,NULL,'2018-11-02 02:36:30','2019-01-27 18:25:14','e68e9fb2-416c-4fff-845c-1f5e40ac7148'),(16,8,NULL,16,2,1,NULL,'2018-12-08 01:32:00','2019-01-27 18:25:14','bded4d2a-4867-417a-8b39-5360a1dcec3c'),(17,8,NULL,16,2,2,NULL,'2018-12-08 01:32:00','2019-01-27 18:25:14','98bdaff4-081d-4ff3-a223-0e248d35b7b0'),(25,24,NULL,34,3,1,NULL,'2019-01-02 01:14:24','2019-01-21 18:24:32','ab7c1d42-3bbe-4ed4-9393-fe8c4a1b8531'),(26,24,NULL,34,3,2,NULL,'2019-01-02 01:15:08','2019-01-21 18:24:32','acc6bb57-f427-49ab-8c0f-8f44feb6e408'),(27,24,NULL,34,3,3,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','2620c1c0-d487-4aa9-b4bc-9bc568525cf7'),(28,24,NULL,34,3,4,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','e2bc5602-1f6e-4d2c-8c4a-58ee909e8d9f'),(29,24,NULL,34,3,5,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','ed6ce614-d788-4a8a-98ff-8ca4b70552d9'),(30,24,NULL,34,3,6,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','d76f4be3-3508-4dca-8f05-afc0f014703d'),(31,24,NULL,34,3,7,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','b02f456d-7417-418a-a57a-2256d103aeb0'),(32,24,NULL,34,3,8,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','a8c2ebba-ba20-4130-8167-825f64c0f4df'),(33,24,NULL,34,3,9,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','6655d7fc-2d18-4d03-94c8-5df0ad9d467c'),(35,34,NULL,39,4,1,NULL,'2019-01-23 02:51:12','2019-01-23 03:05:07','89cbf551-c137-4238-9bb9-d9abebc16422'),(36,34,NULL,39,4,2,NULL,'2019-01-23 02:51:12','2019-01-23 03:05:07','f344525d-9295-4f3d-b304-217fc61841ef'),(37,34,NULL,39,4,3,NULL,'2019-01-23 02:56:28','2019-01-23 03:05:07','08612c67-ae45-4ce8-b43e-22af1be5d9b7'),(38,34,NULL,39,4,4,NULL,'2019-01-23 02:56:29','2019-01-23 03:05:07','015cf27f-f0c3-4acb-89b6-6ade80a782c9'),(39,34,NULL,39,4,5,NULL,'2019-01-23 02:56:29','2019-01-23 03:05:07','3c523823-de0a-4d50-a26e-6af15d2496d1'),(40,34,NULL,43,5,1,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','5a7d90ec-227d-4e6b-a142-05027c70d66c'),(41,34,NULL,43,5,2,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','1207fa92-1e5a-4912-9287-52801d5bd2d8'),(42,34,NULL,43,5,3,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','451d60d6-f3fa-48e6-83b4-de069a6d07b3'),(43,34,NULL,43,5,4,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','0f26f3fe-c586-414e-b2aa-2752f8dece60'),(44,34,NULL,43,5,5,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','8e0317e6-bca4-4026-99eb-3641a04f875e'),(45,34,NULL,43,5,6,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','8a4251f4-5364-4915-a917-67e84c2a8390'),(46,34,NULL,43,5,7,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','d0777c3b-0245-4cc2-b6ac-d59330691b9f'),(47,34,NULL,43,5,8,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','b7541e46-e75b-47d3-98b3-ae5044bb1cae'),(48,34,NULL,43,5,9,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','b79b8d0a-4d5b-4e85-ab39-53b3e8b37aa1'),(49,34,NULL,43,5,10,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','68de242f-6712-44cc-960d-733768338eeb'),(68,6,NULL,46,6,1,NULL,'2019-02-05 02:46:19','2019-02-05 02:46:19','88ca115e-efc4-46ad-affc-eafeed06dbc7'),(69,6,NULL,46,6,2,NULL,'2019-02-05 02:46:19','2019-02-05 02:46:19','59baae00-0d63-4ac5-9903-38508ec68be7'),(70,6,NULL,46,6,3,NULL,'2019-02-05 02:46:19','2019-02-05 02:46:19','798cba98-ab36-4062-90a1-aa5d80c18517'),(71,6,NULL,46,6,4,NULL,'2019-02-05 02:46:19','2019-02-05 02:46:19','ee7978fd-341b-4662-ad18-eade191599e0'),(72,6,NULL,46,6,5,NULL,'2019-02-05 02:46:19','2019-02-05 02:46:19','5e31c094-33b6-4de3-9d3b-ea8216a3d701'),(73,6,NULL,46,6,6,NULL,'2019-02-05 02:46:19','2019-02-05 02:46:19','849a8be3-4759-4d58-bd9f-b94668e7bf87'),(74,6,NULL,46,6,7,NULL,'2019-02-05 02:46:19','2019-02-05 02:46:19','ff5403ea-f79c-4abf-a992-009694b6a1af'),(75,6,NULL,46,6,8,NULL,'2019-02-05 02:46:19','2019-02-05 02:46:19','6f45935b-ae27-4256-8ee5-58e666ae4d96'),(76,6,NULL,46,6,9,NULL,'2019-02-05 02:46:19','2019-02-05 02:46:19','8d8f7e11-7561-4ad7-a79a-dbbe0248b6fd'),(77,6,NULL,46,6,10,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','a3da4f3d-f2b3-4c6d-9654-93a9de55735a'),(78,6,NULL,46,6,11,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','bf87815a-c67e-47ee-9daa-4b02866e2d33'),(79,6,NULL,46,6,12,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','4d437f21-e051-48a5-ad26-82813a81dd30'),(80,6,NULL,46,6,13,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','ce7a31e1-5c90-4b34-9471-b1907d57e86c'),(81,6,NULL,46,6,14,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','a9f76b65-1eef-4eed-85ec-e65ae2409cb9'),(82,6,NULL,46,6,15,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','06f2ed02-7416-45f9-aa4d-c9fc575cdbf5'),(83,6,NULL,46,6,16,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','c33a0759-dc26-4d3c-86a6-817d7258b687'),(84,6,NULL,46,6,17,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','674c49ea-9629-4070-a6d5-0bf18ccfd443'),(85,6,NULL,46,6,18,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','1fa85600-8644-4bc1-9c7d-0136354b8768'),(86,6,NULL,46,6,19,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','f9024a3e-7d52-4f2d-813e-708bb45a5a74'),(87,6,NULL,46,6,20,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','875c8ed1-1851-451a-a99d-d9e2871d0fa6'),(88,6,NULL,46,6,21,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','55298252-31c3-4d25-873b-4d870d38e7e5'),(89,6,NULL,46,6,22,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','806e62b1-2fa6-45e9-a372-f3cdb2e207f4'),(90,6,NULL,46,6,23,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','5fbb91c4-a269-4406-a07e-8f9111c0c010'),(91,6,NULL,46,6,24,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','429f353a-ff43-4bbc-bc6c-882b81371448'),(92,6,NULL,46,6,25,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','7d1f8448-7d66-44bc-9c3e-82d5ba586746'),(93,6,NULL,46,6,26,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','e4a7d12e-3d1c-4c7d-85e1-2b2e2dbdeb3d'),(94,6,NULL,46,6,27,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','259652cf-71eb-48c8-8209-bd0289175202'),(95,6,NULL,46,6,28,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','0c210f91-7472-4911-89c8-3cbfd6d1bb1e'),(96,6,NULL,46,6,29,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','5b8ec728-07fe-4fc6-b8ee-2b894ad84f49'),(97,6,NULL,46,6,30,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','2f903e0e-c3cd-4ae4-af8e-0adfc7f18110'),(98,6,NULL,46,6,31,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','04cec18b-3d86-4c0c-8140-4f4bedda993a'),(99,6,NULL,46,6,32,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','3a33dd3c-51a8-4fe4-8d36-3b337b3b0a8e'),(100,6,NULL,46,6,33,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','4e262d5f-a3d6-4d58-9a05-7e498d249d8b'),(101,6,NULL,46,6,34,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','b7683152-bbf9-4f5d-9fc8-39f655678d89'),(102,6,NULL,46,6,35,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','3b0186fd-143e-40f1-a6be-4c6da5d925b7'),(103,6,NULL,46,6,36,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','a3e6c0b3-ac57-4886-8149-744eef981c35'),(104,6,NULL,46,6,37,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','5ca25d12-38fd-4070-be08-83436aa03df0'),(105,6,NULL,46,6,38,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','5693426c-9198-4d35-a7c9-dae94f07cc5f'),(106,6,NULL,46,6,39,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','e76ee542-5c6e-4aef-a63d-c623fb977726'),(107,6,NULL,46,6,40,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','8f38017f-cd53-4a9d-bff8-25e465a39c3d'),(108,6,NULL,46,6,41,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','44703524-d93b-4cc6-ae30-9ec71128f89f'),(109,6,NULL,46,6,42,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','e98e5979-17b9-42dc-9837-63397f184b28'),(110,6,NULL,46,6,43,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','80ad1a0f-4eeb-4038-8473-04c1a527ed7f'),(111,6,NULL,46,6,44,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','14647e85-610a-4b04-8fee-87376bb4d5e3'),(112,6,NULL,46,6,45,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','c7ecf94e-1599-4d5a-901a-615c6357ef54'),(113,6,NULL,46,6,46,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','0d9a2344-60f9-4f25-9ef3-f4cd58b3866c'),(114,6,NULL,46,6,47,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','893e6e3a-ba8a-4872-9bd0-86e85330df28'),(115,6,NULL,46,6,48,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','ae22effb-ed82-4d9d-954a-3308087fbeb4'),(116,6,NULL,46,6,49,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','17c87349-6d5e-4375-a055-844069d32cad'),(117,6,NULL,46,6,50,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','ab3118be-0768-44de-89e0-376c016c4f7c'),(118,6,NULL,46,6,51,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','8921fe85-e23e-4c89-badf-883f0918df4d'),(119,6,NULL,46,6,52,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','36b3bfa1-4d63-49a5-b746-16a05cb2ef53'),(120,6,NULL,46,6,53,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','e1617ff6-1fb9-45db-af4a-b25ab5d092b3'),(121,6,NULL,46,6,54,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','2e585f04-f833-4d7b-95da-02d90dba095a'),(122,6,NULL,46,6,55,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','7b3b8b36-c121-47da-96dc-ba817b0503b0'),(123,6,NULL,46,6,56,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','29f3c431-a3ae-4625-86ba-37848c266cc2'),(124,6,NULL,46,6,57,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','e7f4d06d-f19d-4029-9096-e5d35d178dc6'),(125,6,NULL,46,6,58,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','bddb333b-e8d6-4153-b819-bc613ca0ba7b'),(126,6,NULL,46,6,59,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','6ff27d4c-7ab6-4577-95b6-38914731d5b3'),(127,6,NULL,46,6,60,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','9e7ff64f-2e1d-460e-83a3-0221297e5a26'),(128,6,NULL,46,6,61,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','5cecb4fe-af69-4906-9585-442c2f731a8b'),(129,6,NULL,46,6,62,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','c8504a19-fc74-49e8-9804-8c248efc283b'),(130,6,NULL,46,6,63,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','02abac73-3f49-4230-b046-e1518e17a955'),(131,6,NULL,46,6,64,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','6091870b-ba0f-4758-8f46-4840b07af55b'),(132,6,NULL,46,6,65,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','7cc57a15-3316-435f-a9ff-c83b97286a4a'),(133,6,NULL,46,6,66,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','6770e9a9-5dc6-48ca-ae02-0766752940de'),(134,6,NULL,46,6,67,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','94a34266-938c-4680-8017-2c518962834f'),(135,6,NULL,46,6,68,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','f950dbbe-cd9b-4b0a-bfa0-697a4100c17e'),(136,6,NULL,46,6,69,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','e6b0237b-862d-4a5f-8c39-27e74da8ef83'),(137,6,NULL,46,6,70,NULL,'2019-02-05 02:46:20','2019-02-05 02:46:20','3684900b-6df7-4578-96e2-bad47963c89b'),(138,6,NULL,46,6,71,NULL,'2019-02-05 02:46:21','2019-02-05 02:46:21','241560ff-8708-462c-a9f5-562501635cbb'),(139,6,NULL,46,6,72,NULL,'2019-02-05 02:46:21','2019-02-05 02:46:21','8384ae6f-74cc-4a09-9ce6-dcb1b198ca4b'),(140,6,NULL,46,6,73,NULL,'2019-02-05 02:46:21','2019-02-05 02:46:21','7425fc6a-03d0-4936-84df-01e332dfe302'),(141,6,NULL,46,6,74,NULL,'2019-02-05 02:46:21','2019-02-05 02:46:21','948c6840-275f-455b-b697-fb30a3c05e81'),(142,6,NULL,46,6,75,NULL,'2019-02-05 02:46:21','2019-02-05 02:46:21','843f5936-6ccf-446a-b473-4f32f3d48ca2'),(143,6,NULL,46,6,76,NULL,'2019-02-05 02:46:21','2019-02-05 02:46:21','da672f87-c6a2-4004-bb11-2dd4242c30ff'),(144,6,NULL,46,6,77,NULL,'2019-02-05 02:46:21','2019-02-05 02:46:21','26153e1a-53c5-4b5d-b91a-428e63db2360'),(145,6,NULL,46,6,78,NULL,'2019-02-05 02:46:21','2019-02-05 02:46:21','6de69370-36f8-4406-bba2-be92c43111b0'),(146,6,NULL,46,6,79,NULL,'2019-02-05 02:46:21','2019-02-05 02:46:21','3c332531-d485-489f-be3e-56f152cd2f2f'),(149,148,NULL,48,7,1,0,'2019-02-10 01:33:17','2019-02-10 01:33:17','825b7ebb-ee95-408d-a3f8-52d04db15ae3'),(150,148,NULL,48,7,2,0,'2019-02-10 01:33:18','2019-02-10 01:33:18','2d96b39a-7d77-43f4-903f-bf3a2f350285'),(151,148,NULL,48,7,3,0,'2019-02-10 01:33:18','2019-02-10 01:33:18','94b352e0-aa0d-4195-a8be-cc4ea17f618f'),(152,148,NULL,48,7,4,0,'2019-02-10 01:33:18','2019-02-10 01:33:18','5ce76a8c-971c-4d21-8b30-98a5fcb45408'),(153,148,NULL,48,7,1,NULL,'2019-02-10 01:33:18','2019-02-10 15:01:02','31b10019-1423-4e51-9cfc-979f0b7fdee9'),(154,148,NULL,48,7,2,NULL,'2019-02-10 01:33:18','2019-02-10 15:01:02','31741392-7724-4848-aefa-29b8bb1ef44c'),(155,148,NULL,48,7,3,NULL,'2019-02-10 01:33:18','2019-02-10 15:01:02','3fadc712-0e5a-4d5f-b521-26fd57844487'),(156,148,NULL,48,7,4,NULL,'2019-02-10 01:33:18','2019-02-10 15:01:02','633cbed8-fb88-4c9d-8f8d-a7fc76055d52'),(157,148,NULL,48,7,5,NULL,'2019-02-10 01:33:49','2019-02-10 15:01:02','863c0421-f3b9-440d-a668-267469899227'),(158,148,NULL,48,7,6,NULL,'2019-02-10 01:38:23','2019-02-10 15:01:02','82763470-7147-4cd2-a744-04e7f0f82278'),(159,148,NULL,48,7,7,NULL,'2019-02-10 01:38:23','2019-02-10 15:01:02','596e2e28-47a4-4cac-b151-82d45a5331ae'),(160,148,NULL,48,7,8,NULL,'2019-02-10 01:38:24','2019-02-10 15:01:02','ef6e25d8-e5bd-4fdf-82cc-23f5604a1fbf'),(161,148,NULL,48,7,9,NULL,'2019-02-10 01:38:24','2019-02-10 15:01:02','77871a16-069a-49dd-8a5a-d96e436f0b3f'),(162,148,NULL,48,7,10,NULL,'2019-02-10 01:38:24','2019-02-10 15:01:02','107714fb-4b0f-42c1-969b-6b6ff1ce7d64'),(163,148,NULL,48,7,11,NULL,'2019-02-10 01:38:24','2019-02-10 15:01:02','d3184459-3c11-40fd-8759-20935e03730f'),(164,148,NULL,48,7,12,NULL,'2019-02-10 01:38:24','2019-02-10 15:01:03','ded84e63-83c6-4b58-b767-c5c0fb9dd0ab'),(165,148,NULL,48,7,13,NULL,'2019-02-10 01:38:24','2019-02-10 15:01:03','c5aeb9f0-29a1-4660-8888-f33618ec5dac'),(166,148,NULL,48,7,14,NULL,'2019-02-10 01:38:24','2019-02-10 15:01:03','de71a25a-db6d-4f9d-9e82-895306f98b4f'),(167,148,NULL,48,7,15,NULL,'2019-02-10 01:38:24','2019-02-10 15:01:03','350e36e7-8983-49cb-9a23-477976f66c82'),(168,148,NULL,48,7,16,NULL,'2019-02-10 01:42:49','2019-02-10 15:01:03','0adf0b70-c30b-4ba2-bb44-8f1604776814'),(169,148,NULL,48,7,17,NULL,'2019-02-10 01:42:49','2019-02-10 15:01:03','175ae703-7716-4a51-ab2d-5963b7cf669c'),(170,148,NULL,48,7,18,NULL,'2019-02-10 01:42:49','2019-02-10 15:01:03','d5989fa9-b8ec-4437-ac28-3297c25dffb1'),(171,148,NULL,48,7,19,NULL,'2019-02-10 01:42:49','2019-02-10 15:01:03','97fdab74-03fd-42ae-adc1-b8e3317a851b'),(172,148,NULL,48,7,20,NULL,'2019-02-10 01:42:49','2019-02-10 15:01:03','4c34d892-0d30-4409-927d-763cbfd813e9'),(173,148,NULL,48,7,21,NULL,'2019-02-10 01:42:49','2019-02-10 15:01:03','afe0a928-131a-421d-9df2-5c1ca7a216a9'),(174,148,NULL,48,7,22,NULL,'2019-02-10 01:42:49','2019-02-10 15:01:03','7f95e9a8-05d9-48e4-8753-83424ca29529'),(175,148,NULL,48,7,23,NULL,'2019-02-10 01:42:49','2019-02-10 15:01:03','ed616aa3-454f-4ff6-9349-62de635fe8fa'),(176,148,NULL,48,7,24,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','56e36041-8a9a-4ba4-955e-34995f1ae39e'),(177,148,NULL,48,7,25,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','26f7ec36-0205-4d59-8663-8d14b50fe3fa'),(178,148,NULL,48,7,26,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','2fe88407-db87-4021-a7e2-74f4936d45a6'),(179,148,NULL,48,7,27,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','3415992b-aca6-4b5d-9e99-a2a71b46a438'),(180,148,NULL,48,7,28,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','e3625fd9-33e4-4817-8ef6-01bb5a5c5ed1'),(181,148,NULL,48,7,29,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','4644dbcb-82f4-4a58-bf41-d6c2d0209980'),(182,148,NULL,48,7,30,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','4b7adf80-d8b4-464b-9005-ffeaffcde95a'),(183,148,NULL,48,7,31,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','42441b42-9b54-4716-a80c-df6e50ecb938'),(184,148,NULL,48,7,32,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','eb0f9edd-ab9d-4fb7-868b-647acfdb668a'),(185,148,NULL,48,7,33,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','5c63b014-0b32-48bc-a12c-840340c913fb'),(186,148,NULL,48,7,34,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','73faac16-d5bf-430e-8822-9fe434c09d33'),(187,148,NULL,48,7,35,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','2bc6312e-8076-46d7-8516-956529ade4a7'),(188,148,NULL,48,7,36,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','912add00-c43a-4a34-b160-ab1b74a0bc83'),(189,148,NULL,48,7,37,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','3d9c0929-8da9-47e8-9df7-29fc6fba5772'),(190,148,NULL,48,7,38,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','d2f2d452-02fd-4131-820e-70beea49ccad'),(191,148,NULL,48,7,39,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','c80ab0fe-b798-41f0-a0f0-9ae5f6d3e8b1'),(192,148,NULL,48,7,40,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','d05f43f6-763a-4556-abb3-8b2b95b1d414'),(193,148,NULL,48,7,41,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','204b4207-b748-45db-ade9-10d48c2a7a53'),(194,148,NULL,48,7,42,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','68274b83-43f8-4c6c-aecf-1c109ca093ed'),(195,148,NULL,48,7,43,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','d4961976-0a62-47a3-9fc4-9853b35a46c5'),(196,148,NULL,48,7,44,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','40578dc1-21bb-4d88-acc8-3edd14731637'),(197,148,NULL,48,7,45,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','d6fcd484-fec6-48a2-81f4-f6ccbb2a8b4c'),(198,148,NULL,48,7,46,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','f3aa33ca-dcda-4c09-abaa-a5f47427d418'),(199,148,NULL,48,7,47,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','87701c81-86f7-4373-a84e-82a1199a8e33'),(200,148,NULL,48,7,48,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','e19d12a9-2137-4001-8dd7-2d7dc8fd514d'),(201,148,NULL,48,7,49,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','d03c5953-9f50-4b4a-b5ce-920a9cfbdbba'),(202,148,NULL,48,7,50,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','177b1b13-eb13-4e11-af06-ebd84644b044'),(203,148,NULL,48,7,51,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','98be93b0-d7ca-448d-a440-52a884544599'),(204,148,NULL,48,7,52,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','4d42a885-2977-4bac-8019-479aaba00719'),(205,148,NULL,48,7,53,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','0c87d126-1d11-46b0-b224-b1377697da0a'),(206,148,NULL,48,7,54,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','5f23fa14-3320-43ed-af0d-cd9099480ab4'),(207,148,NULL,48,7,55,NULL,'2019-02-10 02:02:42','2019-02-10 15:01:03','ce92502c-756d-4f96-a58f-afac9af95c81'),(208,148,NULL,48,7,56,NULL,'2019-02-10 14:50:02','2019-02-10 15:01:03','b727a1ee-4d76-45bf-add3-68ba2b4d8b34'),(209,148,NULL,48,7,57,NULL,'2019-02-10 14:50:02','2019-02-10 15:01:03','43612dc9-3589-4ea2-b44c-584a4babb86e'),(210,148,NULL,48,7,58,NULL,'2019-02-10 14:51:49','2019-02-10 15:01:03','7781be58-8f7e-4cca-8e5e-58b72d1d34f2'),(211,148,NULL,48,7,59,NULL,'2019-02-10 14:51:49','2019-02-10 15:01:03','417d8005-d8cd-4259-aa78-befda56d3710'),(212,148,NULL,48,7,60,NULL,'2019-02-10 14:51:49','2019-02-10 15:01:03','a3169fa3-f520-4280-9366-680cf264a159'),(213,148,NULL,48,7,61,NULL,'2019-02-10 14:51:49','2019-02-10 15:01:03','ed9dc1a1-8f84-4d26-bebd-4802fb4c1549'),(214,148,NULL,48,7,62,NULL,'2019-02-10 14:51:49','2019-02-10 15:01:03','f716dd4d-da00-4853-be26-d997c9adcb2a'),(215,148,NULL,48,7,63,NULL,'2019-02-10 15:01:03','2019-02-10 15:01:03','7e68806a-1dbf-41c8-950e-88681e5427bc'),(216,148,NULL,48,7,64,NULL,'2019-02-10 15:01:03','2019-02-10 15:01:03','9e29ab41-c764-4f24-83ea-9a0f92da36bd'),(217,148,NULL,48,7,65,NULL,'2019-02-10 15:01:03','2019-02-10 15:01:03','6f5b1475-8194-40c5-b34e-ccadb04ac938'),(218,148,NULL,48,7,66,NULL,'2019-02-10 15:01:03','2019-02-10 15:01:03','ffb2d775-7266-415d-b4a5-30ee43d6842c'),(219,148,NULL,48,7,67,NULL,'2019-02-10 15:01:04','2019-02-10 15:01:04','b066c51a-a907-487f-9ab8-31b514cceaf8'),(225,224,NULL,56,10,1,NULL,'2019-05-11 14:36:59','2019-05-11 15:00:35','387dc471-035c-4767-b699-e4aba563e4ef'),(227,226,NULL,56,10,1,NULL,'2019-05-11 14:46:39','2019-05-11 15:01:18','575e77ef-28b1-4de3-8c78-e4d9dcf1b215'),(228,226,NULL,56,10,2,NULL,'2019-05-11 14:58:07','2019-05-11 15:01:18','1c8dca54-869f-47c8-9149-46b5b77ed944'),(229,224,NULL,56,10,2,NULL,'2019-05-11 15:00:35','2019-05-11 15:00:35','22fbc61d-b362-431b-8e77-89bc6df08265'),(230,224,NULL,56,10,3,NULL,'2019-05-11 15:00:35','2019-05-11 15:00:35','1e5609ba-4f35-4b19-b6c4-e00c8e9f7c31'),(231,224,NULL,56,10,4,NULL,'2019-05-11 15:00:35','2019-05-11 15:00:35','30548694-2177-46e1-a276-5baabff017f0'),(232,224,NULL,56,10,5,NULL,'2019-05-11 15:00:35','2019-05-11 15:00:35','140bf7a6-4e29-4e3d-a66e-053e86317c56'),(233,224,NULL,56,10,6,NULL,'2019-05-11 15:00:35','2019-05-11 15:00:35','5f32f65d-d780-42e0-8822-c7e3c6b3d40b'),(234,224,NULL,56,10,7,NULL,'2019-05-11 15:00:35','2019-05-11 15:00:35','46427ae9-30ee-4a6d-9fc5-54896aa1d5c2'),(235,224,NULL,56,10,8,NULL,'2019-05-11 15:00:35','2019-05-11 15:00:35','6255f643-593a-4588-912f-dd5907ceea78'),(236,224,NULL,56,10,9,NULL,'2019-05-11 15:00:35','2019-05-11 15:00:35','0d97daad-e11b-4022-a8bd-fb70def96b4e'),(237,224,NULL,56,10,10,NULL,'2019-05-11 15:00:35','2019-05-11 15:00:35','dbf24fb4-3012-4978-9682-b23e370a9aa7'),(238,226,NULL,56,10,3,NULL,'2019-05-11 15:01:18','2019-05-11 15:01:18','c0845092-c565-451f-b614-c30b55619282'),(239,226,NULL,56,10,4,NULL,'2019-05-11 15:01:18','2019-05-11 15:01:18','6f973122-6c0d-492b-808a-54b2c48276a6'),(240,226,NULL,56,10,5,NULL,'2019-05-11 15:01:18','2019-05-11 15:01:18','8a768429-31c7-43b0-b968-a64b43b754a0'),(242,241,NULL,56,10,1,NULL,'2019-05-11 15:02:03','2019-05-11 15:02:03','5ae4957c-6ce1-41e8-a7fa-018822dba918'),(243,241,NULL,56,10,2,NULL,'2019-05-11 15:02:03','2019-05-11 15:02:03','2a0f3d55-fa1e-4552-aa8d-f3186b5ece49'),(244,241,NULL,56,10,3,NULL,'2019-05-11 15:02:03','2019-05-11 15:02:03','3d275772-fde6-46ea-9bdd-cf59250c6620'),(245,241,NULL,56,10,4,NULL,'2019-05-11 15:02:03','2019-05-11 15:02:03','a018b6d4-50a0-4772-9df6-1f824d18122f'),(246,241,NULL,56,10,5,NULL,'2019-05-11 15:02:03','2019-05-11 15:02:03','082d1e66-2db6-4a6c-8e10-78e396272673'),(247,241,NULL,56,10,6,NULL,'2019-05-11 15:02:03','2019-05-11 15:02:03','337d1a07-ee17-4ac6-aeae-6eed5d25289f'),(249,248,NULL,56,10,1,NULL,'2019-05-11 15:03:48','2019-05-11 15:03:48','4f11bb77-31a9-451b-9e5a-dfdc7652a70b'),(250,248,NULL,56,10,2,NULL,'2019-05-11 15:03:48','2019-05-11 15:03:48','d7ab61f6-6934-456c-8162-23f09aff6184'),(251,248,NULL,56,10,3,NULL,'2019-05-11 15:03:48','2019-05-11 15:03:48','1ec1c221-2137-4a35-90d7-a6209871a650'),(252,248,NULL,56,10,4,NULL,'2019-05-11 15:03:48','2019-05-11 15:03:48','143ce649-69a2-42ef-a681-3d7179f4a74e'),(253,248,NULL,56,10,5,NULL,'2019-05-11 15:03:48','2019-05-11 15:03:48','fc580121-bb80-4d68-9f22-04fee4aac6ac'),(254,248,NULL,56,10,6,NULL,'2019-05-11 15:03:48','2019-05-11 15:03:48','abcfef25-054c-49b1-a11c-1b54a8d592d7'),(255,248,NULL,56,10,7,NULL,'2019-05-11 15:03:48','2019-05-11 15:03:48','36fff2bd-e288-4647-8215-27231f45876a'),(257,256,NULL,56,10,1,NULL,'2019-05-11 15:04:48','2019-05-11 15:04:48','8a4571ac-053e-47c6-81a9-29d42f28a0f7'),(258,256,NULL,56,10,2,NULL,'2019-05-11 15:04:48','2019-05-11 15:04:48','cd3ba4cc-b933-419d-8f60-4eab27b5797f'),(259,256,NULL,56,10,3,NULL,'2019-05-11 15:04:48','2019-05-11 15:04:48','3e699fe1-fb14-4738-b9c7-ba7209abc44d'),(260,256,NULL,56,10,4,NULL,'2019-05-11 15:04:48','2019-05-11 15:04:48','68591615-bc00-4c8b-8e96-6e0280a02ea2'),(261,256,NULL,56,10,5,NULL,'2019-05-11 15:04:48','2019-05-11 15:04:48','e63b8fbf-749c-4ff9-8765-4b1a59cd7f44'),(263,262,NULL,56,10,1,NULL,'2019-05-11 15:05:30','2019-05-11 15:05:30','36fdbd39-a2a6-4dfc-8b91-b4c41b11ded5'),(264,262,NULL,56,10,2,NULL,'2019-05-11 15:05:30','2019-05-11 15:05:30','d9fc279b-53ef-444d-a9e4-b7550346ffe0'),(265,262,NULL,56,10,3,NULL,'2019-05-11 15:05:30','2019-05-11 15:05:30','7dd86b28-505b-4cdc-9c94-4618b061d1e5'),(266,262,NULL,56,10,4,NULL,'2019-05-11 15:05:30','2019-05-11 15:05:30','748dca44-d219-457d-91fc-9e8691a3bd85'),(267,262,NULL,56,10,5,NULL,'2019-05-11 15:05:30','2019-05-11 15:05:30','ae0199ee-8e7e-4a65-8466-56a5bf3918d2'),(268,262,NULL,56,10,6,NULL,'2019-05-11 15:05:30','2019-05-11 15:05:30','011478d8-56ac-4865-8cec-cb5168f5d114'),(269,262,NULL,56,10,7,NULL,'2019-05-11 15:05:30','2019-05-11 15:05:30','3c01d987-1cb8-4f8e-882d-dbe8789af1eb'),(270,262,NULL,56,10,8,NULL,'2019-05-11 15:05:30','2019-05-11 15:05:30','a1c4d4a5-6923-427e-8501-436bd6c3f063'),(272,271,NULL,56,10,1,NULL,'2019-05-11 15:06:18','2019-05-11 15:06:18','cdca2a4d-d9da-4b2a-bea5-049937699f81'),(273,271,NULL,56,10,2,NULL,'2019-05-11 15:06:18','2019-05-11 15:06:18','78f2bb38-0568-401b-91b6-3ea60aa26692'),(274,271,NULL,56,10,3,NULL,'2019-05-11 15:06:18','2019-05-11 15:06:18','a10224b1-d8bf-4e0e-9280-8e87817d7e39'),(275,271,NULL,56,10,4,NULL,'2019-05-11 15:06:18','2019-05-11 15:06:18','331a3948-a49d-4e9b-a522-396212a266a1'),(276,271,NULL,56,10,5,NULL,'2019-05-11 15:06:18','2019-05-11 15:06:18','9f17b55d-dcb0-4dfe-9d52-489894d079ed'),(277,271,NULL,56,10,6,NULL,'2019-05-11 15:06:18','2019-05-11 15:06:18','83f69f4a-c626-459f-83cc-86e255ba59aa'),(278,271,NULL,56,10,7,NULL,'2019-05-11 15:06:18','2019-05-11 15:06:18','1c13488b-7264-4374-a595-feaeda761244'),(279,271,NULL,56,10,8,NULL,'2019-05-11 15:06:18','2019-05-11 15:06:18','2a81208f-b593-4f2a-90d3-9f94b9f3db71'),(281,280,NULL,56,10,1,NULL,'2019-05-11 15:07:00','2019-05-11 15:07:00','8748aec3-77ba-42ad-a0ac-d6d088e1f086'),(282,280,NULL,56,10,2,NULL,'2019-05-11 15:07:00','2019-05-11 15:07:00','380e4b27-ef7e-486c-93a8-32b09eb18ed3'),(283,280,NULL,56,10,3,NULL,'2019-05-11 15:07:00','2019-05-11 15:07:00','cc60bfe2-2c52-41ce-8d92-198f8f318a31'),(284,280,NULL,56,10,4,NULL,'2019-05-11 15:07:00','2019-05-11 15:07:00','8f01c32b-0046-4922-b71c-a485c0862375'),(285,280,NULL,56,10,5,NULL,'2019-05-11 15:07:00','2019-05-11 15:07:00','c3c82978-0b40-4dec-b64a-d60e18443667'),(286,280,NULL,56,10,6,NULL,'2019-05-11 15:07:00','2019-05-11 15:07:00','b585e83b-2db5-4077-91da-57b4def7a8e2'),(287,280,NULL,56,10,7,NULL,'2019-05-11 15:07:00','2019-05-11 15:07:00','c8b56b1b-c81d-4d0b-a412-c1b050540d65'),(288,280,NULL,56,10,8,NULL,'2019-05-11 15:07:00','2019-05-11 15:07:00','6bff11c3-3b04-4764-92b9-df92524ba521'),(290,289,NULL,56,10,1,NULL,'2019-05-11 15:07:44','2019-05-11 15:07:44','009dd0b5-7910-4d2a-a1a8-2ef7d1465350'),(291,289,NULL,56,10,2,NULL,'2019-05-11 15:07:44','2019-05-11 15:07:44','81fc4cf2-6ded-4232-9338-4ef010cf8ca2'),(292,289,NULL,56,10,3,NULL,'2019-05-11 15:07:44','2019-05-11 15:07:44','ec1dbe03-2d9c-413d-9339-87e8ea420dae'),(293,289,NULL,56,10,4,NULL,'2019-05-11 15:07:44','2019-05-11 15:07:44','991fddab-f27d-4bdf-a6f3-488b64b56d37'),(294,289,NULL,56,10,5,NULL,'2019-05-11 15:07:44','2019-05-11 15:07:44','442e520d-aa85-4108-ad1a-b713f060862d'),(295,289,NULL,56,10,6,NULL,'2019-05-11 15:07:44','2019-05-11 15:07:44','1e4f0b5c-5016-4eb2-a1b6-74dbee0a9947'),(296,289,NULL,56,10,7,NULL,'2019-05-11 15:07:44','2019-05-11 15:07:44','4a7fda5f-d8db-466d-acca-90cf2902b38d'),(297,289,NULL,56,10,8,NULL,'2019-05-11 15:07:44','2019-05-11 15:07:44','86210a1d-e3c1-4f80-9220-f0a1d81db353'),(299,298,NULL,56,10,1,NULL,'2019-05-11 15:08:26','2019-05-11 15:08:26','704d9b5e-702d-4104-bfa7-1ac158a55513'),(300,298,NULL,56,10,2,NULL,'2019-05-11 15:08:26','2019-05-11 15:08:26','c027d73e-9bf5-42c7-b936-ca7242734305'),(301,298,NULL,56,10,3,NULL,'2019-05-11 15:08:26','2019-05-11 15:08:26','0699dd4d-4901-4c52-a43c-2ad127d840ab'),(302,298,NULL,56,10,4,NULL,'2019-05-11 15:08:26','2019-05-11 15:08:26','80d2faef-f901-49d4-ac44-7fd981f65811'),(303,298,NULL,56,10,5,NULL,'2019-05-11 15:08:26','2019-05-11 15:08:26','d22e53a6-d3be-4b13-ba84-a0a2a75049de'),(304,298,NULL,56,10,6,NULL,'2019-05-11 15:08:26','2019-05-11 15:08:26','cbf26c97-1cc4-494c-80db-f0f050347615'),(305,298,NULL,56,10,7,NULL,'2019-05-11 15:08:26','2019-05-11 15:08:26','11b0082c-0b6e-4f1a-8046-cbec2d3ec688'),(306,298,NULL,56,10,8,NULL,'2019-05-11 15:08:26','2019-05-11 15:08:26','8e59dbcd-ef77-47e9-a06b-dc1ad4a10458'),(308,307,NULL,56,10,1,NULL,'2019-05-11 15:09:10','2019-05-11 15:09:10','860e28c4-be5d-4d6a-8af1-0d24f60909b5'),(309,307,NULL,56,10,2,NULL,'2019-05-11 15:09:10','2019-05-11 15:09:10','09a63ddc-120d-431b-a873-e6b18280d7ea'),(310,307,NULL,56,10,3,NULL,'2019-05-11 15:09:10','2019-05-11 15:09:10','8f6cc479-5aaf-4c78-86c2-3641e3e4f84f'),(311,307,NULL,56,10,4,NULL,'2019-05-11 15:09:10','2019-05-11 15:09:10','cd0c029f-16fe-4ec8-9a15-b9a39998f670'),(312,307,NULL,56,10,5,NULL,'2019-05-11 15:09:10','2019-05-11 15:09:10','4c33404d-f284-4358-84fe-58fd0b30326f'),(313,307,NULL,56,10,6,NULL,'2019-05-11 15:09:10','2019-05-11 15:09:10','7e6290d9-dc75-45ff-a7d4-60266be0ef3e'),(314,307,NULL,56,10,7,NULL,'2019-05-11 15:09:10','2019-05-11 15:09:10','8afdd181-d916-43b6-9949-71fc32f71e70'),(315,307,NULL,56,10,8,NULL,'2019-05-11 15:09:10','2019-05-11 15:09:10','56e11505-73f4-4fcc-a5f1-46813c4535b3');
/*!40000 ALTER TABLE `acr_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixblocktypes`
--

LOCK TABLES `acr_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `acr_matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixblocktypes` VALUES (1,12,9,'Service','service',1,'2018-11-02 02:34:57','2019-01-17 02:45:24','ad0dc2b4-7b01-48f6-9596-8c8dad66a4b1'),(2,16,10,'Call To Action','callToAction',1,'2018-12-08 01:29:41','2019-01-17 02:45:24','a18a4a20-6a90-4d48-8995-8ab7941dcc11'),(3,34,18,'Store Location','storeLocation',1,'2019-01-02 01:11:47','2019-01-21 18:21:58','c773ee36-d4bd-4d3c-8a25-e904a163d34e'),(4,39,19,'Initiative','initiative',1,'2019-01-23 02:50:14','2019-01-23 02:57:52','cd5cbfa7-0720-49c3-8c87-eca987b0e498'),(5,43,21,'Initiative','teamInitiative',1,'2019-01-23 03:03:52','2019-01-23 03:03:52','3334d866-45d7-4fa3-b627-7c7470d3687a'),(6,46,23,'Result','result',1,'2019-02-05 02:31:48','2019-02-05 02:31:48','2b703ea5-e694-4433-8977-1b00f3a9259a'),(7,48,24,'Vendor','vendor',1,'2019-02-10 01:29:56','2019-02-10 01:29:56','8cd2da25-6028-4e91-aceb-25283dbdf155'),(10,56,31,'Recipient','recipient',1,'2019-05-11 14:36:36','2019-05-11 14:36:36','ccfa9a8b-8bbd-4c93-b9ef-437d2260aa8f');
/*!40000 ALTER TABLE `acr_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixcontent_acrcaresinitiatives`
--

LOCK TABLES `acr_matrixcontent_acrcaresinitiatives` WRITE;
/*!40000 ALTER TABLE `acr_matrixcontent_acrcaresinitiatives` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixcontent_acrcaresinitiatives` VALUES (1,35,1,'2019-01-23 02:51:12','2019-01-23 03:05:07','49c288a6-2efc-434e-ace5-f225bd42407e','Roc Solid Foundations','Roc Solid Foundation® builds hope for children battling cancer and their families by offering opportunities for them to do what they do best – play. Roc Solid partners with local groups to build playsets and remodel the rooms of children battling cancer. ACR Cares will be building a playset with Roc Solid October 2018.'),(2,36,1,'2019-01-23 02:51:12','2019-01-23 03:05:07','a5e84a94-675d-4a86-9f7f-61485f790343','Ronald McDonald House','Providing stability and resources for families everywhere. ACR Cares partners with the local Ronald McDonald House’s to cook meals, provide gifts and needed materials at Christmas time, and sponsors a family every Christmas.'),(3,37,1,'2019-01-23 02:56:28','2019-01-23 03:05:07','dd049d01-d836-43ea-893d-36fe22748ef0','Operation Resolute','Operation Resolute® is a non-profit organization based in North Carolina that is dedicated to sustaining and strengthening families within the US Armed Forces by serving with and working through military chaplains. By partnering with chaplains, Operation Resolute® works within the parameters of the US military while adorning the Gospel by being salt and light. ACR Cares partners with Operation Resolute by hosting Daddy Daughter dances, spouse retreats, and other events.'),(4,38,1,'2019-01-23 02:56:29','2019-01-23 03:05:07','171df002-ad5b-4f37-8d90-065bbf622483','Burkina Faso','ACR Cares is currently building an Orphanage in the country of Burkina Faso.'),(5,39,1,'2019-01-23 02:56:29','2019-01-23 03:05:07','6ae0b968-7530-4fb8-bc0e-1085db32bcc9','Human Coalition','Human Coalition is a group dedicated to helping women at risk of having an abortion see the beauty of choosing life. ACR Cares takes part in the annual  fundraising event, 4000 Steps.');
/*!40000 ALTER TABLE `acr_matrixcontent_acrcaresinitiatives` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixcontent_ctas`
--

LOCK TABLES `acr_matrixcontent_ctas` WRITE;
/*!40000 ALTER TABLE `acr_matrixcontent_ctas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixcontent_ctas` VALUES (1,16,1,'2018-12-08 01:32:00','2019-01-27 18:25:14','35383eb2-682e-4740-9692-f72ac3ff87f6','Shop Online','Explore our catalog of products','red','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}'),(2,17,1,'2018-12-08 01:32:00','2019-01-27 18:25:14','0b640160-41bb-4161-a5d6-43201a75ad0f','Request Online Account','Quickly request an account to shop with us','blue','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"52\"}');
/*!40000 ALTER TABLE `acr_matrixcontent_ctas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixcontent_locations`
--

LOCK TABLES `acr_matrixcontent_locations` WRITE;
/*!40000 ALTER TABLE `acr_matrixcontent_locations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixcontent_locations` VALUES (1,25,1,'2019-01-02 01:14:24','2019-01-21 18:24:32','ce3de249-626a-4395-ab05-420fa2bb54c8','Burlington','2352 W Hanford Rd.\nBurlington, NC 27215','(336) 227 - 5000','https://goo.gl/maps/3EGEq92J2t72'),(2,26,1,'2019-01-02 01:15:08','2019-01-21 18:24:32','ecef42c4-e6b5-4144-b2e5-e117c6683946','Carrboro','101 Barnes St.\nCarrboro, NC 27510','(919) 929 - 2099','https://goo.gl/maps/PrdhT1bGbgm'),(3,27,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','e6f70d46-ec70-431b-8461-1897cf8a0fd5','Durham','2719 Hillsborough Rd.\nDurham, NC 27705','(919) 286 - 2228','https://goo.gl/maps/2KLv6FA1XYJ2'),(4,28,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','85a6c11c-6447-46eb-a56e-42ad3a9c76d7','Greensboro','2201 Binford St.\nGreensboro, NC 27407','(336) 854 - 5800','https://goo.gl/maps/QyVYuMKfoXy'),(5,29,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','fd5d0832-3572-417f-8d42-5a4d1712d8a5','Raleigh','2416 Alwin Ct.\nRaleigh, NC 27604','(919) 861 - 2277','https://goo.gl/maps/9EeSxoVCQut'),(6,30,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','5fe96432-c7c9-4c59-ad80-9eff4d60d7a2','Wilmington','3207 Burnt Mill Dr.\nWilmington, NC 28403','(910) 442 - 3303','https://goo.gl/maps/gQgGihH59uT2'),(7,31,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','e6efc616-4a65-4144-b84e-e61617cb609c','Winston-Salem','1735 Link Rd.\nWinston-Salem, NC 27103','(336) 831 - 0505','https://goo.gl/maps/zR6HSX5wqmK2'),(8,32,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','3f167f77-862d-4999-b892-d31de2b8bc09','Winterville','4125 Bayswater Rd.\nWinterville, NC 28590','(252) 754 - 2653','https://goo.gl/maps/Ux9UmLTbdsB2'),(9,33,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','3d9b0263-0c70-4629-a688-3f4a6ade763e','Central Services','4040 S. Alston Ave.\nDurham, NC 27713','(919) 765 - 8081','https://goo.gl/maps/Rmo31C2wPC92');
/*!40000 ALTER TABLE `acr_matrixcontent_locations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixcontent_scholarshiprecipients`
--

LOCK TABLES `acr_matrixcontent_scholarshiprecipients` WRITE;
/*!40000 ALTER TABLE `acr_matrixcontent_scholarshiprecipients` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixcontent_scholarshiprecipients` VALUES (1,225,1,'2019-05-11 14:36:59','2019-05-11 15:00:35','d817e441-bab0-4301-85e4-d4a777425c1d','Lexie Smith'),(2,227,1,'2019-05-11 14:46:39','2019-05-11 15:01:18','e995d6e5-c4a6-408e-96ba-6f3de7957b3a','Lindsey Cook'),(3,228,1,'2019-05-11 14:58:07','2019-05-11 15:01:18','98eaefce-12c0-4044-8f9c-15b862813f97','John Richardson'),(4,229,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','99b357b9-0647-44dd-ba47-ae602dd7ee6c','Lindsey Smith'),(5,230,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','eaaa00f5-83db-48c6-bfb2-150e998a5eb8','John Richardson'),(6,231,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','bbb9968d-a053-4c32-822f-1517c8fcd420','John Cappello'),(7,232,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','2315de05-97f5-4118-953f-995786e0dae0','Anthony Cappello'),(8,233,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','b252dcb0-9d9e-4a07-b5b6-3996d0a595cf','Scottie Garner'),(9,234,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','a8e1bc3c-f884-4586-9b75-a525dcc14d11','Brittany Barbour'),(10,235,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','8004cc51-d3d9-4ce4-a40e-7d490223c4c7','Lindsey Cook'),(11,236,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','42accae6-5aef-4497-a2f1-a8cd62141d74','Kevin Buckman'),(12,237,1,'2019-05-11 15:00:35','2019-05-11 15:00:35','5b7f8972-3115-4a45-8ad9-86936b393a84','Brian Buckman'),(13,238,1,'2019-05-11 15:01:18','2019-05-11 15:01:18','aac5e457-c27b-4710-b520-5c1f39e30a07','Lindsey Smith'),(14,239,1,'2019-05-11 15:01:18','2019-05-11 15:01:18','b87c7b6f-3939-4a3c-a3af-4bfaf610c36b','Anthony Cappello'),(15,240,1,'2019-05-11 15:01:18','2019-05-11 15:01:18','73112549-4f51-49f9-b04e-c7d615ddcef8','John Cappello'),(16,242,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','cfd9667f-de79-45c8-b4d8-8e704051ff15','Thomas Aiken'),(17,243,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','78fbd7ef-58d3-488e-8880-610a7bb596b6','Bryan Richardson'),(18,244,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','457e164e-54ac-4d88-931f-d06ea56b9d2c','John Richardson'),(19,245,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','645d05d1-2319-45e6-8d09-eb4c8acaa7b4','John Cappello'),(20,246,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','6cacd945-52b1-4a65-a9ba-bf81c8768d32','Anthony Cappello'),(21,247,1,'2019-05-11 15:02:03','2019-05-11 15:02:03','0cc79414-25f4-4ed6-a872-7328a5bc48c4','Lindsey Smith'),(22,249,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','a7654fbe-43fd-41be-b6f0-09d459ac8f27','Thomas Aiken'),(23,250,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','57648680-c442-43cc-943d-20930193620a','John Cappello'),(24,251,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','e65fbb3e-27a0-48af-b8de-bfe77a44904d','John Richardson'),(25,252,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','7e736cae-32ed-41d8-bcb0-f92d48bc7e4c','Bryan Richardson'),(26,253,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','d0dd7fe1-14a1-4f8f-a607-6fad33027122','Nicholas Cicero'),(27,254,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','62f7d569-c245-4026-b8ca-e98a074f6975','Aaron Cook'),(28,255,1,'2019-05-11 15:03:48','2019-05-11 15:03:48','c3897106-5258-4fc5-b782-6bb31c03ac03','Allison Cook'),(29,257,1,'2019-05-11 15:04:48','2019-05-11 15:04:48','7c119284-685f-4e4f-a87f-e927213d652c','Thomas Aiken'),(30,258,1,'2019-05-11 15:04:48','2019-05-11 15:04:48','74e4ba06-1df5-4518-9668-a8e8bfdba5b2','Aaron Cook'),(31,259,1,'2019-05-11 15:04:48','2019-05-11 15:04:48','52d3d656-8ff5-4769-b621-14f4f3fdcbdc','Allison Cook'),(32,260,1,'2019-05-11 15:04:48','2019-05-11 15:04:48','28dfd5a9-8dc9-4749-b130-af9f6d356395','Bryan Richardson'),(33,261,1,'2019-05-11 15:04:48','2019-05-11 15:04:48','9ac185fd-e5c5-4bf6-bbfb-4ca92b4fb6b2','Allie Smith'),(34,263,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','97982572-49e8-473b-a86f-697885df234c','Thomas Aiken'),(35,264,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','04c599ae-32fa-4f0a-82e4-7c8f4e132a71','Hayden Brumley'),(36,265,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','5a1554ae-7e61-451e-b06e-cdc16582957c','Matthew Cappello'),(37,266,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','ecc75de1-1683-4fbb-8753-782e32da2adc','Aaron Cook'),(38,267,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','899ff8bf-bf5a-4587-99fb-97898d711044','Allison Cook'),(39,268,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','9f340b46-46fc-4a57-afe1-c97311896cbb','Allie Smith'),(40,269,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','13da4cff-ab9b-461b-a1c4-d7ead798e0ca','Caleb Smith'),(41,270,1,'2019-05-11 15:05:30','2019-05-11 15:05:30','62af6779-c540-4e49-aafe-9abd1851fa02','Madison Smith'),(42,272,1,'2019-05-11 15:06:17','2019-05-11 15:06:17','e3777ff8-ae68-4411-af77-f6e5ffb46b03','Matthew Cappello'),(43,273,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','84d839e3-a6bb-4887-a6f4-ec09f20cf5cd','Aaron Cook'),(44,274,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','89f58ae2-0942-4cee-9363-7ce266b0a561','Allison Cook'),(45,275,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','cad16c9c-156d-4121-9e3b-186ddb18eccc','Hannah Gardner'),(46,276,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','47b51021-fcb6-4d6f-9bc2-c78d2e486122','Alyssa Hayes'),(47,277,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','740c0a58-f63d-4c74-b5d2-b61fd959bfea','Megan Shepherd'),(48,278,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','6fe5a3f7-fa52-4507-aa35-6d9aa10fd254','Madison Smith'),(49,279,1,'2019-05-11 15:06:18','2019-05-11 15:06:18','cfd9c5f9-ac49-4064-bd17-f04d6c2947d2','Christopher Terreault'),(50,281,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','05ba36b3-212e-493f-9c4c-be0408a5b06d','Cassandra Cappello'),(51,282,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','28d6469d-7379-4243-9380-5affa8470827','Meghan Dempsey'),(52,283,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','01f3ed24-0bdc-4538-9731-4079df8f8714','Hannah Gardner'),(53,284,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','1f39bf2c-af66-4175-89b2-0318f17aacdd','Megan Shepherd'),(54,285,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','9955d9e1-9da8-4c27-aec2-d00423b24383','Allie Smith'),(55,286,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','07489b0e-7143-479a-90cf-9cf631b7fef3','Madison Smith'),(56,287,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','711b7d86-5dc5-4678-a1fe-239544405ecc','Andrew Terreault'),(57,288,1,'2019-05-11 15:07:00','2019-05-11 15:07:00','ff291d7a-bd34-4902-af3e-4aba9f1f4438','Christopher Terreault'),(58,290,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','5f33ec59-64da-4f82-94b8-59f166d0440d','Cassandra Cappello'),(59,291,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','7734800d-e155-4b6f-82c4-d727d204afef','Matthew Cappello'),(60,292,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','ade9133e-13ce-4b46-90fa-9dba81045257','Meghan Dempsey'),(61,293,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','605faff4-fb79-4d17-9c70-13adb03ff845','Hannah Gardner'),(62,294,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','00e96ae6-348e-4109-bdad-14820502959d','Bailey McCann'),(63,295,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','4b307ceb-0098-4bef-bc00-01424b8d6ce9','Megan Shepherd'),(64,296,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','61641642-5c95-4c59-85e7-cd4c24d90d60','Madison Smith'),(65,297,1,'2019-05-11 15:07:44','2019-05-11 15:07:44','aedde583-642e-42d8-881d-002d3a676f4c','Christopher Terreault'),(66,299,1,'2019-05-11 15:08:25','2019-05-11 15:08:25','01f51058-0f7a-4661-ac58-ec5dc6ff945e','Cassandra Cappello'),(67,300,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','beb45d88-9d27-4ca4-8c71-6ef8e91e67bd','Matthew Cappello'),(68,301,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','3e826ea2-7301-48f8-abaf-8a1d2c71904d','Meghan Dempsey'),(69,302,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','1d5fa737-ef59-4ae0-8a38-0f7bf3a315d0','Hannah Gardner'),(70,303,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','d64773df-017b-4cf1-9dc4-c73ec41edd1f','Megan Shepherd'),(71,304,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','2626d148-bc42-46d6-a30a-9dff1dfde0ce','Christopher Terreault'),(72,305,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','3e53fade-02ef-4bd7-9184-e789aed489be','Dylan Thompson'),(73,306,1,'2019-05-11 15:08:26','2019-05-11 15:08:26','1bb7d608-b806-4c3c-8185-38813fc1e48e','Robert Ursery'),(74,308,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','f9d0f119-99b5-4a77-be09-39f2953d16f6','Anna Brumley'),(75,309,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','ee41c3cf-e061-4c08-86dc-3eddb76853de','Sophia Brzezinski'),(76,310,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','c19f93a0-bb4b-4742-828d-579deee4d559','Ethan Butler'),(77,311,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','600f5396-8f93-41ce-89b6-c6bc9530f66b','Cassandra Cappello'),(78,312,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','9f843295-c839-4c92-9678-85bd7615a37d','Meghan Dempsey'),(79,313,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','cecc4fab-3a3a-4ba2-b95b-1a55695ba897','Micaela Dempsey'),(80,314,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','062d4794-79af-488d-9003-b0dacf39df99','Chandler Gardner'),(81,315,1,'2019-05-11 15:09:10','2019-05-11 15:09:10','5451d0ac-71a5-44be-a1a8-418ed4b57acd','Robert Ursery');
/*!40000 ALTER TABLE `acr_matrixcontent_scholarshiprecipients` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixcontent_services`
--

LOCK TABLES `acr_matrixcontent_services` WRITE;
/*!40000 ALTER TABLE `acr_matrixcontent_services` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixcontent_services` VALUES (1,12,1,'2018-11-02 02:36:30','2019-01-27 18:25:14','ef6ec637-82b0-4cdf-a14e-0927429e01ad','Thousands of Products','We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}'),(2,13,1,'2018-11-02 02:36:30','2019-01-27 18:25:14','ee0c8373-1022-4ffb-9351-a31c8d9701b4','Thousands of Products','We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}'),(3,14,1,'2018-11-02 02:36:30','2019-01-27 18:25:14','4aa9d87f-fb31-4e1d-8b3a-05df0cf08c28','Thousands of Products','We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}');
/*!40000 ALTER TABLE `acr_matrixcontent_services` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixcontent_surveyresults`
--

LOCK TABLES `acr_matrixcontent_surveyresults` WRITE;
/*!40000 ALTER TABLE `acr_matrixcontent_surveyresults` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixcontent_surveyresults` VALUES (1,68,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','2ae38e6c-7da4-48c5-936b-8eabdd100e5b','A culture of family'),(2,69,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','066d261c-4367-418d-a0bb-d4260566e20c','A culture that truly does try to serve others over self.'),(3,70,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','cb3f5bb0-81d9-46ea-8f76-a9d3e1f816ec','A customer focused culture of respect, open communication and, resolving conflict in a healthy manor.'),(4,71,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','a2d88c16-d051-4e67-a172-09dd24040f96','A GREAT ENVIRONMENT WITH POSITIVE ATTITUDES.'),(5,72,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','9b738ef8-62d8-469b-8b43-de84f1267000','ACR is a customer focused company that cares deeply about its employees.'),(6,73,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','aee4c9fa-a593-48e8-800c-1f0d322deab9','ACR is a place that creates an environment where team members want to get up and come to work everyday. If you have ever dreaded going to a job, then you know why this is soooo important.'),(7,74,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','550b1fdf-c51b-4f69-bd21-19cf05619c63','ACR is family and it is a place where you do not have to worry about weather or not you will have a job the next day if something happens in your life becasue ACR has your back no matter what'),(8,75,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','d6544c06-50b5-4c32-ae78-07522ec4670a','ACR\'s culture reflects our guiding principles.'),(9,76,1,'2019-02-05 02:46:19','2019-02-05 02:46:19','f8a30e78-05e4-48ab-b930-c0e397c8af90','Amazing couldn\'t ask for a better family.'),(10,77,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','de5d1a72-7dc3-4ce3-8395-00a7cbf9526e','AMAZING CULTURE'),(11,78,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','5fea733d-3415-460b-ae83-54da25c787f5','Awesome culture when people buy in team work'),(12,79,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','f08b2c33-4bed-4a96-95d3-59bd5eb232f2','Awesome!'),(13,80,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','051fc877-39db-4723-83d8-570c4b4c55c0','Balance of team work and customer service - with integrity'),(14,81,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','8f363cb7-380b-47a5-923d-1b67029f41d8','Big Family'),(15,82,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','378880f6-7955-4e6c-bc90-4c21584c93e2','CARING ABOUT PEOPLE PASSIONATE ABOUT SOLUTIONS AND TO GLORIFY GOD'),(16,83,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','eb79de90-9c22-47aa-866e-3e19cc5c5841','caring god based culture'),(17,84,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','83fddeb9-8d9d-45a6-a228-cbffe8303881','Christ-centered, customer-focused, associate-friendly'),(18,85,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','6966caea-54a3-4005-a72a-17ecbe7cc890','Close family'),(19,86,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','86ce150d-30f3-46a8-b237-a846c8cae23c','Customer Focused'),(20,87,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','00d9bb32-f71c-48ec-a45e-9b410275910a','CUSTOMER DRIVEN'),(21,88,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','f2bea78b-d4b0-42d6-b971-f9dec18017bc','effective, diverse, accepted, encouraged'),(22,89,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','ddc88020-a6bc-4faa-8760-40d461722793','It feels like a family - all the staff are great to work with.employee and customer based, something on a level I haven\'t seen in previous jobs'),(23,90,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','40563cb6-703d-4a03-824e-cd188ed679f0','Encouraging, supportive, and happy'),(24,91,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','b125cb43-2187-42df-8e96-f038742df093','Everybody acts like a big family and you can tell when we have meetings that everyone genuinely gets along'),(25,92,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','a06174e2-7800-4791-b572-b15795d373f0','everyone willing to help'),(26,93,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','d584d921-e693-4b7e-985b-652694235593','Excellent culture. It’s awesome being at a workplace where everyone actually wants to be at work and genuinely cares about the big picture'),(27,94,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','e33e292e-712b-4228-b31a-3c0d2f3c49b8','Family'),(28,95,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','f090d54b-c8fe-41c8-af4e-f062461a3945','Family atmosphere. Everyone gets along great.'),(29,96,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','3f4d41a2-d3a8-4a0c-87ed-8319a532fab9','Family business'),(30,97,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','b8a62a5a-585e-4644-b045-d5036cf7ab2c','Family oriented, honest, ethical.'),(31,98,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','9a5001fb-9aef-4c06-a7e5-7332331dbe09','family/community'),(32,99,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','8238487e-a593-423f-932f-84d1f242ff27','For me it\'s simple. It is a culture that loves people and makes a difference in their lives.'),(33,100,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','139a5f3d-e213-4149-b8c2-31106fea794d','friendly'),(34,101,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','2ce3dd55-42e4-4e7b-b148-903eee09d328','friendly atmosphere where you want to come to work'),(35,102,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','ec308b1d-79f0-4b16-ba48-bbf18357dc8b','friendly, helpful, loving, Christ centered.'),(36,103,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','d9321f46-43ca-46b3-8c4c-5329afaacf3e','GOOD'),(37,104,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','4faaadfc-f02b-4f78-8f46-1d2bcf5bf3ce','Good , place work like the people. healthy team work.'),(38,105,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','70afdbd1-5f64-46a2-8d4b-0e8a44c3064d','good culture that bring honor and glory to God'),(39,106,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','47a80fc9-4dda-4083-b178-1dec166e793b','Great culture where everyone wants to help out and be apart of a team.'),(40,107,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','2165b11f-4e62-4175-95c7-7c39f3ec83a7','Great family atmosphere'),(41,108,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','ef75165b-4a80-4668-8ffc-21d3fe2276bf','Great work environment .'),(42,109,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','7dc9442e-5b54-4a43-a2c6-08b2e7e0b26c','Happy, Happy Happy'),(43,110,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','8b26a9c4-0888-4f9c-9c8c-fd60f430ef10','Honest and trustworthy, very little drama'),(44,111,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','f7bd0f7e-045c-4a77-9168-e0c497d17072','I believe that a culture has been built where people are treated and embraced like family. I have confidence that I can go to anyone at anytime and have a discussion, ask a question, or be vulnerable about my personal life.'),(45,112,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','136e2dff-ff24-43a5-8494-7a9b1521f2fe','I think of importance of family and God when I think of ACR.'),(46,113,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','6abd983d-8cf3-462e-9e1d-b075b335c287','I would describe the ACR culture as one of INTEGRITY. From that well, all the other characteristics of a great place to work flow.'),(47,114,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','7087bfd3-e9e0-426f-851b-1ff64ef054a2','I would describe the culture as Helpful and fun.'),(48,115,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','5bab8fdf-10e1-406b-8e2d-1f8f79e728b8','It is a good place to work that allows people to excel in their life through their work and outside life balance. There is a genuine care for employees well-being not just at work but outside of work too.'),(49,116,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','cdefee2a-79d8-45b7-aa13-56a1a4fd3208','Its a second family'),(50,117,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','367d4f2d-6244-4360-9b42-a88f9f7b952a','Its an awesome culture at ACR. Would be better if everyone followed it.'),(51,118,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','198084af-e2c3-4485-9bd5-4901fa80a560','It\'s refreshing and attractive among all the other culture\'s in our industry.'),(52,119,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','aae780f4-53ed-4f08-abeb-df9040934b80','It\'s tight-knit group of people who strive to make a difference in the marketplace and in the community.'),(53,120,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','0c8800b1-9dcb-4b2b-ac1b-26cb0b819886','Living and working for a common goal, to achieve success in business, work and play. To pay homage to God and give thanks for what we have.'),(54,121,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','4506c177-5291-48dd-b53d-c937abafdecf','loving and fun-loving; productive and professional.'),(55,122,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','9336f4e2-bbc7-4a89-be72-039b46eeecce','ok'),(56,123,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','d1aa6835-e23f-4a66-af5f-8fc2b3e12914','One of family and friends.'),(57,124,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','535356d1-957d-4638-baa8-3a7ed7e8fbab','One that values relationships with customers and team members alike.'),(58,125,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','b86b09b9-10b3-4830-8331-48d52be65764','Open and Caring'),(59,126,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','8ba15aa0-b4b1-44f5-bc3b-ea5286aed575','Our culture at work provides a road map for life.'),(60,127,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','b1b049a1-1945-43e9-ae95-6c231c8c6c35','Our culture is positive, forward thinking and we truly care about one another and the impact we have on each other\'s lives and each other\'s families.'),(61,128,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','64de8a02-be7f-4828-9e6b-1145e2fdfcb4','People liking and respecting one another, with the end goal to satisfy our customers.'),(62,129,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','19e9a295-580f-429d-b46f-d54f78d6c1ba','professional, unique, kind, smart, trust'),(63,130,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','25e26def-e053-4ce6-95b8-ceece46ad7a9','Refreshing'),(64,131,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','28852352-b6eb-490d-9241-a5178b151e75','Rewarding personally and professionally'),(65,132,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','8de98a6a-55c7-4ce6-8388-84e9c691a2ad','Spiritual'),(66,133,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','abedb53c-16a8-4f8e-98a3-869055014d08','take care of customer at all cost'),(67,134,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','c2f9c11b-cd95-4279-850e-278ea9148daa','The ACR Culture is phenomenal, I have never worked at a place like this before. Everyone seems to be very helpful, Family oriented and has a Purpose for doing whats best for ACR.'),(68,135,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','bc6f36fd-28de-4fbb-a57c-d8f4430103de','The culture at ACR is amazing I love the fact that the companies principal includes to glorify god.'),(69,136,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','08f1b494-a5a1-4efd-b50a-546b56e428a7','The culture at ACR is one of serving customers first by working together and also by helping its employees to be better trained within their own fields.'),(70,137,1,'2019-02-05 02:46:20','2019-02-05 02:46:20','9f4972a0-de7d-4018-9ebc-6a09ac6f57a8','The culture at ACR Supply is like we\'re all a family.'),(71,138,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','903da28a-b67c-42d2-add7-bf2877c07f2f','The culture has improved over the past few years.'),(72,139,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','9891cf52-a9de-4ce2-8c00-172e5baec08b','The culture is not always applied the same'),(73,140,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','102375bd-bff3-4583-a669-8911cfffab42','The culture of this company is awesome. Everyone is loved, and part of the team.'),(74,141,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','92fc283e-6769-4928-a140-a53472d43148','Unique, I treasure this place, best job I\'ve ever had.'),(75,142,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','d0feffe4-53ad-4007-9511-a5a19febd1e1','Values, beliefs, attitudes, and behaviors share each day at work.'),(76,143,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','fafb674e-cd86-464f-b56b-e755e37f97ba','VISIONARY'),(77,144,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','ee2a0c94-68f0-4b22-a787-f0acc7c9e29a','Visionary leaders everywhere with a humble servant leadership mindset with a mission to fulfill God\'s purposes in our sphere\'s of influence while making a profit for the future!  SEE BIG while thinking SMALL'),(78,145,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','48830030-e45a-4015-822e-cedcbfa61ca8','We are a family that loves, cares for, and prays for one another and our communities.'),(79,146,1,'2019-02-05 02:46:21','2019-02-05 02:46:21','e761dafd-a95f-4ee9-8bed-5d4c30105292','We care for each other');
/*!40000 ALTER TABLE `acr_matrixcontent_surveyresults` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixcontent_teammemberinitiatives`
--

LOCK TABLES `acr_matrixcontent_teammemberinitiatives` WRITE;
/*!40000 ALTER TABLE `acr_matrixcontent_teammemberinitiatives` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixcontent_teammemberinitiatives` VALUES (1,40,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','5475b42f-2a65-41a9-b61d-52c7c16d8243','Annual Scholarship to our team members’ children'),(2,41,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','5823668b-6bf6-4437-9038-0a770fc5fd1e','Benevolence fund for team members going through difficult times'),(3,42,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','1e2c4319-6e82-43dc-b044-f14d503ab08c','Corporate Chaplains'),(4,43,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','db4cba75-4096-4c0e-88b5-b5430c712272','Ministry pamphlets in all our locations'),(5,44,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','36c772f7-2024-4e10-9f2c-334f555e975d','Annual Awards Banquet'),(6,45,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','00f6342a-24a6-4151-8d74-834389968b9f','Annual Family Fun Day'),(7,46,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','48e2a5a4-3d49-4d3d-80db-f56ed7a05a84','Marriage Retreats for team members and their spouses'),(8,47,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','2e0e7c20-bf03-4794-8857-809498e8b119','Volunteer Policy'),(9,48,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','e48aca8b-d03b-4f7d-a5f6-2e2afef461d3','Mission Trip Policy'),(10,49,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','72df0f4d-21a6-45cf-96c8-3f0cacd24b34','Disaster Relief Policy');
/*!40000 ALTER TABLE `acr_matrixcontent_teammemberinitiatives` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixcontent_vendors`
--

LOCK TABLES `acr_matrixcontent_vendors` WRITE;
/*!40000 ALTER TABLE `acr_matrixcontent_vendors` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixcontent_vendors` VALUES (1,149,1,'2019-02-10 01:33:17','2019-02-10 01:33:17','9e7a25be-1dc1-4d91-b82b-3be3d203a86d','A.O. Smith','Electric Motors-Fractional and Integral Horsepower','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}'),(2,150,1,'2019-02-10 01:33:17','2019-02-10 01:33:17','7a8a5dbb-6dc0-4cbb-9925-c6815fd17dd7','A1 Components','A/C and Refrigeration Components, Camstat Controls','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}'),(3,151,1,'2019-02-10 01:33:18','2019-02-10 01:33:18','4c6af85c-e132-45ac-a287-1daf4d605198','Amprobe','Instruments for Measuring Volts, Amps, Ohms, Temperature','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}'),(4,152,1,'2019-02-10 01:33:18','2019-02-10 01:33:18','c1ea56d9-0240-4a77-8656-500487755265','Antunes',NULL,'{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"\"}'),(5,153,1,'2019-02-10 01:33:18','2019-02-10 15:01:02','9636b9a8-4742-4f6a-8bdb-53bbf2ad00d9','A.O. Smith','Electric Motors-Fractional and Integral Horsepower','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.centuryelectricmotor.com/\"}'),(6,154,1,'2019-02-10 01:33:18','2019-02-10 15:01:02','0783fb3c-65b1-4b98-ba38-b5889629fa99','A1 Components','A/C and Refrigeration Components, Camstat Controls','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"https://www.acrsupply.com/vendors/\"}'),(7,155,1,'2019-02-10 01:33:18','2019-02-10 15:01:02','eea1b8e9-4751-4721-a1f9-d16b1f7a2423','Amprobe','Instruments for Measuring Volts, Amps, Ohms, Temperature','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.amprobe.com/amprobe/usen/home/\"}'),(8,156,1,'2019-02-10 01:33:18','2019-02-10 15:01:02','31433e9d-d509-4961-aca3-12f4288f8bb2','Antunes','Pressure Switches for Gas and Air','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.antunescontrols.com/\"}'),(9,157,1,'2019-02-10 01:33:49','2019-02-10 15:01:02','aa55c70a-9303-450a-999b-373df7cd9abb','AquaGuard','Conservation Technologies','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/index.php/products-4/\"}'),(10,158,1,'2019-02-10 01:38:23','2019-02-10 15:01:02','a707aef7-4328-4541-b166-4c25647258c8','Armacell','Closed Cell Insulation for Refrigerant Lines','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.armacell.com/\"}'),(11,159,1,'2019-02-10 01:38:23','2019-02-10 15:01:02','2f27ee9c-ca71-40e0-a244-fea3d14b2f5a','ASCO','Solenoid Valves','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.asco.com/\"}'),(12,160,1,'2019-02-10 01:38:24','2019-02-10 15:01:02','57f596cc-2f6b-4f65-bc6e-73cf52d2b09a','Bacharach','Combustion Analyzers, Leak Detectors and Refrigerant Recovery/Tools','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.bacharach-inc.com/\"}'),(13,161,1,'2019-02-10 01:38:24','2019-02-10 15:01:02','063e6e90-8952-4de8-8eb0-f07b5af759ac','Baron Wire','Thermostat Cable-UL, Plenum, Shielded, Extension Cords','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.colemancable.com/Home\"}'),(14,162,1,'2019-02-10 01:38:24','2019-02-10 15:01:02','4ab3cdf9-e90c-47ed-9d62-8bf346ae5ac6','Belimo','Direct Mounted Actuators and Valves','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.belimo.com/english/index.cfm\"}'),(15,163,1,'2019-02-10 01:38:24','2019-02-10 15:01:02','db8271a7-1659-415f-9f1c-22f6b1ea50c3','Browning Belts','V-belt drives and power transmission products','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonindustrial.com/en-US/powertransmissionsolutions/Pages/home.aspx\"}'),(16,164,1,'2019-02-10 01:38:24','2019-02-10 15:01:02','587fa857-f795-4c67-b43e-61ef4e9906c8','Cooper-Atkins','Thermometers-Digital/Bi-metal/Liquid Filled','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooper-atkins.com/\"}'),(17,165,1,'2019-02-10 01:38:24','2019-02-10 15:01:03','5cebecf3-3af0-45c0-a0aa-39ad992b000b','Copeland','Hermetic and Semi-Hermetic Compressors for Refrigeration and Air Conditioning','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonclimate.com/en-US/Pages/home.aspx\"}'),(18,166,1,'2019-02-10 01:38:24','2019-02-10 15:01:03','495e3b6e-a807-4dc8-bbbb-1db9771660cf','Crown Boiler','Heating Parts','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.crownboiler.com/\"}'),(19,167,1,'2019-02-10 01:38:24','2019-02-10 15:01:03','87b86ebf-6825-41ac-9499-f2aad50ac94e','Diversitech','Air Conditioning Accessories','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.diversitech.com/\"}'),(20,168,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','e743c6e2-80f1-43f7-b195-b347c8b8cb75','Dupont Refrigerants','Refrigerant, filters','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www2.dupont.com/Refrigerants/en_US/\"}'),(21,169,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','33281e69-8a1e-4513-b752-a9bd8296ffcf','Dust Free','Indoor Air Quality Solutions','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dustfree.com/\"}'),(22,170,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','b4c5aa7d-07c5-4f1c-95a7-f628db9b5b8b','Dwyer','Magnehelic Gages','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.dwyer-inst.com/\"}'),(23,171,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','fb06b7d1-9675-43e6-bf2e-20818f7d84dc','Ecobee','Programmable Thermostats','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ecobee.com/\"}'),(24,172,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','4e358492-e24f-4e78-bd19-8c148fdfa7f7','Edison Fusegear','Electrical Fuses','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.cooperindustries.com/content/public/en/bussmann.html\"}'),(25,173,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','e8ef95fa-0c05-4ed1-9418-9e52fb6a2e51','Federal Process','Specialty Chemicals','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.federalprocess.com/\"}'),(26,174,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','1437f3c1-bfd4-49a5-9c60-91136a4793ba','Fluke','Electrical Test Instruments','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.fluke.com/\"}'),(27,175,1,'2019-02-10 01:42:49','2019-02-10 15:01:03','6b20d875-31c0-464c-809a-ce5de6ae80f5','Functional Devices','Electronic devices','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.functionaldevices.com/\"}'),(28,176,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','d17977cf-692e-4914-98af-5ad9a926f675','Gates','V-Belts','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.gates.com/\"}'),(29,177,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','eda15c5b-3a02-4443-a1af-a4cad1aea3a4','Hays Fluid','Automatic Flow Control Valves','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.haysfluidcontrols.com/index.html\"}'),(30,178,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','163daaf6-28a8-4a7c-8544-8a7ac3dc52d6','HeatCraft','Refrigeration Evaporators and Condensing Units','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.heatcraftrpd.com/\"}'),(31,179,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','5df6f899-74e9-48fe-bf30-cc954bec1c47','Henry Valve','Refrigerant Control Valves','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.henrytech.com/\"}'),(32,180,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','b0525ffe-7134-469e-86e8-f52422f1a295','Highside','Chemicals','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.highsidechem.com/\"}'),(33,181,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','0cb03739-3cb8-4876-a8f3-619398dbfe0f','Honeywell','Burner and Boiler Controls, Commercial Building Controls, Environmental Controls, Hydronic Controls Pneumatic Controls, Residential HVAC Controls, Perfect Climate Humidifiers, Air Cleaners, UV Air Treatment, Digital Thermostats, Communicating Thermostats, Equipment Monitoring','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.customer.honeywell.com/\"}'),(34,182,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','81ee2ad4-31aa-4cc5-b6c8-fb46f4aaaf15','Imperial (Stride Tools)','Tube Working Tools','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://imperial-tools.com/\"}'),(35,183,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','4dfcebbd-fa1b-47cd-a16b-256902a0b4b0','Inficon','Refrigerant Leak Detectors','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.inficon.com/default.aspx?language=en-us\"}'),(36,184,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','f2897193-8062-4b54-bdd2-8969bfb3331b','J.W. Harris','Soldering and Brazing Products','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.harrisproductsgroup.com/\"}'),(37,185,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','86519a96-5c7d-45dc-b191-c6509a927e89','JB Industries','Vacuum Pumps and Charging Accessories','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.jbind.com/\"}'),(38,186,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','db4fc239-59e0-4628-8a80-828cc7583711','Johnson Controls','Pneumatic Controls, Refrigeration Controls and Leak Detectors, Commercial Air Conditioning Controls, BASO Gas Ignition Products, Valves and Actuators','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://cgproducts.johnsoncontrols.com/default.aspx?topframe.aspx&0\"}'),(39,187,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','b1d807a4-71ef-465d-abd2-c98f4e91446d','KE2 Thermal','Advanced energy saving technology','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ke2therm.com/\"}'),(40,188,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','a7bf6b12-d575-403a-a570-f329698ab23d','Klein','Hand Tools','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.kleintools.com/\"}'),(41,189,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','365dda0a-7192-409b-bec5-db36ce937a04','Koch Filter','Commercial and Industrial Air Filtration Products','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.kochfilter.com/\"}'),(42,190,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','1c6f5edc-534d-4bb1-a41a-ee378c9b6e7a','Lau','Blower Wheels and Fan Blades','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.lauparts.com/\"}'),(43,191,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','abef6ec0-9de4-4f6f-a54f-d20302973e73','Lenox','Saw Blades','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.lenoxtools.com/Pages/home.aspx\"}'),(44,192,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','cb1f35b4-1fb3-4670-a688-1cced517d607','Little Giant','Condensate Pumps','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://franklin-electric.com/hvac.aspx\"}'),(45,193,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','e624c153-4abb-46f7-9c63-949d369cc096','Malco','Hand Tools For HVAC Trades','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://malcoproducts.com/\"}'),(46,194,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','7f8b2dc3-4fd5-44c2-a85c-4c07fb63e5ff','Mars','Motors & Armatures','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.marsm-a.com/\"}'),(47,195,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','02411ad8-1dea-48dd-950a-3260ea0c24e8','Mueller','Copper Tube and Fitting for HVAC/R','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.muellerindustries.com/\"}'),(48,196,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','2ce04ba6-70a5-409c-a54a-69e98ac9640c','NSI','Connectors','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nsiindustries.com/products/electrical.aspx\"}'),(49,197,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','b71ad576-9721-427f-8417-aadf26de8517','NTI','High Efficiency Boilers','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nythermal.com/trinity_ti\"}'),(50,198,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','b8ec2967-aa40-45fe-8502-74db51f8c311','NuCalgon','Coil Cleaners and Chemicals for the HVAC/R Trades','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nucalgon.com/\"}'),(51,199,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','be407403-202b-436c-9a5b-ec798a0e1d3a','Parker','Brass Fittings, Refrigeration Control Products','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.parker.com/portal/site/PARKER/menuitem.b90576e27a4d71ae1bfcc510237ad1ca/?vgnextoid=c38888b5bd16e010VgnVCM1000000308a8c0RCRD&vgnextfmt=default\"}'),(52,200,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','2dda16c9-ca2a-4582-8941-152e174b7b7c','Polyken Tape','Pressure sensitive tapes and adhesives','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://tapes.berryplastics.com/\"}'),(53,201,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','0f571dda-1182-41ed-9a68-8e69c0ad5883','Ranco','Refrigeration Temperature and Pressure Controls','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.uni-line.com/common/ranco.aspx\"}'),(54,202,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','6df1d8d4-e003-4f77-9ca9-56b2e5f45f71','RCD Mastics','Home Weatherization Products','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rcdmastics.com/\"}'),(55,203,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','bc69b69f-12b8-45be-b7a6-4545ccf82a09','RectorSeal','Chemicals for the HVAC/R Trades','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.rectorseal.com/\"}'),(56,204,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','edf015d6-eb7b-44d5-9422-fd7048105e36','Ritchie','Charging Hoses and Manifolds','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.yellowjacket.com/\"}'),(57,205,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','0bd6ce11-c840-4a76-b212-bda49fd8f678','Schneider Electric','Energy Management','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.schneider-electric.com/site/home/index.cfm/ww/?selectCountry=true\"}'),(58,206,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','ad3ff445-7caf-4500-888e-ac005e88f702','Scotsman Ice Machines','Leaders in ice machine innovation','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.scotsman-ice.com/?xhtml=xhtml/sct/us/en/homepage/default.html&xsl=homepage.xsl\"}'),(59,207,1,'2019-02-10 02:02:42','2019-02-10 15:01:03','9ecaa877-1abc-4ebd-bca3-ccb61d06d526','Sealed Unit Parts','SUPCO Accessories for the HVAC/R Trade','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.supco.com/web/supco_live/\"}'),(60,208,1,'2019-02-10 14:50:02','2019-02-10 15:01:03','eaeba17a-9171-4419-819e-26cec0390fa4','Siemens','Pneumatic Controls','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.nsiindustries.com/products/electrical.aspx\"}'),(61,209,1,'2019-02-10 14:50:02','2019-02-10 15:01:03','f38cde6a-a12d-40e9-b24f-edd5c1b81c76','Sporlan','Catch-All Driers, Solenoid Valves, Thermostatic Expansion Valves, Refrigerant Pressure Regulators','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.parker.com/portal/site/PARKER/menuitem.223a4a3cce02eb6315731910237ad1ca/?vgnextoid=47f9724fe7a5e210VgnVCM10000048021dacRCRD&vgnextfmt=EN\"}'),(62,210,1,'2019-02-10 14:51:49','2019-02-10 15:01:03','ae5c3c3a-1622-489e-8b1e-57b83c71458c','Suntec','Fuel Oil Pumps','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.suntecpumps.com/\"}'),(63,211,1,'2019-02-10 14:51:49','2019-02-10 15:01:03','20a61d3c-d3c8-4770-9113-5d5976b26414','System Sensor','Duct Smoke Detectors','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.systemsensor.com/en-us/Pages/welcome.aspx\"}'),(64,212,1,'2019-02-10 14:51:49','2019-02-10 15:01:03','e6d4ac1d-c76d-45cc-806d-e3fe1136e501','Temprite','Oil Separators','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.temprite.com/main_content.asp?pagename=home\"}'),(65,213,1,'2019-02-10 14:51:49','2019-02-10 15:01:03','e4869c66-8050-4a1c-993c-34e466cb3ba2','UEI','Electrical and Temperature Test Instruments','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ueitest.com/\"}'),(66,214,1,'2019-02-10 14:51:49','2019-02-10 15:01:03','856f4357-6ae4-4d5c-8198-75a551caa46a','Ultravation','Ultraviolet Disinfection Systems and Indoor Air Quality Products','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.ultravation.com/\"}'),(67,215,1,'2019-02-10 15:01:03','2019-02-10 15:01:03','82bce7d9-2970-4d44-bb1e-aeae9ef18893','Uniweld','Welding Outfits and Accessories','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://uniweld.com/\"}'),(68,216,1,'2019-02-10 15:01:03','2019-02-10 15:01:03','255c5c57-e87d-47b9-95d2-483bcb7a6103','Victor-Turbo Torch','Self Lighting Torches','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://victortechnologies.com/\"}'),(69,217,1,'2019-02-10 15:01:03','2019-02-10 15:01:03','c328ed59-2571-463c-b92f-03c134e1afb8','Watts','Backflow Preventer Repair Parts','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.watts.com/\"}'),(70,218,1,'2019-02-10 15:01:03','2019-02-10 15:01:03','6f6d9a7e-0dbf-4bca-aaae-ef75e4764ecb','Weiss','Thermometers and Pressure Gauges','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.weissinstruments.com/\"}'),(71,219,1,'2019-02-10 15:01:04','2019-02-10 15:01:04','202e13d3-62ed-4992-b1b3-937f5c85aa7f','White Rogers','Thermostats and Gas Controls','{\"ariaLabel\":null,\"customQuery\":null,\"customText\":null,\"target\":\"_blank\",\"title\":null,\"type\":\"url\",\"value\":\"http://www.emersonclimate.com/en-us/brands/white_rodgers/pages/white_rodgers.aspx\"}');
/*!40000 ALTER TABLE `acr_matrixcontent_vendors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_migrations`
--

LOCK TABLES `acr_migrations` WRITE;
/*!40000 ALTER TABLE `acr_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_migrations` VALUES (1,NULL,'app','Install','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','d56e87b0-69cb-446f-bafc-d8adbf93b679'),(2,NULL,'app','m150403_183908_migrations_table_changes','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','43d5036e-caca-40f3-8db2-dff2f39d3eaa'),(3,NULL,'app','m150403_184247_plugins_table_changes','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','2e41d709-0396-468c-ae70-d79d00c3989e'),(4,NULL,'app','m150403_184533_field_version','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','f04370ec-b948-4229-9e51-ab360bdc4514'),(5,NULL,'app','m150403_184729_type_columns','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','451b13b3-139f-42cb-85b1-db62a57a1887'),(6,NULL,'app','m150403_185142_volumes','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','e39f1a03-599e-4655-bd34-a62dc8c52083'),(7,NULL,'app','m150428_231346_userpreferences','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','38c2e83a-f277-470a-9fbe-0d860108d608'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','5505fb12-d44b-45a5-a972-98c7d9579276'),(9,NULL,'app','m150617_213829_update_email_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','a87e3116-4147-4905-aeb4-2eef690d51af'),(10,NULL,'app','m150721_124739_templatecachequeries','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','ba345308-a352-4610-ad96-67510046a135'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','adafddbc-bf92-4cf2-83e5-9600b51ce544'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','fbaf72ca-2597-4ae9-937f-54999572d5d1'),(13,NULL,'app','m151002_095935_volume_cache_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','916fe096-3aec-4fae-8b96-9ba26b6124b6'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','b8f9f3e5-1218-4591-946e-ebf79be447d3'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','02f2739d-b747-4e2b-9310-9d9a264e757a'),(16,NULL,'app','m151209_000000_move_logo','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','e7d32d1c-a39d-4c53-b366-5ef407baefd3'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','58cb6868-9d2e-4f84-bd60-3c0b63a84c39'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','81192b37-e506-472d-b994-21e289af8db6'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','b7e53de4-0f5a-49a5-ba67-c3e7e4dde67d'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','82d2c3cf-d2a4-4488-89c9-ec80e11dbe22'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','3da1c809-1f7f-49ba-b75c-3cae1089dd77'),(22,NULL,'app','m160727_194637_column_cleanup','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','7f1e8f30-9e0e-4202-a78c-8758f403631b'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','f2befb09-7f8c-464e-b2e6-041612388692'),(24,NULL,'app','m160807_144858_sites','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','e9e2b049-0648-4126-b64c-09018a55a065'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','25b02982-92dd-4253-8dc8-dac299b14a6c'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','60f05c52-572d-472d-b3c5-2cc3ae7c372e'),(27,NULL,'app','m160912_230520_require_entry_type_id','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','e119affb-3e0e-47dd-875d-1cd995a5b455'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','b462caa6-d53e-4556-8c44-3b41e0d30f70'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','b562d88f-a44e-450d-aeb9-6526d92633f6'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','b14b1045-6e73-4d3c-acfd-ef913421c5d8'),(31,NULL,'app','m160925_113941_route_uri_parts','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','0a07047a-7d21-47e2-9099-b5e9b6522fd1'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','3fdccd34-56e4-4949-8842-2bae8ed6f05d'),(33,NULL,'app','m161007_130653_update_email_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','8d0d0e20-2b6d-4228-86ae-fcbeaa4b6323'),(34,NULL,'app','m161013_175052_newParentId','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','37ec1d75-50e3-43dd-b9e6-c584ccaa0ae4'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','27bce9b2-b863-448f-9909-472e0dffc8bd'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','1b9e2e13-7101-4eba-a078-8f0c7b1d766d'),(37,NULL,'app','m161025_000000_fix_char_columns','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','bf96bdd7-ead9-45ca-a69c-3fa84a2033ea'),(38,NULL,'app','m161029_124145_email_message_languages','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','e8103f77-8c0e-4dca-a7c9-17d883112a13'),(39,NULL,'app','m161108_000000_new_version_format','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','0ae1af55-401c-421b-bb69-9d68e8527993'),(40,NULL,'app','m161109_000000_index_shuffle','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','24a84c4c-9fe0-45b3-9062-8d90a8f04aff'),(41,NULL,'app','m161122_185500_no_craft_app','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','8b9e8bfe-843e-46c8-9813-70f98ab5a073'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','634a4f86-5f2c-472f-a272-dc9f7012ac1c'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','eb136ed2-b186-4c2c-a8e9-ffddee5f27a0'),(44,NULL,'app','m170114_161144_udates_permission','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','5dd79c67-5a80-498a-b71b-dd29d1ef1201'),(45,NULL,'app','m170120_000000_schema_cleanup','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','ef7cd75f-cae1-43d3-859c-5ec5f1fde62e'),(46,NULL,'app','m170126_000000_assets_focal_point','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','5f7e60f9-2849-4764-adf1-50cbb634d778'),(47,NULL,'app','m170206_142126_system_name','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','f5d1fd7c-3036-4b1c-bc13-1e6d1c0c7d7e'),(48,NULL,'app','m170217_044740_category_branch_limits','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','8add68fc-1529-4ed0-9e03-1ecb4695d9da'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','5a53cf68-7e3d-44ab-95f1-bcb97fa9c44c'),(50,NULL,'app','m170223_224012_plain_text_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','2827e619-de75-49f5-819e-a866c6c2c858'),(51,NULL,'app','m170227_120814_focal_point_percentage','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','00e694a4-d3a8-4aa3-8194-5a81df0dfa3e'),(52,NULL,'app','m170228_171113_system_messages','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','ade57e26-bdfd-43c4-bef5-d4ba6220043b'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','f6d3186b-7ca0-498e-8887-02c925fe4822'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','5cc36422-c89b-4c95-a471-8f6ac7b535fe'),(55,NULL,'app','m170414_162429_rich_text_config_setting','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','0329cabc-713a-4520-8eac-069e6ca9e727'),(56,NULL,'app','m170523_190652_element_field_layout_ids','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','26301a5b-b12c-4d28-a3a9-ea7ede151cf2'),(57,NULL,'app','m170612_000000_route_index_shuffle','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','169ba763-9547-4119-babe-db0bb4fe8355'),(58,NULL,'app','m170621_195237_format_plugin_handles','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','b6f0337b-0a13-4736-ac0f-c435005b7143'),(59,NULL,'app','m170630_161028_deprecation_changes','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','05da5489-3c19-4098-89c1-0225a409880e'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','dbc1128f-6ad2-4c3e-ac5f-7fb508f814e8'),(61,NULL,'app','m170704_134916_sites_tables','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','44075ee2-1653-4d75-8612-6ac8b89c996c'),(62,NULL,'app','m170706_183216_rename_sequences','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','43d8f750-8f6c-438c-be08-bac91e060e67'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','ec9bf4c3-3278-435d-9e9d-219489fe3b24'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','60bb9778-c2aa-4995-9101-f48cfac4a52f'),(65,NULL,'app','m170810_201318_create_queue_table','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','3216d1b4-d877-4118-aae3-01e9f755af15'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','faa83552-585c-462d-9bda-7e923885499a'),(67,NULL,'app','m170821_180624_deprecation_line_nullable','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','42122645-f93d-411b-8437-24c79ea553d1'),(68,NULL,'app','m170903_192801_longblob_for_queue_jobs','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','db17ce9a-14f1-449c-a08c-970d40d6a182'),(69,NULL,'app','m170914_204621_asset_cache_shuffle','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','dea6bd2b-f156-4be7-af60-581a3045b24b'),(70,NULL,'app','m171011_214115_site_groups','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','97383247-3dd6-4a0a-9643-9180df27d0c2'),(71,NULL,'app','m171012_151440_primary_site','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','7578f3e8-7388-47f3-8097-80198a915314'),(72,NULL,'app','m171013_142500_transform_interlace','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','91fc1f5d-0050-43d8-886c-001040b3b99e'),(73,NULL,'app','m171016_092553_drop_position_select','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','30483229-3b26-40c0-a3b4-d2459b4b4a85'),(74,NULL,'app','m171016_221244_less_strict_translation_method','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','3490ae3d-c067-4e07-8717-1276d22bcc49'),(75,NULL,'app','m171107_000000_assign_group_permissions','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','040241e3-7d19-487e-9525-95d0baef9f70'),(76,NULL,'app','m171117_000001_templatecache_index_tune','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','6aa78df6-b423-4cab-bd31-9e4f238564da'),(77,NULL,'app','m171126_105927_disabled_plugins','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','f9294c08-a3d7-478c-9729-7134147ee981'),(78,NULL,'app','m171130_214407_craftidtokens_table','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','6b842dc8-4343-4f2e-be07-2886c75409f2'),(79,NULL,'app','m171202_004225_update_email_settings','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','a6c854e1-31b0-4c7f-9c28-4be629a18ab6'),(80,NULL,'app','m171204_000001_templatecache_index_tune_deux','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','ec671994-421a-45d3-bb3d-c722e2e60644'),(81,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','56f925e4-85f0-4fe9-9620-f5c93d878e56'),(82,NULL,'app','m171218_143135_longtext_query_column','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','a0c687d2-d09c-4e92-9502-0d32b17e3d6c'),(83,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','5a372769-0af4-4eda-84f8-80bfdedee12d'),(84,NULL,'app','m180113_153740_drop_users_archived_column','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','cdf6f9fa-f58a-4f86-a4bb-2ca7063886d0'),(85,NULL,'app','m180122_213433_propagate_entries_setting','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','6e6fa68e-497b-4d89-a026-4167b6475aee'),(86,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','f20e7e5b-192f-4e18-b8a1-dcf4080289e7'),(87,NULL,'app','m180128_235202_set_tag_slugs','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','d702dd61-6698-4080-807e-40722b2dfe19'),(88,NULL,'app','m180202_185551_fix_focal_points','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','d0c96a06-043e-4cac-9b19-cf20d47344d4'),(89,NULL,'app','m180217_172123_tiny_ints','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','69589218-d98e-4717-aefd-ffa3de330ce9'),(90,NULL,'app','m180321_233505_small_ints','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','9ef153ed-baa9-4f08-9aa0-61e9cf267041'),(91,NULL,'app','m180328_115523_new_license_key_statuses','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','12f777af-d8c0-4301-83a3-6111bce458a3'),(92,NULL,'app','m180404_182320_edition_changes','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','d00c62aa-14c7-430e-87da-ad543b8d5aa2'),(93,NULL,'app','m180411_102218_fix_db_routes','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','77d6b691-0c19-459c-8c91-9bf0e4a1db16'),(94,NULL,'app','m180416_205628_resourcepaths_table','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','507413a9-5ecc-4a8d-b7ef-f8e46c5e2b59'),(95,NULL,'app','m180418_205713_widget_cleanup','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','47ef3cfa-2de7-40db-a6b5-f07a1a713bbb'),(96,NULL,'app','m180824_193422_case_sensitivity_fixes','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','74f44af5-977c-4987-9fce-d0b4765e0435'),(97,NULL,'app','m180901_151639_fix_matrixcontent_tables','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','75a941bb-6420-4ebd-b665-75ae3a9d2836'),(98,NULL,'app','m181112_203955_sequences_table','2018-12-08 01:19:03','2018-12-08 01:19:03','2018-12-08 01:19:03','3288fc9c-a424-4884-9318-16de0251cf29'),(99,NULL,'app','m170630_161027_deprecation_line_nullable','2019-01-17 02:45:19','2019-01-17 02:45:19','2019-01-17 02:45:19','34da1cf6-839b-46b7-9bdf-4ddb6414832d'),(100,NULL,'app','m180425_203349_searchable_fields','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','6a903528-657b-4734-bd10-fa96e1a9ec51'),(101,NULL,'app','m180516_153000_uids_in_field_settings','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','a720f1a5-2b35-49e5-950a-c60043a36520'),(102,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','2cc6b89a-95ae-4f09-8606-86f05bbd9f79'),(103,NULL,'app','m180518_173000_permissions_to_uid','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','1d71c422-08e9-4a6a-9bdd-db55842d74fc'),(104,NULL,'app','m180520_173000_matrix_context_to_uids','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','e8c23c20-6106-426e-a3da-86549f58edb9'),(105,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','5b532ed3-6b7f-4b89-a5f3-af2c930442a2'),(106,NULL,'app','m180731_162030_soft_delete_sites','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','ed9a727b-07d3-442d-8ba9-ce8c0ce5bda8'),(107,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','6b055ec4-0c1e-482c-a0ff-ff916336378d'),(108,NULL,'app','m180810_214439_soft_delete_elements','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','d7ed982b-c3a1-4e3d-8078-12ec9654d20a'),(109,NULL,'app','m180904_112109_permission_changes','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','4b0da163-640e-4cae-82e4-fd1691067952'),(110,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','2cc26733-09fe-4902-8795-fb31a7222884'),(111,NULL,'app','m181011_160000_soft_delete_asset_support','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','378b481a-86ca-42f1-9b08-a8509bd1431b'),(112,NULL,'app','m181016_183648_set_default_user_settings','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','aa1a4b7f-3986-4ca6-a4ef-f65726ff7879'),(113,NULL,'app','m181017_225222_system_config_settings','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','e4f0a591-7248-4a18-9384-def2b5d373f3'),(114,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','1959e6a7-2c48-495b-a4e6-667c3f99b45b'),(115,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','52998828-6d63-4e18-b18f-a7cad44bf9a8'),(116,NULL,'app','m181121_001712_cleanup_field_configs','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','0184cf52-510c-49b7-a078-cef2848a43aa'),(117,NULL,'app','m181128_193942_fix_project_config','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','d6dfc015-491f-4a67-85e0-c5f2bc121679'),(118,NULL,'app','m181130_143040_fix_schema_version','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','349e9708-be30-4c12-92bf-39116e855811'),(119,NULL,'app','m181211_143040_fix_entry_type_uids','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','5e23c897-aa53-44c6-b297-e87ee2d07940'),(120,NULL,'app','m181213_102500_config_map_aliases','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','f364143d-cdac-4748-b3ab-2cff043364af'),(121,NULL,'app','m181217_153000_fix_structure_uids','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','dbcff585-9d48-4d4f-88d4-9718c7894009'),(122,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','b7611df8-fe24-4e49-99c1-8f40ad992baf'),(123,NULL,'app','m190108_110000_cleanup_project_config','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','67256851-026e-4b9b-a743-22ea82281d9f'),(124,NULL,'app','m190108_113000_asset_field_setting_change','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','310f15c3-f541-4e7f-9780-33b5d0d89bf0'),(125,NULL,'app','m190109_172845_fix_colspan','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','1ffde8d1-560d-417a-9118-b665c8e0c41d'),(126,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','ec9bb94e-5d8e-424e-9f19-e70afda86c67'),(127,NULL,'app','m190110_214819_soft_delete_volumes','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','29e11b08-f8f2-4303-91ef-5d1fe769b3c1'),(128,NULL,'app','m190112_124737_fix_user_settings','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','fed0186d-118f-4693-9e03-8bda5e369025'),(129,NULL,'app','m190112_131225_fix_field_layouts','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','d3b3d5a6-535d-4b49-82d2-3082c59e1a47'),(130,NULL,'app','m190112_201010_more_soft_deletes','2019-01-17 02:45:23','2019-01-17 02:45:23','2019-01-17 02:45:23','05ad73c3-b755-4375-8169-01862577b728'),(131,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-01-17 02:45:24','2019-01-17 02:45:24','2019-01-17 02:45:24','8db848a7-51b0-41d5-a825-ae7b623f5b96'),(132,NULL,'app','m190218_143000_element_index_settings_uid','2019-01-21 18:43:19','2019-01-21 18:43:19','2019-01-21 18:43:19','87022d36-e145-4b80-a2c3-a38504575b63'),(133,NULL,'app','m190121_120000_rich_text_config_setting','2019-01-23 03:11:59','2019-01-23 03:11:59','2019-01-23 03:11:59','6a81a23e-b8c8-4f29-880f-ca2b6de8a44b'),(134,6,'plugin','Install','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','b3f1d685-9e2f-4c5a-b662-e199ed0804b2'),(135,6,'plugin','m180120_140521_CraftUpgrade','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','c77c24cc-5afe-4a9f-9a8f-cb56e16f9f74'),(136,6,'plugin','m180125_124339_UpdateForeignKeyNames','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','c73596da-6dc8-419e-bb26-9578044b5217'),(137,6,'plugin','m180214_094247_AddUniqueTokenToSubmissionsAndForms','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','ef1d9c4a-408f-46de-9a88-b8485d6475e7'),(138,6,'plugin','m180220_072652_ChangeFileUploadFieldColumnType','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','b24eebec-d27a-4545-a03a-848832c95c0c'),(139,6,'plugin','m180326_094124_AddIsSpamToSubmissions','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','161dbb4e-ea48-45b0-beca-ecdf89cbcceb'),(140,6,'plugin','m180405_101920_AddIpAddressToSubmissions','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','a391e090-df9a-4e40-ae4c-cc73abf33f51'),(141,6,'plugin','m180410_131206_CreateIntegrationsQueue','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','f1d3c640-2583-4b46-ba9b-37bc806ae543'),(142,6,'plugin','m180417_134527_AddMultipleSelectTypeToFields','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','963b8697-0373-4228-98fa-e8de53d33cfe'),(143,6,'plugin','m180430_151626_PaymentGateways','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','f7cd4c21-3c15-4c8b-a08e-4284b515d368'),(144,6,'plugin','m180508_095131_CreatePaymentGatewayFieldsTable','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','559fa08c-a5c7-47f9-a747-7b7b3846d3b5'),(145,6,'plugin','m180606_141402_AddConnectionsToFormProperties','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','22ba4a9b-8eeb-4e2c-a213-22c77f1de5db'),(146,6,'plugin','m180730_171628_AddCcDetailsFieldType','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','43fc5921-8d6a-4a89-a00b-795a0d1f434d'),(147,6,'plugin','m180817_091801_AddRulesToFormProperties','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','b373e5fe-7ce9-4485-b222-a48bc763c1fc'),(148,6,'plugin','m181112_152751_ChangeTypeEnumColumnsToIndexedText','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','3acb071c-4de7-4bf3-8ffa-5944e5bd1b98'),(149,6,'plugin','m181129_083939_ChangeIntegrationFieldTypeColumnTypeToString','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','3d143546-039a-4f38-98be-44806eef7ec1'),(150,NULL,'app','m190125_191628_fix_email_transport_password','2019-01-27 18:05:24','2019-01-27 18:05:24','2019-01-27 18:05:24','62f5d309-89fa-4718-aba5-26c4b15a0cd8'),(151,NULL,'app','m190128_181422_cleanup_volume_folders','2019-02-14 03:12:08','2019-02-14 03:12:08','2019-02-14 03:12:08','0cf9e013-8e65-4e24-bc36-0d9af63e536d'),(152,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-02-14 03:12:08','2019-02-14 03:12:08','2019-02-14 03:12:08','b7274303-daa2-47f1-be31-dd66032e1e42'),(153,NULL,'app','m190208_140000_reset_project_config_mapping','2019-02-14 03:12:08','2019-02-14 03:12:08','2019-02-14 03:12:08','9cacb5ad-b2b2-49c8-8558-fc521d9e1acd'),(154,8,'plugin','Install','2019-03-24 19:23:12','2019-03-24 19:23:12','2019-03-24 19:23:12','30e7887a-1f76-40e8-9491-f4f3dd6882b4'),(155,8,'plugin','m180316_130028_Craft3Upgrade','2019-03-24 19:23:12','2019-03-24 19:23:12','2019-03-24 19:23:12','aaffd137-2143-4b1f-8134-7e9068fd36b3'),(156,8,'plugin','m180601_113607_MigrateCalendarEventFieldtype','2019-03-24 19:23:12','2019-03-24 19:23:12','2019-03-24 19:23:12','0b0c5b99-c84c-4da5-90b8-3d22b444c935'),(157,8,'plugin','m180619_120655_MigrateCalendarElementsAndLayouts','2019-03-24 19:23:12','2019-03-24 19:23:12','2019-03-24 19:23:12','f1bd1e28-49ca-4f2b-8cdd-621e10ad84ff'),(158,8,'plugin','m180628_091905_MigrateSelectDates','2019-03-24 19:23:12','2019-03-24 19:23:12','2019-03-24 19:23:12','4a8a5d81-12d8-499a-8656-36891ef9a4c3'),(159,8,'plugin','m180921_124711_AddIcsTimezoneToCalendar','2019-03-24 19:23:12','2019-03-24 19:23:12','2019-03-24 19:23:12','0cd7ce74-c4a3-4c48-849a-701bb568f547'),(160,NULL,'app','m190401_223843_drop_old_indexes','2019-04-18 00:53:49','2019-04-18 00:53:49','2019-04-18 00:53:49','38904bc0-b011-4032-8449-99879440cb5d'),(161,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-04-18 00:53:49','2019-04-18 00:53:49','2019-04-18 00:53:49','7c0f35ab-2ecb-46a2-a98d-594b7c86192d');
/*!40000 ALTER TABLE `acr_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_plugins`
--

LOCK TABLES `acr_plugins` WRITE;
/*!40000 ALTER TABLE `acr_plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_plugins` VALUES (2,'element-api','2.5.4','1.0.0','unknown',NULL,'2018-09-30 16:27:52','2018-09-30 16:27:52','2019-05-11 14:03:16','fd7ba61d-aeb3-45c0-af53-d3686c559a27'),(4,'locate','2.1.1','2.1.1','unknown',NULL,'2018-10-09 00:06:58','2018-10-09 00:06:58','2019-05-11 14:03:16','1f373530-e204-4126-979c-8c8ea0d63667'),(5,'typedlinkfield','1.0.17','1.0.0','unknown',NULL,'2018-10-09 00:14:35','2018-10-09 00:14:35','2019-05-11 14:03:16','074fe6ed-f488-490f-9be5-cb214290542d'),(6,'freeform','2.5.17','2.1.3','invalid',NULL,'2019-01-24 01:47:30','2019-01-24 01:47:30','2019-05-11 14:03:16','3da68d4d-0c17-44e8-9e6c-45beea590e0c'),(7,'copy','1.0.0-RC5','1.0.0','unknown',NULL,'2019-01-31 03:22:12','2019-01-31 03:22:12','2019-05-11 14:03:16','afe7117b-6bc3-43c4-b42c-df63b3a5f704'),(8,'calendar','2.0.19','2.0.5','invalid',NULL,'2019-03-24 19:23:11','2019-03-24 19:23:11','2019-05-11 14:03:16','7f60a9ef-155b-4ac0-ae76-f871f34a03de');
/*!40000 ALTER TABLE `acr_plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_queue`
--

LOCK TABLES `acr_queue` WRITE;
/*!40000 ALTER TABLE `acr_queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_relations`
--

LOCK TABLES `acr_relations` WRITE;
/*!40000 ALTER TABLE `acr_relations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_relations` VALUES (2,2,3,NULL,5,1,'2018-10-08 23:50:21','2018-10-08 23:50:21','2cdae2c9-d6da-4589-88b2-46121909f916'),(17,2,10,NULL,61,1,'2019-01-27 17:55:11','2019-01-27 17:55:11','ce6ab752-6992-4123-83c5-e57d2e05176e'),(18,45,10,NULL,62,1,'2019-01-27 18:02:05','2019-01-27 18:02:05','a9fc58fe-339f-42e3-bdfa-96283d31bde7'),(21,45,64,NULL,63,1,'2019-01-27 18:17:46','2019-01-27 18:17:46','a48dc014-2b5d-4f16-9749-eb1351d436ea'),(25,19,16,NULL,65,1,'2019-01-27 18:25:14','2019-01-27 18:25:14','3b09d751-6ca0-40c9-9b93-119bbb7850fb'),(26,19,17,NULL,66,1,'2019-01-27 18:25:14','2019-01-27 18:25:14','c2c29984-9725-4c1d-aa20-c58ae5aed026'),(27,25,8,NULL,15,1,'2019-01-27 18:25:14','2019-01-27 18:25:14','211cc590-3188-416d-92e1-52ec8aa392ad'),(30,25,67,NULL,62,1,'2019-02-01 01:54:10','2019-02-01 01:54:10','1c7cd2b9-d8df-4500-82e9-ddeb427885bc'),(32,2,11,NULL,147,1,'2019-02-09 21:39:17','2019-02-09 21:39:17','2dc94cff-84d7-4f54-b396-e20712e4c1c6');
/*!40000 ALTER TABLE `acr_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_resourcepaths`
--

LOCK TABLES `acr_resourcepaths` WRITE;
/*!40000 ALTER TABLE `acr_resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_resourcepaths` VALUES ('103d4a5c','@lib/fileupload'),('10ce69d9','@app/web/assets/craftsupport/dist'),('1111302c','@craft/web/assets/updateswidget/dist'),('1144526','@app/web/assets/matrixsettings/dist'),('1155f76a','@craft/web/assets/utilities/dist'),('11ec693','@lib/fileupload'),('1280018f','@app/web/assets/updateswidget/dist'),('12f35adf','@lib/velocity'),('12f8ead1','@lib/jquery-ui'),('14a93147','@swixpop/locate/assetbundles/locatefieldfield/dist'),('156d238','@craft/web/assets/cp/dist'),('1684918c','@lib/xregexp'),('1753e73c','@lib/d3'),('18bd999b','@lib'),('197f5f1c','@craft/web/assets/tablesettings/dist'),('198e2313','@craft/web/assets/matrix/dist'),('19f6c76d','@lib/picturefill'),('1a22bb52','@craft/web/assets/matrixsettings/dist'),('1ac7f04f','@craft/web/assets/cp/dist'),('1bc50aa4','@lib/element-resize-detector'),('1c12ad4e','@app/web/assets/craftsupport/dist'),('1ce8d506','@lib/selectize'),('1ded5799','@app/web/assets/feed/dist'),('1e2ed243','@lib'),('1e352fce','@craft/web/assets/sites/dist'),('1e52fbaf','@lib/jquery-touch-events'),('1e5cc518','@app/web/assets/updateswidget/dist'),('1f1d3785','@lib/jquery-ui'),('208ba84b','@lib/fabric'),('20975863','@bower/jquery/dist'),('20d5a7ee','@craft/web/assets/fields/dist'),('20e68776','@app/web/assets/recententries/dist'),('20f49bcd','@app/web/assets/utilities/dist'),('214d9c0','@craft/web/assets/pluginstore/dist'),('22947639','@app/web/assets/tablesettings/dist'),('24eef0ba','@lib/garnishjs'),('254e9a3e','@craft/web/assets/editentry/dist'),('259249c7','@craft/web/assets/recententries/dist'),('25da562c','@lib/velocity'),('260413bb','@bower/jquery/dist'),('2668341d','@craft/web/assets/updater/dist'),('2693edd0','@app/web/assets/pluginstore/dist'),('26f8dd96','@lib/jquery.payment'),('278eede','@Solspace/Calendar/Resources'),('297bc9f9','@lib/timepicker'),('29def592','@app/web/assets/tablesettings/dist'),('2a4f2947','@app/web/assets/pluginstore/dist'),('2b508503','@bower/jquery/dist'),('2bac4b2e','@lib/jquery.payment'),('2bbe1866','@app/web/assets/utilities/dist'),('2c2703f6','@app/web/assets/matrixsettings/dist'),('2c3a43e1','@app/web/assets/recententries/dist'),('2cec0657','@lib/element-resize-detector'),('2d3f00f6','@lib/jquery.payment'),('2d553b0','@app/web/assets/updater/dist'),('2fab7242','@craft/web/assets/recententries/dist'),('30506ffb','@lib/selectize'),('308a5dc8','@typedlinkfield/resources'),('30de1149','@app/web/assets/feed/dist'),('3118af1e','@lib/velocity'),('316ded69','@craft/web/assets/fields/dist'),('3177646c','@app/web/assets/cp/dist'),('31a82484','@lib/fabric'),('323b786a','@Solspace/Calendar/Resources'),('32e7b69a','@freeform/Resources'),('32eaeb8e','@lib/timepicker'),('33f2d6b0','@lib/timepicker'),('3455a151','@bower/jquery/dist'),('34b4066e','@craft/web/assets/login/dist'),('35497112','@app/web/assets/login/dist'),('35cd7c75','@lib/garnishjs'),('378be4c6','@lib/velocity'),('37c02def','@craft/web/assets/updater/dist'),('37cada2','@bower/jquery/dist'),('38d3d00b','@lib/timepicker'),('39716fcc','@lib/timepicker'),('3995b585','@app/web/assets/login/dist'),('39fdf9c4','@lib/jquery.payment'),('3a3c2b71','@lib/xregexp'),('3a78ce7','@craft/web/assets/feed/dist'),('3adf727e','@lib/velocity'),('3b566c5a','@lib'),('3b9492e2','@app/web/assets/feed/dist'),('3c390768','@craft/web/assets/updates/dist'),('3cb2b1a3','@craft/web/assets/craftsupport/dist'),('3daba0fb','@app/web/assets/cp/dist'),('3dcfb8a0','@app/web/assets/searchindexes/dist'),('3e036bb0','@craft/web/assets/recententries/dist'),('4035c885','@craft/web/assets/utilities/dist'),('403b5b5d','@bower/jquery/dist'),('40615cb6','@craft/web/assets/updateswidget/dist'),('40745f49','@lib/fileupload'),('4076de9c','@lib/jquery.payment'),('41d6e08e','@lib/fileupload'),('428fd95c','@app/web/assets/cp/dist'),('431af5f9','@freeform/Resources'),('4335f57a','@craft/web/assets/updates/dist'),('43be43b1','@craft/web/assets/craftsupport/dist'),('447359f6','@lib/velocity'),('44b0eb45','@app/web/assets/feed/dist'),('4633d8d3','@lib/d3'),('46b1cc22','@app/web/assets/login/dist'),('470179c4','@app/web/assets/updateswidget/dist'),('476be47','@freeform/Resources'),('47e4ae63','@lib/xregexp'),('481f60f3','@craft/web/assets/tablesettings/dist'),('48245e1','@app/web/assets/installer/dist'),('486c2fd2','@app/web/assets/feed/dist'),('4896f882','@lib/picturefill'),('48ee1cfc','@craft/web/assets/matrix/dist'),('4993d505','@app/web/assets/craftsupport/dist'),('49c55af7','@app/web/assets/cp/dist'),('4af7e635','@lib/fileupload'),('4ba7cfa0','@craft/web/assets/cp/dist'),('4bb8f47c','@craft/web/assets/login/dist'),('4befdb0b','@lib/fileupload'),('4c02ef6','@lib/element-resize-detector'),('4c70a196','@lib/fabric'),('4d88eae9','@lib/selectize'),('4d9303c8','@lib/jquery.payment'),('4db4cec9','@lib/prismjs'),('4dde8609','@bower/jquery/dist'),('4dfb4f89','@app/web/assets/login/dist'),('4e145d0c','@lib/velocity'),('4f32c440','@lib/jquery-touch-events'),('507ef97c','@lib/fileupload'),('50ff3522','@app/web/assets/updates/dist'),('519dd177','@craft/web/assets/utilities/dist'),('51b4ac20','@lib/velocity'),('51d91631','@craft/web/assets/updateswidget/dist'),('521fe7cb','@lib/picturefill'),('5233f2e4','@lib/jquery.payment'),('5307daf5','@lib/picturefill'),('530c26fd','@app/web/assets/utilities/dist'),('5316249b','@app/web/assets/editentry/dist'),('54887d7a','@app/web/assets/recententries/dist'),('54a3e637','@lib/jquery-touch-events'),('55bbdb09','@lib/jquery-touch-events'),('55fcae8b','@bower/jquery/dist'),('56397ee6','@lib/d3'),('56b7bfd3','@app/web/assets/matrix/dist'),('56c722ac','@lib/xregexp'),('56fa8c35','@app/web/assets/tablesettings/dist'),('57542bfb','@app/web/assets/updater/dist'),('579bc121','@lib/d3'),('5854f61e','@lib/jquery.payment'),('589c5eb7','@lib/picturefill'),('593675a8','@lib/garnishjs'),('593ee170','@lib/picturefill'),('5946050e','@craft/web/assets/matrix/dist'),('59959de7','@app/web/assets/editentry/dist'),('59b77901','@craft/web/assets/tablesettings/dist'),('59b79477','@app/web/assets/pluginstore/dist'),('5a1f8527','@craft/web/assets/cp/dist'),('5a2648a2','@app/web/assets/tablesettings/dist'),('5a42682c','@craft/web/assets/editentry/dist'),('5a84436f','@craft/web/assets/cp/dist'),('5ba4eaf2','@craft/web/assets/utilities/dist'),('5c3406af','@app/web/assets/matrix/dist'),('5c37304','@lib/timepicker'),('5c517174','@lib/velocity'),('5c5ac17a','@lib/jquery-ui'),('5cab6626','@lib/selectize'),('5cbac79a','@lib/d3'),('5da2faa4','@lib/d3'),('5dbe68fc','@lib/prismjs'),('5e8583e','@craft/web/assets/dashboard/dist'),('5e9addb2','@lib/jquery-touch-events'),('5f386275','@lib/jquery-touch-events'),('5f9baa71','@bower/jquery/dist'),('5fc2fed1','@app/web/assets/recententries/dist'),('5fd0e26a','@app/web/assets/utilities/dist'),('600dd286','@craft/web/assets/fields/dist'),('601491e2','@swixpop/locate/assetbundles/locate/dist'),('60861a67','@app/web/assets/matrix/dist'),('60c80959','@app/web/assets/login/dist'),('60c81b6b','@lib/fabric'),('6178bcbf','@app/web/assets/updateswidget/dist'),('6246d9e','@app/web/assets/generalsettings/dist'),('624e2dfc','@lib/element-resize-detector'),('638a7ebd','@lib/jquery-touch-events'),('6426d6a7','@lib/garnishjs'),('642e427f','@lib/picturefill'),('64a093d5','@app/web/assets/craftsupport/dist'),('64f61c27','@app/web/assets/cp/dist'),('65846960','@lib/garnishjs'),('661ca4f','@lib/selectize'),('66a01200','@craft/web/assets/updater/dist'),('66ce9096','@app/web/assets/updates/dist'),('6706bf3','@lib/d3'),('67b16b89','@lib'),('67d6ada8','@app/web/assets/updates/dist'),('67d99612','@app/web/assets/routes/dist'),('68d5eb6','@app/web/assets/utilities/dist'),('68e37b9','@lib/xregexp'),('69387ad9','@lib/timepicker'),('6a323f14','@app/web/assets/updateswidget/dist'),('6a8b622e','@lib/d3'),('6b212c10','@craft/web/assets/dbbackup/dist'),('6b73cd89','@lib/jquery-ui'),('6c4d29ea','@app/web/assets/updates/dist'),('6cbb8f71','@typedlinkfield/resources'),('6dd66f73','@lib'),('6e0d296f','@Solspace/Calendar/Resources'),('6e1fed22','@lib/garnishjs'),('6f07d01c','@lib/garnishjs'),('6f63545f','@craft/web/assets/recententries/dist'),('6fa43853','@app/web/assets/editentry/dist'),('6fabf0a8','@lib/element-resize-detector'),('6fea107e','@app/web/assets/craftsupport/dist'),('700b0184','@lib/element-resize-detector'),('70c2bd5e','@lib/fabric'),('712dee80','@app/web/assets/updater/dist'),('71600299','@lib/fabric'),('71a5cb74','@craft/web/assets/fields/dist'),('722cf49e','@app/web/assets/deprecationerrors/dist'),('72a7e84','@craft/web/assets/updates/dist'),('72c887e','@lib/xregexp'),('73b0e69b','@app/web/assets/dashboard/dist'),('7476e9db','@lib/jquery-ui'),('74d7c8d5','@app/web/assets/fields/dist'),('757abf2a','@app/web/assets/matrixsettings/dist'),('758ecf55','@lib/garnishjs'),('767ba5','@craft/web/assets/utilities/dist'),('77185887','@craft/web/assets/updater/dist'),('77839ecf','@craft/web/assets/updater/dist'),('779f771','@lib/selectize'),('78119aa5','@lib'),('781bf616','@lib/timepicker'),('782b62d9','@app/web/assets/dashboard/dist'),('79227f63','@lib/jquery-ui'),('79335fe7','@app/web/assets/dashboard/dist'),('79a67bbd','@app/web/assets/matrixsettings/dist'),('79bb3baa','@app/web/assets/recententries/dist'),('7a3e0668','@swixpop/locate/assetbundles/locate/dist'),('7a410422','@lib/fabric'),('7a676d2b','@app/web/assets/updater/dist'),('7a6c057e','@lib/element-resize-detector'),('7ae4aa2c','@craft/web/assets/dashboard/dist'),('7b59391c','@lib/fabric'),('7cab7ef5','@craft/web/assets/feed/dist'),('7cc64381','@lib/fileupload'),('7e5471a9','@app/web/assets/fields/dist'),('7edb1ed8','@craft/web/assets/recententries/dist'),('7fb134bb','@lib/jquery-ui'),('808b8aaa','@lib/jquery-ui'),('813d7330','@craft/web/assets/editentry/dist'),('81609e3b','@craft/web/assets/cp/dist'),('8173b174','@lib/d3'),('81829710','@app/web/assets/dashboard/dist'),('8193b794','@lib/jquery-ui'),('82f0ccd5','@lib/fabric'),('831f9f0b','@app/web/assets/updater/dist'),('8366994','@craft/web/assets/matrix/dist'),('8391c0e4','@craft/web/assets/feed/dist'),('8463870d','@lib/fabric'),('847f7725','@bower/jquery/dist'),('84a64ee0','@craft/web/assets/fields/dist'),('84d30c97','@lib/velocity'),('85e7aa01','@lib/garnishjs'),('86e5b95e','@app/web/assets/fields/dist'),('8744fb02','@lib/xregexp'),('874fbb72','@lib/selectize'),('875d906b','@app/web/assets/editentry/dist'),('881bae46','@craft/web/assets/pluginstore/dist'),('8872ade7','@lib/jquery-touch-events'),('88841b49','@app/web/assets/updater/dist'),('899c2677','@app/web/assets/updater/dist'),('89a8fb61','@craft/web/assets/feed/dist'),('89d72fb0','@lib/jquery.payment'),('89f2a4e1','@craft/web/assets/updates/dist'),('8ab2b12f','@lib/jquery-ui'),('8ac814bb','@app/web/assets/dashboard/dist'),('8af4a76e','@lib/prismjs'),('8b100ee8','@lib/jquery-ui'),('8c0fb41f','@app/web/assets/cp/dist'),('8c7159b','@craft/web/assets/tablesettings/dist'),('8d23fff8','@lib/xregexp'),('8d28bf88','@lib/selectize'),('8d54ba2','@lib/picturefill'),('8daf3af5','@app/web/assets/fields/dist'),('8fa45a6d','@lib/fabric'),('8fd69125','@lib/picturefill'),('908539b7','@craft/web/assets/editentry/dist'),('90a17e3f','@lib/fabric'),('91255333','@lib/garnishjs'),('92830ed4','@lib/xregexp'),('934acd34','@app/web/assets/updateswidget/dist'),('950a970a','@lib/selectize'),('9535dbca','@app/web/assets/updates/dist'),('955cfbea','@bower/jquery/dist'),('95f08058','@lib/velocity'),('9643e5b7','@app/web/assets/craftsupport/dist'),('973e90db','@lib/fileupload'),('975bd889','@app/web/assets/craftsupport/dist'),('97b618eb','@lib/garnishjs'),('9800e293','@craft/web/assets/feed/dist'),('984aee66','@craft/web/assets/updates/dist'),('98d1282e','@craft/web/assets/updates/dist'),('98d14976','@app/web/assets/updateswidget/dist'),('98ef4a5e','@lib/selectize'),('98f4a37f','@lib/jquery.payment'),('994b84e','@lib/element-resize-detector'),('99c97448','@app/web/assets/updateswidget/dist'),('9ae28e53','@lib/garnishjs'),('9b1aa8dd','@lib/jquery-ui'),('9b1e47aa','@craft/web/assets/updateswidget/dist'),('9dd861f5','@app/web/assets/craftsupport/dist'),('9e7f5861','@app/web/assets/updates/dist'),('9f66d380','@lib/xregexp'),('9f8d2d0f','@craft/web/assets/utilities/dist'),('a0179c28','@lib/fileupload'),('a01e61be','@app/web/assets/pluginstore/dist'),('a05e8546','@lib/jquery-touch-events'),('a09c7c25','@app/web/assets/fields/dist'),('a10100d7','@swixpop/locate/assetbundles/locatefieldfield/dist'),('a1065c80','@app/web/assets/pluginstore/dist'),('a1245510','@app/web/assets/editentry/dist'),('a19bb130','@craft/web/assets/dashboard/dist'),('a29844b5','@lib/d3'),('a2d88fcf','@lib/prismjs'),('a40b0f6d','@lib/d3'),('a49e54e3','@craft/web/assets/utilities/dist'),('a54cf48f','@app/web/assets/matrix/dist'),('a5a405c4','@craft/web/assets/recententries/dist'),('a5ec68d','@app/web/assets/matrixsettings/dist'),('a667406e','@app/web/assets/deprecationerrors/dist'),('a66b0b18','@app/web/assets/recententries/dist'),('a715dfd7','@craft/web/assets/craftsupport/dist'),('a7733626','@app/web/assets/recententries/dist'),('a78872cc','@lib/fabric'),('a7fab984','@lib/picturefill'),('a7fb526b','@app/web/assets/dashboard/dist'),('a91f52af','@lib/prismjs'),('a95f99d5','@lib/d3'),('aa6ed6bb','@app/web/assets/editentry/dist'),('aaae2f3c','@lib/picturefill'),('ab27ded','@app/web/assets/findreplace/dist'),('ab995826','@lib/jquery-touch-events'),('abefdcd0','@lib/element-resize-detector'),('ac3d64e4','@lib/picturefill'),('ac45809a','@craft/web/assets/matrix/dist'),('ac67439b','@craft/web/assets/updater/dist'),('acb4fc95','@craft/web/assets/tablesettings/dist'),('ad0a13fe','@lib/jquery-touch-events'),('ad763a12','@lib'),('ad7c56a1','@lib/timepicker'),('adac253','@lib/jquery-ui'),('adf08f5a','@app/web/assets/recententries/dist'),('af8c1977','@lib/prismjs'),('afe918db','@craft/web/assets/matrixsettings/dist'),('b023fbb7','@craft/web/assets/dashboard/dist'),('b0b16733','@app/web/assets/plugins/dist'),('b0bda8d7','@app/web/assets/cp/dist'),('b2462ec2','@lib/fileupload'),('b2cea6f2','@lib/garnishjs'),('b3391586','@Solspace/Calendar/Resources'),('b483bda9','@app/web/assets/login/dist'),('b4d5651a','@lib/fileupload'),('b51a71ef','@Solspace/Freeform/Resources'),('b65abd87','@lib/d3'),('b6bdc625','@craft/web/assets/craftsupport/dist'),('b6fe9bd','@craft/web/assets/cp/dist'),('b7a21220','@lib/jquery-ui'),('b8069d1a','@app/web/assets/updates/dist'),('b8bba377','@lib/timepicker'),('b8ff9dd6','@lib/picturefill'),('b929de','@craft/web/assets/updateswidget/dist'),('ba3e11ab','@app/web/assets/cp/dist'),('bacc501f','@lib/element-resize-detector'),('bb262c95','@app/web/assets/cp/dist'),('bc84fda0','@craft/web/assets/craftsupport/dist'),('bdc6a9','@lib/jquery-ui'),('bdddab9d','@lib/prismjs'),('be51525c','@craft/web/assets/matrixsettings/dist'),('bebb71e8','@craft/web/assets/login/dist'),('bf12b87a','@lib/fileupload'),('bf1839eb','@app/web/assets/login/dist'),('bf5ba114','@lib/jquery-touch-events'),('bfad83c3','@app/web/assets/updater/dist'),('bfda52df','@typedlinkfield/resources'),('c00c04c4','@typedlinkfield/resources'),('c0d8ec5','@lib/xregexp'),('c174ba8e','@lib/picturefill'),('c1be93f2','@lib/fileupload'),('c1e50658','@craft/web/assets/editentry/dist'),('c234478b','@lib/d3'),('c23d672b','@app/web/assets/feed/dist'),('c3255a15','@app/web/assets/feed/dist'),('c41b2a8a','@lib/velocity'),('c43cc405','@bower/jquery/dist'),('c4b743ae','@app/web/assets/sites/dist'),('c5b9954d','@lib/velocity'),('c61788ff','@lib/timepicker'),('c6d0864c','@lib/jquery-touch-events'),('c714d50d','@lib/element-resize-detector'),('c93a82fc','@craft/web/assets/updates/dist'),('c960dd7c','@craft/web/assets/feed/dist'),('c9949c90','@lib/jquery.payment'),('c9a6e369','@app/web/assets/feed/dist'),('ca7a9732','@lib/jquery-ui'),('cb355b18','@lib/jquery-touch-events'),('cb431e47','@lib/timepicker'),('cbd99708','@lib/fileupload'),('cc9167da','@lib/picturefill'),('cdd0559f','@lib/timepicker'),('ce22110f','@lib/velocity'),('ce27333','@lib/selectize'),('cf3a2c31','@lib/velocity'),('cf9637f8','@swixpop/locate/assetbundles/locate/dist'),('cfd19adf','@lib/d3'),('d01232e4','@typedlinkfield/resources'),('d04d1faa','@craft/web/assets/editentry/dist'),('d1220e83','@app/web/assets/matrix/dist'),('d15b3fb','@lib/xregexp'),('d16f3d65','@app/web/assets/tablesettings/dist'),('d1c4f82b','@lib/xregexp'),('d205bee7','@lib/jquery.payment'),('d2c6ea46','@app/web/assets/utilities/dist'),('d2dce820','@app/web/assets/editentry/dist'),('d31d83d9','@lib/jquery.payment'),('d33196f6','@lib/picturefill'),('d36bb189','@craft/web/assets/updater/dist'),('d40ccf4','@lib/selectize'),('d4366230','@bower/jquery/dist'),('d4796624','@lib/fileupload'),('d495aa34','@lib/jquery-touch-events'),('d594ddf7','@bower/jquery/dist'),('d5b33378','@lib/velocity'),('d613a0bd','@lib/prismjs'),('d7f3b25d','@lib/d3'),('d83c8562','@lib/jquery.payment'),('d845533a','@app/web/assets/utilities/dist'),('d8929b0e','@craft/web/assets/updates/dist'),('d8d897fb','@craft/web/assets/feed/dist'),('d912acad','@lib/timepicker'),('d956920c','@lib/picturefill'),('d95d6e04','@app/web/assets/utilities/dist'),('d99cbb70','@lib/fileupload'),('d99e3aa5','@lib/jquery.payment'),('daa8f7d6','@craft/web/assets/recententries/dist'),('db591bfd','@lib/jquery-ui'),('db92a6f1','@craft/web/assets/utilities/dist'),('dba8bca1','@lib/selectize'),('dbec8419','@app/web/assets/tablesettings/dist'),('dc642484','@craft/web/assets/cp/dist'),('dc74a447','@lib/prismjs'),('dd94b6a7','@lib/d3'),('de002cb7','@app/web/assets/editentry/dist'),('deb5db4c','@bower/jquery/dist'),('dec02aa4','@craft/web/assets/deprecationerrors/dist'),('def2aece','@lib/jquery-touch-events'),('dfade672','@bower/jquery/dist'),('e099727','@app/web/assets/updater/dist'),('e143c458','@craft/web/assets/dashboard/dist'),('e15b21c6','@app/web/assets/updates/dist'),('e2901db7','@typedlinkfield/resources'),('e412b5b8','@craft/web/assets/updateswidget/dist'),('e44ea5db','@lib/garnishjs'),('e4cf8433','@lib/fabric'),('e52c266d','@lib/jquery.payment'),('e69f1ab4','@lib'),('e6edf4d8','@lib/xregexp'),('e787278a','@lib'),('e7cdaabf','@craft/web/assets/craftsupport/dist'),('e878c865','@craft/web/assets/updater/dist'),('e8847ef8','@bower/jquery/dist'),('e92a5967','@lib/fabric'),('ebac6ff0','@lib/element-resize-detector'),('ec81b052','@lib/selectize'),('ed4f537','@lib/jquery.payment'),('ed87e551','@app/web/assets/updates/dist'),('edbded','@craft/web/assets/utilities/dist'),('edbe1c0f','@lib'),('ee29a121','@lib/garnishjs'),('ee3ba05e','@lib/timepicker'),('ee74f68e','@app/web/assets/utilities/dist'),('ef213ec6','@craft/web/assets/matrixsettings/dist'),('f03d4d87','@lib/element-resize-detector'),('f07f396','@lib/element-resize-detector'),('f0ebddaa','@craft/web/assets/dashboard/dist'),('f10871e5','@lib/fabric'),('f12570b9','@lib/element-resize-detector'),('f189500d','@lib/garnishjs'),('f22f0dea','@lib/xregexp'),('f27a2a20','@app/web/assets/dashboard/dist'),('f2ef0e7a','@app/web/assets/matrixsettings/dist'),('f3849400','@lib/selectize'),('f4bc4632','@lib/xregexp'),('f51d046e','@app/web/assets/fields/dist'),('f675e038','@craft/web/assets/craftsupport/dist'),('f717760','@lib/jquery-touch-events'),('f8434960','@lib/selectize'),('f86cb706','@app/web/assets/matrixsettings/dist'),('f90b8985','@lib/velocity'),('f9c1c0f9','@app/web/assets/fields/dist'),('f9e8d08a','@lib/xregexp'),('fa047602','@lib/element-resize-detector'),('fa730e9','@app/web/assets/tablesettings/dist'),('fad2e62f','@craft/web/assets/dashboard/dist'),('fb6f751f','@lib/fabric'),('fba6c9c5','@lib/element-resize-detector'),('fc1605fd','@lib'),('fc6c8d59','@lib/garnishjs'),('fe6c6c29','@craft/web/assets/cp/dist'),('fe7357f5','@craft/web/assets/login/dist'),('fe892734','@craft/web/assets/matrixsettings/dist'),('fea6eeb7','@app/web/assets/dashboard/dist'),('fed002b8','@lib/selectize');
/*!40000 ALTER TABLE `acr_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_searchindex`
--

LOCK TABLES `acr_searchindex` WRITE;
/*!40000 ALTER TABLE `acr_searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_searchindex` VALUES (1,'username',0,1,' wesley cole87 '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' wesley cole87 gmail com '),(1,'slug',0,1,''),(2,'id',0,1,' 2 '),(2,'title',0,1,' test event '),(2,'startdate',0,1,' 2018 09 03 00 00 00 '),(2,'enddate',0,1,' 2018 09 03 23 59 59 '),(2,'slug',0,1,' test event '),(2,'field',1,1,''),(3,'slug',0,1,''),(3,'field',2,1,' white logo notag '),(5,'kind',0,1,' image '),(5,'slug',0,1,''),(5,'extension',0,1,' png '),(5,'filename',0,1,' white logo notag png '),(5,'title',0,1,' white logo notag '),(6,'slug',0,1,' about '),(6,'title',0,1,' about '),(24,'field',34,1,' 2352 w hanford rd burlington nc 27215 https goo gl maps 3egeq92j2t72 burlington 336 227 5000 101 barnes st carrboro nc 27510 https goo gl maps prdht1bgbgm carrboro 919 929 2099 2719 hillsborough rd durham nc 27705 https goo gl maps 2klv6fa1xyj2 durham 919 286 2228 2201 binford st greensboro nc 27407 https goo gl maps qyvyumkfoxy greensboro 336 854 5800 2416 alwin ct raleigh nc 27604 https goo gl maps 9eesxovcqut raleigh 919 861 2277 3207 burnt mill dr wilmington nc 28403 https goo gl maps gqggihh59ut2 wilmington 910 442 3303 1735 link rd winston salem nc 27103 https goo gl maps zr6hsx5wqmk2 winston salem 336 831 0505 4125 bayswater rd winterville nc 28590 https goo gl maps ux9umltbdsb2 winterville 252 754 2653 4040 s alston ave durham nc 27713 https goo gl maps rmo31c2wpc92 central services 919 765 8081 '),(25,'field',35,1,' burlington '),(25,'field',36,1,' 2352 w hanford rd burlington nc 27215 '),(25,'field',37,1,' 336 227 5000 '),(25,'slug',0,1,''),(26,'field',35,1,' carrboro '),(26,'field',36,1,' 101 barnes st carrboro nc 27510 '),(26,'field',37,1,' 919 929 2099 '),(26,'slug',0,1,''),(27,'field',35,1,' durham '),(27,'field',36,1,' 2719 hillsborough rd durham nc 27705 '),(24,'title',0,1,' locations '),(24,'slug',0,1,' locations '),(8,'slug',0,1,' home '),(8,'title',0,1,' home '),(9,'filename',0,1,' oct 18 web promo jpg '),(9,'extension',0,1,' jpg '),(9,'kind',0,1,' image '),(9,'slug',0,1,''),(9,'title',0,1,' oct 18 web promo '),(64,'field',45,1,' dec18 web promo '),(63,'slug',0,1,''),(63,'title',0,1,' dec18 web promo '),(63,'extension',0,1,' jpg '),(63,'filename',0,1,' dec18 web promo jpg '),(11,'field',7,1,' http blog bcwinstitute org 87 organizations honored as certified best christian workplaces 2018 '),(11,'field',2,1,' bcwi_certified_2018_clear e1533605047308 '),(11,'field',6,1,' acr supply honored as certified best christian workplace for 2018 '),(11,'slug',0,1,' new store hours '),(11,'title',0,1,' best christian workplaces '),(8,'field',8,1,' what we do best '),(8,'field',9,1,' as the weather cools you may be seeing pests around your house in the fall months here are some things to be on the lookout for '),(8,'field',10,1,' what we do best '),(8,'field',11,1,' as the weather cools you may be seeing pests around your house in the fall months here are some things to be on the lookout for '),(8,'field',12,1,' we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time thousands of products we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time https shop acrsupply com thousands of products we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time thousands of products '),(67,'field',25,1,' slider '),(67,'field',26,1,' stay updated with acr '),(12,'field',13,1,' thousands of products '),(12,'field',14,1,' we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time '),(12,'field',15,1,''),(67,'field',27,1,' get vip access for early announcements for all our events and sales '),(12,'slug',0,1,''),(13,'field',13,1,' thousands of products '),(13,'field',14,1,' we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time '),(13,'field',15,1,' https shop acrsupply com '),(13,'slug',0,1,''),(14,'field',13,1,' thousands of products '),(14,'field',14,1,' we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time '),(14,'field',15,1,''),(14,'slug',0,1,''),(8,'field',16,1,' red shop online explore our catalog of products warehouse https store acrsupply com blue request online account quickly request an account to shop with us training lab http acrsupply test request e store account '),(15,'filename',0,1,' building lights bw png '),(15,'extension',0,1,' png '),(15,'kind',0,1,' image '),(15,'slug',0,1,''),(15,'title',0,1,' building lights bw '),(16,'field',17,1,' shop online '),(16,'field',18,1,' explore our catalog of products '),(16,'field',19,1,' warehouse '),(16,'slug',0,1,''),(17,'field',17,1,' request online account '),(17,'field',18,1,' quickly request an account to shop with us '),(17,'field',19,1,' training lab '),(17,'slug',0,1,''),(16,'field',20,1,' red '),(17,'field',20,1,' blue '),(16,'field',22,1,' https store acrsupply com '),(17,'field',22,1,' http acrsupply test request e store account '),(18,'field',23,1,' mark webster '),(18,'field',24,1,' mark macurdy was working at a job site over the weekend emergency call and needed some parts to get a 600 ton chiller up for a customer mark called the after hours number and got jeff mark said that he not only got the part for him he dropped it off at the job site so mark never had to stop working but he also dropped off some water for mark as well mark could not say enough about the professional manner in how he handled having to come out on sunday 102 degrees but he went the extra step to make sure mark was hydrated please recognize this young man in front of your group for going the extra mile troy you know as well as anyone that parts are parts and everyone has them but very few companies find people who go the extra mile this guy will help acr keep customers for life '),(18,'slug',0,1,' mark webster testimonial '),(18,'title',0,1,' mark webster testimonial '),(8,'field',26,1,' stay updated with acr '),(8,'field',27,1,' get vip access for early announcements for all our events and sales '),(8,'field',25,1,' building lights bw '),(22,'field',2,1,''),(22,'field',29,1,' https itunes apple com app acr supply store id1122845601 '),(22,'field',30,1,' https play google com store apps details id=io gonative android pdzwn '),(22,'field',31,1,' https www facebook com acrsupply '),(22,'slug',0,1,''),(22,'field',32,1,''),(22,'field',33,1,' north carolina s leading hvac and refrigeration wholesale distributor '),(27,'slug',0,1,''),(27,'field',37,1,' 919 286 2228 '),(28,'field',35,1,' greensboro '),(28,'field',36,1,' 2201 binford st greensboro nc 27407 '),(28,'field',37,1,' 336 854 5800 '),(28,'slug',0,1,''),(29,'field',35,1,' raleigh '),(29,'field',36,1,' 2416 alwin ct raleigh nc 27604 '),(29,'field',37,1,' 919 861 2277 '),(29,'slug',0,1,''),(30,'field',35,1,' wilmington '),(30,'field',36,1,' 3207 burnt mill dr wilmington nc 28403 '),(30,'field',37,1,' 910 442 3303 '),(30,'slug',0,1,''),(31,'field',35,1,' winston salem '),(31,'field',36,1,' 1735 link rd winston salem nc 27103 '),(31,'field',37,1,' 336 831 0505 '),(31,'slug',0,1,''),(32,'field',35,1,' winterville '),(32,'field',36,1,' 4125 bayswater rd winterville nc 28590 '),(32,'field',37,1,' 252 754 2653 '),(32,'slug',0,1,''),(33,'field',35,1,' central services '),(33,'field',36,1,' 4040 s alston ave durham nc 27713 '),(33,'field',37,1,' 919 765 8081 '),(33,'slug',0,1,''),(25,'field',38,1,' https goo gl maps 3egeq92j2t72 '),(26,'field',38,1,' https goo gl maps prdht1bgbgm '),(27,'field',38,1,' https goo gl maps 2klv6fa1xyj2 '),(28,'field',38,1,' https goo gl maps qyvyumkfoxy '),(29,'field',38,1,' https goo gl maps 9eesxovcqut '),(30,'field',38,1,' https goo gl maps gqggihh59ut2 '),(31,'field',38,1,' https goo gl maps zr6hsx5wqmk2 '),(32,'field',38,1,' https goo gl maps ux9umltbdsb2 '),(33,'field',38,1,' https goo gl maps rmo31c2wpc92 '),(34,'slug',0,1,' acr cares '),(34,'title',0,1,' acr cares '),(34,'field',39,1,' roc solid foundation builds hope for children battling cancer and their families by offering opportunities for them to do what they do best play roc solid partners with local groups to build playsets and remodel the rooms of children battling cancer acr cares will be building a playset with roc solid october 2018 roc solid foundations providing stability and resources for families everywhere acr cares partners with the local ronald mcdonald house s to cook meals provide gifts and needed materials at christmas time and sponsors a family every christmas ronald mcdonald house operation resolute is a non profit organization based in north carolina that is dedicated to sustaining and strengthening families within the us armed forces by serving with and working through military chaplains by partnering with chaplains operation resolute works within the parameters of the us military while adorning the gospel by being salt and light acr cares partners with operation resolute by hosting daddy daughter dances spouse retreats and other events operation resolute acr cares is currently building an orphanage in the country of burkina faso burkina faso human coalition is a group dedicated to helping women at risk of having an abortion see the beauty of choosing life acr cares takes part in the annual fundraising event 4000 steps human coalition '),(35,'field',40,1,''),(35,'field',41,1,' roc solid foundations '),(35,'field',42,1,' roc solid foundation builds hope for children battling cancer and their families by offering opportunities for them to do what they do best play roc solid partners with local groups to build playsets and remodel the rooms of children battling cancer acr cares will be building a playset with roc solid october 2018 '),(35,'slug',0,1,''),(36,'field',40,1,''),(36,'field',41,1,' ronald mcdonald house '),(36,'field',42,1,' providing stability and resources for families everywhere acr cares partners with the local ronald mcdonald house s to cook meals provide gifts and needed materials at christmas time and sponsors a family every christmas '),(36,'slug',0,1,''),(37,'field',40,1,''),(37,'field',41,1,' operation resolute '),(37,'field',42,1,' operation resolute is a non profit organization based in north carolina that is dedicated to sustaining and strengthening families within the us armed forces by serving with and working through military chaplains by partnering with chaplains operation resolute works within the parameters of the us military while adorning the gospel by being salt and light acr cares partners with operation resolute by hosting daddy daughter dances spouse retreats and other events '),(37,'slug',0,1,''),(38,'field',40,1,''),(38,'field',41,1,' burkina faso '),(38,'field',42,1,' acr cares is currently building an orphanage in the country of burkina faso '),(38,'slug',0,1,''),(39,'field',40,1,''),(39,'field',41,1,' human coalition '),(39,'field',42,1,' human coalition is a group dedicated to helping women at risk of having an abortion see the beauty of choosing life acr cares takes part in the annual fundraising event 4000 steps '),(39,'slug',0,1,''),(34,'field',43,1,' annual scholarship to our team members children benevolence fund for team members going through difficult times corporate chaplains ministry pamphlets in all our locations annual awards banquet annual family fun day marriage retreats for team members and their spouses volunteer policy mission trip policy disaster relief policy '),(40,'field',44,1,' annual scholarship to our team members children '),(40,'slug',0,1,''),(41,'field',44,1,' benevolence fund for team members going through difficult times '),(41,'slug',0,1,''),(42,'field',44,1,' corporate chaplains '),(42,'slug',0,1,''),(43,'field',44,1,' ministry pamphlets in all our locations '),(43,'slug',0,1,''),(44,'field',44,1,' annual awards banquet '),(44,'slug',0,1,''),(45,'field',44,1,' annual family fun day '),(45,'slug',0,1,''),(46,'field',44,1,' marriage retreats for team members and their spouses '),(46,'slug',0,1,''),(47,'field',44,1,' volunteer policy '),(47,'slug',0,1,''),(48,'field',44,1,' mission trip policy '),(48,'slug',0,1,''),(49,'field',44,1,' disaster relief policy '),(49,'slug',0,1,''),(50,'slug',0,1,' contact '),(50,'title',0,1,' contact '),(52,'title',0,1,' request e store account '),(52,'slug',0,1,' request e store account '),(53,'slug',0,1,' e store credit application '),(53,'title',0,1,' e store credit application '),(54,'slug',0,1,' pay online '),(54,'title',0,1,' pay online '),(55,'slug',0,1,' training and education '),(55,'title',0,1,' training and education '),(56,'slug',0,1,' scholarships '),(56,'title',0,1,' scholarships '),(57,'slug',0,1,' careers '),(57,'title',0,1,' careers '),(58,'slug',0,1,' associates '),(58,'title',0,1,' associates '),(60,'title',0,1,' about us '),(60,'slug',0,1,' about us '),(61,'filename',0,1,' slider png '),(61,'extension',0,1,' png '),(61,'kind',0,1,' image '),(61,'slug',0,1,''),(61,'title',0,1,' slider '),(62,'filename',0,1,' slider png '),(62,'extension',0,1,' png '),(62,'kind',0,1,' image '),(62,'slug',0,1,''),(62,'title',0,1,' slider '),(63,'kind',0,1,' image '),(64,'field',4,1,''),(64,'slug',0,1,' dec18 promotion '),(64,'title',0,1,' dec18 promotion '),(65,'filename',0,1,' warehouse jpg '),(65,'extension',0,1,' jpg '),(65,'kind',0,1,' image '),(65,'slug',0,1,''),(65,'title',0,1,' warehouse '),(66,'filename',0,1,' training lab jpg '),(66,'extension',0,1,' jpg '),(66,'kind',0,1,' image '),(66,'slug',0,1,''),(66,'title',0,1,' training lab '),(67,'slug',0,1,''),(6,'field',46,1,' a culture of family a culture that truly does try to serve others over self a customer focused culture of respect open communication and resolving conflict in a healthy manor a great environment with positive attitudes acr is a customer focused company that cares deeply about its employees acr is a place that creates an environment where team members want to get up and come to work everyday if you have ever dreaded going to a job then you know why this is soooo important acr is family and it is a place where you do not have to worry about weather or not you will have a job the next day if something happens in your life becasue acr has your back no matter what acr s culture reflects our guiding principles amazing couldn t ask for a better family amazing culture awesome culture when people buy in team work awesome balance of team work and customer service with integrity big family caring about people passionate about solutions and to glorify god caring god based culture christ centered customer focused associate friendly close family customer focused customer driven effective diverse accepted encouraged it feels like a family all the staff are great to work with employee and customer based something on a level i haven t seen in previous jobs encouraging supportive and happy everybody acts like a big family and you can tell when we have meetings that everyone genuinely gets along everyone willing to help excellent culture it s awesome being at a workplace where everyone actually wants to be at work and genuinely cares about the big picture family family atmosphere everyone gets along great family business family oriented honest ethical family community for me it s simple it is a culture that loves people and makes a difference in their lives friendly friendly atmosphere where you want to come to work friendly helpful loving christ centered good good place work like the people healthy team work good culture that bring honor and glory to god great culture where everyone wants to help out and be apart of a team great family atmosphere great work environment happy happy happy honest and trustworthy very little drama i believe that a culture has been built where people are treated and embraced like family i have confidence that i can go to anyone at anytime and have a discussion ask a question or be vulnerable about my personal life i think of importance of family and god when i think of acr i would describe the acr culture as one of integrity from that well all the other characteristics of a great place to work flow i would describe the culture as helpful and fun it is a good place to work that allows people to excel in their life through their work and outside life balance there is a genuine care for employees well being not just at work but outside of work too its a second family its an awesome culture at acr would be better if everyone followed it it s refreshing and attractive among all the other culture s in our industry it s tight knit group of people who strive to make a difference in the marketplace and in the community living and working for a common goal to achieve success in business work and play to pay homage to god and give thanks for what we have loving and fun loving productive and professional ok one of family and friends one that values relationships with customers and team members alike open and caring our culture at work provides a road map for life our culture is positive forward thinking and we truly care about one another and the impact we have on each other s lives and each other s families people liking and respecting one another with the end goal to satisfy our customers professional unique kind smart trust refreshing rewarding personally and professionally spiritual take care of customer at all cost the acr culture is phenomenal i have never worked at a place like this before everyone seems to be very helpful family oriented and has a purpose for doing whats best for acr the culture at acr is amazing i love the fact that the companies principal includes to glorify god the culture at acr is one of serving customers first by working together and also by helping its employees to be better trained within their own fields the culture at acr supply is like we re all a family the culture has improved over the past few years the culture is not always applied the same the culture of this company is awesome everyone is loved and part of the team unique i treasure this place best job i ve ever had values beliefs attitudes and behaviors share each day at work visionary visionary leaders everywhere with a humble servant leadership mindset with a mission to fulfill god s purposes in our sphere s of influence while making a profit for the future see big while thinking small we are a family that loves cares for and prays for one another and our communities we care for each other '),(68,'field',47,1,' a culture of family '),(68,'slug',0,1,''),(69,'field',47,1,' a culture that truly does try to serve others over self '),(69,'slug',0,1,''),(70,'field',47,1,' a customer focused culture of respect open communication and resolving conflict in a healthy manor '),(70,'slug',0,1,''),(71,'field',47,1,' a great environment with positive attitudes '),(71,'slug',0,1,''),(72,'field',47,1,' acr is a customer focused company that cares deeply about its employees '),(72,'slug',0,1,''),(73,'field',47,1,' acr is a place that creates an environment where team members want to get up and come to work everyday if you have ever dreaded going to a job then you know why this is soooo important '),(73,'slug',0,1,''),(74,'field',47,1,' acr is family and it is a place where you do not have to worry about weather or not you will have a job the next day if something happens in your life becasue acr has your back no matter what '),(74,'slug',0,1,''),(75,'field',47,1,' acr s culture reflects our guiding principles '),(75,'slug',0,1,''),(76,'field',47,1,' amazing couldn t ask for a better family '),(76,'slug',0,1,''),(77,'field',47,1,' amazing culture '),(77,'slug',0,1,''),(78,'field',47,1,' awesome culture when people buy in team work '),(78,'slug',0,1,''),(79,'field',47,1,' awesome '),(79,'slug',0,1,''),(80,'field',47,1,' balance of team work and customer service with integrity '),(80,'slug',0,1,''),(81,'field',47,1,' big family '),(81,'slug',0,1,''),(82,'field',47,1,' caring about people passionate about solutions and to glorify god '),(82,'slug',0,1,''),(83,'field',47,1,' caring god based culture '),(83,'slug',0,1,''),(84,'field',47,1,' christ centered customer focused associate friendly '),(84,'slug',0,1,''),(85,'field',47,1,' close family '),(85,'slug',0,1,''),(86,'field',47,1,' customer focused '),(86,'slug',0,1,''),(87,'field',47,1,' customer driven '),(87,'slug',0,1,''),(88,'field',47,1,' effective diverse accepted encouraged '),(88,'slug',0,1,''),(89,'field',47,1,' it feels like a family all the staff are great to work with employee and customer based something on a level i haven t seen in previous jobs '),(89,'slug',0,1,''),(90,'field',47,1,' encouraging supportive and happy '),(90,'slug',0,1,''),(91,'field',47,1,' everybody acts like a big family and you can tell when we have meetings that everyone genuinely gets along '),(91,'slug',0,1,''),(92,'field',47,1,' everyone willing to help '),(92,'slug',0,1,''),(93,'field',47,1,' excellent culture it s awesome being at a workplace where everyone actually wants to be at work and genuinely cares about the big picture '),(93,'slug',0,1,''),(94,'field',47,1,' family '),(94,'slug',0,1,''),(95,'field',47,1,' family atmosphere everyone gets along great '),(95,'slug',0,1,''),(96,'field',47,1,' family business '),(96,'slug',0,1,''),(97,'field',47,1,' family oriented honest ethical '),(97,'slug',0,1,''),(98,'field',47,1,' family community '),(98,'slug',0,1,''),(99,'field',47,1,' for me it s simple it is a culture that loves people and makes a difference in their lives '),(99,'slug',0,1,''),(100,'field',47,1,' friendly '),(100,'slug',0,1,''),(101,'field',47,1,' friendly atmosphere where you want to come to work '),(101,'slug',0,1,''),(102,'field',47,1,' friendly helpful loving christ centered '),(102,'slug',0,1,''),(103,'field',47,1,' good '),(103,'slug',0,1,''),(104,'field',47,1,' good place work like the people healthy team work '),(104,'slug',0,1,''),(105,'field',47,1,' good culture that bring honor and glory to god '),(105,'slug',0,1,''),(106,'field',47,1,' great culture where everyone wants to help out and be apart of a team '),(106,'slug',0,1,''),(107,'field',47,1,' great family atmosphere '),(107,'slug',0,1,''),(108,'field',47,1,' great work environment '),(108,'slug',0,1,''),(109,'field',47,1,' happy happy happy '),(109,'slug',0,1,''),(110,'field',47,1,' honest and trustworthy very little drama '),(110,'slug',0,1,''),(111,'field',47,1,' i believe that a culture has been built where people are treated and embraced like family i have confidence that i can go to anyone at anytime and have a discussion ask a question or be vulnerable about my personal life '),(111,'slug',0,1,''),(112,'field',47,1,' i think of importance of family and god when i think of acr '),(112,'slug',0,1,''),(113,'field',47,1,' i would describe the acr culture as one of integrity from that well all the other characteristics of a great place to work flow '),(113,'slug',0,1,''),(114,'field',47,1,' i would describe the culture as helpful and fun '),(114,'slug',0,1,''),(115,'field',47,1,' it is a good place to work that allows people to excel in their life through their work and outside life balance there is a genuine care for employees well being not just at work but outside of work too '),(115,'slug',0,1,''),(116,'field',47,1,' its a second family '),(116,'slug',0,1,''),(117,'field',47,1,' its an awesome culture at acr would be better if everyone followed it '),(117,'slug',0,1,''),(118,'field',47,1,' it s refreshing and attractive among all the other culture s in our industry '),(118,'slug',0,1,''),(119,'field',47,1,' it s tight knit group of people who strive to make a difference in the marketplace and in the community '),(119,'slug',0,1,''),(120,'field',47,1,' living and working for a common goal to achieve success in business work and play to pay homage to god and give thanks for what we have '),(120,'slug',0,1,''),(121,'field',47,1,' loving and fun loving productive and professional '),(121,'slug',0,1,''),(122,'field',47,1,' ok '),(122,'slug',0,1,''),(123,'field',47,1,' one of family and friends '),(123,'slug',0,1,''),(124,'field',47,1,' one that values relationships with customers and team members alike '),(124,'slug',0,1,''),(125,'field',47,1,' open and caring '),(125,'slug',0,1,''),(126,'field',47,1,' our culture at work provides a road map for life '),(126,'slug',0,1,''),(127,'field',47,1,' our culture is positive forward thinking and we truly care about one another and the impact we have on each other s lives and each other s families '),(127,'slug',0,1,''),(128,'field',47,1,' people liking and respecting one another with the end goal to satisfy our customers '),(128,'slug',0,1,''),(129,'field',47,1,' professional unique kind smart trust '),(129,'slug',0,1,''),(130,'field',47,1,' refreshing '),(130,'slug',0,1,''),(131,'field',47,1,' rewarding personally and professionally '),(131,'slug',0,1,''),(132,'field',47,1,' spiritual '),(132,'slug',0,1,''),(133,'field',47,1,' take care of customer at all cost '),(133,'slug',0,1,''),(134,'field',47,1,' the acr culture is phenomenal i have never worked at a place like this before everyone seems to be very helpful family oriented and has a purpose for doing whats best for acr '),(134,'slug',0,1,''),(135,'field',47,1,' the culture at acr is amazing i love the fact that the companies principal includes to glorify god '),(135,'slug',0,1,''),(136,'field',47,1,' the culture at acr is one of serving customers first by working together and also by helping its employees to be better trained within their own fields '),(136,'slug',0,1,''),(137,'field',47,1,' the culture at acr supply is like we re all a family '),(137,'slug',0,1,''),(138,'field',47,1,' the culture has improved over the past few years '),(138,'slug',0,1,''),(139,'field',47,1,' the culture is not always applied the same '),(139,'slug',0,1,''),(140,'field',47,1,' the culture of this company is awesome everyone is loved and part of the team '),(140,'slug',0,1,''),(141,'field',47,1,' unique i treasure this place best job i ve ever had '),(141,'slug',0,1,''),(142,'field',47,1,' values beliefs attitudes and behaviors share each day at work '),(142,'slug',0,1,''),(143,'field',47,1,' visionary '),(143,'slug',0,1,''),(144,'field',47,1,' visionary leaders everywhere with a humble servant leadership mindset with a mission to fulfill god s purposes in our sphere s of influence while making a profit for the future see big while thinking small '),(144,'slug',0,1,''),(145,'field',47,1,' we are a family that loves cares for and prays for one another and our communities '),(145,'slug',0,1,''),(146,'field',47,1,' we care for each other '),(146,'slug',0,1,''),(147,'filename',0,1,' bcwi_certified_2018_clear e1533605047308 png '),(147,'extension',0,1,' png '),(147,'kind',0,1,' image '),(147,'slug',0,1,''),(147,'title',0,1,' bcwi_certified_2018_clear e1533605047308 '),(148,'slug',0,1,' vendors '),(148,'title',0,1,' vendors '),(148,'field',48,1,' electric motors fractional and integral horsepower http www centuryelectricmotor com a o smith a c and refrigeration components camstat controls https www acrsupply com vendors a1 components instruments for measuring volts amps ohms temperature http www amprobe com amprobe usen home amprobe pressure switches for gas and air http www antunescontrols com antunes conservation technologies http www rectorseal com index php products 4 aquaguard closed cell insulation for refrigerant lines http www armacell com armacell solenoid valves http www asco com asco combustion analyzers leak detectors and refrigerant recovery tools http www bacharach inc com bacharach thermostat cable ul plenum shielded extension cords http www colemancable com home baron wire direct mounted actuators and valves http www belimo com english index cfm belimo v belt drives and power transmission products http www emersonindustrial com en us powertransmissionsolutions pages home aspx browning belts thermometers digital bi metal liquid filled http www cooper atkins com cooper atkins hermetic and semi hermetic compressors for refrigeration and air conditioning http www emersonclimate com en us pages home aspx copeland heating parts http www crownboiler com crown boiler air conditioning accessories http www diversitech com diversitech refrigerant filters http www2 dupont com refrigerants en_us dupont refrigerants indoor air quality solutions http www dustfree com dust free magnehelic gages http www dwyer inst com dwyer programmable thermostats http www ecobee com ecobee electrical fuses http www cooperindustries com content public en bussmann html edison fusegear specialty chemicals http www federalprocess com federal process electrical test instruments http www fluke com fluke electronic devices http www functionaldevices com functional devices v belts http www gates com gates automatic flow control valves http www haysfluidcontrols com index html hays fluid refrigeration evaporators and condensing units http www heatcraftrpd com heatcraft refrigerant control valves http www henrytech com henry valve chemicals http www highsidechem com highside burner and boiler controls commercial building controls environmental controls hydronic controls pneumatic controls residential hvac controls perfect climate humidifiers air cleaners uv air treatment digital thermostats communicating thermostats equipment monitoring http www customer honeywell com honeywell tube working tools http imperial tools com imperial stride tools refrigerant leak detectors http www inficon com default aspx language=en us inficon soldering and brazing products http www harrisproductsgroup com j w harris vacuum pumps and charging accessories http www jbind com jb industries pneumatic controls refrigeration controls and leak detectors commercial air conditioning controls baso gas ignition products valves and actuators http cgproducts johnsoncontrols com default aspx topframe aspx 0 johnson controls advanced energy saving technology http www ke2therm com ke2 thermal hand tools http www kleintools com klein commercial and industrial air filtration products http www kochfilter com koch filter blower wheels and fan blades http www lauparts com lau saw blades http www lenoxtools com pages home aspx lenox condensate pumps http franklin electric com hvac aspx little giant hand tools for hvac trades http malcoproducts com malco motors armatures http www marsm a com mars copper tube and fitting for hvac r http www muellerindustries com mueller connectors http www nsiindustries com products electrical aspx nsi high efficiency boilers http www nythermal com trinity_ti nti coil cleaners and chemicals for the hvac r trades http www nucalgon com nucalgon brass fittings refrigeration control products http www parker com portal site parker menuitem b90576e27a4d71ae1bfcc510237ad1ca vgnextoid=c38888b5bd16e010vgnvcm1000000308a8c0rcrd vgnextfmt=default parker pressure sensitive tapes and adhesives http tapes berryplastics com polyken tape refrigeration temperature and pressure controls http www uni line com common ranco aspx ranco home weatherization products http www rcdmastics com rcd mastics chemicals for the hvac r trades http www rectorseal com rectorseal charging hoses and manifolds http www yellowjacket com ritchie energy management http www schneider electric com site home index cfm ww selectcountry=true schneider electric leaders in ice machine innovation http www scotsman ice com xhtml=xhtml sct us en homepage default html xsl=homepage xsl scotsman ice machines supco accessories for the hvac r trade http www supco com web supco_live sealed unit parts pneumatic controls http www nsiindustries com products electrical aspx siemens catch all driers solenoid valves thermostatic expansion valves refrigerant pressure regulators http www parker com portal site parker menuitem 223a4a3cce02eb6315731910237ad1ca vgnextoid=47f9724fe7a5e210vgnvcm10000048021dacrcrd vgnextfmt=en sporlan fuel oil pumps http www suntecpumps com suntec duct smoke detectors http www systemsensor com en us pages welcome aspx system sensor oil separators http www temprite com main_content asp pagename=home temprite electrical and temperature test instruments http www ueitest com uei ultraviolet disinfection systems and indoor air quality products http www ultravation com ultravation welding outfits and accessories http uniweld com uniweld self lighting torches http victortechnologies com victor turbo torch backflow preventer repair parts http www watts com watts thermometers and pressure gauges http www weissinstruments com weiss thermostats and gas controls http www emersonclimate com en us brands white_rodgers pages white_rodgers aspx white rogers '),(157,'slug',0,1,''),(157,'field',51,1,' http www rectorseal com index php products 4 '),(157,'field',50,1,' conservation technologies '),(157,'field',49,1,' aquaguard '),(153,'field',49,1,' a o smith '),(153,'field',50,1,' electric motors fractional and integral horsepower '),(153,'field',51,1,' http www centuryelectricmotor com '),(153,'slug',0,1,''),(154,'field',49,1,' a1 components '),(154,'field',50,1,' a c and refrigeration components camstat controls '),(154,'field',51,1,' https www acrsupply com vendors '),(154,'slug',0,1,''),(155,'field',49,1,' amprobe '),(155,'field',50,1,' instruments for measuring volts amps ohms temperature '),(155,'field',51,1,' http www amprobe com amprobe usen home '),(155,'slug',0,1,''),(156,'field',49,1,' antunes '),(156,'field',50,1,' pressure switches for gas and air '),(156,'field',51,1,' http www antunescontrols com '),(156,'slug',0,1,''),(158,'field',49,1,' armacell '),(158,'field',50,1,' closed cell insulation for refrigerant lines '),(158,'field',51,1,' http www armacell com '),(158,'slug',0,1,''),(159,'field',49,1,' asco '),(159,'field',50,1,' solenoid valves '),(159,'field',51,1,' http www asco com '),(159,'slug',0,1,''),(160,'field',49,1,' bacharach '),(160,'field',50,1,' combustion analyzers leak detectors and refrigerant recovery tools '),(160,'field',51,1,' http www bacharach inc com '),(160,'slug',0,1,''),(161,'field',49,1,' baron wire '),(161,'field',50,1,' thermostat cable ul plenum shielded extension cords '),(161,'field',51,1,' http www colemancable com home '),(161,'slug',0,1,''),(162,'field',49,1,' belimo '),(162,'field',50,1,' direct mounted actuators and valves '),(162,'field',51,1,' http www belimo com english index cfm '),(162,'slug',0,1,''),(163,'field',49,1,' browning belts '),(163,'field',50,1,' v belt drives and power transmission products '),(163,'field',51,1,' http www emersonindustrial com en us powertransmissionsolutions pages home aspx '),(163,'slug',0,1,''),(164,'field',49,1,' cooper atkins '),(164,'field',50,1,' thermometers digital bi metal liquid filled '),(164,'field',51,1,' http www cooper atkins com '),(164,'slug',0,1,''),(165,'field',49,1,' copeland '),(165,'field',50,1,' hermetic and semi hermetic compressors for refrigeration and air conditioning '),(165,'field',51,1,' http www emersonclimate com en us pages home aspx '),(165,'slug',0,1,''),(166,'field',49,1,' crown boiler '),(166,'field',50,1,' heating parts '),(166,'field',51,1,' http www crownboiler com '),(166,'slug',0,1,''),(167,'field',49,1,' diversitech '),(167,'field',50,1,' air conditioning accessories '),(167,'field',51,1,' http www diversitech com '),(167,'slug',0,1,''),(168,'field',49,1,' dupont refrigerants '),(168,'field',50,1,' refrigerant filters '),(168,'field',51,1,' http www2 dupont com refrigerants en_us '),(168,'slug',0,1,''),(169,'field',49,1,' dust free '),(169,'field',50,1,' indoor air quality solutions '),(169,'field',51,1,' http www dustfree com '),(169,'slug',0,1,''),(170,'field',49,1,' dwyer '),(170,'field',50,1,' magnehelic gages '),(170,'field',51,1,' http www dwyer inst com '),(170,'slug',0,1,''),(171,'field',49,1,' ecobee '),(171,'field',50,1,' programmable thermostats '),(171,'field',51,1,' http www ecobee com '),(171,'slug',0,1,''),(172,'field',49,1,' edison fusegear '),(172,'field',50,1,' electrical fuses '),(172,'field',51,1,' http www cooperindustries com content public en bussmann html '),(172,'slug',0,1,''),(173,'field',49,1,' federal process '),(173,'field',50,1,' specialty chemicals '),(173,'field',51,1,' http www federalprocess com '),(173,'slug',0,1,''),(174,'field',49,1,' fluke '),(174,'field',50,1,' electrical test instruments '),(174,'field',51,1,' http www fluke com '),(174,'slug',0,1,''),(175,'field',49,1,' functional devices '),(175,'field',50,1,' electronic devices '),(175,'field',51,1,' http www functionaldevices com '),(175,'slug',0,1,''),(176,'field',49,1,' gates '),(176,'field',50,1,' v belts '),(176,'field',51,1,' http www gates com '),(176,'slug',0,1,''),(177,'field',49,1,' hays fluid '),(177,'field',50,1,' automatic flow control valves '),(177,'field',51,1,' http www haysfluidcontrols com index html '),(177,'slug',0,1,''),(178,'field',49,1,' heatcraft '),(178,'field',50,1,' refrigeration evaporators and condensing units '),(178,'field',51,1,' http www heatcraftrpd com '),(178,'slug',0,1,''),(179,'field',49,1,' henry valve '),(179,'field',50,1,' refrigerant control valves '),(179,'field',51,1,' http www henrytech com '),(179,'slug',0,1,''),(180,'field',49,1,' highside '),(180,'field',50,1,' chemicals '),(180,'field',51,1,' http www highsidechem com '),(180,'slug',0,1,''),(181,'field',49,1,' honeywell '),(181,'field',50,1,' burner and boiler controls commercial building controls environmental controls hydronic controls pneumatic controls residential hvac controls perfect climate humidifiers air cleaners uv air treatment digital thermostats communicating thermostats equipment monitoring '),(181,'field',51,1,' http www customer honeywell com '),(181,'slug',0,1,''),(182,'field',49,1,' imperial stride tools '),(182,'field',50,1,' tube working tools '),(182,'field',51,1,' http imperial tools com '),(182,'slug',0,1,''),(183,'field',49,1,' inficon '),(183,'field',50,1,' refrigerant leak detectors '),(183,'field',51,1,' http www inficon com default aspx language=en us '),(183,'slug',0,1,''),(184,'field',49,1,' j w harris '),(184,'field',50,1,' soldering and brazing products '),(184,'field',51,1,' http www harrisproductsgroup com '),(184,'slug',0,1,''),(185,'field',49,1,' jb industries '),(185,'field',50,1,' vacuum pumps and charging accessories '),(185,'field',51,1,' http www jbind com '),(185,'slug',0,1,''),(186,'field',49,1,' johnson controls '),(186,'field',50,1,' pneumatic controls refrigeration controls and leak detectors commercial air conditioning controls baso gas ignition products valves and actuators '),(186,'field',51,1,' http cgproducts johnsoncontrols com default aspx topframe aspx 0 '),(186,'slug',0,1,''),(187,'field',49,1,' ke2 thermal '),(187,'field',50,1,' advanced energy saving technology '),(187,'field',51,1,' http www ke2therm com '),(187,'slug',0,1,''),(188,'field',49,1,' klein '),(188,'field',50,1,' hand tools '),(188,'field',51,1,' http www kleintools com '),(188,'slug',0,1,''),(189,'field',49,1,' koch filter '),(189,'field',50,1,' commercial and industrial air filtration products '),(189,'field',51,1,' http www kochfilter com '),(189,'slug',0,1,''),(190,'field',49,1,' lau '),(190,'field',50,1,' blower wheels and fan blades '),(190,'field',51,1,' http www lauparts com '),(190,'slug',0,1,''),(191,'field',49,1,' lenox '),(191,'field',50,1,' saw blades '),(191,'field',51,1,' http www lenoxtools com pages home aspx '),(191,'slug',0,1,''),(192,'field',49,1,' little giant '),(192,'field',50,1,' condensate pumps '),(192,'field',51,1,' http franklin electric com hvac aspx '),(192,'slug',0,1,''),(193,'field',49,1,' malco '),(193,'field',50,1,' hand tools for hvac trades '),(193,'field',51,1,' http malcoproducts com '),(193,'slug',0,1,''),(194,'field',49,1,' mars '),(194,'field',50,1,' motors armatures '),(194,'field',51,1,' http www marsm a com '),(194,'slug',0,1,''),(195,'field',49,1,' mueller '),(195,'field',50,1,' copper tube and fitting for hvac r '),(195,'field',51,1,' http www muellerindustries com '),(195,'slug',0,1,''),(196,'field',49,1,' nsi '),(196,'field',50,1,' connectors '),(196,'field',51,1,' http www nsiindustries com products electrical aspx '),(196,'slug',0,1,''),(197,'field',49,1,' nti '),(197,'field',50,1,' high efficiency boilers '),(197,'field',51,1,' http www nythermal com trinity_ti '),(197,'slug',0,1,''),(198,'field',49,1,' nucalgon '),(198,'field',50,1,' coil cleaners and chemicals for the hvac r trades '),(198,'field',51,1,' http www nucalgon com '),(198,'slug',0,1,''),(199,'field',49,1,' parker '),(199,'field',50,1,' brass fittings refrigeration control products '),(199,'field',51,1,' http www parker com portal site parker menuitem b90576e27a4d71ae1bfcc510237ad1ca vgnextoid=c38888b5bd16e010vgnvcm1000000308a8c0rcrd vgnextfmt=default '),(199,'slug',0,1,''),(200,'field',49,1,' polyken tape '),(200,'field',50,1,' pressure sensitive tapes and adhesives '),(200,'field',51,1,' http tapes berryplastics com '),(200,'slug',0,1,''),(201,'field',49,1,' ranco '),(201,'field',50,1,' refrigeration temperature and pressure controls '),(201,'field',51,1,' http www uni line com common ranco aspx '),(201,'slug',0,1,''),(202,'field',49,1,' rcd mastics '),(202,'field',50,1,' home weatherization products '),(202,'field',51,1,' http www rcdmastics com '),(202,'slug',0,1,''),(203,'field',49,1,' rectorseal '),(203,'field',50,1,' chemicals for the hvac r trades '),(203,'field',51,1,' http www rectorseal com '),(203,'slug',0,1,''),(204,'field',49,1,' ritchie '),(204,'field',50,1,' charging hoses and manifolds '),(204,'field',51,1,' http www yellowjacket com '),(204,'slug',0,1,''),(205,'field',49,1,' schneider electric '),(205,'field',50,1,' energy management '),(205,'field',51,1,' http www schneider electric com site home index cfm ww selectcountry=true '),(205,'slug',0,1,''),(206,'field',49,1,' scotsman ice machines '),(206,'field',50,1,' leaders in ice machine innovation '),(206,'field',51,1,' http www scotsman ice com xhtml=xhtml sct us en homepage default html xsl=homepage xsl '),(206,'slug',0,1,''),(207,'field',49,1,' sealed unit parts '),(207,'field',50,1,' supco accessories for the hvac r trade '),(207,'field',51,1,' http www supco com web supco_live '),(207,'slug',0,1,''),(208,'field',49,1,' siemens '),(208,'field',50,1,' pneumatic controls '),(208,'field',51,1,' http www nsiindustries com products electrical aspx '),(208,'slug',0,1,''),(209,'field',49,1,' sporlan '),(209,'field',50,1,' catch all driers solenoid valves thermostatic expansion valves refrigerant pressure regulators '),(209,'field',51,1,' http www parker com portal site parker menuitem 223a4a3cce02eb6315731910237ad1ca vgnextoid=47f9724fe7a5e210vgnvcm10000048021dacrcrd vgnextfmt=en '),(209,'slug',0,1,''),(210,'field',49,1,' suntec '),(210,'field',50,1,' fuel oil pumps '),(210,'field',51,1,' http www suntecpumps com '),(210,'slug',0,1,''),(211,'field',49,1,' system sensor '),(211,'field',50,1,' duct smoke detectors '),(211,'field',51,1,' http www systemsensor com en us pages welcome aspx '),(211,'slug',0,1,''),(212,'field',49,1,' temprite '),(212,'field',50,1,' oil separators '),(212,'field',51,1,' http www temprite com main_content asp pagename=home '),(212,'slug',0,1,''),(213,'field',49,1,' uei '),(213,'field',50,1,' electrical and temperature test instruments '),(213,'field',51,1,' http www ueitest com '),(213,'slug',0,1,''),(214,'field',49,1,' ultravation '),(214,'field',50,1,' ultraviolet disinfection systems and indoor air quality products '),(214,'field',51,1,' http www ultravation com '),(214,'slug',0,1,''),(215,'field',49,1,' uniweld '),(215,'field',50,1,' welding outfits and accessories '),(215,'field',51,1,' http uniweld com '),(215,'slug',0,1,''),(216,'field',49,1,' victor turbo torch '),(216,'field',50,1,' self lighting torches '),(216,'field',51,1,' http victortechnologies com '),(216,'slug',0,1,''),(217,'field',49,1,' watts '),(217,'field',50,1,' backflow preventer repair parts '),(217,'field',51,1,' http www watts com '),(217,'slug',0,1,''),(218,'field',49,1,' weiss '),(218,'field',50,1,' thermometers and pressure gauges '),(218,'field',51,1,' http www weissinstruments com '),(218,'slug',0,1,''),(219,'field',49,1,' white rogers '),(219,'field',50,1,' thermostats and gas controls '),(219,'field',51,1,' http www emersonclimate com en us brands white_rodgers pages white_rodgers aspx '),(219,'slug',0,1,''),(220,'id',0,1,' 220 '),(220,'title',0,1,' emerson copeland teardown class durham acr '),(220,'startdate',0,1,' 2019 03 26 17 30 00 '),(220,'enddate',0,1,' 2019 03 26 19 30 00 '),(220,'slug',0,1,' emerson copeland teardown class durham acr '),(221,'id',0,1,' 221 '),(221,'title',0,1,' emerson copeland teardown class raleigh acr '),(221,'startdate',0,1,' 2019 03 27 17 30 00 '),(221,'enddate',0,1,' 2019 03 27 19 30 00 '),(221,'slug',0,1,' emerson copeland teardown class raleigh acr '),(222,'id',0,1,' 222 '),(222,'title',0,1,' 2019 acr hvac refrigeration expo '),(222,'startdate',0,1,' 2019 04 03 09 00 00 '),(222,'enddate',0,1,' 2019 04 03 15 30 00 '),(222,'slug',0,1,' 2019 acr hvac refrigeration expo '),(220,'field',52,1,''),(221,'field',52,1,''),(222,'field',52,1,' registration test form '),(220,'field',53,1,' lat lng location placeid locationdata '),(221,'field',53,1,' lat lng location placeid locationdata '),(222,'field',54,1,' this is the calendar event description it can be added or left blank but it will be a great place to add some information about the event that will be beneficial to site visitors '),(220,'field',55,1,''),(228,'slug',0,1,''),(229,'field',60,1,' lindsey smith '),(229,'slug',0,1,''),(230,'field',60,1,' john richardson '),(230,'slug',0,1,''),(231,'field',60,1,' john cappello '),(231,'slug',0,1,''),(232,'field',60,1,' anthony cappello '),(232,'slug',0,1,''),(233,'field',60,1,' scottie garner '),(233,'slug',0,1,''),(234,'field',60,1,' brittany barbour '),(234,'slug',0,1,''),(235,'field',60,1,' lindsey cook '),(235,'slug',0,1,''),(236,'field',60,1,' kevin buckman '),(222,'field',53,1,' 4040 s alston ave durham nc '),(220,'field',54,1,''),(221,'field',54,1,''),(221,'field',55,1,''),(222,'field',55,1,' 20 00 '),(223,'slug',0,1,' john smith '),(223,'title',0,1,' john smith '),(56,'field',56,1,''),(224,'field',56,1,' lexie smith lindsey smith john richardson john cappello anthony cappello scottie garner brittany barbour lindsey cook kevin buckman brian buckman '),(225,'field',60,1,' lexie smith '),(225,'slug',0,1,''),(224,'slug',0,1,' 2009 2010 '),(224,'title',0,1,' 2009 2010 school year '),(226,'field',56,1,' lindsey cook john richardson lindsey smith anthony cappello john cappello '),(227,'field',60,1,' lindsey cook '),(227,'slug',0,1,''),(226,'slug',0,1,' 2010 2011 '),(226,'title',0,1,' 2010 2011 school year '),(228,'field',60,1,' john richardson '),(236,'slug',0,1,''),(237,'field',60,1,' brian buckman '),(237,'slug',0,1,''),(238,'field',60,1,' lindsey smith '),(238,'slug',0,1,''),(239,'field',60,1,' anthony cappello '),(239,'slug',0,1,''),(240,'field',60,1,' john cappello '),(240,'slug',0,1,''),(241,'field',56,1,' thomas aiken bryan richardson john richardson john cappello anthony cappello lindsey smith '),(242,'field',60,1,' thomas aiken '),(242,'slug',0,1,''),(243,'field',60,1,' bryan richardson '),(243,'slug',0,1,''),(244,'field',60,1,' john richardson '),(244,'slug',0,1,''),(245,'field',60,1,' john cappello '),(245,'slug',0,1,''),(246,'field',60,1,' anthony cappello '),(246,'slug',0,1,''),(247,'field',60,1,' lindsey smith '),(247,'slug',0,1,''),(241,'slug',0,1,' 2011 2012 school year '),(241,'title',0,1,' 2011 2012 school year '),(248,'field',56,1,' thomas aiken john cappello john richardson bryan richardson nicholas cicero aaron cook allison cook '),(249,'field',60,1,' thomas aiken '),(249,'slug',0,1,''),(250,'field',60,1,' john cappello '),(250,'slug',0,1,''),(251,'field',60,1,' john richardson '),(251,'slug',0,1,''),(252,'field',60,1,' bryan richardson '),(252,'slug',0,1,''),(253,'field',60,1,' nicholas cicero '),(253,'slug',0,1,''),(254,'field',60,1,' aaron cook '),(254,'slug',0,1,''),(255,'field',60,1,' allison cook '),(255,'slug',0,1,''),(248,'slug',0,1,' 2012 2013 school year '),(248,'title',0,1,' 2012 2013 school year '),(256,'field',56,1,' thomas aiken aaron cook allison cook bryan richardson allie smith '),(257,'field',60,1,' thomas aiken '),(257,'slug',0,1,''),(258,'field',60,1,' aaron cook '),(258,'slug',0,1,''),(259,'field',60,1,' allison cook '),(259,'slug',0,1,''),(260,'field',60,1,' bryan richardson '),(260,'slug',0,1,''),(261,'field',60,1,' allie smith '),(261,'slug',0,1,''),(256,'slug',0,1,' 2013 2014 school year '),(256,'title',0,1,' 2013 2014 school year '),(262,'field',56,1,' thomas aiken hayden brumley matthew cappello aaron cook allison cook allie smith caleb smith madison smith '),(263,'field',60,1,' thomas aiken '),(263,'slug',0,1,''),(264,'field',60,1,' hayden brumley '),(264,'slug',0,1,''),(265,'field',60,1,' matthew cappello '),(265,'slug',0,1,''),(266,'field',60,1,' aaron cook '),(266,'slug',0,1,''),(267,'field',60,1,' allison cook '),(267,'slug',0,1,''),(268,'field',60,1,' allie smith '),(268,'slug',0,1,''),(269,'field',60,1,' caleb smith '),(269,'slug',0,1,''),(270,'field',60,1,' madison smith '),(270,'slug',0,1,''),(262,'slug',0,1,' 2014 2015 school year '),(262,'title',0,1,' 2014 2015 school year '),(271,'field',56,1,' matthew cappello aaron cook allison cook hannah gardner alyssa hayes megan shepherd madison smith christopher terreault '),(272,'field',60,1,' matthew cappello '),(272,'slug',0,1,''),(273,'field',60,1,' aaron cook '),(273,'slug',0,1,''),(274,'field',60,1,' allison cook '),(274,'slug',0,1,''),(275,'field',60,1,' hannah gardner '),(275,'slug',0,1,''),(276,'field',60,1,' alyssa hayes '),(276,'slug',0,1,''),(277,'field',60,1,' megan shepherd '),(277,'slug',0,1,''),(278,'field',60,1,' madison smith '),(278,'slug',0,1,''),(279,'field',60,1,' christopher terreault '),(279,'slug',0,1,''),(271,'slug',0,1,' 2015 2016 school year '),(271,'title',0,1,' 2015 2016 school year '),(280,'field',56,1,' cassandra cappello meghan dempsey hannah gardner megan shepherd allie smith madison smith andrew terreault christopher terreault '),(281,'field',60,1,' cassandra cappello '),(281,'slug',0,1,''),(282,'field',60,1,' meghan dempsey '),(282,'slug',0,1,''),(283,'field',60,1,' hannah gardner '),(283,'slug',0,1,''),(284,'field',60,1,' megan shepherd '),(284,'slug',0,1,''),(285,'field',60,1,' allie smith '),(285,'slug',0,1,''),(286,'field',60,1,' madison smith '),(286,'slug',0,1,''),(287,'field',60,1,' andrew terreault '),(287,'slug',0,1,''),(288,'field',60,1,' christopher terreault '),(288,'slug',0,1,''),(280,'slug',0,1,' 2016 2017 school year '),(280,'title',0,1,' 2016 2017 school year '),(289,'field',56,1,' cassandra cappello matthew cappello meghan dempsey hannah gardner bailey mccann megan shepherd madison smith christopher terreault '),(290,'field',60,1,' cassandra cappello '),(290,'slug',0,1,''),(291,'field',60,1,' matthew cappello '),(291,'slug',0,1,''),(292,'field',60,1,' meghan dempsey '),(292,'slug',0,1,''),(293,'field',60,1,' hannah gardner '),(293,'slug',0,1,''),(294,'field',60,1,' bailey mccann '),(294,'slug',0,1,''),(295,'field',60,1,' megan shepherd '),(295,'slug',0,1,''),(296,'field',60,1,' madison smith '),(296,'slug',0,1,''),(297,'field',60,1,' christopher terreault '),(297,'slug',0,1,''),(289,'slug',0,1,' 2017 2018 school year '),(289,'title',0,1,' 2017 2018 school year '),(298,'field',56,1,' cassandra cappello matthew cappello meghan dempsey hannah gardner megan shepherd christopher terreault dylan thompson robert ursery '),(299,'field',60,1,' cassandra cappello '),(299,'slug',0,1,''),(300,'field',60,1,' matthew cappello '),(300,'slug',0,1,''),(301,'field',60,1,' meghan dempsey '),(301,'slug',0,1,''),(302,'field',60,1,' hannah gardner '),(302,'slug',0,1,''),(303,'field',60,1,' megan shepherd '),(303,'slug',0,1,''),(304,'field',60,1,' christopher terreault '),(304,'slug',0,1,''),(305,'field',60,1,' dylan thompson '),(305,'slug',0,1,''),(306,'field',60,1,' robert ursery '),(306,'slug',0,1,''),(298,'slug',0,1,' 2018 2019 school year '),(298,'title',0,1,' 2018 2019 school year '),(307,'field',56,1,' anna brumley sophia brzezinski ethan butler cassandra cappello meghan dempsey micaela dempsey chandler gardner robert ursery '),(308,'field',60,1,' anna brumley '),(308,'slug',0,1,''),(309,'field',60,1,' sophia brzezinski '),(309,'slug',0,1,''),(310,'field',60,1,' ethan butler '),(310,'slug',0,1,''),(311,'field',60,1,' cassandra cappello '),(311,'slug',0,1,''),(312,'field',60,1,' meghan dempsey '),(312,'slug',0,1,''),(313,'field',60,1,' micaela dempsey '),(313,'slug',0,1,''),(314,'field',60,1,' chandler gardner '),(314,'slug',0,1,''),(315,'field',60,1,' robert ursery '),(315,'slug',0,1,''),(307,'slug',0,1,' 2019 2020 school year '),(307,'title',0,1,' 2019 2020 school year ');
/*!40000 ALTER TABLE `acr_searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sections`
--

LOCK TABLES `acr_sections` WRITE;
/*!40000 ALTER TABLE `acr_sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_sections` VALUES (2,NULL,'About','about','single',1,1,'2018-10-08 23:53:17','2019-02-05 02:34:16',NULL,'fc6457f4-0483-4d21-a704-9f47893b5ada'),(3,NULL,'Promotions','promotions','channel',1,1,'2018-10-09 00:13:24','2019-01-27 18:17:45',NULL,'deefb807-a3f2-4b77-9b48-aa6bd8864f7f'),(4,NULL,'Home','home','single',1,1,'2018-10-10 23:42:21','2018-10-10 23:42:21',NULL,'148a408c-a3e0-469e-aa18-46200336c446'),(5,NULL,'Notifications','notifications','channel',1,1,'2018-11-02 01:16:09','2019-02-09 21:36:20',NULL,'c3c14b51-1050-404a-b79d-ac586030e8a4'),(6,NULL,'Testimonials','testimonials','channel',1,1,'2018-12-17 01:13:58','2018-12-17 01:13:58',NULL,'33cd06cd-ae75-4b06-ae73-5ab87ecf2963'),(8,NULL,'Locations','locations','single',1,1,'2019-01-02 01:08:25','2019-01-02 01:15:39',NULL,'b19546f5-4ea4-4336-8cd0-1623e4279468'),(9,NULL,'ACR Cares','acrCares','single',1,1,'2019-01-23 02:23:36','2019-01-23 03:04:05',NULL,'8b99fb28-9536-4c55-8adc-cff3e561baff'),(10,NULL,'Contact','contact','single',1,1,'2019-01-24 01:56:00','2019-01-24 01:56:00',NULL,'720bf92c-3db9-49d3-8814-2a047cb85e8c'),(11,NULL,'Request E-Store Account','eStore','single',1,1,'2019-01-24 02:30:36','2019-01-24 02:30:42',NULL,'6fbf9061-9641-4350-9e34-a974e674a2e9'),(12,NULL,'E-Store Credit Application','eStoreCreditApplication','single',1,1,'2019-01-24 02:35:59','2019-01-24 02:36:46',NULL,'4d4a42c3-dac6-4331-8d12-fe4460f697d1'),(13,NULL,'Pay Online','payOnline','single',1,1,'2019-01-24 03:20:09','2019-01-24 03:20:09',NULL,'f7d15cfa-53c3-4526-ab2d-84124c9f1d2f'),(14,NULL,'Training and Education','trainingAndEducation','single',1,1,'2019-01-25 02:16:36','2019-01-25 02:16:36',NULL,'ab2deffb-873a-4836-82c1-42b602c2b02f'),(15,NULL,'Scholarships','scholarships','single',1,1,'2019-01-25 02:27:28','2019-05-11 14:33:40',NULL,'b94ea8c9-c5ce-4409-b4d6-1bce2ead4787'),(16,NULL,'Careers','careers','single',1,1,'2019-01-25 02:29:08','2019-01-25 02:29:08',NULL,'b766f97e-4a11-4234-b7a0-86790e70977e'),(17,NULL,'Associates','associates','single',1,1,'2019-01-25 02:30:45','2019-01-25 02:30:45',NULL,'2ab94a27-43de-4c5d-99b7-f5a5667c2fde'),(18,NULL,'The Story','theStory','single',1,1,'2019-01-25 02:32:27','2019-01-25 02:33:02','2019-01-25 02:33:03','0a19efa6-f797-42d1-8bf5-91ad001d82d1'),(19,1,'Pages','pages','structure',1,1,'2019-01-25 02:42:26','2019-01-25 02:42:26',NULL,'aa8de52f-f0b3-4669-b39b-86de1ea3266e'),(20,NULL,'Vendors','vendors','single',1,1,'2019-02-10 01:28:33','2019-02-10 01:30:11',NULL,'f698d717-24dd-43e6-b94e-68128fd55f6c'),(21,NULL,'Scholarship Recipients','scholarshipRecipients','channel',1,1,'2019-05-11 14:24:15','2019-05-11 14:34:20','2019-05-11 14:34:21','d91175ae-93dd-4aef-a9c3-359d50958e76'),(22,NULL,'Scholarship Years & Recipients','scholarshipYearsRecipients','channel',1,1,'2019-05-11 14:34:47','2019-05-11 14:35:41',NULL,'39adccaf-5f1e-48ec-834d-5ccfe0d3c1a4');
/*!40000 ALTER TABLE `acr_sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sections_sites`
--

LOCK TABLES `acr_sections_sites` WRITE;
/*!40000 ALTER TABLE `acr_sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_sections_sites` VALUES (2,2,1,1,'about','about',1,'2018-10-08 23:53:17','2019-02-05 02:34:16','b47b32ca-4983-4635-85fa-1559b2f4f920'),(3,3,1,1,'promotions/{slug}','promotions/_entry',1,'2018-10-09 00:13:24','2019-01-27 18:17:45','19ff82bf-0c81-439b-b0d2-9edd4b5347f4'),(4,4,1,1,'__home__','index.html',1,'2018-10-10 23:42:21','2018-10-10 23:42:21','4654d8c5-8c4a-4483-95ed-803d3182879e'),(5,5,1,1,'notifications/{slug}','notifications/_entry',1,'2018-11-02 01:16:09','2019-02-09 21:36:20','2307ac2f-c736-4975-8a89-7633ae89cb75'),(6,6,1,1,'testimonials/{slug}','testimonials/_entry',1,'2018-12-17 01:13:58','2018-12-17 01:13:58','b2af5ba5-555c-41c9-86d0-dafa354fb92f'),(8,8,1,1,'locations','locations',1,'2019-01-02 01:08:25','2019-01-02 01:15:39','5c116521-9aee-4b75-8d1b-a7f5afb76e28'),(9,9,1,1,'acr-cares','acrCares',1,'2019-01-23 02:23:36','2019-01-23 03:04:05','8fc48536-b51f-407c-89a7-cd47e94443f8'),(10,10,1,1,'contact','contact',1,'2019-01-24 01:56:00','2019-01-24 01:56:00','374c4515-7b6c-41df-91a5-cc4edae935a0'),(11,11,1,1,'request-e-store-account','eStore',1,'2019-01-24 02:30:36','2019-01-24 02:30:42','32c6fc97-ba06-40e4-9714-aa5f6972761a'),(12,12,1,1,'estore-credit-application','eStoreCredit',1,'2019-01-24 02:35:59','2019-01-24 02:36:46','7e8a877c-348f-499e-ab56-7d0c56bbbe19'),(13,13,1,1,'pay-online','payOnline',1,'2019-01-24 03:20:09','2019-01-24 03:20:09','ed0c65c5-6874-450f-9a4f-51e192d7f043'),(14,14,1,1,'training-and-education','trainingAndEducation',1,'2019-01-25 02:16:36','2019-01-25 02:16:36','1d191efa-60d1-4689-ac79-543e871836a8'),(15,15,1,1,'scholarships','scholarships',1,'2019-01-25 02:27:28','2019-05-11 14:33:40','54ff4f3e-81f6-4fbb-bec2-6d7b4cc9b290'),(16,16,1,1,'careers','careers',1,'2019-01-25 02:29:08','2019-01-25 02:29:08','3551f61d-f4f1-4144-af0f-6cba4cb2ff3a'),(17,17,1,1,'associates','associates',1,'2019-01-25 02:30:45','2019-01-25 02:30:45','075d9556-9fee-479b-82cd-0e276ff36089'),(18,18,1,1,'the-story','theStory',1,'2019-01-25 02:32:27','2019-01-25 02:33:02','997b5d12-bc80-4a18-9771-271844e3b7b7'),(19,19,1,1,'pages/{slug}','',1,'2019-01-25 02:42:26','2019-01-25 02:42:26','53ad489a-08f6-4b90-9115-6f0e606bb971'),(20,20,1,1,'vendors','vendors',1,'2019-02-10 01:28:33','2019-02-10 01:30:11','3bee462f-b0ef-42c4-b92f-eb8fa87d7c91'),(21,21,1,1,'scholarships/{slug}','',1,'2019-05-11 14:24:16','2019-05-11 14:34:20','1fc53d88-c4f6-478c-9f5d-df6b31de26d5'),(22,22,1,1,'scholarship-years-recipients/{slug}','',1,'2019-05-11 14:34:47','2019-05-11 14:35:41','7c1cef18-75ce-4e6c-9572-0188b03cd9ff');
/*!40000 ALTER TABLE `acr_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sequences`
--

LOCK TABLES `acr_sequences` WRITE;
/*!40000 ALTER TABLE `acr_sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_shunnedmessages`
--

LOCK TABLES `acr_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `acr_shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sitegroups`
--

LOCK TABLES `acr_sitegroups` WRITE;
/*!40000 ALTER TABLE `acr_sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_sitegroups` VALUES (1,'ACR Supply Co.','2018-09-30 15:22:58','2018-09-30 15:22:58',NULL,'29730c2c-25c9-4557-aa1a-247b9f593b50');
/*!40000 ALTER TABLE `acr_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sites`
--

LOCK TABLES `acr_sites` WRITE;
/*!40000 ALTER TABLE `acr_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_sites` VALUES (1,1,1,'ACR Supply Co.','default','en-US',1,'@web/',1,'2018-09-30 15:22:58','2018-09-30 15:22:58',NULL,'d84c7a06-9ecd-42c4-b65c-ec087c3bba35');
/*!40000 ALTER TABLE `acr_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_structureelements`
--

LOCK TABLES `acr_structureelements` WRITE;
/*!40000 ALTER TABLE `acr_structureelements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_structureelements` VALUES (1,1,NULL,1,1,4,0,'2019-01-25 02:42:54','2019-01-25 02:42:54','2680da11-f24d-42c4-bf0c-c31ac4d351a1'),(2,1,60,1,2,3,1,'2019-01-25 02:42:54','2019-01-25 02:42:54','f690c503-57db-40bd-bf39-4a531867259e');
/*!40000 ALTER TABLE `acr_structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_structures`
--

LOCK TABLES `acr_structures` WRITE;
/*!40000 ALTER TABLE `acr_structures` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_structures` VALUES (1,2,'2019-01-25 02:42:26','2019-01-25 02:42:26',NULL,'f07ef9da-1139-41e6-b5a3-e61c6fef2735');
/*!40000 ALTER TABLE `acr_structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_systemmessages`
--

LOCK TABLES `acr_systemmessages` WRITE;
/*!40000 ALTER TABLE `acr_systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_taggroups`
--

LOCK TABLES `acr_taggroups` WRITE;
/*!40000 ALTER TABLE `acr_taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_tags`
--

LOCK TABLES `acr_tags` WRITE;
/*!40000 ALTER TABLE `acr_tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_tokens`
--

LOCK TABLES `acr_tokens` WRITE;
/*!40000 ALTER TABLE `acr_tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_usergroups`
--

LOCK TABLES `acr_usergroups` WRITE;
/*!40000 ALTER TABLE `acr_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_usergroups_users`
--

LOCK TABLES `acr_usergroups_users` WRITE;
/*!40000 ALTER TABLE `acr_usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_userpermissions`
--

LOCK TABLES `acr_userpermissions` WRITE;
/*!40000 ALTER TABLE `acr_userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_userpermissions_usergroups`
--

LOCK TABLES `acr_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `acr_userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_userpermissions_users`
--

LOCK TABLES `acr_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `acr_userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_userpreferences`
--

LOCK TABLES `acr_userpreferences` WRITE;
/*!40000 ALTER TABLE `acr_userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `acr_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_users`
--

LOCK TABLES `acr_users` WRITE;
/*!40000 ALTER TABLE `acr_users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_users` VALUES (1,'wesley.cole87',NULL,NULL,NULL,'wesley.cole87@gmail.com','$2y$13$oSmne8Jb48zankPcc5vY5.XUllCrQATUwlDHDP4n0Oz4LSv47O20O',1,0,0,0,'2019-05-11 14:03:12','127.0.0.1',NULL,NULL,'2019-05-11 14:03:07',NULL,1,NULL,NULL,NULL,0,'2018-09-30 15:22:58','2018-09-30 15:22:58','2019-05-11 14:03:12','ab56c1b9-afab-4353-af4a-756bfd9a4be6');
/*!40000 ALTER TABLE `acr_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_volumefolders`
--

LOCK TABLES `acr_volumefolders` WRITE;
/*!40000 ALTER TABLE `acr_volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_volumefolders` VALUES (1,NULL,1,'Global','','2018-10-08 23:46:31','2019-01-27 18:19:02','c2be7942-3ed0-43dd-a51d-6c73ca7578d8'),(2,NULL,NULL,'Temporary source',NULL,'2018-10-08 23:48:16','2018-10-08 23:48:16','9f331564-85f8-411c-bd41-5cb6a06c1962'),(3,2,NULL,'user_1','user_1/','2018-10-08 23:48:16','2018-10-08 23:48:16','7e01e8e5-e27a-4c76-9ec5-d6aa48c4d141'),(4,1,1,'promotions','promotions/','2019-01-27 17:55:11','2019-01-27 17:55:11','c94e5aa2-e177-4c04-9345-4a9c8be0a762'),(5,NULL,2,'Promotions','','2019-01-27 18:00:26','2019-01-27 18:14:46','53166208-b48c-425c-93b7-be0b028465b9');
/*!40000 ALTER TABLE `acr_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_volumes`
--

LOCK TABLES `acr_volumes` WRITE;
/*!40000 ALTER TABLE `acr_volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_volumes` VALUES (1,NULL,'Global','global','craft\\volumes\\Local',1,'/assets/images','{\"path\":\"@webroot/assets/images\"}',1,'2018-10-08 23:46:31','2019-01-27 18:19:02',NULL,'0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e'),(2,NULL,'Promotions','promotions','craft\\volumes\\Local',1,'/assets/images/promotions','{\"path\":\"@webroot/assets/images/promotions\"}',NULL,'2019-01-27 18:00:26','2019-01-27 18:14:46',NULL,'98af559e-fbd3-426a-aada-0f8e6fe41d61');
/*!40000 ALTER TABLE `acr_volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_widgets`
--

LOCK TABLES `acr_widgets` WRITE;
/*!40000 ALTER TABLE `acr_widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,1,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2018-09-30 15:28:39','2019-01-21 19:03:57','083d8e33-d7df-4971-af10-f319331009c4'),(2,1,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2018-09-30 15:28:39','2018-09-30 15:28:39','e2d37842-427e-4b32-8c35-b361ed34c22e'),(3,1,'craft\\widgets\\Updates',3,0,'[]',1,'2018-09-30 15:28:39','2018-09-30 15:28:39','a071838b-d690-48b4-872b-a6d89223f490'),(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2018-09-30 15:28:39','2018-09-30 15:28:39','f5fe35aa-5dce-47f4-ad27-ec7fda44b418');
/*!40000 ALTER TABLE `acr_widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assetindexdata`
--

LOCK TABLES `assetindexdata` WRITE;
/*!40000 ALTER TABLE `assetindexdata` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransformindex`
--

LOCK TABLES `assettransformindex` WRITE;
/*!40000 ALTER TABLE `assettransformindex` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2019-01-31 03:24:53','2019-01-31 03:24:53','ee6d4fb9-8030-489b-bde7-faab2d368f15');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2019-01-31 03:24:53','2019-01-31 03:24:53',NULL,'09abbc1d-6b07-4ffb-9486-5bb617ad1ed1');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-01-31 03:24:53','2019-01-31 03:24:53','5fd2953b-fd69-45fe-8216-9e425ebf38b0');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrydrafts`
--

LOCK TABLES `entrydrafts` WRITE;
/*!40000 ALTER TABLE `entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entryversions`
--

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2019-01-31 03:24:53','2019-01-31 03:24:53','e42446b9-607a-4638-9ae1-4a5f72304b97');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.1.6.1','3.1.23',0,'a:0:{}','[]','qroPLUYujCis','2019-01-31 03:24:53','2019-01-31 03:24:53','bb291948-39b0-416b-8490-6a91b076924a');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','a2162668-6cc2-44bc-b9a6-aefc02b4a81a'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','a3be0d3b-adb2-4be8-9728-416e9ca3420d'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','05c08288-36ad-429a-b5b2-e8f754a20c7a'),(4,NULL,'app','m150403_184533_field_version','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','100c25d6-4d09-4594-bb09-d8697df8fc7b'),(5,NULL,'app','m150403_184729_type_columns','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','da0c89f3-84f4-4922-b7d4-c2fe7c6346e9'),(6,NULL,'app','m150403_185142_volumes','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','62b695b7-9c14-4c23-b04c-3f775662389b'),(7,NULL,'app','m150428_231346_userpreferences','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','f52e8408-0984-49dd-b796-1606617067cc'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','95a36e54-ff76-42e4-b481-306ba4be74e8'),(9,NULL,'app','m150617_213829_update_email_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','da1c3e9d-4c37-42e4-b480-f4abfade4db4'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','9389fe74-ed2a-4135-ae9b-d2cd87bcd0d3'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','6b3111c6-1480-4122-ab9e-09ec532d5788'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','ffa14afc-6bdc-49d4-aa83-0b3cafe3f7e3'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','3deebbb8-7c8e-48b5-ac6b-60deaab48eee'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','d4d83ee3-af0f-41fd-b1f9-7b3861be1fab'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','fe79a982-e4dd-47a2-8b8a-1cc063dfd12e'),(16,NULL,'app','m151209_000000_move_logo','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','f49eba97-f77e-41af-b301-fabb0222d380'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','fd5ed506-2303-42b3-b1db-77cf7b5c7644'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','a88822b7-469a-416d-8803-24260d431ec2'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','e1893a52-08cb-44d0-8dd3-2e421dddd9cb'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','196d12be-5c28-4b54-b05b-d4b9ed40bb7d'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','2edc3b95-6615-405c-a8cf-a4743b4da2e2'),(22,NULL,'app','m160727_194637_column_cleanup','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','2e817fc7-2442-4fd1-be87-5c08ce195f5a'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','097d69a9-f618-4033-9b09-6f6ea6b56d99'),(24,NULL,'app','m160807_144858_sites','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','e579dc6f-8cb5-4ac0-9bb5-0dd145dffdb5'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','10d1ed70-c043-4113-9c09-09978b76b851'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','f80e0c3d-d4fc-4f35-9a14-8c334b5869e5'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','bc4fd061-b970-4371-829c-53e729c28547'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','bb5d6bad-4986-4acc-b888-411a8ac01b19'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','25aac3f5-030c-4262-adf5-1f8dc50b8c0a'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','18b6c8b1-68ad-4044-ae87-27b8666b1058'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','facf5936-c7f4-4533-ad7a-b6efb458874e'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','fb77098e-cd89-4c05-81eb-6e80593c9906'),(33,NULL,'app','m161007_130653_update_email_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','c1a7057b-7988-4eb7-a0dd-f534c710a5f1'),(34,NULL,'app','m161013_175052_newParentId','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','edf73a36-7bb1-4b3b-810c-d82933504b4f'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','5c83d67a-3448-47a7-99ec-191ae65ec56d'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','9650d8b4-8e33-4994-8a9e-24b0c9da5117'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','0e058d95-8883-4dbb-a973-b02e80696f6d'),(38,NULL,'app','m161029_124145_email_message_languages','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','f1de4ee9-0714-442f-9bb3-4af7d41b3e7e'),(39,NULL,'app','m161108_000000_new_version_format','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','fff6c296-f6d6-4453-accd-c0165c7bf345'),(40,NULL,'app','m161109_000000_index_shuffle','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','a5158cba-fac3-45a1-9276-3f9ad61345c0'),(41,NULL,'app','m161122_185500_no_craft_app','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','e6fee46a-3728-45ab-b519-aa80ffe65697'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','e1322f93-4225-4e9a-9fce-1426db8c7a25'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','9a7cdca8-ad75-48cc-a494-21bc7a663b09'),(44,NULL,'app','m170114_161144_udates_permission','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','afbf8ecf-3cbb-4b3c-9f62-c6ac51e4e014'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','260a1fd0-16f7-4b1e-97a0-36d3c4f1a138'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','cead3831-c36c-4045-a989-4a30834e6574'),(47,NULL,'app','m170206_142126_system_name','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','31d0862c-704d-40c5-9183-897619b205e0'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','fae760b0-243e-47a0-b794-b88dc424633e'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','dd98eef9-41a0-49f0-9719-d238f35dfcf2'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','0109c4df-0400-4530-977c-7795e3e0a75b'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','b9074070-3fb6-468d-ba94-e427447a977a'),(52,NULL,'app','m170228_171113_system_messages','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','7620a309-8bb2-49b9-9d88-961786fa6828'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','5ce1c37b-2be5-49eb-8e76-319fcbb0558a'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','792d43ab-98aa-459d-8a3e-0c7c67a4aeab'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','dc8da18c-d853-4f98-85fb-237edfa04c38'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','b10c5d15-8ba3-4bd7-b70a-74659c9e3113'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','5f8883ba-6305-47fe-8877-dcb73be25190'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','35e40e91-f9bf-4d8f-8250-6ca275b7b5d8'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','46fde486-0f2c-40c5-8fbe-d80cad53743e'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','cd90e9d2-feaa-4914-b6fd-29a0823b1764'),(61,NULL,'app','m170704_134916_sites_tables','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','704648f3-4be9-4be5-a17b-e137c20c386d'),(62,NULL,'app','m170706_183216_rename_sequences','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','4a3bc42b-6f63-4697-b054-91656e0d44b2'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','fd30169b-4da7-47bb-a754-6f2124d808e1'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','efd7afc5-c9f2-46a5-9691-101dd963ed2a'),(65,NULL,'app','m170810_201318_create_queue_table','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','7d68cfa6-6509-406e-bf51-e0b2ba1fe053'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','bc6df7e0-0cfe-42ac-af5c-ac9cfe5d1e24'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','f8f3942a-032e-4ec9-ada4-f4543287314f'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','e7576312-443d-454e-bab7-0b6f42784702'),(69,NULL,'app','m171011_214115_site_groups','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','5b5dbbff-1e3d-4b52-b8a2-91909efeb686'),(70,NULL,'app','m171012_151440_primary_site','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','9109b29c-b6a8-4991-950c-a1c9986ed79c'),(71,NULL,'app','m171013_142500_transform_interlace','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','92b455cd-48fd-4032-a363-1496d3872899'),(72,NULL,'app','m171016_092553_drop_position_select','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','0ab30c3e-1a8f-4d18-aa8d-9234665ad388'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','cd156208-42e1-45c1-9517-ac97c5ac31b4'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','4db6b4d8-04d6-423e-81c4-8e7c464bb07c'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','a04fe3b9-a933-4eeb-bc95-017c93bbd7c6'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','63e4b1c1-0811-4aa9-b229-3e1322bb0f59'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','fe4d7cba-7482-46a5-83c4-f69ec69b9ba1'),(78,NULL,'app','m171202_004225_update_email_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','50a10a5f-4bd4-4eed-bb61-36a6c80654d4'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','97512c8f-3d16-444c-aa44-c3364e4a5ca5'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','1adae328-3f29-46a8-bead-e02568913f67'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','acc084de-9f08-442c-891d-502a1bf77381'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','0d81147e-ce31-46ee-8379-74abd8b4ca34'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','219d034b-88b9-4cd1-a6c0-5289772ed2fb'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','1250fa1b-b68a-44f2-b233-ccd4ecfc16d9'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','8edcca0a-36d4-4c6b-b865-375f42dcd006'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','c14f659c-c0ba-4499-88f4-02733b63dcf0'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','99b9440f-9c9c-4f3b-9c00-e0e73fcb6cac'),(88,NULL,'app','m180217_172123_tiny_ints','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','29be9543-dac9-4599-bc6b-9c28fcebde2a'),(89,NULL,'app','m180321_233505_small_ints','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','ab158711-720f-46b8-8054-b8b37ffb5992'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','c656079d-6ba5-49bd-ae65-fe514a630ec3'),(91,NULL,'app','m180404_182320_edition_changes','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','bcb9fe64-aa2a-46f4-a32d-b2cd4eb027de'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','a1b3ccaf-5766-448b-acf3-b4a82e5bdc23'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','7969da58-114e-411b-a249-db3fa7ca4935'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','8b143834-e5c9-4bf1-a277-36ee4b0b7b5d'),(95,NULL,'app','m180425_203349_searchable_fields','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','2356137f-e5eb-41da-bb6d-0cc7df30be17'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','63c71b46-ae81-4d0f-9dac-1f4befa2b588'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','ebb1af5f-43d9-4a49-8bdc-d72622d48849'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','8d9c8b9e-1f25-49a4-899d-56d4fdb33dde'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','f1f7f68a-238f-4271-b67f-cf4085e723ad'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','00ac4400-85b0-45b5-bc59-014820bcbc33'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','24b263f1-6747-4954-88c7-74a9be1bd36a'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','a3e538dc-4e4e-489d-a3bd-45347765ffae'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','e60b39c4-3a3f-4eb9-8cc0-0ec8a20233fe'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','826c1bfe-b987-49e7-b8a4-d59cf7cc6738'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','d8ba017f-f6d8-489e-bfd6-13b027e2166d'),(106,NULL,'app','m180904_112109_permission_changes','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','297738c4-c64c-4d22-b7c4-047b745f57a7'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','c2725f7b-c5e3-4948-bb1f-9c7ef8dd00c7'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','1c51b34c-f439-4f80-aca8-feb505fbc284'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','3453dd82-0fba-4e43-9b43-dc8dbeaae67f'),(110,NULL,'app','m181017_225222_system_config_settings','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','2acf3bf2-6a3b-4df0-9fb7-9ce93ec758e5'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','96459f3c-9014-4af3-843a-bbe20adf6e3d'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','904b9088-82f5-4136-9d06-ab35c32be4dd'),(113,NULL,'app','m181112_203955_sequences_table','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','92a9f264-d350-477b-aaa2-3d2fe58a5486'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','47af8325-b45b-402e-b93e-d0b9df4f50ea'),(115,NULL,'app','m181128_193942_fix_project_config','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','9b6818b4-289e-477e-bd62-8f5dd87086bf'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','a0c25507-2ea0-4bc4-bc3e-cf4ddbcbd2fa'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','309f846f-bfd7-4deb-88af-e8112c96ca52'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','d75ad0fe-c968-4d6e-b1b5-d1e58b955b86'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','c01e8efd-805e-4fe5-a272-f4ab13936e75'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','46eee71d-da9b-4676-8199-fde11b92876d'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','884824e6-be11-4a5c-a242-991fc47764c9'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','4222dd8a-a6e6-4bc3-8d1a-201f0ca16923'),(123,NULL,'app','m190109_172845_fix_colspan','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','87e2af86-7d42-4528-b591-ac2b5e04d0b2'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','aaa23428-cbb4-4683-aaeb-a18e0993dbc0'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','0167cc34-957d-4acc-a830-fecb241b5f0b'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','c3fb7992-0fe9-47db-a907-858ff0a956cc'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','cadcc634-cee8-454c-b723-948870bd7c58'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','933283a8-4e17-4b7f-9a18-5115391b0adc'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','1c60b730-c39e-4a15-a36a-1c43f414821c'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','98af4437-25b3-4cae-a8c3-bd85039ffef1'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','290b8c35-3d23-4497-a239-798a6f28d10d'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','9a87a0be-490a-42b5-bea6-5f55be27ca14'),(133,NULL,'app','m190218_143000_element_index_settings_uid','2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','b03ec6b6-2a1b-43f9-a75d-67f7ed09f950');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'copy','1.0.0-RC2','1.0.0','unknown',NULL,'2019-01-31 03:24:55','2019-01-31 03:24:55','2019-01-31 03:24:55','30fff04b-0fbe-4805-a594-2b1f52680081');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('260413bb','@bower/jquery/dist'),('2bac4b2e','@lib/jquery.payment'),('378be4c6','@lib/velocity'),('79227f63','@lib/jquery-ui'),('82f0ccd5','@lib/fabric'),('97b618eb','@lib/garnishjs'),('994b84e','@lib/element-resize-detector'),('a40b0f6d','@lib/d3'),('aaae2f3c','@lib/picturefill'),('ad0a13fe','@lib/jquery-touch-events'),('b2462ec2','@lib/fileupload'),('f4bc4632','@lib/xregexp'),('f8ff27f1','@craft/web/assets/cp/dist'),('fed002b8','@lib/selectize');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' dummy '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' dummy domain tld '),(1,'slug',0,1,'');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'dummy','2019-01-31 03:24:53','2019-01-31 03:24:53',NULL,'f68c8bad-92d7-48f9-8721-0c2a95e065c3');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'dummy','default','en-US',1,'@web',1,'2019-01-31 03:24:53','2019-01-31 03:24:53',NULL,'1afa571d-04b0-4b1a-990a-6a0654b6518f');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `templatecacheelements`
--

LOCK TABLES `templatecacheelements` WRITE;
/*!40000 ALTER TABLE `templatecacheelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `templatecachequeries`
--

LOCK TABLES `templatecachequeries` WRITE;
/*!40000 ALTER TABLE `templatecachequeries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `templatecaches`
--

LOCK TABLES `templatecaches` WRITE;
/*!40000 ALTER TABLE `templatecaches` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `templatecaches` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'dummy',NULL,NULL,NULL,'dummy@domain.tld','$2y$13$YD8rKCAo3H9FpCu.9OWjceGGjnU8KXEL9RFkX4jRXPeOe86BlkNR.',1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,0,'2019-01-31 03:24:54','2019-01-31 03:24:54','2019-01-31 03:24:54','625cade5-5c2e-4bfb-8bbf-3b49a7cac1bc');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'acrsupply'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-11 11:36:04
