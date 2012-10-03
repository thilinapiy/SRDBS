package org.srdbs.web;

import net.sf.json.JSONObject;
import org.srdbs.core.DbConnect;
import org.srdbs.messenger.Sender;
import org.srdbs.scheduler.RunMessageJob;
import org.srdbs.sftp.Sftp;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * Created by IntelliJ IDEA.
 * User: isanka
 * Date: 9/18/12
 * Time: 8:16 PM
 * To change this template use File | Settings | File Templates.
 */
public class CloudStatus extends HttpServlet {


    protected void doGet(HttpServletRequest request, HttpServletResponse response) {

        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            JSONObject json = new JSONObject();
            // cloud1
            json.put("cloud1", RunMessageJob.cloud1);
            json.put("cloud2", RunMessageJob.cloud2);
            json.put("cloud3", RunMessageJob.cloud3);



            out.print(json);

        } catch (Exception e) {
            // TODO: handle exception
        }
    }


}
