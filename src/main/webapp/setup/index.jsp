<%@ page import="org.srdbs.web.Setup" %>

<%
    // Check for previous installations.
    //Setup.checkInstallation();
    //Get
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Set admin user and password</title>
</head>

<body style="text-align:center;">
<table width="600" border="0" align="center" style="margin-top:200px; background-color:#00F; color:#FFF;">
    <tr align="center" valign="middle">
        <td height="60" style="background-color:#FF0; color:#F00;">Step 1</td>
        <td>Step 2</td>
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
                        <td>Admin User</td>
                        <td><input type="text" name="adminuser"/></td>
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
                        <td><input type="submit" name="admin" value="Next"/></td>
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
