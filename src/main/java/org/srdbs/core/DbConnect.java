package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.split.MYSpFile;
import org.srdbs.split.MyFile;

import java.sql.*;
import java.util.ArrayList;
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
    public static Logger backplogger = Logger.getLogger("backupLog");
    public static Logger restoreLog = Logger.getLogger("restoreLog");

    private Connection connect() {

        Connection conn = null;
        try {

            Class.forName(Global.dbDriver).newInstance();
            Global.dbURL = "jdbc:mysql://" + Global.dbIPAddress + ":" + Global.dbPort + "/";
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

    public ArrayList selectQuery(String query) {

        ArrayList array = new ArrayList();

        try {

            Connection conn = connect();
            Statement stmt = conn.createStatement();
            ResultSet resultSet = stmt.executeQuery(query);
            logger.info("Execute the SQL SELECT statement.");
            ResultSetMetaData rm = resultSet.getMetaData();
            while (resultSet.next()) {
                ArrayList row = new ArrayList();
                for (int column = 1; column <= rm.getColumnCount(); column++) {
                    row.add(resultSet.getObject(column));
                }
                array.add(row);
            }
            resultSet.close();
            stmt.close();
            conn.close();
            logger.info("Retrieve data from the database successfully.");
        } catch (Exception e) {

            logger.error("Error in reading data from database. : " + e);
        }

        return array;
    }

    public boolean updateQuery(String query) {

        Connection conn = connect();
        Statement s = null;
        try {
            s = conn.createStatement();
            s.executeUpdate(query);
            s.close();
            return true;

        } catch (Exception e) {
            logger.error("Error on update sql query : " + query);
            return false;
        }
    }

    public int validateUser(String uname, String passwd) {

        return 0;
    }

    public int saveFiles(List<MyFile> fileList) throws SQLException {

        //	String sql = "insert into Full_File (FName, FSize, HashValue,Up_Date) values (?, ?, ?,?)";
        String sql = "insert into full_file (FName,FSize,HashValue,Up_Date) values (?,?,?,?)";
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

    public ArrayList getBasicConfig() {

        String sql = "SELECT * FROM backup_locations";
        return selectQuery(sql);
    }

    public int saveFiles(String Fname, long Size, String Hash, String Date) {

        //	String sql = "insert into Full_File (FName, FSize, HashValue,Up_Date) values (?, ?, ?,?)";
        String sql = "insert into Full_File (FName,FSize,HashValue,Up_Date) values (?,?,?,?)";
        Connection connection = connect();
        PreparedStatement ps = null;
        try {
            ps = connection.prepareStatement(sql);
            //for (MyFile myFile: fileList) {
            // java.sql.Date sqlDate = new java.sql.Date(myFile.getcDate().getTime());
            MyFile myFile = new MyFile();
            ps.setString(1, Fname);
            ps.setLong(2, Size);
            ps.setString(3, Hash);
            ps.setString(4, Date);
            ps.addBatch();
            //}
            ps.executeBatch();
            ps.close();
            connection.close();
        } catch (SQLException e) {
            logger.error("Save File error.");
        }

        return 1;
    }

    public int saveSPFiles(long fid, String Fname, long Size, String Hash, int Cl_ID, int R_ID) throws SQLException {


        String sql = "insert into Sp_File (F_ID,SP_FileName,F_Size,HashValue,Ref_Cloud_ID,Raid_Ref) values (?,?,?,?,?,?)";
        Connection connection = connect();
        PreparedStatement ps = connection.prepareStatement(sql);


        //for (MYSpFile mySFile: fileList) {
        // java.sql.Date sqlDate = new java.sql.Date(myFile.getcDate().getTime());
        MYSpFile mySFile = new MYSpFile();
        ps.setLong(1, fid);
        ps.setString(2, Fname);
        ps.setLong(3, Size);
        ps.setString(4, Hash);
        //  ps.setString(4,mySFile.getcDate());
        ps.setInt(5, Cl_ID);
        ps.setInt(6, R_ID);
        ps.addBatch();
        //}
        ps.executeBatch();
        ps.close();
        connection.close();

        return 1;

    }

    public List<MyFile> selectFullQuery(int fid) {


        String sql = " select F_ID,FName,HashValue from Full_File where F_ID=" + fid + "";
        Connection connection = connect();
        List<MyFile> fileList = new ArrayList<MyFile>();
        try {
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);

            while (rs.next()) {
                MyFile myFile = new MyFile();

                myFile.setId(rs.getLong("F_ID"));
                myFile.setName(rs.getString("FName"));
                myFile.setHash(rs.getString("HashValue"));
                fileList.add(myFile);

            }
        } catch (Exception e) {
            logger.error("Error in SelectFullQuery : " + e);
        }
        return fileList;
    }

    public long RowCount() {

        long fid = 0;

        String sql = "select F_ID from Full_File ";
        Connection connection = connect();
        try {
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);

            while (rs.next()) {
                MyFile myfile = new MyFile();

                myfile.setId(rs.getLong("F_ID"));
            }
            rs.last();
            fid = rs.getRow();
        } catch (Exception e) {
            logger.error("Error in RowCount " + e);
        }
        return fid;
    }

    public List<MYSpFile> selectQuery(int fid) throws Exception {

        String sql = " select SP_FileName,HashValue from sp_file where F_ID=" + fid + "";
        Connection connection = connect();
        Statement s = connection.createStatement();
        ResultSet rs = s.executeQuery(sql);
        List<MYSpFile> fileList = new ArrayList<MYSpFile>();

        while (rs.next()) {
            MYSpFile myspFile = new MYSpFile();
            myspFile.setName(rs.getString("SP_FileName"));
            myspFile.setHash(rs.getString("HashValue"));
            fileList.add(myspFile);
        }
        return fileList;
    }

    public List<MYSpFile> selectLoadSpQuery(int fid) {

        String sql = " select SP_FileName,Ref_Cloud_ID,Raid_Ref from sp_file where F_ID=" + fid + "";
        Connection connection = connect();
        List<MYSpFile> fileList = new ArrayList<MYSpFile>();

        try {
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);

            while (rs.next()) {
                MYSpFile myspFile = new MYSpFile();
                myspFile.setName(rs.getString("SP_FileName"));
                myspFile.setCloud(rs.getInt("Ref_Cloud_ID"));
                myspFile.setRcloud(rs.getInt("Raid_Ref"));
                fileList.add(myspFile);
            }
            restoreLog.info("Get SP files of the FID : " + fid);
        } catch (Exception e) {
            restoreLog.error("Error in retrieving data from the database.");
        }

        return fileList;
    }
}