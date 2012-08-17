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

    public void execute(JobExecutionContext context) throws JobExecutionException {

        logger.info("Sending periodic message to check the availability of the messaging service on clouds.");
        try {
            Sender.sendMessage(Global.c1IPAddress, Global.c1MessagePort, "status");
        } catch (Exception e) {
            retryStatus(Global.c1IPAddress, Global.c1MessagePort);
        }

        try {
            Sender.sendMessage(Global.c2IPAddress, Global.c2MessagePort, "status");
        } catch (Exception e) {
            retryStatus(Global.c2IPAddress, Global.c2MessagePort);
        }

        try {
            Sender.sendMessage(Global.c3IPAddress, Global.c3MessagePort, "status");
        } catch (Exception e) {
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
