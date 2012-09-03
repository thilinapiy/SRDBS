<%@ page import="org.srdbs.web.Api" %>

<%
    if (!Api.systemState()) {

        response.sendRedirect("/setup/");
        return;
    }

    if (session.getAttribute("username") == null) {

        response.sendRedirect("/login.jsp");
        return;

    } else {

        if (request.getParameter("restartbtn") != null && request.getParameter("restartbtn").equalsIgnoreCase("restart")) {

            Api.restartCore();
        }

        if (request.getParameter("stopbtn") != null && request.getParameter("stopbtn").equalsIgnoreCase("stop")) {

            Api.stopCore();
        }
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<!-- start content-outer -->
<div id="content-outer">
    <!-- start content -->
    <div id="content">

        <div id="page-heading"><h1>Dashboard</h1></div>

        <table border="0" width="100%" cellpadding="0" cellspacing="0" id="content-table">
            <tr>
                <th rowspan="3" class="sized"><img src="/images/shared/side_shadowleft.jpg" width="20" height="300"
                                                   alt=""/></th>
                <th class="topleft"></th>
                <td id="tbl-border-top">&nbsp;</td>
                <th class="topright"></th>
                <th rowspan="3" class="sized"><img src="/images/shared/side_shadowright.jpg" width="20" height="300"
                                                   alt=""/></th>
            </tr>
            <tr>
                <td id="tbl-border-left"></td>
                <td>
                    <!--  start content-table-inner ...................................................................... START -->
                    <div id="content-table-inner">

                        <!--  start table-content  -->
                        <%@ include file="UploadProgress.jsp" %>
                        <div id="table-content">

                            <!-- form action="index.jsp" method="post">
                                <input type="submit" name="restartbtn" value="restart">
                                <input type="submit" name="stopbtn" value="stop">                             
                            </form -->
                        </div>
                        <!--  end table-content  -->

                        <div class="clear"></div>
                    </div>
                    <!--  end content-table-inner ............................................END  -->
                </td>
                <td id="tbl-border-right"></td>
            </tr>
            <tr>
                <th class="sized bottomleft"></th>
                <td id="tbl-border-bottom">&nbsp;</td>
                <th class="sized bottomright"></th>
            </tr>
        </table>


        <div class="clear">&nbsp;</div>
    </div>
    <!--  end content -->
    <div class="clear">&nbsp;</div>
</div>

<!-- end content-outer -->
<%@ include file="footer.jsp" %>