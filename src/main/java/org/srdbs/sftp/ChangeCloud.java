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
 * Date: 7/18/12
 * Time: 1:52 PM
 * To change this template use File | Settings | File Templates.
 */
public class ChangeCloud {

    public static List ChangeFiles;;

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
                }

                if(Integer.parseInt(ChangeFiles.get(1).toString())== 1)
                {
                    ChangeDownload(getChangeFiles.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(0).toString()),ChangeFiles.get(2).toString());
                }

                 i=i+2;
            }
            ChangeUpload(getChangeFiles,1,ChangeFiles.get(2).toString());


        }

        if(cloudID == 2)
        {
            List getChangeFiles =  new DbConnect().ChangeC2();
            for(int i=0; i<getChangeFiles.size();)
            {
                List ChangeFiles =  new DbConnect().CheckSP(Long.parseLong(getChangeFiles.get(i).toString()),getChangeFiles.get(i+1).toString());

                if(Integer.parseInt(ChangeFiles.get(0).toString())== 2)
                {
                    ChangeDownload(getChangeFiles.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(1).toString()),ChangeFiles.get(2).toString());
                }

                if(Integer.parseInt(ChangeFiles.get(1).toString())== 2)
                {
                    ChangeDownload(getChangeFiles.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(0).toString()),ChangeFiles.get(2).toString());
                }

                i=i+2;
            }
            ChangeUpload(getChangeFiles,2,ChangeFiles.get(2).toString());
        }

        if(cloudID == 3)
        {
            List getChangeFiles =  new DbConnect().ChangeC3();
            for(int i=0; i<getChangeFiles.size();)
            {
                List ChangeFiles =  new DbConnect().CheckSP(Long.parseLong(getChangeFiles.get(i).toString()),getChangeFiles.get(i+1).toString());

                if(Integer.parseInt(ChangeFiles.get(0).toString())== 3)
                {
                    ChangeDownload(getChangeFiles.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(1).toString()),ChangeFiles.get(2).toString());
                }

                if(Integer.parseInt(ChangeFiles.get(1).toString())== 3)
                {
                    ChangeDownload(getChangeFiles.get(i+1).toString(),Integer.parseInt(ChangeFiles.get(0).toString()),ChangeFiles.get(2).toString());
                }

                i=i+2;
            }
            ChangeUpload(getChangeFiles,3,ChangeFiles.get(2).toString());
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
            sftpChannel.get(serverPath + "/" + remotePath + "/" + fileName, Global.restoreLocation);
            sftpChannel.exit();
            session.disconnect();
            return 0;

        } catch (Exception e) {
            return -1;
        }
    }


    public static int  ChangeUpload(List fileName, int cloud, String remotePath)
    {
        System.out.print("=============================");
        System.out.print(fileName);
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
            channelSftp.mkdir(serverPath + "/" + remotePath);
            channelSftp.cd(serverPath + "/" + remotePath);

        for(int k=0; k<fileName.size();)
        {
            File f = new File(Global.restoreLocation + "/" + fileName.get(k+1));
            channelSftp.put(new FileInputStream(f), f.getName());
            System.out.print(f);
            f.delete();
            k=k+2;
        }

            channelSftp.exit();
            session.disconnect();

            return 0;
        } catch (Exception ex) {
            return 10;
        }

    }
}



