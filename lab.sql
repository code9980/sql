--lab.sql
--Lab Set Up:

--Lab Setup for Basic/Advanced SQL Exercises:
--Sample database: Employee Management System
=============================================

---------------------------------------
--All rights reserved. GPL-GNU licence.
--No responsibility will be taken by the author for any issues that may be caused by any code in this file.
-------------------------------------
--TO BE EXECUTED IN SSMS (NOT ONLINE LAB-WEBSITES):

--Check SQL Server details (name/version):
print @@servername  --OR select SERVERPROPERTY('ServerName')		-- host-server & named-instance name.
print @@version
print system_user

-------------------------------------
--Do NOT run following database creation without updating the File-Paths first.
--(Alterntively, in SSMS create database using GUI (Right click "Databases" -> "New Database")
CREATE DATABASE [EmpDb]
 ON  PRIMARY ( NAME = N'EmpDb', FILENAME = N'C:\temp\EmpDb.mdf')
 LOG ON ( NAME = N'EmpDb_log', FILENAME = N'C:\temp\EmpDb_log.ldf' )
-------------------------------------

--DB state:
SELECT database_id, name, state_desc [DB_State], recovery_model_desc, user_access_desc, collation_name, compatibility_level FROM sys.databases WHERE name = 'EmpDb'
--Change Recovery Model:
ALTER DATABASE [EmpDb] SET RECOVERY SIMPLE 
GO

USE EmpDb
GO

print db_name()  --View database-name in use.
--------------------------------


--SAMPLE TABLES CREATION WITH DATA:
-----------------------------------

--Create emp table:
create table emp (
	eid	int 	 NOT NULL PRIMARY KEY,
	ename	varchar(100)	,
	jobtitle	varchar(100)	,
	managerid	int	,
	hiredate	date	,
	salary	money	,
	commission	decimal(9,2)	,
	did	int ,
	rid int
)			

EXEC sp_tables @table_owner='dbo'
EXEC sp_help 'emp'

insert into emp (eid,ename,jobtitle,managerid,hiredate,salary,commission,did,rid)
	Values
	(	68319, 'Kylie', 'President', 68319, '2009-11-18', 60000.00, NULL , 10	, NULL ),
	(	66928, 'Bob', 'General Manager', 68319, '2013-05-01', 27500.00, 0.33 , 10	, NULL ),
	(	67832, 'Clare', 'Technical Manager', 66928, '2011-06-09', 25500.00, NULL , 10	, NULL ),
	(	65646, 'John', 'Sales Manager', 66928, '2014-04-02', 29570.00, NULL , 10	, NULL ),
	(	67858, 'Scarlet', 'Analyst', 67832, '2017-04-19', 3100.00, NULL , 20	, NULL ),
	(	69324, 'Mark', 'DBA', 67832, '2012-01-23', 1900.00, NULL , 20	, NULL ),
	(	69062, 'Frank', 'Analyst', 67832, '2011-12-03', 3100.00, NULL , 20	, NULL ),
	(	63679, 'Sandra', 'Developer', 67832, '2010-12-18', 2900.00, NULL , 20	, NULL ),
	(	64989, 'Irene', 'Sales Representative', 65646, '2018-02-20', 1700.00, 0.1, 30	, 1 ),
	(	65271, 'Dwayne', 'Sales Representative', 65646, '2011-02-22', 1350.00, 0.05, 30	, 2 ),
	(	66564, 'Gerogia', 'Sales Representative', 65646, '2011-09-28', 1400.00, 0.02, 30	, 1 ),
	(	66569, 'Matt', 'Sales Representative', 65646, '2019-01-28', 1325.00, 0.02, 30	, 2 ),
	(	66571, 'Raj', 'Sales Representative', 65646, '2013-02-15', 1190.00, 0.02, 30	, 5 ),
	(	68454, 'Tucker', 'Sales Representative', 65646, '2011-09-08', 1600.00, 0.01, 30	, 3 ),
	(	68455, 'Sam', 'Sales Representative', 65646, '2020-09-18', 1400.00, 0.01, 30	, 4 ),
	(	68736, 'Andy', 'Technical Support', 67832, '2017-05-23', 1200.00, NULL , 20	, NULL ),
	(	69000, 'Julie', 'Sales Apprentice', 65646, '2011-12-03', 950.00, NULL , 30 , 4	)


--Create dept table:
CREATE TABLE [dbo].[dept](
	[did] [int] NOT NULL,
	[DeptName] [nchar](30) NULL
)

INSERT INTO dept ([did],[DeptName])
VALUES
	(10,	'Mgmt'),
	(20,	'Tech'),
	(30,	'Sales'),
	(40,	'Procurement')
    
--Create region table:
CREATE TABLE [dbo].[region](
	[rid] [int] NOT NULL,
	[RegionName] [nchar](30) NULL
)

INSERT INTO region ([rid],[RegionName])
VALUES
	(1,	'Americas'),
	(2,	'Europe'),
	(3,	'Australias'),
	(4,	'Africa'),
	(5,	'Asia'),
	(6,	'Antarctica')


--Creating PK on DEPT:
ALTER TABLE dept
ADD CONSTRAINT pk_did
PRIMARY KEY (did)

--Creating PK on REGION table:
ALTER TABLE region
ADD CONSTRAINT pk_rid
PRIMARY KEY (rid)

--FK for DEPT:
ALTER TABLE emp
ADD CONSTRAINT fk_did
FOREIGN KEY (did) REFERENCES dept(did)

--FK for REGION:
ALTER TABLE emp
ADD CONSTRAINT fk_rid
FOREIGN KEY (rid) REFERENCES region(rid)
-------------------------------------------------------
EXEC sp_tables @table_owner='dbo'
SELECT * FROM emp
SELECT * FROM dept
SELECT * FROM region
-------------------------------------------------------

EXEC sp_help 'emp'

------------------x------------------

