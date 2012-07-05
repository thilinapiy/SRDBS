package org.srdbs.scheduler;

import org.apache.log4j.Logger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;
import org.srdbs.core.DbConnect;

import java.util.List;

import static org.quartz.CronScheduleBuilder.dailyAtHourAndMinute;
import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.newTrigger;

/**
 * Secure and Redundant Data Backup System.
 * User: Thilina Piyasundara
 * Date: 7/5/12
 * Time: 1:03 PM
 * For more details visit : http://www.thilina.org
 */
public class RunScheduler {

    public static Logger logger = Logger.getLogger("systemsLog");
    public static Logger backplogger = Logger.getLogger("backupLog");

    public void initSchedule() {

        try {

            List<Schedule> scheduleList = new DbConnect().getSchedule();
            Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();
            scheduler.start();

            int count = 1;
            for (Schedule one : scheduleList) {

                backplogger.info("Schedule path :" + one.getLocation() + " and " + one.getFrequency());

                JobDetail job = newJob(RunJob.class)
                        .withIdentity("Job " + count, "Daily backup group")
                        .usingJobData("backupLocation", one.getLocation())
                        .build();

                Trigger trigger = newTrigger().withIdentity("trigger " + count++, "Daily backup group")
                        .startNow()
                        .withSchedule(dailyAtHourAndMinute(one.getStartHour(), one.getStartMin()))
                        .build();

                scheduler.scheduleJob(job, trigger);
                backplogger.info("Starting backup job : " + one.getLocation() + " on schedule " + one.getStartHour()
                        + ":" + one.getStartMin());
            }

            /* while (true) {
                try {
                    Thread.sleep(90L * 1000L);
                } catch (InterruptedException e) {
                    logger.error("Thread interrupt.");
                    scheduler.shutdown(true);
                    logger.info("Shutdown the job.");
                }
            }
            */
        } catch (Exception e) {
            backplogger.error("Error creating the job : " + e);
        }
    }
}
