<%@ page import="org.srdbs.web.Api" %>
<%@ page import="org.srdbs.web.Setup" %>

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
    String submitbtn = request.getParameter("submit");

    session.setAttribute("setupstate", "step7");
    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        session.setAttribute("setupstate", "step6");
        response.sendRedirect("/setup/step6.jsp");
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
<%!

    String getFreq(int fq) {

        String value = "";
        switch (fq) {
            case 1:
                value = "Daily";
                break;
            case 2:
                value = "Weekly - On every Monday";
                break;
            case 3:
                value = "Weekly - On every Tuesday";
                break;
            case 4:
                value = "Weekly - On every Wednesday";
                break;
            case 5:
                value = "Weekly - On every Thursday";
                break;
            case 6:
                value = "Weekly - On every Friday";
                break;
            case 7:
                value = "Weekly - On every Saturday";
                break;
            case 8:
                value = "Weekly - On every Sunday";
                break;
            case 9:
                value = "Monthly - On  1st";
                break;
            case 10:
                value = "Monthly - On  5th";
                break;
            case 11:
                value = "Monthly - On 10th";
                break;
            case 12:
                value = "Monthly - On 15th";
                break;
            case 13:
                value = "Monthly - On 20th";
                break;
            case 14:
                value = "Monthly - On 25th";
                break;
            case 15:
                value = "Monthly - On 28th";
                break;
            default:
                value = "Error !";
                break;
        }

        return value;
    }

%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%@ include file="header.jsp" %>

<!-- start step-holder -->
<div id="step-holder">
    <div class="step-no-off">1</div>
    <div class="step-light-left">Add Users</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">2</div>
    <div class="step-light-left">Database Setup</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">3</div>
    <div class="step-light-left">Cloud 1</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">4</div>
    <div class="step-light-left">Cloud 2</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">5</div>
    <div class="step-light-left">Cloud 3</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no-off">6</div>
    <div class="step-light-left">Schedules</div>
    <div class="step-light-right">&nbsp;</div>

    <div class="step-no">7</div>
    <div class="step-dark-left">Final</div>
    <div class="step-dark-round">&nbsp;</div>

    <div class="clear"></div>
</div>
<!-- end step-holder -->
<!-- start id-form -->

<form action="step7.jsp" method="GET">
    <table border="0" cellpadding="0" cellspacing="0" id="id-form">
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
                        out.println(session.getAttribute("c1messageport"));
                        out.println(session.getAttribute("c1bandwidth"));
                        out.println(session.getAttribute("c1cost"));


                        out.println("");
                        out.println("Cloud 2");
                        out.println(session.getAttribute("c2ipaddress"));
                        out.println(session.getAttribute("c2port"));
                        out.println(session.getAttribute("c2remotepath"));
                        out.println(session.getAttribute("c2username"));
                        out.println(session.getAttribute("c2password"));
                        out.println(session.getAttribute("c2messageport"));
                        out.println(session.getAttribute("c2bandwidth"));
                        out.println(session.getAttribute("c2cost"));

                        out.println("");
                        out.println("Cloud 3");
                        out.println(session.getAttribute("c3ipaddress"));
                        out.println(session.getAttribute("c3port"));
                        out.println(session.getAttribute("c3remotepath"));
                        out.println(session.getAttribute("c3username"));
                        out.println(session.getAttribute("c3password"));
                        out.println(session.getAttribute("c3messageport"));
                        out.println(session.getAttribute("c3bandwidth"));
                        out.println(session.getAttribute("c3cost"));

                        out.println("");
                        out.println("System Locations");
                        out.println(session.getAttribute("templocation"));
                        out.println(session.getAttribute("restorelocation"));

                        out.println("");
                        out.println("Baclup locations");

                        int count = Integer.valueOf(session.getAttribute("noofbackuplocations").toString());
                        if (count != 0) {
                            out.print("<table border='2px'>");
                            out.print("<tr><td>Backup Location</td><td>Frequency</td><td>Start Time</td><td>Compress</td><td>Encrypt</td></tr>");
                            for (int i = 1; i <= count; i++) {
                                String name = "backuplocation" + i;
                                String frequency = "frequency" + i;
                                String StartHour = "starthour" + i;
                                String StartMin = "startmin" + i;
                                String comp = "compress" + i;
                                String encr = "encrypt" + i;

                                int freq = Integer.valueOf(session.getAttribute(frequency).toString());
                                out.print("<tr>");
                                out.print("<td width='350px' ><b>" + session.getAttribute(name) + "</b></td>");
                                out.print("<td width='175px'>" + getFreq(freq) + "</td>");
                                out.print("<td width='80px' align='center'>" + session.getAttribute(StartHour) + ":" + session.getAttribute(StartMin) + "h </td>");
                                out.print("<td width='50px' align='center'>" + session.getAttribute(comp) + "</td>");
                                out.print("<td width='50px' align='center'>" + session.getAttribute(encr) + "</td>");
                                out.print("</tr>");
                            }
                            out.print("</table>");
                        }

                    %>
				</pre>
            </td>
        </tr>

        <tr>
            <th>&nbsp;</th>
            <td valign="top">
                <input type="submit" class="form-back" name="back" value="Back"/>
                <input type="submit" class="form-submit" name="submit" value="Submit"/>
            </td>
            <td>
                <% if (!msg.equals("")) {
                    out.println("<div class='error-left'></div>");
                    out.println("<div class='error-inner'>" + msg + "</div>");
                } else {
                    out.println("&nbsp;");
                }
                %>
            </td>
        </tr>
    </table>
</form>
<!-- end id-form -->
</td>
<td>

    <!--  start related-activities -->
    <div id="related-activities">
        <!--  start related-act-top -->
        <div id="related-act-top">
            <img src="/images/forms/header_related_act.gif" width="271" height="43" alt=""/>
        </div>
        <!-- end related-act-top -->

        <!--  start related-act-bottom -->
        <div id="related-act-bottom">
            <!--  start related-act-inner -->
            <div id="related-act-inner">
                <div class="left"><a href=""><img src="/images/forms/icon_plus.gif" width="21" height="21" alt=""/></a>
                </div>
                <div class="right">
                    <h5></h5>
                    Lorem ipsum dolor sit amet consectetur
                    adipisicing elitsed do eiusmod tempor.
                    <ul class="greyarrow">
                        <li><a href="">Click here to visit</a></li>
                        <li><a href="">Click here to visit</a></li>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
            <!-- end related-act-inner -->
            <div class="clear"></div>
        </div>
        <!-- end related-act-bottom -->
    </div>
    <!-- end related-activities -->
<%@ include file="footer.jsp" %>