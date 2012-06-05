package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.sftp.Sftp;
import org.srdbs.split.FileData;
import org.srdbs.split.MYSpFile;
import org.srdbs.split.MyFile;
import org.srdbs.split.Split;

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

        listOfFiles = FileData.Read(path);

        for (MyFile file : listOfFiles) {
            int count = mySplit(path + Global.fs + file.getName(), dest
                    + Global.fs + file.getName(), packetVal);
            logger.info("Split Files in the file path of : "
                    + path + Global.fs + file.getName()
                    + " in to " + count + " parts.");
            noOfFiles++;

            // RAID
            int[] raidArray = Sftp.raid(7, 3, 2, 3, 2);
            //TODO remove this

            for (int j = 0; j < raidArray.length; ) {
                logger.info("Packet " + (j + 2) / 2 + ": Orignal: " + raidArray[j] + " , " + "Raid: " + raidArray[j + 1]);
                j = j + 2;
            }

            int ftpFileNo = 1;
            boolean raidDone = false;
            for (int j = 0; j < raidArray.length; j++) {
                if (raidArray[j] == 1) {
                    logger.info("Uploading " + file + " to cloud 1.");
                    Sftp.upload("192.168.222.141", "prabodha", "prabodha", 22, "/home/prabodha",
                            dest + Global.fs + file.getName() + Split.createSuffix(ftpFileNo));
                }

                if (raidArray[j] == 2) {
                    logger.info("Uploading " + file + " to cloud 2.");
                    Sftp.upload("192.168.222.142", "prabodha", "prabodha", 22, "/home/prabodha",
                            dest + Global.fs + file.getName() + Split.createSuffix(ftpFileNo));
                }

                if (raidArray[j] == 3) {
                    logger.info("Uploading " + file + " to cloud 3.");
                    Sftp.upload("192.168.222.143", "prabodha", "prabodha", 22, "/home/prabodha",
                            dest + Global.fs + file.getName() + Split.createSuffix(ftpFileNo));
                }

                if (raidArray[j] == 4) {
                    logger.info("Uploading " + file + " to cloud 4.");
                    //  Sftp.upload()
                }

                if (raidArray[j] == 5) {
                    logger.info("Uploading " + file + " to cloud 5.");
                    //  Sftp.upload()
                }
                if (raidDone) {
                    ftpFileNo++;
                    raidDone = false;
                } else
                    raidDone = true;
            }
            // FTP data to server.

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
