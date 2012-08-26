<%@ page import="org.srdbs.core.DbConnect" %>
<%@ page import="org.srdbs.scheduler.RunScheduler" %>
<%@ page import="org.srdbs.web.Api" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
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

            response.sendRedirect("/addschedule.jsp");
            return;
        }

        if (deletebtn != null) {

            try {

                Connection connection = new DbConnect().webDbConnect();
                String sql = "delete from schedule where backupid= ?";
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setString(1, deletebtn);
                ps.addBatch();

                ps.executeBatch();
                ps.close();
                connection.close();
                RunScheduler.restartScheduler();
                msg = "Done";
            } catch (Exception ex) {
                msg = "Unable to connect to database.";
            }
        }
    }
%>
<%!

    String getFreq(int fq) {

        String value = "";
        switch (fq) {
            case 1:
                value = "Daily";
                break;
            case 2:
                value = "Weekly - On every Sunday";
                break;
            case 3:
                value = "Weekly - On every Monday";
                break;
            case 4:
                value = "Weekly - On every Tuesday";
                break;
            case 5:
                value = "Weekly - On every Wednesday";
                break;
            case 6:
                value = "Weekly - On every Thursday";
                break;
            case 7:
                value = "Weekly - On every Friday";
                break;
            case 8:
                value = "Weekly - On every Saturday";
                break;
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
            case 28:
            case 29:
            case 30:
            case 31:
            case 32:
            case 33:
            case 34:
            case 35:
            case 36:

                value = "Monthly - On " + (fq - 8);
                break;
            default:
                value = "Error !";
                break;
        }

        return value;
    }

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!-- start content-outer -->
<div id="content-outer">
    <!-- start content -->
    <div id="content">

        <div id="page-heading"><h1>Scheduler</h1></div>

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

                            <table id="schedule-table" border="4px">
                                <tr>
                                    <!-- th>Schedule ID</th -->
                                    <th>Backup Location</th>
                                    <th>Frequency</th>
                                    <th>Time</th>
                                    <!-- th>Min</th -->
                                    <th>Compress</th>
                                    <th>Encrypt</th>
                                    <!-- th>Edit</th -->
                                    <th>Delete</th>
                                </tr>

                                <form action="scheduler.jsp" method="GET">
                                    <%
                                        try {

                                            Connection connection = new DbConnect().webDbConnect();
                                            Statement statement = connection.createStatement();
                                            String QueryString = "SELECT * from schedule";
                                            ResultSet rs = statement.executeQuery(QueryString);

                                            while (rs.next()) {
                                    %>
                                    <tr>
                                        <!-- td><%=rs.getInt(1)%></td -->
                                        <td><%=rs.getString(2)%>
                                        </td>
                                        <td><%=getFreq(rs.getInt(3))%>
                                        </td>
                                        <%!
                                            String getYesNo(int val) {

                                                String msg = "";
                                                if (val == 1) {
                                                    msg = "Yes";
                                                } else if (val == 0) {
                                                    msg = "No";
                                                }

                                                return msg;
                                            }

                                            String getTime(int hour, int min) {

                                                String msg = "";
                                                if (hour < 10) {
                                                    msg = "0" + String.valueOf(hour);
                                                } else {
                                                    msg = String.valueOf(hour);
                                                }

                                                msg += ":";
                                                if (hour < 10) {
                                                    msg += "0" + String.valueOf(min);
                                                } else {
                                                    msg += String.valueOf(min);
                                                }
                                                msg += " h";
                                                return msg;
                                            }
                                        %>
                                        <td><%= getTime(rs.getInt(4), rs.getInt(5)) %>
                                        </td>
                                        <!-- td><%=rs.getInt(5)%>
                                        </td -->
                                        <td align="center"><%= getYesNo(rs.getInt(6))%>
                                        </td>
                                        <td align="center"><%= getYesNo(rs.getInt(7))%>
                                        </td>
                                        <!-- td><input type="Submit" name="edit" Value="<%=rs.getLong(1)%>"></td -->
                                        <!-- td>
                                            <button height='23px' type='submit' name='edit' value='<%=rs.getLong(1)%>'>
                                                <img src='/images/table/action_edit.gif'/></button>
                                        </td -->
                                        <td>
                                            <button type="Submit" name="delete" value='<%=rs.getLong(1)%>'><img
                                                    src='/images/table/delete.gif'/></button>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                            rs.close();
                                            statement.close();
                                            connection.close();
                                        } catch (Exception ex) {
                                            out.println("Unable to connect to database.");
                                        }
                                    %>
                                    <tr>
                                        <td colspan="4">
                                            <%
                                                if (!msg.equals("")) {
                                                    out.println("<div class='error-left'></div>");
                                                    out.println("<div class='error-inner'>" + msg + "</div>");
                                                } else {
                                                    out.println("&nbsp;");
                                                }
                                            %>
                                        </td>
                                        <td colspan="2">
                                            <button type="Submit" name="add" Value="add"><img
                                                    src='/images/forms/form_add.gif'/></button>
                                        </td>
                                    </tr>
                                </form>
                            </table>

                            <!-- End of the schedule -->
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
<!-- end content-outer -->
<%@ include file="footer.jsp" %>