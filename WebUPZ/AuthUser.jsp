<%-- 
    Document   : AuthUser
    Created on : Jul 4, 2024, 1:18:38 PM
    Author     : RhendyAl
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    
    
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Contoh autentikasi sederhana
    if ("admin".equals(username) && "password".equals(password)) {
        // Autentikasi berhasil, set session dan redirect ke halaman welcome
        session.setAttribute("username", username);
        response.sendRedirect("ReadUpz.jsp");
    } else {
        // Autentikasi gagal, redirect kembali ke halaman login
        response.sendRedirect("LoginUserTest.jsp?error=true");
    }
%>

