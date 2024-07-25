<%-- 
    Document   : DeleteUPZ
    Created on : Jul 4, 2024, 2:38:13 PM
    Author     : RhendyAl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Upz</title>
    </head>
    <body>
        <%@page import = "java.sql.*" %>
<%
String id = request.getParameter("id");
try {
Class.forName("com.mysql.jdbc.Driver");
String connectionURL = "jdbc:mysql://localhost/upz_db";
Connection connection = DriverManager.getConnection(connectionURL,
"root", "");
Statement statement = connection.createStatement();
int i = statement.executeUpdate("DELETE FROM menu WHERE id=" + id +
"");
response.sendRedirect("ReadUpz.jsp");
} catch (Exception e) {
response.sendRedirect("ReadUpz.jsp");
}
%>
    </body>
</html>
