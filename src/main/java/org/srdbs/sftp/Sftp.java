package org.srdbs.sftp;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.srdbs.core.Global;
import org.srdbs.split.*;
import org.srdbs.core.DbConnect;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.*;
import java.net.*;
import java.lang.String;

/**
 * Creating the secure ftp channels.
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Sftp {

    public static Logger logger = Logger.getLogger("systemsLog");
    public static Logger backplogger = Logger.getLogger("backupLog");
    public static Logger restoreLog = Logger.getLogger("restoreLog");

    public static List<Integer> cloud1 = new ArrayList<Integer>();
    public static List<Integer> cloud2 = new ArrayList<Integer>();
    public static List<Integer> cloud3 = new ArrayList<Integer>();

    public static int count1=0;
    public static int count2=0;
    public static int count3=0;


    /**
     * This is a test method
     */
    public static int copyFile(String sourcePath, String destPath)
    {

        String msg = "";
        File source = new File(sourcePath);
        File desc = new File(destPath);
        try {
            //FileUtils.copyFile(source,desc);
            FileUtils.copyDirectory(source, desc);
            logger.info("File copied from : " + sourcePath);
            return 0;
        } catch (IOException e) {
            logger.error("Error in copy file : " + e);
            return 10;
        }
    }


    public static int upload(String file, long fID, String rPath)
    {

        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;
        int ftpFileNo=0;
        long fid=fID;

        try {
            JSch jsch = new JSch();
            session = jsch.getSession(Global.c1UserName, Global.c1IPAddress, Global.c1Port);
            session.setPassword(Global.c1Password);
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
            session.connect();
            channel = session.openChannel("sftp");
            channel.connect();
            channelSftp = (ChannelSftp) channel;
            channelSftp.mkdir(Global.c1Remotepath + "/" + rPath);
            channelSftp.cd(Global.c1Remotepath + "/" + rPath);

            for(int i=cloud1.size()-1;i>=0;i--)
            {
               ftpFileNo=cloud1.get(i);
               File f = new File(file + Split.createSuffix(ftpFileNo));
                backplogger.info("File name :" + f );
                channelSftp.put(new FileInputStream(f), f.getName());

                backplogger.info("IP : " + Global.c1IPAddress + ", " + Global.c1Port + ", " + Global.c1UserName + ", "
                        + Global.c1Password + ", " + file + " upload to " + Global.c1Remotepath + "/" + rPath);
                backplogger.info("Send the file.");

                cloud1.remove(i);
               backplogger.info(cloud1);

                String temp []=f.toString().split("\\\\");
                DbConnect dbconnect = new DbConnect();
                dbconnect.saveUploadSPFiles(fid,temp[temp.length-1],rPath,1 ) ;
                dbconnect.SaveCloud1(fid, temp[temp.length-1],Global.c1Remotepath + "/" + rPath);

            }
                channelSftp.disconnect();
                session.disconnect();

            return 0;
        } catch (Exception ex) {
            backplogger.error("Ftp upload error on IP : " + Global.c1IPAddress + " more details :" + ex);
            //backplogger.error("IP : " + Global.c1IPAddress + ", " + Global.c1Port + ", " + Global.c2UserName + ", "
                    //+ Global.c1Password + ", " + file + " upload to " + Global.c1Remotepath + "/" + datef.format(date));


            backplogger.info("Retring to upload");
            long startTime = System.currentTimeMillis();
            while((System.currentTimeMillis()-startTime)< 30000)
            {
                if(count1 < 3)
                {
                    boolean server = ping(Global.c1IPAddress,Global.c1Port);
                    if(server == true)
                    {

                        backplogger.info("upload again");
                        backplogger.info(count1);
                        count1++;
                        upload(file,fid,rPath);
                        break;
                    }
                }

            }
            failUploadSave(fid, 1, cloud1, file, rPath);
            return 10;
        }

    }

    public static int upload1(String file, long fID, String rPath)
    {

        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;
        int ftpFileNo=0;
        long fid=fID;
        



        try {
            JSch jsch = new JSch();
            session = jsch.getSession(Global.c2UserName, Global.c2IPAddress, Global.c2Port);
            session.setPassword(Global.c2Password);
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
            session.connect();
            channel = session.openChannel("sftp");
            channel.connect();
            channelSftp = (ChannelSftp) channel;
            channelSftp.mkdir(Global.c2Remotepath + "/" + rPath);
            channelSftp.cd(Global.c2Remotepath + "/" + rPath);

            for(int i=cloud2.size()-1;i>=0;i--)
            {
                ftpFileNo=cloud2.get(i);
                File f = new File(file + Split.createSuffix(ftpFileNo));

                backplogger.info("File name :" + f );
                channelSftp.put(new FileInputStream(f), f.getName());
                backplogger.info("IP : " + Global.c2IPAddress + ", " + Global.c2Port + ", " + Global.c2UserName + ", "
                        + Global.c2Password + ", " + file + " upload to " + Global.c2Remotepath + "/" + rPath);
                backplogger.info("Send the file.");

                cloud2.remove(i);
                backplogger.info(cloud2);

                String temp []=f.toString().split("\\\\");
                DbConnect dbconnect = new DbConnect();
                dbconnect.saveUploadSPFiles(fid,temp[temp.length-1],rPath, 2);
                dbconnect.SaveCloud2(fid,temp[temp.length-1],Global.c2Remotepath + "/" + rPath);

            }
                channelSftp.disconnect();
                session.disconnect();

            return 0;
        } catch (Exception ex) {
            backplogger.error("Ftp upload error on IP : " + Global.c2IPAddress + " more details :" + ex);
            //backplogger.error("IP : " + Global.c2IPAddress + ", " + Global.c2Port + ", " + Global.c2UserName + ", "
                    //+ Global.c2Password + ", " + file + " upload to " + Global.c2Remotepath + "/" + datef.format(date));

            String [] temp=file.split("/");
            backplogger.info(temp[temp.length-1]);

            backplogger.info("Retring to upload");
            long startTime = System.currentTimeMillis();
            while((System.currentTimeMillis()-startTime)< 30000)
            {
                if(count2 < 3)
                {
                    boolean server = ping(Global.c2IPAddress,Global.c2Port);
                    if(server == true)
                    {

                            backplogger.info("upload again");
                            count2++;
                            upload1(file,fid,rPath);
                            break;
                        }
                }

            }

            failUploadSave(fid, 2, cloud2, file, rPath);
            return 10;
        }

    }

    public static int upload2(String file, long fID, String rPath)
    {

        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;
        int ftpFileNo=0;
        long fid=fID;

        try {
            JSch jsch = new JSch();
            session = jsch.getSession(Global.c3UserName, Global.c3IPAddress, Global.c3Port);
            session.setPassword(Global.c3Password);
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
            session.connect();
            channel = session.openChannel("sftp");
            channel.connect();
            channelSftp = (ChannelSftp) channel;
            channelSftp.mkdir(Global.c3Remotepath + "/" + rPath);
            channelSftp.cd(Global.c3Remotepath + "/" + rPath);

            for(int i=cloud3.size()-1;i>=0;i--)
            {
                ftpFileNo=cloud3.get(i);
                File f = new File(file + Split.createSuffix(ftpFileNo));

                backplogger.info("File name :" + f );
                channelSftp.put(new FileInputStream(f), f.getName());
                backplogger.info("IP : " + Global.c3IPAddress + ", " + Global.c3Port + ", " + Global.c3UserName + ", "
                        + Global.c3Password + ", " + file + " upload to " + Global.c3Remotepath + "/" + rPath);
                backplogger.info("Send the file.");

                cloud3.remove(i);
                backplogger.info(cloud3);

                String temp []=f.toString().split("\\\\");
                DbConnect dbconnect = new DbConnect();
                dbconnect.saveUploadSPFiles(fid,temp[temp.length - 1], rPath, 3);
                dbconnect.SaveCloud3(fid,temp[temp.length-1],Global.c3Remotepath + "/" + rPath);
            }
                channelSftp.disconnect();
                session.disconnect();

            return 0;
        } catch (Exception ex) {
            backplogger.error("Ftp upload error on IP : " + Global.c3IPAddress + " more details :" + ex);
            //backplogger.error("IP : " + Global.c3IPAddress + ", " + Global.c3Port + ", " + Global.c3UserName + ", "
                    //+ Global.c3Password + ", " + file + " upload to " + Global.c3Remotepath + "/" + datef.format(date));
            backplogger.info("Retring to upload");
            long startTime = System.currentTimeMillis();
            while((System.currentTimeMillis()-startTime)< 30000)
            {
                if(count3 < 3)
                {
                    boolean server = ping(Global.c3IPAddress,Global.c3Port);
                    if(server== true)
                    {

                            backplogger.info("upload again");
                            count3++;
                            upload2(file, fid,rPath);
                            break;
                    }
                }
            }

            failUploadSave(fid, 3, cloud3, file, rPath);
            return 10;
        }

    }

    public static int download(String fileName, int cloud, String remotePath)
    {

        String uName = "";
        String host = "";
        int port = 22;
        String password = "";
        String serverPath = "";

        JSch jsch = new JSch();
        Session session = null;

        if (cloud == 1) {
            host = Global.c1IPAddress;
            uName = Global.c1UserName;
            port = Global.c1Port;
            password = Global.c1Password;
            serverPath = Global.c1Remotepath;
        }

        if (cloud == 2) {
            host = Global.c2IPAddress;
            uName = Global.c2UserName;
            port = Global.c2Port;
            password = Global.c2Password;
            serverPath = Global.c2Remotepath;
        }

        if (cloud == 3) {
            host = Global.c3IPAddress;
            uName = Global.c3UserName;
            port = Global.c3Port;
            password = Global.c3Password;
            serverPath = Global.c3Remotepath;
        }

        try {
            session = jsch.getSession(uName, host, port);
            session.setConfig("StrictHostKeyChecking", "no");
            session.setPassword(password);
            session.connect();

            Channel channel = session.openChannel("sftp");
            channel.connect();
            ChannelSftp sftpChannel = (ChannelSftp) channel;
            sftpChannel.get(serverPath + "/" + remotePath + "/" + fileName, Global.restoreLocation);
            sftpChannel.exit();
            session.disconnect();
            restoreLog.info("Successfully download the file : " + serverPath + "/" + remotePath + "/" + fileName);
            return 0;

        } catch (Exception e) {
            restoreLog.error("Error on downloading file : " + serverPath + "/" + remotePath + "/" + fileName
                    + " from : " + uName + "@" + host + ":" + port);
            return -1;
        }
    }


    // TODO write method 3 methods for RAID. Prabodha
    public static int[] raid(int pNumber)
    {

        int numberOfClouds = 3;
        int[] raidArray = new int[2 * pNumber];
        int i = 0;

        do {
            int o = getRandomCloud(numberOfClouds);
            int r = getRandomCloud(numberOfClouds);

            while (o == r) {
                r = getRandomCloud(numberOfClouds);
            }
            raidArray[i] = o;
            raidArray[i + 1] = r;

            if(o==1 && r==2 )
            {
                cloud1.add((i+2)/2);
                cloud2.add((i+2)/2);
            }
            if(o==1 && r==3 )
            {
                cloud1.add((i+2)/2);
                cloud3.add((i+2)/2);
            }
            if(o==2 && r==1 )
            {
                cloud2.add((i+2)/2);
                cloud1.add((i+2)/2);
            }
            if(o==2 && r==3 )
            {
                cloud2.add((i+2)/2);
                cloud3.add((i+2)/2);
            }
            if(o==3 && r==1 )
            {
                cloud3.add((i+2)/2);
                cloud1.add((i+2)/2);
            }
            if(o==3 && r==2 )
            {
                cloud3.add((i+2)/2);
                cloud2.add(((i+2))/2);
            }
            i=i+2;


        }
        while ( i < (pNumber*2) );
        backplogger.info("Raid array completed successfully.");

        return raidArray;

    }

    private static int getRandomCloud(int numberOfClouds)
    {
        return (int) ((Math.random() * 10) % numberOfClouds) + 1;
    }


    // Check Server availability
    public static boolean ping(String ip, int port)
    {
        boolean ping=false;
        try
        {
            Socket mySocket = new Socket(ip,port);
            backplogger.info("Connection to: " + mySocket.getInetAddress());
            ping=true;
        }
        catch (Exception e)
        {
            backplogger.info("Site not found!");
        }
        return ping;
    }

    public static void failUploadSave(long FID, int CloudID, List cloud, String file, String path )
    {
        List<Integer> Ecloud3 = cloud;
        DbConnect dbconnect = new DbConnect();
     try
     {
        for(int l=0; l<cloud.size(); l++)
        {
            File source_file = new File(file + Split.createSuffix(Ecloud3.get(l)));
            dbconnect.ErrorFiles(FID,CloudID,source_file.toString(),path);
        }
         backplogger.info("Save Fail file details to the database. ");
     }catch (Exception ex)
     {
         backplogger.error("Database Error" + ex);
     }

    }

}