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
    String bandwidth = request.getParameter("bandwidth");
    String cost = request.getParameter("cost");
    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        response.sendRedirect("/setup/step2.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (ipaddress != null && port != null && remotepath != null && username != null && password != null && bandwidth != null && cost != null) {
            if (!ipaddress.trim().equals("") && !port.trim().equals("") && !remotepath.trim().equals("") && !username.trim().equals("")
                    && !password.trim().equals("") && !bandwidth.trim().equals("") && !cost.trim().equals("")) {

                session.setAttribute("c1ipaddress", ipaddress.toLowerCase().trim());
                session.setAttribute("c1port", port.trim());
                session.setAttribute("c1remotepath", remotepath.trim());
                session.setAttribute("c1username", username.trim());
                session.setAttribute("c1password", password.trim());
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
<h3>Cloud 1 Setup</h3>

<form action="" method="GET">
    <table width="400" border="0">
        <tr>
            <td>IP address</td>
            <td><input type="text" name="ipaddress"
                       value="<% if(session.getAttribute("c1ipaddress")!=null) { out.println(session.getAttribute("c1ipaddress")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Port</td>
            <td><input type="text" name="port"
                       value="<% if(session.getAttribute("c1port")!=null) { out.println(session.getAttribute("c1port")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Remote Path</td>
            <td><input type="text" name="remotepath"
                       value="<% if(session.getAttribute("c1remotepath")!=null) { out.println(session.getAttribute("c1remotepath")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>User Name</td>
            <td><input type="text" name="username"
                       value="<% if(session.getAttribute("c1username")!=null) { out.println(session.getAttribute("c1username")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input type="text" name="password"
                       value="<% if(session.getAttribute("c1password")!=null) { out.println(session.getAttribute("c1password")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Bandwidth (KBPS)</td>
            <td><input type="text" name="bandwidth"
                       value="<% if(session.getAttribute("c1bandwidth")!=null) { out.println(session.getAttribute("c1bandwidth")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Cost</td>
            <td><input type="text" name="cost"
                       value="<% if(session.getAttribute("c1cost")!=null) { out.println(session.getAttribute("c1cost")); } %>"/>
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

%>
</pre>