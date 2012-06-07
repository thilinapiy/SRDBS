<%@ page import="org.srdbs.web.Setup" %>

<% String msg = "";
    String backbtn = request.getParameter("back");
    String nextbtn = request.getParameter("Submit");

    session.setAttribute("setupstate", "Done");
    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        response.sendRedirect("/setup/step6.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("Submit")) {
        response.sendRedirect("/");
        return;
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h3>Final</h3>

<form action="" method="GET">
    <table width="400" border="0">
        <tr>
            <td>
				<pre>
					<%
                        out.println(session.getAttribute("setupstate"));

                        out.println("");
                        out.println("Admin details");
                        out.println(session.getAttribute("username"));
                        out.println(session.getAttribute("password"));

                        out.println("");
                        out.println("Database");
                        out.println(session.getAttribute("ipaddress"));
                        out.println(session.getAttribute("port"));
                        out.println(session.getAttribute("dbuser"));
                        out.println(session.getAttribute("dbpassword"));

                        out.println("");
                        out.println("Cloud 1");
                        out.println(session.getAttribute("c1ipaddress"));
                        out.println(session.getAttribute("c1port"));
                        out.println(session.getAttribute("c1username"));
                        out.println(session.getAttribute("c1password"));
                        out.println(session.getAttribute("c1bandwidth"));
                        out.println(session.getAttribute("c1cost"));

                        out.println("");
                        out.println("Cloud 2");
                        out.println(session.getAttribute("c2ipaddress"));
                        out.println(session.getAttribute("c2port"));
                        out.println(session.getAttribute("c2username"));
                        out.println(session.getAttribute("c2password"));
                        out.println(session.getAttribute("c2bandwidth"));
                        out.println(session.getAttribute("c2cost"));

                        out.println("");
                        out.println("Cloud 3");
                        out.println(session.getAttribute("c3ipaddress"));
                        out.println(session.getAttribute("c3port"));
                        out.println(session.getAttribute("c3username"));
                        out.println(session.getAttribute("c3password"));
                        out.println(session.getAttribute("c3bandwidth"));
                        out.println(session.getAttribute("c3cost"));

                        out.println(session.getAttribute("templocation"));
                        out.println(session.getAttribute("restorelocation"));
                    %>
				</pre>
            </td>
        </tr>
        <tr>
            <td>
                <input type="submit" name="back" value="Back"/>
                <input type="submit" name="next" value="Submit"/>
            </td>
        </tr>
    </table>
</form>