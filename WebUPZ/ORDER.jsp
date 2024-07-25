<%-- 
    Document   : ORDER
    Created on : Jul 17, 2024, 4:56:20 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Custom CSS -->
        <style>
            body {
                background-image: url('./img/BGupz.jpg');
                color: #343a40;
            }
            .container {
                max-width: 800px; /* Set maximum width for the container */
                margin-top: 20px;
                background-color: #e48f45;
                box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
                padding: 20px;
                border-radius: 10px;
            }
            .header {
                text-align: center;
                margin-bottom: 20px;
            }
            .form-floating {
                margin-bottom: 20px;
            }
            .form-control {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }
            .table-responsive {
                overflow-x: auto;
            }
            .table {
                width: 100%;
                border-collapse: collapse;
            }
            .table th,
            .table td {
                border: 1px solid #dddddd;
                padding: 8px;
                text-align: left;
            }
            .table th {
                background-color: #343a40;
                color: white;
            }
            .table tbody tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .btn {
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }
            .btn:hover {
                background-color: #0056b3;
            }
            .search-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .entries-dropdown {
                display: flex;
                align-items: center;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1 class="text-black"><strong>List Menu</strong></h1>
            </div>
            <form action="ProsesOrder.jsp" method="post" id="orderForm">
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="namaPelanggan" name="namaPelanggan" placeholder="Nina" required>
                    <label for="namaPelanggan">Nama Pelanggan</label>
                </div>
                <div class="search-container">
                    <div class="entries-dropdown">
                        <label for="entriesSelect">Show </label>
                        <select id="entriesSelect" class="form-select" style="width: auto; margin-left: 5px; margin-right: 5px;">
                            <option value="5">5</option>
                            <option value="10" selected>10</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                        </select>
                        <label for="entriesSelect"> entries</label>
                    </div>
                    <input type="text" class="form-control" id="searchInput" placeholder="Search menu by name" style="width: auto;">
                </div>
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th>Nama</th>
                                <th>Deskripsi</th>
                                <th>Harga</th>
                                <th>Kuantitas</th>
                            </tr>
                        </thead>
                        <tbody id="menuTableBody">
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

                                    while (resultSet.next()) {
                            %>
                            <tr>
                                <td><%= resultSet.getString("Nama")%></td>
                                <td><%= resultSet.getString("Tipe")%></td>
                                <td>Rp.<%= resultSet.getString("Harga")%></td>
                                <td>
                                    <input type="number" name="quantity_<%= resultSet.getInt("id")%>" min="0" value="0" class="form-control quantityInput">
                                </td>
                            </tr>
                            <%
                                    }
                                    resultSet.close();
                                    statement.close();
                                    connection.close();
                                } catch (Exception e) {
                                    out.println(e.getMessage());
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-center">
                    <button type="submit" class="btn mb-3">Proses Transaksi</button>
                    <a href="index.html" type="button" class="btn btn-danger text-white mb-3 ms-3"> Log Out</a> 
                </div>
            </form>           
        </div>
        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var quantityInputs = document.querySelectorAll(".quantityInput");
                var searchInput = document.getElementById("searchInput");
                var entriesSelect = document.getElementById("entriesSelect");
                var tableBody = document.getElementById("menuTableBody");
                var rows = tableBody.getElementsByTagName("tr");

                // Add event listeners to all quantity inputs
                quantityInputs.forEach(function (input) {
                    input.addEventListener("input", function () {
                        calculateTotalPrice();
                    });
                });

                // Function to calculate total price
                function calculateTotalPrice() {
                    var total = 0;

                    for (var i = 0; i < rows.length; i++) {
                        var quantity = parseInt(rows[i].querySelector(".quantityInput").value);
                        var price = parseFloat(rows[i].cells[2].innerText.replace("Rp.", "").replace(",", ""));

                        total += quantity * price;
                    }

                    var totalPriceElement = document.getElementById("totalPrice");
                    if (totalPriceElement) {
                        totalPriceElement.innerText = "Total: Rp." + total.toFixed(2);
                    }
                }

                // Function to filter table rows based on search input
                searchInput.addEventListener("input", function () {
                    filterAndLimitRows();
                });

                // Function to limit table rows based on selected entries
                entriesSelect.addEventListener("change", function () {
                    filterAndLimitRows();
                });

                // Function to filter and limit rows based on search and selected entries
                function filterAndLimitRows() {
                    var filter = searchInput.value.toLowerCase();
                    var entries = parseInt(entriesSelect.value);
                    var visibleRowCount = 0;

                    for (var i = 0; i < rows.length; i++) {
                        var nameCell = rows[i].getElementsByTagName("td")[0];
                        if (nameCell) {
                            var txtValue = nameCell.textContent || nameCell.innerText;
                            if (txtValue.toLowerCase().indexOf(filter) > -1 && visibleRowCount < entries) {
                                rows[i].style.display = "";
                                visibleRowCount++;
                            } else {
                                rows[i].style.display = "none";
                            }
                        }
                    }
                }

                // Initially display only the first selected entries
                (function displayInitialRows() {
                    var entries = parseInt(entriesSelect.value);
                    var visibleRowCount = 0;

                    for (var i = 0; i < rows.length; i++) {
                        if (visibleRowCount < entries) {
                            rows[i].style.display = "";
                            visibleRowCount++;
                        } else {
                            rows[i].style.display = "none";
                        }
                    }
                })();
            });
        </script>
    </body>
</html>



