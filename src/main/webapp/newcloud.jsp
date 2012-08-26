<%@ page import="org.srdbs.web.Api" %>
<%@ page import="org.srdbs.web.Setup" %>
<%@ page import="org.srdbs.core.DbConnect" %>
<%@ page import="org.srdbs.core.Global" %>
<%@ page import="org.srdbs.core.Configs" %>
<%@ page import="org.srdbs.sftp.ChangeCloud" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>


<%
    if (!Api.systemState()) {

        response.sendRedirect("/setup/");
        return;
    }

    String msg = "";
    String addbtn = request.getParameter("add");
    String del = request.getParameter("/changecloud.jsp/deletebtn");

    if (session.getAttribute("username") == null) {
        response.sendRedirect("/login.jsp");
        return;

    } else {

        if (addbtn != null && addbtn.equalsIgnoreCase("add")) {

            String ipaddress = request.getParameter("ipaddress");
            String port = request.getParameter("port");
            String username = request.getParameter("username");
            String remotepath = request.getParameter("remotepath");
            String password = request.getParameter("password");
            String messageport = request.getParameter("messageport");
            String bandwidth = request.getParameter("bandwidth");
            String cost = request.getParameter("cost");

            if (ipaddress != null && port != null && remotepath != null && username != null && password != null
                    && messageport != null && bandwidth != null && cost != null) {
                if (!ipaddress.trim().equals("") && !port.trim().equals("") && !remotepath.trim().equals("")
                        && !username.trim().equals("") && !password.trim().equals("") && !messageport.trim().equals("") && !bandwidth.trim().equals("") && !cost.trim().equals("")) {

                    if (Global.deleteCloudID == 1) {
                        Global.c1IPAddress = ipaddress.toLowerCase().trim();
                        Global.c1Port = Integer.valueOf(port.trim().toString());
                        Global.c1Remotepath = remotepath.trim();
                        Global.c1UserName = username.trim();
                        Global.c1Password = password.trim();
                        Global.c1MessagePort = Integer.valueOf(messageport.trim().toString());
                        Global.c1Bandwidth = Integer.valueOf(bandwidth.trim().toString());
                        Global.c1Cost = cost.trim();
                    }

                    if (Global.deleteCloudID == 2) {
                        Global.c2IPAddress = ipaddress.toLowerCase().trim();
                        Global.c2Port = Integer.valueOf(port.trim().toString());
                        Global.c2Remotepath = remotepath.trim();
                        Global.c2UserName = username.trim();
                        Global.c2Password = password.trim();
                        Global.c2MessagePort = Integer.valueOf(messageport.trim().toString());
                        Global.c2Bandwidth = Integer.valueOf(bandwidth.trim().toString());
                        Global.c2Cost = cost.trim();
                    }

                    if (Global.deleteCloudID == 3) {
                        Global.c3IPAddress = ipaddress.toLowerCase().trim();
                        Global.c3Port = Integer.valueOf(port.trim().toString());
                        Global.c3Remotepath = remotepath.trim();
                        Global.c3UserName = username.trim();
                        Global.c3Password = password.trim();
                        Global.c3MessagePort = Integer.valueOf(messageport.trim().toString());
                        Global.c3Bandwidth = Integer.valueOf(bandwidth.trim().toString());
                        Global.c3Cost = cost.trim();
                    }
                    new Configs().finalizeConfig();
                    response.sendRedirect("/changecloud.jsp");
                    ChangeCloud.ChangeCloud(Global.deleteCloudID);
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

        <div id="page-heading"><h1>Dashboard</h1></div>

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

                            <FORM action="newcloud.jsp" method="get">
                                <H2>
                                    <LEFT>ADD NEW CLOUD DETAILS</LEFT>
                                </H2>
                                <div></div>

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
                                        <td> Messageport :</td>
                                        <td><input name="messageport" size=20 type="text"/></td>
                                    </tr>
                                    <tr>
                                        <td> Bandwidth :</td>
                                        <td><input name="bandwidth" size=20 type="text"/></td>
                                    </tr>
                                    <tr>
                                        <td> Cost :</td>
                                        <td><input name="cost" size=20 type="text"/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <button type="Submit" name="add" Value="add"><img
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