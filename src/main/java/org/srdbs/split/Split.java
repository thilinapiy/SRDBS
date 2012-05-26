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

    public static int mySplit(String sourcePath, String destPath, int fileSize) {

        char c = '\u05A0';
        Integer ainteger[];
        ainteger = new Integer[1];
        ainteger[0] = new Integer(fileSize);

        return split(sourcePath, destPath, ainteger);
    }

    public static int mySplit(String sourcePath, String destPath) {

        char c = '\u05A0';
        Integer ainteger[];
        ainteger = new Integer[1];
        ainteger[0] = new Integer(c);

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
        } catch (Exception exception) {
            logger.error("Error opening input file: " + exception);
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
                            logger.error("ex2: " + exception1);
                        }
                    }
                    String s3 = s1 + createSuffix(++j);
                    try {
                        File file = new File(s3);
                        fileoutputstream = new FileOutputStream(file);
                    } catch (Exception exception4) {
                        logger.error("Error opening output file: " + exception4);
                        return 10;
                    }
                }
                i1 += l;
                j1 += l;
                fileoutputstream.write(abyte0, 0, l);
            }
        } catch (Exception exception2) {
            logger.error("ex1: " + exception2);
        }

        try {
            fileinputstream.close();
            fileoutputstream.close();
        } catch (Exception exception3) {
            logger.error("ex4: " + exception3);
        }
        l1 = System.currentTimeMillis() - l2;
        logger.info("Done!\n\n");
        logger.info("bytes read: " + String.valueOf(i1) + " \nbytes written: " + String.valueOf(j1) + "\n");
        logger.info("parts created: " + j + "\n");
        logger.info("time used: " + String.valueOf(l1 / 1000L) + "." + String.valueOf(l1 % 1000L) + " sec.\n");
        return j;
    }

    static String createSuffix(int i) {
        String s;
        for (s = String.valueOf(i); s.length() < 3; s = "0" + s) ;
        return "." + s;
    }
}
