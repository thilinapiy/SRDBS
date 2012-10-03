<%@ page import="org.srdbs.web.Api" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>SRDBS</title>
    <script type="text/javascript" src="js/jquery/jquery-1.4.1.min.js"></script>
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
                }, 5000);


    </script>


<TABLE BORDER="0" WIDTH="50%" CELLPADDING="4" CELLSPACING="3" ALIGN="Center">
    <TR>
        <TH COLSPAN="3"><BR>

            <H3>CLOUD AVAILABILITY</H3>
        </TH>
    </TR>

    <TR ALIGN="CENTER">
        <div id="cloud1">
            <TD><img src="images/cloudgreen.jpg" id="img1" title="SRDBS" alt="SRDBS" width="150" height="130"
                     border="0"/></TD>
        </div>
        <div id="cloud2">
            <TD><img src="images/cloudgreen.jpg" id="img2" title="SRDBS" alt="SRDBS" width="150" height="130"
                     border="0"/></TD>
        </div>
        <div id="cloud3">
            <TD><img src="images/cloudgreen.jpg" id="img3" title="SRDBS" alt="SRDBS" width="150" height="130"
                     border="0"/></TD>
        </div>
    </TR>
    <TR ALIGN="CENTER">
        <div id="arrow1">
            <TD><img src="images/up.JPG" title="SRDBS" alt="SRDBS" width="150" height="130" border="0"/></TD>
        </div>
        <div id="arrow2">
            <TD><img src="images/up.JPG" title="SRDBS" alt="SRDBS" width="150" height="130" border="0"/></TD>
        </div>
        <div id="arrow3">
            <TD><img src="images/up.JPG" title="SRDBS" alt="SRDBS" width="150" height="130" border="0"/></TD>
        </div>
    </TR>
    <TR>
        <TH COLSPAN="3"><BR><img src="images/user.jpg" title="SRDBS" alt="SRDBS" width="150" height="130" border="0"/>
        </TH>
    </TR>
</TABLE>
</html>