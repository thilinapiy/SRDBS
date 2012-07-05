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

        new DbConnect().getSystemConfig();

    }

    public void finalizeConfig() {

        try {
            binProp.setProperty("binary.system.config", Global.binaryConfigState);

            binProp.setProperty("mysql.dbIPAddress", Global.dbIPAddress);
            binProp.setProperty("mysql.dbPort", String.valueOf(Global.dbPort));
            binProp.setProperty("mysql.dbName", Global.dbName);
            binProp.setProperty("mysql.dbUserName", Global.dbUserName);
            binProp.setProperty("mysql.dbPassword", Global.dbPassword);
            binProp.store(new FileOutputStream(Global.binConfigPath), null);

            new DbConnect().finaliseSystemConfig();
            logger.info("Write configurations to the binary file.");

        } catch (Exception e) {
            logger.error("Error on writing configurations to binary file : " + e);
        }
    }
}
