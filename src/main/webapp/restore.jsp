<%@ page import="org.srdbs.web.Api" %>
<%@ page import="org.srdbs.web.MyPrint" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%
    if (!Api.systemState()) {

        response.sendRedirect("/setup/");
        return;
    }

    if (session.getAttribute("username") == null) {

        response.sendRedirect("/login.jsp");
        return;

        // } else {


    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<p>Login as : <% if (session.getAttribute("username") != null) {
    out.println(session.getAttribute("username"));
}%></p>
<a href="/logout.jsp">Logout</a>
<table border="2px" cellpadding="10px">
    <form action="restore.jsp" method="post">
        <%

            try {

                String connectionURL = "jdbc:mysql://localhost:3306/srdbsdb";
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection connection = DriverManager.getConnection(connectionURL, "SRDBS", "password");
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
            <td><%=rs.getString(3)%>
            </td>
            <td><%=rs.getString(4)%>
            </td>
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
                    String select[] = request.getParameterValues("id");
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