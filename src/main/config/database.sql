CREATE DATABASE SRDBSDB;

CREATE USER SRDBS;

GRANT ALL PRIVILEGES ON SRDBSDB.* TO 'SRDBS'@'127.0.0.1' IDENTIFIED BY 'password';

DROP TABLE sysconfig;
DROP TABLE clouds;
DROP TABLE backup_locations;

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

CREATE TABLE backup_locations(
  backupID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  location varchar (2048)
);

CREATE TABLE full_File(
	F_ID INT NOT NULL AUTO_INCREMENT,
	FName VARCHAR(100),
	FSize BIGINT,
	HashValue VARCHAR(100),
	Up_Date VARCHAR(100),
	CONSTRAINT PK_FULLF1 PRIMARY KEY (F_ID)
);


CREATE TABLE split_File(
	SP_FILE_ID INT NOT NULL AUTO_INCREMENT,
	F_ID INT,
	SP_FileName VARCHAR(400),
	F_SIZE BIGINT,
	HashValue VARCHAR(200),
	Ref_Cloud_ID INT,
	Raid_Ref INT,

	CONSTRAINT Pk_SP_FileID_1 PRIMARY KEY(SP_FILE_ID),
	CONSTRAINT FK_SP_FileID_2 FOREIGN KEY (F_ID) REFERENCES Full_File (F_ID)
);
--
-- Step 1
--
INSERT INTO sysconfig (sysname, sysvalue) VALUE ("INIT_CONFIG","falls");
INSERT INTO sysconfig (sysname, sysvalue) VALUE ("ADMIN_NAME","admin");
INSERT INTO sysconfig (sysname, sysvalue) VALUE ("PASSWORD",MD5('password'));
INSERT INTO sysconfig (sysname, sysvalue) VALUE ("SYSLOG_MAIN","");
INSERT INTO sysconfig (sysname, sysvalue) VALUE ("SYSLOG_BACKUP","");
INSERT INTO sysconfig (sysname, sysvalue) VALUE ("BACKUPLOG_MAIN","");
INSERT INTO sysconfig (sysname, sysvalue) VALUE ("BACKUPLOG_BACKUP","");
INSERT INTO sysconfig (sysname, sysvalue) VALUE ("RESTORELOG_MAIN","");
INSERT INTO sysconfig (sysname, sysvalue) VALUE ("RESTORELOG_BACKUP","");
--
-- Step 2
--
INSERT INTO clouds (cloudID, IPaddress, port, username, password, bandwidth, cost)
             VALUE (0,"192.168.1.5",55555,"prabodha","P$asd%#2","1024","300");
--
-- Step 3
--
INSERT INTO backup_locations (location) VALUE ("c:\\");
