<%@ page import="org.srdbs.web.Api" %>
<%@ page import="org.srdbs.web.Setup" %>
<%@ page import="java.sql.*" %>
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
        session.setAttribute("setupstate", "index");
        response.sendRedirect("/setup/index.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

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
                    Setup.initializeDatabase(session);
                    msg = "Database initialized successfully.";


                    session.setAttribute("setupstate", "step3");
                    response.sendRedirect("/setup/step3.jsp");
                    return;
                } catch (SQLException e) {
                    msg = "SQL exception : " + e.getErrorCode();
                }

            } else {
                msg = "All fields are required.";
            }
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%@ include file="header.jsp" %>

<!-- start step-holder -->
<div id="step-holder">
    <div class="step-no-off">1</div>
    <div class="step-light-left">Add Users</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no">2</div>
    <div class="step-dark-left">Database Setup</div>
    <div class="step-dark-right">&nbsp;</div>

    <div class="step-no-off">3</div>
    <div class="step-light-left">Cloud 1</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">4</div>
    <div class="step-light-left">Cloud 2</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">5</div>
    <div class="step-light-left">Cloud 3</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">6</div>
    <div class="step-light-left">Schedules</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">7</div>
    <div class="step-light-left">Final</div>
    <div class="step-light-round">&nbsp;</div>

    <div class="clear"></div>
</div>
<!-- end step-holder -->
<!-- start id-form -->

<form action="step2.jsp" method="GET">
    <table border="0" cellpadding="0" cellspacing="0" id="id-form">
        <tr>
            <th valign="top">IP address</th>
            <td><input type="text" class="inp-form" name="dbipaddress"
                       value="<% if(session.getAttribute("dbipaddress")!=null) { out.println(session.getAttribute("dbipaddress")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Port</th>
            <td><input type="text" class="inp-form" name="dbport"
                       value="<% if(session.getAttribute("dbport")!=null) { out.println(session.getAttribute("dbport")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Database Name</th>
            <td><input type="text" class="inp-form" name="dbname"
                       value="<% if(session.getAttribute("dbname")!=null) { out.println(session.getAttribute("dbname")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">DB user</th>
            <td><input type="text" class="inp-form" name="dbuser"
                       value="<% if(session.getAttribute("dbuser")!=null) { out.println(session.getAttribute("dbuser")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">DB password</th>
            <td><input type="password" class="inp-form" name="dbpassword"
                       value="<% if(session.getAttribute("dbpassword")!=null) { out.println(session.getAttribute("dbpassword")); } %>"/>
            </td>
        </tr>
        <tr>
            <th>&nbsp;</th>
            <td valign="top">
                <input type="submit" class="form-back" name="back" value="Back"/>
                <input type="submit" class="form-next" name="next" value="Next"/>
            </td>
            <td>
                <% if (!msg.equals("")) {
                    out.println("<div class='error-left'></div>");
                    out.println("<div class='error-inner'>" + msg + "</div>");
                } else {
                    out.println("&nbsp;");
                }
                %>
            </td>
        </tr>
    </table>
</form>
<!-- end id-form -->
</td>
<td>

    <!--  start related-activities -->
    <div id="related-activities">
        <!--  start related-act-top -->
        <div id="related-act-top">
            <img src="/images/forms/header_related_act.gif" width="271" height="43" alt=""/>
        </div>
        <!-- end related-act-top -->

        <!--  start related-act-bottom -->
        <div id="related-act-bottom">
            <!--  start related-act-inner -->
            <div id="related-act-inner">
                <div class="left"><a href=""><img src="/images/forms/icon_plus.gif" width="21" height="21" alt=""/></a>
                </div>
                <div class="right">
                    <h5></h5>
                    Lorem ipsum dolor sit amet consectetur
                    adipisicing elitsed do eiusmod tempor.
                    <ul class="greyarrow">
                        <li><a href="">Click here to visit</a></li>
                        <li><a href="">Click here to visit</a></li>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
            <!-- end related-act-inner -->
            <div class="clear"></div>
        </div>
        <!-- end related-act-bottom -->
    </div>
    <!-- end related-activities -->
<%@ include file="footer.jsp" %>