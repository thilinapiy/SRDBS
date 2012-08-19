package org.srdbs.core;

import java.text.DateFormat;
import java.util.Date;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/28/12
 * Time: 7:16 PM
 * For more details visit : http://www.thilina.org
 */
public class Global {

    // Main system configurations.
    public static String fs; // FileSeparator
    public static String systemHome;
    public static String sysConfigPath;
    public static String binConfigPath;
    public static String binaryConfigState;

    // Basic system configurations.
    public static String sysLogPath;
    public static String backupLogPath;
    public static String dbIPAddress;
    public static int dbPort;
    public static String dbURL;
    public static String dbName;
    public static String dbDriver = "com.mysql.jdbc.Driver";
    public static String dbUserName;
    public static String dbPassword;

    public static int webPort;
    public static String SysUserName;
    public static String SysUserPassword;

    public static String c1IPAddress;
    public static int c1Port;
    public static String c1Remotepath;
    public static String c1UserName;
    public static String c1Password;
    public static int c1MessagePort;
    public static int c1Bandwidth;
    public static String c1Cost;
    public static int cloud1ID = 1;

    public static String c2IPAddress;
    public static int c2Port;
    public static String c2Remotepath;
    public static String c2UserName;
    public static String c2Password;
    public static int c2MessagePort;
    public static int c2Bandwidth;
    public static String c2Cost;
    public static int cloud2ID = 2;

    public static String c3IPAddress;
    public static int c3Port;
    public static String c3Remotepath;
    public static String c3UserName;
    public static String c3Password;
    public static int c3MessagePort;
    public static int c3Bandwidth;
    public static String c3Cost;
    public static int cloud3ID = 3;

    public static String c4IPAddress;
    public static int c4Port;
    public static String c4Remotepath;
    public static String c4UserName;
    public static String c4Password;
    public static int c4MessagePort;
    public static int c4Bandwidth;
    public static String c4Cost;
    public static int cloud4ID = 3;

    public static String c5IPAddress;
    public static int c5Port;
    public static String c5Remotepath;
    public static String c5UserName;
    public static String c5Password;
    public static int c5MessagePort;
    public static int c5Bandwidth;
    public static String c5Cost;
    public static int cloud5ID = 3;

    public static String tempLocation;
    public static String restoreLocation;

    public static int noOfBackuplocations;
    public static int deleteCloudID;


}
