package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.web.Web;

/**
 * Main class of the system
 *
 * @author Thilina Piyasundara
 * @version 0.2
 */
public class Core {

    public static Logger logger = Logger.getLogger("systemsLog");

    /**
     * This is the runWebDashboard method of the system.
     *
     * @param args Get the command line input
     */
    public static void main(String[] args) {

        try {
            System.out.println("Starting the system.");
            Global.fs = System.getProperty("file.separator");
            Global.systemHome = System.getenv("SRDBS_HOME");
            System.out.println("System SRDBS_HOME path is set to : " + Global.systemHome);
            if (Global.systemHome == null) {
                System.out.println("Set the environment variable \"SRDBS_HOME\" and rerun the system.");
                System.exit(0);
            } else {
                Global.sysconfigPath = Global.systemHome + Global.fs + "config" + Global.fs + "sysconfig.conf";
                System.out.println("System main config file path is set to : " + Global.sysconfigPath);
            }

        } catch (Exception e) {

            System.out.println("Set the environment variable \"SRDBS_HOME\" and rerun the system.");
            System.exit(-1);
        }

        // initialize logs and system configurations.
        System.out.println("Initializing main system configurations.");
        new Configs().initConfigs();

        // Start, stop or restart the system.
        if (args.length == 0) {

            System.out.println("Usage : start | stop | restart");
            logger.info("Usage : start | stop | restart");
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

            System.out.println("Starting thread 1 (scheduler) started.");
            logger.info("Starting thread 1 (scheduler) started.");
            // RunBackup.runBackup("sadasd");
        }
    }

    private static class MyThread2 implements Runnable {
        public void run() {

            System.out.println("Starting thread 2 (web dashboard) Started.");
            logger.info("Starting thread 2 (web dashboard) Started.");
            Web.runWebDashboard();
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
            Process process = Runtime.getRuntime().exec(Global.systemHome + "\\bin\\srdbsstart.bat");
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
