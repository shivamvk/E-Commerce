

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
 * Servlet implementation class Signup
 */
@WebServlet("/Signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
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
		} catch (Exception e) {
			
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
