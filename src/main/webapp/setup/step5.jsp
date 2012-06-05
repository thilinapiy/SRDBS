<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Set Backup Locations</title>
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
        response.sendRedirect("/setup/step4.jsp");
    }

    if (request.getParameter("logout") != null && request.getParameter("logout").equalsIgnoreCase("logout")) {
        session.invalidate();
        response.sendRedirect("/setup/");
    }

    String msg = "";
    if (request.getParameter("blocation1") != null
            && request.getParameter("blocation2") != null
            && request.getParameter("blocation3") != null
            && request.getParameter("blocation4") != null
            && request.getParameter("blocation5") != null)

    {

        String BackupLocation1 = request.getParameter("blocation1");
        String BackupLocation2 = request.getParameter("blocation2");
        String BackupLocation3 = request.getParameter("blocation3");
        String BackupLocation4 = request.getParameter("blocation4");
        String BackupLocation5 = request.getParameter("blocation5");

        session.setAttribute("blocation1", "blocation1");
        session.setAttribute("blocation2", "blocation2");
        session.setAttribute("blocation3", "blocation3");
        session.setAttribute("blocation4", "blocation4");
        session.setAttribute("blocation5", "blocation5");
        session.setAttribute("setupstate", "step5");
        if (!BackupLocation1.equalsIgnoreCase("")) {

            msg = "Enter Backup Location 1!";
        } else if (!BackupLocation2.equalsIgnoreCase("")) {

            msg = "Enter Backup Location 2!";
        } else if (!BackupLocation3.equalsIgnoreCase("")) {

            msg = "Enter Backup Location 3!";
        } else if (!BackupLocation4.equalsIgnoreCase("")) {

            msg = "Enter Backup Location 4!";
        } else if (!BackupLocation5.equalsIgnoreCase("")) {

            msg = "Enter Backup Location 4!";
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
        <td>Step 4</td>
        <td style="background-color:#FF0; color:#F00;">Step 5</td>
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
                        <td>Backup Location 1</td>
                        <td><input type="text" name="blocation1"/></td>
                    </tr>
                    <tr>
                        <td>Backup Location 2</td>
                        <td><input type="text" name="blocation2"/></td>
                    </tr>
                    <tr>
                        <td>Backup Location 3</td>
                        <td><input type="text" name="blocation3"/></td>
                    </tr>
                    <tr>
                        <td>Backup Location 4</td>
                        <td><input type="text" name="blocation4"/></td>
                    </tr>
                    <tr>
                        <td>Backup Location 5</td>
                        <td><input type="text" name="blocation5"/></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><a href="step6.jsp"><input type="submit" name="backuplocations" value="Next"></a></td>
                        <td><input type="submit" name="back" value="Back"/></td>
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
</body>
</html>
