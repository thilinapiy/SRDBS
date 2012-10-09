<%@ page import="org.srdbs.web.Api" %>
<%
    if (Api.systemState()) {

        response.sendRedirect("/");
        return;
    }

    session.setAttribute("setupstate", "index");
    session.setAttribute("noofbackuplocations", 0);

    String msg = "";
    String nextbtn = request.getParameter("next");
    String username = request.getParameter("adminuser");
    String password1 = request.getParameter("password");
    String password2 = request.getParameter("password2");

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (username != null && password1 != null && password2 != null) {
            if (!username.trim().equals("") && !password1.trim().equals("") && !password2.trim().equals("")) {
                if (password2.equals(password1)) {

                    session.setAttribute("username", username.toLowerCase().trim());
                    session.setAttribute("password", password1.trim());
                    session.setAttribute("setupstate", "step2");
                    response.sendRedirect("/setup/step2.jsp");
                    return;
                } else {
                    msg += "Passwords must match both fields";
                }
            } else {
                msg = "All fields are required.";
            }
        }
    }
%>
<%@ include file="header.jsp" %>

<!-- start step-holder -->
<div id="step-holder">
    <div class="step-no">1</div>
    <div class="step-dark-left">Add Users</div>
    <div class="step-dark-right">&nbsp;</div>

    <div class="step-no-off">2</div>
    <div class="step-light-left">Database Setup</div>
    <div class="step-light-right">&nbsp;</div>

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
<form action="index.jsp" method="GET">
    <table border="0" cellpadding="0" cellspacing="0" id="id-form">
        <tr>
            <th valign="top">Admin User:</th>
            <td><input type="text" class="inp-form" name="adminuser"
                       value="<% if(session.getAttribute("adminuser")!=null) { out.println(session.getAttribute("adminuser")); } %>"/>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <th valign="top">Password:</th>
            <td><input type="password" name="password" class="inp-form"/></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <th valign="top">Re-enter password:</th>
            <td><input type="password" name="password2" class="inp-form"/></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <th>&nbsp;</th>
            <td valign="top"><input type="submit" name="next" value="Next" class="form-next"/></td>
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
                    <h5>This is the SRDBS admin user account.</h5>
                </div>
                <div class="left"><a href=""><img src="/images/forms/icon_plus.gif" width="21" height="21" alt=""/></a>
                </div>
                <div class="right">
                    <h5>Use this user name and the password to login to the system.</h5>
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