package org.srdbs.scheduler;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
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
            Sender.sendMessage("127.0.0.1", "55555", "request");
        } catch (Exception e) {
            logger.error("Error on the message service of the cloud : " + "127.0.0.1");
        }
    }
}
