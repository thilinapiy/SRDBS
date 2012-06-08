<%@ page import="org.srdbs.web.Api" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%
    if (Api.systemState()) {

        response.sendRedirect("/");
        return;
    }

    if (!session.getAttribute("setupstate").equals("step2")) {
        response.sendRedirect("/setup/" + session.getAttribute("setupstate") + ".jsp");
        return;
    }

    String msg = "";
    String backbtn = request.getParameter("back");
    String nextbtn = request.getParameter("next");
    String testbtn = request.getParameter("testdb");

    String dbipaddress = request.getParameter("dbipaddress");
    String dbport = request.getParameter("dbport");
    String dbname = request.getParameter("dbname");
    String dbuser = request.getParameter("dbuser");
    String dbpassword = request.getParameter("dbpassword");

    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        response.sendRedirect("/setup/index.jsp");
        return;
    }

    if (testbtn != null && testbtn.equalsIgnoreCase("Test Database Connection")) {

        if (dbipaddress != null && dbport != null && dbname != null && dbuser != null && dbpassword != null) {
            if (!dbipaddress.trim().equals("") && !dbport.trim().equals("") && !dbname.trim().equals("") && !dbuser.trim().equals("") && !dbpassword.trim().equals("")) {

                session.setAttribute("dbipaddress", dbipaddress.toLowerCase().trim());
                session.setAttribute("dbport", dbport.trim());
                session.setAttribute("dbname", dbname.trim());
                session.setAttribute("dbuser", dbuser.trim());
                session.setAttribute("dbpassword", dbpassword.trim());

                Connection conn = null;
                try {

                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    String dbURL = "jdbc:mysql://" + session.getAttribute("dbipaddress") + ":"
                            + session.getAttribute("dbport") + "/" + session.getAttribute("dbname");
                    String dbu = String.valueOf(session.getAttribute("dbuser"));
                    String dbp = String.valueOf(session.getAttribute("dbpassword"));
                    conn = DriverManager.getConnection(dbURL, dbu, dbp);
                    conn.close();
                    msg = "Connected to the database";
                } catch (Exception e) {
                    msg = "Database connection error : " + e;
                }

            } else {
                msg = "All fields are required.";
            }
        }
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (dbipaddress != null && dbport != null && dbname != null && dbuser != null && dbpassword != null) {
            if (!dbipaddress.trim().equals("") && !dbport.trim().equals("") && !dbname.trim().equals("") && !dbuser.trim().equals("") && !dbpassword.trim().equals("")) {

                session.setAttribute("dbipaddress", dbipaddress.toLowerCase().trim());
                session.setAttribute("dbport", dbport.trim());
                session.setAttribute("dbname", dbname.trim());
                session.setAttribute("dbuser", dbuser.trim());
                session.setAttribute("dbpassword", dbpassword.trim());

                session.setAttribute("setupstate", "step3");
                response.sendRedirect("/setup/step3.jsp");
                return;
            } else {
                msg = "All fields are required.";
            }
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>Database Setup</h3>

<form action="" method="GET">
    <table width="400" border="0">
        <tr>
            <td>IP address</td>
            <td><input type="text" name="dbipaddress"
                       value="<% if(session.getAttribute("dbipaddress")!=null) { out.println(session.getAttribute("dbipaddress")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Port</td>
            <td><input type="text" name="dbport"
                       value="<% if(session.getAttribute("dbport")!=null) { out.println(session.getAttribute("dbport")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Database Name</td>
            <td><input type="text" name="dbname"
                       value="<% if(session.getAttribute("dbname")!=null) { out.println(session.getAttribute("dbname")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>DB user</td>
            <td><input type="text" name="dbuser"
                       value="<% if(session.getAttribute("dbuser")!=null) { out.println(session.getAttribute("dbuser")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>DB password</td>
            <td><input type="text" name="dbpassword"
                       value="<% if(session.getAttribute("dbpassword")!=null) { out.println(session.getAttribute("dbpassword")); } %>"/>
            </td>
        </tr>
        <tr>
            <td><input type="submit" name="testdb" value="Test Database Connection"/></td>
            <td>
                <input type="submit" name="back" value="Back"/>
                <input type="submit" name="next" value="Next"/>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><p><% out.println(msg); %></p>
            </td>
        </tr>
    </table>
</form>

<pre>
<%
    out.println(session.getAttribute("username"));
    out.println(session.getAttribute("password"));
    out.println(session.getAttribute("setupstate"));
%>
</pre>