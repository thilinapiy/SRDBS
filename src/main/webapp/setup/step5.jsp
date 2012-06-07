<%@ page import="org.srdbs.web.Setup" %>

<% String msg = "";
    String backbtn = request.getParameter("back");
    String nextbtn = request.getParameter("next");


    String ipaddress = request.getParameter("ipaddress");
    String port = request.getParameter("port");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String bandwidth = request.getParameter("bandwidth");
    String cost = request.getParameter("cost");
    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        response.sendRedirect("/setup/step4.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (ipaddress != null && port != null && username != null && password != null && bandwidth != null && cost != null) {
            if (!ipaddress.trim().equals("") && !port.trim().equals("") && !username.trim().equals("")
                    && !password.trim().equals("") && !bandwidth.trim().equals("") && !cost.trim().equals("")) {

                session.setAttribute("c3ipaddress", ipaddress.toLowerCase().trim());
                session.setAttribute("c3port", port.trim());
                session.setAttribute("c3username", username.trim());
                session.setAttribute("c3password", password.trim());
                session.setAttribute("c3bandwidth", bandwidth.trim());
                session.setAttribute("c3cost", cost.trim());

                session.setAttribute("setupstate", "step4");
                response.sendRedirect("/setup/step6.jsp");
                return;
            } else {
                msg = "All fields are required.";
            }
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h3>Cloud 3 Setup</h3>

<form action="" method="GET">
    <table width="400" border="0">
        <tr>
            <td>IP address</td>
            <td><input type="text" name="ipaddress"
                       value="<% if(session.getAttribute("c3ipaddress")!=null) { out.println(session.getAttribute("c3ipaddress")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Port</td>
            <td><input type="text" name="port"
                       value="<% if(session.getAttribute("c3port")!=null) { out.println(session.getAttribute("c3port")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>User Name</td>
            <td><input type="text" name="username"
                       value="<% if(session.getAttribute("c3username")!=null) { out.println(session.getAttribute("c3username")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input type="text" name="password"
                       value="<% if(session.getAttribute("c3password")!=null) { out.println(session.getAttribute("c3password")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Bandwidth (KBPS)</td>
            <td><input type="text" name="bandwidth"
                       value="<% if(session.getAttribute("c3bandwidth")!=null) { out.println(session.getAttribute("c3bandwidth")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Cost</td>
            <td><input type="text" name="cost"
                       value="<% if(session.getAttribute("c3cost")!=null) { out.println(session.getAttribute("c3cost")); } %>"/>
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
    out.println(session.getAttribute("c1username"));
    out.println(session.getAttribute("c1password"));
    out.println(session.getAttribute("c1bandwidth"));
    out.println(session.getAttribute("c1cost"));


    out.println("");
    out.println("Cloud 2");
    out.println(session.getAttribute("c2ipaddress"));
    out.println(session.getAttribute("c2port"));
    out.println(session.getAttribute("c2username"));
    out.println(session.getAttribute("c2password"));
    out.println(session.getAttribute("c2bandwidth"));
    out.println(session.getAttribute("c2cost"));
%>
</pre>