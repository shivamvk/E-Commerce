<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
			PreparedStatement statement = con.prepareStatement("select * from cart where userEmail=? and productId=?");
			statement.setString(1, request.getSession().getAttribute("sessionEmail").toString());
			statement.setString(2, request.getParameter("productId"));
			ResultSet rs = statement.executeQuery();
			if(rs.next()) {
				response.getWriter().write("not");
			} else {
				PreparedStatement statement1 = con.prepareStatement("insert into cart values(?,?,?)");
				statement1.setString(1, request.getSession().getAttribute("sessionEmail").toString());
				statement1.setString(2, request.getParameter("productId"));
				statement1.setString(3, request.getParameter("size"));
				statement1.executeUpdate();
				response.getWriter().write("ok");
			}
%>
