package org.srdbs.core;

/**
 * Api class of the core
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Api {

    /**
     * This method will restart the core from the UI.
     */
    public static void restartCore() {

        System.out.println("Running the restartCore method.");
        Core.restart();
    }

    /**
     * This method will stop the core from the UI.
     */
    public static void stopCore() {

        System.out.println("Running the stopCore method.");
        Core.stop();
    }
}
