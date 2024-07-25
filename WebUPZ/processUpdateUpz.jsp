<%-- 
    Document   : processUpdateUpz
    Created on : Jul 3, 2024, 11:58:59 AM
    Author     : User
--%>
<%-- 
    Document   : processUpdateProduct
    Created on : Jun 20, 2024, 15:43:09 PM
    Author     : RhendyAl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
 <%@page import = "java.sql.*" %>
<%
        String id = request.getParameter("id");
        String Nama = request.getParameter("Nama");
        String Tipe = request.getParameter("Tipe");
        String Harga = request.getParameter("Harga");
        String Kategori = request.getParameter("Kategori");
            if(id != null) {
                String connectionURL = "jdbc:mysql://localhost/upz_db";
                Connection connection = null;
                PreparedStatement statement = null;
                Class.forName("com.mysql.jdbc.Driver");
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    connection = DriverManager.getConnection(connectionURL, "root","");
                    String query = "UPDATE menu SET id=?, Nama=?, Tipe=? , Harga=?, Kategori=? WHERE id=" + id + "";
                    statement = connection.prepareStatement(query);
                    statement.setString(1, id);
                    statement.setString(2, Nama);
                    statement.setString(3, Tipe);
                    statement.setString(4, Harga);
                    statement.setString(5, Kategori);
                    int i = statement.executeUpdate();
                    response.sendRedirect("ReadUpz.jsp");
                    } catch (Exception e) {
                    response.sendRedirect("ReadUpz.jsp");
                    }
                    }
%>

    </body>
</html>


