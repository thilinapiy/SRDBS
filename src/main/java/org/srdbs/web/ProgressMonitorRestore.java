package org.srdbs.web;

import net.sf.json.JSONObject;
import org.srdbs.core.RunRestore;
import org.srdbs.sftp.Sftp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


/**
 * Created by IntelliJ IDEA.
 * User: isanka
 * Date: 8/18/12
 * Time: 9:24 PM
 * To change this template use File | Settings | File Templates.
 */



/**
 * Servlet implementation class TestCmd
 */
public class ProgressMonitorRestore extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProgressMonitorRestore() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String info="#";
        info = info+ Sftp.processlogg;
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
//
        JSONObject json = new JSONObject();
        // cloud1
        json.put("restoreFileName", RunRestore.restoreFileName);
        json.put("curentFileNumber",  RunRestore.curentFileNumber);
        json.put("fullFileCount",RunRestore.fullFileCount);
        out.print(json);

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub




    }

}