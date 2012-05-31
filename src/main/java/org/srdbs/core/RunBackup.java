package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.split.FileData;
import org.srdbs.split.MYSpFile;
import org.srdbs.split.MyFile;

import java.util.List;

import static org.srdbs.split.Split.mySplit;


/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/25/12
 * Time: 10:46 AM
 * For more details visit : http://www.thilina.org
 */
public class RunBackup {

    public static Logger logger = Logger.getLogger("systemsLog");

    public static int runBackup(String path, String dest, int packetVal) {

        logger.info("Running the backup log.");

        DbConnect dbConnect = new DbConnect();
        int noOfFiles = 0;
        List<MyFile> listOfFiles = null;

        logger.info("Running the raid.");

        listOfFiles = FileData.Read(path);

        for (MyFile file : listOfFiles) {
            int count = mySplit(path + Global.fs + file.getName(), dest
                    + Global.fs + file.getName(), packetVal);
            logger.info("Split Files in the file path of : "
                    + path + Global.fs + file.getName()
                    + " in to " + count + " parts.");
            noOfFiles++;
        }

        try {
            dbConnect.saveFiles(listOfFiles);
            List<MYSpFile> dListOfFiles = FileData.ReadSPFile(dest);
            dbConnect.saveSPFiles(dListOfFiles);

        } catch (Exception e) {
            logger.error("Database connection error : " + e);
        }


        logger.info("Split " + noOfFiles + " Files in the file path of : " + path);
        // reg details of the backup
        // read folder and get files to backup
        // split file by file
        // RAID

        // ftp each part file

        return 0;
    }
}
