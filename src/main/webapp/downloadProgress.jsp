<%@ page import="org.srdbs.web.Api" %>

<!DOCTYPE html>
<html>


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="js/jquery/jquery-1.4.1.min.js"></script>
<script type="text/javascript">
    //



    var auto_refresh = setInterval(
            function ()
            {


                $.ajax({
                    url:'ProgressMonitorRestore',
                    type:'get',
                    dataType: 'json',
                    success: function(data) {
                        $('#restoreFileName').html(data.restoreFileName);
                        $('#curentFileNumber').html(data.curentFileNumber);
                        $('#fullFileCount').html(data.fullFileCount);
                        $('#restoreTotal').html(data.restoreTotal);


                        if(data.curentFileNumber != 0){

                            $('#limit4').show();
                        }
                        if(data.fullFileCount == data.curentFileNumber){

                            $('#limit4').hide();
                        }

                        var  width = ((data.curentFileNumber  / data.fullFileCount) * 300);




                        console.log("width " +width);

                        $('#div').animate({
                            width:width
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

<tr>
    <td id="tbl-border-left"></td>
    <td>
        <!--  start content-table-inner ...................................................................... START -->
        <div id="content-table-inner" >

            <!--  start table-content  -->
            <div id="table-content">
                <tr>
                <p id="restoreFileName"></p>
                 <br>
                <p id="restoreTotal"></p>
                </tr>
                <div id="limit4" style="height: 20px;width: 300px;border: 1px solid #000; display:none; ">

                    <div id="div" style="float:left;height: 20px;background-color: blue" ></div>    <br>
                </div>

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







<%--cloud1--%>

</body>
</html>