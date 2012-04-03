package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.web.Web;

import java.util.Date;

/**
 * Main class of the system
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Core {

    public static Logger logger = Logger.getLogger("System");

    /**
     * This is the main method of the system.
     *
     * @param args Get the command line input
     */
    public static void main(String[] args) {


        if (args.length == 0) {

            System.out.println("Usage : start | stop | restart");
            System.exit(-1);
        } else {

            String argument = args[0].toLowerCase().trim();
            if (argument.matches("start")) {
                System.out.println("Starting ...");
                Core.start();
            } else if (argument.matches("stop")) {
                System.out.println("Stopping ...");
                Core.stop();
            } else if (argument.matches("restart")) {
                System.out.println("Restarting ...");
                Core.restart();
            } else {
                System.out.println("Usage : start | stop | restart");
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
    protected static void restart() {
    }

    /**
     * This method will stop the system.
     */
    protected static void stop() {
    }
}
