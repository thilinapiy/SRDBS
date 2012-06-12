<%@ page import="org.srdbs.web.Api" %>
<%
    if (Api.systemState()) {

        response.sendRedirect("/");
        return;
    }

    session.setAttribute("setupstate", "index");

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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h3>User Setup</h3>

<form action="index.jsp" method="GET">
    <table width="400" border="0">
        <tr>
            <td>Admin User</td>
            <td><input type="text" name="adminuser"
                       value="<% if(session.getAttribute("adminuser")!=null) { out.println(session.getAttribute("adminuser")); } %>"/>
            </td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input type="password" name="password"/></td>
        </tr>
        <tr>
            <td>Re-enter the password</td>
            <td><input type="password" name="password2"/></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
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