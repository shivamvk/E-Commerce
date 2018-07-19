<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
PreparedStatement statement = con.prepareStatement("select * from users where email=? and password=?");
statement.setString(1, request.getParameter("email"));
statement.setString(2, request.getParameter("password"));
ResultSet rs = statement.executeQuery();
if(rs.next()) {
	session.setAttribute("sessionEmail", request.getParameter("email"));
	session.setAttribute("sessionName", rs.getString(4));
	response.getWriter().write("ok");
} else {
	response.getWriter().write("not");
}
%>