<%@ page import="org.srdbs.web.Api" %>
<%@ page import="org.srdbs.core.DbConnect" %>
<%@ page import="org.srdbs.core.Global" %>
<%@ page import="java.sql.*" %>


<%
    if (!Api.systemState()) {

        response.sendRedirect("/setup/");
        return;
    }

    String msg = "";
    String deletebtn = request.getParameter("delete");

    if (session.getAttribute("username") == null) {
        response.sendRedirect("/login.jsp");
        return;

    } else {

        if (deletebtn != null) {

            Global.deleteCloudID = Integer.valueOf(deletebtn);
            response.sendRedirect("/newcloud.jsp");

        }

    }

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!-- start content-outer -->
<div id="content-outer">
    <!-- start content -->
    <div id="content">

        <div id="page-heading"><h1>Update Cloud Details</h1></div>

        <table border="0" width="100%" cellpadding="0" cellspacing="0" id="content-table">
            <tr>
                <th rowspan="3" class="sized"><img src="images/shared/side_shadowleft.jpg" width="20" height="300"
                                                   alt=""/></th>
                <th class="topleft"></th>
                <td id="tbl-border-top">&nbsp;</td>
                <th class="topright"></th>
                <th rowspan="3" class="sized">
                    <img src="images/shared/side_shadowright.jpg" width="20" height="300" alt=""/></th>
            </tr>
            <tr>
                <td id="tbl-border-left"></td>
                <td>
                    <!--  start content-table-inner ...................................................................... START -->
                    <div id="content-table-inner">
                        <!--  start table-content  -->
                        <div id="table-content">
                            <FORM action="changecloud.jsp" method="get">
                                <table border="1" width="300" height="150">

                                    <tr>
                                        <th>Cloud ID</th>
                                        <th>IP Address</th>
                                        <th>Change</th>
                                    </tr>


                                    <%
                                        try {

                                            Connection connection = new DbConnect().webDbConnect();
                                            Statement statement = connection.createStatement();
                                            String QueryString = "SELECT sysvalue from sysconfig where sysid='4'";
                                            ResultSet rs = statement.executeQuery(QueryString);

                                            while (rs.next()) {
                                    %>
                                    <tr>
                                        <td align="center">1</td>
                                        <td align="center"><%=rs.getString(1)%>
                                        </td>
                                        <td align="center">
                                            <button type="Submit" name="delete" value='1'><img
                                                    src='/images/table/action_edit.gif'/></button>
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
                                    <%
                                        try {

                                            Connection connection = new DbConnect().webDbConnect();
                                            Statement statement = connection.createStatement();
                                            String QueryString = "SELECT sysvalue from sysconfig where sysid='12'";
                                            ResultSet rs = statement.executeQuery(QueryString);

                                            while (rs.next()) {
                                    %>
                                    <tr>
                                        <td align="center">2</td>
                                        <td align="center"><%=rs.getString(1)%>
                                        </td>
                                        <td align="center">
                                            <button type="Submit" name="delete" value='2'><img
                                                    src='/images/table/action_edit.gif'/></button>
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
                                    <%
                                        try {

                                            Connection connection = new DbConnect().webDbConnect();
                                            Statement statement = connection.createStatement();
                                            String QueryString = "SELECT sysvalue from sysconfig where sysid='20'";
                                            ResultSet rs = statement.executeQuery(QueryString);

                                            while (rs.next()) {
                                    %>
                                    <tr>
                                        <td align="center">3</td>
                                        <td align="center"><%=rs.getString(1)%>
                                        </td>
                                        <td align="center">
                                            <button type="Submit" name="delete" value='3'><img
                                                    src='/images/table/action_edit.gif'/></button>
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
<!-- end content-outer -->
<%@ include file="footer.jsp" %>