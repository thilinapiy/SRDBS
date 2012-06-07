package org.srdbs.core;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
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
    public static Properties prop = new Properties();

    public void initConfigs() {

        // Read the binary configurations file.
        try {
            binProp.load(new FileInputStream(Global.binConfigPath));
            if (binProp.getProperty("binary.system.config").equalsIgnoreCase("TRUE")) {
                System.out.println("Reading the binary config file (sysconfig.bin).");
                Global.binaryConfigState = binProp.getProperty("binary.system.config");

                // initializing using the binary file
                initUsingBin(binProp);
            } else {
                System.out.println("Reading the system configuration file (sysconfig.conf).");
                Global.binaryConfigState = "false";

                //initializing using sysconfig.conf file.
                initUsingSysConfig();
            }
        } catch (Exception e) {
            System.out.println("Error reading binary config file : " + Global.binConfigPath + "\n" + e);
            System.exit(-1);
        }
    }

    private void initUsingSysConfig() {

        try {

            PropertyConfigurator.configure(Global.sysConfigPath);
            logger.info("Logs initialization done by using system configuration file.");
            backplogger.info("Logs initialization done by using system configuration file.");
            restoreLog.info("Logs initialization done by using system configuration file.");
        } catch (Exception e) {
            System.out.println("Cannot read the sysconfig.conf file. \n" + e);
            System.exit(-1);
        }

        try {

            prop.load(new FileInputStream(Global.sysConfigPath));
            Global.webPort = Integer.valueOf(prop.getProperty("web.port"));
            //TODO Remove database details

            Global.dbIP = prop.getProperty("mysql.dbIP");
            Global.dbPort = prop.getProperty("mysql.dbPort");
            Global.dbName = prop.getProperty("mysql.dbName");
            Global.dbUserName = prop.getProperty("mysql.dbUserName");
            Global.dbPassword = prop.getProperty("mysql.dbPassword");
            Global.dbURL = "jdbc:mysql://" + Global.dbIP + ":" + Global.dbPort + "/";
            logger.info("DB URL : " + Global.dbURL + ", "
                    + "DB Name : " + Global.dbName + ", "
                    + "DB User : " + Global.dbUserName);
            System.out.println("Web dashboard port : " + Global.webPort);
            logger.info("Web dashboard port : " + Global.webPort);

            //TODO : remove this from the source
            initDbConfigs();

        } catch (Exception e) {
            System.out.println("Error in system variable initialization. Check the config file : \n"
                    + Global.sysConfigPath);
            logger.error("Error in system variable initialization. Check the config file : \n"
                    + Global.sysConfigPath);
            System.exit(-1);
        }
    }

    public void initUsingBin(Properties binProp) {

        PropertyConfigurator.configure(Global.binConfigPath);
        logger.info("Logs initialization done by using binary configurations file.");
        backplogger.info("Logs initialization done by using binary configurations file.");
        restoreLog.info("Logs initialization done by using binary configurations file.");

        Global.webPort = Integer.valueOf(binProp.getProperty("web.port"));
        System.out.println("Web dashboard port : " + Global.webPort);
        logger.info("Web dashboard port : " + Global.webPort);

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
            Global.cloudPort1 = 22;
            Global.cloudBW1 = 1024;

            Global.cloudIP2 = "192.168.222.142";
            Global.cloudUname2 = "prabodha";
            Global.cloudPasswd2 = "prabodha";
            Global.cloudPort2 = 22;
            Global.cloudBW2 = 2048;

            Global.cloudIP3 = "192.168.222.143";
            Global.cloudUname3 = "prabodha";
            Global.cloudPasswd3 = "prabodha";
            Global.cloudPort3 = 22;
            Global.cloudBW3 = 4096;


            conn.close();

            System.out.println("Database connection test done.");
            ArrayList data = new DbConnect().getBasicConfig();
            System.out.println("Retrive data from the database.");

        } catch (Exception ex) {
            System.out.println("Error in database connection test : " + ex);
            logger.error("Error in database connection test : " + ex);
            System.exit(-1);
        }
    }

    public void finalizeConfig() {

        try {
            binProp.setProperty("binary.system.config", Global.binaryConfigState);
            binProp.store(new FileOutputStream(Global.binConfigPath), null);
            logger.info("Write configurations to the binary file.");
        } catch (Exception e) {
            logger.error("Error on writing configurations to binary file : " + e);
        }
    }
}
