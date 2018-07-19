<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
PreparedStatement statement = con.prepareStatement("update products set productName=?,productDescription=?"
		+ ",productGender=?,productCategory=?,productQuantitySmall=?,productQuantityMedium=?"
		+ ",productQuantityLarge=?,productPrice=?,productDiscount=? where productId=?");
statement.setString(1, request.getParameter("productName"));
statement.setString(2, request.getParameter("productDescription"));
statement.setString(3, request.getParameter("gender"));
statement.setString(4, request.getParameter("productCategory"));
statement.setString(5, request.getParameter("productQuantitySmall"));
statement.setString(6, request.getParameter("productQuantityMedium"));
statement.setString(7, request.getParameter("productQuantityLarge"));
statement.setString(8, request.getParameter("productPrice"));
statement.setString(9, request.getParameter("productDiscount"));
statement.setString(10, request.getParameter("productId"));
statement.executeUpdate();
response.sendRedirect("adminindex.jsp"); 
%>