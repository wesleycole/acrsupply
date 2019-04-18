-- MySQL dump 10.13  Distrib 8.0.15, for osx10.14 (x86_64)
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
  KEY `acr_assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `acr_assets_folderId_idx` (`folderId`),
  KEY `acr_assets_volumeId_idx` (`volumeId`),
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
  KEY `acr_categorygroups_name_idx` (`name`),
  KEY `acr_categorygroups_handle_idx` (`handle`),
  KEY `acr_categorygroups_structureId_idx` (`structureId`),
  KEY `acr_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_categorygroups_dateDeleted_idx` (`dateDeleted`),
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_content_siteId_idx` (`siteId`),
  KEY `acr_content_title_idx` (`title`),
  CONSTRAINT `acr_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  KEY `acr_elements_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_elements_type_idx` (`type`),
  KEY `acr_elements_enabled_idx` (`enabled`),
  KEY `acr_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `acr_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
  KEY `acr_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `acr_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `acr_entrytypes_sectionId_idx` (`sectionId`),
  KEY `acr_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `acr_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `acr_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `acr_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  KEY `acr_fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  UNIQUE KEY `acr_globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `acr_globalsets_handle_unq_idx` (`handle`),
  KEY `acr_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `acr_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `acr_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  KEY `acr_sections_handle_idx` (`handle`),
  KEY `acr_sections_name_idx` (`name`),
  KEY `acr_sections_structureId_idx` (`structureId`),
  KEY `acr_sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `acr_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `acr_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
  KEY `acr_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_sites_handle_idx` (`handle`),
  KEY `acr_sites_sortOrder_idx` (`sortOrder`),
  KEY `acr_sites_groupId_fk` (`groupId`),
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  KEY `acr_taggroups_name_idx` (`name`),
  KEY `acr_taggroups_handle_idx` (`handle`),
  KEY `acr_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  KEY `acr_volumes_name_idx` (`name`),
  KEY `acr_volumes_handle_idx` (`handle`),
  KEY `acr_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `acr_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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

-- Dump completed on 2019-04-17 20:48:38
-- MySQL dump 10.13  Distrib 8.0.15, for osx10.14 (x86_64)
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
INSERT INTO `acr_content` VALUES (1,1,1,NULL,'2019-04-18 00:36:05','2019-04-18 00:36:05','ed4a41d6-2064-4a07-938e-be66591de518');
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
/*!40000 ALTER TABLE `acr_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_elementindexsettings`
--

LOCK TABLES `acr_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `acr_elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_elements`
--

LOCK TABLES `acr_elements` WRITE;
/*!40000 ALTER TABLE `acr_elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2019-04-18 00:36:04','2019-04-18 00:36:04',NULL,'eedfb86e-4ad7-44b0-8014-822134a7e4d6');
/*!40000 ALTER TABLE `acr_elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_elements_sites`
--

LOCK TABLES `acr_elements_sites` WRITE;
/*!40000 ALTER TABLE `acr_elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-04-18 00:36:05','2019-04-18 00:36:05','5cb5ee18-6208-4305-bd64-f4e0466ab832');
/*!40000 ALTER TABLE `acr_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_entries`
--

LOCK TABLES `acr_entries` WRITE;
/*!40000 ALTER TABLE `acr_entries` DISABLE KEYS */;
set autocommit=0;
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
/*!40000 ALTER TABLE `acr_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_entryversions`
--

LOCK TABLES `acr_entryversions` WRITE;
/*!40000 ALTER TABLE `acr_entryversions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldgroups`
--

LOCK TABLES `acr_fieldgroups` WRITE;
/*!40000 ALTER TABLE `acr_fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fieldgroups` VALUES (1,'Common','2019-04-18 00:36:04','2019-04-18 00:36:04','e2f7d0aa-629e-4d2a-a84e-0ba74e549f10');
/*!40000 ALTER TABLE `acr_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldlayoutfields`
--

LOCK TABLES `acr_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `acr_fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldlayouts`
--

LOCK TABLES `acr_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `acr_fieldlayouts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldlayouttabs`
--

LOCK TABLES `acr_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `acr_fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fields`
--

LOCK TABLES `acr_fields` WRITE;
/*!40000 ALTER TABLE `acr_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_globalsets`
--

LOCK TABLES `acr_globalsets` WRITE;
/*!40000 ALTER TABLE `acr_globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_info`
--

LOCK TABLES `acr_info` WRITE;
/*!40000 ALTER TABLE `acr_info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_info` VALUES (1,'3.1.10','3.1.25',0,'a:8:{s:11:\"fieldGroups\";a:1:{s:36:\"e2f7d0aa-629e-4d2a-a84e-0ba74e549f10\";a:1:{s:4:\"name\";s:6:\"Common\";}}s:10:\"siteGroups\";a:1:{s:36:\"b8a80bbf-7cba-4959-bef2-b1928911fc81\";a:1:{s:4:\"name\";s:10:\"ACR Supply\";}}s:5:\"sites\";a:1:{s:36:\"90255823-0a1e-4237-bcce-580417535db5\";a:8:{s:7:\"baseUrl\";s:17:\"$DEFAULT_SITE_URL\";s:6:\"handle\";s:7:\"default\";s:7:\"hasUrls\";b:1;s:8:\"language\";s:5:\"en-US\";s:4:\"name\";s:10:\"ACR Supply\";s:7:\"primary\";b:1;s:9:\"siteGroup\";s:36:\"b8a80bbf-7cba-4959-bef2-b1928911fc81\";s:9:\"sortOrder\";i:1;}}s:5:\"email\";a:3:{s:9:\"fromEmail\";s:23:\"wesley.cole87@gmail.com\";s:8:\"fromName\";s:10:\"ACR Supply\";s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";}s:6:\"system\";a:5:{s:7:\"edition\";s:4:\"solo\";s:4:\"name\";s:10:\"ACR Supply\";s:4:\"live\";b:1;s:13:\"schemaVersion\";s:6:\"3.1.25\";s:8:\"timeZone\";s:19:\"America/Los_Angeles\";}s:5:\"users\";a:5:{s:24:\"requireEmailVerification\";b:1;s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:14:\"photoVolumeUid\";N;s:12:\"photoSubpath\";s:0:\"\";}s:12:\"dateModified\";i:1555547893;s:7:\"plugins\";a:1:{s:4:\"copy\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}}}','[]','8ntTPktNqF2Z','2019-04-18 00:36:04','2019-04-18 00:38:13','47ebf958-ace2-4a02-9567-a58d2629e559');
/*!40000 ALTER TABLE `acr_info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixblocks`
--

LOCK TABLES `acr_matrixblocks` WRITE;
/*!40000 ALTER TABLE `acr_matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixblocktypes`
--

LOCK TABLES `acr_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `acr_matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_migrations`
--

LOCK TABLES `acr_migrations` WRITE;
/*!40000 ALTER TABLE `acr_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_migrations` VALUES (1,NULL,'app','Install','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','2c413b76-9aeb-4d1e-8efd-0586b9df8946'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','7ab4e002-5d2d-446c-9013-01539089f28c'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','98a73e9a-71c1-4c6c-a90c-a7dd11077fd7'),(4,NULL,'app','m150403_184533_field_version','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','69970d12-b5e2-40aa-886c-e0adc2b88f54'),(5,NULL,'app','m150403_184729_type_columns','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','7ed3c3a1-3bc9-4214-8d20-8d0bb59813ba'),(6,NULL,'app','m150403_185142_volumes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','70813274-bb95-477a-988c-842862495a99'),(7,NULL,'app','m150428_231346_userpreferences','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','c6689318-28eb-406a-9afb-1f4e5549ff22'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','6fd7a571-8631-487c-9b8c-6c2ef2883ec4'),(9,NULL,'app','m150617_213829_update_email_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','ee7cec63-5ff3-4e1b-81bd-0b8033b4ace6'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','38d861c9-31f3-4e52-a94b-d90f2462a8de'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','63a7b250-1c11-4697-8379-0f3211c3f37f'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','c15c62e6-a8cb-4cfd-82f4-6c0d1edf86f2'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','6ff554bf-ed3d-4342-9ec4-18e5519cb7c1'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','807b6d08-68a3-40cd-862b-73d01a9c2703'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','30e17cda-6183-4750-8820-dc316cc4c181'),(16,NULL,'app','m151209_000000_move_logo','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','7f5a4e91-dda4-41fc-bda3-2bdf1d27790e'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','0db619eb-eb41-40d8-8049-1d09cfc95a3c'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','d74ed153-3096-48e6-bb86-55fed33bfac8'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','e4879a02-dea7-4160-9152-0de73cca31d7'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','934280b5-899b-4fef-a3d7-26305c04d4d4'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','e87bb6f3-6e93-406d-85cc-43e211813410'),(22,NULL,'app','m160727_194637_column_cleanup','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','2cf6d588-8e58-4c63-b3ec-8d74bb7ed371'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','125d61df-40ea-4fbc-868a-c114e5bad477'),(24,NULL,'app','m160807_144858_sites','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','218ff8ba-93c3-453b-80a3-3921f8c775e0'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','299c9d59-8062-4bfe-a7d5-eb0943a3e652'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','1cc0b8cc-aec4-4264-b656-c971fa87fa9f'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','5b9b42c0-dc90-4540-bd13-4e8f4cc1f6b3'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','4a72eb18-9a9b-4e38-96bf-fad58e0b0368'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','9b6d5f3e-82c6-4e04-9868-259c8535ef8f'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','e021bb40-382c-4009-9861-531912a06dd3'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','85672918-9157-4a34-bfaa-b791bde651be'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','d2f33d23-77c3-4429-aecd-1e5e88ac34ac'),(33,NULL,'app','m161007_130653_update_email_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','5284a86c-51d0-46dd-b2f5-883d025ff308'),(34,NULL,'app','m161013_175052_newParentId','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','8f5b6638-a43f-4ff3-8c26-730c02f479d5'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','6edfe47a-ac4d-438e-97ef-0229447cb186'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','7d115b2b-70b5-4dac-af8c-87a59dde8bcc'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','e7309801-3c56-4e91-a13f-53465ca7f852'),(38,NULL,'app','m161029_124145_email_message_languages','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','4028bff2-653f-42f1-95ca-9be1a9567f0a'),(39,NULL,'app','m161108_000000_new_version_format','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','d859bfb3-4074-4840-a976-4f2ed96d6165'),(40,NULL,'app','m161109_000000_index_shuffle','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','771be930-223a-4fa4-b471-a0a6b0d723f6'),(41,NULL,'app','m161122_185500_no_craft_app','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','81ce2fd8-a5db-4dea-a14a-bfb9b211bcc7'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','f750ebae-c346-4cf2-9626-ecee80c3996f'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','6be5a9cb-1aaf-48ee-97fd-6e38a9f64845'),(44,NULL,'app','m170114_161144_udates_permission','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','c1a98349-8975-435e-bafd-5db453e46f07'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','9425d28e-874e-4485-9262-4aa40138bbd6'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','146bc743-182e-40cb-8c2f-d006002d989d'),(47,NULL,'app','m170206_142126_system_name','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','fb3afb07-9f8b-4beb-9931-75f3218971e9'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','0073a80d-c513-4e0b-91d1-a00cbfdc38ed'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','e7b2ba42-2a78-4306-aee4-d4fa58bd6e1d'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','1920e51c-4f65-4b9e-bd98-2105d7ae7464'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','a8ee46cd-ed4f-4288-a4d0-ed2c90381a24'),(52,NULL,'app','m170228_171113_system_messages','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','c9ee398f-65bf-4a48-991d-657777f7b943'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','59638231-c58b-43d7-994a-f0564a59aa40'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','09431787-06f2-4d2d-9b9d-416deb23ec1b'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','4b5c0f37-3a4d-4bcd-94b4-57e6a449a081'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','dff824d7-cb26-42c5-bb7c-af1bce078f25'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','731a88ba-d547-4960-9c84-64f4946fbefa'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','283836b2-93b8-48aa-aa46-632a5d478488'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','015a5e38-9af4-4421-b505-bcff8ec31507'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','4ada7def-512b-403d-b88c-d9de55337592'),(61,NULL,'app','m170704_134916_sites_tables','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','d6f28f9a-dd1a-4025-bb84-79e166451327'),(62,NULL,'app','m170706_183216_rename_sequences','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','eff367f1-f59f-4b6e-9931-f3dcaedddc55'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','19df5e19-ea1b-4450-84da-08c54a296538'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','14b46067-2374-4f68-9ef6-02cee7a5da8a'),(65,NULL,'app','m170810_201318_create_queue_table','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','835c643f-070f-4ce8-b70c-1e78ff3dca73'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','9fa00847-2e76-4e34-a581-7a5db232f9f5'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','ad1fa6cd-49f3-4aa4-8f94-835ba25091a1'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','4222c7c3-e9bb-41ab-a852-4ee44dbcd8c8'),(69,NULL,'app','m171011_214115_site_groups','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','2701c3e6-0c89-4332-95e7-78d62ca733b2'),(70,NULL,'app','m171012_151440_primary_site','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','9f0b4417-d9e8-461c-8e50-cf536826e57e'),(71,NULL,'app','m171013_142500_transform_interlace','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','5108e743-5480-4c64-8e03-e1107d9f382c'),(72,NULL,'app','m171016_092553_drop_position_select','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','13376c70-1a43-477a-ad16-222b0db7bb62'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','9e86e4d9-68c5-4ce5-9a73-f122ffcf3178'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','d8efaa45-4533-458c-83eb-3c248b8a3f68'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','f74990e3-33ec-4754-91fa-d105e40f2732'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','edb43bd8-feb2-4aa9-b9c5-704f59645b1a'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','6b7596fd-c2d2-4d4a-ae53-9af0ba4c1b50'),(78,NULL,'app','m171202_004225_update_email_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','163e6767-ad0a-41c8-85cd-cc6cc175857d'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','32944d18-f324-4652-8511-b66267609f90'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','df47c9fb-556a-4420-9712-cd16b0020fb6'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','06e67276-e7cf-4c32-92dd-9bbb1dfc4a9a'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','1e80d228-d4f2-4c91-8019-34a715e0a3e7'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','cdb8e5c0-4f73-4cb6-b479-78dbc75f8979'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','1350c669-ee73-478f-97ec-2855f43a5d90'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','7622e449-4541-4607-b5ef-70c3fba2821a'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','a6092bac-5cf8-4ace-ac5b-d571fa56de2c'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','88b74414-9740-43e6-ad74-4ac099d48bc5'),(88,NULL,'app','m180217_172123_tiny_ints','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','ba3420f8-db93-4ecf-bdc5-004bbcb694dd'),(89,NULL,'app','m180321_233505_small_ints','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','23466550-943a-40cb-9f02-4cf561d106d4'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','8aa82292-1fbe-4a3d-91a0-049cdc685b51'),(91,NULL,'app','m180404_182320_edition_changes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','6944e42a-d4ba-4ad4-81b8-246c2705ec70'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','36c02062-0459-4928-b2b4-e4fce557c32a'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','4ad76c72-8ea1-47bc-9300-db37803d0c47'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','7a377df7-af7d-4a15-864f-04d44512a309'),(95,NULL,'app','m180425_203349_searchable_fields','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','73a4f714-effd-4312-ad3b-2763d43504f8'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','44cc70ac-3cb0-437e-9ae8-bf3c52dacb13'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','b88d2f27-bb4a-413d-8f9f-712ef113c3b6'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','8c8ade80-c404-4f7f-9ad7-8a9488006ad1'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','660244de-32de-4487-a53e-9dfe5c6a06de'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','5a2267b8-433b-42b5-9949-5bb78b6ef10c'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','d70f7ded-c72a-4221-9b6c-0c4afdaa52c8'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','3f23d684-8e8c-4f5a-b55e-9f897092dfe8'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','fb23367c-a3f4-4e28-8cf9-5cb6660341b9'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','992093cd-8b2c-4ac5-9ce9-50a8bf73ae8f'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','8239041a-8417-42f2-ae42-1517e1714c5b'),(106,NULL,'app','m180904_112109_permission_changes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','4214ba9c-9472-44ba-b376-5b0032042e8b'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','bab23811-bd50-4222-83b7-f40e9da0c9e8'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','c0eb6c63-ca73-4455-a40e-dd94862e5b11'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','43c66550-a356-421f-8b6b-52c233c05d22'),(110,NULL,'app','m181017_225222_system_config_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','ea437045-3de8-440d-b5e6-6c0c16e6ff3f'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','958be82e-4c24-490a-a63f-354d38ddcd5e'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','cb446324-6c20-41df-9f84-fe1cb955f7d0'),(113,NULL,'app','m181112_203955_sequences_table','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','d9ce8e2e-69a1-43bb-b672-f3e6abf20b65'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','df201929-93b4-4f83-a503-a60b20defb98'),(115,NULL,'app','m181128_193942_fix_project_config','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','fef63ccb-38bf-40a9-be04-0c6f8cf242e3'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','dda90932-0b7d-4b48-988f-79deef2ba619'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','b67eaad3-fb68-4bb1-8a5d-c6533ab0c26a'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','3c152631-65fb-4170-ac94-1c473cfe97e6'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','423aca57-880b-4096-aa27-33f09659edae'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','ffe44637-c94a-4004-a136-46eac49ad38f'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','683c88c0-8fdc-4341-8d71-2112731737e2'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','ec9ba5f5-a793-4442-8d79-a9c49e61c6d7'),(123,NULL,'app','m190109_172845_fix_colspan','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','0ff68d03-6dd9-4c8e-8a05-5b166efb846a'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','6bf7cf62-ad84-441d-a038-67e7bafa3f63'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','abbb2abb-6a4c-4dcd-bfcc-23d085f8aaf6'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','53a85855-77d4-4861-8da6-126911acb6c8'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','15b3a9ef-49d1-46e4-b465-efa9e1050fc4'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','62aa0b9d-a3fb-4e47-875e-5b31bd2ad033'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','71d1ccd0-da30-4ea7-a600-eae7c475874b'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','90fd5639-1608-48ba-92b9-905b16bc80af'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','eab6070a-d1b2-49d4-84f9-4bc44647b416'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','6eae7b96-e455-4266-a266-2d19b1fef9f7'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','4c380ee9-9676-4ecc-a180-d3e4da7542cc'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','821e5903-fb26-4f47-91bd-40ba7a57fd40'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:05','a76eb763-b254-4d98-a51c-bca58795e5f6');
/*!40000 ALTER TABLE `acr_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_plugins`
--

LOCK TABLES `acr_plugins` WRITE;
/*!40000 ALTER TABLE `acr_plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_plugins` VALUES (1,'copy','1.0.0-RC5','1.0.0','unknown',NULL,'2019-04-18 00:38:13','2019-04-18 00:38:13','2019-04-18 00:38:13','5401fe19-4457-4007-a131-bc85ea5ec7f0');
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
/*!40000 ALTER TABLE `acr_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_resourcepaths`
--

LOCK TABLES `acr_resourcepaths` WRITE;
/*!40000 ALTER TABLE `acr_resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_resourcepaths` VALUES ('4befdb0b','@lib/fileupload'),('5307daf5','@lib/picturefill'),('54a3e637','@lib/jquery-touch-events'),('5da2faa4','@lib/d3'),('6e1fed22','@lib/garnishjs'),('779f771','@lib/selectize'),('782b62d9','@app/web/assets/dashboard/dist'),('7b59391c','@lib/fabric'),('808b8aaa','@lib/jquery-ui'),('9643e5b7','@app/web/assets/craftsupport/dist'),('98d14976','@app/web/assets/updateswidget/dist'),('a66b0b18','@app/web/assets/recententries/dist'),('bb262c95','@app/web/assets/cp/dist'),('bf1839eb','@app/web/assets/login/dist'),('c23d672b','@app/web/assets/feed/dist'),('ce22110f','@lib/velocity'),('d15b3fb','@lib/xregexp'),('d205bee7','@lib/jquery.payment'),('dfade672','@bower/jquery/dist'),('f03d4d87','@lib/element-resize-detector');
/*!40000 ALTER TABLE `acr_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_searchindex`
--

LOCK TABLES `acr_searchindex` WRITE;
/*!40000 ALTER TABLE `acr_searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' wesley cole87 gmail com '),(1,'slug',0,1,'');
/*!40000 ALTER TABLE `acr_searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sections`
--

LOCK TABLES `acr_sections` WRITE;
/*!40000 ALTER TABLE `acr_sections` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sections_sites`
--

LOCK TABLES `acr_sections_sites` WRITE;
/*!40000 ALTER TABLE `acr_sections_sites` DISABLE KEYS */;
set autocommit=0;
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
INSERT INTO `acr_sitegroups` VALUES (1,'ACR Supply','2019-04-18 00:36:04','2019-04-18 00:36:04',NULL,'b8a80bbf-7cba-4959-bef2-b1928911fc81');
/*!40000 ALTER TABLE `acr_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sites`
--

LOCK TABLES `acr_sites` WRITE;
/*!40000 ALTER TABLE `acr_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_sites` VALUES (1,1,1,'ACR Supply','default','en-US',1,'$DEFAULT_SITE_URL',1,'2019-04-18 00:36:04','2019-04-18 00:36:04',NULL,'90255823-0a1e-4237-bcce-580417535db5');
/*!40000 ALTER TABLE `acr_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_structureelements`
--

LOCK TABLES `acr_structureelements` WRITE;
/*!40000 ALTER TABLE `acr_structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_structures`
--

LOCK TABLES `acr_structures` WRITE;
/*!40000 ALTER TABLE `acr_structures` DISABLE KEYS */;
set autocommit=0;
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
INSERT INTO `acr_users` VALUES (1,'admin',NULL,NULL,NULL,'wesley.cole87@gmail.com','$2y$13$HDWMETvEdwbSWtRw9eAWPOG8jpCYZbdAH.vff/Gelbz9kLzwN5kay',1,0,0,0,'2019-04-18 00:36:27',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-04-18 00:36:05','2019-04-18 00:36:05','2019-04-18 00:36:28','4aa72f56-7705-4ada-a628-a69809b07f8c');
/*!40000 ALTER TABLE `acr_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_volumefolders`
--

LOCK TABLES `acr_volumefolders` WRITE;
/*!40000 ALTER TABLE `acr_volumefolders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_volumes`
--

LOCK TABLES `acr_volumes` WRITE;
/*!40000 ALTER TABLE `acr_volumes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `acr_volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_widgets`
--

LOCK TABLES `acr_widgets` WRITE;
/*!40000 ALTER TABLE `acr_widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-04-18 00:36:28','2019-04-18 00:36:28','9c854357-ce3b-4c73-a411-cf163856de34'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-04-18 00:36:28','2019-04-18 00:36:28','5cc8f946-df13-4b8c-b01d-c6a2da144d29'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-04-18 00:36:28','2019-04-18 00:36:28','559d6720-7ce6-45b8-b1cf-fbcac3a82614'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-04-18 00:36:28','2019-04-18 00:36:28','a209ff58-af5e-4871-b11e-6fb8d5f70147');
/*!40000 ALTER TABLE `acr_widgets` ENABLE KEYS */;
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

-- Dump completed on 2019-04-17 20:48:38
