<%-- 
    Document   : CreateUpz
    Created on : Jul 4, 2024, 1:15:53 pm
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
        <div class="container">
        <div class="card">
        <h1 class="text-center">Create Menu</h1>
            <div class="container px-5 my-5">

         <form id="contactForm" data-sb-form-api-token="API_TOKEN" action="" method="post">
        <div class="form-floating mb-3">
            <input name="Nama" class="form-control" id="newField1" type="text" placeholder="New Field 1" data-sb-validations="required" />
            <label for="newField1">Nama</label>
        </div>
        <div class="form-floating mb-3">
            <input name="Tipe" class="form-control" id="newField" type="text" placeholder="New Field" data-sb-validations="required" />
            <label for="newField">Tipe</label>
        </div>
        <div class="form-floating mb-3">
            <input name="Harga" class="form-control" id="newField" type="text" placeholder="New Field" data-sb-validations="required" />
            <label for="newField">Harga</label>
        </div>
        <div class="form-floating mb-3 text-center">
            <select name="Kategori" class="form-select"  aria-label="Default select example">
                    <option selected>Jenis</option>
                    <option value="MAKANAN">MAKANAN</option>
                    <option value="MAKANAN">MINUMAN</option>
                 </select>
        </div>
       
        <div class="d-grid">
            <button class="btn btn-primary" type="submit" name="Create Menu" >Kirim</button>

        </div>
    </form>
            </div>
    </body>
    <div class="d-flex justify-content-center">
            <a href="ReadUpz.jsp" type="button" class="btn btn-primary text-white mb-3">
                <i class="bi bi-plus-lg"></i> Kembali
            </a>
    </div>
    </div>
    </div>        
    
    <%@page import = "java.sql.*" %>
    <%@page import = "java.swing.*" %>
    
    <%
    String Nama = request.getParameter("Nama");
    String Tipe = request.getParameter("Tipe");
    String Harga = request.getParameter("Harga");
    String Kategori = request.getParameter("Kategori");
    
    PreparedStatement statement = null;
    Connection connection = null;
    
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    int updateQuery = 0;
    
    if(Nama != null && Tipe != null && Harga != null && Kategori != null) {
        try{
            connection = DriverManager.getConnection(
            "jdbc:mysql://localhost/upz_db",
            "root",
            ""
        );
        String query = "INSERT INTO menu VALUES(NULL,?,?,?,?)";
        statement = connection.prepareStatement(query);
        
        statement.setString(1, Nama);
        statement.setString(2, Tipe);
        statement.setString(3, Harga);
        statement.setString(4, Kategori);
        
        updateQuery = statement.executeUpdate();
        
        if(updateQuery != 0) { response.sendRedirect("ReadUpz.jsp"); }
        } catch(Exception e) { response.sendRedirect("ReadUpz.jsp"); 
        } finally { statement.close(); connection.close(); }
    }
    %>
</html>
