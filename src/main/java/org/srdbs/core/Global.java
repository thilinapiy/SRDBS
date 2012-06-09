package org.srdbs.core;

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
    public static int c1Bandwidth;
    public static String c1Cost;

    public static String c2IPAddress;
    public static int c2Port;
    public static String c2Remotepath;
    public static String c2UserName;
    public static String c2Password;
    public static int c2Bandwidth;
    public static String c2Cost;

    public static String c3IPAddress;
    public static int c3Port;
    public static String c3Remotepath;
    public static String c3UserName;
    public static String c3Password;
    public static int c3Bandwidth;
    public static String c3Cost;

    public static String tempLocation;
    public static String restoreLocation;

    public static String backupLocation1;
    public static String backupLocation2;
    public static String backupLocation3;
    public static String backupLocation4;
    public static String backupLocation5;

    public static String schedule1;
    public static String schedule2;
    public static String schedule3;
    public static String schedule4;
    public static String schedule5;
}
