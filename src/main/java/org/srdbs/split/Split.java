package org.srdbs.split;

import org.apache.log4j.Logger;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

/**
 * Split files.
 *
 * @author Thilina Piyasundara
 * @version 0.1
 */
public class Split {

    public static Logger logger = Logger.getLogger("systemsLog");
    public static Logger backplogger = Logger.getLogger("backupLog");

    public static int mySplit(String sourcePath, String destPath, int fileSize) {

        char c = '\u05A0';
        Integer ainteger[];
        ainteger = new Integer[1];
        ainteger[0] = new Integer(fileSize);

        return split(sourcePath, destPath, ainteger);
    }

    static int split(String s, String s1, Integer ainteger[]) {
        int i = 0;
        char c = '\u0400';
        int j = 0;
        int k = 0;
        int l = 0;
        int i1 = 0;
        int j1 = 0;
        byte abyte0[] = new byte[c];
        FileInputStream fileinputstream = null;
        FileOutputStream fileoutputstream = null;
        Object obj = null;
        String s2 = "";
        long l1 = 0L;
        long l2 = System.currentTimeMillis();

        try {
            fileinputstream = new FileInputStream(s);
            backplogger.info("Reading file : " + s);
        } catch (Exception e) {
            backplogger.error("Error opening input file: " + e);
            return 10;
        }

        try {
            while ((l = fileinputstream.read(abyte0)) > 0) {
                if (k++ == ainteger[i].intValue() || j == 0) {
                    if (j > 0) {
                        k = 1;
                        try {
                            fileoutputstream.close();
                            if (i < ainteger.length - 1)
                                i++;
                        } catch (Exception exception1) {
                            backplogger.error("ex2: " + exception1);
                        }
                    }
                    String s3 = s1 + createSuffix(++j);
                    try {
                        File file = new File(s3);
                        fileoutputstream = new FileOutputStream(file);
                    } catch (Exception exception4) {
                        backplogger.error("Error opening output file: " + exception4);
                        return 10;
                    }
                }
                i1 += l;
                j1 += l;
                fileoutputstream.write(abyte0, 0, l);
            }
        } catch (Exception exception2) {
            backplogger.error("ex1: " + exception2);
        }

        try {
            fileinputstream.close();
            fileoutputstream.close();
        } catch (Exception e) {
            backplogger.error("ex4: " + e);
        }
        l1 = System.currentTimeMillis() - l2;
        backplogger.info("Done!");
        backplogger.info("bytes read: " + String.valueOf(i1) + " bytes written: " + String.valueOf(j1));
        backplogger.info("parts created: " + j);
        backplogger.info("time used: " + String.valueOf(l1 / 1000L) + "." + String.valueOf(l1 % 1000L) + " sec.");
        return j;
    }

    public static String createSuffix(int i) {
        String s;
        for (s = String.valueOf(i); s.length() < 3; s = "0" + s) ;
        return "." + s;
    }
}
