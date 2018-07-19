<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>

<%
Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
			PreparedStatement statement = con.prepareStatement("delete from cart where productId=? and userEmail=?");
			statement.setString(1, request.getParameter("productId"));
			statement.setString(2, request.getSession().getAttribute("sessionEmail").toString());
			statement.executeUpdate();
			response.sendRedirect(request.getParameter("calledBy"));
%>
