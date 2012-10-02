<%@ page import="org.srdbs.web.Api" %>

<%
    if (Api.systemState()) {

        response.sendRedirect("/");
        return;
    }

    if (!session.getAttribute("setupstate").equals("step6")) {
        response.sendRedirect("/setup/" + session.getAttribute("setupstate") + ".jsp");
        return;
    }

    String msg = "";
    String backbtn = request.getParameter("back");
    String nextbtn = request.getParameter("next");
    String addbtn = request.getParameter("add");
    String deletebtn = request.getParameter("delete");
    String getName = request.getParameter("backuplocation");
    int count = Integer.valueOf(session.getAttribute("noofbackuplocations").toString());

    String templocation = request.getParameter("templocation");
    String restorelocation = request.getParameter("restorelocation");
	String failfilelocation = request.getParameter("failfilelocation");

    if (addbtn != null && addbtn.equalsIgnoreCase("add")) {

        int getFrequency = Integer.valueOf(request.getParameter("frequency").toString());
        int getStartHour = Integer.valueOf(request.getParameter("starthour").toString());
        int getStartMin = Integer.valueOf(request.getParameter("startmin").toString());

        int Compress = (request.getParameter("Compress") != null) ? 1 : 0;
        int Encrypt = (request.getParameter("Encrypt") != null) ? 1 : 0;

        if (!templocation.trim().equals("") && !restorelocation.trim().equals("") && !failfilelocation.trim().equals("") ) {
            session.setAttribute("templocation", templocation.trim());
            session.setAttribute("restorelocation", restorelocation.trim());
			session.setAttribute("failfilelocation", failfilelocation.trim());
        }

        if (getName != "" && getFrequency != 0) {
            count++;
            String name = "backuplocation" + count;
            String frequency = "frequency" + count;
            String StartHour = "starthour" + count;
            String StartMin = "startmin" + count;
            String comp = "compress" + count;
            String encr = "encrypt" + count;

            session.setAttribute(name, getName);
            session.setAttribute(frequency, getFrequency);
            session.setAttribute(StartHour, getStartHour);
            session.setAttribute(StartMin, getStartMin);
            session.setAttribute(comp, Compress);
            session.setAttribute(encr, Encrypt);
            session.setAttribute("noofbackuplocations", count);
        }
    }

    if (deletebtn != null & count != 0) {

        int i = 1;
        for (int k = 1; k <= count; k++) {
            if (Integer.valueOf(deletebtn) != k) {

                String name = "backuplocation" + i;
                String frequency = "frequency" + i;
                String StartHour = "starthour" + i;
                String StartMin = "startmin" + i;
                String comp = "compress" + i;
                String encr = "encrypt" + i;
                i++;

                session.setAttribute(name, session.getAttribute(("backuplocation" + k)));
                session.setAttribute(frequency, session.getAttribute(("frequency" + k)));
                session.setAttribute(StartHour, session.getAttribute(("starthour" + k)));
                session.setAttribute(StartMin, session.getAttribute(("startmin" + k)));
                session.setAttribute(comp, session.getAttribute(("compress" + k)));
                session.setAttribute(encr, session.getAttribute(("encrypt" + k)));
            }
        }

        count--;
        session.setAttribute("noofbackuplocations", count);
    }

    if (backbtn != null && backbtn.equalsIgnoreCase("back")) {
        session.setAttribute("setupstate", "step5");
        response.sendRedirect("/setup/step5.jsp");
        return;
    }

    if (nextbtn != null && nextbtn.equalsIgnoreCase("next")) {

        if (templocation != null && restorelocation != null && failfilelocation != null && count != 0) {

            if (!templocation.trim().equals("") && !restorelocation.trim().equals("") && !failfilelocation.trim().equals("")) {

                session.setAttribute("templocation", templocation.trim());
                session.setAttribute("restorelocation", restorelocation.trim());
				 session.setAttribute("failfilelocation", failfilelocation.trim());

                session.setAttribute("setupstate", "step7");
                response.sendRedirect("/setup/step7.jsp");
                return;
            } else {

                msg = "All fields are required.";
            }
        } else if (count == 0) {

            msg = "Add a backup location";
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
                value = "Weekly - On every Sunday";
                break;
            case 3:
                value = "Weekly - On every Monday";
                break;
            case 4:
                value = "Weekly - On every Tuesday";
                break;
            case 5:
                value = "Weekly - On every Wednesday";
                break;
            case 6:
                value = "Weekly - On every Thursday";
                break;
            case 7:
                value = "Weekly - On every Friday";
                break;
            case 8:
                value = "Weekly - On every Saturday";
                break;
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
            case 28:
            case 29:
            case 30:
            case 31:
            case 32:
            case 33:
            case 34:
            case 35:
            case 36:

                value = "Monthly - On " + (fq - 8);
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

    <div class="step-no">6</div>
    <div class="step-dark-left">Schedules</div>
    <div class="step-dark-right">&nbsp;</div>

    <div class="step-no-off">7</div>
    <div class="step-light-left">Final</div>
    <div class="step-light-round">&nbsp;</div>

    <div class="clear"></div>
</div>
<!-- end step-holder -->
<!-- start id-form -->

<h1>Default locations</h1>
<br/>

<div class="clear"></div>

<form action="" method="GET">
    <table border="0" cellpadding="0" cellspacing="0" id="id-form">
        <tr>
            <th valign="top">Tempary location</th>
            <td><input type="text" class="inp-form" name="templocation"
                       value="<% if(session.getAttribute("templocation")!=null) { out.println(session.getAttribute("templocation")); } %>"/>
            </td>
        </tr>
        <tr>
            <th valign="top">Restore location</th>
            <td><input type="text" class="inp-form" name="restorelocation"
                       value="<% if(session.getAttribute("restorelocation")!=null) { out.println(session.getAttribute("restorelocation")); } %>"/>
            </td>
        </tr>
		<tr>
            <th valign="top">Restore location</th>
            <td><input type="text" class="inp-form" name="failfilelocation"
                       value="<% if(session.getAttribute("failfilelocation")!=null) { out.println(session.getAttribute("failfilelocation")); } %>"/>
            </td>
        </tr>
    </table>
    <br/>
    <br/>

    <h1>Schedules</h1>
    <br/>

    <div class="clear"></div>
    <%
        if (count != 0) {
            out.print("<table padding='2px'>");
            out.print("<th>Backup Location</th><th>Frequency</th><th>Start Time</th><th>Compress</th><th>Encrypt</th><th>&nbsp;</th>");
            for (int i = 1; i <= count; i++) {
                String name = "backuplocation" + i;
                String frequency = "frequency" + i;
                String StartHour = "starthour" + i;
                String StartMin = "startmin" + i;
                String comp = "compress" + i;
                String encr = "encrypt" + i;

                int freq = Integer.valueOf(session.getAttribute(frequency).toString());
                out.print("<tr>");
                out.print("<td width='300px' ><b>" + session.getAttribute(name) + "</b></td>");
                out.print("<td width='175px'>" + getFreq(freq) + "</td>");
                out.print("<td width='80px' align='center'>" + session.getAttribute(StartHour) + ":" + session.getAttribute(StartMin) + "h </td>");
                out.print("<td width='50px' align='center'>" + session.getAttribute(comp) + "</td>");
                out.print("<td width='50px' align='center'>" + session.getAttribute(encr) + "</td>");
                out.print("<td><button height='23px' type='submit' name='delete' value='" + i + "' ><img src='/images/table/delete.gif'/></button></td>");
                out.print("</tr>");
            }
            out.print("</table>");
        }

    %>
    <div class="clear"></div>
    <br/>
    <br/>
    <br/>
    <br/>
    <table border="0" cellpadding="0" cellspacing="0" id="id-form">
        <tr>
            <th>Add Backup Location</th>
            <td>
                <input type="text" class="inp-form" name="backuplocation"/>
            </td>
        </tr>
        <tr>
            <th>Frequency</th>
            <td>
                <select name="frequency" class="styledselect-schedule">
                    <option value="0">Select</option>
                    <option value="1">Daily</option>
                    <option value="2">Weekly - On every Sunday</option>
                    <option value="3">Weekly - On every Monday</option>
                    <option value="4">Weekly - On every Tuesday</option>
                    <option value="5">Weekly - On every Wednesday</option>
                    <option value="6">Weekly - On every Thursday</option>
                    <option value="7">Weekly - On every Friday</option>
                    <option value="8">Weekly - On every Saturday</option>
                    <%
                        for (int s = 1; s < 29; s++) {
                            out.print("<option value='" + (s + 8) + "'>Monthly - On day " + s + " </option>");
                        }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <th>Start time</th>
            <td>
                <select name="starthour" class="styledselect-schedule">
                    <% for (int i = 0; i < 24; i++) {
                        out.println("<option value='" + i + "' >" + i + "</option>");
                    }
                    %>
                </select>
                <select name="startmin" class="styledselect-schedule">
                    <% for (int j = 0; j < 60; j++) {
                        out.println("<option value='" + j + "' >" + j + "</option>");
                    }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <th>Compress</th>
            <td>
                <input type="checkbox" name="Compress" value="Compress"/>
            </td>
        </tr>
        <tr>
            <th>Encrypt</th>
            <td>
                <input type="checkbox" name="Encrypt" value="Encrypt"/>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td valign="top">
                <input type="submit" class="form-add" name="add" value="Add"/>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td valign="top">
                <input type="submit" class="form-back" name="back" value="Back"/>
                <input type="submit" class="form-next" name="next" value="Next"/>
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