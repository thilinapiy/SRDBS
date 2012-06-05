CREATE DATABASE SRDBSDB;

CREATE USER SRDBS;

GRANT ALL PRIVILEGES ON SRDBSDB.* TO 'SRDBS'@'127.0.0.1' IDENTIFIED BY 'password';

DROP TABLE sysconfig;
DROP TABLE clouds;
DROP TABLE schedule;
DROP TABLE backup_locations;
DROP TABLE full_File;
DROP TABLE split_File;

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

CREATE TABLE full_file(
	F_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	FName VARCHAR(100),
	FSize BIGINT,
	HashValue VARCHAR(100),
	Up_Date VARCHAR(100)
);


CREATE TABLE split_file(
	SP_FILE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	F_ID INT,
	SP_FileName VARCHAR(400),
	F_SIZE BIGINT,
	HashValue VARCHAR(200),
	Ref_Cloud_ID INT,
	Raid_Ref INT
);
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

