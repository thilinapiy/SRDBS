<%@ page import="org.srdbs.sftp.Sftp" %>

<%
    String copyStatus1 = "";

    //todo: session handling
    /*  if (request.getParameter("submit") != null && request.getParameter("submit").equalsIgnoreCase("submit")) {
        if (request.getParameter("path1").toString() != null)
        {
            copyStatus1 = Sftp.copyFile(request.getParameter("path1").toString());
        }
    }
    */
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SRDBS | Config</title>
    <link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="header">
    <div align="center">
        <img src="images/header.png" alt="SRDBS Logo">
    </div>
</div>
<div class="navi">
    <div class="wrapper">
        <table width="943" height="31">
            <tr>
                <td class="navtab"><a href="./status.jsp">Status</a></td>
                <td class="navtab"><a href="./config.jsp">Configuration</a></td>
                <td class="navtab"><a href="./backup.jsp">Backup</a></td>
                <td class="navtab"><a href="./restore.jsp">Restore</a></td>
                <td class="navtab"><a href="./logs.jsp">Logs</a></td>
                <td class="navtab"><a href="./contacts.jsp">Contacts</a></td>
            </tr>
        </table>
    </div>
</div>
<div class="body">
    <div class="wrapper">
        <h3>Config</h3>

        <form method="post" action="config.jsp">
            IP Address : <input type="text" name="ipaddr1"><br/>
            User Name : <input type="text" name="uname1"><br/>
            password : <input type="password" name="passwd1"><br/>
            <br/>
            IP Address : <input type="text" name="ipaddr2"><br/>
            User Name : <input type="text" name="uname2"><br/>
            password : <input type="password" name="passwd2"><br/>
            <br/>
            IP Address : <input type="text" name="ipaddr3"><br/>
            User Name : <input type="text" name="uname3"><br/>
            password : <input type="password" name="passwd3"><br/>
            <input type="submit" name="submit" value="submit">
        </form>
    </div>
</div>
<div class="footer">
    <div class="wrapper">
        <p>Creative Common Lichens.</p>
    </div>
</div>
</body>
</html>