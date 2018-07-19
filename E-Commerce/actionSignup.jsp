<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
PreparedStatement statement = con.prepareStatement("select * from users where email=?");
statement.setString(1, request.getParameter("email"));
ResultSet rs = statement.executeQuery();
if(rs.next()) {
	response.getWriter().write("not");
} else {
	PreparedStatement statement1 = con.prepareStatement("insert into users(email,password,name) values(?,?,?)");
	statement1.setString(1, request.getParameter("email"));
	statement1.setString(2, request.getParameter("password"));
	statement1.setString(3, request.getParameter("name"));
	statement1.executeUpdate();
	session.setAttribute("sessionEmail", request.getParameter("email"));
	session.setAttribute("sessionName", request.getParameter("name"));
	response.getWriter().write("ok");
}
%>