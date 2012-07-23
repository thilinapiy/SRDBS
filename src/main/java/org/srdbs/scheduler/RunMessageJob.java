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

        try {
            Sender.sendMessage(Global.c1IPAddress, Global.c1MessagePort, "request");
        } catch (Exception e) {
            logger.error("Error on the message service of the cloud : " + Global.c1IPAddress + e);
        }

        try {
            Sender.sendMessage(Global.c2IPAddress, Global.c2MessagePort, "request");
        } catch (Exception e) {
            logger.error("Error on the message service of the cloud : " + Global.c2IPAddress + e);
        }

        try {
            Sender.sendMessage(Global.c3IPAddress, Global.c3MessagePort, "request");
        } catch (Exception e) {
            logger.error("Error on the message service of the cloud : " + Global.c3IPAddress + e);
        }
    }
}
