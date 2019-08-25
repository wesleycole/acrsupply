-- MySQL dump 10.13  Distrib 5.7.27, for osx10.14 (x86_64)
--
-- Host: localhost    Database: acrsupply
-- ------------------------------------------------------
-- Server version	5.7.27

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
-- Table structure for table `acr_assetindexdata`
--

DROP TABLE IF EXISTS `acr_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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

-- Dump completed on 2019-08-25 13:27:45
-- MySQL dump 10.13  Distrib 5.7.27, for osx10.14 (x86_64)
--
-- Host: localhost    Database: acrsupply
-- ------------------------------------------------------
-- Server version	5.7.27

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
INSERT INTO `acr_content` VALUES (1,1,1,NULL,'2019-08-25 17:24:54','2019-08-25 17:24:54','0e7d3479-6005-4eea-b292-ea86bef1f33e');
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
INSERT INTO `acr_elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2019-08-25 17:24:54','2019-08-25 17:24:54',NULL,'a93f58e1-ade6-4c24-bce2-3e2b030518cb');
/*!40000 ALTER TABLE `acr_elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_elements_sites`
--

LOCK TABLES `acr_elements_sites` WRITE;
/*!40000 ALTER TABLE `acr_elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-08-25 17:24:54','2019-08-25 17:24:54','973c5ae1-91cc-425a-8af5-611a4150ffb7');
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
INSERT INTO `acr_fieldgroups` VALUES (1,'Common','2019-08-25 17:24:54','2019-08-25 17:24:54','c162345d-fe37-46fb-bd4f-54b110378929');
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
INSERT INTO `acr_info` VALUES (1,'3.1.19','3.1.25',0,'a:8:{s:11:\"fieldGroups\";a:1:{s:36:\"c162345d-fe37-46fb-bd4f-54b110378929\";a:1:{s:4:\"name\";s:6:\"Common\";}}s:10:\"siteGroups\";a:1:{s:36:\"0bfe9cbf-9f5e-4ed0-bc9d-7fd0a0baffd6\";a:1:{s:4:\"name\";s:14:\"ACR Supply Co.\";}}s:5:\"sites\";a:1:{s:36:\"71efbe2e-62eb-4c39-9dfb-0cbbdee7b11f\";a:8:{s:7:\"baseUrl\";s:17:\"$DEFAULT_SITE_URL\";s:6:\"handle\";s:7:\"default\";s:7:\"hasUrls\";b:1;s:8:\"language\";s:5:\"en-US\";s:4:\"name\";s:14:\"ACR Supply Co.\";s:7:\"primary\";b:1;s:9:\"siteGroup\";s:36:\"0bfe9cbf-9f5e-4ed0-bc9d-7fd0a0baffd6\";s:9:\"sortOrder\";i:1;}}s:5:\"email\";a:3:{s:9:\"fromEmail\";s:23:\"wesley.cole87@gmail.com\";s:8:\"fromName\";s:14:\"ACR Supply Co.\";s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";}s:6:\"system\";a:5:{s:7:\"edition\";s:4:\"solo\";s:4:\"name\";s:14:\"ACR Supply Co.\";s:4:\"live\";b:1;s:13:\"schemaVersion\";s:6:\"3.1.25\";s:8:\"timeZone\";s:19:\"America/Los_Angeles\";}s:5:\"users\";a:5:{s:24:\"requireEmailVerification\";b:1;s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:14:\"photoVolumeUid\";N;s:12:\"photoSubpath\";s:0:\"\";}s:12:\"dateModified\";i:1566753916;s:7:\"plugins\";a:1:{s:4:\"copy\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}}}','[]','Sj6HFm4sm7CS','2019-08-25 17:24:54','2019-08-25 17:25:16','ae007e15-eb74-4efc-a14c-67952c68ed6d');
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
INSERT INTO `acr_migrations` VALUES (1,NULL,'app','Install','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','ec3c0758-bf11-4152-9d90-146ee842b3d8'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','87a8b0a7-63ae-4e1b-8dfb-40176937408a'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','e3f425b5-e2a5-40d2-a0c2-462eb0baf31a'),(4,NULL,'app','m150403_184533_field_version','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','9f28b3d2-f5ef-459d-bc15-230a8a66ae76'),(5,NULL,'app','m150403_184729_type_columns','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','e6e917ae-4d21-422a-b6ca-40cb97d15c33'),(6,NULL,'app','m150403_185142_volumes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','58e028d4-78e0-446d-9bd7-226dd684bc0e'),(7,NULL,'app','m150428_231346_userpreferences','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','73eda839-7705-488c-a291-c61ff0c3fe18'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','57b1e79e-2658-4afc-9df3-0be793b1eeac'),(9,NULL,'app','m150617_213829_update_email_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','f78c2ca0-2195-4bfa-bcae-fdf3385e8eda'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','a2386949-aa74-447e-af83-c0d0cbc7b30e'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','ee8c2dca-d64d-4b30-8911-2f7662ddca4c'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','82902583-0cc7-4632-96a5-dcdfa264c850'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','bddd7c96-c985-4f29-8686-c50950464473'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','9afb2a17-7ce6-4c7b-987b-34091a99c2bb'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','a46232a8-f711-4c63-8256-6c399b16a08e'),(16,NULL,'app','m151209_000000_move_logo','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','ea60f2fe-efd4-40ba-a771-7de4108f4f37'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','64a28343-fc07-473a-b862-f07a1f841026'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','63809cf8-b512-4b25-be9a-888e656ca0a9'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','3a043723-b599-4c53-99bc-46cc2e578950'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','00bce787-93e5-4674-b7a2-2d0e116b71d3'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','eec839c8-20e3-4d95-b472-0f5bbeb87b85'),(22,NULL,'app','m160727_194637_column_cleanup','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','577cfea9-6eef-4ef1-ab90-f66efc6f7634'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','f0c69c36-5469-405b-aecf-982837758a67'),(24,NULL,'app','m160807_144858_sites','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','2d0cbd5c-ff7c-484e-93f5-7e79c3d28e18'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','1a52ec05-7fdc-4309-b243-7c7936ee37d0'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','0169b658-7f90-43f1-b4f6-60344d57a3b0'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','a6e53bd0-e10a-4bd4-a515-845b7c250864'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','94c80396-5868-42dd-b51c-4dd7839b8463'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','90bdc554-0b67-4f63-9fd9-d35881332e05'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','c2f031e6-b554-4322-9f63-ef1fab58168f'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','6f1692ae-fcd0-4c64-96a3-cba37a25f89c'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','81d15ded-aa49-413f-b78a-f72eeb020f87'),(33,NULL,'app','m161007_130653_update_email_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','1cde24e2-3293-4b64-9de4-94547304acf6'),(34,NULL,'app','m161013_175052_newParentId','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','02a838bb-13ff-4970-ab81-b73e2c225298'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','7841fce4-ec36-4467-8e2b-c10a5b54ee86'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','378c071a-15eb-4d4f-9b0e-ba4ff21b5a1c'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','1f1a74b1-2541-4328-8869-46b0b7ec6120'),(38,NULL,'app','m161029_124145_email_message_languages','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','1ea75b24-877b-4597-917c-76655f719ac0'),(39,NULL,'app','m161108_000000_new_version_format','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','b58a4f54-1abc-42d9-8e76-f4cc66e555d8'),(40,NULL,'app','m161109_000000_index_shuffle','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','549ec82e-d846-41b1-858e-9618319f18a8'),(41,NULL,'app','m161122_185500_no_craft_app','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','234d4ccb-fd59-4123-a6dd-4b506c7b0fa5'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','425c1f5d-fb6b-4e19-81c6-35a63c2bdeff'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','65da256d-bb83-4d4b-a8d2-0928fcaaa7c2'),(44,NULL,'app','m170114_161144_udates_permission','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','627a01c5-0c9a-485a-abc0-04381371873a'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','e9054197-419b-42e0-9693-b30318284daf'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','e1459851-5aae-4dca-b1ef-4fbb265ca438'),(47,NULL,'app','m170206_142126_system_name','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','664bfec1-13ab-4320-9a74-f2661c63cf72'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','e9f53ec5-5747-495f-a011-c82678f9e19f'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','372471a1-74ec-41e5-8cba-13b12ab3e0f8'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','77817a12-5875-4e15-9889-49a93a5b5f22'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','ce9c1a8e-f55c-4537-ba77-6c28366ef36f'),(52,NULL,'app','m170228_171113_system_messages','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','166a22f6-cd19-48cd-9536-34be24fb6716'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','7f865964-dfb6-47be-a703-bccb9ec3ae7c'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','2f44c59f-8304-4abd-bca8-dd8638292939'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','7010eeee-03dc-4497-ad34-4630380eee28'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','edb4cf4c-3f03-4441-9754-bf38ab2ae19a'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','a4ba4065-a071-4cf7-9ac4-a7c6d0f80aee'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','331d0920-ad8a-46c4-8fe3-1a485d772971'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','874b702e-86a2-43a4-b0bc-8d6240f98546'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','d29e9126-9ff8-48a6-910c-b0fdeec3f00d'),(61,NULL,'app','m170704_134916_sites_tables','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','6f59d0df-0c49-4d6a-a368-72728f1dc5a0'),(62,NULL,'app','m170706_183216_rename_sequences','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','e3199ac7-d23b-4d56-b2c3-4fc7eedeac66'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','0f8ca0c2-24c5-49a5-89f1-172aa5dfb8a4'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','f4df2626-e90a-4114-bff6-8ed2bb672dc8'),(65,NULL,'app','m170810_201318_create_queue_table','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','8698aa71-dbc4-4e24-a7b5-99d26592b756'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','a80522d0-f173-452f-9829-27da8adc5aad'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','87767d3f-9b62-449d-b291-0d851800b315'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','fd6f5253-4a68-4ab3-bc96-8f96527baeb4'),(69,NULL,'app','m171011_214115_site_groups','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','4d758d44-bb8b-41b7-8991-cf92f247fa2c'),(70,NULL,'app','m171012_151440_primary_site','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','d51f9530-2b22-4995-80e7-184f3fbde2ab'),(71,NULL,'app','m171013_142500_transform_interlace','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','676fc942-bc7f-4b7d-b912-47c48724a2f8'),(72,NULL,'app','m171016_092553_drop_position_select','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','a1967b4c-2c47-4686-b0b7-ec7dc87d3193'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','8dfce5a6-19b7-4174-a89a-50bfeb10e716'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','0a4e4e15-3661-4402-ba22-df1f9ff09fe2'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','9c277d6f-9835-421e-82ac-a2f6b86677d5'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','ec35914e-ae17-42e3-935e-1340bc8dd930'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','3a2d2d5d-0163-4f64-8ba5-641d83421002'),(78,NULL,'app','m171202_004225_update_email_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','7ddad9b5-5978-4d17-b8d7-22b197906e04'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','76f270b9-ad1d-4616-9d7d-4caece8fdb96'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','fe565221-6a79-49d1-867f-7f797c55e5dd'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','40c56a88-e4e9-4454-bedb-cb82bc579c72'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','04d99d23-20ad-457e-a3e5-7f3ad53a4243'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','a602b333-bf4e-4a53-b5b9-c58f26d92cef'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','5ef0bb46-f43d-4301-9a99-dbf79f697e7d'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','5b8d9df6-501a-474a-abd1-0f307af01fe5'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','c6bd2e9f-a8e8-4dd4-9058-6ca6f692998f'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','5f3b94ed-5994-410d-8834-68d695186d55'),(88,NULL,'app','m180217_172123_tiny_ints','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','cda23857-82c4-4901-98f4-af8b3330cf1e'),(89,NULL,'app','m180321_233505_small_ints','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','6a4d1a68-d75c-4356-82d6-7ccde3421ce2'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','1c601ff9-e1ff-44c0-aacb-5374b1315272'),(91,NULL,'app','m180404_182320_edition_changes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','76d7379f-6b88-4b13-bc42-5ad43659b4b0'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','dea59e0e-21fc-4eaa-8b72-7bd325196edb'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','1abef22a-417f-45ae-9a2c-ff542a93dce6'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','fed9a9a2-ed6e-4686-be55-50e6b78cad2f'),(95,NULL,'app','m180425_203349_searchable_fields','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','0c350a87-95fd-4295-8f7b-c3b5e08bc213'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','4ae62934-20ac-4941-b834-39bb8466ff29'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','eaa80053-08ef-4aca-9744-b4b59808cf1b'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','323ad669-5d10-405d-9e6f-37fbad32e281'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','74894adb-876d-4396-994e-ae2d23ee4c15'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','d1a27616-ac01-4078-bbcd-9ffa0217cfe3'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','5d9a5971-7cf6-4c8a-ba6c-40a45ff8b095'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','1bbed05d-af84-4564-85cc-18fa701a7804'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','b5b71564-c3bf-4558-b256-839a32cb36c3'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','0c84c26a-be74-4e52-88bf-4260932be215'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','36061177-ff21-44af-958a-c0e0803e9e32'),(106,NULL,'app','m180904_112109_permission_changes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','6e744970-e470-475c-9aa9-c683856c911d'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','78455090-f39c-4ca3-9128-18b68af7b523'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','d1b5af27-4b86-46f3-b574-76aa109909ea'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','6e73923b-2dd6-4519-bf47-f1864ed8af72'),(110,NULL,'app','m181017_225222_system_config_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','298c2ccc-6a52-4d50-a1a8-f6adddd42f83'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','b5273c13-1629-4b0f-9839-4a9c2e23d18b'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','25ddb7f9-d8b1-4396-aff6-5b51afe8dd9e'),(113,NULL,'app','m181112_203955_sequences_table','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','9b2595e0-c81d-4c1b-9268-3de8751855ca'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','ae98bd6c-5757-4f86-82a1-09c1008a38b6'),(115,NULL,'app','m181128_193942_fix_project_config','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','babee594-4d3e-402a-9885-2774ebf2f4b1'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','568486e6-5803-4422-8dfd-9bd2597bbd29'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','4bc79579-62c6-43ad-987a-a37a1c963d18'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','eec63679-9755-4d56-b31b-72729ac9bca9'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','0044e124-fcdb-468a-868d-838b26791767'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','79344fa3-2eb5-4063-a544-9413600c6b42'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','734eefc2-04a9-4b59-bcda-e03fdaa4cf72'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','219ce5ce-220f-4cf9-85ce-efaf7e4ee5c0'),(123,NULL,'app','m190109_172845_fix_colspan','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','7ab4a506-f7f3-4905-b9aa-63a180088cf3'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','07cc7b6b-cd7c-466d-af15-cb4bec55f897'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','c7df5ca0-94e1-4cbe-aa6b-e03666b32dcb'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','9b211a7f-e748-476c-b5fa-5cf15e81422f'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','35e2c6a8-43d8-45c5-909f-d755a1888ed9'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','bcb615ee-fbbd-467e-adf3-d69cba5dad9e'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','f77c0725-2859-4337-9e98-c7f678a6b02e'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','c6908c5c-5265-4265-ba79-20cc7e25f7a2'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','a0cde62a-ad52-489a-841b-d0bdf69ee828'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','847191dd-46ae-4f3c-bd66-fd52e639201d'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','2e0aeb33-1dd1-46ec-968b-0f24152faea9'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','0c769071-bb08-43a3-9cde-04f886482d96'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:24:55','0d5c2d85-8a2b-4359-bcce-14fee2bce65c');
/*!40000 ALTER TABLE `acr_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_plugins`
--

LOCK TABLES `acr_plugins` WRITE;
/*!40000 ALTER TABLE `acr_plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_plugins` VALUES (1,'copy','1.0.0-RC4','1.0.0','unknown',NULL,'2019-08-25 17:25:16','2019-08-25 17:25:16','2019-08-25 17:25:16','c2c34d3a-baa8-4fe2-8ad4-4c12a95acda7');
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
INSERT INTO `acr_resourcepaths` VALUES ('103d4a5c','@lib/fileupload'),('208ba84b','@lib/fabric'),('35cd7c75','@lib/garnishjs'),('56c722ac','@lib/xregexp'),('5a84436f','@craft/web/assets/cp/dist'),('5cab6626','@lib/selectize'),('6706bf3','@lib/d3'),('7e40d890','@craft/web/assets/recententries/dist'),('847f7725','@bower/jquery/dist'),('89d72fb0','@lib/jquery.payment'),('8d54ba2','@lib/picturefill'),('95f08058','@lib/velocity'),('a1007778','@craft/web/assets/dashboard/dist'),('abefdcd0','@lib/element-resize-detector'),('d84351b3','@craft/web/assets/feed/dist'),('db591bfd','@lib/jquery-ui'),('e7566cf7','@craft/web/assets/craftsupport/dist'),('ef50db3a','@craft/web/assets/login/dist'),('f717760','@lib/jquery-touch-events');
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
INSERT INTO `acr_sitegroups` VALUES (1,'ACR Supply Co.','2019-08-25 17:24:54','2019-08-25 17:24:54',NULL,'0bfe9cbf-9f5e-4ed0-bc9d-7fd0a0baffd6');
/*!40000 ALTER TABLE `acr_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sites`
--

LOCK TABLES `acr_sites` WRITE;
/*!40000 ALTER TABLE `acr_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_sites` VALUES (1,1,1,'ACR Supply Co.','default','en-US',1,'$DEFAULT_SITE_URL',1,'2019-08-25 17:24:54','2019-08-25 17:24:54',NULL,'71efbe2e-62eb-4c39-9dfb-0cbbdee7b11f');
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
INSERT INTO `acr_users` VALUES (1,'admin',NULL,NULL,NULL,'wesley.cole87@gmail.com','$2y$13$G7aLbNv9RA5y36aa8GsMB.SLDkBKKC31e01XzamPxakyyJ4iJymye',1,0,0,0,'2019-08-25 17:27:05',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-08-25 17:24:55','2019-08-25 17:24:55','2019-08-25 17:27:05','cfb21ff2-5d1d-4334-84e5-15996ecdec13');
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
INSERT INTO `acr_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-08-25 17:27:05','2019-08-25 17:27:05','4df374f2-1271-49b6-b9bf-c93f18778a97'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-08-25 17:27:05','2019-08-25 17:27:05','72fba2a3-7a3a-4f22-880f-97cac879252e'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-08-25 17:27:05','2019-08-25 17:27:05','b4c4adf8-a521-47b6-a0a3-1c41d2a7e7d9'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-08-25 17:27:05','2019-08-25 17:27:05','2f8dde9f-cd2e-4560-b416-16a538a646f8');
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

-- Dump completed on 2019-08-25 13:27:45
