package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.scheduler.Schedule;
import org.srdbs.split.MYSpFile;
import org.srdbs.split.MyFile;

import javax.servlet.http.HttpSession;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.io.*;

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

    public int saveSPFiles(long fid, String Fname, long Size, String Hash, int Cl_ID, int R_ID/*, String R_Path*/) throws SQLException {


        String sql = "insert into Sp_File (F_ID,SP_FileName,F_Size,HashValue,Ref_Cloud_ID,Raid_Ref/*,Remote_path*/) values (?,?,?,?,?,?/*,?*/)";
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
        //ps.setString(7, R_Path);
        ps.addBatch();
        //}
        ps.executeBatch();
        ps.close();
        connection.close();

        return 1;

    }

    public int saveUploadSPFiles(long fid, String Fname, String path, int cloud ) throws SQLException {

        String sql = "update Sp_file set Remote_path = ?  where F_ID = '" +fid +"' and SP_FileName ='" + Fname + "'";
		Connection connection = connect();
        PreparedStatement ps = connection.prepareStatement(sql);
		MYSpFile mySfile = new MYSpFile();
		ps.setString(1,path);
		
		ps.addBatch();
        ps.executeBatch();
        ps.close();
        connection.close();


        return 1;


    }

    public int ErrorFiles(long fid, int CloudID, String filepath, String R_path) throws SQLException {


        String sql = "insert into Fail_Upload (F_ID,CloudID,File_Source_path,Remote_path) values (?,?,?,?)";
        Connection connection = connect();
        PreparedStatement ps = connection.prepareStatement(sql);

        MYSpFile mySFile = new MYSpFile();
        ps.setLong(1, fid);
        ps.setInt(2, CloudID);
        ps.setString(3, filepath);
        ps.setString(4, R_path);

        ps.addBatch();
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

        String sql = " select SP_FileName,Ref_Cloud_ID,Raid_Ref,Remote_path from sp_file where F_ID=" + fid + "";
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
                myspFile.setRemotePath(rs.getString("Remote_path"));
                fileList.add(myspFile);
            }
            restoreLog.info("Get SP files of the FID : " + fid);
        } catch (Exception e) {
            restoreLog.error("Error in retrieving data from the database.");
        }

        return fileList;
    }

    public List<Schedule> getSchedule() {

        String sql = "SELECT * FROM schedule";
        Connection connection = connect();
        List<Schedule> fileList = new ArrayList<Schedule>();

        try {
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);

            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setLocation(rs.getString("location"));
                schedule.setFrequency(rs.getInt("frequency"));
                schedule.setStartHour(rs.getInt("StartHour"));
                schedule.setStartMin(rs.getInt("StartMin"));
                schedule.setCompress(rs.getInt("compress"));
                schedule.setEncrypt(rs.getInt("encrypt"));
                fileList.add(schedule);
            }
            backplogger.info("Retrieve schedule data from the database.");

        } catch (Exception e) {
            backplogger.error("Error in retrieving scheduler data from the database : " + e);
        }

        return fileList;
    }

    public void setScheduler(HttpSession session) {

        String sql = "INSERT INTO schedule(location, frequency, StartHour, StartMin, compress, encrypt) VALUE (?,?,?,?,?,?)";
        Connection con = connect();

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            for (int i = 1; i <= Global.noOfBackuplocations; i++) {

                String location = "backuplocation" + i;
                String frequency = "frequency" + i;
                String StartHour = "starthour" + i;
                String StartMin = "startmin" + i;
                String compress = "compress" + i;
                String encrypt = "encrypt" + i;

                int freq = Integer.valueOf(session.getAttribute(frequency).toString());
                int stHour = Integer.valueOf(session.getAttribute(StartHour).toString());
                int stMin = Integer.valueOf(session.getAttribute(StartMin).toString());
                int comp = Integer.valueOf(session.getAttribute(compress).toString());
                int encr = Integer.valueOf(session.getAttribute(encrypt).toString());
                logger.debug("Convert Session objects to relevant types.");
                ps.setString(1, (String) session.getAttribute(location));
                logger.info("get location.");
                ps.setInt(2, freq);
                ps.setInt(3, stHour);
                ps.setInt(4, stMin);
                ps.setInt(5, comp);
                ps.setInt(6, encr);
                ps.addBatch();
                logger.info("Insert the backup location " + i + " : " + session.getAttribute(location));
            }

            ps.executeBatch();
            ps.close();
            con.close();

        } catch (Exception e) {

            logger.error("Error in inserting schedule in to the database : " + e);
        }
    }

    public void finaliseSystemConfig() {

        logger.info("Inserting configurations into the database.");
        String sql = "insert into sysconfig (sysid,sysvalue) values (?,?)";
        Connection con = connect();

        try {
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, 1);
            ps.setString(2, String.valueOf(Global.webPort));
            ps.addBatch();

            ps.setInt(1, 2);
            ps.setString(2, Global.SysUserName);
            ps.addBatch();

            ps.setInt(1, 3);
            ps.setString(2, Global.SysUserPassword);
            ps.addBatch();

            ps.setInt(1, 4);
            ps.setString(2, Global.c1IPAddress);
            ps.addBatch();

            ps.setInt(1, 5);
            ps.setString(2, String.valueOf(Global.c1Port));
            ps.addBatch();

            ps.setInt(1, 6);
            ps.setString(2, Global.c1Remotepath);
            ps.addBatch();

            ps.setInt(1, 7);
            ps.setString(2, Global.c1UserName);
            ps.addBatch();

            ps.setInt(1, 8);
            ps.setString(2, Global.c1Password);
            ps.addBatch();

            ps.setInt(1, 9);
            ps.setString(2, String.valueOf(Global.c1MessagePort));
            ps.addBatch();

            ps.setInt(1, 10);
            ps.setString(2, String.valueOf(Global.c1Bandwidth));
            ps.addBatch();

            ps.setInt(1, 11);
            ps.setString(2, Global.c1Cost);
            ps.addBatch();

            ps.setInt(1, 12);
            ps.setString(2, Global.c2IPAddress);
            ps.addBatch();

            ps.setInt(1, 13);
            ps.setString(2, String.valueOf(Global.c2Port));
            ps.addBatch();

            ps.setInt(1, 14);
            ps.setString(2, Global.c2Remotepath);
            ps.addBatch();

            ps.setInt(1, 15);
            ps.setString(2, Global.c2UserName);
            ps.addBatch();

            ps.setInt(1, 16);
            ps.setString(2, Global.c2Password);
            ps.addBatch();

            ps.setInt(1, 17);
            ps.setString(2, String.valueOf(Global.c2MessagePort));
            ps.addBatch();

            ps.setInt(1, 18);
            ps.setString(2, String.valueOf(Global.c2Bandwidth));
            ps.addBatch();

            ps.setInt(1, 19);
            ps.setString(2, Global.c2Cost);
            ps.addBatch();

            ps.setInt(1, 20);
            ps.setString(2, Global.c3IPAddress);
            ps.addBatch();

            ps.setInt(1, 21);
            ps.setString(2, String.valueOf(Global.c3Port));
            ps.addBatch();

            ps.setInt(1, 22);
            ps.setString(2, Global.c3Remotepath);
            ps.addBatch();

            ps.setInt(1, 23);
            ps.setString(2, Global.c3UserName);
            ps.addBatch();

            ps.setInt(1, 24);
            ps.setString(2, Global.c3Password);
            ps.addBatch();

            ps.setInt(1, 25);
            ps.setString(2, String.valueOf(Global.c3MessagePort));
            ps.addBatch();

            ps.setInt(1, 26);
            ps.setString(2, String.valueOf(Global.c3Bandwidth));
            ps.addBatch();

            ps.setInt(1, 27);
            ps.setString(2, Global.c3Cost);
            ps.addBatch();

            ps.setInt(1, 28);
            ps.setString(2, Global.c4IPAddress);
            ps.addBatch();

            ps.setInt(1, 29);
            ps.setString(2, String.valueOf(Global.c4Port));
            ps.addBatch();

            ps.setInt(1, 30);
            ps.setString(2, Global.c4Remotepath);
            ps.addBatch();

            ps.setInt(1, 31);
            ps.setString(2, Global.c4UserName);
            ps.addBatch();

            ps.setInt(1, 32);
            ps.setString(2, Global.c4Password);
            ps.addBatch();

            ps.setInt(1, 33);
            ps.setString(2, String.valueOf(Global.c4MessagePort));
            ps.addBatch();

            ps.setInt(1, 34);
            ps.setString(2, String.valueOf(Global.c4Bandwidth));
            ps.addBatch();

            ps.setInt(1, 35);
            ps.setString(2, Global.c4Cost);
            ps.addBatch();

            ps.setInt(1, 36);
            ps.setString(2, Global.c5IPAddress);
            ps.addBatch();

            ps.setInt(1, 37);
            ps.setString(2, String.valueOf(Global.c5Port));
            ps.addBatch();

            ps.setInt(1, 38);
            ps.setString(2, Global.c5Remotepath);
            ps.addBatch();

            ps.setInt(1, 39);
            ps.setString(2, Global.c5UserName);
            ps.addBatch();

            ps.setInt(1, 40);
            ps.setString(2, Global.c5Password);
            ps.addBatch();

            ps.setInt(1, 41);
            ps.setString(2, String.valueOf(Global.c5MessagePort));
            ps.addBatch();

            ps.setInt(1, 42);
            ps.setString(2, String.valueOf(Global.c5Bandwidth));
            ps.addBatch();

            ps.setInt(1, 43);
            ps.setString(2, Global.c5Cost);
            ps.addBatch();

            ps.setInt(1, 44);
            ps.setString(2, Global.tempLocation);
            ps.addBatch();

            ps.setInt(1, 45);
            ps.setString(2, Global.restoreLocation);
            ps.addBatch();

            ps.executeBatch();
            ps.close();
            con.close();

            //TODO: chang this to - on duplicate key update.
        } catch (Exception e) {

            logger.error("Error in inserting configurations in to the database." + e);
        }

    }

    public void getSystemConfig() {

        try {

            Connection conn = connect();
            Statement stmt = conn.createStatement();
            ResultSet resultSet = stmt.executeQuery("SELECT * FROM `sysconfig` ORDER BY `sysid`");
            logger.info("Reading configurations from the database.");

            resultSet.next();
            Global.webPort = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.SysUserName = resultSet.getString(2);
            resultSet.next();
            Global.SysUserPassword = resultSet.getString(2);

            resultSet.next();
            Global.c1IPAddress = resultSet.getString(2);
            resultSet.next();
            Global.c1Port = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c1Remotepath = resultSet.getString(2);
            resultSet.next();
            Global.c1UserName = resultSet.getString(2);
            resultSet.next();
            Global.c1Password = resultSet.getString(2);
            resultSet.next();
            Global.c1MessagePort = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c1Bandwidth = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c1Cost = resultSet.getString(2);

            resultSet.next();
            Global.c2IPAddress = resultSet.getString(2);
            resultSet.next();
            Global.c2Port = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c2Remotepath = resultSet.getString(2);
            resultSet.next();
            Global.c2UserName = resultSet.getString(2);
            resultSet.next();
            Global.c2Password = resultSet.getString(2);
            resultSet.next();
            Global.c2MessagePort = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c2Bandwidth = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c2Cost = resultSet.getString(2);

            resultSet.next();
            Global.c3IPAddress = resultSet.getString(2);
            resultSet.next();
            Global.c3Port = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c3Remotepath = resultSet.getString(2);
            resultSet.next();
            Global.c3UserName = resultSet.getString(2);
            resultSet.next();
            Global.c3Password = resultSet.getString(2);
            resultSet.next();
            Global.c3MessagePort = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c3Bandwidth = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c3Cost = resultSet.getString(2);

            resultSet.next();
            Global.c4IPAddress = resultSet.getString(2);
            resultSet.next();
            Global.c4Port = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c4Remotepath = resultSet.getString(2);
            resultSet.next();
            Global.c4UserName = resultSet.getString(2);
            resultSet.next();
            Global.c4Password = resultSet.getString(2);
            resultSet.next();
            Global.c4MessagePort = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c4Bandwidth = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c4Cost = resultSet.getString(2);

            resultSet.next();
            Global.c5IPAddress = resultSet.getString(2);
            resultSet.next();
            Global.c5Port = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c5Remotepath = resultSet.getString(2);
            resultSet.next();
            Global.c5UserName = resultSet.getString(2);
            resultSet.next();
            Global.c5Password = resultSet.getString(2);
            resultSet.next();
            Global.c5MessagePort = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c5Bandwidth = Integer.valueOf(resultSet.getString(2));
            resultSet.next();
            Global.c5Cost = resultSet.getString(2);

            resultSet.next();
            Global.tempLocation = resultSet.getString(2);
            resultSet.next();
            Global.restoreLocation = resultSet.getString(2);

            resultSet.close();
            stmt.close();
            conn.close();
            logger.info("Retrieve data from the database successfully.");
        } catch (Exception e) {

            logger.error("Error in reading data from database. : " + e.getMessage());
        }
    }
}
