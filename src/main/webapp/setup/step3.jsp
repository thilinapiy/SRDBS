<%@ page import="org.srdbs.web.Api" %>

<%
    if (Api.systemState()) {

        response.sendRedirect("/");
        return;
    }

    if (!session.getAttribute("setupstate").equals("step3")) {
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
        session.setAttribute("setupstate", "step2");
        response.sendRedirect("/setup/step2.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (ipaddress != null && port != null && remotepath != null && username != null && password != null
                && messageport != null && bandwidth != null && cost != null) {
            if (!ipaddress.trim().equals("") && !port.trim().equals("") && !remotepath.trim().equals("")
                    && !username.trim().equals("") && !password.trim().equals("") && !messageport.trim().equals("")
                    && !bandwidth.trim().equals("") && !cost.trim().equals("")) {

                session.setAttribute("c1ipaddress", ipaddress.toLowerCase().trim());
                session.setAttribute("c1port", port.trim());
                session.setAttribute("c1remotepath", remotepath.trim());
                session.setAttribute("c1username", username.trim());
                session.setAttribute("c1password", password.trim());
                session.setAttribute("c1messageport", messageport.trim());
                session.setAttribute("c1bandwidth", bandwidth.trim());
                session.setAttribute("c1cost", cost.trim());

                session.setAttribute("setupstate", "step4");
                response.sendRedirect("/setup/step4.jsp");
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

    <div class="step-no">3</div>
    <div class="step-dark-left">Cloud 1</div>
    <div class="step-dark-right">&nbsp;</div>

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

<form action="step3.jsp" method="GET">
    <table border="0" cellpadding="0" cellspacing="0" id="id-form">
        <tr>
            <th valign="top">IP address</th>
            <td><input type="text" class="inp-form" name="ipaddress"
                       value="<% if(session.getAttribute("c1ipaddress")!=null) { out.println(session.getAttribute("c1ipaddress")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Port</th>
            <td><input type="text" class="inp-form" name="port"
                       value="<% if(session.getAttribute("c1port")!=null) { out.println(session.getAttribute("c1port")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Remote Path</th>
            <td><input type="text" class="inp-form" name="remotepath"
                       value="<% if(session.getAttribute("c1remotepath")!=null) { out.println(session.getAttribute("c1remotepath")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">User Name</th>
            <td><input type="text" class="inp-form" class="inp-form" name="username"
                       value="<% if(session.getAttribute("c1username")!=null) { out.println(session.getAttribute("c1username")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Password</th>
            <td><input type="password" class="inp-form" name="password"
                       value="<% if(session.getAttribute("c1password")!=null) { out.println(session.getAttribute("c1password")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Message Port</th>
            <td><input type="text" class="inp-form" name="messageport"
                       value="<% if(session.getAttribute("c1messageport")!=null) { out.println(session.getAttribute("c1messageport")); } %>"/>
            </td>
        </tr>
        <!-- Hidden for future works. -->
        <!-- tr>
            <th valign="top">Bandwidth (KBPS)</th>
            <td><input type="text" class="inp-form" name="bandwidth"
                       value="<% if(session.getAttribute("c1bandwidth")!=null) { out.println(session.getAttribute("c1bandwidth")); } %>"/>
            </td>
        </tr>
		<tr>
            <th valign="top">Cost</th>
            <td><input type="text" class="inp-form" name="cost"
                       value="<% if(session.getAttribute("c1cost")!=null) { out.println(session.getAttribute("c1cost")); } %>"/>
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