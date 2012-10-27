package org.srdbs.web;

import org.apache.activemq.usage.Usage;
import org.apache.log4j.Logger;
import org.srdbs.core.Core;
import org.srdbs.core.Global;
import org.srdbs.core.DbConnect;

/**
 * Api class of the core
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Api {

    public  static String  c1ip="";
    public  static String  c2ip="";
    public  static String  c3ip="";

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

        String c1 = "";
        DbConnect dbconnect = new DbConnect();
        try {
            double val = dbconnect.count(1) / (1024 * 1024 * 1024);
            c1 ="Usage : "+ Double.toString(Math.round(val * 1000.0) / 1000.0) +"GB";;
        } catch (Exception e) {
            logger.error("error on cloud usage capacity");
        }
        return c1;
    }

    public static String getCloud2size() {

        String c2 = "";
        DbConnect dbconnect = new DbConnect();
        try {
            double val = dbconnect.count(2) / (1024 * 1024 * 1024);
            c2 ="Usage : "+ Double.toString(Math.round(val * 1000.0) / 1000.0) +"GB";
        } catch (Exception e) {
            logger.error("error on cloud usage capacity");
        }
        return c2;
    }

    public static String getCloud3size() {
        String c3 = "";
        DbConnect dbconnect = new DbConnect();
        try {
            double val = dbconnect.count(3) / (1024 * 1024 * 1024);
            c3 ="Usage : "+ Double.toString(Math.round(val * 1000.0) / 1000.0) +"GB";;
        } catch (Exception e) {
            logger.error("error on cloud usage capacity");
        }
        return c3;
    }

    public static String getCloud1Name() {
           c1ip= "IP :"+Global.c1IPAddress;

        return  c1ip;
                //Global.c1IPAddress;
    }

    public static String getCloud2Name() {
        c2ip= "IP : "+Global.c2IPAddress;

        return c2ip;
    }

    public static String getCloud3Name() {

        c3ip= "IP : "+Global.c3IPAddress;
        return c3ip;
    }
}
