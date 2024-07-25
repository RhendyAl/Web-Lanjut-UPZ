<%-- 
    Document   : ReadUpz
    Created on : Jun 27, 2024, 2:07:17 PM
    Author     : RhendyAl
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Products</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css">
        <style>
            body {
                background-image: url('./img/BGupz.jpg');
                color: #343a40;
            }
            h1 {
                color: #Black;
                margin-top: 20px;
            }
            table {
                margin-top: 20px;
            }
            .table-warning {
                background-color: #fff3cd;
            }
            .card {
            margin-top: 20px;
            background-color: #e48f45;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            padding: 20px;
            border-radius: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="card">
            <h1 class="text-center">Product Minuman Upz Coffe</h1>
            <div class="d-flex justify-content-center">
            <a href="CreateUpz.jsp" type="button" class="btn btn-primary text-white mb-3">
                <i class="bi bi-plus-lg"></i> Create New Data
            </a>
    </div>
            <table class="table table-bordered table-responsive">
                <thead class="table-dark">
                    <tr class="text-center">
                        <th>Nama</th>
                        <th>Tipe</th>
                        <th>Harga</th>
                        <th>Kategori</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        Connection connection = null;
                        Statement statement = null;
                        ResultSet resultSet = null;
                        
                        try {
                            String connectionURL = "jdbc:mysql://localhost/upz_db";
                            String usernameDB = "root";
                            String passwordDB = "";
                            Class.forName("com.mysql.jdbc.Driver");
                            connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);
                            statement = connection.createStatement();
                            
                            String query = "SELECT * FROM menu";
                            resultSet = statement.executeQuery(query);
                            
                            while(resultSet.next()) {
                    %>
                                <tr class="text-center">   
                                    <td><%= resultSet.getString("Nama") %></td>
                                    <td><%= resultSet.getString("Tipe") %></td>
                                    <td>Rp.<%= resultSet.getString("Harga") %></td>
                                    <td><%= resultSet.getString("Kategori") %></td>
                                    <td>
                        <a class="btn btn-success text-light" href="UpdateUpz.jsp?id=<% out.println(resultSet.getString("id")); %>" role="button"><i class="bi bi-pencil-square"></i>Update</a>
                        <a class="btn btn-danger" href="DeleteUpz.jsp?id=<% out.println(resultSet.getString("id")); %>" role="button"><i class="bi bi-trash"></i>Delete</a>
                    </td>
                                </tr>
                    <% 
                            }
                            resultSet.close(); 
                            statement.close(); 
                            connection.close();
                        } catch(Exception e){
                            e.printStackTrace();
                        }
                    %>
                </tbody>
            </table>
                <div class="d-flex justify-content-center">
                   <a href="index.html" type="button" class="btn btn-danger text-white mb-3">
                   Log Out
                    </a> 
                </div>
                
                </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz4fnFO9gybBogGzFpm5XjlriIYvvPpjsDf3UJzog4z7pUsNyZ9PlBbZGp" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-qQNHrgrHgdL5ATi8iYtdO2AaEjxdAXtXPsUJJkLkpyT37BNWp6eLr70944Y3e0aZ" crossorigin="anonymous"></script>
    </body>
</html>

