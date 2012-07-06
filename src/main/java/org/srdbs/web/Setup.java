package org.srdbs.web;

import org.apache.log4j.Logger;
import org.srdbs.core.Configs;
import org.srdbs.core.DbConnect;
import org.srdbs.core.Global;

import javax.servlet.http.HttpSession;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/24/12
 * Time: 10:52 AM
 * For more details visit : http://www.thilina.org
 */
public class Setup {

    public static Logger logger = Logger.getLogger("systemsLog");

    public static boolean checkInstallation(HttpSession session) {

        Global.dbIPAddress = (String) session.getAttribute("dbipaddress");
        Global.dbPort = Integer.valueOf(session.getAttribute("dbport").toString());
        Global.dbName = (String) session.getAttribute("dbname");
        Global.dbUserName = (String) session.getAttribute("dbuser");
        Global.dbPassword = (String) session.getAttribute("dbpassword");

        // Global.state = (String) session.getAttribute("setupstate");
        Global.SysUserName = (String) session.getAttribute("username");
        Global.SysUserPassword = (String) session.getAttribute("password");

        Global.c1IPAddress = (String) session.getAttribute("c1ipaddress");
        Global.c1Port = Integer.valueOf(session.getAttribute("c1port").toString());
        Global.c1Remotepath = (String) session.getAttribute("c1remotepath");
        Global.c1UserName = (String) session.getAttribute("c1username");
        Global.c1Password = (String) session.getAttribute("c1password");
        Global.c1MessagePort = Integer.valueOf(session.getAttribute("c1messageport").toString());
        Global.c1Bandwidth = Integer.valueOf(session.getAttribute("c1bandwidth").toString());
        Global.c1Cost = (String) session.getAttribute("c1cost");

        Global.c2IPAddress = (String) session.getAttribute("c2ipaddress");
        Global.c2Port = Integer.valueOf(session.getAttribute("c2port").toString());
        Global.c2Remotepath = (String) session.getAttribute("c2remotepath");
        Global.c2UserName = (String) session.getAttribute("c2username");
        Global.c2Password = (String) session.getAttribute("c2password");
        Global.c2MessagePort = Integer.valueOf(session.getAttribute("c2messageport").toString());
        Global.c2Bandwidth = Integer.valueOf(session.getAttribute("c2bandwidth").toString());
        Global.c2Cost = (String) session.getAttribute("c2cost");

        Global.c3IPAddress = (String) session.getAttribute("c3ipaddress");
        Global.c3Port = Integer.valueOf(session.getAttribute("c3port").toString());
        Global.c3Remotepath = (String) session.getAttribute("c3remotepath");
        Global.c3UserName = (String) session.getAttribute("c3username");
        Global.c3Password = (String) session.getAttribute("c3password");
        Global.c3Bandwidth = Integer.valueOf(session.getAttribute("c3bandwidth").toString());
        Global.c3MessagePort = Integer.valueOf(session.getAttribute("c3messageport").toString());
        Global.c3Cost = (String) session.getAttribute("c3cost");

        Global.tempLocation = (String) session.getAttribute("templocation");
        Global.restoreLocation = (String) session.getAttribute("restorelocation");
        Global.noOfBackuplocations = Integer.valueOf(session.getAttribute("noofbackuplocations").toString());

        Global.binaryConfigState = "true";
        new Configs().finalizeConfig();
        new DbConnect().setScheduler(session);

        logger.info("Setup is installing basic configurations of the system.");
        return true;
    }

    public static void initializeDatabase(HttpSession session) {

        Global.dbIPAddress = (String) session.getAttribute("dbipaddress");
        Global.dbPort = Integer.valueOf(session.getAttribute("dbport").toString());
        Global.dbName = (String) session.getAttribute("dbname");
        Global.dbUserName = (String) session.getAttribute("dbuser");
        Global.dbPassword = (String) session.getAttribute("dbpassword");

        DbConnect dbCon = new DbConnect();
        dbCon.updateQuery("DROP TABLE IF EXISTS sp_File");
        dbCon.updateQuery("DROP TABLE IF EXISTS full_File");
        dbCon.updateQuery("DROP TABLE IF EXISTS schedule");
        dbCon.updateQuery("DROP TABLE IF EXISTS sysconfig");
        dbCon.updateQuery("CREATE TABLE full_file(" +
                "F_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY," +
                "FName VARCHAR(100)," +
                "FSize BIGINT," +
                "HashValue VARCHAR(100)," +
                "Up_Date VARCHAR(100))");
        dbCon.updateQuery("Create Table Sp_File(" +
                "SP_FILE_ID int not null auto_increment," +
                "F_ID int," +
                "SP_FileName varchar(400)," +
                "F_SIZE Bigint," +
                "HashValue varchar(200)," +
                "Ref_Cloud_ID int," +
                "Raid_Ref int," +
                "Remote_path varchar(400)," +
                "Constraint Pk_SP_FileID_1 Primary key(SP_FILE_ID)," +
                "Constraint FK_SP_FileID_2 Foreign key (F_ID) References Full_File (F_ID))");
        dbCon.updateQuery("CREATE TABLE schedule(" +
                "backupID INT NOT NULL AUTO_INCREMENT PRIMARY KEY," +
                "location varchar (2048)," +
                "frequency int," +
                "StartHour int," +
                "StartMin int," +
                "compress int," +
                "encrypt int)");
        dbCon.updateQuery("CREATE TABLE sysconfig(" +
                "sysid int NOT NULL PRIMARY KEY," +
                "sysvalue VARCHAR (2048) NULL)");
        //dbCon.updateQuery("");
    }
}
