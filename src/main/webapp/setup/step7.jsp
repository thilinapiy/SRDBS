<%@ page import="org.srdbs.web.Api" %>

<%
    if (Api.systemState()) {

        response.sendRedirect("/");
        return;
    }

    if (!session.getAttribute("setupstate").equals("step7")) {
        response.sendRedirect("/setup/" + session.getAttribute("setupstate") + ".jsp");
        return;
    }

    String msg = "";
    String backbtn = request.getParameter("back");
    String nextbtn = request.getParameter("next");


    String backuplocation1 = request.getParameter("backuplocation1");
    String backuplocation2 = request.getParameter("backuplocation2");
    String backuplocation3 = request.getParameter("backuplocation3");
    String backuplocation4 = request.getParameter("backuplocation4");
    String backuplocation5 = request.getParameter("backuplocation5");
    String schedule1 = request.getParameter("schedule1");
    String schedule2 = request.getParameter("schedule2");
    String schedule3 = request.getParameter("schedule3");
    String schedule4 = request.getParameter("schedule4");
    String schedule5 = request.getParameter("schedule5");

    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        session.setAttribute("setupstate", "step6");
        response.sendRedirect("/setup/step6.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (backuplocation1 != null && backuplocation2 != null && backuplocation3 != null && backuplocation4 != null && backuplocation5 != null) {
            if (!backuplocation1.trim().equals("") && !backuplocation2.trim().equals("") && !backuplocation3.trim().equals("")
                    && !backuplocation4.trim().equals("") && !backuplocation5.trim().equals("")) {

                session.setAttribute("backuplocation1", backuplocation1.toLowerCase().trim());
                session.setAttribute("backuplocation2", backuplocation2.toLowerCase().trim());
                session.setAttribute("backuplocation3", backuplocation3.toLowerCase().trim());
                session.setAttribute("backuplocation4", backuplocation4.toLowerCase().trim());
                session.setAttribute("backuplocation5", backuplocation5.toLowerCase().trim());

                session.setAttribute("schedule1", schedule1.toLowerCase().trim());
                session.setAttribute("schedule2", schedule2.toLowerCase().trim());
                session.setAttribute("schedule3", schedule3.toLowerCase().trim());
                session.setAttribute("schedule4", schedule4.toLowerCase().trim());
                session.setAttribute("schedule5", schedule5.toLowerCase().trim());

                session.setAttribute("setupstate", "step8");
                response.sendRedirect("/setup/step8.jsp");
                return;
            } else {
                msg = "All fields are required.";
            }
        }
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h3>Backup Locations Setup</h3>

<form action="" method="GET">
    <table width="400" border="0">
        <tr>
            <td>Backup location 1</td>
            <td><input type="text" name="backuplocation1"
                       value="<% if(session.getAttribute("backuplocation1")!=null) { out.println(session.getAttribute("backuplocation1")); } %>"/>
            </td>
            <td>
                <select name="schedule1">
                    <option value="monthly">@monthly</option>
                    <option value="weekly">@weekly</option>
                    <option value="daily">@daily</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>Backup location 2</td>
            <td><input type="text" name="backuplocation2"
                       value="<% if(session.getAttribute("backuplocation2")!=null) { out.println(session.getAttribute("backuplocation2")); } %>"/>
            </td>
            <td>
                <select name="schedule2">
                    <option value="monthly">@monthly</option>
                    <option value="weekly">@weekly</option>
                    <option value="daily">@daily</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>Backup location 3</td>
            <td><input type="text" name="backuplocation3"
                       value="<% if(session.getAttribute("backuplocation3")!=null) { out.println(session.getAttribute("backuplocation3")); } %>"/>
            </td>
            <td>
                <select name="schedule3">
                    <option value="monthly">@monthly</option>
                    <option value="weekly">@weekly</option>
                    <option value="daily">@daily</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>Backup location 4</td>
            <td><input type="text" name="backuplocation4"
                       value="<% if(session.getAttribute("backuplocation4")!=null) { out.println(session.getAttribute("backuplocation4")); } %>"/>
            </td>
            <td>
                <select name="schedule4">
                    <option value="monthly">@monthly</option>
                    <option value="weekly">@weekly</option>
                    <option value="daily">@daily</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>Backup location 5</td>
            <td><input type="text" name="backuplocation5"
                       value="<% if(session.getAttribute("backuplocation5")!=null) { out.println(session.getAttribute("backuplocation5")); } %>"/>
            </td>
            <td>
                <select name="schedule5">
                    <option value="monthly">@monthly</option>
                    <option value="weekly">@weekly</option>
                    <option value="daily">@daily</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <input type="submit" name="back" value="Back"/>
                <input type="submit" name="next" value="Next"/>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><p><% out.println(msg); %></p>
            </td>
        </tr>
    </table>
</form>

<pre>
<%
    out.println(session.getAttribute("setupstate"));

    out.println("");
    out.println("Admin details");
    out.println(session.getAttribute("username"));
    out.println(session.getAttribute("password"));

    out.println("");
    out.println("Database");
    out.println(session.getAttribute("dbipaddress"));
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
%>
</pre>