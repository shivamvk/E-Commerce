

import java.io.IOException;
import java.sql.*;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddToCart
 */
@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
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
		} catch(Exception e) {
			response.getWriter().write("not");
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
