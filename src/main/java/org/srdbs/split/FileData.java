package org.srdbs.split;

import org.apache.log4j.Logger;
import org.srdbs.core.Global;

import java.io.File;
import java.io.FileInputStream;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/30/12
 * Time: 11:07 AM
 * For more details visit : http://www.thilina.org
 */
public class FileData {

    public static Logger logger = Logger.getLogger("systemsLog");

    //TODO: change method name.
    public static List<MyFile> Read(String path) {

        File folder = null;
        String Full_Path;
        String Hash, date;

        try {
            folder = new File(path);
            logger.info("Reading the directory  : " + path);
        } catch (Exception e) {
            logger.error("Error reading directory : " + path);
        }

        List<MyFile> fileList = new ArrayList<MyFile>();

        for (File sysFile : folder.listFiles()) {
            Full_Path = path + Global.fs + sysFile.getName();
            long S = getFileSize(Full_Path);
            Hash = getHash(Full_Path);
            Calendar cal = Calendar.getInstance();
            date = cal.getTime().toString();

            MyFile myFile = new MyFile();
            myFile.setName(sysFile.getName());
            myFile.setHash(Hash);
            myFile.setcDate(date);
            myFile.setSize(S);
            myFile.setFile(sysFile);
            fileList.add(myFile);
        }

        return fileList;
    }

    //TODO: change method name.
    public static List<MYSpFile> ReadSPFile(String path) throws Exception {
        // int Count =0;
        // String Fname ;
        String Full_Path;
        String Hash, date;

        File folder = new File(path);
        List<MYSpFile> fileList = new ArrayList<MYSpFile>();
        for (File sysFile : folder.listFiles()) {
            Full_Path = path + "/" + sysFile.getName();
            long S = getFileSize(Full_Path);
            Hash = getHash(Full_Path);
            Calendar cal = Calendar.getInstance();
            date = cal.getTime().toString();

            MYSpFile mySPFile = new MYSpFile();
            mySPFile.setName(sysFile.getName());
            mySPFile.setHash(Hash);
            mySPFile.setcDate(date);
            mySPFile.setSize(S);
            mySPFile.setFile(sysFile);
            mySPFile.setCloud(1);
            mySPFile.setRcloud(2);
            fileList.add(mySPFile);
        }

        return fileList;
    }


    public static long getFileSize(String filename) {

        File file = new File(filename);

        if (!file.exists() || !file.isFile()) {
            System.out.println("File doesn\'t exist");
            return -1;
        }

        // Here we get the actual size
        return file.length();
    }

    public static String getHash(String sCompletePath) {

        FileInputStream fis = null;
        MessageDigest md = null;
        String hashValue = "";
        byte[] dataBytes = new byte[1024];
        byte[] mdBytes = null;
        int nRead = 0;


        try {
            md = MessageDigest.getInstance("MD5");
            fis = new FileInputStream(sCompletePath);
            while ((nRead = fis.read(dataBytes)) != -1) {
                md.update(dataBytes, 0, nRead);
            }
            mdBytes = md.digest();
            // convert the byte to hex format method 1
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < mdBytes.length; i++) {
                sb.append(Integer.toString((mdBytes[i] & 0xff) + 0x100, 16)
                        .substring(1));
            }
            logger.info("Digest in hex format :: " + sb.toString());
            hashValue = sb.toString();
        } catch (Exception e) {
            logger.error("Error in hashing : " + e);
        }

        return hashValue;
    }
}
