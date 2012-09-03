<%@ page import="org.srdbs.web.Api" %>


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

                            var  width = ((data.currentFileNunber  / data.fileCount) * 400);
                            var  widthcloud2 = ((data.currentFileNunbercloud2  / data.fileCountcloud2) * 400);
                            var  widthcloud3 = ((data.currentFileNunbercloud3  / data.fileCountcloud3) * 400);


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

            <tr>
                <td id="tbl-border-left"></td>

                    <!--  start content-table-inner ...................................................................... START -->

                        <div style="font-weight:bold;font-style:oblique;font-size:20;border:#008888 ">
                            <p id="filename"> </p>
                        </div>

                        <br>
                        <div id="limit" style="height: 20px;width: 400px;border: 1px solid #000">

                            <div id="div" style="float:left;height: 20px;background-color: blue;"></div>    <br>
                        </div>
                        <br>
                        <%--cloud2--%>
                        <div style="font-weight:bold;font-style:oblique;font-size:20">
                        <p id="filenamecloud2"></p>
                        </div>
                        <br>
                        <div id="limit" style="height: 20px;width: 400px;border: 1px solid #000">

                            <div id="divcloud2" style="float:left;height: 20px;background-color: blue;"></div>   <br>
                        </div>
                        <br>
                        <%--cloud3--%>
                        <div style="font-weight:bold;font-style:oblique;font-size:20">
                        <p id="filenamecloud3"></p>
                        </div>
                        <br>
                        <div id="limit" style="height: 20px;width: 400px;border: 1px solid #000">

                            <div id="divcloud3" style="float:left;height: 20px;background-color: blue;"></div>
                        </div>


                        <!--  start table-content  -->
                        <div id="table-content">


                        </div>
                        <!--  end table-content  -->





</body>
</html>