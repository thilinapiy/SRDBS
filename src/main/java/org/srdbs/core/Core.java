package org.srdbs.core;

import org.srdbs.sftp.Sftp;
import org.srdbs.web.Web;

/**
 * Main class of the system
 *
 * @version 0.1
 * @author Thilina Piyasundara
 */
public class Core {

    /**
     * This is the main method of the system.
     *
     * @param args
     */
    public static void main(String[] args) {

        if ( args[0].isEmpty()){
            System.exit(-1);
        }
        String arg = args[0].toString();
        System.out.println(arg);
        if ( arg.matches("run")) {

            System.out.println("Hello World!");

            Sftp ftp = new Sftp();
            ftp.main();
            Web wb = new Web();
            try {
                wb.main();
            } catch (Exception e) {
                System.out.println("Error occurred : " + e);
            }
        } else {
            System.out.println("Exiting.");
            System.exit(0);
        }

    }
}
