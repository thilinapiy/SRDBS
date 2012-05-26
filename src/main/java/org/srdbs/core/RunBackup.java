package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.sftp.Sftp;
import org.srdbs.split.Split;

import java.io.File;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/25/12
 * Time: 10:46 AM
 * For more details visit : http://www.thilina.org
 */
public class RunBackup {

    public static Logger logger = Logger.getLogger("systemsLog");

    public static int runBackup(String BackpID) {

        logger.info("Running the backup log.");

        int count = 1;
        String path = "C:\\Users\\Thilina\\Desktop\\ISO\\";
        String dest = "E:\\copytest\\";
        String sFile = null;
        String dFile = null;
        String ftpFile = null;
        int packetVal = 524288;
        File[] filesInfolder;

        filesInfolder = getFiles(path);

        for (int i = 0; i < filesInfolder.length; i++) {
            if (filesInfolder[i].isFile()) {
                String files = filesInfolder[i].getName();
                sFile = path.concat(files);
                dFile = dest.concat(files);
                count++;
                int asd = Split.mySplit(sFile, dFile, packetVal);
                logger.info("Split the file : " + sFile);
            }
        }
        logger.info("Split " + count + " Files in the file path of : " + path);
        // reg details of the backup
        // read folder and get files to backup
        // split file by file
        // RAID
        logger.info("Running the raid.");
        // ftp each part file

        filesInfolder = getFiles(dest);
        for (int i = 0; i < filesInfolder.length; i++) {
            if (filesInfolder[i].isFile()) {
                String files = filesInfolder[i].getName();
                ftpFile = dest.concat(files);
                Sftp.upload("192.168.222.141", "prabodha", "prabodha", 22, "/home/prabodha/ftp", ftpFile);
                logger.info("Ftp done for the file : " + ftpFile);

            }
        }

        return 0;
    }

    private static File[] getFiles(String path) {

        File[] listOfFiles = null;
        try {
            File folder = new File(path);
            listOfFiles = folder.listFiles();
        } catch (Exception ex) {
            logger.error("Error in reading fo;der : " + path);
        }
        return listOfFiles;
    }
}
