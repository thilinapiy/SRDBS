package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.messenger.Sender;
import org.srdbs.scheduler.RunScheduler;
import org.srdbs.web.Web;

/**
 * Main class of the system
 *
 * @author Thilina Piyasundara
 * @version 0.3
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
            System.out.println("initializing the basic system configurations.");

            // Get system details from the host machine
            Global.fs = System.getProperty("file.separator");
            Global.systemHome = System.getenv("SRDBS_HOME");
            System.out.println("System SRDBS_HOME path is set to : " + Global.systemHome);

            if (Global.systemHome == null) {
                System.out.println("Set the environment variable \"SRDBS_HOME\" and rerun the system.");
                System.exit(-1);
            } else {
                Global.sysConfigPath = Global.systemHome + Global.fs + "config" + Global.fs + "sysconfig.conf";
                Global.binConfigPath = Global.systemHome + Global.fs + "config" + Global.fs + "sysconfig.bin";
                System.out.println("System main config file path is set to : " + Global.sysConfigPath);
                System.out.println("System binary config file path is set to : " + Global.binConfigPath);
            }

        } catch (Exception e) {

            System.out.println("Set the environment variable \"SRDBS_HOME\" and rerun the system.");
            System.exit(-1);
        }

        // initialize logs and system configurations.
        System.out.println("Initializing main system configurations.");
        new Configs().initConfigs();
        System.out.println("Starting ...");
        logger.info("Starting ...");
        Core.start();
    }


    private static class WebDashboard implements Runnable {
        public void run() {

            System.out.println("Starting thread 2 (web dashboard) Started.");
            logger.info("Starting thread 2 (web dashboard) Started.");
            Web.runWebDashboard();
        }
    }

    private static class InitSchedule implements Runnable {

        public void run() {

            System.out.println("Starting thread 1 (scheduler) started.");
            logger.info("Starting thread 1 (scheduler) started.");
            RunScheduler.initSchedule();

        }
    }


    /**
     * This method will start the system.
     */
    protected static void start() {

        try {
            Thread t1 = new Thread(new WebDashboard());
            Thread t2 = new Thread(new InitSchedule());
            t1.start();
            logger.info("Start the web dashboard.");
            if (Global.binaryConfigState.equalsIgnoreCase("TRUE")) {
                if (checkSftpServices() && checkMessageServices()) {
                    t2.start();
                    logger.info("Start the system.");
                } else {
                    logger.error("Error in Message service/SFTP service. Please check if those services are " +
                            "running correctly and restart the server.");
                    logger.error("System terminated due to an error in Message service/SFTP service.");
                    System.exit(-1);
                }
            } else {
                System.out.println("Please do the initial configurations : https://localhost:8080/setup/ ");
                logger.info("Please do the initial configurations : https://localhost:8080/setup/ ");
            }

        } catch (Exception e) {
            logger.error("Error occurred : " + e);
        }
    }

    /**
     * This method will restart the system.
     */
    public static void restart() {

        new Configs().finalizeConfig();
        logger.info("Finalizing the binary configurations file.");
        logger.info("Restarting the configurations.");
        new Configs().initConfigs();
        RunScheduler.restartScheduler();
    }

    /**
     * This method will stop the system.
     */
    public static void stop() {

        new Configs().finalizeConfig();
        logger.info("Finalizing the binary configurations file.");
        logger.info("Stopping the system.");
        System.exit(0);
    }

    private static boolean checkMessageServices() {

        logger.info("Checking Message Services on clouds.");
        try {
            Sender.sendMessage(Global.c1IPAddress, Global.c1MessagePort, "status");
        } catch (Exception e) {
            logger.error("Message service on " + Global.c1IPAddress + ":" + Global.c1MessagePort + " is down");
            return false;
        }

        try {
            Sender.sendMessage(Global.c2IPAddress, Global.c2MessagePort, "status");
        } catch (Exception e) {
            logger.error("Message service on " + Global.c2IPAddress + ":" + Global.c2MessagePort + " is down");
            return false;
        }

        try {
            Sender.sendMessage(Global.c3IPAddress, Global.c3MessagePort, "status");
        } catch (Exception e) {
            logger.error("Message service on " + Global.c3IPAddress + ":" + Global.c3MessagePort + " is down");
            return false;
        }

        logger.info("All Message Services on clouds are working.");
        return true;
    }

    private static boolean checkSftpServices() {

        logger.info("Checking SFTP Services on clouds.");
        //TODO :  SFTP validation comes here.
        logger.info("All SFTP Services on clouds are working.");
        return true;
    }
}
