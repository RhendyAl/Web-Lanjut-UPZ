<%-- 
    Document   : WelcomeUser
    Created on : Jul 4, 2024, 1:19:53 PM
    Author     : RhendyAl
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome Page</title>
</head>
<body>
    <h2>Welcome, <%= session.getAttribute("username") %></h2>
    <p>This is a secure area. Only authenticated users can access this page.</p>
    <p><a href="LogoutUser.jsp">Back to login user</a></p>
</body>
</html>
