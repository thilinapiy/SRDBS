<%@ page import="org.srdbs.web.Api" %>
<%@ page import="org.srdbs.web.MyPrint" %>

<%
    response.sendRedirect("/setup/");
    //todo: session handling
    if (request.getParameter("restartbt") != null && request.getParameter("restartbt").equalsIgnoreCase("restart")) {

        System.out.println("Restart method called.");
        out.print("Restart ...");
        Api.restartCore();
    }

    if (request.getParameter("stopbt") != null && request.getParameter("stopbt").equalsIgnoreCase("stop")) {

        System.out.println("Stop method called.");
        out.print("Stop ...");
        Api.stopCore();
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SRDBS | Welcome</title>
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
        <h3><% out.println(MyPrint.send()); %></h3>

        <form action="index.jsp" method="post">
            <input type="submit" name="restartbt" value="restart">
            <input type="submit" name="stopbt" value="stop">
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