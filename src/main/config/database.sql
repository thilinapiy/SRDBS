CREATE DATABASE SRDBSDB;

CREATE USER SRDBS;

GRANT ALL PRIVILEGES ON SRDBSDB.* TO 'SRDBS'@'127.0.0.1' IDENTIFIED BY 'password';

DROP TABLE sysconfig;
DROP TABLE clouds;
DROP TABLE schedule;
DROP TABLE backup_locations;
DROP TABLE sp_File;
DROP TABLE full_File;

CREATE TABLE sysconfig(
	sysname VARCHAR (30)  NOT NULL PRIMARY KEY,
--	sysvalue VARCHAR (2048)
	sysvalue VARBINARY (2048)
);


CREATE TABLE clouds(
  cloudID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  IPaddress VARCHAR(15),
  port INT,
  username VARCHAR(30),
  password VARBINARY(2048),
  bandwidth VARCHAR(30),
  cost VARCHAR(30)
);

-- CREATE TABLE schedule(
--  backupID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
--  starttime
--  location varchar (2048)
-- );

CREATE TABLE backup_locations(
  backupID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  location varchar (2048)
);

DROP TABLE sp_File;
DROP TABLE full_File;

CREATE TABLE full_file(
	F_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	FName VARCHAR(100),
	FSize BIGINT,
	HashValue VARCHAR(100),
	Up_Date VARCHAR(100)
);


Create Table Sp_File(
SP_FILE_ID int not null auto_increment,
F_ID int,
SP_FileName varchar(400),
F_SIZE Bigint,
HashValue varchar(200),
Ref_Cloud_ID int,
Raid_Ref int,
Remote_path varchar(400),

Constraint Pk_SP_FileID_1 Primary key(SP_FILE_ID),
Constraint FK_SP_FileID_2 Foreign key (F_ID) References Full_File (F_ID)
);

SELECT  * from Sp_File;


--
-- Step 1
--
INSERT INTO sysconfig (sysname, sysvalue) VALUE ('INIT_CONFIG','falls');
INSERT INTO sysconfig (sysname, sysvalue) VALUE ('ADMIN_NAME','admin');
INSERT INTO sysconfig (sysname, sysvalue) VALUE ('PASSWORD',MD5('password'));
INSERT INTO sysconfig (sysname, sysvalue) VALUE ('TEMP_LOCATION', 'E:\\copytest\\');
INSERT INTO sysconfig (sysname, sysvalue) VALUE ('SYSLOG_MAIN','');
INSERT INTO sysconfig (sysname, sysvalue) VALUE ('SYSLOG_BACKUP','');
INSERT INTO sysconfig (sysname, sysvalue) VALUE ('BACKUPLOG_MAIN','');
INSERT INTO sysconfig (sysname, sysvalue) VALUE ('BACKUPLOG_BACKUP','');
INSERT INTO sysconfig (sysname, sysvalue) VALUE ('RESTORELOG_MAIN','');
INSERT INTO sysconfig (sysname, sysvalue) VALUE ('RESTORELOG_BACKUP','');
--
-- Step 2
--
INSERT INTO clouds (IPaddress, port, username, password, bandwidth, cost)
             VALUE ('192.168.222.141',22,'prabodha','prabodha','1024','300');
--
-- Step 3
--
--
INSERT INTO backup_locations (location) VALUE ('C:\\Users\\Thilina\\Desktop\\ISO\\');
INSERT INTO backup_locations (location) VALUE ('C:\\Users\\Thilina\\Desktop\\movie\\');

