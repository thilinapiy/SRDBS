package org.srdbs.web;

/**
 * Created by IntelliJ IDEA.
 * User: isanka
 * Date: 8/13/12
 * Time: 7:51 PM
 * To change this template use File | Settings | File Templates.
 */

import net.sf.json.JSONObject;
import org.srdbs.core.RunRestore;
import org.srdbs.sftp.Sftp;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TestCmd
 */
public class ProgressMonitor extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProgressMonitor() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String info="#";
        info = info+ Sftp.processlogg;
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
//
	  JSONObject json = new JSONObject();
       // cloud1
	        json.put("bytecount",Sftp.bytecount);
	        json.put("filename", Sftp.filename);
            json.put("downByteCount", Sftp.downByteCount);
            json.put("fileCount", Sftp.fileCount);
            json.put("currentFileNunber", Sftp.currentFileNunber);

        //cloud2
            json.put("bytecountcloud2",Sftp.bytecountcloud2);
            json.put("filenamecloud2", Sftp.filenamecloud2);
            json.put("fileCountcloud2", Sftp.fileCountcloud2);
            json.put("currentFileNunbercloud2", Sftp.currentFileNunbercloud2);

        // cloud3
            json.put("bytecountcloud3",Sftp.bytecountcloud3);
            json.put("filenamecloud3", Sftp.filenamecloud3);
            json.put("fileCountcloud3", Sftp.fileCountcloud3);
            json.put("currentFileNunbercloud3", Sftp.currentFileNunbercloud3);
	        out.print(json);
            //out.println(info);

    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
//
        JSONObject json = new JSONObject();
        // cloud1
        json.put("restoreFileName", RunRestore.restoreFileName);
        json.put("curentFileNumber",  RunRestore.curentFileNumber);
        json.put("fullFileCount",RunRestore.fullFileCount);

                 }

}
