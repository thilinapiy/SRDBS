<%@ page import="org.srdbs.core.Api" %>
<%@ page import="org.srdbs.web.MyPrint" %>

<%
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