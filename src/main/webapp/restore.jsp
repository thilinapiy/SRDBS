<%@ page import="org.srdbs.web.Api" %>
<%@ page import="org.srdbs.core.RunRestore" %>
<%@ page import="org.srdbs.core.DbConnect" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%
    String select[] = request.getParameterValues("id");

    if (!Api.systemState()) {

        response.sendRedirect("/setup/");
        return;
    }

    if (session.getAttribute("username") == null) {

        response.sendRedirect("/login.jsp");
        return;
    } else {

        if (select != null && select.length != 0) {
            for (int i = 0; i < select.length; i++) {
                RunRestore.runRestore(Integer.valueOf(select[i]));
            }
        }

    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<p>Login as : <% if (session.getAttribute("username") != null) {
    out.println(session.getAttribute("username"));
}%></p>
<a href="/">Index</a>
<a href="/logout.jsp">Logout</a>
<table border="2px" cellpadding="10px">
    <form action="restore.jsp" method="post">
        <%

            try {

                Connection connection = new DbConnect().webDbConnect();
                Statement statement = connection.createStatement();
                String QueryString = "SELECT * from Full_File";
                ResultSet rs = statement.executeQuery(QueryString);

                while (rs.next()) {
        %>
        <tr>
            <td><input type="checkbox" name="id" value=<%=rs.getLong(1)%>></td>
            <td><%=rs.getLong(1)%>
            </td>
            <td><%=rs.getString(2)%>
            </td>
            <td><%=rs.getString(3)%>
            </td>
            <td><%=rs.getString(4)%>
            </td>
            <td><%=rs.getString(5)%>
            </td>
        </tr>
        <%
                }
                rs.close();
                statement.close();
                connection.close();
            } catch (Exception ex) {
                out.println("Unable to connect to database.");
            }
        %>
        <tr>
            <td>
                <input type="submit" value="Submit"/>
            </td>
            <td colspan="5">
                <%
                    if (select != null && select.length != 0) {
                        out.println("You have selected: ");
                        for (int i = 0; i < select.length; i++) {
                            out.println(select[i]);
                        }
                    }
                %>
            </td>
        </tr>
    </form>
    <table width="350" align="center" cellpadding="0" cellspacing="0" >
        <tr>
            <th height="30" scope="col">
                <div id="div1" style="background-color:#0C3">
                    <h2>25%</h2>
                </div>
            </th>
            <th scope="col">
                <div id="div2" style="background-color:#0C3">
                    <h2>50%</h2>
                </div>
            </th>
            <th scope="col">
                <div id="div3" style="background-color:#0C3">
                    <h2>75%</h2>
                </div>
            </th>
            <th scope="col">
                <div id="div4" style="background-color:#0C3">
                    <h2>100%</h2>
                </div>
            </th>
        </tr>
    </table>






    <style type="text/css">
        .style1 {
            color: #0000FF;
        }
        .style3 {
            color: #CC0066;
        }

        img {border: none;}
        #targetDiv {
            float: right;
            border: 2px solid #AAA;
            padding: 0;
            width: 300px;
        }
        .message {
            border-bottom: 1px solid #AAA;
            padding: 5px;
        }

        .message:hover {
            background-color: #F5F5F5;
            cursor: pointer;
        }

        .content {
            float: left;
            padding: 0px;
            width: 248px;
        }
        .icon {
            float: left;
            width: 32px;
            padding: 0 5px;
        }
        .clear {clear:both;}

            /* #targetDiv {
            background-image: url(images/cancel2.png) no-repeat;
            padding-left: 34px;
            border-style:solid;
           border-width:5px;


           } */
    </style>

    <script type="text/javascript">


        function div1enable(){
            document.getElementById('div1').style.visibility = 'visible';
            //alert("Page is loaded");
        }
        function div2enable(){
            document.getElementById('div2').style.visibility = 'visible';
            //alert("Page is loaded");
        }
        function div3enable(){
            document.getElementById('div3').style.visibility = 'visible';
            //alert("Page is loaded");
        }
        function div4enable(){
            document.getElementById('div4').style.visibility = 'visible';
            //alert("Page is loaded");
        }

        function changeVal() {
            alert('Welcome to my page!');
        }



        var auto_refresh = setInterval(
                function ()
                {
                    $
                            .ajax({
                        method:'get',
                        url : "AjaxFromDB2",
                        //	data : "data",
                        dataType: 'json',
                        success : function(json) {

                            var prop = 2;
                            var propCount = 0;

                            //	$('#targetDiv').hide();
                            $('#targetDiv').empty();
                            $.each(json[0], function(i, item) {

                                titlecheck = item.match("fail");

                                if (titlecheck != null ) {

                                    $('#targetDiv').append('<div class="message"> <div class=\"content\">'+item+'</div><div class=\"icon\"><img src=\"images/cancel2.png" width=\"32\" height=\"32\" /></div><div class="clear"></div></div>' ).show();

                                }
                                else {


                                    $('#targetDiv').append('<div class="message"> <div class=\"content\">'+item+'</div><div class=\"icon\"><img src=\"images/red_ok2.png" width=\"32\" height=\"32\" /></div><div class="clear"></div></div>' ).show();
                                    div1 = item.match("deleted");
                                    if (div1 != null ) {
                                        div1enable();
                                    }
                                    div2 = item.match("Hashes");
                                    if (div2 != null ) {
                                        div2enable();
                                    }
                                    div3 = item.match("decompressed");
                                    if (div3 != null ) {
                                        div3enable();
                                    }
                                    div4 = item.match("Restoration");
                                    if (div4 != null ) {
                                        div4enable();
                                    }
                                }
                                propCount++;


                            });


                        }
                    });

//    $('#responsecontainer').load('TestMethord?mode=mode2').fadeIn("slow");
                }, 10000); // refresh every 10000 milliseconds



    </script>
    <div id="targetDiv" style="display: none;">
    </div>

</table>