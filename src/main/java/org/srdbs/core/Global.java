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
    public static String dbIP;
    public static String dbPort;
    public static String dbURL;
    public static String dbName;
    public static String dbDriver = "com.mysql.jdbc.Driver";
    public static String dbUserName;
    public static String dbPassword;

    public static int webPort;
}
