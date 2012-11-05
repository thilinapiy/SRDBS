<%@ page import="org.srdbs.web.Api" %>

<script type="text/javascript">

    $(document).ready(function () {
        $('#getData').click(function () {
            $.ajax({
                url:'ProgressMonitor',
                type:'get',
                dataType:'text',
                success:function (data) {
                    $('#name').val(data);


                }
            });
        });
    });


    var auto_refresh = setInterval(
            function () {
                $.ajax({
                    url:'ProgressMonitor',
                    type:'get',
                    dataType:'json',
                    success:function (data) {
                        $('#filename').html(data.filename);
                        $('#bytecount').html(data.bytecount);
                        $('#fileCount').html(data.fileCount);
                        $('#currentFileNunber').html(data.currentFileNunber);
                        $('#filenametotal').html(data.filenametotal);

                        $('#filenamecloud2').html(data.filenamecloud2);
                        $('#bytecouncloud2t').html(data.bytecountcloud2);
                        $('#fileCountcloud2').html(data.fileCountcloud2);
                        $('#currentFileNunbercloud2').html(data.currentFileNunbercloud2);
                        $('#filenamecloud2total').html(data.filenamecloud2total);

                        $('#filenamecloud3').html(data.filenamecloud3);
                        $('#bytecountcloud3').html(data.bytecountcloud3);
                        $('#fileCountcloud3').html(data.fileCountcloud3);
                        $('#currentFileNunbercloud3').html(data.currentFileNunbercloud3);
                        $('#filenamecloud3total').html(data.filenamecloud3total);

                        // if (data.currentFileNunber != 0) {
                        //   $('#outer').show();
                        // }


                        if (data.currentFileNunber != 0) {
                            $('#limit').show();
                            $('#cloud1').show();
                        }
                        if( data.currentFileNunber==0) {
                            $('#limit').hide();
                            $('#cloud1').hide();
                        }

                        if (data.currentFileNunbercloud2 != 0) {
                            $('#limit2').show();
                            $('#cloud2').show();

                        }

                        if (data.currentFileNunbercloud2==0) {
                            $('#limit2').hide();
                            $('#cloud2 ').hide();
                        }

                        if (data.currentFileNunbercloud3 != 0) {
                            $('#limit3').show();
                            $('#cloud3').show();
                        }

                        if ( data.currentFileNunbercloud3==0) {
                            $('#limit3').hide();
                            $('#cloud3').hide();
                        }



                        var width = ((data.currentFileNunber / data.fileCount) * 300);
                        var widthcloud2 = ((data.currentFileNunbercloud2 / data.fileCountcloud2) * 300);
                        var widthcloud3 = ((data.currentFileNunbercloud3 / data.fileCountcloud3) * 300);


                        console.log("widthcloud2 " + widthcloud2);
                        console.log("widthcloud3 " + widthcloud3);

                        $('#div').animate({
                            width:width
                        }, {
                            duration:1000,
                            complete:function () {
                            }
                        });

                        $('#divcloud2').animate({
                            width:widthcloud2
                        }, {
                            duration:1000,
                            complete:function () {
                            }
                        });

                        $('#divcloud3').animate({
                            width:widthcloud3
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


<tr>
    <td id="tbl-border-left"></td>

    <!--  start content-table-inner ...................................................................... START -->
    <td>
        <div id="cloud1" style="font-weight:bold;font-style:oblique;font-size:20;border:#008888; display:none;">
            <tr>
                <p id="filename"></p>
                <br>

                <p id="filenametotal"></p>
            </tr>

        </div>

        <br>

        <div id="limit" style="height: 20px;width: 300px;border: 1px solid #000 ;display:none;">

            <div id="div" style="float:left;height: 20px;background-color: blue;"></div>
            <br>
        </div>
        <br>
    </td>
    <%--cloud2--%>
    <td>
        <div id="cloud2" style="font-weight:bold;font-style:oblique;font-size:20 ;display:none;">
            <tr>
                <p id="filenamecloud2"></p>
                <br>

                <p id="filenamecloud2total"></p>
            </tr>
        </div>
        <br>

        <div id="limit2" style="height: 20px;width: 300px;border: 1px solid #000 ; display:none;">

            <div id="divcloud2" style="float:left;height: 20px;background-color: blue;"></div>
            <br>
        </div>
        <br>
    </td>
    <%--cloud3--%>
    <td>
        <div id="cloud3" style="font-weight:bold;font-style:oblique;font-size:20 ;display:none;">
            <tr>
                <p id="filenamecloud3"></p>
                <br>

                <p id="filenamecloud3total"></p>
            </tr>
        </div>
        <br>

        <div id="limit3" style="height: 20px;width: 300px;border: 1px solid #000 ; display:none;">

            <div id="divcloud3" style="float:left;height: 20px;background-color: blue;"></div>
        </div>

    </td>
    <!--  start table-content  -->
<div id="table-content">


</div>
<!--  end table-content  -->


</div>