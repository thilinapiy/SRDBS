<%@ page import="org.srdbs.web.Api" %>
<%@ page import="org.srdbs.web.Setup" %>
<%@ page import="org.srdbs.core.DbConnect" %>
<%@ page import="org.srdbs.core.Global" %>
<%@ page import="org.srdbs.core.Configs" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>


<%
    if (!Api.systemState()) {

        response.sendRedirect("/setup/");
        return;
    }

    String msg = "";
    String smtbtn = request.getParameter("submit");

    if (session.getAttribute("username") == null) {
        response.sendRedirect("/login.jsp");
        return;

    } else {

        if (smtbtn != null && smtbtn.equalsIgnoreCase("submit")) {

            String ipaddress = request.getParameter("ipaddress");
            String port = request.getParameter("port");
            String username = request.getParameter("username");
            String remotepath = request.getParameter("remotepath");
            String password = request.getParameter("password");
            String messageport = request.getParameter("messageport");

            if (ipaddress != null && port != null && remotepath != null && username != null && password != null
                    && messageport != null) {
                if (!ipaddress.trim().equals("") && !port.trim().equals("") && !remotepath.trim().equals("")
                        && !username.trim().equals("") && !password.trim().equals("") && !messageport.trim().equals("")) {

                    Global.c2IPAddress = ipaddress.toLowerCase().trim();
                    Global.c2Port = Integer.valueOf(port.trim().toString());
                    Global.c2Remotepath = remotepath.trim();
                    Global.c2UserName = username.trim();
                    Global.c2Password = password.trim();
                    Global.c2MessagePort = Integer.valueOf(messageport.trim().toString());

                    new Configs().finalizeConfig();
                    response.sendRedirect("/cloud2.jsp");
                    return;
                }
            }

        }
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!-- start content-outer -->
<div id="content-outer">
<!-- start content -->
<div id="content">

<div id="page-heading"><h1>Cloud 2</h1></div>

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
                <FORM action="cloud2.jsp" method="get">
                    <table border="1" width="300" height="150">

                        <%
                            try {

                                Connection connection = new DbConnect().webDbConnect();
                                Statement statement = connection.createStatement();
                                String QueryString = "SELECT sysvalue from sysconfig where sysid='12'";
                                ResultSet rs = statement.executeQuery(QueryString);

                                while (rs.next()) {
                        %>
                        <tr>
                            <td>IP Address</td>
                            <td><%=rs.getString(1)%>
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
                                String QueryString = "SELECT sysvalue from sysconfig where sysid='13'";
                                ResultSet rs = statement.executeQuery(QueryString);

                                while (rs.next()) {
                        %>
                        <tr>
                            <td>Port</td>
                            <td><%=rs.getString(1)%>
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
                                String QueryString = "SELECT sysvalue from sysconfig where sysid='14'";
                                ResultSet rs = statement.executeQuery(QueryString);

                                while (rs.next()) {
                        %>
                        <tr>
                            <td>Remote Path</td>
                            <td><%=rs.getString(1)%>
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
                                String QueryString = "SELECT sysvalue from sysconfig where sysid='15'";
                                ResultSet rs = statement.executeQuery(QueryString);

                                while (rs.next()) {
                        %>
                        <tr>
                            <td>Username</td>
                            <td><%=rs.getString(1)%>
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
                                String QueryString = "SELECT sysvalue from sysconfig where sysid='17'";
                                ResultSet rs = statement.executeQuery(QueryString);

                                while (rs.next()) {
                        %>
                        <tr>
                            <td>Message Port</td>
                            <td><%=rs.getString(1)%>
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
                    <div>
                        <br/><br/>
                    </div>

                    <TABLE WIDTH="30%">
                        <tr>
                            <td> IP Address :</td>
                            <td><input name="ipaddress" size=20 type="text"/></td>
                        </tr>
                        <tr>
                            <td> Port :</td>
                            <td><input name="port" size=20 type="text"/></td>
                        </tr>
                        <tr>
                            <td> Username :</td>
                            <td><input name="username" size=20 type="text"/></td>
                        </tr>
                        <tr>
                            <td> Password :</td>
                            <td><input name="password" size=20 type="password"/></td>
                        </tr>
                        <tr>
                            <td> Remote Path :</td>
                            <td><input name="remotepath" size=20 type="text"/></td>
                        </tr>
                        <tr>
                            <td> messageport :</td>
                            <td><input name="messageport" size=20 type="text"/></td>
                        </tr>
                        <tr>
                            <td colspan="1">
                                <button type="Submit" name="submit" Value="submit"><img
                                        src='/images/forms/form_add.gif'/></button>
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
<!-- end content-outer -->
<%@ include file="footer.jsp" %>