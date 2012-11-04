<!-- HTML Start -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>SRDBS</title>
    <link rel="stylesheet" href="/css/screen.css" type="text/css" media="screen" title="default"/>
</head>
<body>
<!-- Start: page-top-outer -->
<div id="page-top-outer">
    <!-- Start: page-top -->
    <div id="page-top">
        <!-- start logo -->
        <div id="logo">
            <a href="/"><!-- h1 style="color:white;">Secure and Redundant Data Backup System</h1 -->
                <img src="/images/shared/logo_new.png"  alt=""/></a>
        </div>
        <!-- end logo -->
        <div class="clear"></div>
    </div>
    <!-- End: page-top -->
</div>
<!-- End: page-top-outer -->
<div class="clear">&nbsp;</div>

<!--  start nav-outer-repeat................................................................................................. START -->
<div class="nav-outer-repeat">
    <!--  start nav-outer -->
    <div class="nav-outer">
        <!-- start nav-right -->
        <div id="nav-right">
            <div class="nav-divider">&nbsp;</div>
            <div class="showhide-account" width="93" height="14"><h3>
                <% if (session.getAttribute("username") != null) {
                    String name = session.getAttribute("username").toString();
                    char[] stringArray = name.toCharArray();
                    stringArray[0] = Character.toUpperCase(stringArray[0]);
                    out.println(new String(stringArray));
                }%>
            </h3></div>
            <div class="nav-divider">&nbsp;</div>
            <a href="/logout.jsp" id="logout">
                <img src="/images/shared/nav/nav_logout.gif" width="64" height="14" alt=""/></a>

            <div class="clear">&nbsp;</div>
        </div>
        <!-- end nav-right -->

        <!--  start nav -->
        <div class="nav">
            <div class="table">
                <ul class="current">
                    <li><a href="/"><b>Dashboard</b></a></li>
                </ul>

                <div class="nav-divider">&nbsp;</div>
                <ul class="select">
                    <li><a href="#"><b>Clouds</b></a>

                        <div class="select_sub">
                            <ul class="sub">
                                <li><a href="/cloud1.jsp">Cloud 1</a></li>
                                <li><a href="/cloud2.jsp">Cloud 2</a></li>
                                <li><a href="/cloud3.jsp">Cloud 3</a></li>
                                <li><a href="/changecloud.jsp">Change a cloud</a></li>
                                <!--li><a href="/newcloud.jsp">Add new cloud</a></li -->
                            </ul>
                        </div>
                    </li>
                </ul>
                <div class="nav-divider">&nbsp;</div>

                <ul class="select">
                    <li><a href="/scheduler.jsp"><b>Schedule</b></a></li>
                </ul>
                <div class="nav-divider">&nbsp;</div>

                <ul class="select">
                    <li><a href="/restore.jsp"><b>Restore</b></a></li>
                </ul>
                <div class="nav-divider">&nbsp;</div>

                <!-- ul class="select">
                    <li><a href="#"><b>Logs</b></a>
                     <div class="select_sub">
                            <ul class="sub">
                                <li><a href="/logs/syslog.jsp">System Log</a></li>
                                <li><a href="/logs/backuplog.jsp">Backup Log</a></li>
                                <li><a href="/logs/restorelog.jsp">Restore Log</a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
                <div class="nav-divider">&nbsp;</div -->

                <ul class="select">
                    <li><a href="#"><b>Help</b></a></li>
                </ul>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
        <!--  start nav -->

    </div>
    <div class="clear"></div>
    <!--  start nav-outer -->
</div>
<!--  start nav-outer-repeat................................................... END -->

<div class="clear"></div>
