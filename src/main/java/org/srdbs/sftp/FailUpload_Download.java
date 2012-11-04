package org.srdbs.sftp;

import com.jcraft.jsch.*;
import org.apache.log4j.Logger;
import org.srdbs.core.DbConnect;
import org.srdbs.core.Global;
import org.srdbs.core.RunBackup;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;


/**
 * Created by IntelliJ IDEA.
 * User: Prabodha
 * Date: 7/14/12
 * Time: 7:08 PM
 * To change this template use File | Settings | File Templates.
 */
public class FailUpload_Download {

    public static Logger logger = Logger.getLogger("systemsLog");
    public static Logger backplogger = Logger.getLogger("backupLog");
    public static Logger restoreLog = Logger.getLogger("restoreLog");

    public static void getFile() {


        List getFailFiles = new DbConnect().selectLoadFailQuery();

        if (!getFailFiles.isEmpty()) {
            for (int i = 0; i < getFailFiles.size(); ) {
                if (Integer.parseInt(getFailFiles.get(i + 1).toString()) == 1) {
                    boolean up = Sftp.ping(Global.c1IPAddress, Global.c1Port);
                    if (up == true) {
                        failUploadC1(getFailFiles.get(i).toString(), getFailFiles.get(i + 2).toString(), getFailFiles.get(i + 3).toString());
                    }
                }

                if (Integer.parseInt(getFailFiles.get(i + 1).toString()) == 2) {
                    boolean up1 = Sftp.ping(Global.c2IPAddress, Global.c2Port);
                    if (up1 == true) {
                        failUploadC2(getFailFiles.get(i).toString(), getFailFiles.get(i + 2).toString(), getFailFiles.get(i + 3).toString());
                    }
                }
                if (Integer.parseInt(getFailFiles.get(i + 1).toString()) == 3) {
                    boolean up2 = Sftp.ping(Global.c3IPAddress, Global.c3Port);
                    if (up2 == true) {
                        failUploadC3(getFailFiles.get(i).toString(), getFailFiles.get(i + 2).toString(), getFailFiles.get(i + 3).toString());
                    }
                }
                i = i + 4;
            }

            boolean FolDel= deleteDir(new File(Global.failfileLocation)) ;
            backplogger.info("Folder Deletion : " + FolDel);
        }

        else {
                 backplogger.info("No Fail files in Database");

        }
    }

    public static int failUploadC1(String fid, String file, String path) {
        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;
        long Fid = Long.parseLong(fid);
        long fsize;

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
            channelSftp.cd(Global.c1Remotepath + "/" + path);

            File f = new File(file);
            FileInputStream F1 = new FileInputStream(f);
            channelSftp.put(F1, f.getName(), new SystemOutProgressMonitor());
            String temp[] = f.toString().split("\\\\");

            DbConnect dbconnect = new DbConnect();
            fsize= dbconnect.pSize(Fid, f.getName());
            dbconnect.saveUploadSPFiles(Fid, temp[temp.length - 1], path, 1);
            dbconnect.SaveCloud1(Fid,temp[temp.length-1],Global.c1Remotepath + "/" + path,fsize);
            dbconnect.deleteFile(Fid, file);

            backplogger.info("Upload file: "+ f.getName() +" Completed");
            channelSftp.exit();
            session.disconnect();
            F1.close();
            return 0;
        }

        catch (Exception ex) {

    
            try{
                channelSftp.mkdir(Global.c1Remotepath + "/" + path);
                channelSftp.cd(Global.c1Remotepath + "/" + path);
                failUploadC1(fid, file, path);
            }
            catch(Exception e1){
                
                backplogger.error("Error in fail upload ");
            }

            return 10;
        }
    }

    public static int failUploadC2(String fid, String file, String path) {
        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;
        long Fid = Long.parseLong(fid);
        long fsize;
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
            channelSftp.cd(Global.c2Remotepath + "/" + path);

            File f = new File(file);
            FileInputStream F1 = new FileInputStream(f);
            channelSftp.put(F1, f.getName(), new SystemOutProgressMonitor());
            String temp[] = f.toString().split("\\\\");

            DbConnect dbconnect = new DbConnect();
            fsize= dbconnect.pSize(Fid, f.getName());
            dbconnect.saveUploadSPFiles(Fid, temp[temp.length - 1], path, 2);
            dbconnect.SaveCloud2(Fid,temp[temp.length-1],Global.c2Remotepath + "/" + path, fsize);
            dbconnect.deleteFile(Fid, file);

            backplogger.info("Upload file: "+ f.getName() +" Completed");
            channelSftp.exit();
            session.disconnect();
            F1.close();
            return 0;

        } catch (Exception ex) {

            //ex.printStackTrace();
            //System.out.println("ERROR-----------");

            try{
                channelSftp.mkdir(Global.c2Remotepath + "/" + path);
                channelSftp.cd(Global.c2Remotepath + "/" + path);
                failUploadC2(fid, file, path);
            }
            catch(Exception e1){
                //e1.printStackTrace();
                backplogger.error("Error in fail upload ");
            }
            return 10;
        }
    }

    public static int failUploadC3(String fid, String file, String path) {
        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;
        long Fid = Long.parseLong(fid);
        long fsize;

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
            channelSftp.cd(Global.c3Remotepath + "/" + path);

            File f = new File(file);
            FileInputStream F1 = new FileInputStream(f);
            channelSftp.put(F1, f.getName(), new SystemOutProgressMonitor());
            String temp[] = f.toString().split("\\\\");

            DbConnect dbconnect = new DbConnect();
            fsize= dbconnect.pSize(Fid, f.getName());
            dbconnect.saveUploadSPFiles(Fid, temp[temp.length - 1], path, 3);
            dbconnect.SaveCloud3(Fid,temp[temp.length-1],Global.c3Remotepath + "/" + path, fsize);
            dbconnect.deleteFile(Fid, file);

            backplogger.info("Upload file: "+ f.getName() +" Completed");
            channelSftp.exit();
            session.disconnect();
            F1.close();
            return 0;

        } catch (Exception ex) {

            //ex.printStackTrace();
            //System.out.println("ERROR-----------");

            try{
                channelSftp.mkdir(Global.c3Remotepath + "/" + path);
                channelSftp.cd(Global.c3Remotepath + "/" + path);
                failUploadC3(fid, file, path);
            }
            catch(Exception e1){
                //e1.printStackTrace();
                backplogger.error("Error in fail upload ");
            }
            return 10;
        }


    }

    public static int failDownload(String Fname, String Rpath, int Cloud) {

        String uName = "";
        String host = "";
        int port = 22;
        String password = "";
        String serverPath = "";
        JSch jsch = new JSch();
        Session session = null;


        if (Cloud == 1) {


            host = Global.c1IPAddress;
            uName = Global.c1UserName;
            port = Global.c1Port;
            password = Global.c1Password;
            serverPath = Global.c1Remotepath;


        }

        if (Cloud == 2) {
            host = Global.c2IPAddress;
            uName = Global.c2UserName;
            port = Global.c2Port;
            password = Global.c2Password;
            serverPath = Global.c2Remotepath;

        }

        if (Cloud == 3) {
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
            sftpChannel.get(serverPath + "/" + Rpath + "/" + Fname, Global.restoreLocation);

            sftpChannel.exit();
            session.disconnect();
            restoreLog.info("Successfully download the file : " + serverPath + "/" + Rpath + "/" + Fname);
            return 0;

        } catch (Exception e) {
            restoreLog.error("Error on downloading file : " + serverPath + "/" + Rpath + "/" + Fname);
            return -1;
        }
    }

    public static boolean deleteDir(File directory) {
        if(directory.exists()){
            File[] files = directory.listFiles();
            if(null!=files){
                for(int i=0; i<files.length; i++) {
                    if(files[i].isDirectory()) {
                        File[] files1 = files[i].listFiles();
                        for(int j=0; j<files1.length;j++)
                        {
                            files1[j].delete();
                        }
                            files[i].delete();
                    }

                    else {
                        files[i].delete();
                    }
                }
            }
        }
        return true;
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
