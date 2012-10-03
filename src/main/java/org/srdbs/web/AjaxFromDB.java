package org.srdbs.web;

import net.sf.json.JSONObject;
import org.srdbs.core.DbConnect;
import org.srdbs.messenger.Sender;
import org.srdbs.sftp.Sftp;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class AjaxFromDB extends HttpServlet {

    Connection connection = null;
    Statement ptmt = null;
    ResultSet resultSet = null;
    PrintWriter out;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {

        try {
            JSONObject json = new JSONObject();
            int count = 0;
            response.setContentType("application/json");

            out = response.getWriter();
            out.print("[");

            String queryString = "select * from status ";

            DbConnect DB = new DbConnect();
            connection = DB.getConnection();
            ptmt = connection.createStatement();
            resultSet = ptmt.executeQuery(queryString);
            while (resultSet.next()) {
                count++;
                json.put(count, resultSet.getObject(4).toString());
            }

            out.print(json);
            out.print("]");


        } catch (Exception e) {
            // TODO: handle exception
        }
    }
}
