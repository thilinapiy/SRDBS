package org.srdbs.sftp;

import com.jcraft.jsch.*;
import org.apache.log4j.Logger;
import org.srdbs.core.DbConnect;
import org.srdbs.core.Global;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Prabodha
 * Date: 7/18/12
 * Time: 1:52 PM
 * To change this template use File | Settings | File Templates.
 */
public class ChangeCloud {

    public static Logger logger = Logger.getLogger("systemsLog");
    public static Logger backplogger  = Logger.getLogger("backupLog");
    public static List ChangeFiles;

    public static void ChangeCloud(int cloudID)
    {
        if(cloudID == 1)
        {
            List getChangeFiles =  new DbConnect().ChangeC1();

            for(int i=0; i<getChangeFiles.size();)
            {

                ChangeFiles =  new DbConnect().CheckSP(Long.parseLong(getChangeFiles.get(i).toString()),getChangeFiles.get(i+1).toString());

                if(Integer.parseInt(ChangeFiles.get(0).toString())== 1)
                {
                    ChangeDownload(getChangeFiles.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(1).toString()),ChangeFiles.get(2).toString());
                    backplogger.info("Download Completed from Cloud " + Integer.parseInt(ChangeFiles.get(1).toString()));
                }

                if(Integer.parseInt(ChangeFiles.get(1).toString())== 1)
                {
                    ChangeDownload(getChangeFiles.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(0).toString()),ChangeFiles.get(2).toString());
                    backplogger.info("Download Completed from Cloud " + Integer.parseInt(ChangeFiles.get(0).toString()));
                }

                ChangeUpload(getChangeFiles.get(i+1).toString(),1,ChangeFiles.get(2).toString());
                i=i+2;
            }


        }

        if(cloudID == 2)
        {
            List getChangeFiles1 =  new DbConnect().ChangeC2();
            for(int i=0; i<getChangeFiles1.size();)
            {
                List ChangeFiles =  new DbConnect().CheckSP(Long.parseLong(getChangeFiles1.get(i).toString()),getChangeFiles1.get(i+1).toString());

                if(Integer.parseInt(ChangeFiles.get(0).toString())== 2)
                {
                    ChangeDownload(getChangeFiles1.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(1).toString()),ChangeFiles.get(2).toString());
                    backplogger.info("Download Completed from Cloud " + Integer.parseInt(ChangeFiles.get(1).toString()));
                }

                if(Integer.parseInt(ChangeFiles.get(1).toString())== 2)
                {
                    ChangeDownload(getChangeFiles1.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(0).toString()),ChangeFiles.get(2).toString());
                    backplogger.info("Download Completed from Cloud " + Integer.parseInt(ChangeFiles.get(0).toString())) ;
                }
                ChangeUpload(getChangeFiles1.get(i+1).toString(),2,ChangeFiles.get(2).toString());
                i=i+2;
            }

        }

        if(cloudID == 3)
        {
            List getChangeFiles2 =  new DbConnect().ChangeC3();
            for(int i=0; i<getChangeFiles2.size();)
            {
                List ChangeFiles =  new DbConnect().CheckSP(Long.parseLong(getChangeFiles2.get(i).toString()),getChangeFiles2.get(i+1).toString());

                if(Integer.parseInt(ChangeFiles.get(0).toString())== 3)
                {
                    ChangeDownload(getChangeFiles2.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(1).toString()),ChangeFiles.get(2).toString());
                    backplogger.info("Download Completed from Cloud " + Integer.parseInt(ChangeFiles.get(1).toString()));
                }

                if(Integer.parseInt(ChangeFiles.get(1).toString())== 3)
                {
                    ChangeDownload(getChangeFiles2.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(0).toString()),ChangeFiles.get(2).toString());
                    backplogger.info("Download Completed from Cloud " + Integer.parseInt(ChangeFiles.get(0).toString()));
                }

                ChangeUpload(getChangeFiles2.get(i+1).toString(),3,ChangeFiles.get(2).toString());
                i=i+2;
            }

        }


    }


    public static int ChangeDownload(String fileName, int cloud, String remotePath)
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
            sftpChannel.get(serverPath + "/" + remotePath + "/" + fileName, Global.restoreLocation, new SystemOutProgressMonitor());
            backplogger.info(fileName +"Download Completed");
            sftpChannel.exit();
            session.disconnect();
            return 0;

        } catch (Exception e) {
            backplogger.error(fileName +"Download Failed");
            return -1;
        }
    }


    public static int  ChangeUpload(String fileName, int cloud, String remotePath)
    {
        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;

        String uName = "";
        String host = "";
        int port = 22;
        String password = "";
        String serverPath = "";

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
            JSch jsch = new JSch();
            session = jsch.getSession(uName, host, port);
            session.setPassword(password);
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
            session.connect();
            channel = session.openChannel("sftp");
            channel.connect();
            channelSftp = (ChannelSftp) channel;

            try{
                channelSftp.cd(serverPath + "/" + remotePath);

            }
            catch (Exception e)
            {
                channelSftp.mkdir(serverPath + "/" + remotePath);
                channelSftp.cd(serverPath + "/" + remotePath);
            }
                File f = new File(Global.restoreLocation + "/" + fileName);
                FileInputStream F1 = new FileInputStream(f);
                channelSftp.put(F1, f.getName(), new SystemOutProgressMonitor());

                backplogger.info(f.getName()+ "Upload Completed");
                F1.close();
                f.delete();


            channelSftp.exit();
            session.disconnect();

            return 0;
        } catch (Exception ex) {
            backplogger.info("Upload Failed");
            return 10;
        }

    }

    public static class SystemOutProgressMonitor implements SftpProgressMonitor {
        public SystemOutProgressMonitor() {
            ;
        }

        public void init(int op, java.lang.String src, java.lang.String dest, long max) {
            System.out.println("STARTING: " + op + " " + src + " -> " + dest + " total: " + max);
        }

        public boolean count(long bytes) {
            for (int x = 0; x < bytes; ) {
                System.out.print("#");
                x = x + 5000000;
            }
            return (true);
        }

        public void end() {
            System.out.println("\nFINISHED!");
        }

    }
}



