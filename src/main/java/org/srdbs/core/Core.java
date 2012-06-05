package org.srdbs.core;

import org.apache.log4j.Logger;
import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;
import org.srdbs.scheduler.RunJob;
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
                logger.info("Stopping ...");
                Core.stop();
            } else if (argument.matches("restart")) {
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

            try {
                Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();
                scheduler.start();

                JobDetail job = new JobDetail("backup1", "BackupSchedule", RunJob.class);

                Trigger trigger = new CronTrigger("Trigger1", "Triggers", "0 0/5 * * * ?");
                //Trigger trigger = TriggerUtils.makeHourlyTrigger();
                //trigger.setStartTime(new Date());
                //trigger.setName("myTrigger");

                scheduler.scheduleJob(job, trigger);

                while (true) {
                    try {
                        Thread.sleep(90L * 1000L);
                    } catch (InterruptedException e) {
                        logger.error("Thread interrupt.");
                        scheduler.shutdown(true);
                        logger.info("Shutdown the job.");
                    }
                }
            } catch (Exception e) {
                logger.error("Error creating the job : " + e);
            }

            /* RunBackup.runBackup("C:\\Users\\Thilina\\Desktop\\ISO\\",
                     "E:\\copytest\\",
                     524288);
            */
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

        new Configs().finalizeConfig();
        logger.info("Finalizing the binary configurations file.");
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

        new Configs().finalizeConfig();
        logger.info("Finalizing the binary configurations file.");
        logger.info("Stopping the system.");
        System.exit(0);
    }
}
