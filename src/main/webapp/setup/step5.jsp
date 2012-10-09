<%@ page import="org.srdbs.messenger.Sender" %>
<%@ page import="org.srdbs.web.Api" %>

<%
    if (Api.systemState()) {

        response.sendRedirect("/");
        return;
    }

    if (!session.getAttribute("setupstate").equals("step5")) {
        response.sendRedirect("/setup/" + session.getAttribute("setupstate") + ".jsp");
        return;
    }

    String msg = "";
    String backbtn = request.getParameter("back");
    String nextbtn = request.getParameter("next");

    String ipaddress = request.getParameter("ipaddress");
    String port = request.getParameter("port");
    String username = request.getParameter("username");
    String remotepath = request.getParameter("remotepath");
    String password = request.getParameter("password");
    String messageport = request.getParameter("messageport");
    String bandwidth = request.getParameter("bandwidth");
    String cost = request.getParameter("cost");

    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        session.setAttribute("setupstate", "step4");
        response.sendRedirect("/setup/step4.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (ipaddress != null && port != null && remotepath != null && username != null && password != null
                && messageport != null && bandwidth != null && cost != null) {
            if (!ipaddress.trim().equals("") && !port.trim().equals("") && !remotepath.trim().equals("")
                    && !username.trim().equals("") && !password.trim().equals("") && !messageport.trim().equals("")
                    && !bandwidth.trim().equals("") && !cost.trim().equals("")) {

                session.setAttribute("c3ipaddress", ipaddress.toLowerCase().trim());
                session.setAttribute("c3port", port.trim());
                session.setAttribute("c3remotepath", remotepath.trim());
                session.setAttribute("c3username", username.trim());
                session.setAttribute("c3password", password.trim());
                session.setAttribute("c3messageport", messageport.trim());
                session.setAttribute("c3bandwidth", bandwidth.trim());
                session.setAttribute("c3cost", cost.trim());

                try {
                    // validating the message service.
                    Sender.sendMessage(session.getAttribute("c3ipaddress").toString()
                            , Integer.valueOf(session.getAttribute("c3messageport").toString()), "init");

                    session.setAttribute("setupstate", "step6");
                    response.sendRedirect("/setup/step6.jsp");
                    return;
                } catch (Exception e) {
                    msg = "Error on message service.";
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

    <div class="step-no-off">2</div>
    <div class="step-light-left">Database Setup</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">3</div>
    <div class="step-light-left">Cloud 1</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">4</div>
    <div class="step-light-left">Cloud 2</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no">5</div>
    <div class="step-dark-left">Cloud 3</div>
    <div class="step-dark-right">&nbsp;</div>

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

<form action="step5.jsp" method="GET">
    <table border="0" cellpadding="0" cellspacing="0" id="id-form">
        <tr>
            <th valign="top">SFTP Host</th>
            <td><input type="text" class="inp-form" name="ipaddress"
                       value="<% if(session.getAttribute("c3ipaddress")!=null) { out.println(session.getAttribute("c3ipaddress")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">SFTP Port</th>
            <td><input type="text" class="inp-form" name="port"
                       value="<% if(session.getAttribute("c3port")!=null) { out.println(session.getAttribute("c3port")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">SFTP Root</th>
            <td><input type="text" class="inp-form" name="remotepath"
                       value="<% if(session.getAttribute("c3remotepath")!=null) { out.println(session.getAttribute("c3remotepath")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">SFTP User</th>
            <td><input type="text" class="inp-form" name="username"
                       value="<% if(session.getAttribute("c3username")!=null) { out.println(session.getAttribute("c3username")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">SFTP Password</th>
            <td><input type="password" class="inp-form" name="password"
                       value="<% if(session.getAttribute("c3password")!=null) { out.println(session.getAttribute("c3password")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Message Port</th>
            <td><input type="text" class="inp-form" name="messageport"
                       value="<% if(session.getAttribute("c3messageport")!=null) { out.println(session.getAttribute("c3messageport")); } %>"/>
            </td>
        </tr>
        <!-- Hidden for future works. -->
        <!-- tr>
            <th valign="top">Bandwidth (KBPS)</th>
            <td><input type="text" class="inp-form" name="bandwidth"
                       value="<% if(session.getAttribute("c3bandwidth")!=null) { out.println(session.getAttribute("c3bandwidth")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Cost</th>
            <td><input type="text" class="inp-form" name="cost"
                       value="<% if(session.getAttribute("c3cost")!=null) { out.println(session.getAttribute("c3cost")); } %>"/>
            </td>
        </tr -->
        <input type="hidden" class="inp-form" name="bandwidth" value="0"/>
        <input type="hidden" class="inp-form" name="cost" value="0"/>
        <!-- Hidden End. -->

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
                    <h5>This is to setup the communication with the third cloud storage.</h5>
                </div>
                <div class="left"><a href=""><img src="/images/forms/icon_plus.gif" width="21" height="21" alt=""/></a>
                </div>
                <div class="right">
                    <h5>Check the 'SFTP service' and the 'Messaging service' is running on the respective cloud</h5>
                </div>
                <div class="left"><a href=""><img src="/images/forms/icon_plus.gif" width="21" height="21" alt=""/></a>
                </div>
                <div class="right">
                    <h5>If an error occurs check the given message service and SFTP service configurations.</h5>
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