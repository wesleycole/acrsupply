-- MySQL dump 10.13  Distrib 5.7.21, for osx10.13 (x86_64)
--
-- Host: localhost    Database: acrsupply
-- ------------------------------------------------------
-- Server version	5.7.21

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
  KEY `acr_assets_folderId_idx` (`folderId`),
  KEY `acr_assets_volumeId_idx` (`volumeId`),
  KEY `acr_assets_filename_folderId_idx` (`filename`,`folderId`),
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `acr_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `acr_content_siteId_idx` (`siteId`),
  KEY `acr_content_title_idx` (`title`),
  CONSTRAINT `acr_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `acr_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `acr_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `acr_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
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
  KEY `acr_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_elements_type_idx` (`type`),
  KEY `acr_elements_enabled_idx` (`enabled`),
  KEY `acr_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `acr_elements_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `acr_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
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
  KEY `acr_entrytypes_sectionId_idx` (`sectionId`),
  KEY `acr_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `acr_entrytypes_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `acr_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  CONSTRAINT `acr_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `acr_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `acr_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `acr_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;
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
  KEY `acr_fieldlayouts_type_idx` (`type`),
  KEY `acr_fieldlayouts_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_crm_fields`
--

DROP TABLE IF EXISTS `acr_freeform_crm_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_freeform_integrations`
--

DROP TABLE IF EXISTS `acr_freeform_integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acr_matrixcontent_acrcaresinitiatives`
--

DROP TABLE IF EXISTS `acr_matrixcontent_acrcaresinitiatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
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
-- Table structure for table `acr_matrixcontent_services`
--

DROP TABLE IF EXISTS `acr_matrixcontent_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
-- Table structure for table `acr_matrixcontent_teammemberinitiatives`
--

DROP TABLE IF EXISTS `acr_matrixcontent_teammemberinitiatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
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
  KEY `acr_sections_structureId_idx` (`structureId`),
  KEY `acr_sections_dateDeleted_idx` (`dateDeleted`),
  KEY `acr_sections_name_idx` (`name`),
  KEY `acr_sections_handle_idx` (`handle`),
  CONSTRAINT `acr_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `acr_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
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
  KEY `acr_sitegroups_dateDeleted_idx` (`dateDeleted`),
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
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

-- Dump completed on 2019-01-30 22:24:59
-- MySQL dump 10.13  Distrib 5.7.21, for osx10.13 (x86_64)
--
-- Host: localhost    Database: acrsupply
-- ------------------------------------------------------
-- Server version	5.7.21

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
INSERT INTO `acr_assets` VALUES (5,1,1,'white-logo-notag.png','image',175,60,42214,NULL,NULL,NULL,'2018-10-08 23:50:14','2018-10-08 23:50:14','2018-10-08 23:50:14','40fe6249-57c2-473b-926c-f1d52dda789f'),(9,1,1,'Oct-18-Web-Promo.jpg','image',2500,917,816039,NULL,NULL,NULL,'2018-10-24 01:14:03','2018-10-24 01:14:03','2018-10-24 01:14:03','fbb81cda-b24d-41e6-9979-902b4ac54037'),(15,1,1,'building-lights-bw.png','image',721,475,333096,NULL,NULL,NULL,'2018-12-08 01:31:52','2018-12-08 01:31:52','2018-12-08 01:31:52','32cc588c-239b-49c1-be46-bfa9cc4919e0'),(61,1,4,'slider.png','image',1440,449,481175,NULL,NULL,NULL,'2019-01-27 17:55:11','2019-01-27 17:55:02','2019-01-27 17:55:11','ddefc3c6-86aa-4229-8b24-02ccfdfe19d3'),(62,2,5,'slider.png','image',1440,449,481175,NULL,NULL,NULL,'2019-01-27 18:01:58','2019-01-27 18:01:58','2019-01-27 18:01:58','262bbd08-ee0b-41e1-85b0-6a1340786595'),(63,2,5,'DEC18-Web-Promo.jpg','image',2500,917,1163743,NULL,NULL,NULL,'2019-01-27 18:14:58','2019-01-27 18:14:58','2019-01-27 18:14:58','16560535-21f7-42a1-89da-a4f704a89bd3'),(65,2,5,'Warehouse.jpg','image',900,550,171123,NULL,NULL,NULL,'2019-01-27 18:23:01','2019-01-27 18:23:01','2019-01-27 18:23:01','05acca82-7c99-47c7-8473-ef7d48b9fc3f'),(66,2,5,'Training-Lab.jpg','image',900,550,103454,NULL,NULL,NULL,'2019-01-27 18:23:12','2019-01-27 18:23:12','2019-01-27 18:23:12','9611b3a5-d634-43b5-a831-781eb21c778a');
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
INSERT INTO `acr_content` VALUES (1,1,1,NULL,'2018-09-30 15:22:58','2018-09-30 15:22:58','126b03bb-4f6f-4da6-95e8-b516b4843e4a',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,2,1,'Test Event','2018-09-30 15:31:33','2018-09-30 15:33:39','74aaff84-3f3b-499a-951a-c06366a92336',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,3,1,NULL,'2018-10-08 23:42:03','2018-10-08 23:50:21','060089bf-8076-475b-8e9e-245ca3d656bd',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,5,1,'White Logo Notag','2018-10-08 23:50:14','2018-10-08 23:50:14','31f00bde-fe0d-4f0b-9ccc-ab9dd7e9f5b7',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,6,1,'About','2018-10-08 23:53:17','2018-10-10 23:45:28','ac503cda-7999-4a43-9f1f-388957cafa38',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(8,8,1,'Home','2018-10-10 23:42:21','2019-01-27 18:25:14','a5690118-e065-4a43-a698-b62eb7751172',NULL,NULL,NULL,'What We Do Best','As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:',NULL,NULL,'Stay Updated With ACR','Get VIP access for early announcements for all our events and sales.',NULL,NULL,NULL,NULL,NULL),(9,9,1,'Oct 18 Web Promo','2018-10-24 01:14:03','2018-10-24 01:14:03','eb104e53-b7cd-4f0a-9a36-21003be8fbb4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(10,10,1,'Sure Comfort Promotion','2018-10-24 01:14:25','2019-01-27 18:02:05','9354b2e8-a3ee-44ec-9c92-b7ffb738c852','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"url\",\"value\":\"http://s7098.pcdn.co/wp-content/uploads/2018/07/Sure-Summer-of-Fun-Flyer_HR.pdf\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(11,11,1,'New Store Hours','2018-11-02 01:21:37','2018-11-02 01:21:37','2201726b-45c2-49da-9821-a5b6ee99e732',NULL,'<strong>We have new store hours,</strong> to better serve you!','{\"ariaLabel\":null,\"customText\":\"Locations\",\"target\":\"\",\"title\":null,\"type\":\"entry\",\"value\":\"7\"}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,15,1,'Building Lights Bw','2018-12-08 01:31:48','2018-12-08 01:31:48','38690095-df00-48a9-a17e-dabcf402f0ff',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,18,1,'Mark Webster Testimonial','2018-12-30 16:13:20','2018-12-30 16:13:20','d062c3b0-d937-49c7-aae5-1811c6b1dd62',NULL,NULL,NULL,NULL,NULL,'Mark Webster','Mark Macurdy was working at a job site over the weekend (emergency call) and needed some parts to get a 600 ton chiller up for a customer. Mark called the after hours number and got Jeff. Mark said that he not only got the part for him, he dropped it off at the job site so Mark never had to stop working but he also dropped off some water for Mark as well. Mark could not say enough about the professional manner in how he handled having to come out on Sunday (102 degrees) but he went the extra step to make sure Mark was hydrated! Please recognize this young man in front of your group for going the extra mile. Troy, you know as well as anyone that parts are parts and everyone has them BUT, very few companies find people who go the extra mile. This guy will help ACR keep customers for life!',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(17,22,1,NULL,'2018-12-30 16:43:46','2019-01-02 00:46:22','4c99e85d-27f7-422c-864e-69033787cee9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://apple.com','https://google.com','https://facebook.com','North Carolina\'s leading HVAC and Refrigeration wholesale distributor.'),(19,24,1,'Locations','2019-01-02 01:08:25','2019-01-21 18:24:32','ccc5af04-fbb4-4f0e-8a10-3998c46d9e08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(20,34,1,'ACR Cares','2019-01-23 02:23:36','2019-01-23 03:05:07','0024ef52-551a-4c17-90a0-277651c6a3e5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(21,50,1,'Contact','2019-01-24 01:56:00','2019-01-24 01:56:00','2dae5592-4eb1-4164-98e9-a92c0b960a33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(22,51,1,'2019-01-23 21:00:21','2019-01-24 02:00:21','2019-01-24 02:00:21','3eb7d961-bea7-45a0-800a-f2295b1b23c1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(23,52,1,'Request E-Store Account','2019-01-24 02:30:36','2019-01-24 02:30:43','0122a429-089f-49bb-812f-bb0712210d6d',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(24,53,1,'E-Store Credit Application','2019-01-24 02:36:46','2019-01-24 02:36:47','bdd0d516-0489-4e46-b655-3f27e5f22938',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(25,54,1,'Pay Online','2019-01-24 03:20:09','2019-01-24 03:20:09','78478e50-dfc0-400b-bbdb-637db811306b',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(26,55,1,'Training and Education','2019-01-25 02:16:36','2019-01-25 02:16:36','7f7057c5-74c3-444a-bbdd-523609d234ae',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(27,56,1,'Scholarships','2019-01-25 02:27:28','2019-01-25 02:27:28','db111192-3b61-479d-93de-718338999f80',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(28,57,1,'Careers','2019-01-25 02:29:08','2019-01-25 02:29:08','93da3b90-0981-43b7-9f96-da197e9c5bef',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(29,58,1,'Associates','2019-01-25 02:30:45','2019-01-25 02:30:45','7f049576-9ede-4da5-a218-289075d52093',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(30,59,1,'The Story','2019-01-25 02:32:27','2019-01-25 02:33:02','1f12df39-d3ac-41d5-a8bf-55495b4b02f3',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(31,60,1,'About Us','2019-01-25 02:42:54','2019-01-25 02:42:54','add0639f-2329-4d53-8b4d-34ef7515b943',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(32,61,1,'Slider','2019-01-27 17:54:55','2019-01-27 17:55:11','332c8e43-39fa-4f39-8cda-2f607da2d101',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(33,62,1,'Slider','2019-01-27 18:01:51','2019-01-27 18:01:51','7e6fa1a8-de54-4bce-b989-99d33d7bdc24',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(34,63,1,'DEC18-Web-Promo','2019-01-27 18:14:58','2019-01-27 18:14:58','c935ad52-5acf-4e45-ba5c-b4e40e4473ef',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(35,64,1,'DEC18 Promotion','2019-01-27 18:15:14','2019-01-27 18:17:46','a26584c5-c6ad-40ab-a6d5-b1e4ee6f539f','{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":null}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(36,65,1,'Warehouse','2019-01-27 18:23:01','2019-01-27 18:23:01','ef17445d-ad8b-4c81-8e14-daa171af56ee',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(37,66,1,'Training-Lab','2019-01-27 18:23:12','2019-01-27 18:23:12','7111b094-1a15-4081-8054-6ed66d517860',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(38,67,1,NULL,'2019-01-27 18:29:04','2019-01-27 18:33:01','d3eba8ab-dab6-4f63-ad32-e60d03fa06f6',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Stay Updated With ACR','Get VIP access for early announcements for all our events and sales.',NULL,NULL,NULL,NULL,NULL);
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
INSERT INTO `acr_elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2018-09-30 15:22:58','2018-09-30 15:22:58',NULL,'bafa4cf8-b725-49b9-8267-677b9fab9c59'),(2,1,'Solspace\\Calendar\\Elements\\Event',1,0,'2018-09-30 15:31:33','2018-09-30 15:33:39',NULL,'569e5b0a-505a-40bf-b419-67f9af89a395'),(3,2,'craft\\elements\\GlobalSet',1,0,'2018-10-08 23:42:03','2018-10-08 23:50:21',NULL,'2fd6bbb7-140d-4547-8232-fd576b3c3b6f'),(5,3,'craft\\elements\\Asset',1,0,'2018-10-08 23:50:14','2018-10-08 23:50:14',NULL,'9388817f-ab4f-4696-a078-8dffe96a6e82'),(6,5,'craft\\elements\\Entry',1,0,'2018-10-08 23:53:17','2018-10-10 23:45:28',NULL,'ea3d0231-9ff7-49f6-ae40-fad3197a19e0'),(8,7,'craft\\elements\\Entry',1,0,'2018-10-10 23:42:21','2019-01-27 18:25:14',NULL,'0c039a82-d3ca-4200-b090-ecf9b176d8eb'),(9,3,'craft\\elements\\Asset',1,0,'2018-10-24 01:14:03','2018-10-24 01:14:03',NULL,'1b2c20af-0fdc-405c-981a-86f6c310cec6'),(10,6,'craft\\elements\\Entry',1,0,'2018-10-24 01:14:25','2019-01-27 18:02:05','2019-01-27 18:14:05','f2fbf0d0-1785-480c-81fb-d9cba2e61f8e'),(11,8,'craft\\elements\\Entry',1,0,'2018-11-02 01:21:37','2018-11-02 01:21:37',NULL,'63f7fe29-ef0e-4cf3-b23a-722f528236fb'),(12,9,'craft\\elements\\MatrixBlock',1,0,'2018-11-02 02:36:30','2019-01-27 18:25:14',NULL,'ec939812-cb63-45d3-89e5-d08617d098f8'),(13,9,'craft\\elements\\MatrixBlock',1,0,'2018-11-02 02:36:30','2019-01-27 18:25:14',NULL,'1847d4c9-ee26-42fe-b2c4-3006603d55d7'),(14,9,'craft\\elements\\MatrixBlock',1,0,'2018-11-02 02:36:30','2019-01-27 18:25:14',NULL,'486bdff8-e75e-4a72-8a7a-c1a5a07f8933'),(15,3,'craft\\elements\\Asset',1,0,'2018-12-08 01:31:48','2018-12-08 01:31:48',NULL,'657b2267-7c08-42d9-893b-160c7d952fce'),(16,10,'craft\\elements\\MatrixBlock',1,0,'2018-12-08 01:32:00','2019-01-27 18:25:14',NULL,'c48aa2c6-7d74-4d95-8384-775c0461a4cc'),(17,10,'craft\\elements\\MatrixBlock',1,0,'2018-12-08 01:32:00','2019-01-27 18:25:14',NULL,'8d9ab4ad-7111-4a69-95a9-5406a3a306bd'),(18,11,'craft\\elements\\Entry',1,0,'2018-12-30 16:13:20','2018-12-30 16:13:20',NULL,'8ac4ea2c-5e50-4a52-9732-29a277c4d09a'),(22,15,'craft\\elements\\GlobalSet',1,0,'2018-12-30 16:43:46','2019-01-02 00:46:22',NULL,'6e7b131e-ba3a-433e-9169-915f557b3867'),(24,17,'craft\\elements\\Entry',1,0,'2019-01-02 01:08:25','2019-01-21 18:24:32',NULL,'702aab3a-81a6-4ded-98f1-046c5bb252e4'),(25,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:14:24','2019-01-21 18:24:32',NULL,'4bfde363-cf68-4324-b938-2d5eff736410'),(26,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:15:08','2019-01-21 18:24:32',NULL,'8586919c-b969-4ef8-ae84-0399da245706'),(27,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'189cbd60-3615-42a8-9274-c1ed189212f2'),(28,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'b489708c-0f90-483d-af1c-5af584c085ba'),(29,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'feaa9dbd-961a-4502-87d9-ff05b4d22fe3'),(30,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'2a46a71c-f705-4d38-a204-9343ce2d3118'),(31,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'afc44762-5859-44b9-8e8d-aa1a613d787a'),(32,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'3a8e3695-8e3d-4cc1-9f4a-95e2eb0171f3'),(33,18,'craft\\elements\\MatrixBlock',1,0,'2019-01-02 01:30:33','2019-01-21 18:24:32',NULL,'4da6e408-e661-49f7-8d65-39180e33a637'),(34,20,'craft\\elements\\Entry',1,0,'2019-01-23 02:23:36','2019-01-23 03:05:07',NULL,'b6ee7d23-9459-4431-826d-6be77a390b7b'),(35,19,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 02:51:12','2019-01-23 03:05:07',NULL,'7cdd8f51-247c-42ab-ab7c-febe5d630ce3'),(36,19,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 02:51:12','2019-01-23 03:05:07',NULL,'353b1742-bea9-487d-a34c-47d3c58292c3'),(37,19,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 02:56:28','2019-01-23 03:05:07',NULL,'116a548e-4970-47c2-b0b7-bc39a9ec97c2'),(38,19,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 02:56:29','2019-01-23 03:05:07',NULL,'04203da1-d42c-479f-a91b-d219b38491f0'),(39,19,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 02:56:29','2019-01-23 03:05:07',NULL,'c93ab961-c1a9-4a66-8364-4f904a750296'),(40,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'0a8bf146-96ad-47fa-9b88-2fa6a5995324'),(41,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'0361d796-ae9f-4215-a217-f8fb8a696562'),(42,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'1ba3ee7c-93b0-4641-825c-0d6b3df819bd'),(43,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'e5161378-3c58-411c-b3bf-866bdf4b7f0d'),(44,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'9d5415ba-16f7-4148-8c8c-6ab8e9d29dd6'),(45,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'506b1cd2-758c-4ce4-9056-d60ca0876ce8'),(46,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'5695fb7f-05f1-4dfc-9d69-4a07643c59ef'),(47,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'eaed28b4-2b40-4608-a167-b71d06a24a39'),(48,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'cf783ce1-9014-4ea3-a554-5130ed25f4a8'),(49,21,'craft\\elements\\MatrixBlock',1,0,'2019-01-23 03:05:07','2019-01-23 03:05:07',NULL,'4bf73f14-b4a4-4973-bdcb-2c1769f397fe'),(50,NULL,'craft\\elements\\Entry',1,0,'2019-01-24 01:56:00','2019-01-24 01:56:00',NULL,'bc31dc5d-be67-4367-a467-3345570366bc'),(51,NULL,'Solspace\\Freeform\\Elements\\Submission',1,0,'2019-01-24 02:00:21','2019-01-24 02:00:21','2019-01-24 02:00:38','4c01c633-5972-4456-8a7d-93f2d083e96f'),(52,NULL,'craft\\elements\\Entry',1,0,'2019-01-24 02:30:36','2019-01-24 02:30:43',NULL,'cc580f4d-1579-4f73-b16e-d65d9adca1ff'),(53,NULL,'craft\\elements\\Entry',1,0,'2019-01-24 02:36:46','2019-01-24 02:36:47',NULL,'9afca978-0470-4259-a195-4c47ce30ec79'),(54,NULL,'craft\\elements\\Entry',1,0,'2019-01-24 03:20:09','2019-01-24 03:20:09',NULL,'8e7bdb01-d249-4f28-bbca-f9203b151779'),(55,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:16:36','2019-01-25 02:16:36',NULL,'ab00af6c-b028-46de-894e-c2d6b4d82806'),(56,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:27:28','2019-01-25 02:27:28',NULL,'0089ba8c-2d2d-4b69-8699-f2c9d52eb7dc'),(57,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:29:08','2019-01-25 02:29:08',NULL,'af5e2262-ef73-4dfa-a35a-e35fb1c90969'),(58,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:30:45','2019-01-25 02:30:45',NULL,'b24d04cc-d98c-4afe-a678-86fac3c5acc5'),(59,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:32:27','2019-01-25 02:33:02','2019-01-25 02:33:03','2bc2addc-32ec-4194-908c-158fece1276b'),(60,NULL,'craft\\elements\\Entry',1,0,'2019-01-25 02:42:54','2019-01-25 02:42:54',NULL,'7e5dcf42-d09f-4236-b14c-c54dd3144a2a'),(61,3,'craft\\elements\\Asset',1,0,'2019-01-27 17:54:55','2019-01-27 17:55:11',NULL,'7c8a9f49-dd5a-47f8-8209-2f9e6b8936ab'),(62,NULL,'craft\\elements\\Asset',1,0,'2019-01-27 18:01:51','2019-01-27 18:01:51',NULL,'040e433b-1eac-4c8f-965f-4904d1645239'),(63,NULL,'craft\\elements\\Asset',1,0,'2019-01-27 18:14:58','2019-01-27 18:14:58',NULL,'0d393b8a-9d1b-47d3-94cf-f9139dcc9463'),(64,6,'craft\\elements\\Entry',1,0,'2019-01-27 18:15:14','2019-01-27 18:17:46',NULL,'f8e0768e-0080-43ac-991b-fc40b8733b9d'),(65,NULL,'craft\\elements\\Asset',1,0,'2019-01-27 18:23:01','2019-01-27 18:23:01',NULL,'828b631a-35b8-40bd-97b2-3a51a6a9e2e3'),(66,NULL,'craft\\elements\\Asset',1,0,'2019-01-27 18:23:12','2019-01-27 18:23:12',NULL,'90b70428-25ee-4586-bcc1-bfaf89607338'),(67,22,'craft\\elements\\GlobalSet',1,0,'2019-01-27 18:29:04','2019-01-27 18:33:01',NULL,'b4388c1c-535d-4c91-ba62-3de564eb8eff');
/*!40000 ALTER TABLE `acr_elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_elements_sites`
--

LOCK TABLES `acr_elements_sites` WRITE;
/*!40000 ALTER TABLE `acr_elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2018-09-30 15:22:58','2018-09-30 15:22:58','8bbc4622-8196-4e56-80a4-a968526be9c4'),(2,2,1,'test-event',NULL,1,'2018-09-30 15:31:33','2018-09-30 15:33:39','36992236-7e84-445f-8f47-d24ac6767d8d'),(3,3,1,NULL,NULL,1,'2018-10-08 23:42:03','2018-10-08 23:50:21','b34f533a-cce7-4c3f-aecf-8a8555a4a032'),(5,5,1,NULL,NULL,1,'2018-10-08 23:50:14','2018-10-08 23:50:14','cfdc4b8a-4174-4898-a0ce-d7274acf217a'),(6,6,1,'about','about',1,'2018-10-08 23:53:17','2018-10-10 23:45:28','ce44c268-1787-4211-b206-c6acb1e3dc59'),(8,8,1,'home','__home__',1,'2018-10-10 23:42:21','2019-01-27 18:25:14','388e0d47-87cb-417d-a9a6-75dc7f882fb5'),(9,9,1,NULL,NULL,1,'2018-10-24 01:14:03','2018-10-24 01:14:03','8efe39ca-9a51-4a8b-96a7-d933d42a8810'),(10,10,1,'sure-comfort-promotion','promotions/sure-comfort-promotion',1,'2018-10-24 01:14:25','2019-01-27 18:02:05','98e425f7-6dd3-4590-848a-e444ea5bc4fa'),(11,11,1,'new-store-hours','notifications/new-store-hours',1,'2018-11-02 01:21:37','2018-11-02 01:21:37','a95463ed-db16-45db-b65a-f57f420bb9e6'),(12,12,1,NULL,NULL,1,'2018-11-02 02:36:30','2019-01-27 18:25:14','a840a50c-1706-4f56-8d5a-8a134630e409'),(13,13,1,NULL,NULL,1,'2018-11-02 02:36:30','2019-01-27 18:25:14','2adcaa2c-67ef-4aad-9ab4-9d4602782f8d'),(14,14,1,NULL,NULL,1,'2018-11-02 02:36:30','2019-01-27 18:25:14','3e256002-a1b9-4df1-a656-c0b45093bd97'),(15,15,1,NULL,NULL,1,'2018-12-08 01:31:48','2018-12-08 01:31:48','3e092c46-e383-42e5-9b65-c1bb87e70a65'),(16,16,1,NULL,NULL,1,'2018-12-08 01:32:00','2019-01-27 18:25:14','ecd29ad5-20ab-49f9-805f-0ca2c1f2a81b'),(17,17,1,NULL,NULL,1,'2018-12-08 01:32:00','2019-01-27 18:25:14','4e1b460a-6a2c-49e5-9d9b-ba283e7c1cab'),(18,18,1,'mark-webster-testimonial','testimonials/mark-webster-testimonial',1,'2018-12-30 16:13:20','2018-12-30 16:13:20','bd10e5fc-21ea-40f9-9813-d67ff6d8267d'),(22,22,1,NULL,NULL,1,'2018-12-30 16:43:46','2019-01-02 00:46:22','dc85844b-343f-4182-854b-c4448b9f2670'),(24,24,1,'locations','locations',1,'2019-01-02 01:08:25','2019-01-21 18:24:32','66e9017d-d106-4f4a-956f-e322fc01b1fb'),(25,25,1,NULL,NULL,1,'2019-01-02 01:14:24','2019-01-21 18:24:32','fe130109-2ad6-46f4-b776-1b89d4a0f4fb'),(26,26,1,NULL,NULL,1,'2019-01-02 01:15:08','2019-01-21 18:24:32','f0bb3f17-d74b-48b0-8d07-87e3bf2fd868'),(27,27,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','e2117512-1871-4a77-a548-b6a86f0db300'),(28,28,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','e346fd94-fcaf-42e4-b75b-5868bbaf5ae3'),(29,29,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','304b9916-3f26-44c0-9042-17f79d3e46e1'),(30,30,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','376bb6d7-147c-4465-bde2-f8a06f13de8d'),(31,31,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','ae06855e-2dc3-471b-83af-a22ed5aaf0c0'),(32,32,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','7061c9f9-96a2-40f8-889f-f1d0ef4f639e'),(33,33,1,NULL,NULL,1,'2019-01-02 01:30:33','2019-01-21 18:24:32','184c8bff-a14c-44d6-8db9-c72f3ff6255d'),(34,34,1,'acr-cares','acr-cares',1,'2019-01-23 02:23:36','2019-01-23 03:05:07','f8e9985e-83f1-4187-93c5-4631b622aa7f'),(35,35,1,NULL,NULL,1,'2019-01-23 02:51:12','2019-01-23 03:05:07','be7d53c6-420c-4763-a3af-2d227f2662da'),(36,36,1,NULL,NULL,1,'2019-01-23 02:51:12','2019-01-23 03:05:07','9d19c43c-0a48-474c-829e-0e09c6d55fa6'),(37,37,1,NULL,NULL,1,'2019-01-23 02:56:28','2019-01-23 03:05:07','3c9dc43e-98d1-4354-9cfc-56cfe940477a'),(38,38,1,NULL,NULL,1,'2019-01-23 02:56:29','2019-01-23 03:05:07','13b0a491-b635-4ff8-83a7-4a2c95108c6d'),(39,39,1,NULL,NULL,1,'2019-01-23 02:56:29','2019-01-23 03:05:07','2c290840-f5b6-405c-a198-4b55c883a466'),(40,40,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','e5e33e9a-5f1a-4388-b7fd-4d830042d80f'),(41,41,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','53347df3-540a-4040-8071-810396c50b4e'),(42,42,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','e627d22c-1e1c-4c38-b5ad-f84a167a4136'),(43,43,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','7ee706be-cf8d-4a95-932c-fb1a226aeaf1'),(44,44,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','8a5e381c-1429-4750-afd0-5127f17c155f'),(45,45,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','d5ca4fc3-154f-485c-b5d7-a734947797e4'),(46,46,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','42da810d-7d84-458a-a270-259707733164'),(47,47,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','4838d8a2-d8af-4165-ae27-53318644c3c4'),(48,48,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','2cd2af72-6ae1-4805-af8f-c85dcf43d1a2'),(49,49,1,NULL,NULL,1,'2019-01-23 03:05:07','2019-01-23 03:05:07','e4651b3d-ed0b-45e3-a9a4-10b778454d55'),(50,50,1,'contact','contact',1,'2019-01-24 01:56:00','2019-01-24 01:56:00','cc94f76c-2e9e-4cb9-a65c-d4f048e77bac'),(51,51,1,NULL,NULL,1,'2019-01-24 02:00:21','2019-01-24 02:00:21','198dcbc3-b162-43d7-a3b8-babfe49016b9'),(52,52,1,'request-e-store-account','request-e-store-account',1,'2019-01-24 02:30:36','2019-01-24 02:30:43','64d679f2-03ca-472b-b05d-98a0614f5314'),(53,53,1,'e-store-credit-application','estore-credit-application',1,'2019-01-24 02:36:46','2019-01-24 02:36:47','1d335c4a-bc14-4e33-9b69-0ac586a813cb'),(54,54,1,'pay-online','pay-online',1,'2019-01-24 03:20:09','2019-01-24 03:20:09','36541050-1264-4afa-8b27-d1e5cc9f676e'),(55,55,1,'training-and-education','training-and-education',1,'2019-01-25 02:16:36','2019-01-25 02:16:36','9d3d7c68-e4c2-4aca-a11e-b7e18e96208b'),(56,56,1,'scholarships','scholarships',1,'2019-01-25 02:27:28','2019-01-25 02:27:28','130e8730-c025-4f8e-a3be-699713b5a3bc'),(57,57,1,'careers','careers',1,'2019-01-25 02:29:08','2019-01-25 02:29:08','f00f63e3-6d35-47e6-a277-a9d26355119e'),(58,58,1,'associates','associates',1,'2019-01-25 02:30:45','2019-01-25 02:30:45','9e648024-5a5e-4960-ae35-2f862e8f2921'),(59,59,1,'the-story','the-story',1,'2019-01-25 02:32:27','2019-01-25 02:33:02','339734ac-ea58-4b26-80e1-1096e00c28ac'),(60,60,1,'about-us','pages/about-us',1,'2019-01-25 02:42:54','2019-01-25 02:42:54','f122838f-6c4f-4f5a-a2de-bcb02e69050d'),(61,61,1,NULL,NULL,1,'2019-01-27 17:54:55','2019-01-27 17:55:11','eba08130-c4a3-4b1b-8101-1e29dd486903'),(62,62,1,NULL,NULL,1,'2019-01-27 18:01:51','2019-01-27 18:01:51','81d7c632-a0e7-4885-91a7-e13335eb1f28'),(63,63,1,NULL,NULL,1,'2019-01-27 18:14:58','2019-01-27 18:14:58','ba16f177-b175-45cf-b3bb-9bd05c9fcd42'),(64,64,1,'dec18-promotion','promotions/dec18-promotion',1,'2019-01-27 18:15:14','2019-01-27 18:17:46','2d863177-8ee0-43ad-b7f4-977f757a2c9a'),(65,65,1,NULL,NULL,1,'2019-01-27 18:23:01','2019-01-27 18:23:01','08f769df-08d5-4b8b-b48a-3922ab9622ba'),(66,66,1,NULL,NULL,1,'2019-01-27 18:23:12','2019-01-27 18:23:12','fba7b1f6-c05b-4080-95b4-810cd427dddb'),(67,67,1,NULL,NULL,1,'2019-01-27 18:29:04','2019-01-27 18:33:01','8a769fce-d900-4d19-a3d3-916a1ecfc89f');
/*!40000 ALTER TABLE `acr_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_entries`
--

LOCK TABLES `acr_entries` WRITE;
/*!40000 ALTER TABLE `acr_entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_entries` VALUES (6,2,NULL,2,NULL,'2018-10-08 23:53:00',NULL,NULL,'2018-10-08 23:53:17','2018-10-10 23:45:28','40261008-ec5f-4819-8096-eb7a5e85d82b'),(8,4,NULL,4,NULL,'2018-10-10 23:42:00',NULL,NULL,'2018-10-10 23:42:21','2019-01-27 18:25:14','eaaf27c6-41c3-49f2-8999-458fe83541d4'),(10,3,NULL,3,1,'2018-10-24 01:14:00',NULL,0,'2018-10-24 01:14:25','2019-01-27 18:02:05','3d540864-6415-4308-9d96-9b8c0bd6c7d8'),(11,5,NULL,5,1,'2018-11-02 01:21:00',NULL,NULL,'2018-11-02 01:21:37','2018-11-02 01:21:37','7d3688ad-8e1d-4e97-b4b8-0cd23648b462'),(18,6,NULL,6,1,'2018-12-30 16:13:00',NULL,NULL,'2018-12-30 16:13:20','2018-12-30 16:13:20','146641be-52f5-4381-aef4-a32d03d44b0f'),(24,8,NULL,8,NULL,'2019-01-02 01:08:00',NULL,NULL,'2019-01-02 01:08:25','2019-01-21 18:24:32','b0c38622-6d9f-4f5f-a88c-3f4910fe1449'),(34,9,NULL,9,NULL,'2019-01-23 02:23:00',NULL,NULL,'2019-01-23 02:23:36','2019-01-23 03:05:07','37f84c46-1032-4b5b-b0e0-d99f4b44784d'),(50,10,NULL,10,NULL,'2019-01-24 01:56:00',NULL,NULL,'2019-01-24 01:56:00','2019-01-24 01:56:00','f0973a1e-47f5-443f-8304-f9e0c4d0ce46'),(52,11,NULL,11,NULL,'2019-01-24 02:30:00',NULL,NULL,'2019-01-24 02:30:36','2019-01-24 02:30:43','1cf1b7e9-058c-4af0-afa5-fca1e9703520'),(53,12,NULL,12,NULL,'2019-01-24 02:36:00',NULL,NULL,'2019-01-24 02:36:46','2019-01-24 02:36:47','c62457ad-e00c-4f61-a435-ada84d913eac'),(54,13,NULL,13,NULL,'2019-01-24 03:20:00',NULL,NULL,'2019-01-24 03:20:09','2019-01-24 03:20:09','0521fc8b-8bfd-4f06-aafb-7080c645636a'),(55,14,NULL,14,NULL,'2019-01-25 02:16:00',NULL,NULL,'2019-01-25 02:16:36','2019-01-25 02:16:36','b6524440-8d7b-4606-94d8-c005d481b4b7'),(56,15,NULL,15,NULL,'2019-01-25 02:27:00',NULL,NULL,'2019-01-25 02:27:28','2019-01-25 02:27:28','b31b060b-8eab-41ae-9098-28c4b4ea74fb'),(57,16,NULL,16,NULL,'2019-01-25 02:29:00',NULL,NULL,'2019-01-25 02:29:08','2019-01-25 02:29:08','9be6058c-d024-4618-9776-706433fcedf8'),(58,17,NULL,17,NULL,'2019-01-25 02:30:00',NULL,NULL,'2019-01-25 02:30:45','2019-01-25 02:30:45','ec16de7a-ecd1-4ebe-ae6b-7106e8d3db76'),(59,18,NULL,18,NULL,'2019-01-25 02:32:00',NULL,1,'2019-01-25 02:32:27','2019-01-25 02:33:02','e34cdadc-63f9-402c-993f-18508e2617a8'),(60,19,NULL,19,1,'2019-01-25 02:42:00',NULL,NULL,'2019-01-25 02:42:54','2019-01-25 02:42:54','7fdefda0-e334-416e-97a6-682e20934a14'),(64,3,NULL,3,1,'2019-01-27 18:15:00',NULL,NULL,'2019-01-27 18:15:14','2019-01-27 18:17:46','1493351e-9ede-4f4c-a0f2-6697972c263c');
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
INSERT INTO `acr_entrytypes` VALUES (2,2,5,'About','about',1,'Page Title',NULL,1,'2018-10-08 23:53:17','2018-10-10 23:45:28',NULL,'3763008a-e976-465a-b92f-9309836c9be0'),(3,3,6,'Promotions','promotions',1,'Title','',1,'2018-10-09 00:13:24','2019-01-27 18:17:45',NULL,'b4a92b05-e940-4b60-b063-e03b8e8ed290'),(4,4,7,'Home','home',0,NULL,'{section.name|raw}',1,'2018-10-10 23:42:21','2018-12-30 16:32:20',NULL,'89e916b0-48ff-4c47-b285-bea42a6de1eb'),(5,5,8,'Notifications','notifications',1,'Title',NULL,1,'2018-11-02 01:16:09','2018-11-02 01:20:46',NULL,'cc5c88c2-6256-43b6-accc-6866de536e42'),(6,6,11,'Testimonials','testimonials',1,'Title',NULL,1,'2018-12-17 01:13:58','2018-12-30 16:10:48',NULL,'4aecf25f-7fd2-4fac-86f9-571abb544b3b'),(8,8,17,'Locations','locations',0,NULL,'{section.name|raw}',1,'2019-01-02 01:08:25','2019-01-02 01:15:39',NULL,'6158f0a0-0d2b-4e2c-a79e-ae3ae8ef5498'),(9,9,20,'ACR Cares','acrCares',0,'','{section.name|raw}',1,'2019-01-23 02:23:36','2019-01-23 03:04:05',NULL,'43601a53-dddf-44fd-96ff-e5034fe169d1'),(10,10,NULL,'Contact','contact',0,NULL,'{section.name|raw}',1,'2019-01-24 01:56:00','2019-01-24 01:56:00',NULL,'6ce85c89-9cc3-4180-9af7-0f2109ab5dde'),(11,11,NULL,'Request E-Store Account','eStore',0,NULL,'{section.name|raw}',1,'2019-01-24 02:30:36','2019-01-24 02:30:42',NULL,'2228d5f0-f6f0-4be9-af9b-b14f7c9a65ff'),(12,12,NULL,'E-Store Credit Application','eStoreCreditApplication',1,'Title',NULL,1,'2019-01-24 02:35:59','2019-01-24 02:35:59',NULL,'e0180887-e30e-4628-aa32-08b1842ee5f0'),(13,13,NULL,'Pay Online','payOnline',0,NULL,'{section.name|raw}',1,'2019-01-24 03:20:09','2019-01-24 03:20:09',NULL,'2cc1817d-2570-4954-a8aa-b57c5e5eeda1'),(14,14,NULL,'Training and Education','trainingAndEducation',0,NULL,'{section.name|raw}',1,'2019-01-25 02:16:36','2019-01-25 02:16:36',NULL,'78c5241d-877a-4e91-8ac5-836bb161279b'),(15,15,NULL,'Scholarships','scholarships',0,NULL,'{section.name|raw}',1,'2019-01-25 02:27:28','2019-01-25 02:27:28',NULL,'ff374fa6-3141-4a64-be08-6fcae035a8fe'),(16,16,NULL,'Careers','careers',0,NULL,'{section.name|raw}',1,'2019-01-25 02:29:08','2019-01-25 02:29:08',NULL,'d28af146-9297-4753-8222-0708a5cbf5aa'),(17,17,NULL,'Associates','associates',0,NULL,'{section.name|raw}',1,'2019-01-25 02:30:45','2019-01-25 02:30:45',NULL,'47bb783e-b48b-4ed6-9e79-b1a308939085'),(18,18,NULL,'The Story','theStory',0,NULL,'{section.name|raw}',1,'2019-01-25 02:32:27','2019-01-25 02:32:27','2019-01-25 02:33:03','77af3a61-c5e8-4d48-ac1f-25ebe9c9c254'),(19,19,NULL,'Pages','pages',1,'Title',NULL,1,'2019-01-25 02:42:26','2019-01-25 02:42:26',NULL,'6fcb7060-ebde-4e32-963e-b9a094be6ab7');
/*!40000 ALTER TABLE `acr_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_entryversions`
--

LOCK TABLES `acr_entryversions` WRITE;
/*!40000 ALTER TABLE `acr_entryversions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_entryversions` VALUES (2,10,3,1,1,1,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Sure Comfort Promotion\",\"slug\":\"sure-comfort-promotion\",\"postDate\":1540343640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"ariaLabel\":\"\",\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"url\",\"value\":\"http://s7098.pcdn.co/wp-content/uploads/2018/07/Sure-Summer-of-Fun-Flyer_HR.pdf\"},\"2\":[\"9\"]}}','2018-10-24 01:14:25','2018-10-24 01:14:25','b8075956-795c-41bc-94d1-dc1de0702c15'),(3,11,5,1,1,1,'','{\"typeId\":\"5\",\"authorId\":\"1\",\"title\":\"New Store Hours\",\"slug\":\"new-store-hours\",\"postDate\":1541121660,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"7\":{\"ariaLabel\":null,\"customText\":\"Locations\",\"target\":\"\",\"title\":null,\"type\":\"entry\",\"value\":\"7\"},\"6\":\"<strong>We have new store hours,</strong> to better serve you!\"}}','2018-11-02 01:21:37','2018-11-02 01:21:37','206d16fb-2666-4ac7-ac07-2c16e732e2b2'),(4,8,4,1,1,1,'Revision from Nov 1, 2018, 10:25:33 PM','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":[]}','2018-11-02 02:25:49','2018-11-02 02:25:49','b66f1d67-34b8-411e-b7c9-2b650d2b6f9c'),(5,8,4,1,1,2,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"9\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"8\":\"What We Do Best\"}}','2018-11-02 02:25:49','2018-11-02 02:25:49','0682cc06-6b66-46f5-a744-53b97273953c'),(6,8,4,1,1,3,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"10\":\"What We Do Best\"}}','2018-11-02 02:28:42','2018-11-02 02:28:42','9fb60083-44d9-472b-8bb7-532381109cac'),(7,8,4,1,1,4,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"10\":\"What We Do Best\"}}','2018-11-02 02:36:30','2018-11-02 02:36:30','c2095489-a14f-477c-ac02-6959c05f3a09'),(8,8,4,1,1,5,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"description\":\"Explore our catalog of products\",\"image\":[\"15\"]}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"description\":\"Quickly request an account to shop with us\",\"image\":[\"15\"]}}},\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"10\":\"What We Do Best\"}}','2018-12-08 01:32:00','2018-12-08 01:32:00','2faac918-7023-4f34-ba02-34ec74fccac8'),(9,8,4,1,1,6,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"description\":\"Explore our catalog of products\",\"image\":[\"15\"],\"backgroundColor\":\"#c22c25\"}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"description\":\"Quickly request an account to shop with us\",\"image\":[\"15\"],\"backgroundColor\":\"#276aa6\"}}},\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"10\":\"What We Do Best\"}}','2018-12-08 01:33:03','2018-12-08 01:33:03','c82bce89-4db9-4046-ac79-812ede3203ad'),(10,8,4,1,1,7,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"callToActionDescription\":\"Explore our catalog of products\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"#c22c25\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"callToActionDescription\":\"Quickly request an account to shop with us\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"#276aa6\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"10\":\"What We Do Best\"}}','2018-12-08 01:45:29','2018-12-08 01:45:29','ef5a78c8-da19-4ce9-9df8-fb6af1ee0cfe'),(11,8,4,1,1,8,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"callToActionDescription\":\"Explore our catalog of products\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"red\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"callToActionDescription\":\"Quickly request an account to shop with us\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"blue\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"10\":\"What We Do Best\"}}','2018-12-08 01:55:56','2018-12-08 01:55:56','e98aed21-2ec9-4920-b5bd-460b46b61c46'),(12,18,6,1,1,1,'','{\"typeId\":\"6\",\"authorId\":\"1\",\"title\":\"Mark Webster Testimonial\",\"slug\":\"mark-webster-testimonial\",\"postDate\":1546186380,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"23\":\"Mark Webster\",\"24\":\"Mark Macurdy was working at a job site over the weekend (emergency call) and needed some parts to get a 600 ton chiller up for a customer. Mark called the after hours number and got Jeff. Mark said that he not only got the part for him, he dropped it off at the job site so Mark never had to stop working but he also dropped off some water for Mark as well. Mark could not say enough about the professional manner in how he handled having to come out on Sunday (102 degrees) but he went the extra step to make sure Mark was hydrated! Please recognize this young man in front of your group for going the extra mile. Troy, you know as well as anyone that parts are parts and everyone has them BUT, very few companies find people who go the extra mile. This guy will help ACR keep customers for life!\"}}','2018-12-30 16:13:20','2018-12-30 16:13:20','3675ffb4-5185-4d12-87dc-1204be3e8f60'),(13,8,4,1,1,9,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"callToActionDescription\":\"Explore our catalog of products\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"red\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"callToActionDescription\":\"Quickly request an account to shop with us\",\"callToActionImage\":[\"15\"],\"callToActionBackgroundColor\":\"blue\",\"callToActionLink\":{\"ariaLabel\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"27\":\"Get VIP access for early announcements for all our events and sales.\",\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"25\":[\"15\"],\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"10\"}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"7\"}}}},\"26\":\"Stay Updated With ACR\",\"10\":\"What We Do Best\"}}','2018-12-30 16:33:13','2018-12-30 16:33:13','10ce871b-3acd-4548-91f5-1a9f6a704993'),(14,24,8,1,1,1,'Revision from Jan 1, 2019, 8:12:18 PM','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"34\":[]}}','2019-01-02 01:12:52','2019-01-02 01:12:52','16b72151-ce33-4a64-bb3b-64c57acc50f8'),(15,24,8,1,1,2,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd. Burlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}}}}}','2019-01-02 01:14:24','2019-01-02 01:14:24','078c58e3-f97e-4c8c-b327-56a577008efa'),(16,24,8,1,1,3,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd. Burlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St. Carrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\"}}}}}','2019-01-02 01:15:08','2019-01-02 01:15:08','fcc55863-18a0-435a-bf81-c1c6a70368cf'),(17,24,8,1,1,4,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd.<br>Burlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St.<br>Carrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\"}}}}}','2019-01-02 01:24:02','2019-01-02 01:24:02','7e4bd32f-98eb-475e-a913-d60005be2b6a'),(18,24,8,1,1,5,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd. \\\\nBurlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St. \\\\nCarrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\"}}}}}','2019-01-02 01:25:49','2019-01-02 01:25:49','d4ababd2-c829-4db0-80b8-30b541ebd9eb'),(19,24,8,1,1,6,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd.\\nBurlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St.\\nCarrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\"}}}}}','2019-01-02 01:27:55','2019-01-02 01:27:55','32ff1f38-5763-4dda-9c49-7a7036b5dd45'),(20,24,8,1,1,7,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd.\\nBurlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St.\\nCarrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\"}},\"27\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Durham\",\"address\":\"2719 Hillsborough Rd.\\nDurham, NC 27705\",\"phoneNumber\":\"(919) 286 - 2228\"}},\"28\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Greensboro\",\"address\":\"2201 Binford St.\\nGreensboro, NC 27407\",\"phoneNumber\":\"(336) 854 - 5800\"}},\"29\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Raleigh\",\"address\":\"2416 Alwin Ct.\\nRaleigh, NC 27604\",\"phoneNumber\":\"(919) 861 - 2277\"}},\"30\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Wilmington\",\"address\":\"3207 Burnt Mill Dr.\\nWilmington, NC 28403\",\"phoneNumber\":\"(910) 442 - 3303\"}},\"31\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Winston-Salem\",\"address\":\"1735 Link Rd.\\nWinston-Salem, NC 27103\",\"phoneNumber\":\"(336) 831 - 0505\"}},\"32\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Winterville\",\"address\":\"4125 Bayswater Rd.\\nWinterville, NC 28590\",\"phoneNumber\":\"(252) 754 - 2653\"}},\"33\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Central Services\",\"address\":\"4040 S. Alston Ave.\\nDurham, NC 27713\",\"phoneNumber\":\"(919) 765 - 8081\"}}}}}','2019-01-02 01:30:33','2019-01-02 01:30:33','6434c97a-0ecd-4f50-bcdf-6ed64b4b67da'),(21,24,8,1,1,8,'','{\"typeId\":\"8\",\"authorId\":null,\"title\":\"Locations\",\"slug\":\"locations\",\"postDate\":1546391280,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"34\":{\"25\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Burlington\",\"address\":\"2352 W Hanford Rd.\\nBurlington, NC 27215\",\"phoneNumber\":\"(336) 227 - 5000\",\"googleMapLink\":\"https://goo.gl/maps/3EGEq92J2t72\"}},\"26\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Carrboro\",\"address\":\"101 Barnes St.\\nCarrboro, NC 27510\",\"phoneNumber\":\"(919) 929 - 2099\",\"googleMapLink\":\"https://goo.gl/maps/PrdhT1bGbgm\"}},\"27\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Durham\",\"address\":\"2719 Hillsborough Rd.\\nDurham, NC 27705\",\"phoneNumber\":\"(919) 286 - 2228\",\"googleMapLink\":\"https://goo.gl/maps/2KLv6FA1XYJ2\"}},\"28\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Greensboro\",\"address\":\"2201 Binford St.\\nGreensboro, NC 27407\",\"phoneNumber\":\"(336) 854 - 5800\",\"googleMapLink\":\"https://goo.gl/maps/QyVYuMKfoXy\"}},\"29\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Raleigh\",\"address\":\"2416 Alwin Ct.\\nRaleigh, NC 27604\",\"phoneNumber\":\"(919) 861 - 2277\",\"googleMapLink\":\"https://goo.gl/maps/9EeSxoVCQut\"}},\"30\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Wilmington\",\"address\":\"3207 Burnt Mill Dr.\\nWilmington, NC 28403\",\"phoneNumber\":\"(910) 442 - 3303\",\"googleMapLink\":\"https://goo.gl/maps/gQgGihH59uT2\"}},\"31\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Winston-Salem\",\"address\":\"1735 Link Rd.\\nWinston-Salem, NC 27103\",\"phoneNumber\":\"(336) 831 - 0505\",\"googleMapLink\":\"https://goo.gl/maps/zR6HSX5wqmK2\"}},\"32\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Winterville\",\"address\":\"4125 Bayswater Rd.\\nWinterville, NC 28590\",\"phoneNumber\":\"(252) 754 - 2653\",\"googleMapLink\":\"https://goo.gl/maps/Ux9UmLTbdsB2\"}},\"33\":{\"type\":\"storeLocation\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"locationName\":\"Central Services\",\"address\":\"4040 S. Alston Ave.\\nDurham, NC 27713\",\"phoneNumber\":\"(919) 765 - 8081\",\"googleMapLink\":\"https://goo.gl/maps/Rmo31C2wPC92\"}}}}}','2019-01-21 18:24:32','2019-01-21 18:24:32','9c70cc7a-7c74-412d-98be-95af9b8538a7'),(22,34,9,1,1,1,'Revision from Jan 22, 2019, 9:50:36 PM','{\"typeId\":\"9\",\"authorId\":null,\"title\":\"ACR Cares\",\"slug\":\"acr-cares\",\"postDate\":1548210180,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"39\":[]}}','2019-01-23 02:51:12','2019-01-23 02:51:12','960b7f36-6538-4446-822a-0af5f5d6c48b'),(23,34,9,1,1,2,'','{\"typeId\":\"9\",\"authorId\":null,\"title\":\"ACR Cares\",\"slug\":\"acr-cares\",\"postDate\":1548210180,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"39\":{\"35\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Roc Solid Foundations\",\"initiativeDescription\":\"Roc Solid Foundation® builds hope for children battling cancer and their families by offering opportunities for them to do what they do best – play. Roc Solid partners with local groups to build playsets and remodel the rooms of children battling cancer. ACR Cares will be building a playset with Roc Solid October 2018.\"}},\"36\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Ronald McDonald House\",\"initiativeDescription\":\"Providing stability and resources for families everywhere. ACR Cares partners with the local Ronald McDonald House’s to cook meals, provide gifts and needed materials at Christmas time, and sponsors a family every Christmas.\"}}}}}','2019-01-23 02:51:12','2019-01-23 02:51:12','7a3d609c-81eb-4f78-96e5-f9919e4b81a4'),(24,34,9,1,1,3,'','{\"typeId\":\"9\",\"authorId\":null,\"title\":\"ACR Cares\",\"slug\":\"acr-cares\",\"postDate\":1548210180,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"39\":{\"35\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Roc Solid Foundations\",\"initiativeDescription\":\"Roc Solid Foundation® builds hope for children battling cancer and their families by offering opportunities for them to do what they do best – play. Roc Solid partners with local groups to build playsets and remodel the rooms of children battling cancer. ACR Cares will be building a playset with Roc Solid October 2018.\"}},\"36\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Ronald McDonald House\",\"initiativeDescription\":\"Providing stability and resources for families everywhere. ACR Cares partners with the local Ronald McDonald House’s to cook meals, provide gifts and needed materials at Christmas time, and sponsors a family every Christmas.\"}},\"37\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Operation Resolute\",\"initiativeDescription\":\"Operation Resolute® is a non-profit organization based in North Carolina that is dedicated to sustaining and strengthening families within the US Armed Forces by serving with and working through military chaplains. By partnering with chaplains, Operation Resolute® works within the parameters of the US military while adorning the Gospel by being salt and light. ACR Cares partners with Operation Resolute by hosting Daddy Daughter dances, spouse retreats, and other events.\"}},\"38\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Burkina Faso\",\"initiativeDescription\":\"ACR Cares is currently building an Orphanage in the country of Burkina Faso.\"}},\"39\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeImage\":[],\"initiativeTitle\":\"Human Coalition\",\"initiativeDescription\":\"Human Coalition is a group dedicated to helping women at risk of having an abortion see the beauty of choosing life. ACR Cares takes part in the annual  fundraising event, 4000 Steps.\"}}}}}','2019-01-23 02:56:29','2019-01-23 02:56:29','5b73c17f-9ada-4bec-9ede-6f8492b95dc3'),(25,34,9,1,1,4,'','{\"typeId\":\"9\",\"authorId\":null,\"title\":\"ACR Cares\",\"slug\":\"acr-cares\",\"postDate\":1548210180,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"39\":{\"35\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Roc Solid Foundations\",\"initiativeDescription\":\"Roc Solid Foundation® builds hope for children battling cancer and their families by offering opportunities for them to do what they do best – play. Roc Solid partners with local groups to build playsets and remodel the rooms of children battling cancer. ACR Cares will be building a playset with Roc Solid October 2018.\"}},\"36\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Ronald McDonald House\",\"initiativeDescription\":\"Providing stability and resources for families everywhere. ACR Cares partners with the local Ronald McDonald House’s to cook meals, provide gifts and needed materials at Christmas time, and sponsors a family every Christmas.\"}},\"37\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Operation Resolute\",\"initiativeDescription\":\"Operation Resolute® is a non-profit organization based in North Carolina that is dedicated to sustaining and strengthening families within the US Armed Forces by serving with and working through military chaplains. By partnering with chaplains, Operation Resolute® works within the parameters of the US military while adorning the Gospel by being salt and light. ACR Cares partners with Operation Resolute by hosting Daddy Daughter dances, spouse retreats, and other events.\"}},\"38\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Burkina Faso\",\"initiativeDescription\":\"ACR Cares is currently building an Orphanage in the country of Burkina Faso.\"}},\"39\":{\"type\":\"initiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Human Coalition\",\"initiativeDescription\":\"Human Coalition is a group dedicated to helping women at risk of having an abortion see the beauty of choosing life. ACR Cares takes part in the annual  fundraising event, 4000 Steps.\"}}},\"43\":{\"40\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Annual Scholarship to our team members’ children\"}},\"41\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Benevolence fund for team members going through difficult times\"}},\"42\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Corporate Chaplains\"}},\"43\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Ministry pamphlets in all our locations\"}},\"44\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Annual Awards Banquet\"}},\"45\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Annual Family Fun Day\"}},\"46\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Marriage Retreats for team members and their spouses\"}},\"47\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Volunteer Policy\"}},\"48\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Mission Trip Policy\"}},\"49\":{\"type\":\"teamInitiative\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"initiativeTitle\":\"Disaster Relief Policy\"}}}}}','2019-01-23 03:05:07','2019-01-23 03:05:07','565628c8-185e-449c-9648-742381bb94b9'),(26,60,19,1,1,1,'','{\"typeId\":\"19\",\"authorId\":\"1\",\"title\":\"About Us\",\"slug\":\"about-us\",\"postDate\":1548384120,\"expiryDate\":null,\"enabled\":true,\"newParentId\":\"\",\"fields\":[]}','2019-01-25 02:42:54','2019-01-25 02:42:54','78be6c73-1f84-4fbb-834f-c673f24a5817'),(27,10,3,1,1,2,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Sure Comfort Promotion\",\"slug\":\"sure-comfort-promotion\",\"postDate\":1540343640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"url\",\"value\":\"http://s7098.pcdn.co/wp-content/uploads/2018/07/Sure-Summer-of-Fun-Flyer_HR.pdf\"},\"2\":[\"61\"]}}','2019-01-27 17:55:11','2019-01-27 17:55:11','febdc7fd-4b73-4e71-9741-66d00f7108fb'),(28,10,3,1,1,3,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Sure Comfort Promotion\",\"slug\":\"sure-comfort-promotion\",\"postDate\":1540343640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"url\",\"value\":\"http://s7098.pcdn.co/wp-content/uploads/2018/07/Sure-Summer-of-Fun-Flyer_HR.pdf\"},\"45\":[\"62\"]}}','2019-01-27 18:02:05','2019-01-27 18:02:05','249724e7-006c-417f-8860-c15996be6c00'),(29,64,3,1,1,1,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"DEC18 Promotion\",\"slug\":\"dec18-promotion\",\"postDate\":1548612900,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":{\"ariaLabel\":\"\",\"customQuery\":null,\"customText\":\"\",\"target\":\"\",\"title\":\"\",\"type\":\"entry\",\"value\":null},\"45\":[\"63\"]}}','2019-01-27 18:15:14','2019-01-27 18:15:14','c9a55d13-5775-4776-b53e-f3d417395845'),(30,8,4,1,1,10,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"callToActionDescription\":\"Explore our catalog of products\",\"callToActionImage\":[\"65\"],\"callToActionBackgroundColor\":\"red\",\"callToActionLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"callToActionDescription\":\"Quickly request an account to shop with us\",\"callToActionImage\":[\"66\"],\"callToActionBackgroundColor\":\"blue\",\"callToActionLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}}}},\"27\":\"Get VIP access for early announcements for all our events and sales.\",\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"25\":[\"15\"],\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}}}},\"26\":\"Stay Updated With ACR\",\"10\":\"What We Do Best\"}}','2019-01-27 18:23:14','2019-01-27 18:23:14','d3f0696e-c773-4db2-8d53-25c318c773ec'),(31,8,4,1,1,11,'','{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Home\",\"slug\":\"home\",\"postDate\":1539214920,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"16\":{\"16\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Shop Online\",\"callToActionDescription\":\"Explore our catalog of products\",\"callToActionImage\":[\"65\"],\"callToActionBackgroundColor\":\"red\",\"callToActionLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Start Shopping\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://store.acrsupply.com\"}}},\"17\":{\"type\":\"callToAction\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"callToActionTitle\":\"Request Online Account\",\"callToActionDescription\":\"Quickly request an account to shop with us\",\"callToActionImage\":[\"66\"],\"callToActionBackgroundColor\":\"blue\",\"callToActionLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Request an Account\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":\"52\"}}}},\"27\":\"Get VIP access for early announcements for all our events and sales.\",\"11\":\"As the weather cools, you may be seeing pests around your house. In the fall months, here are some things to be on the lookout for:\",\"25\":[\"15\"],\"12\":{\"12\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}}},\"13\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"Shop Online\",\"target\":null,\"title\":null,\"type\":\"url\",\"value\":\"https://shop.acrsupply.com\"}}},\"14\":{\"type\":\"service\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"serviceTitle\":\"Thousands of Products\",\"serviceDescription\":\"We have everything that you might need. If for some reason we don’t, we will get it for you. Don’t worry about getting a product on time.\",\"serviceLink\":{\"ariaLabel\":null,\"customQuery\":null,\"customText\":\"\",\"target\":null,\"title\":null,\"type\":\"entry\",\"value\":null}}}},\"26\":\"Stay Updated With ACR\",\"10\":\"What We Do Best\"}}','2019-01-27 18:25:14','2019-01-27 18:25:14','f9cfed4b-1beb-4770-8ee7-a687957e31e5');
/*!40000 ALTER TABLE `acr_entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldgroups`
--

LOCK TABLES `acr_fieldgroups` WRITE;
/*!40000 ALTER TABLE `acr_fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fieldgroups` VALUES (1,'Common','2018-09-30 15:22:58','2019-01-17 02:45:22','d1b2d3e0-caff-4265-8c15-310da7c6b14f'),(3,'Notifications','2018-11-02 01:19:21','2019-01-17 02:45:22','75772b73-5f13-442a-b9a8-8c5a6015f039'),(5,'Services','2018-11-02 02:27:54','2019-01-17 02:45:22','d0819d73-9155-4ac5-9995-9fe3d7c32c74'),(7,'Home','2018-12-08 01:26:41','2019-01-17 02:45:22','28b86dd3-c932-453a-ad70-b5c437d0c06b'),(8,'Testimonials','2018-12-30 16:09:03','2019-01-17 02:45:22','3a435df0-e9ed-4290-a496-2073b7800d15'),(9,'Newsletter','2018-12-30 16:31:14','2019-01-17 02:45:22','77926385-cc33-4146-a9d8-bb682af7623a'),(10,'Global','2018-12-30 16:42:19','2019-01-17 02:45:22','7a86ba31-dc42-491b-9a15-47a006756d8b');
/*!40000 ALTER TABLE `acr_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldlayoutfields`
--

LOCK TABLES `acr_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `acr_fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fieldlayoutfields` VALUES (2,2,2,2,0,1,'2018-10-08 23:48:12','2018-10-08 23:48:12','b1772bbf-f9be-4f2d-84a8-5a2fd8451210'),(7,8,6,7,0,1,'2018-11-02 01:20:46','2018-11-02 01:20:46','0c97b502-2d8e-42e2-9eeb-7f15b79447e1'),(8,8,6,6,0,2,'2018-11-02 01:20:46','2018-11-02 01:20:46','0e47f4fa-9a0f-447e-b7cd-205e89fb5146'),(54,11,20,23,0,1,'2018-12-30 16:10:48','2018-12-30 16:10:48','e75f687f-ca0e-4124-a1dd-87c113917776'),(55,11,20,24,0,2,'2018-12-30 16:10:48','2018-12-30 16:10:48','6f337ced-fc8e-4f55-80eb-e47b5de9144f'),(56,7,21,10,0,1,'2018-12-30 16:32:20','2018-12-30 16:32:20','0e3965a8-e3a4-439c-9b05-d7876b7ed13b'),(57,7,21,11,0,2,'2018-12-30 16:32:20','2018-12-30 16:32:20','9f2b94d7-e782-4e48-9a15-e01b1edce0f8'),(58,7,21,12,0,3,'2018-12-30 16:32:20','2018-12-30 16:32:20','5b229b3b-6688-4920-8322-0c8585d6e2c1'),(59,7,22,16,0,1,'2018-12-30 16:32:20','2018-12-30 16:32:20','3ad8696a-6c13-4c76-811d-5ed9bcd3ee92'),(60,7,23,26,0,1,'2018-12-30 16:32:20','2018-12-30 16:32:20','8d704420-f373-428a-a24d-0ae0690d0eeb'),(61,7,23,27,0,2,'2018-12-30 16:32:20','2018-12-30 16:32:20','7f873951-5969-48f9-8576-988a634e4b16'),(62,7,23,25,0,3,'2018-12-30 16:32:20','2018-12-30 16:32:20','6f237ada-e103-488b-b06e-12fb522e98a6'),(72,15,28,33,0,1,'2019-01-02 00:46:22','2019-01-02 00:46:22','19e39c39-23d3-488b-8ca5-f675b5269f35'),(73,15,29,29,0,1,'2019-01-02 00:46:22','2019-01-02 00:46:22','a1e45ee9-edde-4326-b2c9-977bf012897b'),(74,15,29,30,0,2,'2019-01-02 00:46:22','2019-01-02 00:46:22','75a1c14b-1148-41d8-a7d9-b1b7f2bc117e'),(75,15,29,31,0,3,'2019-01-02 00:46:22','2019-01-02 00:46:22','0f5762d4-15fc-42f7-99f7-3eda119389f9'),(83,17,33,34,0,1,'2019-01-02 01:15:39','2019-01-02 01:15:39','fdd0af8a-64c5-4112-9a53-22415fe499b3'),(98,9,38,13,0,1,'2019-01-17 02:45:24','2019-01-17 02:45:24','4b09023b-b4fc-4c32-ade5-032869e80f01'),(99,9,38,14,0,2,'2019-01-17 02:45:24','2019-01-17 02:45:24','fe9c1d22-021a-4a23-930e-0eea7a1e60d6'),(100,9,38,15,0,3,'2019-01-17 02:45:24','2019-01-17 02:45:24','6367b3f9-5d32-4a4a-901f-bab0a5712cce'),(101,10,39,17,1,1,'2019-01-17 02:45:24','2019-01-17 02:45:24','16581a99-947d-4607-a2fb-4ac3ef502fc5'),(102,10,39,18,0,2,'2019-01-17 02:45:24','2019-01-17 02:45:24','dfe35ebd-d406-482e-9188-eec122673d49'),(103,10,39,19,0,3,'2019-01-17 02:45:24','2019-01-17 02:45:24','b49ed67f-17bb-4b39-8928-34dc985639e6'),(104,10,39,20,0,4,'2019-01-17 02:45:24','2019-01-17 02:45:24','4ef0016a-cf14-48d9-83d3-456fbfcc2fc5'),(105,10,39,22,0,5,'2019-01-17 02:45:24','2019-01-17 02:45:24','fc010d2c-91b6-4431-b4aa-6436a33738fc'),(109,18,41,35,0,1,'2019-01-21 18:21:58','2019-01-21 18:21:58','2109c579-ac80-402b-88e1-3c29966c1938'),(110,18,41,36,0,2,'2019-01-21 18:21:58','2019-01-21 18:21:58','3e54ac48-42bd-45cb-ad93-c0eb3c716e42'),(111,18,41,37,0,3,'2019-01-21 18:21:58','2019-01-21 18:21:58','193fc413-c967-4e28-8a18-b3ba39dedffc'),(112,18,41,38,0,4,'2019-01-21 18:21:58','2019-01-21 18:21:58','b16925a4-1608-40f7-98e3-ff0eeda85c91'),(117,19,44,41,0,1,'2019-01-23 02:57:52','2019-01-23 02:57:52','283deab4-c51c-4fd5-b69d-2d142f46ac8c'),(118,19,44,42,0,2,'2019-01-23 02:57:52','2019-01-23 02:57:52','64afab87-50ab-4d62-baf8-209ddb1b2c1a'),(119,21,45,44,0,1,'2019-01-23 03:03:52','2019-01-23 03:03:52','07deb8b2-becf-48b6-82eb-6aa1cf5599f9'),(120,20,46,39,0,1,'2019-01-23 03:04:05','2019-01-23 03:04:05','ce48e776-488e-4a14-b505-b17e309420b2'),(121,20,46,43,0,2,'2019-01-23 03:04:05','2019-01-23 03:04:05','8dba1fd8-1745-44a9-a1a6-192bb3a61001'),(124,6,48,45,1,1,'2019-01-27 18:17:45','2019-01-27 18:17:45','1588142c-4418-4651-b05b-a96c42cde8fa'),(125,6,48,4,0,2,'2019-01-27 18:17:45','2019-01-27 18:17:45','3c852616-e9a8-43e6-8b9c-85e6c2eb88eb'),(129,22,50,25,0,1,'2019-01-27 18:29:22','2019-01-27 18:29:22','56058c09-761b-461a-b9a4-d23a3decfc5b'),(130,22,50,26,0,2,'2019-01-27 18:29:22','2019-01-27 18:29:22','3ea931d4-f60d-4c36-913e-a460ece1e420'),(131,22,50,27,0,3,'2019-01-27 18:29:22','2019-01-27 18:29:22','2a79b08d-3624-4e9c-b935-13708ce16154');
/*!40000 ALTER TABLE `acr_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldlayouts`
--

LOCK TABLES `acr_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `acr_fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fieldlayouts` VALUES (1,'Solspace\\Calendar\\Elements\\Event','2018-09-30 15:33:39','2018-09-30 15:33:39',NULL,'40210270-1b0e-461b-a5aa-319d69ea7819'),(2,'craft\\elements\\GlobalSet','2018-10-08 23:42:03','2018-10-08 23:48:12',NULL,'54e4880b-8f72-49a9-8732-0bacdc5c96b7'),(3,'craft\\elements\\Asset','2018-10-08 23:46:31','2018-10-08 23:46:31','2019-01-27 18:19:02','06fbf1cf-6c60-49ab-9fc6-e1d9640c01bc'),(5,'craft\\elements\\Entry','2018-10-08 23:53:17','2018-10-10 23:45:28',NULL,'d54ded79-c194-433a-ab8f-688521561942'),(6,'craft\\elements\\Entry','2018-10-09 00:13:24','2019-01-27 18:17:45',NULL,'416230ab-5b37-4f4c-8ede-32e9fba6164b'),(7,'craft\\elements\\Entry','2018-10-10 23:42:21','2018-12-30 16:32:20',NULL,'50e9b4f2-ddf3-409f-be4f-cd314baaee51'),(8,'craft\\elements\\Entry','2018-11-02 01:16:09','2018-11-02 01:20:46',NULL,'e9678a4c-360c-483a-a91f-9dff15e607c8'),(9,'craft\\elements\\MatrixBlock','2018-11-02 02:34:57','2019-01-17 02:45:24',NULL,'bbb4f2b3-f970-48bc-b558-4c21dcf0d911'),(10,'craft\\elements\\MatrixBlock','2018-12-08 01:29:41','2019-01-17 02:45:24',NULL,'6d5c94c9-83a9-4be7-af5f-8189aeb32f4c'),(11,'craft\\elements\\Entry','2018-12-17 01:13:58','2018-12-30 16:10:48',NULL,'fbe40f7a-faae-4d94-b250-3f1c367c966e'),(15,'craft\\elements\\GlobalSet','2018-12-30 16:43:46','2019-01-02 00:46:22',NULL,'160be074-78ff-4339-b327-91a2f57bf793'),(17,'craft\\elements\\Entry','2019-01-02 01:08:25','2019-01-02 01:15:39',NULL,'dbb7b849-058e-4556-8ed1-440fed40ef31'),(18,'craft\\elements\\MatrixBlock','2019-01-02 01:11:47','2019-01-21 18:21:58',NULL,'5ea35531-4f32-434f-8ab9-27d853b46432'),(19,'craft\\elements\\MatrixBlock','2019-01-23 02:50:14','2019-01-23 02:57:52',NULL,'8e770b24-247e-49ec-978f-1cbe2a2d8bec'),(20,'craft\\elements\\Entry','2019-01-23 02:50:36','2019-01-23 03:04:05',NULL,'5a96d75b-bcb5-45a8-b004-87efea6204ec'),(21,'craft\\elements\\MatrixBlock','2019-01-23 03:03:52','2019-01-23 03:03:52',NULL,'e2264f39-c7a9-4baa-b4a8-e1add7ff7a89'),(22,'craft\\elements\\GlobalSet','2019-01-27 18:29:04','2019-01-27 18:29:22',NULL,'928d3988-5927-4713-b134-fad5ce7b6342');
/*!40000 ALTER TABLE `acr_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fieldlayouttabs`
--

LOCK TABLES `acr_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `acr_fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fieldlayouttabs` VALUES (1,1,'Registration',1,'2018-09-30 15:33:39','2018-09-30 15:33:39','edf45c2a-0266-4d40-adcc-71c41c433b89'),(2,2,'General Site Information',1,'2018-10-08 23:48:12','2018-10-08 23:48:12','0b0b9220-5011-4fe9-97f0-a1112fccd5e7'),(6,8,'Notification Information',1,'2018-11-02 01:20:46','2018-11-02 01:20:46','75ccd251-5ece-4670-896f-9bd49ce65ef2'),(20,11,'Testimonial Content',1,'2018-12-30 16:10:48','2018-12-30 16:10:48','bbe87f5e-aace-4f1a-becf-d805793abbba'),(21,7,'Services',1,'2018-12-30 16:32:20','2018-12-30 16:32:20','0cbf05d0-3fe6-46c2-bb87-e6b2d7d764e5'),(22,7,'50/50 Section',2,'2018-12-30 16:32:20','2018-12-30 16:32:20','097ba52b-eecd-4e54-86bc-8e22eed43e55'),(23,7,'Newsletter',3,'2018-12-30 16:32:20','2018-12-30 16:32:20','c0dad566-77f7-4860-acce-74f7257788a1'),(28,15,'General',1,'2019-01-02 00:46:22','2019-01-02 00:46:22','bce2e1bc-8ad7-4ec3-9bec-449ffa49d891'),(29,15,'Links',2,'2019-01-02 00:46:22','2019-01-02 00:46:22','b29a6940-60b7-4bdb-9cb8-31d095fe55cf'),(33,17,'Locations Listing',1,'2019-01-02 01:15:39','2019-01-02 01:15:39','b23fc828-c980-4cc5-be49-59298910c307'),(38,9,'Content',1,'2019-01-17 02:45:24','2019-01-17 02:45:24','10ca28cf-afad-4feb-8fa7-63483ce54c64'),(39,10,'Content',1,'2019-01-17 02:45:24','2019-01-17 02:45:24','7ce805f0-9127-4f2e-90fb-589499e58e00'),(41,18,'Content',1,'2019-01-21 18:21:58','2019-01-21 18:21:58','d8fc9c95-b1dd-46e6-bc62-aedfbc978b5a'),(44,19,'Content',1,'2019-01-23 02:57:52','2019-01-23 02:57:52','d8a43a64-27f0-40de-98ad-dd19e0121487'),(45,21,'Content',1,'2019-01-23 03:03:52','2019-01-23 03:03:52','9754dfae-142b-452d-bd1d-08322728fabb'),(46,20,'Initiatives',1,'2019-01-23 03:04:05','2019-01-23 03:04:05','f9a25e47-c053-4b60-bfc1-248283e17b2a'),(48,6,'Settings',1,'2019-01-27 18:17:45','2019-01-27 18:17:45','04147e39-e982-4d70-9dd0-b17a5b96b0c2'),(50,22,'Settings',1,'2019-01-27 18:29:22','2019-01-27 18:29:22','abeaab63-5395-40e3-a751-b230ffe6fb58');
/*!40000 ALTER TABLE `acr_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_fields`
--

LOCK TABLES `acr_fields` WRITE;
/*!40000 ALTER TABLE `acr_fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_fields` VALUES (2,1,'Single Image','singleImage','global','Add a single image to the page.',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"singleUploadLocationSubpath\":\"promotions\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an image\",\"localizeRelations\":false}','2018-10-08 23:47:50','2019-01-27 17:54:12','f988b15f-c79d-4498-8900-22b3859c00cc'),(4,1,'Page Link','pageLink','global','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"3\":\"entry\",\"4\":\"site\",\"7\":\"email\",\"8\":\"tel\",\"9\":\"url\"},\"allowTarget\":\"1\",\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAriaLabel\":\"1\",\"enableTitle\":\"1\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-10-09 00:15:41','2018-10-09 00:15:41','a207db43-6f70-4166-9f80-4694e159fd67'),(6,3,'Notification Text','notificationText','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-02 01:19:37','2018-11-02 01:19:37','6ecf8a37-13bc-46bc-afd1-e9505338259d'),(7,3,'Notification Link','notificationLink','global','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"3\":\"entry\",\"9\":\"url\"},\"allowTarget\":\"1\",\"defaultLinkName\":\"url\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-11-02 01:20:22','2018-11-02 01:20:22','e7ff456f-d45d-43e0-bc06-9c9ffe9468f2'),(10,5,'Title','servicesTitle','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-02 02:28:06','2018-11-02 02:28:06','d1e02aa7-b33b-49c4-a198-dae3f462e65a'),(11,5,'Description','servicesDescription','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-02 02:28:15','2018-11-02 02:28:15','a07789b8-1f0d-4fae-ac9c-52f01e112769'),(12,5,'Services','services','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"1\",\"maxBlocks\":\"6\",\"contentTable\":\"{{%matrixcontent_services}}\",\"localizeBlocks\":false}','2018-11-02 02:34:57','2018-11-02 02:34:57','a4ac9646-eeb8-4757-99be-592e59cf2acb'),(13,NULL,'Title','serviceTitle','matrixBlockType:ad0dc2b4-7b01-48f6-9596-8c8dad66a4b1','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-02 02:34:57','2019-01-17 02:45:23','54f564b2-6d31-46e7-a148-ca738ab72142'),(14,NULL,'Description','serviceDescription','matrixBlockType:ad0dc2b4-7b01-48f6-9596-8c8dad66a4b1','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-11-02 02:34:57','2019-01-17 02:45:23','28cf2be5-8f7e-4677-b055-7b02264a5217'),(15,NULL,'Link','serviceLink','matrixBlockType:ad0dc2b4-7b01-48f6-9596-8c8dad66a4b1','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"3\":\"entry\",\"9\":\"url\"},\"allowTarget\":\"\",\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-11-02 02:34:57','2019-01-17 02:45:24','2e5417ea-9053-4e0f-9f16-0301f26dcf2a'),(16,7,'CTAs','ctas','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_ctas}}\",\"localizeBlocks\":false}','2018-12-08 01:29:41','2018-12-08 01:55:43','f4c519dd-a990-40e1-a0c9-696bbe1ab8fc'),(17,NULL,'Call to Action Title','callToActionTitle','matrixBlockType:a18a4a20-6a90-4d48-8995-8ab7941dcc11','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-08 01:29:41','2019-01-17 02:45:24','3dee8338-1e08-4d25-bdde-b00ee509d056'),(18,NULL,'Description','callToActionDescription','matrixBlockType:a18a4a20-6a90-4d48-8995-8ab7941dcc11','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-08 01:29:41','2019-01-17 02:45:24','fce33d4d-1efd-4868-8cbe-9f00ddbb8fa6'),(19,NULL,'Image','callToActionImage','matrixBlockType:a18a4a20-6a90-4d48-8995-8ab7941dcc11','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-12-08 01:29:41','2019-01-17 02:45:24','9938542d-a4f6-4f92-96a8-c8bcc7818139'),(20,NULL,'Background Color','callToActionBackgroundColor','matrixBlockType:a18a4a20-6a90-4d48-8995-8ab7941dcc11','',1,'none',NULL,'craft\\fields\\RadioButtons','{\"options\":[{\"label\":\"Red\",\"value\":\"red\",\"default\":\"\"},{\"label\":\"Blue\",\"value\":\"blue\",\"default\":\"\"}]}','2018-12-08 01:32:38','2019-01-17 02:45:24','93c4bbd8-db6c-4a65-987f-b31e3462b6c4'),(22,NULL,'Link','callToActionLink','matrixBlockType:a18a4a20-6a90-4d48-8995-8ab7941dcc11','',1,'none',NULL,'typedlinkfield\\fields\\LinkField','{\"allowCustomText\":\"1\",\"allowedLinkNames\":{\"3\":\"entry\",\"4\":\"site\",\"6\":\"custom\",\"7\":\"email\",\"8\":\"tel\",\"9\":\"url\"},\"allowTarget\":\"\",\"defaultLinkName\":\"asset\",\"defaultText\":\"\",\"enableAriaLabel\":\"\",\"enableTitle\":\"\",\"typeSettings\":{\"asset\":{\"sources\":\"*\"},\"category\":{\"sources\":\"*\"},\"entry\":{\"sources\":\"*\"},\"site\":{\"sites\":\"*\"},\"user\":{\"sources\":\"*\"},\"custom\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"email\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"tel\":{\"disableValidation\":\"\",\"allowAliases\":\"\"},\"url\":{\"disableValidation\":\"\",\"allowAliases\":\"\"}}}','2018-12-08 01:43:03','2019-01-17 02:45:24','16531a44-dbf0-4400-bcdd-ecdad520a697'),(23,8,'Author','testimonialAuthor','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-30 16:09:18','2018-12-30 16:09:26','4de3e644-b5ec-4104-89c5-3449fa4175b2'),(24,8,'Content','testimonalcontent','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-30 16:09:57','2018-12-30 16:11:19','06a1d088-9aea-4440-8997-c731e1282b28'),(25,9,'Image','newsletterImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an image\",\"localizeRelations\":false}','2018-12-30 16:31:40','2019-01-27 18:32:46','c56d653e-9e7d-4ef9-aa84-7ec8606d088c'),(26,9,'Title','newsletterTitle','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-30 16:31:49','2018-12-30 16:31:49','1bc2be8f-63f9-4d51-8d5c-3d07b7c84ed5'),(27,9,'Description','newsletterDescription','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-30 16:31:58','2018-12-30 16:31:58','c2b3d873-50c8-4e57-820d-6aa965f39b79'),(28,1,'External Link','externalLink','global','',1,'none',NULL,'craft\\fields\\Url','{\"placeholder\":\"\"}','2018-12-30 16:41:33','2018-12-30 16:41:54','2454409f-dfb2-45e4-b6fc-3ef708639b05'),(29,10,'Apple Store LInk','appleStoreLink','global','',1,'none',NULL,'craft\\fields\\Url','{\"placeholder\":\"\"}','2018-12-30 16:42:30','2018-12-30 16:42:30','009e6ae8-8fde-401d-a29e-784a1170ebfd'),(30,10,'Google Play Store LInk','googlePlayStoreLink','global','',1,'none',NULL,'craft\\fields\\Url','{\"placeholder\":\"\"}','2018-12-30 16:42:43','2018-12-30 16:42:43','654aca73-0f2c-4695-89ba-4bd3e6db1e42'),(31,10,'Facebook Link','facebookLink','global','',1,'none',NULL,'craft\\fields\\Url','{\"placeholder\":\"\"}','2018-12-30 16:42:55','2018-12-30 16:42:55','13e8e656-c68f-463c-86e6-b51e83c7d2a1'),(32,10,'Footer Logo','footerLogo','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2018-12-30 16:44:05','2019-01-17 02:45:23','d43389b3-5eea-455f-8ea2-d05f6a5ec556'),(33,10,'Footer Tagline','footerTagline','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2018-12-30 16:44:11','2018-12-30 16:44:11','877d25f5-76f5-467b-9739-03e87cdffbbe'),(34,1,'Locations','locations','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_locations}}\",\"localizeBlocks\":false}','2019-01-02 01:11:47','2019-01-21 18:21:57','ede61ed2-c66a-4d59-8ef2-a5b1f3630dda'),(35,NULL,'Name','locationName','matrixBlockType:c773ee36-d4bd-4d3c-8a25-e904a163d34e','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-02 01:11:47','2019-01-21 18:21:57','5d063c02-f819-4258-82df-5a5ec9568e0a'),(36,NULL,'Address','address','matrixBlockType:c773ee36-d4bd-4d3c-8a25-e904a163d34e','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-02 01:11:47','2019-01-21 18:21:57','701fee08-7b80-4ba0-981f-7212238bb0d5'),(37,NULL,'Phone Number','phoneNumber','matrixBlockType:c773ee36-d4bd-4d3c-8a25-e904a163d34e','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-02 01:11:47','2019-01-21 18:21:57','cf1d4f60-e469-4979-89db-5395eeacf025'),(38,NULL,'Google Map Link','googleMapLink','matrixBlockType:c773ee36-d4bd-4d3c-8a25-e904a163d34e','',1,'none',NULL,'craft\\fields\\Url','{\"placeholder\":\"\"}','2019-01-21 18:21:58','2019-01-21 18:21:58','ecdf0853-6e09-413b-b63f-2a03ea7a9a1b'),(39,1,'ACR Cares Initiatives','acrCaresInitiatives','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_acrcaresinitiatives}}\",\"localizeBlocks\":false}','2019-01-23 02:50:14','2019-01-23 02:57:52','afceddc5-9590-4182-abf6-bb387268c36d'),(41,NULL,'Title','initiativeTitle','matrixBlockType:cd5cbfa7-0720-49c3-8c87-eca987b0e498','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-23 02:50:14','2019-01-23 02:57:52','5004af34-6543-4cb8-a1c3-157bf57abd95'),(42,NULL,'Description','initiativeDescription','matrixBlockType:cd5cbfa7-0720-49c3-8c87-eca987b0e498','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-23 02:50:14','2019-01-23 02:57:52','8c95b6b9-ce93-4231-942f-7d44e4a0d9a8'),(43,1,'Team Member Initiatives','teamMemberInitiatives','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_teammemberinitiatives}}\",\"localizeBlocks\":false}','2019-01-23 03:03:51','2019-01-23 03:03:51','68d45d5a-b25d-4eba-9741-54d6ab9ff499'),(44,NULL,'Title','initiativeTitle','matrixBlockType:3334d866-45d7-4fa3-b627-7c7470d3687a','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-01-23 03:03:52','2019-01-23 03:03:52','9f53424a-206a-4123-bd8f-9ab550dbf4d8'),(45,1,'Promotion Image','promotionImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"1\",\"defaultUploadLocationSource\":\"volume:98af559e-fbd3-426a-aada-0f8e6fe41d61\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:98af559e-fbd3-426a-aada-0f8e6fe41d61\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"1\",\"allowedKinds\":[\"image\"],\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add an Image\",\"localizeRelations\":false}','2019-01-27 18:01:17','2019-01-27 18:01:17','301600aa-e3fc-4ac2-9dfc-7b599eb1f1fc');
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
INSERT INTO `acr_freeform_forms` VALUES (1,'Contact Form','contactForm',0,'{{ dateCreated|date(\"Y-m-d H:i:s\") }}','','{\"composer\":{\"layout\":[[{\"id\":\"DqvAAWGd9\",\"columns\":[\"8oWe9jZpP\",\"5KM0OK02p\"]},{\"id\":\"pqOLL6Pnr\",\"columns\":[\"d1EeG8Z68\"]},{\"id\":\"DqvAAWvmV\",\"columns\":[\"mgEePYZor\"]},{\"id\":\"WrP779pkb\",\"columns\":[\"Bb10jE4K3\"]},{\"id\":\"pqOLL7j8R\",\"columns\":[\"pqOLL7j8R\"]}]],\"properties\":{\"page0\":{\"type\":\"page\",\"label\":\"Page 1\"},\"form\":{\"type\":\"form\",\"name\":\"Contact Form\",\"handle\":\"contactForm\",\"color\":\"#7303f9\",\"submissionTitleFormat\":\"{{ dateCreated|date(\\\"Y-m-d H:i:s\\\") }}\",\"description\":\"\",\"formTemplate\":\"grid.html\",\"returnUrl\":\"\",\"storeData\":true,\"defaultStatus\":2},\"integration\":{\"type\":\"integration\",\"integrationId\":0,\"mapping\":[]},\"connections\":{\"type\":\"connections\",\"list\":null},\"rules\":{\"type\":\"rules\",\"list\":[]},\"admin_notifications\":{\"type\":\"admin_notifications\",\"notificationId\":0,\"recipients\":\"\"},\"payment\":{\"type\":\"payment\",\"integrationId\":0,\"mapping\":[]},\"8oWe9jZpP\":{\"hash\":\"8oWe9jZpP\",\"id\":1,\"type\":\"text\",\"handle\":\"firstName\",\"label\":\"First Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"5KM0OK02p\":{\"hash\":\"5KM0OK02p\",\"id\":2,\"type\":\"text\",\"handle\":\"lastName\",\"label\":\"Last Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"d1EeG8Z68\":{\"hash\":\"d1EeG8Z68\",\"id\":3,\"type\":\"email\",\"handle\":\"email\",\"label\":\"Email\",\"required\":true,\"instructions\":\"\",\"notificationId\":0,\"values\":[],\"placeholder\":\"\"},\"mgEePYZor\":{\"hash\":\"mgEePYZor\",\"id\":14,\"type\":\"select\",\"handle\":\"reasonForContacting\",\"label\":\"Reason for Contacting\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"General Questions\",\"options\":[{\"label\":\"General Questions\",\"value\":\"General Questions\"},{\"label\":\"Engineering Solutions\",\"value\":\"Engineering Solutions\"},{\"label\":\"Comment or Feedback\",\"value\":\"Comment or Feedback\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"values\":[]},\"Bb10jE4K3\":{\"hash\":\"Bb10jE4K3\",\"id\":15,\"type\":\"textarea\",\"handle\":\"comments\",\"label\":\"Comments\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"pqOLL7j8R\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"}}},\"context\":{\"page\":0,\"hash\":\"form\"}}','',2,NULL,'#7303f9',NULL,'2019-01-24 01:52:16','2019-01-24 01:54:20','5f436f3d-8963-4453-80e9-b847e3fef09a'),(2,'E-Store Account Request Form','eStoreAccountRequestForm',0,'{{ dateCreated|date(\"Y-m-d H:i:s\") }}','','{\"composer\":{\"layout\":[[{\"id\":\"15rWWp9rP\",\"columns\":[\"8oWe9jZpP\",\"5KM0OK02p\"]},{\"id\":\"Bm211nxwn\",\"columns\":[\"AV34dy07p\",\"d1EeG8Z68\"]},{\"id\":\"RqA11VRjA\",\"columns\":[\"1wq0WR4bD\",\"Va34kjZPq\"]},{\"id\":\"rM3LLBPlV\",\"columns\":[\"EGv0Y2ed7\"]},{\"id\":\"ndwLL8KqD\",\"columns\":[\"KNn41Q4x3\"]},{\"id\":\"LLG99D22a\",\"columns\":[\"DBk0Xw4YJ\"]},{\"id\":\"bvNyyAEva\",\"columns\":[\"Bb10jE4K3\"]},{\"id\":\"P21kkJAxN\",\"columns\":[\"rM3LLrAB6\"]}]],\"properties\":{\"page0\":{\"type\":\"page\",\"label\":\"Page 1\"},\"form\":{\"type\":\"form\",\"name\":\"E-Store Account Request Form\",\"handle\":\"eStoreAccountRequestForm\",\"color\":\"#5727dc\",\"submissionTitleFormat\":\"{{ dateCreated|date(\\\"Y-m-d H:i:s\\\") }}\",\"description\":\"\",\"formTemplate\":\"grid.html\",\"returnUrl\":\"\",\"storeData\":true,\"defaultStatus\":2},\"integration\":{\"type\":\"integration\",\"integrationId\":0,\"mapping\":[]},\"connections\":{\"type\":\"connections\",\"list\":null},\"rules\":{\"type\":\"rules\",\"list\":[]},\"admin_notifications\":{\"type\":\"admin_notifications\",\"notificationId\":0,\"recipients\":\"\"},\"payment\":{\"type\":\"payment\",\"integrationId\":0,\"mapping\":[]},\"8oWe9jZpP\":{\"hash\":\"8oWe9jZpP\",\"id\":1,\"type\":\"text\",\"handle\":\"firstName\",\"label\":\"First Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"5KM0OK02p\":{\"hash\":\"5KM0OK02p\",\"id\":2,\"type\":\"text\",\"handle\":\"lastName\",\"label\":\"Last Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"AV34dy07p\":{\"hash\":\"AV34dy07p\",\"id\":16,\"type\":\"text\",\"handle\":\"position\",\"label\":\"Position\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"d1EeG8Z68\":{\"hash\":\"d1EeG8Z68\",\"id\":3,\"type\":\"email\",\"handle\":\"email\",\"label\":\"Email\",\"required\":true,\"instructions\":\"\",\"notificationId\":0,\"values\":[],\"placeholder\":\"\"},\"DBk0Xw4YJ\":{\"hash\":\"DBk0Xw4YJ\",\"id\":17,\"type\":\"text\",\"handle\":\"accountNumber\",\"label\":\"Account Number\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"inputAttributes\":[]},\"KNn41Q4x3\":{\"hash\":\"KNn41Q4x3\",\"id\":7,\"type\":\"text\",\"handle\":\"companyName\",\"label\":\"Company Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"1wq0WR4bD\":{\"hash\":\"1wq0WR4bD\",\"id\":6,\"type\":\"text\",\"handle\":\"phone\",\"label\":\"Phone\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"Va34kjZPq\":{\"hash\":\"Va34kjZPq\",\"id\":5,\"type\":\"text\",\"handle\":\"fax\",\"label\":\"Fax\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"EGv0Y2ed7\":{\"hash\":\"EGv0Y2ed7\",\"id\":8,\"type\":\"textarea\",\"handle\":\"address\",\"label\":\"Address\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"Bb10jE4K3\":{\"hash\":\"Bb10jE4K3\",\"id\":15,\"type\":\"textarea\",\"handle\":\"comments\",\"label\":\"Comments\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"rM3LLrAB6\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"}}},\"context\":{\"page\":0,\"hash\":\"EGv0Y2ed7\"}}','',2,NULL,'#5727dc',NULL,'2019-01-24 02:27:05','2019-01-24 02:33:33','dab224ac-cbf3-4829-941e-b98338a57f53'),(3,'E-Store Credit Application Form','eStoreCreditApplicationForm',0,'{{ dateCreated|date(\"Y-m-d H:i:s\") }}','','{\"composer\":{\"layout\":[[{\"id\":\"P21kLqrnq\",\"columns\":[\"KNn41Q4x3\"]},{\"id\":\"OkW3NKYa7\",\"columns\":[\"EGv0Y2ed7\"]},{\"id\":\"RqA1NbRxB\",\"columns\":[\"VgLeAg426\",\"jDMZQLe3y\",\"A21ZpweEr\"]},{\"id\":\"GRy7KRWvm\",\"columns\":[\"gGp461ZwQ\"]},{\"id\":\"91RPMEEEK\",\"columns\":[\"1wq0WR4bD\",\"Va34kjZPq\"]},{\"id\":\"XzjrwoAvo\",\"columns\":[\"d1EeG8Z68\"]},{\"id\":\"dvBy7PqJp\",\"columns\":[\"Jvb4m946X\"]},{\"id\":\"Aj5WMVlEL\",\"columns\":[\"qlRZRw4XA\"]},{\"id\":\"jRlyxMjEM\",\"columns\":[\"dV8ZM8eob\"]},{\"id\":\"rM3LxOpJx\",\"columns\":[\"Nlj0BV07x\"]},{\"id\":\"jRlyxnVjb\",\"columns\":[\"gB1enGZYl\"]},{\"id\":\"E2lQMGq2w\",\"columns\":[\"vAoe5ye6P\"]},{\"id\":\"yqpzKlAY1\",\"columns\":[\"2yV42xeLY\"]},{\"id\":\"91RPMBG9E\",\"columns\":[\"N5r0JM4Xa\"]},{\"id\":\"gR2yjOzyg\",\"columns\":[\"arWeva0vy\"]},{\"id\":\"jRlyxbMQ1\",\"columns\":[\"N6n0lVZGa\"]},{\"id\":\"qlGKxkrVP\",\"columns\":[\"qlGKxkrVP\"]}]],\"properties\":{\"page0\":{\"type\":\"page\",\"label\":\"Page 1\"},\"form\":{\"type\":\"form\",\"name\":\"E-Store Credit Application Form\",\"handle\":\"eStoreCreditApplicationForm\",\"color\":\"#1e5385\",\"submissionTitleFormat\":\"{{ dateCreated|date(\\\"Y-m-d H:i:s\\\") }}\",\"description\":\"\",\"formTemplate\":\"grid.html\",\"returnUrl\":\"\",\"storeData\":true,\"defaultStatus\":2},\"integration\":{\"type\":\"integration\",\"integrationId\":0,\"mapping\":[]},\"connections\":{\"type\":\"connections\",\"list\":null},\"rules\":{\"type\":\"rules\",\"list\":[]},\"admin_notifications\":{\"type\":\"admin_notifications\",\"notificationId\":0,\"recipients\":\"\"},\"payment\":{\"type\":\"payment\",\"integrationId\":0,\"mapping\":[]},\"KNn41Q4x3\":{\"hash\":\"KNn41Q4x3\",\"id\":7,\"type\":\"text\",\"handle\":\"companyName\",\"label\":\"Company Name\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"EGv0Y2ed7\":{\"hash\":\"EGv0Y2ed7\",\"id\":8,\"type\":\"textarea\",\"handle\":\"mailingAddress\",\"label\":\"Mailing Address\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"VgLeAg426\":{\"hash\":\"VgLeAg426\",\"id\":9,\"type\":\"text\",\"handle\":\"mailingAddressCity\",\"label\":\"City\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"jDMZQLe3y\":{\"hash\":\"jDMZQLe3y\",\"id\":10,\"type\":\"select\",\"handle\":\"mailingAddressState\",\"label\":\"State\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":true,\"value\":\"\",\"options\":[{\"value\":\"\",\"label\":\"Select a State\"},{\"value\":\"AL\",\"label\":\"Alabama\"},{\"value\":\"AK\",\"label\":\"Alaska\"},{\"value\":\"AZ\",\"label\":\"Arizona\"},{\"value\":\"AR\",\"label\":\"Arkansas\"},{\"value\":\"CA\",\"label\":\"California\"},{\"value\":\"CO\",\"label\":\"Colorado\"},{\"value\":\"CT\",\"label\":\"Connecticut\"},{\"value\":\"DE\",\"label\":\"Delaware\"},{\"value\":\"DC\",\"label\":\"District of Columbia\"},{\"value\":\"FL\",\"label\":\"Florida\"},{\"value\":\"GA\",\"label\":\"Georgia\"},{\"value\":\"HI\",\"label\":\"Hawaii\"},{\"value\":\"ID\",\"label\":\"Idaho\"},{\"value\":\"IL\",\"label\":\"Illinois\"},{\"value\":\"IN\",\"label\":\"Indiana\"},{\"value\":\"IA\",\"label\":\"Iowa\"},{\"value\":\"KS\",\"label\":\"Kansas\"},{\"value\":\"KY\",\"label\":\"Kentucky\"},{\"value\":\"LA\",\"label\":\"Louisiana\"},{\"value\":\"ME\",\"label\":\"Maine\"},{\"value\":\"MD\",\"label\":\"Maryland\"},{\"value\":\"MA\",\"label\":\"Massachusetts\"},{\"value\":\"MI\",\"label\":\"Michigan\"},{\"value\":\"MN\",\"label\":\"Minnesota\"},{\"value\":\"MS\",\"label\":\"Mississippi\"},{\"value\":\"MO\",\"label\":\"Missouri\"},{\"value\":\"MT\",\"label\":\"Montana\"},{\"value\":\"NE\",\"label\":\"Nebraska\"},{\"value\":\"NV\",\"label\":\"Nevada\"},{\"value\":\"NH\",\"label\":\"New Hampshire\"},{\"value\":\"NJ\",\"label\":\"New Jersey\"},{\"value\":\"NM\",\"label\":\"New Mexico\"},{\"value\":\"NY\",\"label\":\"New York\"},{\"value\":\"NC\",\"label\":\"North Carolina\"},{\"value\":\"ND\",\"label\":\"North Dakota\"},{\"value\":\"OH\",\"label\":\"Ohio\"},{\"value\":\"OK\",\"label\":\"Oklahoma\"},{\"value\":\"OR\",\"label\":\"Oregon\"},{\"value\":\"PA\",\"label\":\"Pennsylvania\"},{\"value\":\"RI\",\"label\":\"Rhode Island\"},{\"value\":\"SC\",\"label\":\"South Carolina\"},{\"value\":\"SD\",\"label\":\"South Dakota\"},{\"value\":\"TN\",\"label\":\"Tennessee\"},{\"value\":\"TX\",\"label\":\"Texas\"},{\"value\":\"UT\",\"label\":\"Utah\"},{\"value\":\"VT\",\"label\":\"Vermont\"},{\"value\":\"VA\",\"label\":\"Virginia\"},{\"value\":\"WA\",\"label\":\"Washington\"},{\"value\":\"WV\",\"label\":\"West Virginia\"},{\"value\":\"WI\",\"label\":\"Wisconsin\"},{\"value\":\"WY\",\"label\":\"Wyoming\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"values\":[]},\"A21ZpweEr\":{\"hash\":\"A21ZpweEr\",\"id\":11,\"type\":\"text\",\"handle\":\"mailingAddressZipCode\",\"label\":\"Zip Code\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"gGp461ZwQ\":{\"hash\":\"gGp461ZwQ\",\"id\":18,\"type\":\"textarea\",\"handle\":\"shippingAddress\",\"label\":\"Shipping Address\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2},\"1wq0WR4bD\":{\"hash\":\"1wq0WR4bD\",\"id\":6,\"type\":\"text\",\"handle\":\"phone\",\"label\":\"Phone\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"d1EeG8Z68\":{\"hash\":\"d1EeG8Z68\",\"id\":3,\"type\":\"email\",\"handle\":\"email\",\"label\":\"Email\",\"required\":true,\"instructions\":\"\",\"notificationId\":0,\"values\":[],\"placeholder\":\"\"},\"Va34kjZPq\":{\"hash\":\"Va34kjZPq\",\"id\":5,\"type\":\"text\",\"handle\":\"fax\",\"label\":\"Fax\",\"required\":false,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"Jvb4m946X\":{\"hash\":\"Jvb4m946X\",\"id\":19,\"type\":\"text\",\"handle\":\"dateBusinessWasEstablished\",\"label\":\"Date Business Was Established\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"qlRZRw4XA\":{\"id\":21,\"hash\":\"qlRZRw4XA\",\"type\":\"radio_group\",\"handle\":\"organizationType\",\"label\":\"Organization Type\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Corporation\",\"options\":[{\"label\":\"Corporation\",\"value\":\"Corporation\"},{\"label\":\"Partnership\",\"value\":\"Partnership\"},{\"label\":\"Individual\",\"value\":\"Individual\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"values\":[],\"oneLine\":true},\"dV8ZM8eob\":{\"id\":22,\"hash\":\"dV8ZM8eob\",\"type\":\"radio_group\",\"handle\":\"serviceFocus\",\"label\":\"Service Focus\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Distributor\",\"options\":[{\"label\":\"Distributor\",\"value\":\"Distributor\"},{\"label\":\"Buying Group\",\"value\":\"Buying Group\"},{\"label\":\"Building Automation DDC\",\"value\":\"Building Automation DDC\"},{\"label\":\"C Stores \\/ Food Services\",\"value\":\"C Stores \\/ Food Services\"},{\"label\":\"Commercial Refrigeration\",\"value\":\"Commercial Refrigeration\"},{\"label\":\"Commercial HVAC\",\"value\":\"Commercial HVAC\"},{\"label\":\"Hydronics \\/ Plumbing Contractors\",\"value\":\"Hydronics \\/ Plumbing Contractors\"},{\"label\":\"Industrial \\/ Electrical\",\"value\":\"Industrial \\/ Electrical\"},{\"label\":\"Institutional \\/ Health Care\",\"value\":\"Institutional \\/ Health Care\"},{\"label\":\"Municipalities \\/ Governmental\",\"value\":\"Municipalities \\/ Governmental\"},{\"label\":\"OEM \\/ End Users\",\"value\":\"OEM \\/ End Users\"},{\"label\":\"Residential HVAC\",\"value\":\"Residential HVAC\"},{\"label\":\"Supermarket Contractors\",\"value\":\"Supermarket Contractors\"},{\"label\":\"Supermarkets\",\"value\":\"Supermarkets\"},{\"label\":\"Universities \\/ Schools\",\"value\":\"Universities \\/ Schools\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"values\":[],\"oneLine\":false},\"Nlj0BV07x\":{\"id\":27,\"hash\":\"Nlj0BV07x\",\"type\":\"radio_group\",\"handle\":\"doYouRequirePurchaseOrderNumbersForPurchases\",\"label\":\"Do you require purchase order numbers for purchases?\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Yes\",\"options\":[{\"label\":\"Yes\",\"value\":\"Yes\"},{\"label\":\"No\",\"value\":\"No\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"oneLine\":true},\"gB1enGZYl\":{\"id\":28,\"hash\":\"gB1enGZYl\",\"type\":\"radio_group\",\"handle\":\"areYouTaxExemptE595E\",\"label\":\"Are you tax exempt? (E-595E)\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Yes\",\"options\":[{\"label\":\"Yes\",\"value\":\"Yes\"},{\"label\":\"No\",\"value\":\"No\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"oneLine\":true},\"vAoe5ye6P\":{\"id\":29,\"hash\":\"vAoe5ye6P\",\"type\":\"text\",\"handle\":\"salesTaxNumber\",\"label\":\"Sales Tax Number\",\"required\":true,\"instructions\":\"\",\"value\":\"\",\"placeholder\":\"\"},\"2yV42xeLY\":{\"id\":30,\"hash\":\"2yV42xeLY\",\"type\":\"radio_group\",\"handle\":\"wouldYouBeInterestedInShoppingOnOurEStore\",\"label\":\"Would you be interested in shopping on our E-Store?\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Yes\",\"options\":[{\"label\":\"Yes\",\"value\":\"Yes\"},{\"label\":\"No\",\"value\":\"No\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"oneLine\":true},\"N5r0JM4Xa\":{\"id\":31,\"hash\":\"N5r0JM4Xa\",\"type\":\"radio_group\",\"handle\":\"aCRSupplyLocation\",\"label\":\"ACR Supply Location\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Durham\",\"options\":[{\"label\":\"Durham\",\"value\":\"Durham\"},{\"label\":\"Carrboro\",\"value\":\"Carrboro\"},{\"label\":\"Burlington\",\"value\":\"Burlington\"},{\"label\":\"Greensboro\",\"value\":\"Greensboro\"},{\"label\":\"Raleigh\",\"value\":\"Raleigh\"},{\"label\":\"Winston-Salem\",\"value\":\"Winston-Salem\"},{\"label\":\"Greenville\",\"value\":\"Greenville\"},{\"label\":\"Wilmington\",\"value\":\"Wilmington\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"values\":[]},\"arWeva0vy\":{\"id\":32,\"hash\":\"arWeva0vy\",\"type\":\"radio_group\",\"handle\":\"invoiceDeliveryPreference\",\"label\":\"Invoice Delivery Preference\",\"required\":true,\"instructions\":\"\",\"showCustomValues\":false,\"value\":\"Email\",\"options\":[{\"label\":\"Email\",\"value\":\"Email\"},{\"label\":\"Fax\",\"value\":\"Fax\"},{\"label\":\"No invoice copies, Statements only\",\"value\":\"No invoice copies, Statements only\"}],\"source\":\"custom\",\"target\":null,\"configuration\":null,\"oneLine\":true,\"values\":[]},\"N6n0lVZGa\":{\"id\":33,\"hash\":\"N6n0lVZGa\",\"type\":\"textarea\",\"handle\":\"references\",\"label\":\"References\",\"required\":false,\"instructions\":\"Please add a minimum of 3 references.\\n\\nPlease give full name and address of businesses where you have purchased goods using an open account.\",\"value\":\"\",\"placeholder\":\"\",\"rows\":2,\"instructionAttributes\":[{\"attribute\":\"class\",\"value\":\"input-description\"}]},\"qlGKxkrVP\":{\"type\":\"submit\",\"label\":\"Submit\",\"labelNext\":\"Submit\",\"labelPrev\":\"Previous\",\"disablePrev\":false,\"position\":\"left\"}}},\"context\":{\"page\":0,\"hash\":\"N6n0lVZGa\"}}','',2,NULL,'#1e5385',NULL,'2019-01-24 02:35:03','2019-01-24 03:02:07','3ee8975c-964e-4643-95e3-eddc04cf16e4');
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
INSERT INTO `acr_info` VALUES (1,'3.1.6.1','3.1.23',0,'a:17:{s:12:\"dateModified\";i:1548904932;s:10:\"siteGroups\";a:1:{s:36:\"29730c2c-25c9-4557-aa1a-247b9f593b50\";a:1:{s:4:\"name\";s:14:\"ACR Supply Co.\";}}s:5:\"sites\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:8:{s:4:\"name\";s:14:\"ACR Supply Co.\";s:6:\"handle\";s:7:\"default\";s:8:\"language\";s:5:\"en-US\";s:7:\"hasUrls\";s:1:\"1\";s:7:\"baseUrl\";s:5:\"@web/\";s:9:\"sortOrder\";s:1:\"1\";s:7:\"primary\";s:1:\"1\";s:9:\"siteGroup\";s:36:\"29730c2c-25c9-4557-aa1a-247b9f593b50\";}}s:8:\"sections\";a:16:{s:36:\"fc6457f4-0483-4d21-a704-9f47893b5ada\";a:7:{s:4:\"name\";s:5:\"About\";s:6:\"handle\";s:5:\"about\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"3763008a-e976-465a-b92f-9309836c9be0\";a:7:{s:4:\"name\";s:5:\"About\";s:6:\"handle\";s:5:\"about\";s:13:\"hasTitleField\";s:1:\"1\";s:10:\"titleLabel\";s:10:\"Page Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"d54ded79-c194-433a-ab8f-688521561942\";a:1:{s:4:\"tabs\";a:0:{}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:5:\"about\";s:8:\"template\";s:5:\"about\";}}}s:36:\"deefb807-a3f2-4b77-9b48-aa6bd8864f7f\";a:7:{s:4:\"name\";s:10:\"Promotions\";s:6:\"handle\";s:10:\"promotions\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"b4a92b05-e940-4b60-b063-e03b8e8ed290\";a:7:{s:4:\"name\";s:10:\"Promotions\";s:6:\"handle\";s:10:\"promotions\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";s:0:\"\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"416230ab-5b37-4f4c-8ede-32e9fba6164b\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:8:\"Settings\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"301600aa-e3fc-4ac2-9dfc-7b599eb1f1fc\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"a207db43-6f70-4166-9f80-4694e159fd67\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:17:\"promotions/{slug}\";s:8:\"template\";s:17:\"promotions/_entry\";}}}s:36:\"148a408c-a3e0-469e-aa18-46200336c446\";a:7:{s:4:\"name\";s:4:\"Home\";s:6:\"handle\";s:4:\"home\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"89e916b0-48ff-4c47-b285-bea42a6de1eb\";a:7:{s:4:\"name\";s:4:\"Home\";s:6:\"handle\";s:4:\"home\";s:13:\"hasTitleField\";s:1:\"0\";s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"50e9b4f2-ddf3-409f-be4f-cd314baaee51\";a:1:{s:4:\"tabs\";a:3:{i:0;a:3:{s:4:\"name\";s:8:\"Services\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:3:{s:36:\"d1e02aa7-b33b-49c4-a198-dae3f462e65a\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"a07789b8-1f0d-4fae-ac9c-52f01e112769\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"a4ac9646-eeb8-4757-99be-592e59cf2acb\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}}}i:1;a:3:{s:4:\"name\";s:13:\"50/50 Section\";s:9:\"sortOrder\";s:1:\"2\";s:6:\"fields\";a:1:{s:36:\"f4c519dd-a990-40e1-a0c9-696bbe1ab8fc\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}}}i:2;a:3:{s:4:\"name\";s:10:\"Newsletter\";s:9:\"sortOrder\";s:1:\"3\";s:6:\"fields\";a:3:{s:36:\"1bc2be8f-63f9-4d51-8d5c-3d07b7c84ed5\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"c2b3d873-50c8-4e57-820d-6aa965f39b79\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"c56d653e-9e7d-4ef9-aa84-7ec8606d088c\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:8:\"__home__\";s:8:\"template\";s:10:\"index.html\";}}}s:36:\"c3c14b51-1050-404a-b79d-ac586030e8a4\";a:7:{s:4:\"name\";s:13:\"Notifications\";s:6:\"handle\";s:13:\"notifications\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"cc5c88c2-6256-43b6-accc-6866de536e42\";a:7:{s:4:\"name\";s:13:\"Notifications\";s:6:\"handle\";s:13:\"notifications\";s:13:\"hasTitleField\";s:1:\"1\";s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"e9678a4c-360c-483a-a91f-9dff15e607c8\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:24:\"Notification Information\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:2:{s:36:\"e7ff456f-d45d-43e0-bc06-9c9ffe9468f2\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"6ecf8a37-13bc-46bc-afd1-e9505338259d\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:20:\"notifications/{slug}\";s:8:\"template\";s:20:\"notifications/_entry\";}}}s:36:\"33cd06cd-ae75-4b06-ae73-5ab87ecf2963\";a:7:{s:4:\"name\";s:12:\"Testimonials\";s:6:\"handle\";s:12:\"testimonials\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"4aecf25f-7fd2-4fac-86f9-571abb544b3b\";a:7:{s:4:\"name\";s:12:\"Testimonials\";s:6:\"handle\";s:12:\"testimonials\";s:13:\"hasTitleField\";s:1:\"1\";s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"fbe40f7a-faae-4d94-b250-3f1c367c966e\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:19:\"Testimonial Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:2:{s:36:\"4de3e644-b5ec-4104-89c5-3449fa4175b2\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"06a1d088-9aea-4440-8997-c731e1282b28\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:19:\"testimonials/{slug}\";s:8:\"template\";s:19:\"testimonials/_entry\";}}}s:36:\"b19546f5-4ea4-4336-8cd0-1623e4279468\";a:7:{s:4:\"name\";s:9:\"Locations\";s:6:\"handle\";s:9:\"locations\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";s:1:\"1\";s:16:\"propagateEntries\";s:1:\"1\";s:10:\"entryTypes\";a:1:{s:36:\"6158f0a0-0d2b-4e2c-a79e-ae3ae8ef5498\";a:7:{s:4:\"name\";s:9:\"Locations\";s:6:\"handle\";s:9:\"locations\";s:13:\"hasTitleField\";s:1:\"0\";s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";s:1:\"1\";s:12:\"fieldLayouts\";a:1:{s:36:\"dbb7b849-058e-4556-8ed1-440fed40ef31\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:17:\"Locations Listing\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:1:{s:36:\"ede61ed2-c66a-4d59-8ef2-a5b1f3630dda\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}}}}}}}}s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";s:1:\"1\";s:7:\"hasUrls\";s:1:\"1\";s:9:\"uriFormat\";s:9:\"locations\";s:8:\"template\";s:9:\"locations\";}}}s:36:\"8b99fb28-9536-4c55-8adc-cff3e561baff\";a:7:{s:4:\"name\";s:9:\"ACR Cares\";s:6:\"handle\";s:8:\"acrCares\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:9:\"acr-cares\";s:8:\"template\";s:8:\"acrCares\";}}s:10:\"entryTypes\";a:1:{s:36:\"43601a53-dddf-44fd-96ff-e5034fe169d1\";a:7:{s:4:\"name\";s:9:\"ACR Cares\";s:6:\"handle\";s:8:\"acrCares\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";s:0:\"\";s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"5a96d75b-bcb5-45a8-b004-87efea6204ec\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:11:\"Initiatives\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"afceddc5-9590-4182-abf6-bb387268c36d\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"68d45d5a-b25d-4eba-9741-54d6ab9ff499\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}}}}}}}}s:36:\"720bf92c-3db9-49d3-8814-2a047cb85e8c\";a:7:{s:4:\"name\";s:7:\"Contact\";s:6:\"handle\";s:7:\"contact\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:7:\"contact\";s:8:\"template\";s:7:\"contact\";}}s:10:\"entryTypes\";a:1:{s:36:\"6ce85c89-9cc3-4180-9af7-0f2109ab5dde\";a:6:{s:4:\"name\";s:7:\"Contact\";s:6:\"handle\";s:7:\"contact\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"6fbf9061-9641-4350-9e34-a974e674a2e9\";a:7:{s:4:\"name\";s:23:\"Request E-Store Account\";s:6:\"handle\";s:6:\"eStore\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:23:\"request-e-store-account\";s:8:\"template\";s:6:\"eStore\";}}s:10:\"entryTypes\";a:1:{s:36:\"2228d5f0-f6f0-4be9-af9b-b14f7c9a65ff\";a:6:{s:4:\"name\";s:23:\"Request E-Store Account\";s:6:\"handle\";s:6:\"eStore\";s:13:\"hasTitleField\";s:1:\"0\";s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"4d4a42c3-dac6-4331-8d12-fe4460f697d1\";a:7:{s:4:\"name\";s:26:\"E-Store Credit Application\";s:6:\"handle\";s:23:\"eStoreCreditApplication\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:25:\"estore-credit-application\";s:8:\"template\";s:12:\"eStoreCredit\";}}s:10:\"entryTypes\";a:1:{s:36:\"e0180887-e30e-4628-aa32-08b1842ee5f0\";a:6:{s:4:\"name\";s:26:\"E-Store Credit Application\";s:6:\"handle\";s:23:\"eStoreCreditApplication\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";i:1;}}}s:36:\"f7d15cfa-53c3-4526-ab2d-84124c9f1d2f\";a:7:{s:4:\"name\";s:10:\"Pay Online\";s:6:\"handle\";s:9:\"payOnline\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:10:\"pay-online\";s:8:\"template\";s:9:\"payOnline\";}}s:10:\"entryTypes\";a:1:{s:36:\"2cc1817d-2570-4954-a8aa-b57c5e5eeda1\";a:6:{s:4:\"name\";s:10:\"Pay Online\";s:6:\"handle\";s:9:\"payOnline\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"ab2deffb-873a-4836-82c1-42b602c2b02f\";a:7:{s:4:\"name\";s:22:\"Training and Education\";s:6:\"handle\";s:20:\"trainingAndEducation\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:22:\"training-and-education\";s:8:\"template\";s:20:\"trainingAndEducation\";}}s:10:\"entryTypes\";a:1:{s:36:\"78c5241d-877a-4e91-8ac5-836bb161279b\";a:6:{s:4:\"name\";s:22:\"Training and Education\";s:6:\"handle\";s:20:\"trainingAndEducation\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"b94ea8c9-c5ce-4409-b4d6-1bce2ead4787\";a:7:{s:4:\"name\";s:12:\"Scholarships\";s:6:\"handle\";s:12:\"scholarships\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:12:\"scholarships\";s:8:\"template\";s:12:\"scholarships\";}}s:10:\"entryTypes\";a:1:{s:36:\"ff374fa6-3141-4a64-be08-6fcae035a8fe\";a:6:{s:4:\"name\";s:12:\"Scholarships\";s:6:\"handle\";s:12:\"scholarships\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"b766f97e-4a11-4234-b7a0-86790e70977e\";a:7:{s:4:\"name\";s:7:\"Careers\";s:6:\"handle\";s:7:\"careers\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:7:\"careers\";s:8:\"template\";s:7:\"careers\";}}s:10:\"entryTypes\";a:1:{s:36:\"d28af146-9297-4753-8222-0708a5cbf5aa\";a:6:{s:4:\"name\";s:7:\"Careers\";s:6:\"handle\";s:7:\"careers\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"2ab94a27-43de-4c5d-99b7-f5a5667c2fde\";a:7:{s:4:\"name\";s:10:\"Associates\";s:6:\"handle\";s:10:\"associates\";s:4:\"type\";s:6:\"single\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:10:\"associates\";s:8:\"template\";s:10:\"associates\";}}s:10:\"entryTypes\";a:1:{s:36:\"47bb783e-b48b-4ed6-9e79-b1a308939085\";a:6:{s:4:\"name\";s:10:\"Associates\";s:6:\"handle\";s:10:\"associates\";s:13:\"hasTitleField\";b:0;s:10:\"titleLabel\";N;s:11:\"titleFormat\";s:18:\"{section.name|raw}\";s:9:\"sortOrder\";i:1;}}}s:36:\"aa8de52f-f0b3-4669-b39b-86de1ea3266e\";a:8:{s:4:\"name\";s:5:\"Pages\";s:6:\"handle\";s:5:\"pages\";s:4:\"type\";s:9:\"structure\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"d84c7a06-9ecd-42c4-b65c-ec087c3bba35\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:12:\"pages/{slug}\";s:8:\"template\";s:0:\"\";}}s:9:\"structure\";a:2:{s:3:\"uid\";s:36:\"f07ef9da-1139-41e6-b5a3-e61c6fef2735\";s:9:\"maxLevels\";s:1:\"2\";}s:10:\"entryTypes\";a:1:{s:36:\"6fcb7060-ebde-4e32-963e-b9a094be6ab7\";a:6:{s:4:\"name\";s:5:\"Pages\";s:6:\"handle\";s:5:\"pages\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";N;s:9:\"sortOrder\";i:1;}}}}s:11:\"fieldGroups\";a:7:{s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";a:1:{s:4:\"name\";s:6:\"Common\";}s:36:\"75772b73-5f13-442a-b9a8-8c5a6015f039\";a:1:{s:4:\"name\";s:13:\"Notifications\";}s:36:\"d0819d73-9155-4ac5-9995-9fe3d7c32c74\";a:1:{s:4:\"name\";s:8:\"Services\";}s:36:\"28b86dd3-c932-453a-ad70-b5c437d0c06b\";a:1:{s:4:\"name\";s:4:\"Home\";}s:36:\"3a435df0-e9ed-4290-a496-2073b7800d15\";a:1:{s:4:\"name\";s:12:\"Testimonials\";}s:36:\"77926385-cc33-4146-a9d8-bb682af7623a\";a:1:{s:4:\"name\";s:10:\"Newsletter\";}s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";a:1:{s:4:\"name\";s:6:\"Global\";}}s:6:\"fields\";a:23:{s:36:\"f988b15f-c79d-4498-8900-22b3859c00cc\";a:10:{s:4:\"name\";s:12:\"Single Image\";s:6:\"handle\";s:11:\"singleImage\";s:12:\"instructions\";s:31:\"Add a single image to the page.\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:1:\"1\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:27:\"singleUploadLocationSubpath\";s:10:\"promotions\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:12:\"Add an image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"a207db43-6f70-4166-9f80-4694e159fd67\";a:10:{s:4:\"name\";s:9:\"Page Link\";s:6:\"handle\";s:8:\"pageLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:8:{s:15:\"allowCustomText\";s:1:\"1\";s:16:\"allowedLinkNames\";a:5:{i:3;s:5:\"entry\";i:4;s:4:\"site\";i:7;s:5:\"email\";i:8;s:3:\"tel\";i:9;s:3:\"url\";}s:11:\"allowTarget\";s:1:\"1\";s:15:\"defaultLinkName\";s:5:\"entry\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:1:\"1\";s:11:\"enableTitle\";s:1:\"1\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:1:{s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:1:{s:7:\"sources\";s:1:\"*\";}s:5:\"entry\";a:1:{s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:1:{s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"6ecf8a37-13bc-46bc-afd1-e9505338259d\";a:10:{s:4:\"name\";s:17:\"Notification Text\";s:6:\"handle\";s:16:\"notificationText\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"75772b73-5f13-442a-b9a8-8c5a6015f039\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"e7ff456f-d45d-43e0-bc06-9c9ffe9468f2\";a:10:{s:4:\"name\";s:17:\"Notification Link\";s:6:\"handle\";s:16:\"notificationLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:8:{s:15:\"allowCustomText\";s:1:\"1\";s:16:\"allowedLinkNames\";a:2:{i:3;s:5:\"entry\";i:9;s:3:\"url\";}s:11:\"allowTarget\";s:1:\"1\";s:15:\"defaultLinkName\";s:3:\"url\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:0:\"\";s:11:\"enableTitle\";s:0:\"\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:1:{s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:1:{s:7:\"sources\";s:1:\"*\";}s:5:\"entry\";a:1:{s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:1:{s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:10:\"fieldGroup\";s:36:\"75772b73-5f13-442a-b9a8-8c5a6015f039\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"d1e02aa7-b33b-49c4-a198-dae3f462e65a\";a:10:{s:4:\"name\";s:5:\"Title\";s:6:\"handle\";s:13:\"servicesTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"d0819d73-9155-4ac5-9995-9fe3d7c32c74\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"a07789b8-1f0d-4fae-ac9c-52f01e112769\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:19:\"servicesDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"d0819d73-9155-4ac5-9995-9fe3d7c32c74\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"a4ac9646-eeb8-4757-99be-592e59cf2acb\";a:10:{s:4:\"name\";s:8:\"Services\";s:6:\"handle\";s:8:\"services\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:1:\"1\";s:9:\"maxBlocks\";s:1:\"6\";s:12:\"contentTable\";s:27:\"{{%matrixcontent_services}}\";s:14:\"localizeBlocks\";b:0;}s:10:\"fieldGroup\";s:36:\"d0819d73-9155-4ac5-9995-9fe3d7c32c74\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"f4c519dd-a990-40e1-a0c9-696bbe1ab8fc\";a:10:{s:4:\"name\";s:4:\"CTAs\";s:6:\"handle\";s:4:\"ctas\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:23:\"{{%matrixcontent_ctas}}\";s:14:\"localizeBlocks\";b:0;}s:10:\"fieldGroup\";s:36:\"28b86dd3-c932-453a-ad70-b5c437d0c06b\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"4de3e644-b5ec-4104-89c5-3449fa4175b2\";a:10:{s:4:\"name\";s:6:\"Author\";s:6:\"handle\";s:17:\"testimonialAuthor\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"3a435df0-e9ed-4290-a496-2073b7800d15\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"06a1d088-9aea-4440-8997-c731e1282b28\";a:10:{s:4:\"name\";s:7:\"Content\";s:6:\"handle\";s:17:\"testimonalcontent\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:1:\"1\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"3a435df0-e9ed-4290-a496-2073b7800d15\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"c56d653e-9e7d-4ef9-aa84-7ec8606d088c\";a:10:{s:4:\"name\";s:5:\"Image\";s:6:\"handle\";s:15:\"newsletterImage\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:12:\"Add an image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"77926385-cc33-4146-a9d8-bb682af7623a\";}s:36:\"1bc2be8f-63f9-4d51-8d5c-3d07b7c84ed5\";a:10:{s:4:\"name\";s:5:\"Title\";s:6:\"handle\";s:15:\"newsletterTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"77926385-cc33-4146-a9d8-bb682af7623a\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"c2b3d873-50c8-4e57-820d-6aa965f39b79\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:21:\"newsletterDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"77926385-cc33-4146-a9d8-bb682af7623a\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"2454409f-dfb2-45e4-b6fc-3ef708639b05\";a:10:{s:4:\"name\";s:13:\"External Link\";s:6:\"handle\";s:12:\"externalLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:16:\"craft\\fields\\Url\";s:8:\"settings\";a:1:{s:11:\"placeholder\";s:0:\"\";}s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"009e6ae8-8fde-401d-a29e-784a1170ebfd\";a:10:{s:4:\"name\";s:16:\"Apple Store LInk\";s:6:\"handle\";s:14:\"appleStoreLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:16:\"craft\\fields\\Url\";s:8:\"settings\";a:1:{s:11:\"placeholder\";s:0:\"\";}s:10:\"fieldGroup\";s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"654aca73-0f2c-4695-89ba-4bd3e6db1e42\";a:10:{s:4:\"name\";s:22:\"Google Play Store LInk\";s:6:\"handle\";s:19:\"googlePlayStoreLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:16:\"craft\\fields\\Url\";s:8:\"settings\";a:1:{s:11:\"placeholder\";s:0:\"\";}s:10:\"fieldGroup\";s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"13e8e656-c68f-463c-86e6-b51e83c7d2a1\";a:10:{s:4:\"name\";s:13:\"Facebook Link\";s:6:\"handle\";s:12:\"facebookLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:16:\"craft\\fields\\Url\";s:8:\"settings\";a:1:{s:11:\"placeholder\";s:0:\"\";}s:10:\"fieldGroup\";s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"d43389b3-5eea-455f-8ea2-d05f6a5ec556\";a:10:{s:4:\"name\";s:11:\"Footer Logo\";s:6:\"handle\";s:10:\"footerLogo\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:0:\"\";s:12:\"allowedKinds\";N;s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:0:\"\";s:17:\"localizeRelations\";b:0;}s:10:\"fieldGroup\";s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"877d25f5-76f5-467b-9739-03e87cdffbbe\";a:10:{s:4:\"name\";s:14:\"Footer Tagline\";s:6:\"handle\";s:13:\"footerTagline\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";s:36:\"7a86ba31-dc42-491b-9a15-47a006756d8b\";s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"ede61ed2-c66a-4d59-8ef2-a5b1f3630dda\";a:10:{s:4:\"name\";s:9:\"Locations\";s:6:\"handle\";s:9:\"locations\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:28:\"{{%matrixcontent_locations}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"afceddc5-9590-4182-abf6-bb387268c36d\";a:10:{s:4:\"name\";s:21:\"ACR Cares Initiatives\";s:6:\"handle\";s:19:\"acrCaresInitiatives\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:38:\"{{%matrixcontent_acrcaresinitiatives}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"68d45d5a-b25d-4eba-9741-54d6ab9ff499\";a:10:{s:4:\"name\";s:23:\"Team Member Initiatives\";s:6:\"handle\";s:21:\"teamMemberInitiatives\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:40:\"{{%matrixcontent_teammemberinitiatives}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}s:36:\"301600aa-e3fc-4ac2-9dfc-7b599eb1f1fc\";a:10:{s:4:\"name\";s:15:\"Promotion Image\";s:6:\"handle\";s:14:\"promotionImage\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:1:\"1\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:98af559e-fbd3-426a-aada-0f8e6fe41d61\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:98af559e-fbd3-426a-aada-0f8e6fe41d61\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:1:\"1\";s:12:\"allowedKinds\";a:1:{i:0;s:5:\"image\";}s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:12:\"Add an Image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"d1b2d3e0-caff-4265-8c15-310da7c6b14f\";}}s:16:\"matrixBlockTypes\";a:5:{s:36:\"ad0dc2b4-7b01-48f6-9596-8c8dad66a4b1\";a:6:{s:4:\"name\";s:7:\"Service\";s:6:\"handle\";s:7:\"service\";s:9:\"sortOrder\";s:1:\"1\";s:5:\"field\";s:36:\"a4ac9646-eeb8-4757-99be-592e59cf2acb\";s:12:\"fieldLayouts\";a:1:{s:36:\"bbb4f2b3-f970-48bc-b558-4c21dcf0d911\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:3:{s:36:\"54f564b2-6d31-46e7-a148-ca738ab72142\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"28cf2be5-8f7e-4677-b055-7b02264a5217\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"2e5417ea-9053-4e0f-9f16-0301f26dcf2a\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}}}}}}s:6:\"fields\";a:3:{s:36:\"54f564b2-6d31-46e7-a148-ca738ab72142\";a:10:{s:4:\"name\";s:5:\"Title\";s:6:\"handle\";s:12:\"serviceTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"28cf2be5-8f7e-4677-b055-7b02264a5217\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:18:\"serviceDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"2e5417ea-9053-4e0f-9f16-0301f26dcf2a\";a:10:{s:4:\"name\";s:4:\"Link\";s:6:\"handle\";s:11:\"serviceLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:8:{s:15:\"allowCustomText\";s:1:\"1\";s:16:\"allowedLinkNames\";a:2:{i:3;s:5:\"entry\";i:9;s:3:\"url\";}s:11:\"allowTarget\";s:0:\"\";s:15:\"defaultLinkName\";s:5:\"entry\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:0:\"\";s:11:\"enableTitle\";s:0:\"\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:1:{s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:1:{s:7:\"sources\";s:1:\"*\";}s:5:\"entry\";a:1:{s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:1:{s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}}}s:36:\"a18a4a20-6a90-4d48-8995-8ab7941dcc11\";a:6:{s:4:\"name\";s:14:\"Call To Action\";s:6:\"handle\";s:12:\"callToAction\";s:9:\"sortOrder\";s:1:\"1\";s:5:\"field\";s:36:\"f4c519dd-a990-40e1-a0c9-696bbe1ab8fc\";s:12:\"fieldLayouts\";a:1:{s:36:\"6d5c94c9-83a9-4be7-af5f-8189aeb32f4c\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:5:{s:36:\"3dee8338-1e08-4d25-bdde-b00ee509d056\";a:2:{s:8:\"required\";s:1:\"1\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"fce33d4d-1efd-4868-8cbe-9f00ddbb8fa6\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"9938542d-a4f6-4f92-96a8-c8bcc7818139\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}s:36:\"93c4bbd8-db6c-4a65-987f-b31e3462b6c4\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"4\";}s:36:\"16531a44-dbf0-4400-bcdd-ecdad520a697\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"5\";}}}}}}s:6:\"fields\";a:5:{s:36:\"3dee8338-1e08-4d25-bdde-b00ee509d056\";a:10:{s:4:\"name\";s:20:\"Call to Action Title\";s:6:\"handle\";s:17:\"callToActionTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"fce33d4d-1efd-4868-8cbe-9f00ddbb8fa6\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:23:\"callToActionDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}s:36:\"9938542d-a4f6-4f92-96a8-c8bcc7818139\";a:10:{s:4:\"name\";s:5:\"Image\";s:6:\"handle\";s:17:\"callToActionImage\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:0:\"\";s:12:\"allowedKinds\";N;s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:0:\"\";s:14:\"selectionLabel\";s:0:\"\";s:17:\"localizeRelations\";b:0;}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"93c4bbd8-db6c-4a65-987f-b31e3462b6c4\";a:10:{s:4:\"name\";s:16:\"Background Color\";s:6:\"handle\";s:27:\"callToActionBackgroundColor\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:25:\"craft\\fields\\RadioButtons\";s:8:\"settings\";a:1:{s:7:\"options\";a:2:{i:0;a:3:{s:5:\"label\";s:3:\"Red\";s:5:\"value\";s:3:\"red\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:4:\"Blue\";s:5:\"value\";s:4:\"blue\";s:7:\"default\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:6:\"string\";}s:36:\"16531a44-dbf0-4400-bcdd-ecdad520a697\";a:10:{s:4:\"name\";s:4:\"Link\";s:6:\"handle\";s:16:\"callToActionLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";s:1:\"1\";s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:31:\"typedlinkfield\\fields\\LinkField\";s:8:\"settings\";a:8:{s:15:\"allowCustomText\";s:1:\"1\";s:16:\"allowedLinkNames\";a:6:{i:3;s:5:\"entry\";i:4;s:4:\"site\";i:6;s:6:\"custom\";i:7;s:5:\"email\";i:8;s:3:\"tel\";i:9;s:3:\"url\";}s:11:\"allowTarget\";s:0:\"\";s:15:\"defaultLinkName\";s:5:\"asset\";s:11:\"defaultText\";s:0:\"\";s:15:\"enableAriaLabel\";s:0:\"\";s:11:\"enableTitle\";s:0:\"\";s:12:\"typeSettings\";a:9:{s:5:\"asset\";a:1:{s:7:\"sources\";s:1:\"*\";}s:8:\"category\";a:1:{s:7:\"sources\";s:1:\"*\";}s:5:\"entry\";a:1:{s:7:\"sources\";s:1:\"*\";}s:4:\"site\";a:1:{s:5:\"sites\";s:1:\"*\";}s:4:\"user\";a:1:{s:7:\"sources\";s:1:\"*\";}s:6:\"custom\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:5:\"email\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"tel\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}s:3:\"url\";a:2:{s:17:\"disableValidation\";s:0:\"\";s:12:\"allowAliases\";s:0:\"\";}}}s:10:\"fieldGroup\";N;s:17:\"contentColumnType\";s:4:\"text\";}}}s:36:\"c773ee36-d4bd-4d3c-8a25-e904a163d34e\";a:6:{s:5:\"field\";s:36:\"ede61ed2-c66a-4d59-8ef2-a5b1f3630dda\";s:4:\"name\";s:14:\"Store Location\";s:6:\"handle\";s:13:\"storeLocation\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:4:{s:36:\"5d063c02-f819-4258-82df-5a5ec9568e0a\";a:10:{s:4:\"name\";s:4:\"Name\";s:6:\"handle\";s:12:\"locationName\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"701fee08-7b80-4ba0-981f-7212238bb0d5\";a:10:{s:4:\"name\";s:7:\"Address\";s:6:\"handle\";s:7:\"address\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:1:\"1\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"cf1d4f60-e469-4979-89db-5395eeacf025\";a:10:{s:4:\"name\";s:12:\"Phone Number\";s:6:\"handle\";s:11:\"phoneNumber\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"ecdf0853-6e09-413b-b63f-2a03ea7a9a1b\";a:10:{s:4:\"name\";s:15:\"Google Map Link\";s:6:\"handle\";s:13:\"googleMapLink\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:16:\"craft\\fields\\Url\";s:8:\"settings\";a:1:{s:11:\"placeholder\";s:0:\"\";}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"5ea35531-4f32-434f-8ab9-27d853b46432\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:4:{s:36:\"5d063c02-f819-4258-82df-5a5ec9568e0a\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"701fee08-7b80-4ba0-981f-7212238bb0d5\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"cf1d4f60-e469-4979-89db-5395eeacf025\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"ecdf0853-6e09-413b-b63f-2a03ea7a9a1b\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}}}}}}}s:36:\"cd5cbfa7-0720-49c3-8c87-eca987b0e498\";a:6:{s:5:\"field\";s:36:\"afceddc5-9590-4182-abf6-bb387268c36d\";s:4:\"name\";s:10:\"Initiative\";s:6:\"handle\";s:10:\"initiative\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"5004af34-6543-4cb8-a1c3-157bf57abd95\";a:10:{s:4:\"name\";s:5:\"Title\";s:6:\"handle\";s:15:\"initiativeTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"8c95b6b9-ce93-4231-942f-7d44e4a0d9a8\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:21:\"initiativeDescription\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"8e770b24-247e-49ec-978f-1cbe2a2d8bec\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"5004af34-6543-4cb8-a1c3-157bf57abd95\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"8c95b6b9-ce93-4231-942f-7d44e4a0d9a8\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}}}}}}s:36:\"3334d866-45d7-4fa3-b627-7c7470d3687a\";a:6:{s:5:\"field\";s:36:\"68d45d5a-b25d-4eba-9741-54d6ab9ff499\";s:4:\"name\";s:10:\"Initiative\";s:6:\"handle\";s:14:\"teamInitiative\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"9f53424a-206a-4123-bd8f-9ab550dbf4d8\";a:10:{s:4:\"name\";s:5:\"Title\";s:6:\"handle\";s:15:\"initiativeTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"e2264f39-c7a9-4baa-b4a8-e1add7ff7a89\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"9f53424a-206a-4123-bd8f-9ab550dbf4d8\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}}}}}}}s:7:\"volumes\";a:2:{s:36:\"0d114c35-470e-4a92-bbc0-a2c3e7d4fc8e\";a:7:{s:4:\"name\";s:6:\"Global\";s:6:\"handle\";s:6:\"global\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";b:1;s:3:\"url\";s:14:\"/assets/images\";s:8:\"settings\";a:1:{s:4:\"path\";s:22:\"@webroot/assets/images\";}s:9:\"sortOrder\";s:1:\"1\";}s:36:\"98af559e-fbd3-426a-aada-0f8e6fe41d61\";a:7:{s:4:\"name\";s:10:\"Promotions\";s:6:\"handle\";s:10:\"promotions\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";b:1;s:3:\"url\";s:25:\"/assets/images/promotions\";s:8:\"settings\";a:1:{s:4:\"path\";s:33:\"@webroot/assets/images/promotions\";}s:9:\"sortOrder\";N;}}s:14:\"categoryGroups\";a:0:{}s:9:\"tagGroups\";a:0:{}s:5:\"users\";a:5:{s:24:\"requireEmailVerification\";b:1;s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:14:\"photoVolumeUid\";N;s:12:\"photoSubpath\";s:0:\"\";}s:10:\"globalSets\";a:3:{s:36:\"a864a755-a5b5-4afd-8cfa-e091c506065e\";a:3:{s:4:\"name\";s:16:\"Site Information\";s:6:\"handle\";s:15:\"siteInformation\";s:12:\"fieldLayouts\";a:1:{s:36:\"54e4880b-8f72-49a9-8732-0bacdc5c96b7\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:24:\"General Site Information\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:1:{s:36:\"f988b15f-c79d-4498-8900-22b3859c00cc\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}}}}}}}s:36:\"7ef45d2a-aba2-4285-a33c-7fe1f360634e\";a:3:{s:4:\"name\";s:18:\"Footer Information\";s:6:\"handle\";s:17:\"footerInformation\";s:12:\"fieldLayouts\";a:1:{s:36:\"160be074-78ff-4339-b327-91a2f57bf793\";a:1:{s:4:\"tabs\";a:2:{i:0;a:3:{s:4:\"name\";s:7:\"General\";s:9:\"sortOrder\";s:1:\"1\";s:6:\"fields\";a:1:{s:36:\"877d25f5-76f5-467b-9739-03e87cdffbbe\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}}}i:1;a:3:{s:4:\"name\";s:5:\"Links\";s:9:\"sortOrder\";s:1:\"2\";s:6:\"fields\";a:3:{s:36:\"009e6ae8-8fde-401d-a29e-784a1170ebfd\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"1\";}s:36:\"654aca73-0f2c-4695-89ba-4bd3e6db1e42\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"2\";}s:36:\"13e8e656-c68f-463c-86e6-b51e83c7d2a1\";a:2:{s:8:\"required\";s:1:\"0\";s:9:\"sortOrder\";s:1:\"3\";}}}}}}}s:36:\"457c7d37-f5db-462b-9cde-df74024ec539\";a:3:{s:4:\"name\";s:10:\"Newsletter\";s:6:\"handle\";s:10:\"newsletter\";s:12:\"fieldLayouts\";a:1:{s:36:\"928d3988-5927-4713-b134-fad5ce7b6342\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:8:\"Settings\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:3:{s:36:\"c56d653e-9e7d-4ef9-aa84-7ec8606d088c\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"1bc2be8f-63f9-4d51-8d5c-3d07b7c84ed5\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"c2b3d873-50c8-4e57-820d-6aa965f39b79\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}}}}}}}}s:7:\"plugins\";a:5:{s:11:\"element-api\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:6:\"locate\";a:4:{s:8:\"settings\";a:2:{s:16:\"googleMapsApiKey\";s:39:\"AIzaSyAk6zLZpAFtgZGHt7IThIhAeqihEckOIrQ\";s:19:\"autocompleteOptions\";s:0:\"\";}s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"2.0.2\";}s:14:\"typedlinkfield\";a:4:{s:8:\"settings\";N;s:10:\"licenseKey\";N;s:7:\"enabled\";s:1:\"1\";s:13:\"schemaVersion\";s:5:\"1.0.0\";}s:8:\"freeform\";a:4:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"2.1.3\";s:8:\"settings\";a:34:{s:10:\"pluginName\";s:5:\"Forms\";s:21:\"formTemplateDirectory\";N;s:22:\"emailTemplateDirectory\";N;s:20:\"emailTemplateStorage\";s:2:\"db\";s:11:\"defaultView\";s:9:\"dashboard\";s:17:\"fieldDisplayOrder\";s:4:\"name\";s:12:\"showTutorial\";b:0;s:14:\"removeNewlines\";s:0:\"\";s:16:\"defaultTemplates\";s:1:\"1\";s:13:\"footerScripts\";s:1:\"0\";s:17:\"formSubmitDisable\";s:0:\"\";s:16:\"freeformHoneypot\";b:1;s:23:\"spamProtectionBehaviour\";s:16:\"simulate_success\";s:25:\"submissionThrottlingCount\";N;s:29:\"submissionThrottlingTimeFrame\";N;s:13:\"blockedEmails\";N;s:15:\"blockedKeywords\";N;s:20:\"blockedKeywordsError\";s:18:\"Invalid Entry Data\";s:18:\"blockedEmailsError\";s:21:\"Invalid Email Address\";s:26:\"showErrorsForBlockedEmails\";b:0;s:28:\"showErrorsForBlockedKeywords\";b:0;s:18:\"blockedIpAddresses\";N;s:27:\"purgableSubmissionAgeInDays\";s:1:\"0\";s:21:\"purgableSpamAgeInDays\";N;s:20:\"salesforce_client_id\";N;s:24:\"salesforce_client_secret\";N;s:19:\"salesforce_username\";N;s:19:\"salesforce_password\";N;s:17:\"spamFolderEnabled\";b:0;s:16:\"recaptchaEnabled\";b:0;s:12:\"recaptchaKey\";N;s:15:\"recaptchaSecret\";N;s:23:\"renderFormHtmlInCpViews\";s:1:\"1\";s:18:\"autoScrollToErrors\";s:1:\"1\";}}s:4:\"copy\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}}s:5:\"email\";a:3:{s:9:\"fromEmail\";s:23:\"wesley.cole87@gmail.com\";s:8:\"fromName\";s:14:\"ACR Supply Co.\";s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";}s:6:\"system\";a:5:{s:7:\"edition\";s:4:\"solo\";s:4:\"live\";b:1;s:4:\"name\";s:14:\"ACR Supply Co.\";s:8:\"timeZone\";s:16:\"America/New_York\";s:13:\"schemaVersion\";s:6:\"3.1.23\";}s:15:\"imageTransforms\";a:0:{}s:6:\"routes\";a:0:{}}','[]','TmQDCTkmPLGd','2018-09-30 15:22:58','2019-01-31 03:22:12','0434ff09-c766-4fea-a06a-d65d74f8e9f4');
/*!40000 ALTER TABLE `acr_info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixblocks`
--

LOCK TABLES `acr_matrixblocks` WRITE;
/*!40000 ALTER TABLE `acr_matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixblocks` VALUES (12,8,NULL,12,1,1,NULL,'2018-11-02 02:36:30','2019-01-27 18:25:14','2653883a-9a10-4689-92b3-5be2c7a88b9e'),(13,8,NULL,12,1,2,NULL,'2018-11-02 02:36:30','2019-01-27 18:25:14','6eb1fa73-5340-4f7e-8d98-d4f95f7e0b75'),(14,8,NULL,12,1,3,NULL,'2018-11-02 02:36:30','2019-01-27 18:25:14','e68e9fb2-416c-4fff-845c-1f5e40ac7148'),(16,8,NULL,16,2,1,NULL,'2018-12-08 01:32:00','2019-01-27 18:25:14','bded4d2a-4867-417a-8b39-5360a1dcec3c'),(17,8,NULL,16,2,2,NULL,'2018-12-08 01:32:00','2019-01-27 18:25:14','98bdaff4-081d-4ff3-a223-0e248d35b7b0'),(25,24,NULL,34,3,1,NULL,'2019-01-02 01:14:24','2019-01-21 18:24:32','ab7c1d42-3bbe-4ed4-9393-fe8c4a1b8531'),(26,24,NULL,34,3,2,NULL,'2019-01-02 01:15:08','2019-01-21 18:24:32','acc6bb57-f427-49ab-8c0f-8f44feb6e408'),(27,24,NULL,34,3,3,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','2620c1c0-d487-4aa9-b4bc-9bc568525cf7'),(28,24,NULL,34,3,4,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','e2bc5602-1f6e-4d2c-8c4a-58ee909e8d9f'),(29,24,NULL,34,3,5,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','ed6ce614-d788-4a8a-98ff-8ca4b70552d9'),(30,24,NULL,34,3,6,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','d76f4be3-3508-4dca-8f05-afc0f014703d'),(31,24,NULL,34,3,7,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','b02f456d-7417-418a-a57a-2256d103aeb0'),(32,24,NULL,34,3,8,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','a8c2ebba-ba20-4130-8167-825f64c0f4df'),(33,24,NULL,34,3,9,NULL,'2019-01-02 01:30:33','2019-01-21 18:24:32','6655d7fc-2d18-4d03-94c8-5df0ad9d467c'),(35,34,NULL,39,4,1,NULL,'2019-01-23 02:51:12','2019-01-23 03:05:07','89cbf551-c137-4238-9bb9-d9abebc16422'),(36,34,NULL,39,4,2,NULL,'2019-01-23 02:51:12','2019-01-23 03:05:07','f344525d-9295-4f3d-b304-217fc61841ef'),(37,34,NULL,39,4,3,NULL,'2019-01-23 02:56:28','2019-01-23 03:05:07','08612c67-ae45-4ce8-b43e-22af1be5d9b7'),(38,34,NULL,39,4,4,NULL,'2019-01-23 02:56:29','2019-01-23 03:05:07','015cf27f-f0c3-4acb-89b6-6ade80a782c9'),(39,34,NULL,39,4,5,NULL,'2019-01-23 02:56:29','2019-01-23 03:05:07','3c523823-de0a-4d50-a26e-6af15d2496d1'),(40,34,NULL,43,5,1,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','5a7d90ec-227d-4e6b-a142-05027c70d66c'),(41,34,NULL,43,5,2,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','1207fa92-1e5a-4912-9287-52801d5bd2d8'),(42,34,NULL,43,5,3,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','451d60d6-f3fa-48e6-83b4-de069a6d07b3'),(43,34,NULL,43,5,4,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','0f26f3fe-c586-414e-b2aa-2752f8dece60'),(44,34,NULL,43,5,5,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','8e0317e6-bca4-4026-99eb-3641a04f875e'),(45,34,NULL,43,5,6,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','8a4251f4-5364-4915-a917-67e84c2a8390'),(46,34,NULL,43,5,7,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','d0777c3b-0245-4cc2-b6ac-d59330691b9f'),(47,34,NULL,43,5,8,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','b7541e46-e75b-47d3-98b3-ae5044bb1cae'),(48,34,NULL,43,5,9,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','b79b8d0a-4d5b-4e85-ab39-53b3e8b37aa1'),(49,34,NULL,43,5,10,NULL,'2019-01-23 03:05:07','2019-01-23 03:05:07','68de242f-6712-44cc-960d-733768338eeb');
/*!40000 ALTER TABLE `acr_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_matrixblocktypes`
--

LOCK TABLES `acr_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `acr_matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_matrixblocktypes` VALUES (1,12,9,'Service','service',1,'2018-11-02 02:34:57','2019-01-17 02:45:24','ad0dc2b4-7b01-48f6-9596-8c8dad66a4b1'),(2,16,10,'Call To Action','callToAction',1,'2018-12-08 01:29:41','2019-01-17 02:45:24','a18a4a20-6a90-4d48-8995-8ab7941dcc11'),(3,34,18,'Store Location','storeLocation',1,'2019-01-02 01:11:47','2019-01-21 18:21:58','c773ee36-d4bd-4d3c-8a25-e904a163d34e'),(4,39,19,'Initiative','initiative',1,'2019-01-23 02:50:14','2019-01-23 02:57:52','cd5cbfa7-0720-49c3-8c87-eca987b0e498'),(5,43,21,'Initiative','teamInitiative',1,'2019-01-23 03:03:52','2019-01-23 03:03:52','3334d866-45d7-4fa3-b627-7c7470d3687a');
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
-- Dumping data for table `acr_migrations`
--

LOCK TABLES `acr_migrations` WRITE;
/*!40000 ALTER TABLE `acr_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_migrations` VALUES (1,NULL,'app','Install','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','d56e87b0-69cb-446f-bafc-d8adbf93b679'),(2,NULL,'app','m150403_183908_migrations_table_changes','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','43d5036e-caca-40f3-8db2-dff2f39d3eaa'),(3,NULL,'app','m150403_184247_plugins_table_changes','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','2e41d709-0396-468c-ae70-d79d00c3989e'),(4,NULL,'app','m150403_184533_field_version','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','f04370ec-b948-4229-9e51-ab360bdc4514'),(5,NULL,'app','m150403_184729_type_columns','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','451b13b3-139f-42cb-85b1-db62a57a1887'),(6,NULL,'app','m150403_185142_volumes','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','e39f1a03-599e-4655-bd34-a62dc8c52083'),(7,NULL,'app','m150428_231346_userpreferences','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','38c2e83a-f277-470a-9fbe-0d860108d608'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','5505fb12-d44b-45a5-a972-98c7d9579276'),(9,NULL,'app','m150617_213829_update_email_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','a87e3116-4147-4905-aeb4-2eef690d51af'),(10,NULL,'app','m150721_124739_templatecachequeries','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','ba345308-a352-4610-ad96-67510046a135'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','adafddbc-bf92-4cf2-83e5-9600b51ce544'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','fbaf72ca-2597-4ae9-937f-54999572d5d1'),(13,NULL,'app','m151002_095935_volume_cache_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','916fe096-3aec-4fae-8b96-9ba26b6124b6'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','b8f9f3e5-1218-4591-946e-ebf79be447d3'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','02f2739d-b747-4e2b-9310-9d9a264e757a'),(16,NULL,'app','m151209_000000_move_logo','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','e7d32d1c-a39d-4c53-b366-5ef407baefd3'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','58cb6868-9d2e-4f84-bd60-3c0b63a84c39'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','81192b37-e506-472d-b994-21e289af8db6'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','b7e53de4-0f5a-49a5-ba67-c3e7e4dde67d'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','82d2c3cf-d2a4-4488-89c9-ec80e11dbe22'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','3da1c809-1f7f-49ba-b75c-3cae1089dd77'),(22,NULL,'app','m160727_194637_column_cleanup','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','7f1e8f30-9e0e-4202-a78c-8758f403631b'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','f2befb09-7f8c-464e-b2e6-041612388692'),(24,NULL,'app','m160807_144858_sites','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','e9e2b049-0648-4126-b64c-09018a55a065'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','25b02982-92dd-4253-8dc8-dac299b14a6c'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','60f05c52-572d-472d-b3c5-2cc3ae7c372e'),(27,NULL,'app','m160912_230520_require_entry_type_id','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','e119affb-3e0e-47dd-875d-1cd995a5b455'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','b462caa6-d53e-4556-8c44-3b41e0d30f70'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','b562d88f-a44e-450d-aeb9-6526d92633f6'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','b14b1045-6e73-4d3c-acfd-ef913421c5d8'),(31,NULL,'app','m160925_113941_route_uri_parts','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','0a07047a-7d21-47e2-9099-b5e9b6522fd1'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','3fdccd34-56e4-4949-8842-2bae8ed6f05d'),(33,NULL,'app','m161007_130653_update_email_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','8d0d0e20-2b6d-4228-86ae-fcbeaa4b6323'),(34,NULL,'app','m161013_175052_newParentId','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','37ec1d75-50e3-43dd-b9e6-c584ccaa0ae4'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','27bce9b2-b863-448f-9909-472e0dffc8bd'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','1b9e2e13-7101-4eba-a078-8f0c7b1d766d'),(37,NULL,'app','m161025_000000_fix_char_columns','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','bf96bdd7-ead9-45ca-a69c-3fa84a2033ea'),(38,NULL,'app','m161029_124145_email_message_languages','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','e8103f77-8c0e-4dca-a7c9-17d883112a13'),(39,NULL,'app','m161108_000000_new_version_format','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','0ae1af55-401c-421b-bb69-9d68e8527993'),(40,NULL,'app','m161109_000000_index_shuffle','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','24a84c4c-9fe0-45b3-9062-8d90a8f04aff'),(41,NULL,'app','m161122_185500_no_craft_app','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','8b9e8bfe-843e-46c8-9813-70f98ab5a073'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','634a4f86-5f2c-472f-a272-dc9f7012ac1c'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','eb136ed2-b186-4c2c-a8e9-ffddee5f27a0'),(44,NULL,'app','m170114_161144_udates_permission','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','5dd79c67-5a80-498a-b71b-dd29d1ef1201'),(45,NULL,'app','m170120_000000_schema_cleanup','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','ef7cd75f-cae1-43d3-859c-5ec5f1fde62e'),(46,NULL,'app','m170126_000000_assets_focal_point','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','5f7e60f9-2849-4764-adf1-50cbb634d778'),(47,NULL,'app','m170206_142126_system_name','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','f5d1fd7c-3036-4b1c-bc13-1e6d1c0c7d7e'),(48,NULL,'app','m170217_044740_category_branch_limits','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','8add68fc-1529-4ed0-9e03-1ecb4695d9da'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','5a53cf68-7e3d-44ab-95f1-bcb97fa9c44c'),(50,NULL,'app','m170223_224012_plain_text_settings','2018-09-30 15:22:58','2018-09-30 15:22:58','2018-09-30 15:22:58','2827e619-de75-49f5-819e-a866c6c2c858'),(51,NULL,'app','m170227_120814_focal_point_percentage','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','00e694a4-d3a8-4aa3-8194-5a81df0dfa3e'),(52,NULL,'app','m170228_171113_system_messages','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','ade57e26-bdfd-43c4-bef5-d4ba6220043b'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','f6d3186b-7ca0-498e-8887-02c925fe4822'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','5cc36422-c89b-4c95-a471-8f6ac7b535fe'),(55,NULL,'app','m170414_162429_rich_text_config_setting','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','0329cabc-713a-4520-8eac-069e6ca9e727'),(56,NULL,'app','m170523_190652_element_field_layout_ids','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','26301a5b-b12c-4d28-a3a9-ea7ede151cf2'),(57,NULL,'app','m170612_000000_route_index_shuffle','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','169ba763-9547-4119-babe-db0bb4fe8355'),(58,NULL,'app','m170621_195237_format_plugin_handles','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','b6f0337b-0a13-4736-ac0f-c435005b7143'),(59,NULL,'app','m170630_161028_deprecation_changes','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','05da5489-3c19-4098-89c1-0225a409880e'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','dbc1128f-6ad2-4c3e-ac5f-7fb508f814e8'),(61,NULL,'app','m170704_134916_sites_tables','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','44075ee2-1653-4d75-8612-6ac8b89c996c'),(62,NULL,'app','m170706_183216_rename_sequences','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','43d8f750-8f6c-438c-be08-bac91e060e67'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','ec9bf4c3-3278-435d-9e9d-219489fe3b24'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','60bb9778-c2aa-4995-9101-f48cfac4a52f'),(65,NULL,'app','m170810_201318_create_queue_table','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','3216d1b4-d877-4118-aae3-01e9f755af15'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','faa83552-585c-462d-9bda-7e923885499a'),(67,NULL,'app','m170821_180624_deprecation_line_nullable','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','42122645-f93d-411b-8437-24c79ea553d1'),(68,NULL,'app','m170903_192801_longblob_for_queue_jobs','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','db17ce9a-14f1-449c-a08c-970d40d6a182'),(69,NULL,'app','m170914_204621_asset_cache_shuffle','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','dea6bd2b-f156-4be7-af60-581a3045b24b'),(70,NULL,'app','m171011_214115_site_groups','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','97383247-3dd6-4a0a-9643-9180df27d0c2'),(71,NULL,'app','m171012_151440_primary_site','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','7578f3e8-7388-47f3-8097-80198a915314'),(72,NULL,'app','m171013_142500_transform_interlace','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','91fc1f5d-0050-43d8-886c-001040b3b99e'),(73,NULL,'app','m171016_092553_drop_position_select','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','30483229-3b26-40c0-a3b4-d2459b4b4a85'),(74,NULL,'app','m171016_221244_less_strict_translation_method','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','3490ae3d-c067-4e07-8717-1276d22bcc49'),(75,NULL,'app','m171107_000000_assign_group_permissions','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','040241e3-7d19-487e-9525-95d0baef9f70'),(76,NULL,'app','m171117_000001_templatecache_index_tune','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','6aa78df6-b423-4cab-bd31-9e4f238564da'),(77,NULL,'app','m171126_105927_disabled_plugins','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','f9294c08-a3d7-478c-9729-7134147ee981'),(78,NULL,'app','m171130_214407_craftidtokens_table','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','6b842dc8-4343-4f2e-be07-2886c75409f2'),(79,NULL,'app','m171202_004225_update_email_settings','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','a6c854e1-31b0-4c7f-9c28-4be629a18ab6'),(80,NULL,'app','m171204_000001_templatecache_index_tune_deux','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','ec671994-421a-45d3-bb3d-c722e2e60644'),(81,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','56f925e4-85f0-4fe9-9620-f5c93d878e56'),(82,NULL,'app','m171218_143135_longtext_query_column','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','a0c687d2-d09c-4e92-9502-0d32b17e3d6c'),(83,NULL,'app','m171231_055546_environment_variables_to_aliases','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','5a372769-0af4-4eda-84f8-80bfdedee12d'),(84,NULL,'app','m180113_153740_drop_users_archived_column','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','cdf6f9fa-f58a-4f86-a4bb-2ca7063886d0'),(85,NULL,'app','m180122_213433_propagate_entries_setting','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','6e6fa68e-497b-4d89-a026-4167b6475aee'),(86,NULL,'app','m180124_230459_fix_propagate_entries_values','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','f20e7e5b-192f-4e18-b8a1-dcf4080289e7'),(87,NULL,'app','m180128_235202_set_tag_slugs','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','d702dd61-6698-4080-807e-40722b2dfe19'),(88,NULL,'app','m180202_185551_fix_focal_points','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','d0c96a06-043e-4cac-9b19-cf20d47344d4'),(89,NULL,'app','m180217_172123_tiny_ints','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','69589218-d98e-4717-aefd-ffa3de330ce9'),(90,NULL,'app','m180321_233505_small_ints','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','9ef153ed-baa9-4f08-9aa0-61e9cf267041'),(91,NULL,'app','m180328_115523_new_license_key_statuses','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','12f777af-d8c0-4301-83a3-6111bce458a3'),(92,NULL,'app','m180404_182320_edition_changes','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','d00c62aa-14c7-430e-87da-ad543b8d5aa2'),(93,NULL,'app','m180411_102218_fix_db_routes','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','77d6b691-0c19-459c-8c91-9bf0e4a1db16'),(94,NULL,'app','m180416_205628_resourcepaths_table','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','507413a9-5ecc-4a8d-b7ef-f8e46c5e2b59'),(95,NULL,'app','m180418_205713_widget_cleanup','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','47ef3cfa-2de7-40db-a6b5-f07a1a713bbb'),(96,NULL,'app','m180824_193422_case_sensitivity_fixes','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','74f44af5-977c-4987-9fce-d0b4765e0435'),(97,NULL,'app','m180901_151639_fix_matrixcontent_tables','2018-09-30 15:22:59','2018-09-30 15:22:59','2018-09-30 15:22:59','75a941bb-6420-4ebd-b665-75ae3a9d2836'),(98,NULL,'app','m181112_203955_sequences_table','2018-12-08 01:19:03','2018-12-08 01:19:03','2018-12-08 01:19:03','3288fc9c-a424-4884-9318-16de0251cf29'),(99,NULL,'app','m170630_161027_deprecation_line_nullable','2019-01-17 02:45:19','2019-01-17 02:45:19','2019-01-17 02:45:19','34da1cf6-839b-46b7-9bdf-4ddb6414832d'),(100,NULL,'app','m180425_203349_searchable_fields','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','6a903528-657b-4734-bd10-fa96e1a9ec51'),(101,NULL,'app','m180516_153000_uids_in_field_settings','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','a720f1a5-2b35-49e5-950a-c60043a36520'),(102,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','2cc6b89a-95ae-4f09-8606-86f05bbd9f79'),(103,NULL,'app','m180518_173000_permissions_to_uid','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','1d71c422-08e9-4a6a-9bdd-db55842d74fc'),(104,NULL,'app','m180520_173000_matrix_context_to_uids','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','e8c23c20-6106-426e-a3da-86549f58edb9'),(105,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','5b532ed3-6b7f-4b89-a5f3-af2c930442a2'),(106,NULL,'app','m180731_162030_soft_delete_sites','2019-01-17 02:45:20','2019-01-17 02:45:20','2019-01-17 02:45:20','ed9a727b-07d3-442d-8ba9-ce8c0ce5bda8'),(107,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','6b055ec4-0c1e-482c-a0ff-ff916336378d'),(108,NULL,'app','m180810_214439_soft_delete_elements','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','d7ed982b-c3a1-4e3d-8078-12ec9654d20a'),(109,NULL,'app','m180904_112109_permission_changes','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','4b0da163-640e-4cae-82e4-fd1691067952'),(110,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','2cc26733-09fe-4902-8795-fb31a7222884'),(111,NULL,'app','m181011_160000_soft_delete_asset_support','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','378b481a-86ca-42f1-9b08-a8509bd1431b'),(112,NULL,'app','m181016_183648_set_default_user_settings','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','aa1a4b7f-3986-4ca6-a4ef-f65726ff7879'),(113,NULL,'app','m181017_225222_system_config_settings','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','e4f0a591-7248-4a18-9384-def2b5d373f3'),(114,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','1959e6a7-2c48-495b-a4e6-667c3f99b45b'),(115,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','52998828-6d63-4e18-b18f-a7cad44bf9a8'),(116,NULL,'app','m181121_001712_cleanup_field_configs','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','0184cf52-510c-49b7-a078-cef2848a43aa'),(117,NULL,'app','m181128_193942_fix_project_config','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','d6dfc015-491f-4a67-85e0-c5f2bc121679'),(118,NULL,'app','m181130_143040_fix_schema_version','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','349e9708-be30-4c12-92bf-39116e855811'),(119,NULL,'app','m181211_143040_fix_entry_type_uids','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','5e23c897-aa53-44c6-b297-e87ee2d07940'),(120,NULL,'app','m181213_102500_config_map_aliases','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','f364143d-cdac-4748-b3ab-2cff043364af'),(121,NULL,'app','m181217_153000_fix_structure_uids','2019-01-17 02:45:21','2019-01-17 02:45:21','2019-01-17 02:45:21','dbcff585-9d48-4d4f-88d4-9718c7894009'),(122,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','b7611df8-fe24-4e49-99c1-8f40ad992baf'),(123,NULL,'app','m190108_110000_cleanup_project_config','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','67256851-026e-4b9b-a743-22ea82281d9f'),(124,NULL,'app','m190108_113000_asset_field_setting_change','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','310f15c3-f541-4e7f-9780-33b5d0d89bf0'),(125,NULL,'app','m190109_172845_fix_colspan','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','1ffde8d1-560d-417a-9118-b665c8e0c41d'),(126,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','ec9bb94e-5d8e-424e-9f19-e70afda86c67'),(127,NULL,'app','m190110_214819_soft_delete_volumes','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','29e11b08-f8f2-4303-91ef-5d1fe769b3c1'),(128,NULL,'app','m190112_124737_fix_user_settings','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','fed0186d-118f-4693-9e03-8bda5e369025'),(129,NULL,'app','m190112_131225_fix_field_layouts','2019-01-17 02:45:22','2019-01-17 02:45:22','2019-01-17 02:45:22','d3b3d5a6-535d-4b49-82d2-3082c59e1a47'),(130,NULL,'app','m190112_201010_more_soft_deletes','2019-01-17 02:45:23','2019-01-17 02:45:23','2019-01-17 02:45:23','05ad73c3-b755-4375-8169-01862577b728'),(131,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-01-17 02:45:24','2019-01-17 02:45:24','2019-01-17 02:45:24','8db848a7-51b0-41d5-a825-ae7b623f5b96'),(132,NULL,'app','m190218_143000_element_index_settings_uid','2019-01-21 18:43:19','2019-01-21 18:43:19','2019-01-21 18:43:19','87022d36-e145-4b80-a2c3-a38504575b63'),(133,NULL,'app','m190121_120000_rich_text_config_setting','2019-01-23 03:11:59','2019-01-23 03:11:59','2019-01-23 03:11:59','6a81a23e-b8c8-4f29-880f-ca2b6de8a44b'),(134,6,'plugin','Install','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','b3f1d685-9e2f-4c5a-b662-e199ed0804b2'),(135,6,'plugin','m180120_140521_CraftUpgrade','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','c77c24cc-5afe-4a9f-9a8f-cb56e16f9f74'),(136,6,'plugin','m180125_124339_UpdateForeignKeyNames','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','c73596da-6dc8-419e-bb26-9578044b5217'),(137,6,'plugin','m180214_094247_AddUniqueTokenToSubmissionsAndForms','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','ef1d9c4a-408f-46de-9a88-b8485d6475e7'),(138,6,'plugin','m180220_072652_ChangeFileUploadFieldColumnType','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','b24eebec-d27a-4545-a03a-848832c95c0c'),(139,6,'plugin','m180326_094124_AddIsSpamToSubmissions','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','161dbb4e-ea48-45b0-beca-ecdf89cbcceb'),(140,6,'plugin','m180405_101920_AddIpAddressToSubmissions','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','a391e090-df9a-4e40-ae4c-cc73abf33f51'),(141,6,'plugin','m180410_131206_CreateIntegrationsQueue','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','f1d3c640-2583-4b46-ba9b-37bc806ae543'),(142,6,'plugin','m180417_134527_AddMultipleSelectTypeToFields','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','963b8697-0373-4228-98fa-e8de53d33cfe'),(143,6,'plugin','m180430_151626_PaymentGateways','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','f7cd4c21-3c15-4c8b-a08e-4284b515d368'),(144,6,'plugin','m180508_095131_CreatePaymentGatewayFieldsTable','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','559fa08c-a5c7-47f9-a747-7b7b3846d3b5'),(145,6,'plugin','m180606_141402_AddConnectionsToFormProperties','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','22ba4a9b-8eeb-4e2c-a213-22c77f1de5db'),(146,6,'plugin','m180730_171628_AddCcDetailsFieldType','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','43fc5921-8d6a-4a89-a00b-795a0d1f434d'),(147,6,'plugin','m180817_091801_AddRulesToFormProperties','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','b373e5fe-7ce9-4485-b222-a48bc763c1fc'),(148,6,'plugin','m181112_152751_ChangeTypeEnumColumnsToIndexedText','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','3acb071c-4de7-4bf3-8ffa-5944e5bd1b98'),(149,6,'plugin','m181129_083939_ChangeIntegrationFieldTypeColumnTypeToString','2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-24 01:47:30','3d143546-039a-4f38-98be-44806eef7ec1'),(150,NULL,'app','m190125_191628_fix_email_transport_password','2019-01-27 18:05:24','2019-01-27 18:05:24','2019-01-27 18:05:24','62f5d309-89fa-4718-aba5-26c4b15a0cd8');
/*!40000 ALTER TABLE `acr_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_plugins`
--

LOCK TABLES `acr_plugins` WRITE;
/*!40000 ALTER TABLE `acr_plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_plugins` VALUES (2,'element-api','2.5.4','1.0.0','unknown',NULL,'2018-09-30 16:27:52','2018-09-30 16:27:52','2019-01-31 03:09:03','fd7ba61d-aeb3-45c0-af53-d3686c559a27'),(4,'locate','2.1.0','2.0.2','unknown',NULL,'2018-10-09 00:06:58','2018-10-09 00:06:58','2019-01-31 03:09:03','1f373530-e204-4126-979c-8c8ea0d63667'),(5,'typedlinkfield','1.0.16','1.0.0','unknown',NULL,'2018-10-09 00:14:35','2018-10-09 00:14:35','2019-01-31 03:09:03','074fe6ed-f488-490f-9be5-cb214290542d'),(6,'freeform','2.5.11','2.1.3','unknown',NULL,'2019-01-24 01:47:30','2019-01-24 01:47:30','2019-01-31 03:09:03','3da68d4d-0c17-44e8-9e6c-45beea590e0c'),(7,'copy','1.0.0-RC2','1.0.0','unknown',NULL,'2019-01-31 03:22:12','2019-01-31 03:22:12','2019-01-31 03:22:12','afe7117b-6bc3-43c4-b42c-df63b3a5f704');
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
INSERT INTO `acr_relations` VALUES (2,2,3,NULL,5,1,'2018-10-08 23:50:21','2018-10-08 23:50:21','2cdae2c9-d6da-4589-88b2-46121909f916'),(17,2,10,NULL,61,1,'2019-01-27 17:55:11','2019-01-27 17:55:11','ce6ab752-6992-4123-83c5-e57d2e05176e'),(18,45,10,NULL,62,1,'2019-01-27 18:02:05','2019-01-27 18:02:05','a9fc58fe-339f-42e3-bdfa-96283d31bde7'),(21,45,64,NULL,63,1,'2019-01-27 18:17:46','2019-01-27 18:17:46','a48dc014-2b5d-4f16-9749-eb1351d436ea'),(25,19,16,NULL,65,1,'2019-01-27 18:25:14','2019-01-27 18:25:14','3b09d751-6ca0-40c9-9b93-119bbb7850fb'),(26,19,17,NULL,66,1,'2019-01-27 18:25:14','2019-01-27 18:25:14','c2c29984-9725-4c1d-aa20-c58ae5aed026'),(27,25,8,NULL,15,1,'2019-01-27 18:25:14','2019-01-27 18:25:14','211cc590-3188-416d-92e1-52ec8aa392ad'),(29,25,67,NULL,62,1,'2019-01-27 18:33:01','2019-01-27 18:33:01','9e1816ef-a5b1-4e0b-aa1d-fbd71808420b');
/*!40000 ALTER TABLE `acr_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_resourcepaths`
--

LOCK TABLES `acr_resourcepaths` WRITE;
/*!40000 ALTER TABLE `acr_resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_resourcepaths` VALUES ('10ce69d9','@app/web/assets/craftsupport/dist'),('1111302c','@craft/web/assets/updateswidget/dist'),('1144526','@app/web/assets/matrixsettings/dist'),('1280018f','@app/web/assets/updateswidget/dist'),('12f35adf','@lib/velocity'),('12f8ead1','@lib/jquery-ui'),('1684918c','@lib/xregexp'),('18bd999b','@lib'),('1a22bb52','@craft/web/assets/matrixsettings/dist'),('1ac7f04f','@craft/web/assets/cp/dist'),('1bc50aa4','@lib/element-resize-detector'),('1c12ad4e','@app/web/assets/craftsupport/dist'),('1ce8d506','@lib/selectize'),('1ded5799','@app/web/assets/feed/dist'),('1e352fce','@craft/web/assets/sites/dist'),('1e5cc518','@app/web/assets/updateswidget/dist'),('1f1d3785','@lib/jquery-ui'),('20975863','@bower/jquery/dist'),('20d5a7ee','@craft/web/assets/fields/dist'),('20e68776','@app/web/assets/recententries/dist'),('214d9c0','@craft/web/assets/pluginstore/dist'),('22947639','@app/web/assets/tablesettings/dist'),('254e9a3e','@craft/web/assets/editentry/dist'),('25da562c','@lib/velocity'),('2668341d','@craft/web/assets/updater/dist'),('2693edd0','@app/web/assets/pluginstore/dist'),('26f8dd96','@lib/jquery.payment'),('297bc9f9','@lib/timepicker'),('2a4f2947','@app/web/assets/pluginstore/dist'),('2b508503','@bower/jquery/dist'),('2bbe1866','@app/web/assets/utilities/dist'),('2c2703f6','@app/web/assets/matrixsettings/dist'),('2c3a43e1','@app/web/assets/recententries/dist'),('2cec0657','@lib/element-resize-detector'),('2d3f00f6','@lib/jquery.payment'),('2d553b0','@app/web/assets/updater/dist'),('2fab7242','@craft/web/assets/recententries/dist'),('308a5dc8','@typedlinkfield/resources'),('30de1149','@app/web/assets/feed/dist'),('3118af1e','@lib/velocity'),('3177646c','@app/web/assets/cp/dist'),('3455a151','@bower/jquery/dist'),('34b4066e','@craft/web/assets/login/dist'),('35497112','@app/web/assets/login/dist'),('37c02def','@craft/web/assets/updater/dist'),('37cada2','@bower/jquery/dist'),('38d3d00b','@lib/timepicker'),('39716fcc','@lib/timepicker'),('3995b585','@app/web/assets/login/dist'),('39fdf9c4','@lib/jquery.payment'),('3a78ce7','@craft/web/assets/feed/dist'),('3adf727e','@lib/velocity'),('3b566c5a','@lib'),('3c390768','@craft/web/assets/updates/dist'),('3cb2b1a3','@craft/web/assets/craftsupport/dist'),('3daba0fb','@app/web/assets/cp/dist'),('3dcfb8a0','@app/web/assets/searchindexes/dist'),('3e036bb0','@craft/web/assets/recententries/dist'),('4035c885','@craft/web/assets/utilities/dist'),('403b5b5d','@bower/jquery/dist'),('40615cb6','@craft/web/assets/updateswidget/dist'),('40745f49','@lib/fileupload'),('4076de9c','@lib/jquery.payment'),('41d6e08e','@lib/fileupload'),('431af5f9','@freeform/Resources'),('4335f57a','@craft/web/assets/updates/dist'),('43be43b1','@craft/web/assets/craftsupport/dist'),('447359f6','@lib/velocity'),('44b0eb45','@app/web/assets/feed/dist'),('4633d8d3','@lib/d3'),('470179c4','@app/web/assets/updateswidget/dist'),('481f60f3','@craft/web/assets/tablesettings/dist'),('48245e1','@app/web/assets/installer/dist'),('486c2fd2','@app/web/assets/feed/dist'),('4896f882','@lib/picturefill'),('48ee1cfc','@craft/web/assets/matrix/dist'),('4993d505','@app/web/assets/craftsupport/dist'),('49c55af7','@app/web/assets/cp/dist'),('4bb8f47c','@craft/web/assets/login/dist'),('4c02ef6','@lib/element-resize-detector'),('4d9303c8','@lib/jquery.payment'),('4db4cec9','@lib/prismjs'),('4dde8609','@bower/jquery/dist'),('4dfb4f89','@app/web/assets/login/dist'),('4e145d0c','@lib/velocity'),('4f32c440','@lib/jquery-touch-events'),('507ef97c','@lib/fileupload'),('519dd177','@craft/web/assets/utilities/dist'),('51b4ac20','@lib/velocity'),('5233f2e4','@lib/jquery.payment'),('530c26fd','@app/web/assets/utilities/dist'),('5316249b','@app/web/assets/editentry/dist'),('54887d7a','@app/web/assets/recententries/dist'),('55fcae8b','@bower/jquery/dist'),('56397ee6','@lib/d3'),('56fa8c35','@app/web/assets/tablesettings/dist'),('57542bfb','@app/web/assets/updater/dist'),('579bc121','@lib/d3'),('5854f61e','@lib/jquery.payment'),('589c5eb7','@lib/picturefill'),('593ee170','@lib/picturefill'),('5946050e','@craft/web/assets/matrix/dist'),('59b77901','@craft/web/assets/tablesettings/dist'),('5a1f8527','@craft/web/assets/cp/dist'),('5a2648a2','@app/web/assets/tablesettings/dist'),('5a42682c','@craft/web/assets/editentry/dist'),('5c3406af','@app/web/assets/matrix/dist'),('5c517174','@lib/velocity'),('5c5ac17a','@lib/jquery-ui'),('5dbe68fc','@lib/prismjs'),('5e8583e','@craft/web/assets/dashboard/dist'),('5e9addb2','@lib/jquery-touch-events'),('5f386275','@lib/jquery-touch-events'),('5f9baa71','@bower/jquery/dist'),('5fd0e26a','@app/web/assets/utilities/dist'),('600dd286','@craft/web/assets/fields/dist'),('60c80959','@app/web/assets/login/dist'),('60c81b6b','@lib/fabric'),('6246d9e','@app/web/assets/generalsettings/dist'),('624e2dfc','@lib/element-resize-detector'),('6426d6a7','@lib/garnishjs'),('64a093d5','@app/web/assets/craftsupport/dist'),('64f61c27','@app/web/assets/cp/dist'),('65846960','@lib/garnishjs'),('67b16b89','@lib'),('67d99612','@app/web/assets/routes/dist'),('68d5eb6','@app/web/assets/utilities/dist'),('68e37b9','@lib/xregexp'),('6a323f14','@app/web/assets/updateswidget/dist'),('6b212c10','@craft/web/assets/dbbackup/dist'),('6b73cd89','@lib/jquery-ui'),('6c4d29ea','@app/web/assets/updates/dist'),('6dd66f73','@lib'),('6e0d296f','@Solspace/Calendar/Resources'),('6fabf0a8','@lib/element-resize-detector'),('700b0184','@lib/element-resize-detector'),('70c2bd5e','@lib/fabric'),('71600299','@lib/fabric'),('71a5cb74','@craft/web/assets/fields/dist'),('722cf49e','@app/web/assets/deprecationerrors/dist'),('72a7e84','@craft/web/assets/updates/dist'),('72c887e','@lib/xregexp'),('73b0e69b','@app/web/assets/dashboard/dist'),('7476e9db','@lib/jquery-ui'),('74d7c8d5','@app/web/assets/fields/dist'),('757abf2a','@app/web/assets/matrixsettings/dist'),('758ecf55','@lib/garnishjs'),('77185887','@craft/web/assets/updater/dist'),('78119aa5','@lib'),('79a67bbd','@app/web/assets/matrixsettings/dist'),('79bb3baa','@app/web/assets/recententries/dist'),('7a3e0668','@swixpop/locate/assetbundles/locate/dist'),('7a676d2b','@app/web/assets/updater/dist'),('7a6c057e','@lib/element-resize-detector'),('7ae4aa2c','@craft/web/assets/dashboard/dist'),('7cab7ef5','@craft/web/assets/feed/dist'),('7edb1ed8','@craft/web/assets/recententries/dist'),('7fb134bb','@lib/jquery-ui'),('813d7330','@craft/web/assets/editentry/dist'),('81609e3b','@craft/web/assets/cp/dist'),('8173b174','@lib/d3'),('831f9f0b','@app/web/assets/updater/dist'),('8366994','@craft/web/assets/matrix/dist'),('8463870d','@lib/fabric'),('84a64ee0','@craft/web/assets/fields/dist'),('85e7aa01','@lib/garnishjs'),('8744fb02','@lib/xregexp'),('874fbb72','@lib/selectize'),('875d906b','@app/web/assets/editentry/dist'),('881bae46','@craft/web/assets/pluginstore/dist'),('8872ade7','@lib/jquery-touch-events'),('89a8fb61','@craft/web/assets/feed/dist'),('8ab2b12f','@lib/jquery-ui'),('8ac814bb','@app/web/assets/dashboard/dist'),('8af4a76e','@lib/prismjs'),('8b100ee8','@lib/jquery-ui'),('8c7159b','@craft/web/assets/tablesettings/dist'),('8d23fff8','@lib/xregexp'),('8d28bf88','@lib/selectize'),('8daf3af5','@app/web/assets/fields/dist'),('8fa45a6d','@lib/fabric'),('8fd69125','@lib/picturefill'),('90a17e3f','@lib/fabric'),('91255333','@lib/garnishjs'),('92830ed4','@lib/xregexp'),('934acd34','@app/web/assets/updateswidget/dist'),('950a970a','@lib/selectize'),('9535dbca','@app/web/assets/updates/dist'),('973e90db','@lib/fileupload'),('9800e293','@craft/web/assets/feed/dist'),('984aee66','@craft/web/assets/updates/dist'),('98ef4a5e','@lib/selectize'),('9ae28e53','@lib/garnishjs'),('9b1aa8dd','@lib/jquery-ui'),('9b1e47aa','@craft/web/assets/updateswidget/dist'),('9dd861f5','@app/web/assets/craftsupport/dist'),('9f66d380','@lib/xregexp'),('9f8d2d0f','@craft/web/assets/utilities/dist'),('a0179c28','@lib/fileupload'),('a05e8546','@lib/jquery-touch-events'),('a09c7c25','@app/web/assets/fields/dist'),('a10100d7','@swixpop/locate/assetbundles/locatefieldfield/dist'),('a19bb130','@craft/web/assets/dashboard/dist'),('a29844b5','@lib/d3'),('a2d88fcf','@lib/prismjs'),('a49e54e3','@craft/web/assets/utilities/dist'),('a54cf48f','@app/web/assets/matrix/dist'),('a5a405c4','@craft/web/assets/recententries/dist'),('a667406e','@app/web/assets/deprecationerrors/dist'),('a715dfd7','@craft/web/assets/craftsupport/dist'),('a78872cc','@lib/fabric'),('a7fab984','@lib/picturefill'),('a7fb526b','@app/web/assets/dashboard/dist'),('a91f52af','@lib/prismjs'),('a95f99d5','@lib/d3'),('aa6ed6bb','@app/web/assets/editentry/dist'),('ab27ded','@app/web/assets/findreplace/dist'),('ab995826','@lib/jquery-touch-events'),('ac3d64e4','@lib/picturefill'),('ac45809a','@craft/web/assets/matrix/dist'),('ac67439b','@craft/web/assets/updater/dist'),('acb4fc95','@craft/web/assets/tablesettings/dist'),('ad7c56a1','@lib/timepicker'),('adac253','@lib/jquery-ui'),('adf08f5a','@app/web/assets/recententries/dist'),('b0b16733','@app/web/assets/plugins/dist'),('b0bda8d7','@app/web/assets/cp/dist'),('b2cea6f2','@lib/garnishjs'),('b483bda9','@app/web/assets/login/dist'),('b4d5651a','@lib/fileupload'),('b51a71ef','@Solspace/Freeform/Resources'),('b65abd87','@lib/d3'),('b6bdc625','@craft/web/assets/craftsupport/dist'),('b6fe9bd','@craft/web/assets/cp/dist'),('b8069d1a','@app/web/assets/updates/dist'),('b8bba377','@lib/timepicker'),('b8ff9dd6','@lib/picturefill'),('b929de','@craft/web/assets/updateswidget/dist'),('bdc6a9','@lib/jquery-ui'),('bdddab9d','@lib/prismjs'),('be51525c','@craft/web/assets/matrixsettings/dist'),('bebb71e8','@craft/web/assets/login/dist'),('bf12b87a','@lib/fileupload'),('bf5ba114','@lib/jquery-touch-events'),('bfda52df','@typedlinkfield/resources'),('c174ba8e','@lib/picturefill'),('c1be93f2','@lib/fileupload'),('c1e50658','@craft/web/assets/editentry/dist'),('c234478b','@lib/d3'),('c41b2a8a','@lib/velocity'),('c43cc405','@bower/jquery/dist'),('c4b743ae','@app/web/assets/sites/dist'),('c5b9954d','@lib/velocity'),('c61788ff','@lib/timepicker'),('c6d0864c','@lib/jquery-touch-events'),('c93a82fc','@craft/web/assets/updates/dist'),('c9949c90','@lib/jquery.payment'),('c9a6e369','@app/web/assets/feed/dist'),('cb355b18','@lib/jquery-touch-events'),('cbd99708','@lib/fileupload'),('cc9167da','@lib/picturefill'),('cdd0559f','@lib/timepicker'),('ce27333','@lib/selectize'),('cfd19adf','@lib/d3'),('d01232e4','@typedlinkfield/resources'),('d04d1faa','@craft/web/assets/editentry/dist'),('d1220e83','@app/web/assets/matrix/dist'),('d1c4f82b','@lib/xregexp'),('d2c6ea46','@app/web/assets/utilities/dist'),('d2dce820','@app/web/assets/editentry/dist'),('d33196f6','@lib/picturefill'),('d36bb189','@craft/web/assets/updater/dist'),('d40ccf4','@lib/selectize'),('d4366230','@bower/jquery/dist'),('d4796624','@lib/fileupload'),('d495aa34','@lib/jquery-touch-events'),('d594ddf7','@bower/jquery/dist'),('d5b33378','@lib/velocity'),('d613a0bd','@lib/prismjs'),('d7f3b25d','@lib/d3'),('d83c8562','@lib/jquery.payment'),('d8929b0e','@craft/web/assets/updates/dist'),('d8d897fb','@craft/web/assets/feed/dist'),('d912acad','@lib/timepicker'),('d956920c','@lib/picturefill'),('d99cbb70','@lib/fileupload'),('d99e3aa5','@lib/jquery.payment'),('daa8f7d6','@craft/web/assets/recententries/dist'),('db92a6f1','@craft/web/assets/utilities/dist'),('dba8bca1','@lib/selectize'),('dbec8419','@app/web/assets/tablesettings/dist'),('dc642484','@craft/web/assets/cp/dist'),('dc74a447','@lib/prismjs'),('dd94b6a7','@lib/d3'),('de002cb7','@app/web/assets/editentry/dist'),('dec02aa4','@craft/web/assets/deprecationerrors/dist'),('def2aece','@lib/jquery-touch-events'),('e099727','@app/web/assets/updater/dist'),('e143c458','@craft/web/assets/dashboard/dist'),('e15b21c6','@app/web/assets/updates/dist'),('e412b5b8','@craft/web/assets/updateswidget/dist'),('e44ea5db','@lib/garnishjs'),('e4cf8433','@lib/fabric'),('e6edf4d8','@lib/xregexp'),('e7cdaabf','@craft/web/assets/craftsupport/dist'),('e878c865','@craft/web/assets/updater/dist'),('e92a5967','@lib/fabric'),('ebac6ff0','@lib/element-resize-detector'),('ec81b052','@lib/selectize'),('ed4f537','@lib/jquery.payment'),('ed87e551','@app/web/assets/updates/dist'),('edbded','@craft/web/assets/utilities/dist'),('edbe1c0f','@lib'),('ee29a121','@lib/garnishjs'),('ee3ba05e','@lib/timepicker'),('ef213ec6','@craft/web/assets/matrixsettings/dist'),('f07f396','@lib/element-resize-detector'),('f0ebddaa','@craft/web/assets/dashboard/dist'),('f10871e5','@lib/fabric'),('f189500d','@lib/garnishjs'),('f22f0dea','@lib/xregexp'),('f27a2a20','@app/web/assets/dashboard/dist'),('f3849400','@lib/selectize'),('f51d046e','@app/web/assets/fields/dist'),('f8434960','@lib/selectize'),('f86cb706','@app/web/assets/matrixsettings/dist'),('f9c1c0f9','@app/web/assets/fields/dist'),('f9e8d08a','@lib/xregexp'),('fa047602','@lib/element-resize-detector'),('fa730e9','@app/web/assets/tablesettings/dist'),('fb6f751f','@lib/fabric'),('fba6c9c5','@lib/element-resize-detector'),('fc1605fd','@lib'),('fc6c8d59','@lib/garnishjs'),('fe6c6c29','@craft/web/assets/cp/dist'),('fe892734','@craft/web/assets/matrixsettings/dist'),('fea6eeb7','@app/web/assets/dashboard/dist');
/*!40000 ALTER TABLE `acr_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_searchindex`
--

LOCK TABLES `acr_searchindex` WRITE;
/*!40000 ALTER TABLE `acr_searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_searchindex` VALUES (1,'username',0,1,' wesley cole87 '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' wesley cole87 gmail com '),(1,'slug',0,1,''),(2,'id',0,1,' 2 '),(2,'title',0,1,' test event '),(2,'startdate',0,1,' 2018 09 03 00 00 00 '),(2,'enddate',0,1,' 2018 09 03 23 59 59 '),(2,'slug',0,1,' test event '),(2,'field',1,1,''),(3,'slug',0,1,''),(3,'field',2,1,' white logo notag '),(5,'kind',0,1,' image '),(5,'slug',0,1,''),(5,'extension',0,1,' png '),(5,'filename',0,1,' white logo notag png '),(5,'title',0,1,' white logo notag '),(6,'slug',0,1,' about '),(6,'title',0,1,' about '),(24,'field',34,1,' 2352 w hanford rd burlington nc 27215 https goo gl maps 3egeq92j2t72 burlington 336 227 5000 101 barnes st carrboro nc 27510 https goo gl maps prdht1bgbgm carrboro 919 929 2099 2719 hillsborough rd durham nc 27705 https goo gl maps 2klv6fa1xyj2 durham 919 286 2228 2201 binford st greensboro nc 27407 https goo gl maps qyvyumkfoxy greensboro 336 854 5800 2416 alwin ct raleigh nc 27604 https goo gl maps 9eesxovcqut raleigh 919 861 2277 3207 burnt mill dr wilmington nc 28403 https goo gl maps gqggihh59ut2 wilmington 910 442 3303 1735 link rd winston salem nc 27103 https goo gl maps zr6hsx5wqmk2 winston salem 336 831 0505 4125 bayswater rd winterville nc 28590 https goo gl maps ux9umltbdsb2 winterville 252 754 2653 4040 s alston ave durham nc 27713 https goo gl maps rmo31c2wpc92 central services 919 765 8081 '),(25,'field',35,1,' burlington '),(25,'field',36,1,' 2352 w hanford rd burlington nc 27215 '),(25,'field',37,1,' 336 227 5000 '),(25,'slug',0,1,''),(26,'field',35,1,' carrboro '),(26,'field',36,1,' 101 barnes st carrboro nc 27510 '),(26,'field',37,1,' 919 929 2099 '),(26,'slug',0,1,''),(27,'field',35,1,' durham '),(27,'field',36,1,' 2719 hillsborough rd durham nc 27705 '),(24,'title',0,1,' locations '),(24,'slug',0,1,' locations '),(8,'slug',0,1,' home '),(8,'title',0,1,' home '),(9,'filename',0,1,' oct 18 web promo jpg '),(9,'extension',0,1,' jpg '),(9,'kind',0,1,' image '),(9,'slug',0,1,''),(9,'title',0,1,' oct 18 web promo '),(64,'field',45,1,' dec18 web promo '),(63,'slug',0,1,''),(63,'title',0,1,' dec18 web promo '),(63,'extension',0,1,' jpg '),(63,'filename',0,1,' dec18 web promo jpg '),(11,'field',7,1,' http acrsupply test locations burlington '),(11,'field',6,1,' we have new store hours to better serve you '),(11,'slug',0,1,' new store hours '),(11,'title',0,1,' new store hours '),(8,'field',8,1,' what we do best '),(8,'field',9,1,' as the weather cools you may be seeing pests around your house in the fall months here are some things to be on the lookout for '),(8,'field',10,1,' what we do best '),(8,'field',11,1,' as the weather cools you may be seeing pests around your house in the fall months here are some things to be on the lookout for '),(8,'field',12,1,' we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time thousands of products we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time https shop acrsupply com thousands of products we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time thousands of products '),(67,'field',25,1,' slider '),(67,'field',26,1,' stay updated with acr '),(12,'field',13,1,' thousands of products '),(12,'field',14,1,' we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time '),(12,'field',15,1,''),(67,'field',27,1,' get vip access for early announcements for all our events and sales '),(12,'slug',0,1,''),(13,'field',13,1,' thousands of products '),(13,'field',14,1,' we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time '),(13,'field',15,1,' https shop acrsupply com '),(13,'slug',0,1,''),(14,'field',13,1,' thousands of products '),(14,'field',14,1,' we have everything that you might need if for some reason we don t we will get it for you don t worry about getting a product on time '),(14,'field',15,1,''),(14,'slug',0,1,''),(8,'field',16,1,' red shop online explore our catalog of products warehouse https store acrsupply com blue request online account quickly request an account to shop with us training lab http acrsupply test request e store account '),(15,'filename',0,1,' building lights bw png '),(15,'extension',0,1,' png '),(15,'kind',0,1,' image '),(15,'slug',0,1,''),(15,'title',0,1,' building lights bw '),(16,'field',17,1,' shop online '),(16,'field',18,1,' explore our catalog of products '),(16,'field',19,1,' warehouse '),(16,'slug',0,1,''),(17,'field',17,1,' request online account '),(17,'field',18,1,' quickly request an account to shop with us '),(17,'field',19,1,' training lab '),(17,'slug',0,1,''),(16,'field',20,1,' red '),(17,'field',20,1,' blue '),(16,'field',22,1,' https store acrsupply com '),(17,'field',22,1,' http acrsupply test request e store account '),(18,'field',23,1,' mark webster '),(18,'field',24,1,' mark macurdy was working at a job site over the weekend emergency call and needed some parts to get a 600 ton chiller up for a customer mark called the after hours number and got jeff mark said that he not only got the part for him he dropped it off at the job site so mark never had to stop working but he also dropped off some water for mark as well mark could not say enough about the professional manner in how he handled having to come out on sunday 102 degrees but he went the extra step to make sure mark was hydrated please recognize this young man in front of your group for going the extra mile troy you know as well as anyone that parts are parts and everyone has them but very few companies find people who go the extra mile this guy will help acr keep customers for life '),(18,'slug',0,1,' mark webster testimonial '),(18,'title',0,1,' mark webster testimonial '),(8,'field',26,1,' stay updated with acr '),(8,'field',27,1,' get vip access for early announcements for all our events and sales '),(8,'field',25,1,' building lights bw '),(22,'field',2,1,''),(22,'field',29,1,' https apple com '),(22,'field',30,1,' https google com '),(22,'field',31,1,' https facebook com '),(22,'slug',0,1,''),(22,'field',32,1,''),(22,'field',33,1,' north carolina s leading hvac and refrigeration wholesale distributor '),(27,'slug',0,1,''),(27,'field',37,1,' 919 286 2228 '),(28,'field',35,1,' greensboro '),(28,'field',36,1,' 2201 binford st greensboro nc 27407 '),(28,'field',37,1,' 336 854 5800 '),(28,'slug',0,1,''),(29,'field',35,1,' raleigh '),(29,'field',36,1,' 2416 alwin ct raleigh nc 27604 '),(29,'field',37,1,' 919 861 2277 '),(29,'slug',0,1,''),(30,'field',35,1,' wilmington '),(30,'field',36,1,' 3207 burnt mill dr wilmington nc 28403 '),(30,'field',37,1,' 910 442 3303 '),(30,'slug',0,1,''),(31,'field',35,1,' winston salem '),(31,'field',36,1,' 1735 link rd winston salem nc 27103 '),(31,'field',37,1,' 336 831 0505 '),(31,'slug',0,1,''),(32,'field',35,1,' winterville '),(32,'field',36,1,' 4125 bayswater rd winterville nc 28590 '),(32,'field',37,1,' 252 754 2653 '),(32,'slug',0,1,''),(33,'field',35,1,' central services '),(33,'field',36,1,' 4040 s alston ave durham nc 27713 '),(33,'field',37,1,' 919 765 8081 '),(33,'slug',0,1,''),(25,'field',38,1,' https goo gl maps 3egeq92j2t72 '),(26,'field',38,1,' https goo gl maps prdht1bgbgm '),(27,'field',38,1,' https goo gl maps 2klv6fa1xyj2 '),(28,'field',38,1,' https goo gl maps qyvyumkfoxy '),(29,'field',38,1,' https goo gl maps 9eesxovcqut '),(30,'field',38,1,' https goo gl maps gqggihh59ut2 '),(31,'field',38,1,' https goo gl maps zr6hsx5wqmk2 '),(32,'field',38,1,' https goo gl maps ux9umltbdsb2 '),(33,'field',38,1,' https goo gl maps rmo31c2wpc92 '),(34,'slug',0,1,' acr cares '),(34,'title',0,1,' acr cares '),(34,'field',39,1,' roc solid foundation builds hope for children battling cancer and their families by offering opportunities for them to do what they do best play roc solid partners with local groups to build playsets and remodel the rooms of children battling cancer acr cares will be building a playset with roc solid october 2018 roc solid foundations providing stability and resources for families everywhere acr cares partners with the local ronald mcdonald house s to cook meals provide gifts and needed materials at christmas time and sponsors a family every christmas ronald mcdonald house operation resolute is a non profit organization based in north carolina that is dedicated to sustaining and strengthening families within the us armed forces by serving with and working through military chaplains by partnering with chaplains operation resolute works within the parameters of the us military while adorning the gospel by being salt and light acr cares partners with operation resolute by hosting daddy daughter dances spouse retreats and other events operation resolute acr cares is currently building an orphanage in the country of burkina faso burkina faso human coalition is a group dedicated to helping women at risk of having an abortion see the beauty of choosing life acr cares takes part in the annual fundraising event 4000 steps human coalition '),(35,'field',40,1,''),(35,'field',41,1,' roc solid foundations '),(35,'field',42,1,' roc solid foundation builds hope for children battling cancer and their families by offering opportunities for them to do what they do best play roc solid partners with local groups to build playsets and remodel the rooms of children battling cancer acr cares will be building a playset with roc solid october 2018 '),(35,'slug',0,1,''),(36,'field',40,1,''),(36,'field',41,1,' ronald mcdonald house '),(36,'field',42,1,' providing stability and resources for families everywhere acr cares partners with the local ronald mcdonald house s to cook meals provide gifts and needed materials at christmas time and sponsors a family every christmas '),(36,'slug',0,1,''),(37,'field',40,1,''),(37,'field',41,1,' operation resolute '),(37,'field',42,1,' operation resolute is a non profit organization based in north carolina that is dedicated to sustaining and strengthening families within the us armed forces by serving with and working through military chaplains by partnering with chaplains operation resolute works within the parameters of the us military while adorning the gospel by being salt and light acr cares partners with operation resolute by hosting daddy daughter dances spouse retreats and other events '),(37,'slug',0,1,''),(38,'field',40,1,''),(38,'field',41,1,' burkina faso '),(38,'field',42,1,' acr cares is currently building an orphanage in the country of burkina faso '),(38,'slug',0,1,''),(39,'field',40,1,''),(39,'field',41,1,' human coalition '),(39,'field',42,1,' human coalition is a group dedicated to helping women at risk of having an abortion see the beauty of choosing life acr cares takes part in the annual fundraising event 4000 steps '),(39,'slug',0,1,''),(34,'field',43,1,' annual scholarship to our team members children benevolence fund for team members going through difficult times corporate chaplains ministry pamphlets in all our locations annual awards banquet annual family fun day marriage retreats for team members and their spouses volunteer policy mission trip policy disaster relief policy '),(40,'field',44,1,' annual scholarship to our team members children '),(40,'slug',0,1,''),(41,'field',44,1,' benevolence fund for team members going through difficult times '),(41,'slug',0,1,''),(42,'field',44,1,' corporate chaplains '),(42,'slug',0,1,''),(43,'field',44,1,' ministry pamphlets in all our locations '),(43,'slug',0,1,''),(44,'field',44,1,' annual awards banquet '),(44,'slug',0,1,''),(45,'field',44,1,' annual family fun day '),(45,'slug',0,1,''),(46,'field',44,1,' marriage retreats for team members and their spouses '),(46,'slug',0,1,''),(47,'field',44,1,' volunteer policy '),(47,'slug',0,1,''),(48,'field',44,1,' mission trip policy '),(48,'slug',0,1,''),(49,'field',44,1,' disaster relief policy '),(49,'slug',0,1,''),(50,'slug',0,1,' contact '),(50,'title',0,1,' contact '),(52,'title',0,1,' request e store account '),(52,'slug',0,1,' request e store account '),(53,'slug',0,1,' e store credit application '),(53,'title',0,1,' e store credit application '),(54,'slug',0,1,' pay online '),(54,'title',0,1,' pay online '),(55,'slug',0,1,' training and education '),(55,'title',0,1,' training and education '),(56,'slug',0,1,' scholarships '),(56,'title',0,1,' scholarships '),(57,'slug',0,1,' careers '),(57,'title',0,1,' careers '),(58,'slug',0,1,' associates '),(58,'title',0,1,' associates '),(60,'title',0,1,' about us '),(60,'slug',0,1,' about us '),(61,'filename',0,1,' slider png '),(61,'extension',0,1,' png '),(61,'kind',0,1,' image '),(61,'slug',0,1,''),(61,'title',0,1,' slider '),(62,'filename',0,1,' slider png '),(62,'extension',0,1,' png '),(62,'kind',0,1,' image '),(62,'slug',0,1,''),(62,'title',0,1,' slider '),(63,'kind',0,1,' image '),(64,'field',4,1,''),(64,'slug',0,1,' dec18 promotion '),(64,'title',0,1,' dec18 promotion '),(65,'filename',0,1,' warehouse jpg '),(65,'extension',0,1,' jpg '),(65,'kind',0,1,' image '),(65,'slug',0,1,''),(65,'title',0,1,' warehouse '),(66,'filename',0,1,' training lab jpg '),(66,'extension',0,1,' jpg '),(66,'kind',0,1,' image '),(66,'slug',0,1,''),(66,'title',0,1,' training lab '),(67,'slug',0,1,'');
/*!40000 ALTER TABLE `acr_searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sections`
--

LOCK TABLES `acr_sections` WRITE;
/*!40000 ALTER TABLE `acr_sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_sections` VALUES (2,NULL,'About','about','single',1,1,'2018-10-08 23:53:17','2018-10-10 23:45:28',NULL,'fc6457f4-0483-4d21-a704-9f47893b5ada'),(3,NULL,'Promotions','promotions','channel',1,1,'2018-10-09 00:13:24','2019-01-27 18:17:45',NULL,'deefb807-a3f2-4b77-9b48-aa6bd8864f7f'),(4,NULL,'Home','home','single',1,1,'2018-10-10 23:42:21','2018-10-10 23:42:21',NULL,'148a408c-a3e0-469e-aa18-46200336c446'),(5,NULL,'Notifications','notifications','channel',1,1,'2018-11-02 01:16:09','2018-11-02 01:16:09',NULL,'c3c14b51-1050-404a-b79d-ac586030e8a4'),(6,NULL,'Testimonials','testimonials','channel',1,1,'2018-12-17 01:13:58','2018-12-17 01:13:58',NULL,'33cd06cd-ae75-4b06-ae73-5ab87ecf2963'),(8,NULL,'Locations','locations','single',1,1,'2019-01-02 01:08:25','2019-01-02 01:15:39',NULL,'b19546f5-4ea4-4336-8cd0-1623e4279468'),(9,NULL,'ACR Cares','acrCares','single',1,1,'2019-01-23 02:23:36','2019-01-23 03:04:05',NULL,'8b99fb28-9536-4c55-8adc-cff3e561baff'),(10,NULL,'Contact','contact','single',1,1,'2019-01-24 01:56:00','2019-01-24 01:56:00',NULL,'720bf92c-3db9-49d3-8814-2a047cb85e8c'),(11,NULL,'Request E-Store Account','eStore','single',1,1,'2019-01-24 02:30:36','2019-01-24 02:30:42',NULL,'6fbf9061-9641-4350-9e34-a974e674a2e9'),(12,NULL,'E-Store Credit Application','eStoreCreditApplication','single',1,1,'2019-01-24 02:35:59','2019-01-24 02:36:46',NULL,'4d4a42c3-dac6-4331-8d12-fe4460f697d1'),(13,NULL,'Pay Online','payOnline','single',1,1,'2019-01-24 03:20:09','2019-01-24 03:20:09',NULL,'f7d15cfa-53c3-4526-ab2d-84124c9f1d2f'),(14,NULL,'Training and Education','trainingAndEducation','single',1,1,'2019-01-25 02:16:36','2019-01-25 02:16:36',NULL,'ab2deffb-873a-4836-82c1-42b602c2b02f'),(15,NULL,'Scholarships','scholarships','single',1,1,'2019-01-25 02:27:28','2019-01-25 02:27:28',NULL,'b94ea8c9-c5ce-4409-b4d6-1bce2ead4787'),(16,NULL,'Careers','careers','single',1,1,'2019-01-25 02:29:08','2019-01-25 02:29:08',NULL,'b766f97e-4a11-4234-b7a0-86790e70977e'),(17,NULL,'Associates','associates','single',1,1,'2019-01-25 02:30:45','2019-01-25 02:30:45',NULL,'2ab94a27-43de-4c5d-99b7-f5a5667c2fde'),(18,NULL,'The Story','theStory','single',1,1,'2019-01-25 02:32:27','2019-01-25 02:33:02','2019-01-25 02:33:03','0a19efa6-f797-42d1-8bf5-91ad001d82d1'),(19,1,'Pages','pages','structure',1,1,'2019-01-25 02:42:26','2019-01-25 02:42:26',NULL,'aa8de52f-f0b3-4669-b39b-86de1ea3266e');
/*!40000 ALTER TABLE `acr_sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `acr_sections_sites`
--

LOCK TABLES `acr_sections_sites` WRITE;
/*!40000 ALTER TABLE `acr_sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `acr_sections_sites` VALUES (2,2,1,1,'about','about',1,'2018-10-08 23:53:17','2018-10-10 23:45:28','b47b32ca-4983-4635-85fa-1559b2f4f920'),(3,3,1,1,'promotions/{slug}','promotions/_entry',1,'2018-10-09 00:13:24','2019-01-27 18:17:45','19ff82bf-0c81-439b-b0d2-9edd4b5347f4'),(4,4,1,1,'__home__','index.html',1,'2018-10-10 23:42:21','2018-10-10 23:42:21','4654d8c5-8c4a-4483-95ed-803d3182879e'),(5,5,1,1,'notifications/{slug}','notifications/_entry',1,'2018-11-02 01:16:09','2018-11-02 01:16:09','2307ac2f-c736-4975-8a89-7633ae89cb75'),(6,6,1,1,'testimonials/{slug}','testimonials/_entry',1,'2018-12-17 01:13:58','2018-12-17 01:13:58','b2af5ba5-555c-41c9-86d0-dafa354fb92f'),(8,8,1,1,'locations','locations',1,'2019-01-02 01:08:25','2019-01-02 01:15:39','5c116521-9aee-4b75-8d1b-a7f5afb76e28'),(9,9,1,1,'acr-cares','acrCares',1,'2019-01-23 02:23:36','2019-01-23 03:04:05','8fc48536-b51f-407c-89a7-cd47e94443f8'),(10,10,1,1,'contact','contact',1,'2019-01-24 01:56:00','2019-01-24 01:56:00','374c4515-7b6c-41df-91a5-cc4edae935a0'),(11,11,1,1,'request-e-store-account','eStore',1,'2019-01-24 02:30:36','2019-01-24 02:30:42','32c6fc97-ba06-40e4-9714-aa5f6972761a'),(12,12,1,1,'estore-credit-application','eStoreCredit',1,'2019-01-24 02:35:59','2019-01-24 02:36:46','7e8a877c-348f-499e-ab56-7d0c56bbbe19'),(13,13,1,1,'pay-online','payOnline',1,'2019-01-24 03:20:09','2019-01-24 03:20:09','ed0c65c5-6874-450f-9a4f-51e192d7f043'),(14,14,1,1,'training-and-education','trainingAndEducation',1,'2019-01-25 02:16:36','2019-01-25 02:16:36','1d191efa-60d1-4689-ac79-543e871836a8'),(15,15,1,1,'scholarships','scholarships',1,'2019-01-25 02:27:28','2019-01-25 02:27:28','54ff4f3e-81f6-4fbb-bec2-6d7b4cc9b290'),(16,16,1,1,'careers','careers',1,'2019-01-25 02:29:08','2019-01-25 02:29:08','3551f61d-f4f1-4144-af0f-6cba4cb2ff3a'),(17,17,1,1,'associates','associates',1,'2019-01-25 02:30:45','2019-01-25 02:30:45','075d9556-9fee-479b-82cd-0e276ff36089'),(18,18,1,1,'the-story','theStory',1,'2019-01-25 02:32:27','2019-01-25 02:33:02','997b5d12-bc80-4a18-9771-271844e3b7b7'),(19,19,1,1,'pages/{slug}','',1,'2019-01-25 02:42:26','2019-01-25 02:42:26','53ad489a-08f6-4b90-9115-6f0e606bb971');
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
INSERT INTO `acr_users` VALUES (1,'wesley.cole87',NULL,NULL,NULL,'wesley.cole87@gmail.com','$2y$13$oSmne8Jb48zankPcc5vY5.XUllCrQATUwlDHDP4n0Oz4LSv47O20O',1,0,0,0,'2019-01-31 02:39:33','127.0.0.1',NULL,NULL,'2019-01-17 02:39:53',NULL,1,NULL,NULL,NULL,0,'2018-09-30 15:22:58','2018-09-30 15:22:58','2019-01-31 02:39:33','ab56c1b9-afab-4353-af4a-756bfd9a4be6');
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

-- Dump completed on 2019-01-30 22:24:59
