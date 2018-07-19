<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
out.append("<div class=\"modal-header\">\r\n" + 
		"        <h5 class=\"modal-title\" id=\"editproductmodal\">Edit product</h5>\r\n" + 
		"        <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\">\r\n" + 
		"          <span aria-hidden=\"true\">&times;</span>\r\n" + 
		"        </button>\r\n" + 
		"      </div>\r\n" + 
		"      <div class=\"modal-body \">");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
PreparedStatement statement = con.prepareStatement("select * from products where productId=?");
statement.setString(1, request.getParameter("productId"));
ResultSet rs = statement.executeQuery();
rs.next();
out.append("<form action=\"actionEditProduct.jsp\" method=\"get\" style=\"max-height:400px; overflow-y:scroll\">");
out.append("<input type=\"hidden\" value=\"" + rs.getString(1) + "\" name=\"productId\">");
out.append("<input required value=\" " + rs.getString(2) + "\" type=\"text\" class=\"form-control\" placeholder=\"Product Name\" name=\"productName\"><br>");
out.append("<input required value=\"" + rs.getString(3) + "\" class=\"form-control\" placeholder=\"Product Description\" name=\"productDescription\"><br>");
out.append("<div class=\"form-inline\">\r\n" + 
		"	        	<input value=\"Male\" required type=\"radio\" name=\"gender\" class=\"form-control\" id=\"productGenderMale\">\r\n" + 
		"	        	<label for=\"productGenderMale\">&nbsp&nbspMale</label>&nbsp&nbsp&nbsp&nbsp&nbsp\r\n" + 
		"	        	<input value=\"Female\" type=\"radio\" name=\"gender\" class=\"form-control\" id=\"productGenderFemale\">\r\n" + 
		"	        	<label for=\"productGenderFemale\">&nbsp&nbspFemale</label>&nbsp&nbsp&nbsp&nbsp&nbsp\r\n" + 
		"	        	<input value=\"Both\" type=\"radio\" name=\"gender\" class=\"form-control\" id=\"productGenderBoth\">\r\n" + 
		"	        	<label for=\"productGenderBoth\">&nbsp&nbspBoth</label>\r\n" + 
		"        	</div><br>");
out.append("<select required name=\"productCategory\" class=\"form-control\">\r\n" + 
		"        		<option value=\"Topwear\">Topwear</option>\r\n" + 
		"        		<option value=\"Bottomwear\">Bottomwear</option>\r\n" + 
		"        		<option value=\"Footwear\">Footwear</option>\r\n" + 
		"        		<option value=\"Accessories\">Accessories</option>\r\n" + 
		"        	</select><br>");
out.append("<input required value=\"" + rs.getString(6) + "\" type=\"number\" class=\"form-control\" name=\"productQuantitySmall\" placeholder=\"Quantity you have for small size\"><br>");
out.append("<input required value=\"" + rs.getString(7) + "\" type=\"number\" class=\"form-control\" name=\"productQuantityMedium\" placeholder=\"Quantity you have for medium size\"><br>");
out.append("<input required value=\"" + rs.getString(8) + "\" type=\"number\" class=\"form-control\" name=\"productQuantityLarge\" placeholder=\"Quantity you have for large size\"><br>");
out.append("<input required value=\"" + rs.getString(10) + "\" type=\"number\" class=\"form-control\" name=\"productPrice\" placeholder=\"Price of the product\"><br>");
out.append("<input required value=\"" + rs.getString(11) + "\" type=\"number\" class=\"form-control\" name=\"productDiscount\" placeholder=\"Discount on product(%)\">");
out.append("<br><input type=\"submit\" class=\"btn btn-md btn-info\" value=\"Update\">");
out.append("</form>");
out.append("</div>");
out.append("<div class=\"modal-footer\">");
out.append("</div>");
out.append("</form>");
%>