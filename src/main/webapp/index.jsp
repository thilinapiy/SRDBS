<%@ page import="org.srdbs.web.Api" %>
<%@ page import="org.srdbs.web.MyPrint" %>

<%
    // Isanka

    if (!Api.systemState()) {

        response.sendRedirect("/setup/");
        return;
    }

    if (session.getAttribute("username") == null) {

        response.sendRedirect("/login.jsp");
        return;

    } else {

        if (request.getParameter("restartbtn") != null && request.getParameter("restartbtn").equalsIgnoreCase("restart")) {

            Api.restartCore();
        }

        if (request.getParameter("stopbtn") != null && request.getParameter("stopbtn").equalsIgnoreCase("stop")) {

            Api.stopCore();
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<p>Login as : <% if (session.getAttribute("username") != null) {
    out.println(session.getAttribute("username"));
}%></p>
<a href="/restore.jsp">Restore</a>
<a href="/logout.jsp">Logout</a>

<form action="index.jsp" method="post">
    <input type="submit" name="restartbtn" value="restart">
    <input type="submit" name="stopbtn" value="stop">
</form>