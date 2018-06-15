

import java.io.IOException;
import java.sql.*;
import java.sql.DriverManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
        response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
        try {
        	Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
			PreparedStatement statement = con.prepareStatement("select * from sellers where email=? and password=?");
			statement.setString(1, request.getParameter("email"));
			statement.setString(2, request.getParameter("password"));
			ResultSet rs = statement.executeQuery();
			if(rs.next()) {
				session.setAttribute("sessionAdminEmail", rs.getString(3));
				session.setAttribute("sessionAdminName", rs.getString(2));
				response.getWriter().write("ok");
			} else {
				response.getWriter().write("not");
			}
        } catch(Exception e) {
        	
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
