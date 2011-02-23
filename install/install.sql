/*
SQLyog Enterprise - MySQL GUI v8.01 
MySQL - 5.5.8-log : Database - tantalum_meta
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

/*Table structure for table `tan_button` */

DROP TABLE IF EXISTS `tan_button`;

CREATE TABLE `tan_button` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `viewID` char(36) NOT NULL,
  `buttonType` varchar(20) NOT NULL,
  `onClick` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tableName` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_button` */

/*Table structure for table `tan_column` */

DROP TABLE IF EXISTS `tan_column`;

CREATE TABLE `tan_column` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `tableID` char(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  `required` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `displayOrder` int(11) NOT NULL DEFAULT '0',
  `columnType` varchar(20) DEFAULT NULL,
  `size` tinyint(4) DEFAULT NULL,
  `precision` tinyint(4) DEFAULT NULL,
  `dbName` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tableName` (`name`,`tableID`),
  KEY `FK_tan_column` (`tableID`),
  CONSTRAINT `FK_tan_column` FOREIGN KEY (`tableID`) REFERENCES `tan_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_column` */

insert  into `tan_column`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`tableID`,`name`,`required`,`displayOrder`,`columnType`,`size`,`precision`,`dbName`,`label`) values ('1c8e5729-3c64-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce9394a-9f57-11df-936f-e37ecc873ea2','IndexID',1,20,'String',NULL,NULL,'indexID','IndexID'),('1c981a94-3c64-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce9394a-9f57-11df-936f-e37ecc873ea2','IndexColumnID',1,10,'UUID',NULL,NULL,'id','IndexColumnID'),('1e663a3d-3e57-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','AfterEdit',1,500,'String',NULL,NULL,'afteredit',NULL),('22f06ff8-3c50-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce937aa-9f57-11df-936f-e37ecc873ea2','TableID',1,20,'String',NULL,NULL,'tableID','Table ID'),('2cc151a7-3c64-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce9394a-9f57-11df-936f-e37ecc873ea2','ColumnID',1,30,'String',NULL,NULL,'columnID','ColumnID'),('34b8e1dc-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2','TableID',1,10,'UUID',11,NULL,'id','Table ID'),('34b8e6d9-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2','Name',1,20,'String',50,NULL,'name','Table name'),('34b8e8cf-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2','DatabaseName',1,30,'String',50,NULL,'dbName','DB name'),('34b8f09b-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2','Name',1,30,'String',50,NULL,'name','Name'),('34b8f27a-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2','ColumnID',1,10,'UUID',11,NULL,'id','ColumnID'),('34b8f465-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2','TableID',1,20,'String',11,NULL,'tableID','TableID'),('34b8f638-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2','Required',1,35,'Boolean',NULL,NULL,'required','Required'),('34b8f812-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2','Order',1,25,'Integer',11,NULL,'displayOrder','Order'),('34b8f9e5-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','ModelID',1,10,'UUID',11,NULL,'id','ModelID'),('34b8fd81-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2','JoinID',1,10,'UUID',11,NULL,'id','JoinID'),('34b8ff5a-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2','FromTableID',1,20,'String',11,NULL,'fromTableID',NULL),('34b90128-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2','ToTableID',1,30,'String',11,NULL,'toTableID',NULL),('34b902f6-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','ResultsPerPage',0,30,'Integer',NULL,NULL,'resultsPerPage','Results per page'),('34b904c4-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2','Database',0,50,'String',50,NULL,'dbName','Database'),('34b90692-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','BasisTableID',0,60,'String',11,NULL,'basisTableID','BasisTableID'),('34b90860-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','Name',1,70,'String',50,NULL,'name','Name'),('34b90a28-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','ParentID',0,80,'String',11,NULL,'parentID','ParentID'),('34b90bf6-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','ReferenceID',0,90,'String',11,NULL,'referenceID','ReferenceID'),('34b92852-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93150-9f57-11df-936f-e37ecc873ea2','Type',1,10,'String',NULL,NULL,'enumType',NULL),('34b92ac5-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2','CreatedBy',0,240,'CreatedBy',NULL,NULL,'createdBy','CreatedBy'),('34b92ca5-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2','UpdatedBy',0,250,'UpdatedBy',NULL,NULL,'updatedBy','UpdatedBy'),('34b92e7e-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2','CreationDate',0,260,'CreationDate',NULL,NULL,'creationDate','CreationDate'),('34b93057-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2','UpdateDate',0,270,'UpdateDate',NULL,NULL,'updateDate','UpdateDate'),('34b93231-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2','UpdateProcess',0,280,'UpdateProcess',NULL,NULL,'updateProcess','UpdateProcess'),('34b933f9-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2','Project',0,90,'String',NULL,NULL,'projectID','Project ID'),('34b935c1-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2','Database',0,100,'String',NULL,NULL,'databaseID','Database ID'),('34b9378f-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2','ColumnType',1,60,'String',NULL,NULL,'columnType','ColumnType'),('34b9395d-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2','Size',1,70,'Integer',NULL,NULL,'size','Size'),('34b93b25-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2','Precision',1,80,'Integer',NULL,NULL,'precision','Precision'),('34b93cf3-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2','Label',0,90,'String',NULL,NULL,'label','Label'),('34b93ec7-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','FieldID',1,10,'UUID',NULL,NULL,'id','FieldID'),('34b94095-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93150-9f57-11df-936f-e37ecc873ea2','Enum',1,20,'String',NULL,NULL,'enumValue',NULL),('34b94285-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93150-9f57-11df-936f-e37ecc873ea2','Meaning',0,30,'String',NULL,NULL,'meaning',NULL),('34b94453-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2','CreatedBy',0,240,'CreatedBy',NULL,NULL,'createdBy',NULL),('34b94626-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2','UpdatedBy',0,250,'UpdatedBy',NULL,NULL,'updatedBy',NULL),('34b94777-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2','CreationDate',0,260,'CreationDate',NULL,NULL,'creationDate',NULL),('34b94911-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2','UpdateDate',0,270,'UpdateDate',NULL,NULL,'updateDate',NULL),('34b94a68-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2','UpdateProcess',0,280,'UpdateProcess',NULL,NULL,'updateProcess',NULL),('34b96e34-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','CreatedBy',0,540,'CreatedBy',NULL,NULL,'createdBy',NULL),('34b96f85-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','UpdatedBy',0,550,'UpdatedBy',NULL,NULL,'updatedBy',NULL),('34b970d0-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','CreationDate',0,560,'CreationDate',NULL,NULL,'creationDate',NULL),('34b9721a-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','UpdateDate',0,570,'UpdateDate',NULL,NULL,'updateDate',NULL),('34b9736b-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','UpdateProcess',0,580,'UpdateProcess',NULL,NULL,'updateProcess',NULL),('34b974b6-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','CreatedBy',0,240,'CreatedBy',NULL,NULL,'createdBy','CreatedBy'),('34b97600-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','UpdatedBy',0,250,'UpdatedBy',NULL,NULL,'updatedBy','UpdatedBy'),('34b9774b-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','CreationDate',0,260,'CreationDate',NULL,NULL,'creationDate','CreationDate'),('34b9789c-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','UpdateDate',0,270,'UpdateDate',NULL,NULL,'updateDate','UpdateDate'),('34b979e6-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2','UpdateProcess',0,280,'UpdateProcess',NULL,NULL,'updateProcess','UpdateProcess'),('34b97b70-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce932f6-9f57-11df-936f-e37ecc873ea2','CreatedBy',0,240,'CreatedBy',NULL,NULL,'createdBy',NULL),('34b97cbb-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce932f6-9f57-11df-936f-e37ecc873ea2','UpdatedBy',0,250,'UpdatedBy',NULL,NULL,'updatedBy',NULL),('34b97e0b-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce932f6-9f57-11df-936f-e37ecc873ea2','CreationDate',0,260,'CreationDate',NULL,NULL,'creationDate',NULL),('34b97f56-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce932f6-9f57-11df-936f-e37ecc873ea2','UpdateDate',0,270,'UpdateDate',NULL,NULL,'updateDate',NULL),('34b980a6-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce932f6-9f57-11df-936f-e37ecc873ea2','UpdateProcess',0,280,'UpdateProcess',NULL,NULL,'updateProcess',NULL),('34b981f7-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce932f6-9f57-11df-936f-e37ecc873ea2','Id',1,10,'UUID',11,NULL,'id',NULL),('34b98347-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','CreatedBy',0,240,'CreatedBy',NULL,NULL,'createdBy','CreatedBy'),('34b98492-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','UpdatedBy',0,250,'UpdatedBy',NULL,NULL,'updatedBy','UpdatedBy'),('34b985dd-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','CreationDate',0,260,'CreationDate',NULL,NULL,'creationDate','CreationDate'),('34b9873e-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','UpdateDate',0,270,'UpdateDate',NULL,NULL,'updateDate','UpdateDate'),('34b98895-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','UpdateProcess',0,280,'UpdateProcess',NULL,NULL,'updateProcess','UpdateProcess'),('34b989eb-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','Id',1,10,'UUID',11,NULL,'id','Id'),('34b98b41-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2','CreatedBy',0,240,'CreatedBy',NULL,NULL,'createdBy',NULL),('34b9a5e6-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2','UpdatedBy',0,250,'UpdatedBy',NULL,NULL,'updatedBy',NULL),('34b9a747-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2','CreationDate',0,260,'CreationDate',NULL,NULL,'creationDate',NULL),('34b9a8a3-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2','UpdateDate',0,270,'UpdateDate',NULL,NULL,'updateDate',NULL),('34b9a9f9-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2','UpdateProcess',0,280,'UpdateProcess',NULL,NULL,'updateProcess',NULL),('34be5a72-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2','ReferenceID',1,10,'UUID',11,NULL,'id','ReferenceID'),('34be5cad-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2','CreatedBy',0,240,'CreatedBy',NULL,NULL,'createdBy',NULL),('34be5e1f-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2','UpdatedBy',0,250,'UpdatedBy',NULL,NULL,'updatedBy',NULL),('34be5fb4-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2','CreationDate',0,260,'CreationDate',NULL,NULL,'creationDate',NULL),('34deb994-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2','UpdateDate',0,270,'UpdateDate',NULL,NULL,'updateDate',NULL),('34debc74-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2','UpdateProcess',0,280,'UpdateProcess',NULL,NULL,'updateProcess',NULL),('34debe14-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2','Id',1,10,'UUID',11,NULL,'id',NULL),('34debf98-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2','Join',1,20,'String',NULL,NULL,'joinID',NULL),('34dec111-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2','FromColumn',0,30,'String',NULL,NULL,'fromColumnID',NULL),('34dec3df-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2','FromConstant',0,40,'String',NULL,NULL,'fromText',NULL),('34dec5be-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2','ToColumn',1,50,'String',NULL,NULL,'toColumnID',NULL),('34dec737-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2','Name',0,40,'String',NULL,NULL,'name',NULL),('34dec8a4-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2','Type',1,50,'String',NULL,NULL,'joinType',NULL),('34deca1c-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','ModelID',1,20,'String',NULL,NULL,'modelID',NULL),('34decb83-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','Name',1,30,'String',NULL,NULL,'name',NULL),('34decd73-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','BasisColumnID',0,40,'String',NULL,NULL,'basisColumnID',NULL),('34deceec-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','ReferenceID',0,50,'String',NULL,NULL,'referenceID',NULL),('34ded064-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','Visible',1,60,'Boolean',NULL,NULL,'visible',NULL),('34ded20a-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','Label',0,70,'String',NULL,NULL,'label',NULL),('34ded377-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','View',0,80,'String',NULL,NULL,'viewID',NULL),('34defdc5-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','Label',0,80,'String',NULL,NULL,'label','Label'),('34deff4f-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','Parent',0,90,'String',NULL,NULL,'parentID','Parent view'),('34df00b0-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','DisplayOrder',1,100,'Integer',NULL,NULL,'displayOrder','Order'),('34df0223-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','Model',1,20,'String',NULL,NULL,'modelID','ModelID'),('34df0396-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','Name',1,120,'String',NULL,NULL,'name','View name'),('34df0503-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','DisplayOrder',1,140,'Integer',NULL,NULL,'displayOrder',NULL),('34df066a-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','DisplayType',1,150,'String',NULL,NULL,'displayType',NULL),('34df07d7-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','Size',1,160,'Integer',NULL,NULL,'size',NULL),('34df0944-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','Addable',1,170,'Boolean',NULL,NULL,'addable',NULL),('34df0ab1-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','Editable',1,180,'Boolean',NULL,NULL,'editable',NULL),('34df0c18-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','Searchable',1,190,'Boolean',NULL,NULL,'searchable',NULL),('34df0d7f-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','DefaultActionID',0,200,'String',NULL,NULL,'defaultActionID',NULL),('34df0f25-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','ForceDefault',1,210,'Boolean',NULL,NULL,'forceDefault',NULL),('34df1070-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','DefaultValue',0,220,'String',NULL,NULL,'defaultValue',NULL),('7a80418e-3e59-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','SortDirection',1,260,'String',NULL,NULL,'sortDirection',NULL),('7a8857f6-3e59-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','SortOrder',1,250,'Integer',NULL,NULL,'sortOrder',NULL),('b1ba80e2-3dda-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2','Name',0,50,'String',NULL,NULL,'name','Name'),('b1c439e5-3dda-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2','ParentID',0,40,'String',NULL,NULL,'parentID','ParentID'),('b1c7a0cc-3dda-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2','JoinID',1,30,'String',NULL,NULL,'joinID','JoinID'),('b2ad109d-3ef9-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','SelectorID',1,240,'String',NULL,NULL,'selectorID','SelectorID'),('c67a2c0c-3c9d-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce93485-9f57-11df-936f-e37ecc873ea2','ViewType',0,130,'String',NULL,NULL,'viewType','View type'),('db825fa1-3dd9-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2','ModelID',1,20,'String',NULL,NULL,'modelID','ModelID'),('e2e6a5cb-3c4f-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce937aa-9f57-11df-936f-e37ecc873ea2','IndexID',1,10,'UUID',NULL,NULL,'id','Index ID'),('f42d5fa4-3e56-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2','DefaultFieldID',0,230,'String',NULL,NULL,'defaultFieldID',NULL),('fce937aa-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce937aa-9f57-11df-936f-e37ecc873ea2','UniqueIndex',1,30,'String',NULL,NULL,'uniqueIndex','Unique');

/*Table structure for table `tan_database` */

DROP TABLE IF EXISTS `tan_database`;

CREATE TABLE `tan_database` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `server` varchar(50) DEFAULT NULL,
  `database` varchar(50) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_database` */

insert  into `tan_database`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`server`,`database`,`username`,`password`) values ('4fb1a314-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'localhost','tantalum_meta','root','');

/*Table structure for table `tan_enum_generic` */

DROP TABLE IF EXISTS `tan_enum_generic`;

CREATE TABLE `tan_enum_generic` (
  `enumType` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  `meaning` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_enum_generic` */

insert  into `tan_enum_generic`(`enumType`,`value`,`meaning`) values ('JoinTypes','OO','One to one'),('JoinTypes','OM','One to many'),('DisplayTypes','RB','Radio button'),('DisplayTypes','TF','Text field'),('DisplayTypes','TA','Text area'),('DisplayTypes','SB','Select box');

/*Table structure for table `tan_field` */

DROP TABLE IF EXISTS `tan_field`;

CREATE TABLE `tan_field` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `modelID` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `basisColumnID` char(36) DEFAULT NULL,
  `referenceID` char(36) DEFAULT NULL,
  `visible` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `label` varchar(50) DEFAULT NULL,
  `displayOrder` int(11) NOT NULL DEFAULT '10',
  `displayType` varchar(20) DEFAULT NULL,
  `viewID` char(36) DEFAULT NULL,
  `size` int(11) NOT NULL DEFAULT '0',
  `addable` tinyint(4) NOT NULL DEFAULT '1',
  `editable` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `searchable` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `defaultActionID` char(36) DEFAULT NULL,
  `forceDefault` tinyint(4) NOT NULL DEFAULT '0',
  `defaultValue` varchar(100) DEFAULT NULL,
  `defaultScript` text,
  `defaultFieldID` char(36) DEFAULT NULL,
  `defaultFieldType` varchar(20) DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `sortDirection` varchar(4) DEFAULT NULL,
  `selectorID` char(36) DEFAULT NULL,
  `editor` text,
  `renderer` text,
  `afteredit` text,
  PRIMARY KEY (`id`),
  KEY `FK_tan_field_model` (`modelID`),
  KEY `FK_tan_field` (`referenceID`),
  CONSTRAINT `FK_tan_field` FOREIGN KEY (`referenceID`) REFERENCES `tan_reference` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_tan_field_model` FOREIGN KEY (`modelID`) REFERENCES `tan_model` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_field` */

insert  into `tan_field`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`modelID`,`name`,`basisColumnID`,`referenceID`,`visible`,`label`,`displayOrder`,`displayType`,`viewID`,`size`,`addable`,`editable`,`searchable`,`defaultActionID`,`forceDefault`,`defaultValue`,`defaultScript`,`defaultFieldID`,`defaultFieldType`,`sortOrder`,`sortDirection`,`selectorID`,`editor`,`renderer`,`afteredit`) values ('1ea44dde-2911-11e0-b23a-001c238ae411',NULL,NULL,NULL,NULL,NULL,'095e1122-9f58-11df-936f-e37ecc873ea2','ListModelBasisTableName','34b8e6d9-9f56-11df-936f-e37ecc873ea2','1cf68a98-2909-11e0-b23a-001c238ae411',1,'Basis Table',45,'ComboBox','e8806a9d-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,'095e0687-9f58-11df-936f-e37ecc873ea2',NULL,NULL,NULL),('3ef8edd7-3d11-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'459404e9-3d0f-11e0-8705-001c238ae411','DefineTableIndexColumnIndexID','1c8e5729-3c64-11e0-8c47-001c238ae411',NULL,1,'IndexID',20,'String','32ee7a32-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,'ba5f02a8-3c51-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('3ef90a44-3d11-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'459404e9-3d0f-11e0-8705-001c238ae411','DefineTableIndexColumnIndexColumnID','1c981a94-3c64-11e0-8c47-001c238ae411',NULL,1,'IndexColumnID',10,'UUID','32ee7a32-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('3ef91f79-3d11-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'459404e9-3d0f-11e0-8705-001c238ae411','DefineTableIndexColumnColumnID','2cc151a7-3c64-11e0-8c47-001c238ae411',NULL,1,'ColumnID',30,'String','32ee7a32-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('407eacdd-3d13-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','DefineTableJoinParentColumnCreatedBy','34be5cad-9f56-11df-936f-e37ecc873ea2',NULL,0,'Created by',240,'CreatedBy','be373ebd-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('407eba7f-3d13-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','DefineTableJoinParentColumnUpdatedBy','34be5e1f-9f56-11df-936f-e37ecc873ea2',NULL,0,'Updated by',250,'UpdatedBy','be373ebd-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('407ebde8-3d13-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','DefineTableJoinParentColumnCreationDate','34be5fb4-9f56-11df-936f-e37ecc873ea2',NULL,0,'Creation date',260,'CreationDate','be373ebd-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('407ec0ea-3d13-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','DefineTableJoinParentColumnUpdateDate','34deb994-9f56-11df-936f-e37ecc873ea2',NULL,0,'Update date',270,'UpdateDate','be373ebd-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('407ec3db-3d13-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','DefineTableJoinParentColumnUpdateProcess','34debc74-9f56-11df-936f-e37ecc873ea2',NULL,0,'Update process',280,'UpdateProcess','be373ebd-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('407ec70a-3d13-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','DefineTableJoinParentColumnId','34debe14-9f56-11df-936f-e37ecc873ea2',NULL,0,'ID',10,'UUID','be373ebd-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('407ec9de-3d13-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','DefineTableJoinParentColumnJoin','34debf98-9f56-11df-936f-e37ecc873ea2',NULL,1,'JoinID',20,'String','be373ebd-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,1,NULL,NULL,'55145c3c-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('407ecc9c-3d13-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','DefineTableJoinParentColumnFromColumn','34dec111-9f56-11df-936f-e37ecc873ea2',NULL,1,'FromColumnID',30,'String','be373ebd-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('407ecf59-3d13-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','DefineTableJoinParentColumnFromConstant','34dec3df-9f56-11df-936f-e37ecc873ea2',NULL,0,'From constant',40,'String','be373ebd-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('407ed815-3d13-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','DefineTableJoinParentColumnToColumn','34dec5be-9f56-11df-936f-e37ecc873ea2',NULL,1,'ToColumnID',50,'String','be373ebd-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('4dec17ca-3e57-11e0-8705-001c238ae411',NULL,NULL,'2011-02-21 23:44:48',NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldDefaultFieldID','f42d5fa4-3e56-11e0-8705-001c238ae411',NULL,1,'DefaultFieldID',200,NULL,'05d0777b-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55142ce5-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0687-9f58-11df-936f-e37ecc873ea2','ManageTablesTableID','34b8e1dc-9f56-11df-936f-e37ecc873ea2',NULL,1,'ID',10,'Text','e88065f5-9f57-11df-936f-e37ecc873ea2',100,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('551431ba-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0687-9f58-11df-936f-e37ecc873ea2','ManageTablesName','34b8e6d9-9f56-11df-936f-e37ecc873ea2',NULL,1,'Table name',20,'Text','e88065f5-9f57-11df-936f-e37ecc873ea2',0,1,1,1,'5ba14a0d-9f56-11df-936f-e37ecc873ea2',0,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,'e.record.data.ManageTablesDatabaseName = \'tan_\' + e.value.toLowerCase();'),('551435fc-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0687-9f58-11df-936f-e37ecc873ea2','ManageTablesDatabaseName','34b8e8cf-9f56-11df-936f-e37ecc873ea2',NULL,1,'DB name',30,'Text','e88065f5-9f57-11df-936f-e37ecc873ea2',0,1,1,1,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('5514388b-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0978-9f58-11df-936f-e37ecc873ea2','DefineTableTableID','34b8e1dc-9f56-11df-936f-e37ecc873ea2',NULL,1,'ID',10,'Text','e88068d5-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55143aee-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0978-9f58-11df-936f-e37ecc873ea2','DefineTableName','34b8e6d9-9f56-11df-936f-e37ecc873ea2',NULL,1,'Table name',20,'Text','e88068d5-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,NULL),('55143d50-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0978-9f58-11df-936f-e37ecc873ea2','DefineTableDatabaseName','34b8e8cf-9f56-11df-936f-e37ecc873ea2',NULL,1,'DB name',30,'Text','e88068d5-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55144b97-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0f48-9f58-11df-936f-e37ecc873ea2','DefineTableColumnName','34b8f09b-9f56-11df-936f-e37ecc873ea2',NULL,1,'Name',20,'Text','e8806e17-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55144de3-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0f48-9f58-11df-936f-e37ecc873ea2','DefineTableColumnID','34b8f27a-9f56-11df-936f-e37ecc873ea2',NULL,1,'ID',10,'Text','e8806e17-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('551454e2-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0f48-9f58-11df-936f-e37ecc873ea2','DefineTableColumnRequired','34b8f638-9f56-11df-936f-e37ecc873ea2',NULL,1,'Required',30,'Checkbox','e8806e17-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'function (value) {\r\n	return value ? \"Yes\" : \"No\";\r\n}\r\n',NULL),('55145749-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0f48-9f58-11df-936f-e37ecc873ea2','DefineTableColumnDisplayOrder','34b8f812-9f56-11df-936f-e37ecc873ea2',NULL,1,'Order',15,'Text','e8806e17-9f57-11df-936f-e37ecc873ea2',50,1,1,0,NULL,0,NULL,'return (row * 10) + 10;',NULL,NULL,10,NULL,NULL,'',NULL,NULL),('551459b1-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e12fb-9f58-11df-936f-e37ecc873ea2','JoinFromTableID','34b8ff5a-9f56-11df-936f-e37ecc873ea2',NULL,1,'FromTableID',20,'Text','e8806fce-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,'5514388b-9f56-11df-936f-e37ecc873ea2','Hard',NULL,NULL,NULL,NULL,NULL,NULL),('55145c3c-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e12fb-9f58-11df-936f-e37ecc873ea2','JoinJoinID','34b8fd81-9f56-11df-936f-e37ecc873ea2',NULL,1,'JoinID',10,'Text','e8806fce-9f57-11df-936f-e37ecc873ea2',0,0,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55145e8d-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e1122-9f58-11df-936f-e37ecc873ea2','ListModelModelID','34b8f9e5-9f56-11df-936f-e37ecc873ea2',NULL,1,'Model ID',10,'Text','e8806a9d-9f57-11df-936f-e37ecc873ea2',225,0,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('551460de-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e12fb-9f58-11df-936f-e37ecc873ea2','JoinToTableID','34b90128-9f56-11df-936f-e37ecc873ea2',NULL,1,'ToTableID',30,'Text','e8806fce-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55146329-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e12fb-9f58-11df-936f-e37ecc873ea2','JoinToTableName','34b8e6d9-9f56-11df-936f-e37ecc873ea2','e3258b49-9f57-11df-936f-e37ecc873ea2',1,'To table',40,'Text','e8806fce-9f57-11df-936f-e37ecc873ea2',0,1,1,0,'5ba14e54-9f56-11df-936f-e37ecc873ea2',0,NULL,NULL,NULL,NULL,20,NULL,NULL,NULL,NULL,NULL),('5514657a-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0f48-9f58-11df-936f-e37ecc873ea2','DefineTableColumnDbName','34b904c4-9f56-11df-936f-e37ecc873ea2',NULL,1,'Database',40,'Text','e8806e17-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('551467c6-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e1122-9f58-11df-936f-e37ecc873ea2','ListModelName','34b90860-9f56-11df-936f-e37ecc873ea2',NULL,1,'Model Name',20,'Text','e8806a9d-9f57-11df-936f-e37ecc873ea2',0,1,1,1,NULL,0,NULL,NULL,NULL,NULL,20,NULL,NULL,NULL,NULL,NULL),('55146a11-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0f48-9f58-11df-936f-e37ecc873ea2','DefineTableColumnTableID','34b8f465-9f56-11df-936f-e37ecc873ea2',NULL,1,'TableID',10,'Text','e8806e17-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,'5514388b-9f56-11df-936f-e37ecc873ea2','Hard',NULL,NULL,NULL,NULL,NULL,NULL),('55146ca7-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0f48-9f58-11df-936f-e37ecc873ea2','ColumnColumnType','34b9378f-9f56-11df-936f-e37ecc873ea2',NULL,1,'Type',100,'Combo','e8806e17-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'new Ext.form.ComboBox({\r\n    lazyRender: true,\r\n    mode: \'local\',\r\n    store: new Ext.data.ArrayStore({\r\n        id: 0,\r\n        fields: [\r\n            \'value\'\r\n        ],\r\n        data: [[\'String\'],[\'UUID\'],[\'CreatedBy\'],[\'CreationDate\'],[\'UpdateDate\'],[\'UpdateProcess\'],[\'UpdatedBy\']]\r\n    }),\r\n	typeAhead: true,\r\n    valueField: \'value\',\r\n    displayField: \'value\'\r\n})\r\n','',NULL),('5514735b-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e12fb-9f58-11df-936f-e37ecc873ea2','JoinName','34dec737-9f56-11df-936f-e37ecc873ea2',NULL,1,'Name',12,'Text','e8806fce-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,NULL),('55147562-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e12fb-9f58-11df-936f-e37ecc873ea2','JoinJoinType','34dec8a4-9f56-11df-936f-e37ecc873ea2',NULL,1,'Type',14,'Text','e8806fce-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55147769-9f56-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-21 23:44:49',NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldFieldID','34b93ec7-9f56-11df-936f-e37ecc873ea2',NULL,1,'FieldID',10,'Text','05d0777b-3c83-11e0-8c47-001c238ae411',0,0,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55147970-9f56-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-21 23:44:50',NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldModelID','34deca1c-9f56-11df-936f-e37ecc873ea2',NULL,0,'ModelID',20,'Text','05d0777b-3c83-11e0-8c47-001c238ae411',100,1,1,0,NULL,0,NULL,NULL,'b2ec8e60-3c80-11e0-8c47-001c238ae411','Hard',NULL,NULL,NULL,NULL,NULL,NULL),('55147b82-9f56-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-21 23:44:50',NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldName','34decb83-9f56-11df-936f-e37ecc873ea2',NULL,1,'Field name',40,'Text','05d0777b-3c83-11e0-8c47-001c238ae411',200,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55147d89-9f56-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-21 23:44:47',NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldBasisColumn','34decd73-9f56-11df-936f-e37ecc873ea2',NULL,1,'BasisColumnID',50,'Text','05d0777b-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('551486f0-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e16ae-9f58-11df-936f-e37ecc873ea2','ViewViewID','34b989eb-9f56-11df-936f-e37ecc873ea2',NULL,1,'ID',10,'Text','e8807c09-9f57-11df-936f-e37ecc873ea2',0,0,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55148947-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e16ae-9f58-11df-936f-e37ecc873ea2','ViewModelID','34df0223-9f56-11df-936f-e37ecc873ea2',NULL,1,'View',10,'Text','e8807c09-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55148ba3-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e1122-9f58-11df-936f-e37ecc873ea2','ListModelBasisTableID','34b90692-9f56-11df-936f-e37ecc873ea2',NULL,1,'BasisTableID',40,'Text','e8806a9d-9f57-11df-936f-e37ecc873ea2',220,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55148da5-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e1122-9f58-11df-936f-e37ecc873ea2','ListModelResultsPerPage','34b902f6-9f56-11df-936f-e37ecc873ea2',NULL,1,'Results per page',100,'Text','e8806a9d-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55148fdf-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e1122-9f58-11df-936f-e37ecc873ea2','ListModelParentID','34b90a28-9f56-11df-936f-e37ecc873ea2',NULL,1,'ParentID',50,'Text','e8806a9d-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,NULL),('551491e6-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e1122-9f58-11df-936f-e37ecc873ea2','ListModelReferenceID','34b90bf6-9f56-11df-936f-e37ecc873ea2',NULL,1,'ReferenceID',60,'Text','e8806a9d-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('551493ed-9f56-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-21 23:44:49',NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldLabel','34ded20a-9f56-11df-936f-e37ecc873ea2',NULL,1,'Field label',80,'Text','05d0777b-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('551495ee-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e16ae-9f58-11df-936f-e37ecc873ea2','RegionLabel','34defdc5-9f56-11df-936f-e37ecc873ea2',NULL,1,'Label',10,NULL,'e8807c09-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('551497f5-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e16ae-9f58-11df-936f-e37ecc873ea2','RegionParent','34deff4f-9f56-11df-936f-e37ecc873ea2',NULL,1,'Parent',10,NULL,'e8807c09-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,NULL),('55149a0d-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e16ae-9f58-11df-936f-e37ecc873ea2','RegionDisplayOrder','34df00b0-9f56-11df-936f-e37ecc873ea2',NULL,1,'Order',10,NULL,'e8807c09-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('55149c1a-9f56-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-21 23:44:51',NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldVisible','34ded064-9f56-11df-936f-e37ecc873ea2',NULL,1,'Visible',70,NULL,'05d0777b-3c83-11e0-8c47-001c238ae411',5,1,1,0,NULL,0,'1',NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,NULL),('55149e32-9f56-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-21 23:44:50',NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldViewID','34ded377-9f56-11df-936f-e37ecc873ea2',NULL,1,'ViewID',60,NULL,'05d0777b-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('639271c3-3e5c-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldReferenceID','34deceec-9f56-11df-936f-e37ecc873ea2',NULL,1,'ReferenceID',55,NULL,'05d0777b-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),('6e9813b6-3e5a-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldSize','34df07d7-9f56-11df-936f-e37ecc873ea2',NULL,1,'Size',85,NULL,'05d0777b-3c83-11e0-8c47-001c238ae411',5,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('7f9cb132-3c9d-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListViewType','c67a2c0c-3c9d-11e0-8705-001c238ae411',NULL,1,'View type',55,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('82968e85-3e57-11e0-8705-001c238ae411',NULL,NULL,'2011-02-21 23:44:48',NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldDisplayOrder','34df0503-9f56-11df-936f-e37ecc873ea2',NULL,1,'Order',75,NULL,'05d0777b-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,NULL),('861f25be-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListCreatedBy','34b98347-9f56-11df-936f-e37ecc873ea2',NULL,0,'CreatedBy',240,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('861f31fe-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListUpdatedBy','34b98492-9f56-11df-936f-e37ecc873ea2',NULL,0,'UpdatedBy',250,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('861f35d3-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListCreationDate','34b985dd-9f56-11df-936f-e37ecc873ea2',NULL,0,'CreationDate',260,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('861f396f-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListUpdateDate','34b9873e-9f56-11df-936f-e37ecc873ea2',NULL,0,'UpdateDate',270,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('861f3cff-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListUpdateProcess','34b98895-9f56-11df-936f-e37ecc873ea2',NULL,0,'UpdateProcess',280,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('861f40d4-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListId','34b989eb-9f56-11df-936f-e37ecc873ea2',NULL,1,'ViewID',10,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('861f496e-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListLabel','34defdc5-9f56-11df-936f-e37ecc873ea2',NULL,1,'Label',50,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('861f4d7c-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListParent','34deff4f-9f56-11df-936f-e37ecc873ea2',NULL,1,'ParentID',40,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('861f50e4-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListDisplayOrder','34df00b0-9f56-11df-936f-e37ecc873ea2',NULL,1,'Order',100,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('861f5436-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListModel','34df0223-9f56-11df-936f-e37ecc873ea2',NULL,1,'ModelID',30,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('861f57cc-2bff-11e0-bae7-001c238ae411',NULL,NULL,'2011-01-29 15:28:48',NULL,NULL,'095e0b79-9f58-11df-936f-e37ecc873ea2','WebpageListName','34df0396-9f56-11df-936f-e37ecc873ea2',NULL,1,'View name',20,NULL,'e8806c5f-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,NULL),('a0208fee-3e59-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldSortDirection','7a80418e-3e59-11e0-8705-001c238ae411',NULL,1,'Sort Direction',100,NULL,'05d0777b-3c83-11e0-8c47-001c238ae411',5,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('a02cd984-3e59-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldSortOrder','7a8857f6-3e59-11e0-8705-001c238ae411',NULL,1,'Sort Order',90,NULL,'05d0777b-3c83-11e0-8c47-001c238ae411',5,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('a8359eb5-3e5a-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldDisplayType','34df066a-9f56-11df-936f-e37ecc873ea2',NULL,1,'Display Type',84,NULL,'05d0777b-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),('af73c337-3e5c-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'459404e9-3d0f-11e0-8705-001c238ae411','DefineTableIndexColumnColumnName','34b8f09b-9f56-11df-936f-e37ecc873ea2','2dbc11c0-3e5c-11e0-8705-001c238ae411',1,'Column Name',40,'String','32ee7a32-3d10-11e0-8705-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),('b2ec8e60-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelModelID','34b8f9e5-9f56-11df-936f-e37ecc873ea2',NULL,1,'ModelID',10,'UUID','88002361-3c7f-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b2ec9497-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelResultsPerPage','34b902f6-9f56-11df-936f-e37ecc873ea2',NULL,1,'Results per page',40,'Integer','88002361-3c7f-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b2ec97dd-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelBasisTableID','34b90692-9f56-11df-936f-e37ecc873ea2',NULL,1,'BasisTableID',30,'String','88002361-3c7f-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b2ec9b07-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelName','34b90860-9f56-11df-936f-e37ecc873ea2',NULL,1,'Model names',20,'String','88002361-3c7f-11e0-8c47-001c238ae411',200,1,1,0,NULL,0,NULL,NULL,NULL,NULL,10,NULL,NULL,NULL,NULL,NULL),('b2ec9e31-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelParentID','34b90a28-9f56-11df-936f-e37ecc873ea2',NULL,1,'ParentID',80,'String','88002361-3c7f-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b2eca188-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelReferenceID','34b90bf6-9f56-11df-936f-e37ecc873ea2',NULL,1,'ReferenceID',90,'String','88002361-3c7f-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b2eca479-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelCreatedBy','34b974b6-9f56-11df-936f-e37ecc873ea2',NULL,0,'CreatedBy',240,'CreatedBy','88002361-3c7f-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b2eca76a-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelUpdatedBy','34b97600-9f56-11df-936f-e37ecc873ea2',NULL,0,'UpdatedBy',250,'UpdatedBy','88002361-3c7f-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b2ecaa4a-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelCreationDate','34b9774b-9f56-11df-936f-e37ecc873ea2',NULL,0,'CreationDate',260,'CreationDate','88002361-3c7f-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b2ecad7f-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelUpdateDate','34b9789c-9f56-11df-936f-e37ecc873ea2',NULL,0,'UpdateDate',270,'UpdateDate','88002361-3c7f-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('b2ecb064-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'54e96e2a-3c7f-11e0-8c47-001c238ae411','DefineModelUpdateProcess','34b979e6-9f56-11df-936f-e37ecc873ea2',NULL,0,'UpdateProcess',280,'UpdateProcess','88002361-3c7f-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ba5efba3-3c51-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'e69acb51-3399-11e0-a9e1-00059a3c7800','DefineTableIndexesTableID','22f06ff8-3c50-11e0-8c47-001c238ae411',NULL,1,'Table ID',20,'String','ebb5eb9f-3bf5-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,'5514388b-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ba5f02a8-3c51-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'e69acb51-3399-11e0-a9e1-00059a3c7800','DefineTableIndexesIndexID','e2e6a5cb-3c4f-11e0-8c47-001c238ae411',NULL,1,'Index ID',10,'UUID','ebb5eb9f-3bf5-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ba5f05ee-3c51-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'e69acb51-3399-11e0-a9e1-00059a3c7800','DefineTableIndexesUniqueIndex','fce937aa-9f57-11df-936f-e37ecc873ea2',NULL,1,'Unique',30,'String','ebb5eb9f-3bf5-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('dc9aa75d-3ef9-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','DefineModelFieldSelectorID','b2ad109d-3ef9-11e0-8705-001c238ae411',NULL,1,'SelectorID',210,NULL,'05d0777b-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),('e6baa872-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelModelID','34b8f9e5-9f56-11df-936f-e37ecc873ea2',NULL,1,'ModelID',10,'UUID','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6baae70-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelResultsPerPage','34b902f6-9f56-11df-936f-e37ecc873ea2',NULL,1,'Results per page',30,'Integer','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bab1e4-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelBasisTableID','34b90692-9f56-11df-936f-e37ecc873ea2',NULL,1,'BasisTableID',60,'String','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bac282-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelName','34b90860-9f56-11df-936f-e37ecc873ea2',NULL,1,'Name',70,'String','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bac5a6-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelParentID','34b90a28-9f56-11df-936f-e37ecc873ea2',NULL,1,'ParentID',80,'String','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,'b2ec8e60-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bac8e1-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelReferenceID','34b90bf6-9f56-11df-936f-e37ecc873ea2',NULL,1,'ReferenceID',90,'String','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bacb93-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelCreatedBy','34b974b6-9f56-11df-936f-e37ecc873ea2',NULL,0,'CreatedBy',240,'CreatedBy','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bace3f-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelUpdatedBy','34b97600-9f56-11df-936f-e37ecc873ea2',NULL,0,'UpdatedBy',250,'UpdatedBy','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bad0ec-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelCreationDate','34b9774b-9f56-11df-936f-e37ecc873ea2',NULL,0,'CreationDate',260,'CreationDate','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bad3af-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelUpdateDate','34b9789c-9f56-11df-936f-e37ecc873ea2',NULL,0,'UpdateDate',270,'UpdateDate','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6badbb4-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','DefineModelModelUpdateProcess','34b979e6-9f56-11df-936f-e37ecc873ea2',NULL,0,'UpdateProcess',280,'UpdateProcess','b7bc1542-3399-11e0-a9e1-00059a3c7800',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bb0c82-3e12-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','DefineModelReferenceCreatedBy','34b98b41-9f56-11df-936f-e37ecc873ea2',NULL,0,NULL,240,'CreatedBy','0df07b20-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bb13bf-3e12-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','DefineModelReferenceUpdatedBy','34b9a5e6-9f56-11df-936f-e37ecc873ea2',NULL,0,NULL,250,'UpdatedBy','0df07b20-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bb1767-3e12-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','DefineModelReferenceCreationDate','34b9a747-9f56-11df-936f-e37ecc873ea2',NULL,0,NULL,260,'CreationDate','0df07b20-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bb1aa2-3e12-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','DefineModelReferenceUpdateDate','34b9a8a3-9f56-11df-936f-e37ecc873ea2',NULL,0,NULL,270,'UpdateDate','0df07b20-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bb1dff-3e12-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','DefineModelReferenceUpdateProcess','34b9a9f9-9f56-11df-936f-e37ecc873ea2',NULL,0,NULL,280,'UpdateProcess','0df07b20-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bb2162-3e12-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','DefineModelReferenceReferenceID','34be5a72-9f56-11df-936f-e37ecc873ea2',NULL,1,'ReferenceID',10,'UUID','0df07b20-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bb24a8-3e12-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','DefineModelReferenceName','b1ba80e2-3dda-11e0-8705-001c238ae411',NULL,1,'Reference name',50,'String','0df07b20-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bb2782-3e12-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','DefineModelReferenceParentID','b1c439e5-3dda-11e0-8705-001c238ae411',NULL,1,'ParentID',40,'String','0df07b20-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bb2a73-3e12-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','DefineModelReferenceJoinID','b1c7a0cc-3dda-11e0-8705-001c238ae411',NULL,1,'JoinID',30,'String','0df07b20-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e6bb2d69-3e12-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','DefineModelReferenceModelID','db825fa1-3dd9-11e0-8705-001c238ae411',NULL,1,'ModelID',20,'String','0df07b20-3c83-11e0-8c47-001c238ae411',0,1,1,0,NULL,0,NULL,NULL,'b2ec8e60-3c80-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,NULL,NULL),('e7a520e6-2c12-11e0-bae7-001c238ae411',NULL,NULL,NULL,NULL,NULL,'095e0f48-9f58-11df-936f-e37ecc873ea2','ColumnLabel','34b93cf3-9f56-11df-936f-e37ecc873ea2',NULL,1,'Label',45,'Text','e8806e17-9f57-11df-936f-e37ecc873ea2',0,1,1,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `tan_field_action` */

DROP TABLE IF EXISTS `tan_field_action`;

CREATE TABLE `tan_field_action` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `fieldID` char(36) DEFAULT NULL,
  `defaultAction` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tableName` (`name`,`fieldID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_field_action` */

insert  into `tan_field_action`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`name`,`label`,`fieldID`,`defaultAction`) values ('5ba14a0d-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'DefineTable','DefineTable','551431ba-9f56-11df-936f-e37ecc873ea2',0),('5ba14e54-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'DefineTable','DefineTable','55146329-9f56-11df-936f-e37ecc873ea2',0);

/*Table structure for table `tan_field_action_detail` */

DROP TABLE IF EXISTS `tan_field_action_detail`;

CREATE TABLE `tan_field_action_detail` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `fieldID` char(36) DEFAULT NULL,
  `fieldActionID` char(36) DEFAULT NULL,
  `fromFieldID` char(36) DEFAULT NULL,
  `toFieldID` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_field_action_detail` */

insert  into `tan_field_action_detail`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`fieldID`,`fieldActionID`,`fromFieldID`,`toFieldID`) values ('31d533af-3f09-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1ea44dde-2911-11e0-b23a-001c238ae411',NULL,'551431ba-9f56-11df-936f-e37ecc873ea2','1ea44dde-2911-11e0-b23a-001c238ae411'),('4b39adcf-3f09-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1ea44dde-2911-11e0-b23a-001c238ae411',NULL,'55142ce5-9f56-11df-936f-e37ecc873ea2','55148ba3-9f56-11df-936f-e37ecc873ea2'),('61eae37b-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'55142ce5-9f56-11df-936f-e37ecc873ea2','5ba14a0d-9f56-11df-936f-e37ecc873ea2','55142ce5-9f56-11df-936f-e37ecc873ea2','5514388b-9f56-11df-936f-e37ecc873ea2'),('61eae806-9f56-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'551460de-9f56-11df-936f-e37ecc873ea2','5ba14e54-9f56-11df-936f-e37ecc873ea2','551460de-9f56-11df-936f-e37ecc873ea2','5514388b-9f56-11df-936f-e37ecc873ea2');

/*Table structure for table `tan_index` */

DROP TABLE IF EXISTS `tan_index`;

CREATE TABLE `tan_index` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `tableID` char(36) DEFAULT NULL,
  `displayOrder` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `uniqueIndex` tinyint(4) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `tableID` (`displayOrder`),
  KEY `FK_tan_index` (`tableID`),
  CONSTRAINT `FK_tan_index` FOREIGN KEY (`tableID`) REFERENCES `tan_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_index` */

insert  into `tan_index`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`tableID`,`displayOrder`,`uniqueIndex`) values ('0936dc51-3c9d-11e0-8705-001c238ae411',NULL,NULL,'2011-02-19 18:56:50',NULL,NULL,'fce93af0-9f57-11df-936f-e37ecc873ea2',1,1),('7c145395-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce920bd-9f57-11df-936f-e37ecc873ea2',1,1),('7c145675-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce924a9-9f57-11df-936f-e37ecc873ea2',1,1),('7c145815-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92677-9f57-11df-936f-e37ecc873ea2',1,1),('7c145b2e-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce929b7-9f57-11df-936f-e37ecc873ea2',1,1),('7c145cb7-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce92fa4-9f57-11df-936f-e37ecc873ea2',1,1),('7c145e3b-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce93150-9f57-11df-936f-e37ecc873ea2',1,1),('7c145fc5-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'fce932f6-9f57-11df-936f-e37ecc873ea2',1,1),('8fd7b023-3c50-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce937aa-9f57-11df-936f-e37ecc873ea2',1,1),('930c5abb-3c86-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce93615-9f57-11df-936f-e37ecc873ea2',1,1),('d9a25cdf-3e5b-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fce9394a-9f57-11df-936f-e37ecc873ea2',1,1);

/*Table structure for table `tan_index_column` */

DROP TABLE IF EXISTS `tan_index_column`;

CREATE TABLE `tan_index_column` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `indexID` char(36) NOT NULL,
  `columnID` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `indexColumn` (`indexID`,`columnID`),
  KEY `FK_tan_index_column_column` (`columnID`),
  CONSTRAINT `FK_tan_index_column` FOREIGN KEY (`indexID`) REFERENCES `tan_index` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tan_index_column_column` FOREIGN KEY (`columnID`) REFERENCES `tan_column` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_index_column` */

insert  into `tan_index_column`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`indexID`,`columnID`) values ('22de8fe9-3c9d-11e0-8705-001c238ae411',NULL,NULL,'2011-02-19 18:57:34',NULL,NULL,'0936dc51-3c9d-11e0-8705-001c238ae411','34debe14-9f56-11df-936f-e37ecc873ea2'),('65df4dba-9f32-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-01 00:00:00',NULL,NULL,'7c145395-9f57-11df-936f-e37ecc873ea2','34b8e1dc-9f56-11df-936f-e37ecc873ea2'),('65df5055-9f32-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-01 00:00:00',NULL,NULL,'7c145675-9f57-11df-936f-e37ecc873ea2','34b8f27a-9f56-11df-936f-e37ecc873ea2'),('65df51ea-9f32-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-01 00:00:00',NULL,NULL,'7c145815-9f57-11df-936f-e37ecc873ea2','34b8fd81-9f56-11df-936f-e37ecc873ea2'),('65df54ec-9f32-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-01 00:00:00',NULL,NULL,'7c145b2e-9f57-11df-936f-e37ecc873ea2','34b93ec7-9f56-11df-936f-e37ecc873ea2'),('65df566a-9f32-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-01 00:00:00',NULL,NULL,'7c145cb7-9f57-11df-936f-e37ecc873ea2','34b8f9e5-9f56-11df-936f-e37ecc873ea2'),('9df872a7-3c50-11e0-8c47-001c238ae411',NULL,NULL,'2011-02-01 00:00:00',NULL,NULL,'8fd7b023-3c50-11e0-8c47-001c238ae411','e2e6a5cb-3c4f-11e0-8c47-001c238ae411'),('d7108b2c-3c86-11e0-8c47-001c238ae411',NULL,NULL,'2011-02-01 00:00:00',NULL,NULL,'930c5abb-3c86-11e0-8c47-001c238ae411','34be5a72-9f56-11df-936f-e37ecc873ea2'),('e3020200-3e5b-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'d9a25cdf-3e5b-11e0-8705-001c238ae411','1c981a94-3c64-11e0-8c47-001c238ae411');

/*Table structure for table `tan_join` */

DROP TABLE IF EXISTS `tan_join`;

CREATE TABLE `tan_join` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `joinType` char(2) NOT NULL,
  `fromTableID` char(36) DEFAULT NULL,
  `toTableID` char(36) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fromTable` (`fromTableID`,`name`),
  KEY `toTable` (`toTableID`),
  CONSTRAINT `FK_tan_join_from` FOREIGN KEY (`fromTableID`) REFERENCES `tan_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_tan_join_to` FOREIGN KEY (`toTableID`) REFERENCES `tan_table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_join` */

insert  into `tan_join`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`joinType`,`fromTableID`,`toTableID`,`name`) values ('521d6fc2-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'0','fce92fa4-9f57-11df-936f-e37ecc873ea2','fce92fa4-9f57-11df-936f-e37ecc873ea2','ParentModel'),('6a26db53-786f-4e76-9bd4-c0634592aba7',NULL,NULL,NULL,NULL,NULL,'0','fce93485-9f57-11df-936f-e37ecc873ea2','fce92fa4-9f57-11df-936f-e37ecc873ea2','ViewToModel'),('6a81b1ff-3d7b-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'0','fce929b7-9f57-11df-936f-e37ecc873ea2','fce93485-9f57-11df-936f-e37ecc873ea2','View'),('6efebce1-3d7c-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'0','fce929b7-9f57-11df-936f-e37ecc873ea2','fce93615-9f57-11df-936f-e37ecc873ea2','Reference'),('7e953926-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'0','fce92fa4-9f57-11df-936f-e37ecc873ea2','fce93615-9f57-11df-936f-e37ecc873ea2','Reference'),('80a8d90e-3c86-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'0','fce93615-9f57-11df-936f-e37ecc873ea2','fce92fa4-9f57-11df-936f-e37ecc873ea2','Model'),('8db38e11-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'0','fce924a9-9f57-11df-936f-e37ecc873ea2','fce920bd-9f57-11df-936f-e37ecc873ea2','Table'),('8db390c3-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'0','fce92677-9f57-11df-936f-e37ecc873ea2','fce920bd-9f57-11df-936f-e37ecc873ea2','FromTable'),('8db39414-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'0','fce929b7-9f57-11df-936f-e37ecc873ea2','fce92fa4-9f57-11df-936f-e37ecc873ea2','Model'),('8db395af-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'0','fce92677-9f57-11df-936f-e37ecc873ea2','fce920bd-9f57-11df-936f-e37ecc873ea2','ToTable'),('8db39744-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'0','fce93af0-9f57-11df-936f-e37ecc873ea2','fce92677-9f57-11df-936f-e37ecc873ea2','Join'),('8db398d3-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'0','fce929b7-9f57-11df-936f-e37ecc873ea2','fce924a9-9f57-11df-936f-e37ecc873ea2','BasisColumn'),('8db39bfd-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'0','fce93485-9f57-11df-936f-e37ecc873ea2','fce92fa4-9f57-11df-936f-e37ecc873ea2','View'),('aa5e402a-3d41-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'0','fce9394a-9f57-11df-936f-e37ecc873ea2','fce937aa-9f57-11df-936f-e37ecc873ea2','Index'),('b02a319d-3e5b-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'0','fce9394a-9f57-11df-936f-e37ecc873ea2','fce924a9-9f57-11df-936f-e37ecc873ea2','Column'),('dd273887-2909-11e0-b23a-001c238ae411',NULL,NULL,NULL,NULL,NULL,'0','fce92fa4-9f57-11df-936f-e37ecc873ea2','fce920bd-9f57-11df-936f-e37ecc873ea2','BasisTable'),('e41d5a36-3df3-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'0','fce93615-9f57-11df-936f-e37ecc873ea2','fce92677-9f57-11df-936f-e37ecc873ea2','Join'),('ef22396f-3c50-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'0','fce937aa-9f57-11df-936f-e37ecc873ea2','fce920bd-9f57-11df-936f-e37ecc873ea2','Table');

/*Table structure for table `tan_join_column` */

DROP TABLE IF EXISTS `tan_join_column`;

CREATE TABLE `tan_join_column` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `joinID` char(36) DEFAULT NULL,
  `fromColumnID` char(36) DEFAULT NULL,
  `fromText` varchar(50) DEFAULT NULL,
  `toColumnID` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_join_column` */

insert  into `tan_join_column`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`joinID`,`fromColumnID`,`fromText`,`toColumnID`) values ('09f1906b-3d89-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'6efebce1-3d7c-11e0-8705-001c238ae411','34deceec-9f56-11df-936f-e37ecc873ea2',NULL,'34be5a72-9f56-11df-936f-e37ecc873ea2'),('19ce0921-3c51-11e0-8c47-001c238ae411',NULL,NULL,'2011-02-19 00:00:00',NULL,NULL,'ef22396f-3c50-11e0-8c47-001c238ae411','22f06ff8-3c50-11e0-8c47-001c238ae411',NULL,'34b8e1dc-9f56-11df-936f-e37ecc873ea2'),('62fd7c8b-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'521d6fc2-3e14-11e0-8705-001c238ae411','34b90a28-9f56-11df-936f-e37ecc873ea2',NULL,'34b8f9e5-9f56-11df-936f-e37ecc873ea2'),('8220be6d-9f31-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-19 00:00:00',NULL,NULL,'8db38e11-9f57-11df-936f-e37ecc873ea2','34b8f465-9f56-11df-936f-e37ecc873ea2',NULL,'34b8e1dc-9f56-11df-936f-e37ecc873ea2'),('8220bfeb-9f31-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-19 00:00:00',NULL,NULL,'8db390c3-9f57-11df-936f-e37ecc873ea2','34b8ff5a-9f56-11df-936f-e37ecc873ea2',NULL,'34b8e1dc-9f56-11df-936f-e37ecc873ea2'),('8220c0e0-9f31-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-19 00:00:00',NULL,NULL,'8db3927f-9f57-11df-936f-e37ecc873ea2','34b8fbb3-9f56-11df-936f-e37ecc873ea2',NULL,'34b8eab4-9f56-11df-936f-e37ecc873ea2'),('8220c180-9f31-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-19 00:00:00',NULL,NULL,'8db39414-9f57-11df-936f-e37ecc873ea2','34deca1c-9f56-11df-936f-e37ecc873ea2',NULL,'34b8f9e5-9f56-11df-936f-e37ecc873ea2'),('8220c214-9f31-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-19 00:00:00',NULL,NULL,'8db395af-9f57-11df-936f-e37ecc873ea2','34b90128-9f56-11df-936f-e37ecc873ea2',NULL,'34b8e1dc-9f56-11df-936f-e37ecc873ea2'),('8220c2a9-9f31-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-19 00:00:00',NULL,NULL,'8db39a68-9f57-11df-936f-e37ecc873ea2','34deed6b-9f56-11df-936f-e37ecc873ea2',NULL,'34b8eab4-9f56-11df-936f-e37ecc873ea2'),('8220c33d-9f31-11df-936f-e37ecc873ea2',NULL,NULL,'2011-02-19 00:00:00',NULL,NULL,'8db39bfd-9f57-11df-936f-e37ecc873ea2','34df0223-9f56-11df-936f-e37ecc873ea2',NULL,'34b8f9e5-9f56-11df-936f-e37ecc873ea2'),('9676be8e-290a-11e0-b23a-001c238ae411',NULL,NULL,'2011-02-19 00:00:00',NULL,NULL,'dd273887-2909-11e0-b23a-001c238ae411','34b90692-9f56-11df-936f-e37ecc873ea2',NULL,'34b8e1dc-9f56-11df-936f-e37ecc873ea2'),('97db9f2f-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'7e953926-3e14-11e0-8705-001c238ae411','34b90bf6-9f56-11df-936f-e37ecc873ea2',NULL,'34be5a72-9f56-11df-936f-e37ecc873ea2'),('b70b30d4-3df7-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'e41d5a36-3df3-11e0-8705-001c238ae411','b1c7a0cc-3dda-11e0-8705-001c238ae411',NULL,'34b8fd81-9f56-11df-936f-e37ecc873ea2'),('bfe5cb71-3e5b-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'b02a319d-3e5b-11e0-8705-001c238ae411','2cc151a7-3c64-11e0-8c47-001c238ae411',NULL,'34b8f27a-9f56-11df-936f-e37ecc873ea2'),('e443c0eb-3d7b-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'8db398d3-9f57-11df-936f-e37ecc873ea2','34decd73-9f56-11df-936f-e37ecc873ea2',NULL,'34b8f27a-9f56-11df-936f-e37ecc873ea2'),('eb27c888-3dda-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'80a8d90e-3c86-11e0-8c47-001c238ae411','db825fa1-3dd9-11e0-8705-001c238ae411',NULL,'34b8f9e5-9f56-11df-936f-e37ecc873ea2'),('f5078749-3d12-11e0-8705-001c238ae411',NULL,NULL,'2011-02-19 00:00:00',NULL,NULL,'8db39744-9f57-11df-936f-e37ecc873ea2','34debf98-9f56-11df-936f-e37ecc873ea2',NULL,'34b8fd81-9f56-11df-936f-e37ecc873ea2'),('fd0f0856-3d41-11e0-8705-001c238ae411',NULL,NULL,'2011-02-20 14:33:53',NULL,NULL,'aa5e402a-3d41-11e0-8705-001c238ae411','1c8e5729-3c64-11e0-8c47-001c238ae411',NULL,'e2e6a5cb-3c4f-11e0-8c47-001c238ae411'),('fdd89a96-3d7b-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'6a81b1ff-3d7b-11e0-8705-001c238ae411','34ded377-9f56-11df-936f-e37ecc873ea2',NULL,'34b989eb-9f56-11df-936f-e37ecc873ea2');

/*Table structure for table `tan_logging` */

DROP TABLE IF EXISTS `tan_logging`;

CREATE TABLE `tan_logging` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `scope` varchar(255) NOT NULL,
  `logType` varchar(10) NOT NULL,
  `logTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tan_logging` */

/*Table structure for table `tan_menu` */

DROP TABLE IF EXISTS `tan_menu`;

CREATE TABLE `tan_menu` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `databaseID` char(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_menu` */

/*Table structure for table `tan_model` */

DROP TABLE IF EXISTS `tan_model`;

CREATE TABLE `tan_model` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `resultsPerPage` smallint(6) NOT NULL DEFAULT '0',
  `basisTableID` char(36) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `parentID` char(36) DEFAULT NULL,
  `referenceID` char(36) DEFAULT NULL,
  `queryOrder` smallint(6) NOT NULL DEFAULT '0',
  `label` varchar(100) DEFAULT NULL,
  `allowAdd` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `allowEdit` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `allowDelete` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `condition` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pageName` (`name`),
  KEY `FK_tan_model_table` (`basisTableID`),
  KEY `FK_tan_model_reference` (`referenceID`),
  CONSTRAINT `FK_tan_model_reference` FOREIGN KEY (`referenceID`) REFERENCES `tan_reference` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_tan_model_table` FOREIGN KEY (`basisTableID`) REFERENCES `tan_table` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_model` */

insert  into `tan_model`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`resultsPerPage`,`basisTableID`,`name`,`parentID`,`referenceID`,`queryOrder`,`label`,`allowAdd`,`allowEdit`,`allowDelete`,`condition`) values ('095e0687-9f58-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,100,'fce920bd-9f57-11df-936f-e37ecc873ea2','ManageTables',NULL,NULL,0,'Manage Tables',1,1,0,NULL),('095e0978-9f58-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,10,'fce920bd-9f57-11df-936f-e37ecc873ea2','DefineTable',NULL,NULL,0,'Define Table',1,1,1,NULL),('095e0b79-9f58-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,100,'fce93485-9f57-11df-936f-e37ecc873ea2','WebpageList',NULL,NULL,0,'List Webpages',1,0,0,NULL),('095e0f48-9f58-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,0,'fce924a9-9f57-11df-936f-e37ecc873ea2','DefineTableColumn','095e0978-9f58-11df-936f-e37ecc873ea2','e325875d-9f57-11df-936f-e37ecc873ea2',0,NULL,1,1,1,NULL),('095e1122-9f58-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,0,'fce92fa4-9f57-11df-936f-e37ecc873ea2','ListModels',NULL,NULL,0,'Define Webpage',1,1,1,'ListModelParentID IS NULL'),('095e12fb-9f58-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,0,'fce92677-9f57-11df-936f-e37ecc873ea2','DefineTableJoinParent','095e0978-9f58-11df-936f-e37ecc873ea2','e3258cbc-9f57-11df-936f-e37ecc873ea2',0,NULL,1,1,1,NULL),('095e14d4-9f58-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,0,'fce929b7-9f57-11df-936f-e37ecc873ea2','DefineModelField','54e96e2a-3c7f-11e0-8c47-001c238ae411','e3258e29-9f57-11df-936f-e37ecc873ea2',0,NULL,1,1,1,NULL),('095e16ae-9f58-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,0,'fce93485-9f57-11df-936f-e37ecc873ea2','Views','WAS095e1122-9f58-11df-936f-e37ecc873','e3258f9b-9f57-11df-936f-e37ecc873ea2',0,NULL,1,1,1,NULL),('1588be02-3d0f-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,0,'fce93af0-9f57-11df-936f-e37ecc873ea2','DefineTableJoinParentColumns','095e12fb-9f58-11df-936f-e37ecc873ea2','8ede4520-3d0f-11e0-8705-001c238ae411',0,NULL,1,1,1,NULL),('2c35f8ba-3c86-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,0,'fce93615-9f57-11df-936f-e37ecc873ea2','DefineModelReference','54e96e2a-3c7f-11e0-8c47-001c238ae411','a14d4a5a-3dd9-11e0-8705-001c238ae411',0,NULL,1,1,1,NULL),('459404e9-3d0f-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,0,'fce9394a-9f57-11df-936f-e37ecc873ea2','DefineTableIndexColumn','e69acb51-3399-11e0-a9e1-00059a3c7800','d9d3034b-3d0f-11e0-8705-001c238ae411',0,NULL,1,1,1,NULL),('54e96e2a-3c7f-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,0,'fce92fa4-9f57-11df-936f-e37ecc873ea2','DefineModel',NULL,NULL,0,NULL,1,1,1,NULL),('596f118f-339a-11e0-a9e1-00059a3c7800',NULL,NULL,NULL,NULL,NULL,10,'fce93485-9f57-11df-936f-e37ecc873ea2','DefineWebPages',NULL,NULL,0,NULL,1,1,1,NULL),('e69acb51-3399-11e0-a9e1-00059a3c7800',NULL,NULL,NULL,NULL,NULL,0,'fce937aa-9f57-11df-936f-e37ecc873ea2','DefineTableIndex','095e0978-9f58-11df-936f-e37ecc873ea2','eda16078-3c51-11e0-8c47-001c238ae411',0,NULL,1,1,1,NULL),('fe0e7ad3-3399-11e0-a9e1-00059a3c7800',NULL,NULL,NULL,NULL,NULL,0,'fce92fa4-9f57-11df-936f-e37ecc873ea2','DefineModelModels','54e96e2a-3c7f-11e0-8c47-001c238ae411','b69402eb-3e14-11e0-8705-001c238ae411',0,'Child Models',1,1,1,NULL);

/*Table structure for table `tan_project` */

DROP TABLE IF EXISTS `tan_project`;

CREATE TABLE `tan_project` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `userTableID` char(36) DEFAULT NULL,
  `usernameColumnID` char(36) DEFAULT NULL,
  `passwordColumnID` char(36) DEFAULT NULL,
  `projectCode` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_project` */

insert  into `tan_project`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`name`,`userTableID`,`usernameColumnID`,`passwordColumnID`,`projectCode`) values ('cb2782a4-3c84-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'PICS',NULL,NULL,NULL,'pics'),('d91b225e-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Tantalum Builder','fce932f6-9f57-11df-936f-e37ecc873ea2',NULL,NULL,'tb'),('d91b2527-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Northwind Demo',NULL,NULL,NULL,'mw');

/*Table structure for table `tan_reference` */

DROP TABLE IF EXISTS `tan_reference`;

CREATE TABLE `tan_reference` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `modelID` char(36) NOT NULL,
  `joinID` char(36) NOT NULL,
  `parentID` char(36) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_reference` */

insert  into `tan_reference`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`modelID`,`joinID`,`parentID`,`name`) values ('1cf68a98-2909-11e0-b23a-001c238ae411',NULL,NULL,NULL,NULL,NULL,'095e1122-9f58-11df-936f-e37ecc873ea2','dd273887-2909-11e0-b23a-001c238ae411',NULL,'ModelToBasisTable'),('2dbc11c0-3e5c-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'459404e9-3d0f-11e0-8705-001c238ae411','b02a319d-3e5b-11e0-8705-001c238ae411',NULL,'IndexColumnToColumn'),('8ede4520-3d0f-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'1588be02-3d0f-11e0-8705-001c238ae411','8db39744-9f57-11df-936f-e37ecc873ea2',NULL,'JoinColumnsToJoin'),('a14d4a5a-3dd9-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'2c35f8ba-3c86-11e0-8c47-001c238ae411','80a8d90e-3c86-11e0-8c47-001c238ae411',NULL,'ReferenceToModel'),('b69402eb-3e14-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'fe0e7ad3-3399-11e0-a9e1-00059a3c7800','521d6fc2-3e14-11e0-8705-001c238ae411',NULL,'ModelToParent'),('d9d3034b-3d0f-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'459404e9-3d0f-11e0-8705-001c238ae411','aa5e402a-3d41-11e0-8705-001c238ae411',NULL,'IndexColumnToIndex'),('e325875d-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e0f48-9f58-11df-936f-e37ecc873ea2','8db38e11-9f57-11df-936f-e37ecc873ea2',NULL,'ColumnToTable'),('e3258b49-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e12fb-9f58-11df-936f-e37ecc873ea2','8db395af-9f57-11df-936f-e37ecc873ea2',NULL,'JoinToParentTable'),('e3258cbc-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e12fb-9f58-11df-936f-e37ecc873ea2','8db390c3-9f57-11df-936f-e37ecc873ea2',NULL,'JoinToChildTable'),('e3258e29-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e14d4-9f58-11df-936f-e37ecc873ea2','8db39414-9f57-11df-936f-e37ecc873ea2',NULL,'FieldToModel'),('e3258f9b-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'095e16ae-9f58-11df-936f-e37ecc873ea2','8db39bfd-9f57-11df-936f-e37ecc873ea2',NULL,'ViewToModel'),('eda16078-3c51-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'e69acb51-3399-11e0-a9e1-00059a3c7800','ef22396f-3c50-11e0-8c47-001c238ae411',NULL,'IndexToTable');

/*Table structure for table `tan_table` */

DROP TABLE IF EXISTS `tan_table`;

CREATE TABLE `tan_table` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `dbName` varchar(50) NOT NULL,
  `projectID` char(36) DEFAULT NULL,
  `databaseID` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`projectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_table` */

insert  into `tan_table`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`name`,`dbName`,`projectID`,`databaseID`) values ('fce920bd-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Table','tan_table','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce924a9-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Column','tan_column','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce92677-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Join','tan_join','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce929b7-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Field','tan_field','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce92fa4-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Model','tan_model','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce93150-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Enum','tan_enum','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce932f6-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'User','tan_user','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce93485-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'View','tan_view','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce93615-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Reference','tan_reference','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce937aa-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Index','tan_index','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce9394a-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'IndexColumn','tan_index_column','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2'),('fce93af0-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'JoinColumn','tan_join_column','d91b225e-9f57-11df-936f-e37ecc873ea2','4fb1a314-9f56-11df-936f-e37ecc873ea2');

/*Table structure for table `tan_user` */

DROP TABLE IF EXISTS `tan_user`;

CREATE TABLE `tan_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `tan_user` */

insert  into `tan_user`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`username`,`password`) values (1,NULL,NULL,NULL,NULL,NULL,'tallred',NULL);

/*Table structure for table `tan_view` */

DROP TABLE IF EXISTS `tan_view`;

CREATE TABLE `tan_view` (
  `id` char(36) NOT NULL,
  `createdBy` int(11) unsigned DEFAULT NULL,
  `updatedBy` int(11) unsigned DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `updateProcess` varchar(100) DEFAULT NULL,
  `viewType` varchar(50) DEFAULT NULL,
  `modelID` char(36) DEFAULT NULL,
  `parentID` char(36) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL,
  `displayOrder` int(11) DEFAULT '10',
  PRIMARY KEY (`id`),
  KEY `FK_tan_view` (`modelID`),
  CONSTRAINT `FK_tan_view` FOREIGN KEY (`modelID`) REFERENCES `tan_model` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tan_view` */

insert  into `tan_view`(`id`,`createdBy`,`updatedBy`,`creationDate`,`updateDate`,`updateProcess`,`viewType`,`modelID`,`parentID`,`name`,`label`,`displayOrder`) values ('05d0777b-3c83-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'Grid','095e14d4-9f58-11df-936f-e37ecc873ea2','5f9a65ea-3c83-11e0-8c47-001c238ae411','DefineModelField','Field',20),('0df07b20-3c83-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'Grid','2c35f8ba-3c86-11e0-8c47-001c238ae411','5f9a65ea-3c83-11e0-8c47-001c238ae411','DefineModelReference','Reference',30),('32ee7a32-3d10-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'Grid','459404e9-3d0f-11e0-8705-001c238ae411','3a9418f5-3dd7-11e0-8705-001c238ae411','DefineTableIndexColumn','Index Columns',20),('3a9418f5-3dd7-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'Container',NULL,'aedf4d33-379f-11e0-86aa-001c238ae411','DefineTableIndexContainer','Indexes',30),('5f9a65ea-3c83-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'Tabs',NULL,'88002361-3c7f-11e0-8c47-001c238ae411','DefineModelChildren','Data',10),('88002361-3c7f-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'Grid','54e96e2a-3c7f-11e0-8c47-001c238ae411',NULL,'DefineModel','Define Model',10),('aedf4d33-379f-11e0-86aa-001c238ae411',NULL,NULL,NULL,NULL,NULL,'Tabs',NULL,'e88068d5-9f57-11df-936f-e37ecc873ea2','DefineTableTabs','Tabs',10),('b7bc1542-3399-11e0-a9e1-00059a3c7800',NULL,NULL,NULL,NULL,NULL,'Grid','fe0e7ad3-3399-11e0-a9e1-00059a3c7800','5f9a65ea-3c83-11e0-8c47-001c238ae411','DefineModelModel','Children Models',10),('be373ebd-3d10-11e0-8705-001c238ae411',NULL,NULL,NULL,NULL,NULL,'Grid','1588be02-3d0f-11e0-8705-001c238ae411','e880753d-9f57-11df-936f-e37ecc873ea2','DefineTableJoinColumn','Join Columns',20),('ca272d48-339a-11e0-a9e1-00059a3c7800',NULL,NULL,NULL,NULL,NULL,'Form',NULL,NULL,'DefinePages','Define Pages',1),('e88065f5-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Grid','095e0687-9f58-11df-936f-e37ecc873ea2',NULL,'ListTables','List Tables',1),('e88068d5-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Form','095e0978-9f58-11df-936f-e37ecc873ea2',NULL,'DefineTable','Define Table',10),('e8806a9d-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Grid','095e1122-9f58-11df-936f-e37ecc873ea2',NULL,'ListModels','List Models',10),('e8806c5f-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Grid','095e0b79-9f58-11df-936f-e37ecc873ea2',NULL,'Page','List Pages',10),('e8806e17-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Grid','095e0f48-9f58-11df-936f-e37ecc873ea2','aedf4d33-379f-11e0-86aa-001c238ae411','DefineTableColumns','Columns',10),('e8806fce-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Grid','095e12fb-9f58-11df-936f-e37ecc873ea2','e880753d-9f57-11df-936f-e37ecc873ea2','DefineTableJoin','Joins',10),('e880737b-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Container',NULL,NULL,'ManageTables','ManageTables',10),('e880753d-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Container',NULL,'aedf4d33-379f-11e0-86aa-001c238ae411','DefineTableJoinContainer','Joins',20),('e88076f4-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Form','095e1122-9f58-11df-936f-e37ecc873ea2','e880789a-9f57-11df-936f-e37ecc873ea2','Models','Model',10),('e880789a-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Container',NULL,NULL,'Top','Top',10),('e8807a52-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Grid','095e14d4-9f58-11df-936f-e37ecc873ea2','e88076f4-9f57-11df-936f-e37ecc873ea2','Fields','Fields',20),('e8807c09-9f57-11df-936f-e37ecc873ea2',NULL,NULL,NULL,NULL,NULL,'Grid','095e16ae-9f58-11df-936f-e37ecc873ea2','e88076f4-9f57-11df-936f-e37ecc873ea2','Views','Views',30),('ebb5eb9f-3bf5-11e0-8c47-001c238ae411',NULL,NULL,NULL,NULL,NULL,'Grid','e69acb51-3399-11e0-a9e1-00059a3c7800','3a9418f5-3dd7-11e0-8705-001c238ae411','DefineTableIndex','Indexes',10);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;