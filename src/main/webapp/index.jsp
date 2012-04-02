<%@ page import="org.srdbs.web.MyPrint" %>
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
	<div  class="wrapper">
    	<h3><% out.println(MyPrint.send()); %> </p></h3>
	</div>
</div>
<div class="footer">
	<div  class="wrapper">
	<p>Creatvice Common Lisens.</p>
	</div>
</div>
</body>
</html>