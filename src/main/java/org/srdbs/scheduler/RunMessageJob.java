package org.srdbs.scheduler;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.srdbs.core.Global;
import org.srdbs.messenger.Sender;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 7/17/12
 * Time: 11:36 AM
 * For more details visit : http://www.thilina.org
 */
public class RunMessageJob implements Job {

    public static Logger logger = Logger.getLogger("backupLog");

    public static String cloud1 = "";
    public static String cloud2 = "";
    public static String cloud3 = "";



    public void execute(JobExecutionContext context) throws JobExecutionException {

        logger.info("Sending periodic message to check the availability of the messaging service on clouds.");
        try {
            Sender.sendMessage(Global.c1IPAddress, Global.c1MessagePort, "status");
            cloud1 = "live";
            logger.info("cloud1 live ");

        } catch (Exception e) {
            cloud1 = "down";
            logger.info("cloud1 down ");
            retryStatus(Global.c1IPAddress, Global.c1MessagePort);
        }

        try {
            Sender.sendMessage(Global.c2IPAddress, Global.c2MessagePort, "status");
            cloud2 = "live";
            logger.info("cloud2 live ");

        } catch (Exception e) {
            cloud2 = "down";
            logger.info("cloud2 down ");
            retryStatus(Global.c2IPAddress, Global.c2MessagePort);
        }

        try {
            Sender.sendMessage(Global.c3IPAddress, Global.c3MessagePort, "status");
            cloud3 = "live";
            logger.info("cloud3 live ");

        } catch (Exception e) {
            cloud3 = "down";
            logger.info("cloud3 down ");
            retryStatus(Global.c3IPAddress, Global.c3MessagePort);
        }
    }

    public void retryStatus(String cloudIPAddress, int messagePort) {

        int count = 1;
        boolean status = false;

        while (count <= 5 && !status) {
            try {
                Thread.sleep(40 * 1000);  // in milliseconds
                Sender.sendMessage(cloudIPAddress, messagePort, "status");
                status = true; // if there's no exception, change the status in to true.
            } catch (Exception e) {
                count++;
            }
        }

        if (!status) {
            logger.error("Cloud message service on : " + cloudIPAddress + ":"
                    + messagePort + " failed after " + (count - 1) + " attempts.");
        }
    }
}
