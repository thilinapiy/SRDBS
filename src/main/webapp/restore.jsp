<%@ page import="org.srdbs.web.Api" %>
<%@ page import="org.srdbs.core.RunRestore" %>
<%@ page import="org.srdbs.core.DbConnect" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%
    String select[] = request.getParameterValues("id");

    if (!Api.systemState()) {

        response.sendRedirect("/setup/");
        return;
    }

    if (session.getAttribute("username") == null) {

        response.sendRedirect("/login.jsp");
        return;
    } else {

        if (select != null && select.length != 0) {
            for (int i = 0; i < select.length; i++) {
                RunRestore.runRestore(Integer.valueOf(select[i]));
                System.out.println("----------------------------------- isanka ---------------------------");
            }
        }

    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!-- start content-outer -->
<div id="content-outer">
    <!-- start content -->
    <div id="content">

        <div id="page-heading"><h1>Restore</h1></div>

        <table border="0" width="100%" cellpadding="0" cellspacing="0" id="content-table">
            <tr>
                <th rowspan="3" class="sized"><img src="images/shared/side_shadowleft.jpg" width="20" height="300"
                                                   alt=""/></th>
                <th class="topleft"></th>
                <td id="tbl-border-top">&nbsp;</td>
                <th class="topright"></th>
                <th rowspan="3" class="sized"><img src="images/shared/side_shadowright.jpg" width="20" height="300"
                                                   alt=""/></th>
            </tr>
            <tr>
                <td id="tbl-border-left"></td>
                <td>
                    <!--  start content-table-inner ...................................................................... START -->
                    <div id="content-table-inner">

                        <!--  start table-content  -->
                        <div id="table-content">


                            <!-- This is the start of the restore table. -->
                            <table id="restore-table" border="4px">
                                <tr>
                                    <th>Select</th>
                                    <th>File ID</th>
                                    <th>File Name</th>
                                    <th>File Size in KB</th>
                                    <!-- th>Hash Value</th -->
                                    <th>Backuped Time</th>
                                </tr>

                                <form action="restore.jsp" method="post">
                                    <%
                                        try {

                                            Connection connection = new DbConnect().webDbConnect();
                                            Statement statement = connection.createStatement();
                                            String QueryString = "SELECT * from Full_File";
                                            ResultSet rs = statement.executeQuery(QueryString);

                                            while (rs.next()) {
                                    %>
                                    <tr>
                                        <td><input type="checkbox" name="id" value=<%=rs.getLong(1)%>></td>
                                        <td><%=rs.getLong(1)%>
                                        </td>
                                        <td><%=rs.getString(2)%>
                                        </td>
                                        <td><%=rs.getString(3) + " KB"%>
                                        </td>
                                        <!-- td><%=rs.getString(4)%></td -->
                                        <td><%=rs.getString(5)%>
                                        </td>
                                    </tr>
                                    <%
                                            }
                                            rs.close();
                                            statement.close();
                                            connection.close();
                                        } catch (Exception ex) {
                                            out.println("Unable to connect to database.");
                                        }
                                    %>
                                    <tr>
                                        <td>
                                            <input type="submit" value="Submit"/>
                                        </td>
                                        <td colspan="5">
                                            <%
                                                if (select != null && select.length != 0) {
                                                    out.println("You have selected: ");
                                                    for (int i = 0; i < select.length; i++) {
                                                        out.println(select[i]);
                                                    }
                                                }
                                            %>
                                        </td>
                                    </tr>
                                </form>
                            </table>

                            <!-- This is the end of the restore table.-->

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