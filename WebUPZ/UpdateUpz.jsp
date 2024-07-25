<%-- 
    Document   : UpdateUpz
    Created on : Jul 4, 2024, 1:55:16 pm
    Author     : RhendyAl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Menu</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <style>
        body {
                background-image: url('./img/BGupz.jpg');
                color: #343a40;
            }
             h1 {
                color: #Black;
                margin-top: 20px;
            }
            .card {
            margin-top: 20px;
            background-color: #e48f45;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            padding: 20px;
            border-radius: 10px;
            }
    </style>
    <body>
        <%@page import = "java.sql.*" %>
<%
        String id = request.getParameter("id");
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
            try {
                String connectionURL = "jdbc:mysql://localhost/upz_db";
                String userName = "root";
                String passWord = "";
                Class.forName("com.mysql.jdbc.Driver");
                connection = DriverManager.getConnection(connectionURL, userName,passWord);
                statement = connection.createStatement();
                String query = "SELECT * FROM menu WHERE id=" + id + "";
                resultSet = statement.executeQuery(query);
                while(resultSet.next()) {
%>
<div class="container">
    <div class="card">
        <h1 class="text-center">Update Menu</h1>
            <div class="container px-5 my-5">

         <form id="contactForm" data-sb-form-api-token="API_TOKEN" action="processUpdateUpz.jsp" method="post">
        <input type="hidden" name="id" value="<%out.println(resultSet.getString("id"));%>">
        <div class="form-floating mb-3">
            <input  value="<%out.println(resultSet.getString("Nama"));%>"  name="Nama" class="form-control" id="newField1" type="text" placeholder="New Field 1" data-sb-validations="required" />
            <label for="newField1">Nama</label>
        </div>
        <div class="form-floating mb-3">
            <input  value="<%out.println(resultSet.getString("Tipe"));%>"  name="Tipe" class="form-control" id="newField" type="text" placeholder="New Field" data-sb-validations="required" />
            <label for="newField">Tipe</label>
        </div>
        <div class="form-floating mb-3">
            <input  value="<%out.println(resultSet.getString("Harga"));%>"  name="Harga" class="form-control" id="newField" type="text" placeholder="New Field" data-sb-validations="required" />
            <label for="newField">Harga</label>
        </div>    
        <div class="form-floating mb-3 text-center">
            <select name="Kategori" class="form-select"  aria-label="Default select example">
                    <option  value="<%out.println(resultSet.getString("Kategori"));%>"  selected>Jenis</option>
                    <option value="MAKANAN">MAKANAN</option>
                    <option value="MINUMAN">MINUMAN</option>
                 </select>
        </div>
       
        <div class="d-grid">
            <button class="btn btn-primary" type="submit" name="Update Menu" >Kirim</button>
        </div>
    </form>
            </div>
                    </div>
                    </div>
    </body>
    <%
                }
                } catch (Exception e) {
                        out.println(e.getMessage());
                }
%>
</html>
