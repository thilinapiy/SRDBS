<%@ page import="org.srdbs.web.Api" %>

<%
    if (Api.systemState()) {

        response.sendRedirect("/");
        return;
    }

    if (!session.getAttribute("setupstate").equals("step4")) {
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
        session.setAttribute("setupstate", "step3");
        response.sendRedirect("/setup/step3.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (ipaddress != null && port != null && remotepath != null && username != null && password != null
                && messageport != null && bandwidth != null && cost != null) {
            if (!ipaddress.trim().equals("") && !port.trim().equals("") && !remotepath.trim().equals("")
                    && !username.trim().equals("") && !password.trim().equals("") && !messageport.trim().equals("")
                    && !bandwidth.trim().equals("") && !cost.trim().equals("")) {

                session.setAttribute("c2ipaddress", ipaddress.toLowerCase().trim());
                session.setAttribute("c2port", port.trim());
                session.setAttribute("c2remotepath", remotepath.trim());
                session.setAttribute("c2username", username.trim());
                session.setAttribute("c2password", password.trim());
                session.setAttribute("c2messageport", messageport.trim());
                session.setAttribute("c2bandwidth", bandwidth.trim());
                session.setAttribute("c2cost", cost.trim());

                session.setAttribute("setupstate", "step5");
                response.sendRedirect("/setup/step5.jsp");
                return;
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

    <div class="step-no">4</div>
    <div class="step-dark-left">Cloud 2</div>
    <div class="step-dark-right">&nbsp;</div>

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

<form action="step4.jsp" method="GET">
    <table border="0" cellpadding="0" cellspacing="0" id="id-form">
        <tr>
            <th valign="top">IP address</th>
            <td><input type="text" class="inp-form" name="ipaddress"
                       value="<% if(session.getAttribute("c2ipaddress")!=null) { out.println(session.getAttribute("c2ipaddress")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Port</th>
            <td><input type="text" class="inp-form" name="port"
                       value="<% if(session.getAttribute("c2port")!=null) { out.println(session.getAttribute("c2port")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Remote Path</th>
            <td><input type="text" class="inp-form" name="remotepath"
                       value="<% if(session.getAttribute("c2remotepath")!=null) { out.println(session.getAttribute("c2remotepath")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">User Name</th>
            <td><input type="text" class="inp-form" name="username"
                       value="<% if(session.getAttribute("c2username")!=null) { out.println(session.getAttribute("c2username")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Password</th>
            <td><input type="text" class="inp-form" name="password"
                       value="<% if(session.getAttribute("c2password")!=null) { out.println(session.getAttribute("c2password")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Message Port</th>
            <td><input type="text" class="inp-form" name="messageport"
                       value="<% if(session.getAttribute("c2messageport")!=null) { out.println(session.getAttribute("c2messageport")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Bandwidth (KBPS)</th>
            <td><input type="text" class="inp-form" name="bandwidth"
                       value="<% if(session.getAttribute("c2bandwidth")!=null) { out.println(session.getAttribute("c2bandwidth")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Cost</th>
            <td><input type="text" class="inp-form" name="cost"
                       value="<% if(session.getAttribute("c2cost")!=null) { out.println(session.getAttribute("c2cost")); } %>"/>
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