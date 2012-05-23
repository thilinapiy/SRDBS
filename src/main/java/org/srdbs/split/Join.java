package org.srdbs.split;

import org.apache.log4j.Logger;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/23/12
 * Time: 1:44 PM
 * For more details visit : http://www.thilina.org
 */
public class Join {

    public static Logger logger = Logger.getLogger("systemsLog");

    public static String myJoin(String path) {

        int ret = join(path, path);

        if (ret == 0)
            return "Join successful.";
        else
            return "Error.";
    }

    public static int join(String s, String s1) {
        int i = 0x10000;
        int j = 1;
        int k = 0;
        int l = 0;
        int i1 = 0;
        byte abyte0[] = new byte[i];
        Object obj = null;
        FileOutputStream fileoutputstream = null;
        File file = null;
        String s2 = "";
        long l1 = 0L;
        long l2 = System.currentTimeMillis();
        try {
            file = new File(s1);
            fileoutputstream = new FileOutputStream(file);
        } catch (Exception exception) {
            logger.info("Error opening output: " + exception.toString());
            return 10;
        }
        try {
            do {
                String s3 = s + createSuffix(j++);
                FileInputStream fileinputstream = new FileInputStream(s3);
                while ((k = fileinputstream.read(abyte0)) > 0) {
                    l += k;
                    try {
                        fileoutputstream.write(abyte0, 0, k);
                        i1 += k;
                    } catch (Exception exception3) {
                        logger.error("Error writing to output: " + exception3.toString());
                        return 10;
                    }
                }
                fileinputstream.close();
            } while (true);
        } catch (Exception exception1) {
            System.out.println("No more files to join: " + exception1.toString());
        }
        j--;
        try {
            fileoutputstream.close();
        } catch (Exception exception2) {
            System.out.println("Error closing output: " + exception2.toString());
        }
        if (k == 0 && j == 1) {
            file.delete();
            System.out.println("Error opening input file: Nothing to join.\n");
            return 5;
        } else {
            long l3 = System.currentTimeMillis() - l2;
            logger.info("Done!\n\n");
            logger.info("bytes read: " + String.valueOf(l) + "\nbytes written: " + String.valueOf(i1) + "\n");
            logger.info("time used: " + String.valueOf(l3 / 1000L) + "." + String.valueOf(l3 % 1000L) + " sec.\n");
            return 0;
        }
    }

    static String createSuffix(int i) {
        String s;
        for (s = String.valueOf(i); s.length() < 3; s = "0" + s) ;
        return "." + s;
    }
}
