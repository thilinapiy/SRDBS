package org.srdbs.core;

import org.apache.log4j.Logger;

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

    public void initConfigs(Properties configFile) {

        try {

            String sysLogPath = configFile.getProperty("logs.systemslogpath");
            String backupLogPath = configFile.getProperty("logs.backuplogpath");
            String recoverLogPath = configFile.getProperty("logs.recoverylogpath");
            logger.info(sysLogPath);
            logger.info(backupLogPath);

        } catch (Exception e) {

            logger.error("Cannot read the sysconfig file. \n"
                    + "Please make sure that the \"sysconfig\" file exist. \n" +
                    "Please restart the system. \n");
            System.exit(-1);
        }
    }
}
