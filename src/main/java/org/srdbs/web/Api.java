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

    public static boolean validateUser(String uName, String password) {

        if (uName.equalsIgnoreCase(Global.SysUserName)
                && password.equals(Global.SysUserPassword)) {
            return true;
        } else {
            return false;
        }
    }

    public static String getCloud1size() {

        String val = "123.23";

        return val;
    }

    public static String getCloud2size() {

        String val = "234.56";

        return val;
    }

    public static String getCloud3size() {

        String val = "345.67";

        return val;
    }

    public static String getCloud1Name() {

        return Global.c1IPAddress;
    }

    public static String getCloud2Name() {

        return Global.c2IPAddress;
    }

    public static String getCloud3Name() {

        return Global.c3IPAddress;
    }
}
