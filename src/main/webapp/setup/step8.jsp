<%@ page import="org.srdbs.web.Setup" %>

<% String msg = "";
    String backbtn = request.getParameter("back");
    String submitbtn = request.getParameter("submit");

    session.setAttribute("setupstate", "Done");
    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        response.sendRedirect("/setup/step7.jsp");
        return;
    }

    if (submitbtn != null && submitbtn.equalsIgnoreCase("Submit")) {

        boolean status = Setup.checkInstallation(session);
        if (status) {
            response.sendRedirect("/");
            return;
        } else {
            msg = "Error occurred.";
        }
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
                        out.println("System User : " + session.getAttribute("username"));
                        out.println("Password    : " + session.getAttribute("password"));

                        out.println("");
                        out.println("Database");
                        out.println(session.getAttribute("ipaddress"));
                        out.println(session.getAttribute("dbport"));
                        out.println(session.getAttribute("dbname"));
                        out.println(session.getAttribute("dbuser"));
                        out.println(session.getAttribute("dbpassword"));

                        out.println("");
                        out.println("Cloud 1");
                        out.println(session.getAttribute("c1ipaddress"));
                        out.println(session.getAttribute("c1port"));
                        out.println(session.getAttribute("c1remotepath"));
                        out.println(session.getAttribute("c1username"));
                        out.println(session.getAttribute("c1password"));
                        out.println(session.getAttribute("c1bandwidth"));
                        out.println(session.getAttribute("c1cost"));


                        out.println("");
                        out.println("Cloud 2");
                        out.println(session.getAttribute("c2ipaddress"));
                        out.println(session.getAttribute("c2port"));
                        out.println(session.getAttribute("c2remotepath"));
                        out.println(session.getAttribute("c2username"));
                        out.println(session.getAttribute("c2password"));
                        out.println(session.getAttribute("c2bandwidth"));
                        out.println(session.getAttribute("c2cost"));

                        out.println("");
                        out.println("Cloud 3");
                        out.println(session.getAttribute("c3ipaddress"));
                        out.println(session.getAttribute("c3port"));
                        out.println(session.getAttribute("c3remotepath"));
                        out.println(session.getAttribute("c3username"));
                        out.println(session.getAttribute("c3password"));
                        out.println(session.getAttribute("c3bandwidth"));
                        out.println(session.getAttribute("c3cost"));

                        out.println("");
                        out.println("System Locations");
                        out.println(session.getAttribute("templocation"));
                        out.println(session.getAttribute("restorelocation"));

                        out.println("");
                        out.println("Baclup locations");
                        out.println(session.getAttribute("backuplocation1") + " - " + session.getAttribute("schedule1"));
                        out.println(session.getAttribute("backuplocation2") + " - " + session.getAttribute("schedule2"));
                        out.println(session.getAttribute("backuplocation3") + " - " + session.getAttribute("schedule3"));
                        out.println(session.getAttribute("backuplocation4") + " - " + session.getAttribute("schedule4"));
                        out.println(session.getAttribute("backuplocation5") + " - " + session.getAttribute("schedule5"));

                    %>
				</pre>
            </td>
        </tr>
        <tr>
            <td>
                <input type="submit" name="back" value="Back"/>
                <input type="submit" name="submit" value="Submit"/>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><p><% out.println(msg); %></p>
            </td>
        </tr>
    </table>
</form>