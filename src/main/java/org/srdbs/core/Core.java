package org.srdbs.core;

import org.srdbs.sftp.Sftp;
import org.srdbs.web.Web;
import org.apache.log4j.Logger;

import java.util.Date;

/**
 * Main class of the system
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Core {

    private static Logger logger = Logger.getLogger("System");

    /**
     * This is the main method of the system.
     *
     * @param args Get the command line input
     */
    public static void main(String[] args) {

        if (args[0].isEmpty()) {
            System.exit(-1);
        }
        String arg = args[0];
        System.out.println(arg);
        if (arg.matches("run")) {

            Date date = new Date();
            logger.info("System startup at : " + date.getTime());

            Sftp.main();
            try {
                Web.main();
            } catch (Exception e) {
                logger.error("Error occurred : " + e);
            }
        } else {
            logger.info("Exiting.");
            System.exit(0);
        }

    }
}
