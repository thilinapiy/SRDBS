<%
    session.invalidate();
    response.sendRedirect("/login.jsp");
    return;
%>