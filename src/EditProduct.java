

import java.io.IOException;
import java.sql.*;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditProduct
 */
@WebServlet("/EditProduct")
public class EditProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
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
		} catch(Exception e) {
			response.getWriter().write(e.getMessage());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
