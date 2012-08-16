<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
                pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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


<%--<div id="filename"></div>
<div id="bytecount"></div>
<div id="fileCount"></div>
<div id="currentFileNunber"></div>--%>

<%--<div id="div1" style=" 20px;background-color: red; width: 100px"></div>--%>
<%--<div id="limit" style="height: 20px;width: 200px;border: 1px solid #000">--%>

<%--cloud1--%>
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

</body>
</html>