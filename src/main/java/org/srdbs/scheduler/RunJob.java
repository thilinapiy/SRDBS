package org.srdbs.scheduler;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.srdbs.core.RunBackup;

import java.util.Date;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/31/12
 * Time: 12:05 PM
 * For more details visit : http://www.thilina.org
 */
public class RunJob implements Job {

    public static Logger logger = Logger.getLogger("systemsLog");

    public void execute(JobExecutionContext context) throws JobExecutionException {

        logger.info("Running the scheduled backup at : " + new Date());
        RunBackup.runBackup("C:\\Users\\Thilina\\Desktop\\ISO\\",
                "E:\\copytest\\",
                524288);
        logger.info("Scheduled backup process ended at : " + new Date());
    }
}
