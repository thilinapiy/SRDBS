<%@ page import="org.srdbs.web.Api" %>

<%
    if (Api.systemState()) {

        response.sendRedirect("/");
        return;
    }

    if (!session.getAttribute("setupstate").equals("step6")) {
        response.sendRedirect("/setup/" + session.getAttribute("setupstate") + ".jsp");
        return;
    }

    String msg = "";
    String backbtn = request.getParameter("back");
    String nextbtn = request.getParameter("next");


    String templocation = request.getParameter("templocation");
    String restorelocation = request.getParameter("restorelocation");

    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        session.setAttribute("setupstate", "step5");
        response.sendRedirect("/setup/step5.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (templocation != null && restorelocation != null) {
            if (!templocation.trim().equals("") && !restorelocation.trim().equals("")) {

                session.setAttribute("templocation", templocation.toLowerCase().trim());
                session.setAttribute("restorelocation", restorelocation.toLowerCase().trim());

                session.setAttribute("setupstate", "step7");
                response.sendRedirect("/setup/step7.jsp");
                return;
            } else {
                msg = "All fields are required.";
            }
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h3>Locations Setup</h3>

<form action="" method="GET">
    <table width="400" border="0">
        <tr>
            <td>Temp location</td>
            <td><input type="text" name="templocation"
                       value="<% if(session.getAttribute("templocation")!=null) { out.println(session.getAttribute("templocation")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Restore location</td>
            <td><input type="text" name="restorelocation"
                       value="<% if(session.getAttribute("restorelocation")!=null) { out.println(session.getAttribute("restorelocation")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <input type="submit" name="back" value="Back"/>
                <input type="submit" name="next" value="Next"/>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><p><% out.println(msg); %></p>
            </td>
        </tr>
    </table>
</form>

<pre>
<%
    out.println(session.getAttribute("setupstate"));

    out.println("");
    out.println("Admin details");
    out.println(session.getAttribute("username"));
    out.println(session.getAttribute("password"));

    out.println("");
    out.println("Database");
    out.println(session.getAttribute("dbipaddress"));
    out.println(session.getAttribute("dbport"));
    out.println(session.getAttribute("dbname"));
    out.println(session.getAttribute("dbuser"));
    out.println(session.getAttribute("dbpassword"));

    out.println("");
    out.println("Cloud 1");
    out.println(session.getAttribute("c1ipaddress"));
    out.println(session.getAttribute("c1port"));
    out.println(session.getAttribute("c1remotepath"));
    out.println(session.getAttribute("c1username"));
    out.println(session.getAttribute("c1password"));
    out.println(session.getAttribute("c1bandwidth"));
    out.println(session.getAttribute("c1cost"));


    out.println("");
    out.println("Cloud 2");
    out.println(session.getAttribute("c2ipaddress"));
    out.println(session.getAttribute("c2port"));
    out.println(session.getAttribute("c2remotepath"));
    out.println(session.getAttribute("c2username"));
    out.println(session.getAttribute("c2password"));
    out.println(session.getAttribute("c2bandwidth"));
    out.println(session.getAttribute("c2cost"));

    out.println("");
    out.println("Cloud 3");
    out.println(session.getAttribute("c3ipaddress"));
    out.println(session.getAttribute("c3port"));
    out.println(session.getAttribute("c3remotepath"));
    out.println(session.getAttribute("c3username"));
    out.println(session.getAttribute("c3password"));
    out.println(session.getAttribute("c3bandwidth"));
    out.println(session.getAttribute("c3cost"));
%>
</pre>