package org.srdbs.sftp;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.srdbs.core.Global;
import org.srdbs.split.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

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


    public static int upload(String sftpIP, String sftpUser, String sftpPasswd, int sftpPort, String remotePath, String file, int cID)
    {

        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;
        int ftpFileNo=0;

        try {
            JSch jsch = new JSch();
            session = jsch.getSession(sftpUser, sftpIP, sftpPort);
            session.setPassword(sftpPasswd);
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
            session.connect();
            channel = session.openChannel("sftp");
            channel.connect();
            channelSftp = (ChannelSftp) channel;
            channelSftp.mkdir(remotePath);
            channelSftp.cd(remotePath);

        if(cID==1)
        {
            for(int i=0; i < cloud1.size(); i++ )
            {
               ftpFileNo=cloud1.get(i);
               File f = new File(file + Split.createSuffix(ftpFileNo));

                backplogger.info("File name :" + f );
                channelSftp.put(new FileInputStream(f), f.getName());
                backplogger.info("Send the file.");
            }
        }
        if(cID==2)
        {
            for(int i=0; i < cloud2.size(); i++ )
            {
                    ftpFileNo=cloud2.get(i);
                    File f = new File(file + Split.createSuffix(ftpFileNo));

                    backplogger.info("File name :" + f );
                    channelSftp.put(new FileInputStream(f), f.getName());
                    backplogger.info("Send the file.");
            }
        }
        if(cID==3)
        {
        for(int i=0; i < cloud3.size(); i++ )
        {
                ftpFileNo=cloud3.get(i);
                File f = new File(file + Split.createSuffix(ftpFileNo));

                backplogger.info("File name :" + f );
                channelSftp.put(new FileInputStream(f), f.getName());
                backplogger.info("Send the file.");
        }
        }

                channelSftp.exit();
            session.disconnect();


            return 0;
        } catch (Exception ex) {
            backplogger.error("Ftp upload error on IP : " + sftpIP + " more details :" + ex);
            backplogger.error("IP : " + sftpIP + ", " + sftpPort + ", " + sftpUser + ", "
                    + sftpPasswd + ", " + file + " upload to " + remotePath);
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
}
