package org.srdbs.core;

import org.apache.log4j.Logger;
import org.srdbs.sftp.Sftp;
import org.srdbs.split.FileData;
import org.srdbs.split.MYSpFile;
import org.srdbs.split.MyFile;
import java.security.SecureRandom;
import java.util.zip.*;
import javax.crypto.*;
import javax.crypto.spec.*;
import java.io.*;
import java.text.*;



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

    private static final int IV_LENGTH=16;
    public static String Despath;
    public  static int count;

    public static int runBackup(String path, final String dest, int compress, int encrypt) {

        backplogger.info("Running the backup log.");
        backplogger.info("Running the backup for : " + dest + " (compress " + compress + ", encrypt " + encrypt + ")");

        DbConnect dbConnect = new DbConnect();
        int noOfFiles = 0;
        List<MyFile> listOfFiles = null;
        listOfFiles = FileData.Read(path);
        List<MYSpFile> dListOfFiles = null;


        for (final MyFile file : listOfFiles) {

            //if both compression and encryption enable
            if((compress !=0)&&(encrypt !=0)){


                String fzip= file.getName()+".zip";

                try{
                compressFile(path+"/"+file.getName());
                }
                catch (Exception e){
                     e.printStackTrace();
                 }

                String fileName = path +"/"+fzip;
                String tempFileName=fileName+".enc";


                try{
                copy(Cipher.ENCRYPT_MODE, fileName, tempFileName, "password12345678");
                    System.out.println("Success. Find encrypted and decrypted files in current directory");
                    logger.info("Success. Find encrypted and decrypted files in current directory" + fzip);
                }
                catch (Exception e){
                    e.printStackTrace();
                }

                String fzipencrypt= file.getName()+".zip.enc";

                try{
                Despath = CreateFolder(dest);
                }
                catch (Exception e){
                    e.printStackTrace();
                }

                long FSize = FileData.getFileSize(path+"/"+fzip);

                int bandwidthSum = 1024 * (((int) (Math.random() * 10) % 9) + 10);
                int packetVal = (int) (FSize / bandwidthSum);
                backplogger.info("Packet size : " + packetVal + " File size : " + file.getSize() + " c1 : " + Global.c1Bandwidth
                        + " c2 : " + Global.c2Bandwidth + " c3 : " + Global.c3Bandwidth);
                int count = mySplit(path + Global.fs + fzipencrypt, Despath
                        + Global.fs + fzipencrypt, packetVal);

                backplogger.info("Split Files in the file path of : "
                        + path + Global.fs + file.getName()
                        + " in to " + count + " parts.");
                noOfFiles++;

                try {
                    dbConnect.saveFiles(fzipencrypt, file.getSize(), file.getHash(), file.getcDate());
                    backplogger.info("Save full file details to the database.");
                } catch (Exception e) {
                    backplogger.error("Database connection error : " + e);
                }


                backplogger.info("Compressing and Encrypting the backup files : " + file.getName());
            }

            //if compression is enabled.
           else if ((compress != 0)&&(encrypt ==0)) {

                String fzip= file.getName()+".zip";
                
                try{
                compressFile(path+"/"+file.getName());

                }
                catch (Exception e){
                    e.printStackTrace();
                }


                String fzipencrypt= file.getName()+".zip";
                
                try{
                Despath = CreateFolder(dest);
                }
                catch (Exception e){
                    e.printStackTrace();
                }
                long FSize = FileData.getFileSize(path+"/"+fzip);

                int bandwidthSum = 1024 * (((int) (Math.random() * 10) % 9) + 10);
                int packetVal = (int) (file.getSize() / bandwidthSum);
                backplogger.info("Packet size : " + packetVal + " File size : " + file.getSize() + " c1 : " + Global.c1Bandwidth
                        + " c2 : " + Global.c2Bandwidth + " c3 : " + Global.c3Bandwidth);
                int count = mySplit(path + Global.fs + fzipencrypt, Despath
                        + Global.fs + fzipencrypt, packetVal);

                backplogger.info("Split Files in the file path of : "
                        + path + Global.fs + file.getName()
                        + " in to " + count + " parts.");
                noOfFiles++;

                try {
                    dbConnect.saveFiles(fzip, file.getSize(), file.getHash(), file.getcDate());
                    backplogger.info("Save full file details to the database.");
                } catch (Exception e) {
                    backplogger.error("Database connection error : " + e);
                }

                 backplogger.info("Compressing the backup files : " + file.getName());
            }
            // if encryption is enabled.
          else  if ((encrypt != 0)&&(compress ==0)) {

                String fzip= file.getName();

                String fileName = path+"/"+fzip;
                String tempFileName=fileName+".enc";

                try{
                copy(Cipher.ENCRYPT_MODE, fileName, tempFileName, "password12345678");
                    System.out.println("Success. Find encrypted and decripted files in current directory");
                    logger.info("Success. Find encrypted and decripted files in current directory" + fzip);
               
                }
                catch (Exception e){
                    e.printStackTrace();
                }
                

                String fzipencrypt= file.getName()+".enc";
               
                try{
                Despath = CreateFolder(dest);
                }
                catch (Exception e){
                     e.printStackTrace();
                }
             
                long FSize =FileData.getFileSize(path+"/"+fzip);

                int bandwidthSum = 1024 * (((int) (Math.random() * 10) % 9) + 10);
                int packetVal = (int) (FSize / bandwidthSum);
                backplogger.info("Packet size : " + packetVal + " File size : " + file.getSize() + " c1 : " + Global.c1Bandwidth
                        + " c2 : " + Global.c2Bandwidth + " c3 : " + Global.c3Bandwidth);
                int count = mySplit(path + Global.fs + fzipencrypt, Despath
                        + Global.fs + fzipencrypt, packetVal);

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
               
                backplogger.info("Encrypting the backup files : " + file.getName());
            }

         else{
                String fnormal= file.getName();
                
                try{
                Despath = CreateFolder(dest);
                }
                catch (Exception e){
                    e.printStackTrace();
                }

                long FSize = FileData.getFileSize(path+"/"+fnormal);


                int bandwidthSum = 1024 * (((int) (Math.random() * 10) % 9) + 10);
                int packetVal = (int) (file.getSize() / bandwidthSum);
                backplogger.info("Packet size : " + packetVal + " File size : " + file.getSize() + " c1 : " + Global.c1Bandwidth
                        + " c2 : " + Global.c2Bandwidth + " c3 : " + Global.c3Bandwidth);
                int count = mySplit(path + Global.fs + fnormal, Despath
                        + Global.fs + fnormal, packetVal);

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


            }

            /*
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
            */

            // RAID
            int[] raidArray = Sftp.raid(count);
            backplogger.info("Raid is done.");

            //TODO remove this
            for (int j = 0; j < raidArray.length; ) {
                backplogger.info("Packet " + (j + 2) / 2 + ": Orignal: " + raidArray[j] + " , " + "Raid: " + raidArray[j + 1]);
                j = j + 2;
            }

            try {
                dListOfFiles = FileData.ReadSPFile(Despath, count, raidArray);

                for (MYSpFile file2 : dListOfFiles) {
                    dbConnect.saveSPFiles(file2.getFid(), file2.getName(), file2.getSize(),
                            file2.getHash(), file2.getCloud(), file2.getRCloud()/*, file2.getRemotePath()*/);
                }
                backplogger.info("Save split file details to the database. ");
            } catch (Exception e) {
                backplogger.error("Database connection error : " + e);
            }

            

                    backplogger.info("Uploading " + file.getName() + " to cloud 1.");
                    Sftp.upload(dest + Global.fs + file.getName());

                    backplogger.info("Uploading " + file.getName() + " to cloud 2.");
                    Sftp.upload1(dest + Global.fs + file.getName());

                    backplogger.info("Uploading " + file.getName() + " to cloud 3.");
                    Sftp.upload2(dest + Global.fs + file.getName());


        }

        backplogger.info("Split " + noOfFiles + " Files in the file path of : " + path);

        return 0;
    }

    public static void compressFile(String path)throws Exception{

        String D_path  =path+ ".zip";

        ZipOutputStream out = new ZipOutputStream(new
                BufferedOutputStream(new FileOutputStream(D_path)));
        byte[] data = new byte[1000];
        BufferedInputStream in = new BufferedInputStream(new FileInputStream(path));
        int count;
        out.putNextEntry(new ZipEntry("outFile.zip"));
        while((count = in.read(data,0,1000)) != -1)
        {
            out.write(data, 0, count);
        }
        in.close();
        out.flush();

        System.out.println("Your file is zipped");

    }

    public static String CreateFolder(String path)throws Exception{

        String fldate;

        DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        java.util.Date date = new java.util.Date();
        fldate = dateFormat.format(date);

        String strDirectoy =path+ "/" +fldate;

        // Create one directory
        boolean success = (
                new File(strDirectoy)).mkdir();
        if (success) {
            System.out.println("Directory: " + strDirectoy + " created");
            logger.info("Directory: " + strDirectoy + " created");
        }

        return strDirectoy;
    }

    public static void copy(int mode, String inputFile, String outputFile, String password) throws Exception {

        BufferedInputStream is = new BufferedInputStream(new FileInputStream(inputFile));
        BufferedOutputStream os = new BufferedOutputStream(new FileOutputStream(outputFile));
        if(mode==Cipher.ENCRYPT_MODE){
            encrypt(is, os, password);
        }
        else if(mode==Cipher.DECRYPT_MODE){
            //decrypt(is, os, password);
        }
        else throw new Exception("unknown mode");
        is.close();
        os.close();
    }

    public static void encrypt(InputStream in, OutputStream out, String password) throws Exception{

        SecureRandom r = new SecureRandom();
        byte[] iv = new byte[IV_LENGTH];
        r.nextBytes(iv);
        out.write(iv); //write IV as a prefix
        out.flush();
        //System.out.println(">>>>>>>>written"+Arrays.toString(iv));

        Cipher cipher = Cipher.getInstance("AES/CFB8/NoPadding"); //"DES/ECB/PKCS5Padding";"AES/CBC/PKCS5Padding"
        SecretKeySpec keySpec = new SecretKeySpec(password.getBytes(), "AES");
        IvParameterSpec ivSpec = new IvParameterSpec(iv);
        cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);

        out = new CipherOutputStream(out, cipher);
        byte[] buf = new byte[1024];
        int numRead = 0;
        while ((numRead = in.read(buf)) >= 0) {
            out.write(buf, 0, numRead);
        }
        out.close();
    }


}
