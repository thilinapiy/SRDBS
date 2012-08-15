<%@ page import="org.srdbs.core.DbConnect" %>
<%@ page import="org.srdbs.scheduler.RunScheduler" %>
<%@ page import="org.srdbs.web.Api" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%
    if (!Api.systemState()) {
        response.sendRedirect("/setup/");
        return;
    }

    String msg = "";
    String addbtn = request.getParameter("add");
    String deletebtn = request.getParameter("delete");

    if (session.getAttribute("username") == null) {
        response.sendRedirect("/login.jsp");
        return;

    } else {
        if (addbtn != null && addbtn.equalsIgnoreCase("add")) {

            msg = "inside the add button";

            String getName = request.getParameter("backuplocation");
            int getFrequency = Integer.valueOf(request.getParameter("frequency").toString());
            int getStartHour = Integer.valueOf(request.getParameter("starthour").toString());
            int getStartMin = Integer.valueOf(request.getParameter("startmin").toString());
            int Compress = (request.getParameter("Compress") != null) ? 1 : 0;
            int Encrypt = (request.getParameter("Encrypt") != null) ? 1 : 0;

            if (getName != "" && getFrequency != 0) {

                try {

                    Connection connection = new DbConnect().webDbConnect();
                    String sql = "INSERT INTO schedule(location, frequency, StartHour, StartMin, compress, encrypt) VALUE (?,?,?,?,?,?)";
                    PreparedStatement ps = connection.prepareStatement(sql);
                    ps.setString(1, getName);
                    ps.setInt(2, getFrequency);
                    ps.setInt(3, getStartHour);
                    ps.setInt(4, getStartMin);
                    ps.setInt(5, Compress);
                    ps.setInt(6, Encrypt);
                    ps.addBatch();

                    ps.executeBatch();
                    ps.close();
                    connection.close();
                    RunScheduler.restartScheduler();
                    response.sendRedirect("/scheduler.jsp");
                    return;
                } catch (Exception ex) {
                    msg = "Unable to connect to database.";
                }

            } else {
                msg = "All fields are required.";
            }
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- HTML Start -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>SRDBS</title>
    <link rel="stylesheet" href="/css/screen.css" type="text/css" media="screen" title="default"/>
    <!--[if IE]>
    <link rel="stylesheet" media="all" type="text/css" href="/css/pro_dropline_ie.css"/>
    <![endif]-->
</head>
<body>
<div id="content-outer">
    <!-- start content -->
    <div id="content">

        <div id="page-heading"><h1>Add Schedule</h1></div>

        <table border="0" width="100%" cellpadding="0" cellspacing="0" id="content-table">
            <tr>
                <th rowspan="3" class="sized"><img src="images/shared/side_shadowleft.jpg" width="20" height="300"
                                                   alt=""/></th>
                <th class="topleft"></th>
                <td id="tbl-border-top">&nbsp;</td>
                <th class="topright"></th>
                <th rowspan="3" class="sized"><img src="images/shared/side_shadowright.jpg" width="20" height="300"
                                                   alt=""/></th>
            </tr>
            <tr>
                <td id="tbl-border-left"></td>
                <td>
                    <!--  start content-table-inner ...................................................................... START -->
                    <div id="content-table-inner">

                        <!--  start table-content  -->
                        <div id="table-content">
                            <!-- Start of the schedule-->
                            <form action="addschedule.jsp" method="GET">
                                <table border="0" cellpadding="0" cellspacing="0" id="id-form">
                                    <tr>
                                        <th>Add Backup Location</th>
                                        <td>
                                            <input type="text" class="inp-form" name="backuplocation"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Frequency</th>
                                        <td>
                                            <select name="frequency" class="styledselect-schedule">
                                                <option value="0">Select</option>
                                                <option value="1">Daily</option>
                                                <option value="2">Weekly - On every Sunday</option>
                                                <option value="3">Weekly - On every Monday</option>
                                                <option value="4">Weekly - On every Tuesday</option>
                                                <option value="5">Weekly - On every Wednesday</option>
                                                <option value="6">Weekly - On every Thursday</option>
                                                <option value="7">Weekly - On every Friday</option>
                                                <option value="8">Weekly - On every Saturday</option>
                                                <%
                                                    for (int s = 1; s < 29; s++) {
                                                        out.print("<option value='" + (s + 8) + "'>Monthly - On day " + s + " </option>");
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Start time</th>
                                        <td>
                                            <select name="starthour" class="styledselect-schedule">
                                                <% for (int i = 0; i < 24; i++) {
                                                    out.println("<option value='" + i + "' >" + i + "</option>");
                                                }
                                                %>
                                            </select>
                                            <select name="startmin" class="styledselect-schedule">
                                                <% for (int j = 0; j < 60; j++) {
                                                    out.println("<option value='" + j + "' >" + j + "</option>");
                                                }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Compress</th>
                                        <td>
                                            <input type="checkbox" name="Compress" value="Compress"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Encrypt</th>
                                        <td>
                                            <input type="checkbox" name="Encrypt" value="Encrypt"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td valign="top">
                                            <input type="submit" class="form-add" name="add" value="add"/>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>
                                            <%
                                                if (!msg.equals("")) {
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
                        </div>
                        <!--  end table-content  -->
                        <div class="clear"></div>
                    </div>
                    <!--  end content-table-inner ............................................END  -->
                </td>
                <td id="tbl-border-right"></td>
            </tr>
            <tr>
                <th class="sized bottomleft"></th>
                <td id="tbl-border-bottom">&nbsp;</td>
                <th class="sized bottomright"></th>
            </tr>
        </table>


        <div class="clear">&nbsp;</div>
    </div>
    <!--  end content -->
    <div class="clear">&nbsp;</div>
</div>
<!--  end content-outer -->


<div class="clear">&nbsp;</div>

<!-- start footer -->
<div id="footer">
    <!--  start footer-left -->
    <!--  end footer-left -->
    <div class="clear">&nbsp;</div>
</div>
<!-- end footer -->

</body>
</html>