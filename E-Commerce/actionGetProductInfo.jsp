<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%!
public String getDiscountedPrice(int op, int d) {
		int dp = op - (op*d)/100;
		return dp+"";
	}
%>

<%
out.append("<br><br>");
Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
			PreparedStatement statement = con.prepareStatement("select * from products where productId=?");
			statement.setString(1, request.getParameter("productId"));
			ResultSet rs = statement.executeQuery();
			rs.next();
			String productImagePath = rs.getString(12);
			if(productImagePath == null)
				productImagePath = "images/" + "prdouctplaceholder.jpg";
			else
				productImagePath = productImagePath.replace("productImages/","productImages%2F");
			out.append("<div class=\"container\">\r\n" + 
					"	      	<div class=\"row\">\r\n" + 
					"	      		<div class=col-lg-4>\r\n" + 
					"	      			<img src=\"" +productImagePath + "\" height=\"250px\" width=\"200px\">\r\n" + 
					"	      		</div>");
			out.append("<div class=col-lg-8>");
			out.append("<span style=\"font-weight:bold; font-size: 28px; color:#32127A\">" + rs.getString(2) + "</span><br>");
			out.append("<span style=\"\">" + rs.getString(3) + "</span><br><br>");
			out.append("<span>Lorem ipsum dolor sit amet, \r\n" + 
					"	      			consectetur adipisicing elit. Quidem libero ullam assumenda consequuntur illum reiciendis aliquid.\r\n" + 
					"	      			 Quaerat perspiciatis fugiat rerum, labore, voluptates.</span><br><br>");
			out.append("<span><del style=\"text-decoration:line-through\">$" + rs.getString(10) + "</del></span>&nbsp&nbsp");
			out.append("<span style=\"color:red\">" + rs.getString(11) + "% off</span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp");
			out.append("<span style=\"font-size:28px; color:#32127A\">$" + getDiscountedPrice(rs.getInt(10),rs.getInt(11)) + "</span><br><br>");
			out.append("<select id='productdisplaysize' class=\"form-control\">\r\n" +
					"	      	<option>Select your size</option>\r\n" + 
					"	      	<option>Small</option>\r\n" + 
					"	      	<option>Medium</option>\r\n" + 
					"	      	<option>Large</option>\r\n" + 
					"	      </select><br>");
			out.append("<p id='addtocarterror' style='color:red'></p>");
			out.append("<button onclick=\"addtocart(" + rs.getString(1) + ")\" class=\"btn btn-md btn-info\"><i class=\"fa fa-shopping-cart\"></i>&nbsp&nbspAdd item to cart</button>");
			con.close();
out.append("</div>");
		out.append("</div>");
		out.append("</div>");
		out.append("<br><br>");
%>
