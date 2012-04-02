package org.srdbs.web;

/**
 * A test class to make sure the communication with the web application.
 *
 * @version 0.1
 * @author Thilina Piyasundara
 */
public class MyPrint {

    /**
     * This will send a random number to the server page.
     *
     * @return a number
     */
    public static String send() {

        int k = (int) (Math.random() * 100);
        return "The random value is : " + Integer.toString(k);
    }
}
