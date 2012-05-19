package org.srdbs.web;

import org.apache.log4j.Logger;

/**
 * A test class to make sure the communication with the web application.
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class MyPrint {

    public static Logger backupLog = Logger.getLogger("backupLog");

    /**
     * This will send a random number to the server page.
     *
     * @return a number
     */
    public static String send() {

        int k = (int) (Math.random() * 100);
        backupLog.info("Generating a random value");
        return "The random value is : " + Integer.toString(k);
    }
}
