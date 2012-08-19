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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
                pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>SRDBS</title>
<link rel="stylesheet" href="/css/screen.css" type="text/css" media="screen" title="default"/>
<!--[if IE]>
<link rel="stylesheet" media="all" type="text/css" href="/css/pro_dropline_ie.css"/>
<![endif]-->

<!--  jquery core -->
<script src="/js/jquery/jquery-1.4.1.min.js" type="text/javascript"></script>

<!--  checkbox styling script -->
<script src="/js/jquery/ui.core.js" type="text/javascript"></script>
<script src="/js/jquery/ui.checkbox.js" type="text/javascript"></script>
<script src="/js/jquery/jquery.bind.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        $('input').checkBox();
        $('#toggle-all').click(function () {
            $('#toggle-all').toggleClass('toggle-checked');
            $('#mainform input[type=checkbox]').checkBox('toggle');
            return false;
        });
    });
</script>

<![if !IE 7]>
<!--  styled select box script version 1 -->
<script src="/js/jquery/jquery.selectbox-0.5.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.styledselect').selectbox({ inputClass:"selectbox_styled" });
    });
</script>
<![endif]>

<!--  styled select box script version 2 -->
<script src="/js/jquery/jquery.selectbox-0.5_style_2.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.styledselect_form_1').selectbox({ inputClass:"styledselect_form_1" });
        $('.styledselect_form_2').selectbox({ inputClass:"styledselect_form_2" });
    });
</script>

<!--  styled select box script version 3 -->
<script src="/js/jquery/jquery.selectbox-0.5_style_2.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.styledselect_pages').selectbox({ inputClass:"styledselect_pages" });
    });
</script>

<!--  styled file upload script -->
<script src="/js/jquery/jquery.filestyle.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8">
    $(function () {
        $("input.file_1").filestyle({
            image:"images/forms/upload_file.gif",
            imageheight:29,
            imagewidth:78,
            width:300
        });
    });
</script>

<!-- Custom jquery scripts -->
<script src="/js/jquery/custom_jquery.js" type="text/javascript"></script>

<!-- Tooltips -->
<script src="/js/jquery/jquery.tooltip.js" type="text/javascript"></script>
<script src="/js/jquery/jquery.dimensions.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        $('a.info-tooltip ').tooltip({
            track:true,
            delay:0,
            fixPNG:true,
            showURL:false,
            showBody:" - ",
            top:-35,
            left:5
        });
    });
</script>

<!--  date picker script -->
<link rel="stylesheet" href="css/datePicker.css" type="text/css"/>
<script src="/js/jquery/date.js" type="text/javascript"></script>
<script src="/js/jquery/jquery.datePicker.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8">
    $(function () {

// initialise the "Select date" link
        $('#date-pick')
                .datePicker(
                // associate the link with a date picker
                {
                    createButton:false,
                    startDate:'01/01/2005',
                    endDate:'31/12/2020'
                }
        ).bind(
                // when the link is clicked display the date picker
                'click',
                function () {
                    updateSelects($(this).dpGetSelected()[0]);
                    $(this).dpDisplay();
                    return false;
                }
        ).bind(
                // when a date is selected update the SELECTs
                'dateSelected',
                function (e, selectedDate, $td, state) {
                    updateSelects(selectedDate);
                }
        ).bind(
                'dpClosed',
                function (e, selected) {
                    updateSelects(selected[0]);
                }
        );

        var updateSelects = function (selectedDate) {
            var selectedDate = new Date(selectedDate);
            $('#d option[value=' + selectedDate.getDate() + ']').attr('selected', 'selected');
            $('#m option[value=' + (selectedDate.getMonth() + 1) + ']').attr('selected', 'selected');
            $('#y option[value=' + (selectedDate.getFullYear()) + ']').attr('selected', 'selected');
        }
// listen for when the selects are changed and update the picker
        $('#d, #m, #y')
                .bind(
                'change',
                function () {
                    var d = new Date(
                            $('#y').val(),
                            $('#m').val() - 1,
                            $('#d').val()
                    );
                    $('#date-pick').dpSetSelected(d.asString());
                }
        );

// default the position of the selects to today
        var today = new Date();
        updateSelects(today.getTime());

// and update the datePicker to reflect it...
        $('#d').trigger('change');
    });
</script>

<!-- MUST BE THE LAST SCRIPT IN <HEAD></HEAD></HEAD> png fix -->
<script src="/js/jquery/jquery.pngFix.pack.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(document).pngFix();
    });
</script>




    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Insert title here</title>
    <script type="text/javascript" src="js/jquery/jquery-1.4.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#getData').click(function(){
                $.ajax({
                    url:'ProgressMonitor',
                    type:'get',
                    dataType: 'text',
                    success: function(data) {
                        $('#name').val(data);
                        /* $('#name').val(data.name);
                         $('#email').val(data.email);   */

                    }
                });
            });
        });


        var auto_refresh = setInterval(
                function ()
                {
                    $.ajax({
                        url:'ProgressMonitor',
                        type:'get',
                        dataType: 'json',
                        success: function(data) {
                            $('#filename').html(data.filename);
                            $('#bytecount').html(data.bytecount);
                            $('#fileCount').html(data.fileCount);
                            $('#currentFileNunber').html(data.currentFileNunber);

                            $('#filenamecloud2').html(data.filenamecloud2);
                            $('#bytecouncloud2t').html(data.bytecountcloud2);
                            $('#fileCountcloud2').html(data.fileCountcloud2);
                            $('#currentFileNunbercloud2').html(data.currentFileNunbercloud2);

                            $('#filenamecloud3').html(data.filenamecloud3);
                            $('#bytecountcloud3').html(data.bytecountcloud3);
                            $('#fileCountcloud3').html(data.fileCountcloud3);
                            $('#currentFileNunbercloud3').html(data.currentFileNunbercloud3);

                            var  width = ((data.currentFileNunber  / data.fileCount) * 200);
                            var  widthcloud2 = ((data.currentFileNunbercloud2  / data.fileCountcloud2) * 200);
                            var  widthcloud3 = ((data.currentFileNunbercloud3  / data.fileCountcloud3) * 200);

                            console.log("widthcloud2 " +widthcloud2);
                            console.log("widthcloud3 " +widthcloud3);

                            $('#div').animate({
                                width:width
                            }, {
                                duration: 1000,
                                complete: function() {
                                }
                            });

                            $('#divcloud2').animate({
                                width: widthcloud2
                            }, {
                                duration: 1000,
                                complete: function() {
                                }
                            });

                            $('#divcloud3').animate({
                                width:widthcloud3
                            }, {
                                duration: 1000,
                                complete: function() {
                                }
                            });

                        }
                    });

//    $('#responsecontainer').load('TestMethord?mode=mode2').fadeIn("slow");
                }, 5000); // refresh every 10000 milliseconds
    </script>
</head>
<body>
<div id="page-top-outer">
    <!-- Start: page-top -->
    <div id="page-top">
        <!-- start logo -->
        <div id="logo">
            <a href="/"><img src="/images/shared/logo.png" width="156" height="40" alt=""/></a>
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
            <div class="showhide-account" width="93" height="14"><h3><% if (session.getAttribute("username") != null) {
                String name = session.getAttribute("username").toString();
                char[] stringArray = name.toCharArray();
                stringArray[0] = Character.toUpperCase(stringArray[0]);
                out.println(new String(stringArray));
            }%></h3></div>
            <div class="nav-divider">&nbsp;</div>
            <a href="/logout.jsp" id="logout"><img src="/images/shared/nav/nav_logout.gif" width="64" height="14"
                                                   alt=""/></a>

            <div class="clear">&nbsp;</div>

            <!--  start account-content -->
            <div class="account-content">
                <div class="account-drop-inner">
                    <a href="" id="acc-settings">Settings</a>

                    <div class="clear">&nbsp;</div>
                    <div class="acc-line">&nbsp;</div>
                    <a href="" id="acc-details">Personal details </a>

                    <div class="clear">&nbsp;</div>
                    <div class="acc-line">&nbsp;</div>
                    <a href="" id="acc-project">Project details</a>

                    <div class="clear">&nbsp;</div>
                    <div class="acc-line">&nbsp;</div>
                    <a href="" id="acc-inbox">Inbox</a>

                    <div class="clear">&nbsp;</div>
                    <div class="acc-line">&nbsp;</div>
                    <a href="" id="acc-stats">Statistics</a>
                </div>
            </div>
            <!--  end account-content -->

        </div>
        <!-- end nav-right -->


        <!--  start nav -->
        <div class="nav">
            <div class="table">

                <ul class="current">
                    <li><a href="/"><b>Dashboard</b><!--[if IE 7]><!--></a><!--<![endif]-->
                </ul>

                <div class="nav-divider">&nbsp;</div>

                <ul class="select">
                    <li><a href="#"><b>Clouds</b><!--[if IE 7]><!--></a><!--<![endif]-->
                        <!--[if lte IE 6]>
                        <table>
                            <tr>
                                <td><![endif]-->
                        <div class="select_sub">
                            <ul class="sub">
                                <li><a href="/clouds/cloud1.jsp">Cloud 1</a></li>
                                <li><a href="/clouds/cloud2.jsp">Cloud 2</a></li>
                                <li><a href="/clouds/cloud3.jsp">Cloud 3</a></li>
                                <li><a href="/clouds/cloud4.jsp">Cloud 4</a></li>
                                <li><a href="/clouds/cloud5.jsp">Cloud 5</a></li>
                            </ul>
                        </div>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                </ul>

                <div class="nav-divider">&nbsp;</div>

                <ul class="select">
                    <li><a href="#"><b>Schedule</b><!--[if IE 7]><!--></a><!--<![endif]-->
                        <!--[if lte IE 6]>
                        <table>
                            <tr>
                                <td><![endif]-->
                        <!-- div class="select_sub">
                  <ul class="sub">
                      <li><a href="#nogo">Categories Details 1</a></li>
                      <li><a href="#nogo">Categories Details 2</a></li>
                      <li><a href="#nogo">Categories Details 3</a></li>
                  </ul>
              </div -->
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                </ul>

                <div class="nav-divider">&nbsp;</div>

                <ul class="select">
                    <li><a href="#nogo"><b>Restore</b><!--[if IE 7]><!--></a><!--<![endif]-->
                        <!--[if lte IE 6]>
                        <table>
                            <tr>
                                <td><![endif]-->
                        <!-- div class="select_sub">
                  <ul class="sub">
                      <li><a href="#nogo">Clients Details 1</a></li>
                      <li><a href="#nogo">Clients Details 2</a></li>
                      <li><a href="#nogo">Clients Details 3</a></li>

                  </ul>
              </div -->
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                </ul>

                <div class="nav-divider">&nbsp;</div>

                <ul class="select">
                    <li><a href="#"><b>Logs</b><!--[if IE 7]><!--></a><!--<![endif]-->
                        <!--[if lte IE 6]>
                        <table>
                            <tr>
                                <td><![endif]-->
                        <div class="select_sub">
                            <ul class="sub">
                                <li><a href="/logs/syslog.jsp">System Log</a></li>
                                <li><a href="/logs/backuplog.jsp">Backup Log</a></li>
                                <li><a href="/logs/restorelog.jsp">Restore Log</a></li>
                            </ul>
                        </div>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                </ul>

                <div class="nav-divider">&nbsp;</div>

                <ul class="select">
                    <li><a href="/help.jsp"><b>Help</b><!--[if IE 7]><!--></a><!--<![endif]-->
                        <!--[if lte IE 6]>
                        <table>
                            <tr>
                                <td><![endif]-->
                        <!-- div class="select_sub">
                  <ul class="sub">
                      <li><a href="#nogo">System Log</a></li>
                      <li><a href="#nogo">Backup Log</a></li>
                      <li><a href="#nogo">Restore Log</a></li>
                  </ul>
              </div -->
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
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

<!-- start content-outer -->
<div id="content-outer">
    <!-- start content -->
    <div id="content">

        <div id="page-heading"><h1>Dashboard</h1></div>

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
                        <p id="filename"></p>
                        <div id="limit" style="height: 20px;width: 200px;border: 1px solid #000">

                            <div id="div" style="float:left;height: 20px;background-color: blue;"></div>    <br>
                        </div>
                        <%--cloud2--%>
                        <p id="filenamecloud2"></p>
                        <div id="limit" style="height: 20px;width: 200px;border: 1px solid #000">

                            <div id="divcloud2" style="float:left;height: 20px;background-color: blue;"></div>   <br>
                        </div>
                        <%--cloud3--%>
                        <p id="filenamecloud3"></p>
                        <div id="limit" style="height: 20px;width: 200px;border: 1px solid #000">

                            <div id="divcloud3" style="float:left;height: 20px;background-color: blue;"></div>
                        </div>
                        <!--  start table-content  -->
                        <div id="table-content">


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
<!--  end content-outer -->


<div class="clear">&nbsp;</div>

<!-- start footer -->
<div id="footer">
    <!--  start footer-left -->
    <div id="footer-left">Copyright ? 2012 Secure and Redundent Data Backup System. All Rights Reserved. This is Free
        Software released under the <a href="http://www.gnu.org/licenses/gpl-3.0.html">GNU/GPLv3 License</a>.
    </div>
    <!--  end footer-left -->
    <div class="clear">&nbsp;</div>
</div>

<%--<div id="filename"></div>
<div id="bytecount"></div>
<div id="fileCount"></div>
<div id="currentFileNunber"></div>--%>

<%--<div id="div1" style=" 20px;background-color: red; width: 100px"></div>--%>
<%--<div id="limit" style="height: 20px;width: 200px;border: 1px solid #000">--%>

<%--cloud1--%>


</body>
</html>