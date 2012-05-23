package org.srdbs.core;

import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/23/12
 * Time: 2:42 PM
 * For more details visit : http://www.thilina.org
 */
public class DbConnect {

    public static Logger logger = Logger.getLogger("systemsLog");

    public void connect() {

        logger.info("MySQL Connect Example.");
        Connection conn = null;
        String url = "jdbc:mysql://127.0.0.1:3306/";
        String dbName = "SRDBSDB";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "SRDBS";
        String password = "password";
        try {

            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url + dbName, userName, password);
            logger.info("Connected to the database");
            conn.close();
            logger.info("Disconnected from database");
        } catch (Exception e) {
            logger.error(e);
        }
    }
}
