CREATE DATABASE srdbsdb;
CREATE USER srdbs;
GRANT ALL PRIVILEGES ON srdbsdb.* TO 'srdbs'@'127.0.0.1' IDENTIFIED BY 'password';

CREATE DATABASE srdbsclientdb;
CREATE USER srdbsclient;
GRANT ALL PRIVILEGES ON srdbsclientdb.* TO 'srdbsclient'@'127.0.0.1' IDENTIFIED BY 'password';

DROP TABLE sysconfig;
DROP TABLE schedule;

DROP TABLE sp_File;
DROP TABLE full_File;
DROP TABLE Cloud1;
DROP TABLE Cloud2;
DROP TABLE Cloud3;
DROP TABLE Fail_Upload;

CREATE TABLE sysconfig(
  sysid int NOT NULL PRIMARY KEY,
  sysvalue VARCHAR (2048)  null
);

CREATE TABLE schedule(
  backupID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  location varchar (2048),
  frequency int,
  StartHour int,
  StartMin int,
  compress int,
  encrypt int
);


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

Create Table Fail_Upload(
  F_ID int,
  CloudID int,
  File_Source_path varchar(400),
  Remote_path varchar(400)
);

Create Table Cloud1(
  f_ID int,
  FileName varchar(400),
  Remote_Path varchar(400)
);

Create Table Cloud2(
  f_ID int,
  FileName varchar(400),
  Remote_Path varchar(400)
);

Create Table Cloud3(
  f_ID int,
  FileName varchar(400),
  Remote_Path varchar(400)
);

SELECT  * from Sp_File; SELECT  * from full_file;

update schedule set starthour= , startmin= , compress=0, encrypt=0 where backupid=1;