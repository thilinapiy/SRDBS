package org.srdbs.core;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.srdbs.web.Web;

import java.io.FileInputStream;
import java.util.Properties;

/**
 * Main class of the system
 *
 * @author Thilina Piyasundara
 * @version 0.2
 */
public class Core {

    private static String homePath = null;
    private static String fs = null;    // FileSeparator
    private static String sysconfigPath = null;

    public static Logger logger = Logger.getLogger("systemsLog");

    /**
     * This is the main method of the system.
     *
     * @param args Get the command line input
     */
    public static void main(String[] args) {

        Properties configFile = new Properties();

        try {

            fs = System.getProperty("file.separator");
            homePath = System.getenv("SRDBS_HOME");
            if (homePath == null) {
                System.out.println("Set the environment variable \"SRDBS_HOME\" and rerun the system.");
                System.exit(0);
            } else {
                sysconfigPath = homePath + fs + "config" + fs + "sysconfig";
            }

        } catch (Exception e) {

            System.out.println("Set the environment variable \"SRDBS_HOME\" and rerun the system.");
            System.exit(-1);
        }

        try {

            PropertyConfigurator.configure(sysconfigPath);
            configFile.load(new FileInputStream(sysconfigPath));
            Configs newConfig = new Configs();
            newConfig.initConfigs(configFile);
            logger.info("Read the config file.");

        } catch (Exception e) {
            System.out.println("Cannot read the sysconfig file. \n"
                    + "Check the environment variable \"SRDBS_HOME\" and "
                    + "the \"sysconfig\" file exist in " + sysconfigPath + ". \n");
            System.exit(-1);
        }

        DbConnect dbc = new DbConnect();
        dbc.connect();

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


    private static class MyThread1 implements Runnable {

        public void run() {

            System.out.println("Thread 1 started.");
            RunBackup.runBackup("sadasd");
        }
    }

    private static class MyThread2 implements Runnable {
        public void run() {

            System.out.println("Thread 2 Started.");
            Web.main(homePath, fs);
        }
    }

    /**
     * This method will start the system.
     */
    protected static void start() {

        try {
            Thread t1 = new Thread(new MyThread1());
            Thread t2 = new Thread(new MyThread2());
            t1.start();
            t2.start();


            logger.info("Start the system.");
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
            Process process = Runtime.getRuntime().exec(homePath + "\\bin\\srdbsstart.bat");
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
