

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AdminSignup
 */
@WebServlet("/AdminSignup")
public class AdminSignup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
        response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
			PreparedStatement statement = con.prepareStatement("select * from sellers where email=?");
			statement.setString(1, request.getParameter("email"));
			ResultSet rs = statement.executeQuery();
			if(rs.next()) {
				response.getWriter().write("not");
			} else {
				response.getWriter().write("okay");
				PreparedStatement statement1 = con.prepareStatement("insert into sellers(email,password,name) values(?,?,?)");
				statement1.setString(1, request.getParameter("email"));
				statement1.setString(2, request.getParameter("password"));
				statement1.setString(3, request.getParameter("name"));
				statement1.executeUpdate();
				session.setAttribute("sessionAdminEmail", request.getParameter("email"));
				session.setAttribute("sessionAdminName", request.getParameter("name"));
			}
		} catch (Exception e) {
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
