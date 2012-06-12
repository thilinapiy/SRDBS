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
    String bandwidth = request.getParameter("bandwidth");
    String cost = request.getParameter("cost");

    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        session.setAttribute("setupstate", "step3");
        response.sendRedirect("/setup/step3.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (ipaddress != null && port != null && remotepath != null && username != null && password != null && bandwidth != null && cost != null) {
            if (!ipaddress.trim().equals("") && !port.trim().equals("") && !remotepath.trim().equals("") && !username.trim().equals("")
                    && !password.trim().equals("") && !bandwidth.trim().equals("") && !cost.trim().equals("")) {

                session.setAttribute("c2ipaddress", ipaddress.toLowerCase().trim());
                session.setAttribute("c2port", port.trim());
                session.setAttribute("c2remotepath", remotepath.trim());
                session.setAttribute("c2username", username.trim());
                session.setAttribute("c2password", password.trim());
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
<h3>Cloud 2 Setup</h3>

<form action="" method="GET">
    <table width="400" border="0">
        <tr>
            <td>IP address</td>
            <td><input type="text" name="ipaddress"
                       value="<% if(session.getAttribute("c2ipaddress")!=null) { out.println(session.getAttribute("c2ipaddress")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Port</td>
            <td><input type="text" name="port"
                       value="<% if(session.getAttribute("c2port")!=null) { out.println(session.getAttribute("c2port")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Remote Path</td>
            <td><input type="text" name="remotepath"
                       value="<% if(session.getAttribute("c2remotepath")!=null) { out.println(session.getAttribute("c2remotepath")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>User Name</td>
            <td><input type="text" name="username"
                       value="<% if(session.getAttribute("c2username")!=null) { out.println(session.getAttribute("c2username")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input type="text" name="password"
                       value="<% if(session.getAttribute("c2password")!=null) { out.println(session.getAttribute("c2password")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Bandwidth (KBPS)</td>
            <td><input type="text" name="bandwidth"
                       value="<% if(session.getAttribute("c2bandwidth")!=null) { out.println(session.getAttribute("c2bandwidth")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Cost</td>
            <td><input type="text" name="cost"
                       value="<% if(session.getAttribute("c2cost")!=null) { out.println(session.getAttribute("c2cost")); } %>"/>
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

%>
</pre>