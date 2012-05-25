<%@ page import="org.srdbs.web.Setup" %>

<%
    String loginStatus = "";
    if (request.getParameter("adminuser") != "" && request.getParameter("password") != "") {
        loginStatus = "User name = " + request.getParameter("adminuser");
        loginStatus += "Password = " + request.getParameter("password");

    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Login</title>
</head>

<body style="text-align:center;">
<table width="600" border="0" align="center" style="margin-top:200px; background-color:#00F; color:#FFF;">
    <tr align="center" valign="middle">
        <td height="60">&nbsp;</td>
        <td>&nbsp;</td>
    </tr>
    <tr align="center" valign="middle">
        <td colspan="10" height="200">
            <form action="/login.jsp" method="post">
                <table width="400" border="0">
                    <tr>
                        <td>Admin User Name</td>
                        <td><input type="text" name="adminuser"/></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" name="password"/></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" name="login" value="login"/></td>
                    </tr>
                </table>
                <p><% if (loginStatus != null)
                    out.print(loginStatus);%></p>
            </form>
        </td>
    </tr>
    <tr align="center" valign="middle">
        <td colspan="10" height="50">&nbsp;</td>
    </tr>
</table>
</body>
</html>
