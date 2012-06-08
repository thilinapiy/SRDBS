package org.srdbs.sftp;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

/**
 * Creating the secure ftp channels.
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Sftp {

    public static Logger logger = Logger.getLogger("systemsLog");
    public static Logger backplogger = Logger.getLogger("backupLog");

    /**
     * This is a test method
     */
    public static int copyFile(String sourcePath, String destPath) {

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


    public static int upload(String sftpIP, String sftpUser, String sftpPasswd, int sftpPort, String remotePath, String file) {

        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;

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
            File f = new File(file);
            channelSftp.put(new FileInputStream(f), f.getName());
            backplogger.info("Send the file.");

            return 0;
        } catch (Exception ex) {
            backplogger.error("Ftp upload error on IP : " + sftpIP + " more details :" + ex);
            backplogger.error("IP : " + sftpIP + ", " + sftpPort + ", " + sftpUser + ", "
                    + sftpPasswd + ", " + file + " upload to " + remotePath);
            return 10;
        }
    }

    // TODO write method 3 methods for RAID. Prabodha
    public static int[] raid(int pNumber, int c1, int c2, int c3) {

        int numberOfClouds = 3;
        int[] raidArray = new int[2 * pNumber];
        int count1 = (c1 * 2) / 1024;
        int count2 = (c2 * 2) / 1024;
        int count3 = (c3 * 2) / 1024;
        int i = 0;

        backplogger.info("Raid starting with cloud bandwidths : " + count1 + ", " + count2 + ", " + count3 + " number of packets " + 2 * pNumber);
        do {
            int o = getRandomCloud(numberOfClouds);
            int r = getRandomCloud(numberOfClouds);

            while (o == r) {
                r = getRandomCloud(numberOfClouds);
            }
            raidArray[i] = o;
            raidArray[i + 1] = r;
            i = i + 2;

            if (o == 1 && r == 2) {
                count1 = count1 - 1;
                count2 = count2 - 1;
            } else if (o == 1 && r == 3) {
                count1 = count1 - 1;
                count3 = count3 - 1;
            } else if (o == 2 && r == 1) {
                count2 = count2 - 1;
                count1 = count1 - 1;
            } else if (o == 2 && r == 3) {
                count2 = count2 - 1;
                count3 = count3 - 1;
            } else if (o == 3 && r == 1) {
                count3 = count3 - 1;
                count1 = count1 - 1;
            } else if (o == 3 && r == 2) {
                count3 = count3 - 1;
                count2 = count2 - 1;
            }
        }
        while ((count1 + count2 + count3) / 2 > 0);
        backplogger.info("Raid array completed successfully.");
        return raidArray;
    }

    private static int getRandomCloud(int numberOfClouds) {

        return (int) ((Math.random() * 10) % numberOfClouds) + 1;
    }
}
