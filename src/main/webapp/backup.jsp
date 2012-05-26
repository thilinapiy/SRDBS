<%@ page import="org.srdbs.sftp.Sftp" %>
<%@ page import="org.srdbs.split.Split" %>

<%
    String copyStatus1 = "";
    String copyStatus2 = "";
    String copyStatus3 = "";
    String copyStatus4 = "";
    String copyStatus5 = "";

    //todo: session handling
    if (request.getParameter("submit") != null && request.getParameter("submit").equalsIgnoreCase("submit")) {
        if (request.getParameter("path1").toString() != null) {
            // copyStatus1 = Sftp.copyFile(request.getParameter("path1").toString());
            int result = Split.mySplit(request.getParameter("path1"), request.getParameter("path1"), 1048576);
            //  int result = Join.myJoin(request.getParameter("path1").toString(), request.getParameter("path1").toString());

            if (result == 0)
                copyStatus1 = "Success Full.";
            else
                copyStatus1 = "Error.";
        }
        if (request.getParameter("path2").toString() != null) {
            //copyStatus2 = Sftp.copyFile(request.getParameter("path2").toString());
        }
        if (request.getParameter("path3").toString() != null) {
            //copyStatus3 = Sftp.copyFile(request.getParameter("path3").toString());
        }
        if (request.getParameter("path4").toString() != null) {
            //copyStatus4 = Sftp.copyFile(request.getParameter("path4").toString());
        }
        if (request.getParameter("path5").toString() != null) {
            //copyStatus5 = Sftp.copyFile(request.getParameter("path5").toString());
        }
    }

%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SRDBS | Backup</title>
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
        <h3>Backup</h3>

        <form method="post" action="backup.jsp">
            Backup folder 1 : <input type="text" name="path1">

            <p><% out.println(copyStatus1); %></p><br/>
            Backup folder 2 : <input type="text" name="path2">

            <p><% out.println(copyStatus2); %></p><br/>
            Backup folder 3 : <input type="text" name="path3">

            <p><% out.println(copyStatus3); %></p><br/>
            Backup folder 4 : <input type="text" name="path4">

            <p><% out.println(copyStatus4); %></p><br/>
            Backup folder 5 : <input type="text" name="path5">

            <p><% out.println(copyStatus5); %></p><br/>
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