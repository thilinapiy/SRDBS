package org.srdbs.sftp;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.IOException;

/**
 * Creating the secure ftp channels.
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Sftp {

    public static Logger logger = Logger.getLogger("systemsLog");

    /**
     * This is a test method
     */
    public static String copyFile(String path) {

        String msg = "";
        File source = new File(path);
        File desc = new File("E:\\copytest");
        try {
            //FileUtils.copyFile(source,desc);
            FileUtils.copyDirectory(source, desc);
            msg = "File copied from : " + path;
            logger.info("File copied from : " + path);
        } catch (IOException e) {
            logger.error("Error in copy file : " + e);
            msg = "Error in copy file : " + path;
        }
        return msg;
    }


}
