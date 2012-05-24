package org.srdbs.core;

import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/23/12
 * Time: 2:42 PM
 * For more details visit : http://www.thilina.org
 */
public class DbConnect {

    public static Logger logger = Logger.getLogger("systemsLog");

    public Connection connect() {

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
        } catch (Exception e) {
            logger.error(e);
        }

        return conn;
    }

    public int insertSetup(String key, String val) {

        Statement statement = null;
        Connection con = connect();
        int updateQuery = 0;

        try {

            statement = con.createStatement();
            String query = "INSERT INTO sysconfig (sysname, sysvalue) VALUE ('" + key + "','" + val + "')";
            updateQuery = statement.executeUpdate(query);
            statement.close();
            con.close();
            logger.info("Disconnected from database");
        } catch (SQLException e) {
            logger.error("Error in sql statement. - " + e);
        }
        return updateQuery;
    }
}
