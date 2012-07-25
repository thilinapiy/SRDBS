package org.srdbs.sftp;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import org.srdbs.core.DbConnect;
import org.srdbs.core.Global;

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
public class FailUpload {

    public static void getFile() {


        List getFailFiles = new DbConnect().selectLoadFailQuery();

        if (!getFailFiles.isEmpty()) {
            for (int i = 0; i < getFailFiles.size(); ) {
                if (Integer.parseInt(getFailFiles.get(i + 1).toString()) == 1) {
                    boolean up = Sftp.ping(Global.c1IPAddress, Global.c1Port);
                    if (up == true) {
                        failUploadC1(getFailFiles.get(i).toString(), getFailFiles.get(i + 2).toString(), getFailFiles.get(i + 3).toString());
                        System.out.println("Upload Done");
                    }
                }

                if (getFailFiles.get(i + 1).toString() == "2") {
                    boolean up1 = Sftp.ping(Global.c2IPAddress, Global.c2Port);
                    if (up1 == true) {
                        failUploadC2(getFailFiles.get(i).toString(), getFailFiles.get(i + 2).toString(), getFailFiles.get(i + 3).toString());
                    }
                }
                if (getFailFiles.get(i + 1).toString() == "3") {
                    boolean up2 = Sftp.ping(Global.c3IPAddress, Global.c3Port);
                    if (up2 == true) {
                        failUploadC3(getFailFiles.get(i).toString(), getFailFiles.get(i + 2).toString(), getFailFiles.get(i + 3).toString());
                    }
                }
                i = i + 4;
            }
        } else
            System.out.print("No files in data base");

    }

    public static int failUploadC1(String fid, String file, String path) {
        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;
        long Fid = Long.parseLong(fid);

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
            channelSftp.cd(Global.c1Remotepath /*+ "/" + path*/);

            File f = new File(file);
            channelSftp.put(new FileInputStream(f), f.getName());
            String temp[] = f.toString().split("\\\\");

            DbConnect dbconnect = new DbConnect();
            dbconnect.saveUploadSPFiles(Fid, temp[temp.length - 1], path, 1);
            dbconnect.SaveCloud1(Fid,temp[temp.length-1],Global.c1Remotepath /*+ "/" + path*/);
            dbconnect.deleteFile(Fid, file);

            channelSftp.exit();
            session.disconnect();

            return 0;
        } catch (Exception ex) {

            ex.printStackTrace();
            System.out.println("ERROR-----------");

            return 10;
        }
    }

    public static int failUploadC2(String fid, String file, String path) {
        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;
        long Fid = Long.parseLong(fid);

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
            channelSftp.cd(Global.c2Remotepath /*+ "/" + path*/);

            File f = new File(file);
            channelSftp.put(new FileInputStream(f), f.getName());
            String temp[] = f.toString().split("\\\\");

            DbConnect dbconnect = new DbConnect();
            dbconnect.saveUploadSPFiles(Fid, temp[temp.length - 1], path, 2);
            dbconnect.SaveCloud2(Fid,temp[temp.length-1],Global.c2Remotepath /*+ "/" + path*/);
            dbconnect.deleteFile(Fid, file);

            channelSftp.exit();
            session.disconnect();

            return 0;
        } catch (Exception ex) {

            ex.printStackTrace();
            return 10;
        }
    }

    public static int failUploadC3(String fid, String file, String path) {
        Session session = null;
        Channel channel = null;
        ChannelSftp channelSftp = null;
        long Fid = Long.parseLong(fid);

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
            channelSftp.cd(Global.c3Remotepath /*+ "/" + path*/);

            File f = new File(file);
            channelSftp.put(new FileInputStream(f), f.getName());
            String temp[] = f.toString().split("\\\\");

            DbConnect dbconnect = new DbConnect();
            //dbconnect.saveUploadSPFiles(Fid, temp[temp.length - 1], path, 3);
            dbconnect.SaveCloud1(Fid,temp[temp.length-1],Global.c3Remotepath /*+ "/" + path*/);
            dbconnect.deleteFile(Fid, file);

            channelSftp.exit();
            session.disconnect();

            return 0;
        } catch (Exception ex) {

            ex.printStackTrace();
            return 10;
        }


    }
}
