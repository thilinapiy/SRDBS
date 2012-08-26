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
                if (Api.validateUser(username.trim(), password.trim())) {
                    //if (username.trim().equals("thilina") && password.trim().equals("password")) {

                    session.setAttribute("username", username.toLowerCase().trim());
                    //session.setAttribute("password", password.trim());
                    response.sendRedirect("/");
                    return;
                } else {
                    msg = "The username or password you entered is incorrect.";
                }
            } else {
                msg = "All fields are required.";
            }
        }
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>SRDBS</title>
    <link rel="stylesheet" href="/css/screen.css" type="text/css" media="screen" title="default"/>
</head>
<body id="login-bg">

<!-- Start: login-holder -->
<div id="login-holder">
    <!-- start logo -->
    <div id="logo-login"><h1 style="color:white;">Secure and Redundant Data Backup System</h1></div>
    <!-- end logo -->

    <div class="clear"></div>
    <!--  start loginbox ................................................................................. -->
    <div id="loginbox">
        <!--  start login-inner -->
        <div id="login-inner">
            <form action="login.jsp" method="POST">  <!-- //TODO: change this to POST -->
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <th>Username</th>
                        <td><input type="text" class="login-inp" name="username"/></td>
                    </tr>
                    <tr>
                        <th>Password</th>
                        <td><input type="password" name="password" onfocus="this.value=''" class="login-inp"/></td>
                    </tr>
                    <tr>
                        <td colspan='2' valign="top"><% if (msg == null) out.println("<br />");
                        else out.println(msg); %></td>
                    </tr>
                    <!-- tr>
                         <th></th>
                         <td valign="top"><input type="checkbox" name="login" class="checkbox-size" id="login-check" /><label for="login-check">Remember me</label></td>
                     </tr -->
                    <tr>
                        <th></th>
                        <td><input type="submit" name="login" value="Login" class="submit-login"/></td>
                    </tr>
                </table>
            </form>
        </div>
        <!--  end login-inner -->
        <!-- div class="clear"></div -->
        <!-- a href="" class="forgot-pwd">Forgot Password?</a -->

    </div>
    <!--  end loginbox -->
</div>
<!-- End: login-holder -->
</body>
</html>