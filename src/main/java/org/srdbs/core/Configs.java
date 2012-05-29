package org.srdbs.core;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import java.io.FileInputStream;
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

    public void initConfigs() {

        //initialize log4j settings.
        try {

            PropertyConfigurator.configure(Global.sysconfigPath);
            logger.info("Logs initialization done.");

        } catch (Exception e) {
            System.out.println("Cannot read the sysconfig.conf file. \n"
                    + "Check the environment variable \"SRDBS_HOME\" and "
                    + "the \"sysconfig.conf\" file exist in " + Global.sysconfigPath + ". \n");
            System.exit(-1);
        }

        // initialize other system parameters
        Properties prop = new Properties();
        try {
            prop.load(new FileInputStream(Global.sysconfigPath));
            initSysParameters(prop);
        } catch (Exception e) {
            System.out.println("Error in system variable initialization. Check the config file : \n"
                    + Global.sysconfigPath);
            logger.error("Error in system variable initialization. Check the config file : \n"
                    + Global.sysconfigPath);
            System.exit(-1);
        }

    }

    public void initSysParameters(Properties prop) {

        Global.webPort = Integer.valueOf(prop.getProperty("web.port"));
        System.out.println("Web dashboard port : " + Global.webPort);
        logger.info("Web dashboard port : " + Global.webPort);
    }

    public void getConfigFromDb() {

        try {
            DbConnect dbc = new DbConnect();
            dbc.connect();
        } catch (Exception ex) {
            System.out.println("Error in database connection : " + ex);
            logger.error("Error in database connection : " + ex);
            System.exit(-1);
        }
    }
}
