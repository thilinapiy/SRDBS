package org.srdbs.scheduler;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.srdbs.sftp.FailUpload;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 7/17/12
 * Time: 11:54 AM
 * For more details visit : http://www.thilina.org
 */
public class RunFailedBackupsJob implements Job {

    public static Logger logger = Logger.getLogger("backupLog");

    public void execute(JobExecutionContext context) throws JobExecutionException {

        logger.info("Retrying to upload failed backups.");
        FailUpload.getFile();
    }
}
