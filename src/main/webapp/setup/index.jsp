<%@ page import="org.srdbs.web.Setup" %>

<%

    String msg = "";
    if (request.getParameter("back") != null && request.getParameter("back").equalsIgnoreCase("back")) {
        msg = "Back button pressed.";
    }

    if (request.getParameter("adminuser") != null
            && request.getParameter("password") != null
            && request.getParameter("password2") != null)

    {
        String name = request.getParameter("adminuser");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");
        String username = "isanka";
        String passwd = "isa123";


        if (password2.equalsIgnoreCase(passwd) && password.equalsIgnoreCase(passwd) && name.equalsIgnoreCase(username)) {

            session.setAttribute("username", username);
            session.setAttribute("setupstate", "step1");
            response.sendRedirect("/setup/step2.jsp");
            msg = "Should redirect.";

        } else {

            out.println("Login Failed,Please try Againe");
        }

    }


//Check for previous installations.
//Setup.checkInstallation();
//Get
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        <td><input type="submit" name="next" value="Next"/>
                            <input type="submit" name="back" value="Back"/></td>
                        </a>

                    </tr>
                </table>
                <p><% out.println(msg); %></p>
            </form>
        </td>
    </tr>
    <tr align="center" valign="middle">
        <td colspan="10" height="50">&nbsp;</td>
    </tr>
</table>
<script type="text/javascript">


    function validateFormOnSubmit(theForm) {
        var reason = "";

        reason += validateUsername(theForm.username);
        reason += validatePassword(theForm.password);


        if (reason != "") {
            alert("Some fields need correction:\n" + reason);
            return false;
        }

        return true;
    }


    function validateEmpty(fld) {
        var error = "";

        if (fld.value.length == 0) {
            error = "The required field has not been filled in.\n"
        } else {
            alert("Required feilds ok:\n" + reason);
        }
        return error;
    }


    function validateUsername(fld) {
        var error = "";
        var illegalChars = /\W/; // allow letters, numbers, and underscores

        if (fld.value == "") {
            error = "You didn't enter a username.\n";
        } else if ((fld.value.length < 5) || (fld.value.length > 15)) {
            error = "The username is the wrong length.\n";
        } else if (illegalChars.test(fld.value)) {
            error = "The username contains illegal characters.\n";
        } else {
            alert("username is accepted:\n" + reason);
        }
        return error;
    }

    function validatePassword(fld) {
        var error = "";
        var illegalChars = /[\W_]/; // allow only letters and numbers

        if (fld.value == "") {
            error = "You didn't enter a password.\n";
        } else if ((fld.value.length < 7) || (fld.value.length > 15)) {
            error = "The password is the wrong length. \n";

        } else if (illegalChars.test(fld.value)) {
            error = "The password contains illegal characters.\n";

        } else if (!((fld.value.search(/(a-z)+/)) && (fld.value.search(/(0-9)+/)))) {
            error = "The password must contain at least one numeral.\n";

        } else {
            alert("username is accepted:\n" + reason);
        }
        return error;
    }
</script>
</body>
</html>
