package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.split.MYSpFile;
import org.srdbs.split.MyFile;

import java.sql.*;
import java.util.List;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/23/12
 * Time: 2:42 PM
 * For more details visit : http://www.thilina.org
 */
public class DbConnect {

    public static Logger logger = Logger.getLogger("systemsLog");

    private Connection connect() {

        Connection conn = null;
        try {

            Class.forName(Global.dbDriver).newInstance();
            Global.dbURL = "jdbc:mysql://" + Global.dbIP + ":" + Global.dbPort + "/";
            conn = DriverManager.getConnection(Global.dbURL
                    + Global.dbName, Global.dbUserName, Global.dbPassword);
            logger.info("Connected to the database");
        } catch (Exception e) {
            logger.error("Database connection error : " + e);
        }

        return conn;
    }

    public int insertQuery(String query) {

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

    public int selectQuery(String query) {
        return 0;
    }

    public int insertSetup(String key, String val) {

        String query = "INSERT INTO sysconfig (sysname, sysvalue) VALUE ('" + key + "','" + val + "')";
        return insertQuery(query);
    }

    public int validateUser(String uname, String passwd) {

        return 0;
    }

    public int saveFiles(List<MyFile> fileList) throws SQLException {

        //	String sql = "insert into Full_File (FName, FSize, HashValue,Up_Date) values (?, ?, ?,?)";
        String sql = "insert into Full_File (FName,FSize,HashValue,Up_Date) values (?,?,?,?)";
        Connection connection = connect();
        PreparedStatement ps = connection.prepareStatement(sql);

        for (MyFile myFile : fileList) {
            // java.sql.Date sqlDate = new java.sql.Date(myFile.getcDate().getTime());
            ps.setString(1, myFile.getName());
            ps.setLong(2, myFile.getSize());
            ps.setString(3, myFile.getHash());
            ps.setString(4, myFile.getcDate());
            ps.addBatch();
        }
        ps.executeBatch();
        ps.close();
        connection.close();

        return 1;
    }

    public int saveSPFiles(List<MYSpFile> fileList) throws SQLException {


        String sql = "insert into Sp_File (SP_FileName,F_Size,HashValue,Ref_Cloud_ID,Raid_Ref) values (?,?,?,?,?)";
        Connection connection = connect();
        PreparedStatement ps = connection.prepareStatement(sql);

        for (MYSpFile mySFile : fileList) {
            // java.sql.Date sqlDate = new java.sql.Date(myFile.getcDate().getTime());

            ps.setString(1, mySFile.getName());
            ps.setLong(2, mySFile.getSize());
            ps.setString(3, mySFile.getHash());
            //  ps.setString(4,mySFile.getcDate());
            ps.setInt(4, mySFile.getCloud());
            ps.setInt(5, mySFile.getRCloud());
            ps.addBatch();
        }
        ps.executeBatch();
        ps.close();
        connection.close();

        return 1;

    }
}
