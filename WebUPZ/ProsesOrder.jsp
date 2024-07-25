<%-- 
    Document   : ProcessTransaction
    Created on : Jul 14, 2024, 1:25:27 AM
    Author     : Acer
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <title>Upz Coffee</title>
        <style>
            body {
                font-family: 'Comic Sans MS', cursive, sans-serif;
                background-size: cover;
                background-repeat: no-repeat;
                background-image: url('./img/BGupz.jpg');
                color: #343a40;
            }

            h1 {
                color: black;
                margin-top: 20px;
            }
            .sidebar .nav-link.active {
                background-color: #0d6efd;
            }
            .logo {
                max-width: 40%;
                height: auto;
            }
            .header {
                text-align: center;
            }
            .sidebar {
                height: 100vh;
            }
            .content {
                margin-left: 280px;
            }
            .qris {
                max-width: 100%;
                height: auto;
            }
            .transaksi-container {
                background-color: rgba(255, 255, 255, 0.8);
                margin-right: 10px;
            }
            
        </style>
    </head>
    <body>
        <div class="d-flex">
            <div class="container-fluid mt-5">
                
                    <div class="row justify-content-center">
                        <div class="col-md-6 mb-5 p-4 rounded" style="background-color: #e48f45;">
                            <div id="printableArea">
                                <div class="header row justify-content-center">
                                    <div class="header row justify-content-start" style="width: 10rem">
                                        <img src="img/logoupz.png" class="text-start p-0">
                                    </div>
                                    <div class="address d-flex justify-content-center mb-2">
                                        <p>Jl. Komp. Perdana Square<br>Kota Pontianak</p>
                                    </div>
                                    <div class="text-start datetime mt-1 ">
                                        <p>Tanggal : <span id="date"></span></p>
                                        <p>Jam : <span id="time"></span></p>
                                    </div>
                                        <hr>
                                </div>
                                <p><b>Pesanan: </b></p>
<!--                            <div class="header mt-3">
                                <h1 class="text-center" ><strong>Cetak Transaksi</strong></h1>
                            </div>-->
                            <%
                                String namaPelanggan = request.getParameter("namaPelanggan");

                                Connection connection = null;
                                PreparedStatement preparedStatement = null;

                                try {
                                    String connectionURL = "jdbc:mysql://localhost/upz_db";
                                    String usernameDB = "root";
                                    String passwordDB = "";

                                    Class.forName("com.mysql.jdbc.Driver");
                                    connection = DriverManager.getConnection(connectionURL, usernameDB, passwordDB);

                                    // Mulai Transaksi
                                    connection.setAutoCommit(false);

                                    // Insert into transaksi table
                                    String transaksiQuery = "INSERT INTO transaksi (tanggal, total_harga, nama_pelanggan) VALUES (CURDATE(), ?, ?)";
                                    preparedStatement = connection.prepareStatement(transaksiQuery, Statement.RETURN_GENERATED_KEYS);

                                    double total = 0;
                                    HashMap<Integer, Integer> orderDetails = new HashMap<>();

                                    for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
                                        if (entry.getKey().startsWith("quantity_")) {
                                            int productId = Integer.parseInt(entry.getKey().substring(9));
                                            int quantity = Integer.parseInt(entry.getValue()[0]);

                                            if (quantity > 0) {
                                                Statement statement = connection.createStatement();
                                                ResultSet resultSet = statement.executeQuery("SELECT Harga, Nama, Tipe FROM menu WHERE id = " + productId);

                                                if (resultSet.next()) {
                                                    double harga = resultSet.getDouble("Harga");
                                                    total += harga * quantity;
                                                    orderDetails.put(productId, quantity);
                                                }

                                                resultSet.close();
                                                statement.close();
                                            }
                                        }
                                    }

                                    preparedStatement.setDouble(1, total);
                                    preparedStatement.setString(2, namaPelanggan);
                                    preparedStatement.executeUpdate();

                                    ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                                    int transactionId = 0;
                                    if (generatedKeys.next()) {
                                        transactionId = generatedKeys.getInt(1);
                                    }

                                    // Insert into pesanan table
                                    String pesananQuery = "INSERT INTO pesanan (id_transaksi, id_produk, kuantitas, harga) VALUES (?, ?, ?, ?)";
                                    preparedStatement = connection.prepareStatement(pesananQuery);

                                    // Insert into purchases table
                                    String purchasesQuery = "INSERT INTO purchases (transaction_id, customer_name, product_name, product_description, price, quantity, total_price, transaction_date) VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
                                    PreparedStatement purchasesPreparedStatement = connection.prepareStatement(purchasesQuery);

                                    for (Map.Entry<Integer, Integer> entry : orderDetails.entrySet()) {
                                        int productId = entry.getKey();
                                        int quantity = entry.getValue();

                                        Statement statement = connection.createStatement();
                                        ResultSet resultSet = statement.executeQuery("SELECT Harga, Nama, Tipe FROM menu WHERE id = " + productId);

                                        if (resultSet.next()) {
                                            double harga = resultSet.getDouble("Harga");
                                            String namaMenu = resultSet.getString("Nama");
                                            String deskripsi = resultSet.getString("Tipe");
                                            double subtotal = harga * quantity;

                                            // Insert into pesanan table
                                            preparedStatement.setInt(1, transactionId);
                                            preparedStatement.setInt(2, productId);
                                            preparedStatement.setInt(3, quantity);
                                            preparedStatement.setDouble(4, harga);
                                            preparedStatement.executeUpdate();

                                            // Insert into purchases table
                                            purchasesPreparedStatement.setInt(1, transactionId);
                                            purchasesPreparedStatement.setString(2, namaPelanggan);
                                            purchasesPreparedStatement.setString(3, namaMenu);
                                            purchasesPreparedStatement.setString(4, deskripsi);
                                            purchasesPreparedStatement.setDouble(5, harga);
                                            purchasesPreparedStatement.setInt(6, quantity);
                                            purchasesPreparedStatement.setDouble(7, subtotal);
                                            purchasesPreparedStatement.executeUpdate();
                                            
                                            out.println("<div style='display: flex; justify-content: space-between; width: 100%;'>");
                                            out.println("<span>" + namaMenu + "<b>    x </b> " + quantity + " </span>");
                                            out.println("<p style='text-align: end'>Rp. " + subtotal + "</p>");
                                            out.println("</div>");
                                        }

                                        resultSet.close();
                                        statement.close();
                                    }

                                    // Commit Transaksi
                                    connection.commit();

                                    preparedStatement.close();
                                    purchasesPreparedStatement.close();
                                    connection.close();

                                    out.println("<hr>");
                                    out.println("<br>");
                                    out.println("<p style='text-align: right;'>Total :  <strong> " + "Rp. " + total + "</strong></p>");
                                    out.println("<p style='text-align: right;'>Pelanggan : " + "<b>" + namaPelanggan + "<b>" + "</p>");
                                } catch (Exception e) {
                                    if (connection != null) {
                                        try {
                                            connection.rollback();
                                        } catch (SQLException ex) {
                                            out.println("<div class='alert alert-danger' role='alert'>" + ex.getMessage() + "</div>");
                                        }
                                    }
                                    out.println("<div class='alert alert-danger' role='alert'>" + e.getMessage() + "</div>");
                                }
                            %>
                            </div>
                            <div class="d-flex justify-content-center">
                            <a href="ORDER.jsp" class="btn btn-danger mt-3">Kembali ke Menu</a>
                            <input class="btn btn-primary ms-3 mt-3" type="button" onclick="printDiv('printableArea')" value="Print" />
                            </div>
                    </div>
                </div>
            </div>
        </div>
        <script> 
            function printDiv(divName) {
            var printContents = document.getElementById(divName).innerHTML;
            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
            }
        </script>
        <script>
            function updateDateTime() {
                var now = new Date();
                var date = now.toLocaleDateString();
                var time = now.toLocaleTimeString();
                document.getElementById('date').innerText = date;
                document.getElementById('time').innerText = time;
            }

            setInterval(updateDateTime, 1000); // Update every second
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>