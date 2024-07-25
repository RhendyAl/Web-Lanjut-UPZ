<%-- 
    Document   : LogoutUser
    Created on : Jul 4, 2024, 1:20:43 PM
    Author     : RhendyAl
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Hapus semua atribut dari session
    session.invalidate();
    
    // Redirect ke halaman login
    response.sendRedirect("LoginUserTest.jsp");
%>
