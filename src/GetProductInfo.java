

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetProductInfo
 */
@WebServlet("/GetProductInfo")
public class GetProductInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public String getDiscountedPrice(int op, int d) {
		int dp = op - (op*d)/100;
		return dp+"";
	}
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		out.append("<br><br>");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
			PreparedStatement statement = con.prepareStatement("select * from products where productId=?");
			statement.setString(1, request.getParameter("productId"));
			ResultSet rs = statement.executeQuery();
			rs.next();
			out.append("<div class=\"container\">\r\n" + 
					"	      	<div class=\"row\">\r\n" + 
					"	      		<div class=col-lg-4>\r\n" + 
					"	      			<img src=\"images/" + rs.getString(1) + "/productImage.jpg\" height=\"250px\" width=\"200px\">\r\n" + 
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
		} catch(Exception e) {
			
		}
		out.append("</div>");
		out.append("</div>");
		out.append("</div>");
		out.append("<br><br>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
