<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Set Cloud 3</title>
</head>

<body style="text-align:center;">


<A HREF="step5.jsp">Continue</A>
<%
    String msg2 = "";
    String preState = "";
    String postState = "";
    if (session.getAttribute("username") != null &&
            String.valueOf(session.getAttribute("username")).equalsIgnoreCase("setup")) {
        msg2 = "Loged in as : " + String.valueOf(session.getAttribute("username"));
        preState = String.valueOf(session.getAttribute("setupstate"));
        session.setAttribute("setupstate", "login success");
        postState = String.valueOf(session.getAttribute("setupstate"));
    } else {
        response.sendRedirect("/setup/");
    }

    if (request.getParameter("back") != null && request.getParameter("back").equalsIgnoreCase("back")) {
        response.sendRedirect("/setup/step3.jsp");
    }
    if (request.getParameter("logout") != null && request.getParameter("logout").equalsIgnoreCase("logout")) {
        session.invalidate();
        response.sendRedirect("/setup/");
    }

    String msg = "";
    if (request.getParameter("c3ipadd") != null
            && request.getParameter("c3uname") != null
            && request.getParameter("c3password") != null
            && request.getParameter("c3cost") != null
            && request.getParameter("c3bandwidth") != null)

    {

        String IPAddress = request.getParameter("c3ipadd");
        String UserName = request.getParameter("c3uname");
        String password = request.getParameter("c3password");
        String Cost = request.getParameter("c3cost");
        String Bandwidth = request.getParameter("c3bandwidth");

        if (UserName.equals("c3uname") && password.equals("c3password")) {

            session.setAttribute("c3ipadd", "c3ipadd");
            session.setAttribute("c3uname", "c3uname");
            session.setAttribute("c3password", "c3password");
            session.setAttribute("c3cost", "c3cost");
            session.setAttribute("c3bandwidth", "c3bandwidth");
            session.setAttribute("setupstate", "step4");
            response.sendRedirect("/setup/step4.jsp");
        } else if (!password.equals("")) {

            msg = "Please  enter your password!";
        } else if (!UserName.equals("")) {

            msg = "Please  enter your Username!";
        } else if (!IPAddress.equals("")) {

            msg = "Please  enter IPAddress!";
        } else if (!Cost.equals("")) {

            msg = "Please  enter cost!";
        } else if (!Bandwidth.equals("")) {

            msg = "Please  enter Bandwidth!";
        } else {

            msg = "Your input is not correct!";
        }
    }

%>
<table width="600" border="0" align="center" style="margin-top:200px; background-color:#00F; color:#FFF;">
    <tr align="center" valign="middle">
        <td height="60">Step 1</td>
        <td>Step 2</td>
        <td>Step 3</td>
        <td style="background-color:#FF0; color:#F00;">Step 4</td>
        <td>Step 5</td>
        <td>Step 6</td>
        <td>Step 7</td>
        <td>Step 8</td>
        <td>Step 9</td>
        <td>Final</td>
    </tr>
    <tr align="center" valign="middle">
        <td colspan="10" height="200">
            <form action="" method="post">
                <table width="400" border="0">
                    <tr>
                        <td>IP address</td>
                        <td><input type="text" name="c3ipadd"/></td>
                    </tr>
                    <tr>
                        <td>User Name</td>
                        <td><input type="text" name="c3uname"/></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" name="c3password"/></td>
                    </tr>
                    <tr>
                        <td>Cost</td>
                        <td><input type="text" name="c3cost"/></td>
                    </tr>
                    <tr>
                        <td>Bandwidth</td>
                        <td><input type="text" name="c3bandwidth"/></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><a href="step5.jsp"><input type="submit" name="c3setup" value="Next"></a></td>
                        </a>
                        <td><input type="submit" name="back" value="Back"/></td>
                        </a>
                        <td><input type="submit" name="logout" value="Logout"></td>

                    </tr>
                </table>
            </form>
        </td>
    </tr>
    <tr align="center" valign="middle">
        <td colspan="10" height="50">&nbsp;</td>
    </tr>
</table>
<p><%
    out.println(msg2);

%></p>
</body>
</html>
