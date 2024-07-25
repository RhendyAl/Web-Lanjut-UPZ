<%-- 
    Document   : AuthClient
    Created on : Jul 17, 2024, 8:18:50 PM
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    
    
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Contoh autentikasi sederhana
    if ("client".equals(username) && "santuy".equals(password)) {
        // Autentikasi berhasil, set session dan redirect ke halaman welcome
        session.setAttribute("username", username);
        response.sendRedirect("ORDER.jsp");
    } else {
        // Autentikasi gagal, redirect kembali ke halaman login
        response.sendRedirect("LoginClient.jsp?error=true");
    }
%>
