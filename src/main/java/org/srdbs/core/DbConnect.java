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

        Connection conn = null;
        try {

            Class.forName(Global.dbDriver).newInstance();
            conn = DriverManager.getConnection(Global.dbURL
                    + Global.dbName, Global.dbUserName, Global.dbPassword);
            logger.info("Connected to the database");
        } catch (Exception e) {
            logger.error(e);
        }

        return conn;
    }

    private int insertQuery(String query) {

        Statement statement = null;
        Connection con = connect();

        try {
            statement = con.createStatement();
            statement.executeUpdate(query);
            statement.close();
            con.close();
            logger.info("Disconnected from database");
        } catch (SQLException e) {
            logger.error("Error in sql statement. - " + e);
            return 10;
        }

        return 0;
    }

    private int selectQuery(String query) {
        return 0;
    }

    public int insertSetup(String key, String val) {

        String query = "INSERT INTO sysconfig (sysname, sysvalue) VALUE ('" + key + "','" + val + "')";
        return insertQuery(query);
    }

    public int validateUser(String uname, String passwd) {

        return 0;
    }
}
