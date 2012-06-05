<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Set Cloud 3</title>
</head>

<body style="text-align:center;">
<%
    String msg2 = "";

    if (session.getAttribute("username") != null &&
            String.valueOf(session.getAttribute("username")).equalsIgnoreCase("setup")) {
        msg2 = "Loged in as : " + String.valueOf(session.getAttribute("username"));

    } else {
        response.sendRedirect("/setup/");
    }

    if (request.getParameter("back") != null && request.getParameter("back").equalsIgnoreCase("back")) {
        response.sendRedirect("/setup/step6.jsp");
    }

    if (request.getParameter("logout") != null && request.getParameter("logout").equalsIgnoreCase("logout")) {
        session.invalidate();
        response.sendRedirect("/setup/");
    }

    out.println("Cloud 1 IP Address :  " + (String) session.getAttribute("c1ipadd") + "<br/>");
    out.println("Cloud 1 IP Bandwidth :" + (String) session.getAttribute("c1bandwidth") + "<br/>");
    out.println("Cloud 1 IP Cost :     " + (String) session.getAttribute("c1cost") + "<br/>");

    out.println("Cloud 2 IP Address :" + (String) session.getAttribute("c2ipadd") + "<br/>");
    out.println("Cloud 2 IP Bandwidth :" + (String) session.getAttribute("c2bandwidth") + "<br/>");
    out.println("Cloud 2 IP Cost :" + (String) session.getAttribute("c2cost") + "<br/>");

    out.println("Cloud 3 IP Address :" + (String) session.getAttribute("c3ipadd") + "<br/>");
    out.println("Cloud 3 IP Bandwidth :" + (String) session.getAttribute("c3bandwidth") + "<br/>");
    out.println("Cloud 3 IP Cost :" + (String) session.getAttribute("c3cost") + "<br/>");

%>

<tr>
    <td>&nbsp;</td>
    <td><a href="final.jsp"><input type="submit" name="c3setup" value="Next"></a>/td>
    <td><input type="submit" name="back" value="Back"/></td>
    <td><input type="submit" name="logout" value="Logout"></td>
    <td><input type="submit" name="accept" value="Accept"></td>

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

    
