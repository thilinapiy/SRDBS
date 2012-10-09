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

<script type="text/javascript" src="js/jquery/jquery-1.4.1.min.js"></script>
<script type="text/javascript">
    var auto_refresh = setInterval(
            function () {


                $.ajax({
                    url:'ProgressMonitorRestore',
                    type:'get',
                    dataType:'json',
                    success:function (data) {
                        $('#restoreFileName').html(data.restoreFileName);
                        $('#curentFileNumber').html(data.curentFileNumber);
                        $('#fullFileCount').html(data.fullFileCount);

                        if (data.curentFileNumber != 0) {
                            //alert("fffff");
                            //$('#limit').show();
                            $('#limit4').show();
                            $('#outer').show();


                        }

                        var width = ((data.curentFileNumber / data.fullFileCount) * 400);


                        console.log("width " + width);

                        $('#div').animate({
                            width:width
                        }, {
                            duration:1000,
                            complete:function () {
                            }
                        });


                    }

                });


//    $('#responsecontainer').load('TestMethord?mode=mode2').fadeIn("slow");
            }, 5000); // refresh every 10000 milliseconds
</script>

<!-- start content-outer -->
<div id="content-outer">
    <!-- start content -->
    <div id="content">

        <div id="page-heading"><h1>Dashboard</h1></div>

        <table border="0" width="100%" cellpadding="0" cellspacing="0" id="content-table">
            <tr>
                <th rowspan="6" class="sized"><img src="/images/shared/side_shadowleft.jpg" width="20" height="300"
                                                   alt=""/></th>
                <th class="topleft"></th>

                <td id="tbl-border-top">

                </td>
                <th class="topright">
                </th>
                <th rowspan="6" class="sized"><img src="/images/shared/side_shadowright.jpg" width="20" height="300"
                                                   alt=""/></th>
            </tr>
            <tr>
                <td id="tbl-border-left"></td>
                <td>

                    <!--  start content-table-inner ...................................................................... START -->
                    <div id="content-table-inner">

                        <!--  start table-content  -->

                        <div id="table-content">

                            <div align="center">
                                <%@ include file="cloud.jsp" %>
                            </div>
                        </div>
                        <!--  end table-content  -->

                        <div class="clear"></div>
                    </div>
                    <!--  end content-table-inner ............................................END  -->
                </td>

                <td id="tbl-border-right"></td>
                <td>


                </td>

            </tr>
            <tr>
                <th class="sized bottomleft"></th>
                <td id="tbl-border-bottom"></td>
                <th class="sized bottomright"></th>
            </tr>

        </table>

        <br>
        <!--  <table >
              <tr>
                  <td width="400" align="left" >
                      <h2 >
                          </h2>
                  </td>


              </tr>
          </table>

          <div style="border: 3px ; width: 500px; padding: 5px ; margin: 5px ; border: 1px solid rgb(0, 0, 0)" > -->
        <div style="width: 400px ;height:400px; ">
            <%@ include file="UploadProgress.jsp" %>
        </div>
        <div class="clear"></div>
    </div>
    <!--  end content -->
    <div class="clear"></div>

</div>

<!-- end content-outer -->
<%@ include file="footer.jsp" %>
