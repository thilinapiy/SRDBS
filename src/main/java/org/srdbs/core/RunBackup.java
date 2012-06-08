package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.sftp.Sftp;
import org.srdbs.split.FileData;
import org.srdbs.split.MYSpFile;
import org.srdbs.split.MyFile;
import org.srdbs.split.Split;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
    public static Logger backplogger = Logger.getLogger("backupLog");

    public static int runBackup(String path, String dest) {

        backplogger.info("Running the backup log.");
        logger.info("Running the backup log.");

        DbConnect dbConnect = new DbConnect();
        int noOfFiles = 0;
        List<MyFile> listOfFiles = null;
        listOfFiles = FileData.Read(path);
        Date date = new Date();
        DateFormat datef = new SimpleDateFormat("yyMMddHHmmss");

        for (MyFile file : listOfFiles) {

            int packetVal = ((int) file.getSize()) / (Global.cloudBW1 + Global.cloudBW2 + Global.cloudBW3);
            int count = mySplit(path + Global.fs + file.getName(), dest
                    + Global.fs + file.getName(), packetVal);

            backplogger.info("Split Files in the file path of : "
                    + path + Global.fs + file.getName()
                    + " in to " + count + " parts.");
            noOfFiles++;

            try {
                dbConnect.saveFiles(file.getName(), file.getSize(), file.getHash(), file.getcDate());
                backplogger.info("Save full file details to the database.");
            } catch (Exception e) {
                backplogger.error("Database connection error : " + e);
            }

            // RAID
            int[] raidArray = Sftp.raid(count, Global.cloudBW1, Global.cloudBW2, Global.cloudBW3);
            backplogger.info("Raid is done.");

            //TODO remove this
            for (int j = 0; j < raidArray.length; ) {
                backplogger.info("Packet " + (j + 2) / 2 + ": Orignal: " + raidArray[j] + " , " + "Raid: " + raidArray[j + 1]);
                j = j + 2;
            }

            try {
                List<MYSpFile> dListOfFiles = FileData.ReadSPFile(dest, count);
                for (MYSpFile file2 : dListOfFiles) {
                    dbConnect.saveSPFiles(file2.getFid(), file2.getName(), file2.getSize(),
                            file2.getHash(), file2.getCloud(), file2.getRCloud());
                }
                backplogger.info("Save split file details to the database. ");
            } catch (Exception e) {
                backplogger.error("Database connection error : " + e);
            }

            int ftpFileNo = 1;
            boolean raidDone = false;
            for (int j = 0; j < raidArray.length; j++) {

                if (raidArray[j] == 1) {
                    backplogger.info("Uploading " + file.getName() + Split.createSuffix(ftpFileNo) + " to cloud 1.");
                    Sftp.upload(Global.cloudIP1, Global.cloudUname1, Global.cloudPasswd1, Global.cloudPort1,
                            Global.cloudCWD1, dest + Global.fs + file.getName() + Split.createSuffix(ftpFileNo));
                    //Global.cloudCWD1 + "/" + datef.format(date), dest + Global.fs + file.getName() + Split.createSuffix(ftpFileNo));
                }

                if (raidArray[j] == 2) {
                    backplogger.info("Uploading " + file.getName() + Split.createSuffix(ftpFileNo) + " to cloud 2.");
                    Sftp.upload(Global.cloudIP2, Global.cloudUname2, Global.cloudPasswd2, Global.cloudPort2,
                            Global.cloudCWD2, dest + Global.fs + file.getName() + Split.createSuffix(ftpFileNo));
                    //Global.cloudCWD2 + "/" + datef.format(date), dest + Global.fs + file.getName() + Split.createSuffix(ftpFileNo));
                }

                if (raidArray[j] == 3) {
                    backplogger.info("Uploading " + file.getName() + Split.createSuffix(ftpFileNo) + " to cloud 3.");
                    Sftp.upload(Global.cloudIP3, Global.cloudUname3, Global.cloudPasswd3, Global.cloudPort3,
                            Global.cloudCWD3, dest + Global.fs + file.getName() + Split.createSuffix(ftpFileNo));
                    //Global.cloudCWD3 + "/" + datef.format(date), dest + Global.fs + file.getName() + Split.createSuffix(ftpFileNo));
                }

                if (raidArray[j] == 4) {
                    backplogger.info("Uploading " + file.getName() + Split.createSuffix(ftpFileNo) + " to cloud 4.");
                    //  Sftp.upload()
                }

                if (raidArray[j] == 5) {
                    backplogger.info("Uploading " + file.getName() + Split.createSuffix(ftpFileNo) + " to cloud 5.");
                    //  Sftp.upload()
                }
                if (raidDone) {
                    ftpFileNo++;
                    raidDone = false;
                } else
                    raidDone = true;
            }
        }

        backplogger.info("Split " + noOfFiles + " Files in the file path of : " + path);

        return 0;
    }
}
