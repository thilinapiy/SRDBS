package org.srdbs.web;

import org.apache.log4j.Logger;
import org.srdbs.core.Core;
import org.srdbs.core.Global;

/**
 * Api class of the core
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Api {

    public static Logger logger = Logger.getLogger("systemsLog");

    /**
     * This method will restart the core from the UI.
     */
    public static void restartCore() {

        logger.info("Running the restartCore method.");
        Core.restart();
    }

    /**
     * This method will stop the core from the UI.
     */
    public static void stopCore() {

        logger.info("Running the stopCore method.");
        Core.stop();
    }

    public static boolean systemState() {

        if (Global.binaryConfigState.equalsIgnoreCase("TRUE")) {
            return true;
        } else {
            return false;
        }
    }
}
