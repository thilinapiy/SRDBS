package org.srdbs.core;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.srdbs.web.Web;

import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.Properties;

/**
 * Main class of the system
 *
 * @author Thilina Piyasundara
 * @version 0.2
 */
public class Core {

    public static Logger logger = Logger.getLogger("systemsLog");

    /**
     * This is the main method of the system.
     *
     * @param args Get the command line input
     */
    public static void main(String[] args) {

        Properties configFile = new Properties();
        try {
            PropertyConfigurator.configure("config/sysconfig");
            configFile.load(new FileInputStream("config/sysconfig"));
            Configs newConfig = new Configs();
            newConfig.initConfigs(configFile);

        } catch (Exception e) {
            System.out.println("Cannot read the sysconfig file. \n"
                    + "Please make sure that the \"sysconfig\" file exist. \n"
                    + "Please restart the system. \n");
            System.exit(-1);
        }

        if (args.length == 0) {

            System.out.println("Usage : start | stop | restart");
            System.out.println("Usage : start | stop | restart");
            System.exit(-1);
        } else {

            String argument = args[0].toLowerCase().trim();
            if (argument.matches("start")) {
                System.out.println("Starting ...");
                logger.info("Starting ...");
                Core.start();
            } else if (argument.matches("stop")) {
                System.out.println("Stopping ...");
                logger.info("Stopping ...");
                Core.stop();
            } else if (argument.matches("restart")) {
                System.out.println("Restarting ...");
                logger.info("Restarting ...");
                Core.restart();
            } else {
                System.out.println("Usage : start | stop | restart");
                logger.info("Usage : start | stop | restart");
                System.exit(-1);
            }
        }
    }


    /**
     * This method will start the system.
     */
    protected static void start() {

        Date date = new Date();
        logger.info("System startup at : " + date.getTime());

        try {
            Web.main();
        } catch (Exception e) {
            logger.error("Error occurred : " + e);
        }
    }

    /**
     * This method will restart the system.
     */
    public static void restart() {

        logger.info("Restarting the core.");
        try {
            // This will create a new SRDBS process.
            File cwd = new File("");
            String binary = cwd.getAbsolutePath() + "\\bin\\start.bat";
            Process process = Runtime.getRuntime().exec(binary);
            logger.info("Create a new SRDBS Process");
        } catch (Exception e) {
            logger.error("Error : " + e);
        }
        logger.info("Exiting the initial process");
        System.exit(0);
    }

    /**
     * This method will stop the system.
     */
    public static void stop() {

        logger.info("Stopping the system.");
        System.exit(0);
    }
}
