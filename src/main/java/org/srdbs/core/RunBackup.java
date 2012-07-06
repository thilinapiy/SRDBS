package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.sftp.Sftp;
import org.srdbs.split.FileData;
import org.srdbs.split.MYSpFile;
import org.srdbs.split.MyFile;

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

    public static int runBackup(String path, String dest, int compress, int encrypt) {

        backplogger.info("Running the backup log.");
        backplogger.info("Running the backup for : " + dest + " (compress " + compress + ", encrypt " + encrypt + ")");

        DbConnect dbConnect = new DbConnect();
        int noOfFiles = 0;
        List<MyFile> listOfFiles = null;
        listOfFiles = FileData.Read(path);
        Date date = new Date();
        DateFormat datef = new SimpleDateFormat("yyMMddHHmmss");
        List<MYSpFile> dListOfFiles = null;

        for (MyFile file : listOfFiles) {

            //if compression is enabled.
            if (compress != 0) {

                backplogger.info("Compressing the backup files : " + file.getName());
            }
            // if encryption is enabled.
            if (encrypt != 0) {

                backplogger.info("Encrypting the backup files : " + file.getName());
            }

            int bandwidthSum = 1024 * (((int) (Math.random() * 10) % 9) + 10);
            int packetVal = (int) (file.getSize() / bandwidthSum);
            backplogger.info("Packet size : " + packetVal + " File size : " + file.getSize() + " c1 : " + Global.c1Bandwidth
                    + " c2 : " + Global.c2Bandwidth + " c3 : " + Global.c3Bandwidth);
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
            int[] raidArray = Sftp.raid(count);
            backplogger.info("Raid is done.");

            //TODO remove this
            for (int j = 0; j < raidArray.length; ) {
                backplogger.info("Packet " + (j + 2) / 2 + ": Orignal: " + raidArray[j] + " , " + "Raid: " + raidArray[j + 1]);
                j = j + 2;
            }

            try {
                dListOfFiles = FileData.ReadSPFile(dest, count, raidArray, datef.format(date));

                for (MYSpFile file2 : dListOfFiles) {
                    dbConnect.saveSPFiles(file2.getFid(), file2.getName(), file2.getSize(),
                            file2.getHash(), file2.getCloud(), file2.getRCloud(), file2.getRemotePath());
                }
                backplogger.info("Save split file details to the database. ");
            } catch (Exception e) {
                backplogger.error("Database connection error : " + e);
            }


            backplogger.info("Uploading " + file.getName() + " to cloud 1.");
            Sftp.upload(Global.c1IPAddress, Global.c1UserName, Global.c1Password, Global.c1Port,
                    Global.c1Remotepath + "/" + datef.format(date), dest + Global.fs + file.getName(), Global.cloud1ID);

            backplogger.info("Uploading " + file.getName() + " to cloud 2.");
            Sftp.upload(Global.c2IPAddress, Global.c2UserName, Global.c2Password, Global.c2Port,
                    Global.c2Remotepath + "/" + datef.format(date), dest + Global.fs + file.getName(), Global.cloud2ID);

            backplogger.info("Uploading " + file.getName() + " to cloud 3.");
            Sftp.upload(Global.c3IPAddress, Global.c3UserName, Global.c3Password, Global.c3Port,
                    Global.c3Remotepath + "/" + datef.format(date), dest + Global.fs + file.getName(), Global.cloud3ID);

        }

        backplogger.info("Split " + noOfFiles + " Files in the file path of : " + path);

        return 0;
    }
}
