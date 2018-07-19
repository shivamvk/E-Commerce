<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
    
    <%@page import="java.io.*" %>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
PreparedStatement statement = con.prepareStatement("insert into products"
		+ "(productName,productDescription,productGender,productCategory,productQuantitySmall,productQuantityMedium,productQuantityLarge,productSoldBy,productPrice,productDiscount)"
		+ " values(?,?,?,?,?,?,?,?,?,?)");
statement.setString(1, request.getParameter("productName"));
statement.setString(2, request.getParameter("productDescription"));
statement.setString(3, request.getParameter("productGender"));
statement.setString(4, request.getParameter("productCategory"));
statement.setString(5, request.getParameter("productQuantitySmall"));
statement.setString(6, request.getParameter("productQuantityMedium"));
statement.setString(7, request.getParameter("productQuantityLarge"));
statement.setString(8, session.getAttribute("sessionAdminEmail").toString());
statement.setString(9, request.getParameter("productPrice"));
statement.setString(10, request.getParameter("productDiscount"));
statement.executeUpdate();
PreparedStatement statement1 = con.prepareStatement("select * from products order by productId desc");
ResultSet rs = statement1.executeQuery();
rs.next();
File file = new File("/home/ubuntu/Downloads/apache-tomcat-9.0.10/webapps/E-Commerce/images" + "/" + rs.getString(1));
file.mkdir();
String path = "/home/ubuntu/Downloads/apache-tomcat-9.0.10/webapps/E-Commerce/images" + "/productplaceholder.jpg";
FileInputStream fis = new FileInputStream(path);
FileOutputStream fos = new FileOutputStream("/home/ubuntu/Downloads/apache-tomcat-9.0.10/webapps/E-Commerce/images/"
		+ rs.getString(1) + "/" + "productImage.jpg");
int i;
while((i=fis.read())!=-1) {
	fos.write(i);
}
fis.close();
fos.close();
con.close();
response.getWriter().write("ok");
%>