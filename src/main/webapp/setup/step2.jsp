<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Set Cloud 1</title>
</head>

<body style="text-align:center;">

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
        response.sendRedirect("/setup/");
    }
    if (request.getParameter("logout") != null && request.getParameter("logout").equalsIgnoreCase("logout")) {
        session.invalidate();
        response.sendRedirect("/setup/");
        msg2 = "You are not logged in ";
    }
    String msg = "";
    if (request.getParameter("c1ipadd") != null
            && request.getParameter("c1uname") != null
            && request.getParameter("c1password") != null
            && request.getParameter("c1cost") != null
            && request.getParameter("c1bandwidth") != null)

    {

        String IPAddress = request.getParameter("c1ipadd");
        String UserName = request.getParameter("c1uname");
        String password = request.getParameter("c1password");
        String Cost = request.getParameter("c1cost");
        String Bandwidth = request.getParameter("c1bandwidth");
        String c1uname = "namal";
        if (UserName.equalsIgnoreCase("c1uname") && password.equalsIgnoreCase("c1password")) {

            session.setAttribute("c1ipadd", "c1ipadd");
            session.setAttribute("c1uname", "c1uname");
            session.setAttribute("c1password", "c1password");
            session.setAttribute("c1cost", "c1cost");
            session.setAttribute("c1bandwidth", "1bandwidth");
            session.setAttribute("setupstate", "step2");
            response.sendRedirect("/setup/step3.jsp");
        } else if (!password.equalsIgnoreCase("")) {

            msg = "Please  enter your password!";
        } else if (!UserName.equalsIgnoreCase("")) {

            msg = "Please  enter your Username!";
        } else if (!IPAddress.equalsIgnoreCase("")) {

            msg = "Please  enter IPAddress!";
        } else if (!Cost.equalsIgnoreCase("")) {

            msg = "Please  enter cost!";
        } else if (!Bandwidth.equalsIgnoreCase("")) {

            msg = "Please  enter Bandwidth!";
        } else {

            msg = "Your input is not correct!";
        }
    }

%>


<A HREF="step3.jsp">Continue</A>
<table width="600" border="0" align="center" style="margin-top:200px; background-color:#00F; color:#FFF;">
    <tr align="center" valign="middle">
        <td height="60">Step 1</td>
        <td style="background-color:#FF0; color:#F00;">Step 2</td>
        <td>Step 3</td>
        <td>Step 4</td>
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
                        <td><input type="text" name="c1ipadd"/></td>
                    </tr>
                    <tr>
                        <td>User Name</td>
                        <td><input type="text" name="c1uname"/></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" name="c1password"/></td>
                    </tr>
                    <tr>
                        <td>Cost</td>
                        <td><input type="text" name="c1cost"/></td>
                    </tr>
                    <tr>
                        <td>Bandwidth</td>
                        <td><input type="text" name="c1bandwidth"/></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><a href="step3.jsp"><input type="submit" name="c1setup" value="Next"></a></td>
                        </a>
                        <td><a href="index.jsp"><input type="submit" name="c1setup" value="Back"></a></td>
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
