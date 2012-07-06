package org.srdbs.scheduler;

import org.apache.log4j.Logger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;
import org.srdbs.core.DbConnect;

import java.util.List;

import static org.quartz.CronScheduleBuilder.*;
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

                backplogger.info("Schedule path : " + one.getLocation() + " and frequency : " + one.getFrequency());
                Trigger trigger = null;

                JobDetail job = newJob(RunJob.class)
                        .withIdentity("Job " + count, "Daily backup group")
                        .usingJobData("backupLocation", one.getLocation())
                        .usingJobData("compress", one.getCompress())
                        .usingJobData("encrypt", one.getEncrypt())
                        .build();

                // if daily
                if (one.getFrequency() == 1) {

                    backplogger.info("Creating the daily - backup trigger : " + one.getLocation()
                            + " on schedule " + one.getStartHour() + ":" + one.getStartMin());
                    trigger = newTrigger().withIdentity("trigger " + count++, "Daily backup group")
                            .startNow()
                            .withSchedule(dailyAtHourAndMinute(one.getStartHour(), one.getStartMin()))
                            .build();

                    scheduler.scheduleJob(job, trigger);

                    // if weekly
                } else if (1 < one.getFrequency() && one.getFrequency() < 9) {

                    backplogger.info("Creating weekly on " + (one.getFrequency() - 1)
                            + " of the week - backup trigger : " + one.getLocation()
                            + " on schedule " + one.getStartHour() + ":" + one.getStartMin());

                    trigger = newTrigger().withIdentity("trigger " + count++, "Daily backup group")
                            .startNow()
                            .withSchedule(weeklyOnDayAndHourAndMinute((one.getFrequency() - 1),
                                    one.getStartHour(), one.getStartMin()))
                            .build();

                    scheduler.scheduleJob(job, trigger);

                    // if monthly
                } else if (one.getFrequency() > 8) {

                    backplogger.info("Creating monthly on day : " + (one.getFrequency() - 8)
                            + " backup trigger : " + one.getLocation()
                            + " on schedule " + one.getStartHour() + ":" + one.getStartMin());

                    trigger = newTrigger().withIdentity("trigger " + count++, "Daily backup group")
                            .startNow()
                            .withSchedule(monthlyOnDayAndHourAndMinute(one.getFrequency() - 8,
                                    one.getStartHour(), one.getStartMin()))
                            .build();

                    scheduler.scheduleJob(job, trigger);

                }
            }

        } catch (Exception e) {
            backplogger.error("Error creating the job : " + e);
        }
    }
}
