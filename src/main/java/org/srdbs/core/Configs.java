package org.srdbs.core;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
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

        Global.webPort = 8080;
        Global.dbDriver = "com.mysql.jdbc.Driver";
        Global.dbIP = binProp.getProperty("mysql.dbIP");
        Global.dbPort = binProp.getProperty("mysql.dbPort");
        Global.dbName = binProp.getProperty("mysql.dbName");
        Global.dbURL = "jdbc:mysql://" + Global.dbIP + ":" + Global.dbPort + "/";
        Global.dbUserName = binProp.getProperty("mysql.dbUserName");
        Global.dbPassword = binProp.getProperty("mysql.dbPassword");

        initDbConfigs();
    }

    public void initDbConfigs() {

        // test the database connection.
        Connection conn = null;
        try {

            Class.forName(Global.dbDriver).newInstance();
            conn = DriverManager.getConnection(Global.dbURL
                    + Global.dbName, Global.dbUserName, Global.dbPassword);
            logger.info("Database connection test done.");
            // get data from the database
            // TODO change this

            Global.cloudIP1 = "192.168.222.141";
            Global.cloudUname1 = "prabodha";
            Global.cloudPasswd1 = "prabodha";
            Global.cloudCWD1 = "/home/prabodha";
            Global.cloudPort1 = 22;
            Global.cloudBW1 = 1024;

            Global.cloudIP2 = "192.168.222.142";
            Global.cloudUname2 = "prabodha";
            Global.cloudPasswd2 = "prabodha";
            Global.cloudCWD2 = "/home/prabodha";
            Global.cloudPort2 = 22;
            Global.cloudBW2 = 2048;

            Global.cloudIP3 = "192.168.222.143";
            Global.cloudUname3 = "prabodha";
            Global.cloudPasswd3 = "prabodha";
            Global.cloudCWD3 = "/home/prabodha";
            Global.cloudPort3 = 22;
            Global.cloudBW3 = 4096;

            conn.close();

            //System.out.println("Database connection test done.");
            //ArrayList data = new DbConnect().getBasicConfig();
            //System.out.println("Retrive data from the database.");

        } catch (Exception ex) {
            System.out.println("Error in database connection test : " + ex);
            logger.error("Error in database connection test : " + ex);
            System.exit(-1);
        }
    }

    public void finalizeConfig() {

        try {
            binProp.setProperty("binary.system.config", Global.binaryConfigState);
            binProp.setProperty("mysql.dbIP", Global.dbIP);
            binProp.setProperty("mysql.dbPort", Global.dbPort);
            binProp.setProperty("mysql.dbName", Global.dbName);
            binProp.setProperty("mysql.dbUserName", Global.dbUserName);
            binProp.setProperty("mysql.dbPassword", Global.dbPassword);

            binProp.store(new FileOutputStream(Global.binConfigPath), null);
            logger.info("Write configurations to the binary file.");
        } catch (Exception e) {
            logger.error("Error on writing configurations to binary file : " + e);
        }
    }
}
