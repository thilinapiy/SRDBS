<%@ page import="org.srdbs.web.Api" %>
<%
    if (!Api.systemState()) {

        response.sendRedirect("/setup/");
        return;
    }

    String msg = "";
    String loginbtn = request.getParameter("login");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (loginbtn != null && loginbtn.equalsIgnoreCase("login")) {

        if (username != null && password != null) {
            if (!username.trim().equals("") && !password.trim().equals("")) {
                //if ( validateUser(username.trim(), password.trim()) ) {
                if (username.trim().equals("thilina") && password.trim().equals("password")) {

                    session.setAttribute("username", username.toLowerCase().trim());
                    session.setAttribute("password", password.trim());
                    response.sendRedirect("/");
                    return;
                } else {
                    msg = "Incorrect passwords.";
                }
            } else {
                msg = "All fields are required.";
            }
        }
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h3>User Setup</h3>

<form action="login.jsp" method="GET">
    <table width="400" border="0">
        <tr>
            <td>Admin User</td>
            <td><input type="text" name="username"/></td>
        </tr>
        <tr>
            <td>Password</td>
            <td><input type="password" name="password"/></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <input type="submit" name="login" value="Login"/>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><p><% out.println(msg); %></p>
            </td>
        </tr>
    </table>
</form>