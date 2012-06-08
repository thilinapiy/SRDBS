package org.srdbs.web;

import org.apache.log4j.Logger;
import org.srdbs.core.Configs;
import org.srdbs.core.Global;

import javax.servlet.http.HttpSession;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/24/12
 * Time: 10:52 AM
 * For more details visit : http://www.thilina.org
 */
public class Setup {

    public static Logger logger = Logger.getLogger("systemsLog");

    public static boolean checkInstallation(HttpSession session) {

        String dbipaddress = (String) session.getAttribute("dbipaddress");
        String dbport = (String) session.getAttribute("dbport");
        String dbname = (String) session.getAttribute("dbname");
        String dbuser = (String) session.getAttribute("dbuser");
        String dbpassword = (String) session.getAttribute("dbpassword");

        Global.dbIP = dbipaddress;
        Global.dbPort = dbport;
        Global.dbName = dbname;
        Global.dbUserName = dbuser;
        Global.dbPassword = dbpassword;

        new Configs().finalizeConfig();

        String state = (String) session.getAttribute("setupstate");
        String username = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");

        //DbConnect insert = new DbConnect();
        //insert.insertSetup("INIT_CONFIG", "true");

        String c1ipaddress = (String) session.getAttribute("c1ipaddress");
        String c1port = (String) session.getAttribute("c1port");
        String c1username = (String) session.getAttribute("c1username");
        String c1password = (String) session.getAttribute("c1password");
        String c1bandwidth = (String) session.getAttribute("c1bandwidth");
        String c1cost = (String) session.getAttribute("c1cost");

        String c2ipaddress = (String) session.getAttribute("c2ipaddress");
        String c2port = (String) session.getAttribute("c2port");
        String c2username = (String) session.getAttribute("c2username");
        String c2password = (String) session.getAttribute("c2password");
        String c2bandwidth = (String) session.getAttribute("c2bandwidth");
        String c2cost = (String) session.getAttribute("c2cost");

        String c3ipaddress = (String) session.getAttribute("c3ipaddress");
        String c3port = (String) session.getAttribute("c3port");
        String c3username = (String) session.getAttribute("c3username");
        String c3password = (String) session.getAttribute("c3password");
        String c3bandwidth = (String) session.getAttribute("c3bandwidth");
        String c3cost = (String) session.getAttribute("c3cost");

        String templocation = (String) session.getAttribute("templocation");
        String restorelocation = (String) session.getAttribute("restorelocation");

        String backuplocation1 = (String) session.getAttribute("backuplocation1");
        String backuplocation2 = (String) session.getAttribute("backuplocation2");
        String backuplocation3 = (String) session.getAttribute("backuplocation3");
        String backuplocation4 = (String) session.getAttribute("backuplocation4");
        String backuplocation5 = (String) session.getAttribute("backuplocation5");

        String schedule1 = (String) session.getAttribute("schedule1");
        String schedule2 = (String) session.getAttribute("schedule2");
        String schedule3 = (String) session.getAttribute("schedule3");
        String schedule4 = (String) session.getAttribute("schedule4");
        String schedule5 = (String) session.getAttribute("schedule5");

        logger.info("Setup is installing basic configurations of the system.");
        return true;
    }
}
