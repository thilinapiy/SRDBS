<%@ page import="org.srdbs.web.Api" %>

<script type="text/javascript">
    var auto_refresh = setInterval(


            function () {
                $.ajax({
                    url:'CloudStatus',
                    type:'get',
                    dataType:'json',
                    success:function (data) {

                        $('#c1ip').html(data.c1ip);
                        $('#c2ip').html(data.c2ip);
                        $('#c3ip').html(data.c3ip);
                        $('#c1').html(data.c1);
                        $('#c2').html(data.c2);
                        $('#c3').html(data.c3);


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
                     border="0"/>
                <p id="c1ip" name="c1ip"></p>
           <p id="c1" name="c1"></p></TD>
        </div>
        <div id="cloud22">
            <TD><img src="images/cloudblue.jpg" id="img2" title="SRDBS" alt="SRDBS" width="110" height="100"
                     border="0"/>
                <p id="c2ip" name="c2ip"></p>
            <p id="c2" name="c2"></p></TD>
        </div>
        <div id="cloud33">
            <TD><img src="images/cloudblue.jpg" id="img3" title="SRDBS" alt="SRDBS" width="110" height="100"
                     border="0"/>
                <p id="c3ip" name="c3ip"></p>
            <p id="c3" name="c3"></p></TD>
        </div>
    </TR>
    <div></div>


    <TR>
        <TH COLSPAN="3"><BR><img src="images/server.png" title="SRDBS" alt="SRDBS" width="110" height="100" border="0"/>
        </TH>
    </TR>
</TABLE>

