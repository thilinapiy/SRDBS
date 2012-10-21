<%@ page import="org.srdbs.web.Api" %>

<script type="text/javascript">
    var auto_refresh = setInterval(


            function () {
                $.ajax({
                    url:'CloudStatus',
                    type:'get',
                    dataType:'json',
                    success:function (data) {
                        //$('#restoreFileName').html(data.restoreFileName);
                        var imgname;
                        if (data.cloud1 == "live") {

                            //   alert("live")
                            imgname = "cloudblue.jpg";
                            $("#img1").attr("src", "images/cloudblue.jpg");
                        }
                        else {

                            //  alert("down")
                            imgname = "cloudred.jpg";
                            $("#img1").attr("src", "images/cloudred.jpg");
                        }

                        if (data.cloud2 == "live") {

                            //   alert("live")
                            imgname = "cloudblue.jpg";
                            $("#img2").attr("src", "images/cloudblue.jpg");
                        }
                        else {

                            //  alert("down")
                            imgname = "cloudred.jpg";
                            $("#img2").attr("src", "images/cloudred.jpg");
                        }

                        if (data.cloud3 == "live") {

                            //   alert("live")
                            imgname = "cloudblue.jpg";
                            $("#img3").attr("src", "images/cloudblue.jpg");
                        }
                        else {

                            //  alert("down")
                            imgname = "cloudred.jpg";
                            $("#img3").attr("src", "images/cloudred.jpg");
                        }


                        console.log("width " + width);


                    }

                });
            },5000);


</script>


<TABLE BORDER="0" WIDTH="50%" CELLPADDING="4" CELLSPACING="3" ALIGN="Center">
    <TR>
        <TH COLSPAN="3"><BR>

            <H3>CLOUD AVAILABILITY</H3>
        </TH>
    </TR>

    <TR ALIGN="CENTER">
        <div id="cloud11">
            <TD><img src="images/cloudblue.jpg" id="img1" title="SRDBS" alt="SRDBS" width="110" height="100"
                     border="0"/></TD>
        </div>
        <div id="cloud22">
            <TD><img src="images/cloudblue.jpg" id="img2" title="SRDBS" alt="SRDBS" width="110" height="100"
                     border="0"/></TD>
        </div>
        <div id="cloud33">
            <TD><img src="images/cloudblue.jpg" id="img3" title="SRDBS" alt="SRDBS" width="110" height="100"
                     border="0"/></TD>
        </div>
    </TR>
    <TR ALIGN="CENTER">


            <TD><div style="font-weight:bold;font-style:oblique;font-size:20">
                <tr>
                    <p id="cloud4"></p>

                </tr>
            </div>
                </TD>


            <TD><p id= cloud2></p></TD>


            <TD><p id= cloud3></p></TD>


    </TR>
    <TR>
        <TH COLSPAN="3"><BR><img src="images/user.jpg" title="SRDBS" alt="SRDBS" width="110" height="100" border="0"/>
        </TH>
    </TR>
</TABLE>
