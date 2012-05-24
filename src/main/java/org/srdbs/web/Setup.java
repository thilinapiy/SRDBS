package org.srdbs.web;

import org.srdbs.core.DbConnect;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/24/12
 * Time: 10:52 AM
 * For more details visit : http://www.thilina.org
 */
public class Setup {

    public static String checkInstallation() {

        DbConnect insert = new DbConnect();
        insert.insertSetup("INIT_CONFIG", "true");
        return "";
    }
}
