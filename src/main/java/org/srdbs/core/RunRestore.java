package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.sftp.Sftp;
import org.srdbs.split.FileData;
import org.srdbs.split.Join;
import org.srdbs.split.MYSpFile;
import org.srdbs.split.MyFile;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 6/6/12
 * Time: 1:14 PM
 * For more details visit : http://www.thilina.org
 */
public class RunRestore {

    public static Logger logger = Logger.getLogger("systemsLog");
    public static Logger restoreLog = Logger.getLogger("restoreLog");

    public static int runRestore(int FID) {

        //Download files
        List<MYSpFile> getSPFiles = new DbConnect().selectLoadSpQuery(FID);
        for (MYSpFile spfile : getSPFiles) {

            int original = Sftp.download(spfile.getName(), spfile.getCloud());
            if (original != 0) {
                Sftp.download(spfile.getName(), spfile.getRCloud());
            }
        }


        try {
            DbConnect dbconnection = new DbConnect();
            List<MYSpFile> listofFiles = ReadSPFile(Global.restoreLocation);
            List<MyFile> listofrecords = dbconnection.selectFullQuery(FID);
            for (MyFile mylist : listofrecords) {
                if (HashCheck(listofFiles, FID)) {
                    String FileName = mylist.getName();
                    String S_Complete = Global.restoreLocation + "/" + FileName;
                    String D_Complete = Global.restoreLocation + "/" + FileName;
                    Join.join(S_Complete, D_Complete);

                    List<MyFile> fullfilelist = Read(Global.restoreLocation);
                    if (FullHashCheck(fullfilelist, FID)) {
                        restoreLog.info("Hashes are matching");
                    } else {
                        // restoreLog.error("Error in full file hash.");
                    }
                } else {
                    restoreLog.error("Error in split part hash.");
                }
            }
        } catch (Exception ex) {
            restoreLog.error("Error : " + ex);
        }

        return 0;
    }

    public static List<MYSpFile> ReadSPFile(String path) throws Exception {

        String Full_Path;
        String Hash, date;

        File folder = new File(path);
        List<MYSpFile> fileList = new ArrayList<MYSpFile>();
        for (File sysFile : folder.listFiles()) {
            Full_Path = path + "/" + sysFile.getName();
            Hash = FileData.getHash(Full_Path);
            MYSpFile mySPFile = new MYSpFile();
            mySPFile.setName(sysFile.getName());
            mySPFile.setHash(Hash);
            mySPFile.setFile(sysFile);
            fileList.add(mySPFile);
        }
        return fileList;
    }


    public static List<MyFile> Read(String path) throws Exception {

        String Full_Path;
        String Hash, date;
        File folder = new File(path);
        List<MyFile> fileList = new ArrayList<MyFile>();
        for (File sysFile : folder.listFiles()) {
            Full_Path = path + "/" + sysFile.getName();
            Hash = FileData.getHash(Full_Path);
            MyFile myFile = new MyFile();
            myFile.setName(sysFile.getName());
            myFile.setHash(Hash);
            myFile.setFile(sysFile);
            fileList.add(myFile);
        }

        return fileList;
    }

    public static boolean HashCheck(List<MYSpFile> listoffiles, int restoreFileID) throws Exception {

        boolean Check = true;
        DbConnect dbconnect = new DbConnect();
        List<MYSpFile> listofFileSp = dbconnect.selectQuery(restoreFileID);

        for (MYSpFile myfile : listoffiles) {
            for (MYSpFile dbfile : listofFileSp) {
                if ((myfile.getName().equalsIgnoreCase(dbfile.getName()))
                        && (myfile.getHash().equalsIgnoreCase(dbfile.getHash()))) {
                    Check = true;
                    restoreLog.info("Pass : " + myfile.getName());

                } else {
                    Check = false;
                    //restoreLog.error("Fail");
                }
            }
        }

        return Check;
    }

    public static boolean FullHashCheck(List<MyFile> listoffiles, int i) throws Exception {

        boolean pass = true;
        DbConnect dbconnect = new DbConnect();
        List<MyFile> list = dbconnect.selectFullQuery(i);
        for (MyFile myfile : listoffiles) {
            for (MyFile dbfile : list) {
                if (myfile.getName().equalsIgnoreCase(dbfile.getName())
                        && myfile.getHash().equalsIgnoreCase(dbfile.getHash())) {
                    pass = true;
                    restoreLog.info("Pass : " + myfile.getName());
                } else {
                    pass = false;
                    //restoreLog.info("Fail");
                }
            }
        }

        return pass;
    }
}
