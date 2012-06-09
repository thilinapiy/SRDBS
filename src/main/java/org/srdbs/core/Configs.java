package org.srdbs.core;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 4/9/12
 * Time: 12:03 PM
 * For more details visit : http://www.thilina.org
 */
public class Configs {

    public static Logger logger = Logger.getLogger("systemsLog");
    public static Logger backplogger = Logger.getLogger("backupLog");
    public static Logger restoreLog = Logger.getLogger("restoreLog");
    public static Properties binProp = new Properties();

    public void initConfigs() {

        try {
            PropertyConfigurator.configure(Global.sysConfigPath);
            logger.info("Logs initialization done by using system configuration file.");
            backplogger.info("Logs initialization done by using system configuration file.");
            restoreLog.info("Logs initialization done by using system configuration file.");
        } catch (Exception e) {
            System.out.println("Cannot read the sysconfig.conf file. \n" + e);
            System.exit(-1);
        }

        // Read the binary configurations file.
        try {
            binProp.load(new FileInputStream(Global.binConfigPath));
            if (binProp.getProperty("binary.system.config").equalsIgnoreCase("TRUE")) {
                System.out.println("Reading the binary config file (sysconfig.bin).");
                Global.binaryConfigState = binProp.getProperty("binary.system.config");
                initUsingBin(binProp);

            } else {
                System.out.println("Reading the system configuration file (sysconfig.conf).");
                Global.binaryConfigState = "false";
                Global.webPort = 8080;
            }
        } catch (Exception e) {
            System.out.println("Error reading binary config file : " + Global.binConfigPath + "\n" + e);
            System.exit(-1);
        }
    }

    public void initUsingBin(Properties binProp) {

        Global.dbDriver = "com.mysql.jdbc.Driver";
        Global.dbIPAddress = binProp.getProperty("mysql.dbIPAddress");
        Global.dbPort = Integer.valueOf(binProp.getProperty("mysql.dbPort"));
        Global.dbName = binProp.getProperty("mysql.dbName");
        Global.dbURL = "jdbc:mysql://" + Global.dbIPAddress + ":" + Global.dbPort + "/";
        Global.dbUserName = binProp.getProperty("mysql.dbUserName");
        Global.dbPassword = binProp.getProperty("mysql.dbPassword");

        Global.webPort = Integer.valueOf(binProp.getProperty("system.webPort"));
        Global.SysUserName = binProp.getProperty("system.SysUserName");
        Global.SysUserPassword = binProp.getProperty("system.SysUserPassword");

        Global.c1IPAddress = binProp.getProperty("system.c1IPAddress");
        Global.c1Port = Integer.valueOf(binProp.getProperty("system.c1Port"));
        Global.c1Remotepath = binProp.getProperty("system.c1Remotepath");
        Global.c1UserName = binProp.getProperty("system.c1UserName");
        Global.c1Password = binProp.getProperty("system.c1Password");
        Global.c1Bandwidth = Integer.valueOf(binProp.getProperty("system.c1Bandwidth"));
        Global.c1Cost = binProp.getProperty("system.c1Cost");

        Global.c2IPAddress = binProp.getProperty("system.c2IPAddress");
        Global.c2Port = Integer.valueOf(binProp.getProperty("system.c2Port"));
        Global.c2Remotepath = binProp.getProperty("system.c2Remotepath");
        Global.c2UserName = binProp.getProperty("system.c2UserName");
        Global.c2Password = binProp.getProperty("system.c2Password");
        Global.c2Bandwidth = Integer.valueOf(binProp.getProperty("system.c2Bandwidth"));
        Global.c2Cost = binProp.getProperty("system.c2Cost");

        Global.c3IPAddress = binProp.getProperty("system.c3IPAddress");
        Global.c3Port = Integer.valueOf(binProp.getProperty("system.c3Port"));
        Global.c3Remotepath = binProp.getProperty("system.c3Remotepath");
        Global.c3UserName = binProp.getProperty("system.c3UserName");
        Global.c3Password = binProp.getProperty("system.c3Password");
        Global.c3Bandwidth = Integer.valueOf(binProp.getProperty("system.c3Bandwidth"));
        Global.c3Cost = binProp.getProperty("system.c3Cost");

        Global.tempLocation = binProp.getProperty("system.tempLocation");
        Global.restoreLocation = binProp.getProperty("system.restoreLocation");

        Global.backupLocation1 = binProp.getProperty("system.backupLocation1");
        Global.backupLocation2 = binProp.getProperty("system.backupLocation2");
        Global.backupLocation3 = binProp.getProperty("system.backupLocation3");
        Global.backupLocation4 = binProp.getProperty("system.backupLocation4");
        Global.backupLocation5 = binProp.getProperty("system.backupLocation5");

        Global.schedule1 = binProp.getProperty("system.schedule1");
        Global.schedule2 = binProp.getProperty("system.schedule2");
        Global.schedule3 = binProp.getProperty("system.schedule3");
        Global.schedule4 = binProp.getProperty("system.schedule4");
        Global.schedule5 = binProp.getProperty("system.schedule5");

    }

    public void finalizeConfig() {

        try {
            binProp.setProperty("binary.system.config", Global.binaryConfigState);
            binProp.setProperty("mysql.dbIPAddress", Global.dbIPAddress);
            binProp.setProperty("mysql.dbPort", String.valueOf(Global.dbPort));
            binProp.setProperty("mysql.dbName", Global.dbName);
            binProp.setProperty("mysql.dbUserName", Global.dbUserName);
            binProp.setProperty("mysql.dbPassword", Global.dbPassword);

            binProp.setProperty("system.webPort", String.valueOf(Global.webPort));
            binProp.setProperty("system.SysUserName", Global.SysUserName);
            binProp.setProperty("system.SysUserPassword", Global.SysUserPassword);

            binProp.setProperty("system.c1IPAddress", Global.c1IPAddress);
            binProp.setProperty("system.c1Port", String.valueOf(Global.c1Port));
            binProp.setProperty("system.c1Remotepath", Global.c1Remotepath);
            binProp.setProperty("system.c1UserName", Global.c1UserName);
            binProp.setProperty("system.c1Password", Global.c1Password);
            binProp.setProperty("system.c1Bandwidth", String.valueOf(Global.c1Bandwidth));
            binProp.setProperty("system.c1Cost", Global.c1Cost);

            binProp.setProperty("system.c2IPAddress", Global.c2IPAddress);
            binProp.setProperty("system.c2Port", String.valueOf(Global.c2Port));
            binProp.setProperty("system.c2Remotepath", Global.c2Remotepath);
            binProp.setProperty("system.c2UserName", Global.c2UserName);
            binProp.setProperty("system.c2Password", Global.c2Password);
            binProp.setProperty("system.c2Bandwidth", String.valueOf(Global.c2Bandwidth));
            binProp.setProperty("system.c2Cost", Global.c2Cost);

            binProp.setProperty("system.c3IPAddress", Global.c3IPAddress);
            binProp.setProperty("system.c3Port", String.valueOf(Global.c3Port));
            binProp.setProperty("system.c3Remotepath", Global.c3Remotepath);
            binProp.setProperty("system.c3UserName", Global.c3UserName);
            binProp.setProperty("system.c3Password", Global.c3Password);
            binProp.setProperty("system.c3Bandwidth", String.valueOf(Global.c3Bandwidth));
            binProp.setProperty("system.c3Cost", Global.c3Cost);

            binProp.setProperty("system.tempLocation", Global.tempLocation);
            binProp.setProperty("system.restoreLocation", Global.restoreLocation);

            binProp.setProperty("system.backupLocation1", Global.backupLocation1);
            binProp.setProperty("system.backupLocation2", Global.backupLocation2);
            binProp.setProperty("system.backupLocation3", Global.backupLocation3);
            binProp.setProperty("system.backupLocation4", Global.backupLocation4);
            binProp.setProperty("system.backupLocation5", Global.backupLocation5);

            binProp.setProperty("system.schedule1", Global.schedule1);
            binProp.setProperty("system.schedule2", Global.schedule2);
            binProp.setProperty("system.schedule3", Global.schedule3);
            binProp.setProperty("system.schedule4", Global.schedule4);
            binProp.setProperty("system.schedule5", Global.schedule5);

            binProp.store(new FileOutputStream(Global.binConfigPath), null);
            logger.info("Write configurations to the binary file.");
        } catch (Exception e) {
            logger.error("Error on writing configurations to binary file : " + e);
        }
    }
}
