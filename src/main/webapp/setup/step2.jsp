<%@ page import="org.srdbs.web.Setup" %>

<% String msg = "";
    String backbtn = request.getParameter("back");
    String nextbtn = request.getParameter("next");
    String testbtn = request.getParameter("dbtest");

    String ipaddress = request.getParameter("ipaddress");
    String port = request.getParameter("port");
    String dbuser = request.getParameter("dbuser");
    String dbpassword = request.getParameter("dbpassword");

    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        response.sendRedirect("/setup/index.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (ipaddress != null && port != null && dbuser != null && dbpassword != null) {
            if (!ipaddress.trim().equals("") && !port.trim().equals("") && !dbuser.trim().equals("") && !dbpassword.trim().equals("")) {

                session.setAttribute("ipaddress", ipaddress.toLowerCase().trim());
                session.setAttribute("port", port.trim());
                session.setAttribute("dbuser", dbuser.trim());
                session.setAttribute("dbpassword", dbpassword.trim());

                session.setAttribute("setupstate", "step2");
                response.sendRedirect("/setup/step3.jsp");
                return;
            } else {
                msg = "All fields are required.";
            }
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<h3>Database Setup</h3>

<form action="" method="GET">
    <table width="400" border="0">
        <tr>
            <td>IP address</td>
            <td><input type="text" name="ipaddress"
                       value="<% if(session.getAttribute("ipaddress")!=null) { out.println(session.getAttribute("ipaddress")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Port</td>
            <td><input type="text" name="port"
                       value="<% if(session.getAttribute("port")!=null) { out.println(session.getAttribute("port")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>DB user</td>
            <td><input type="text" name="dbuser"
                       value="<% if(session.getAttribute("dbuser")!=null) { out.println(session.getAttribute("dbuser")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>DB password</td>
            <td><input type="text" name="dbpassword"
                       value="<% if(session.getAttribute("dbpassword")!=null) { out.println(session.getAttribute("dbpassword")); } %>"/>
            </td>
        </tr>
        <tr>
            <td><input type="submit" name="testdb" value="Test Database Connection"/></td>
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
<% out.println(session.getAttribute("username")); %>
<% out.println(session.getAttribute("password")); %>
<% out.println(session.getAttribute("setupstate")); %>
<% //out.println(session.getAttribute()); %>
</pre>