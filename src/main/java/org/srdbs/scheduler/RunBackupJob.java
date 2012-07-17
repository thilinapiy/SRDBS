package org.srdbs.scheduler;

import org.apache.log4j.Logger;
import org.quartz.*;
import org.srdbs.core.Global;
import org.srdbs.core.RunBackup;

import java.util.Date;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 5/31/12
 * Time: 12:05 PM
 * For more details visit : http://www.thilina.org
 */
public class RunBackupJob implements Job {

    public static Logger logger = Logger.getLogger("backupLog");
    public static Logger backplogger = Logger.getLogger("backupLog");

    public void execute(JobExecutionContext context) throws JobExecutionException {

        JobKey key = context.getJobDetail().getKey();
        JobDataMap dataMap = context.getJobDetail().getJobDataMap();
        String jobSays = dataMap.getString("backupLocation");
        int compress = dataMap.getInt("compress");
        int encrypt = dataMap.getInt("encrypt");

        backplogger.info("Running the scheduled backup at : " + new Date());
        RunBackup.runBackup(jobSays, Global.tempLocation, compress, encrypt);
        backplogger.info("Scheduled backup process ended at : " + new Date());
    }
}
