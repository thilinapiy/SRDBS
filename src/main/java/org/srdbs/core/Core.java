package org.srdbs.core;

import org.apache.log4j.Logger;
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


    private static class RunDashboardThread implements Runnable {
        public void run() {

            System.out.println("Starting the dashboard thread.");
            logger.info("Starting the dashboard Started.");
            Web.runWebDashboard();
        }
    }

    private static class RunSchedulerThread implements Runnable {

        public void run() {

            System.out.println("Starting scheduler thread.");
            logger.info("Starting scheduler thread.");
            new RunScheduler().initSchedule();

        }
    }

    /**
     * This method will start the system.
     */
    protected static void start() {

        try {
            Thread t1 = new Thread(new RunDashboardThread());
            Thread t2 = new Thread(new RunSchedulerThread());
            t1.start();
            logger.info("Start the web dashboard.");
            if (Global.binaryConfigState.equalsIgnoreCase("TRUE")) {
                t2.start();
                logger.info("Start the system.");
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
        //TODO restart the scheduler.
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
}
