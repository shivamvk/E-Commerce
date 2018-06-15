

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
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
 * Servlet implementation class AddAProduct
 */
@WebServlet("/AddAProduct")
public class AddAProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
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
			File file = new File("C:\\Users\\hp\\eclipse-workspace\\E-Commerce\\WebContent\\images" + "\\" + rs.getString(1));
			file.mkdir();
			String path = "C:\\Users\\hp\\eclipse-workspace\\E-Commerce\\WebContent\\images" + "\\productplaceholder.jpg";
			FileInputStream fis = new FileInputStream(path);
			FileOutputStream fos = new FileOutputStream("C:\\Users\\hp\\eclipse-workspace\\E-Commerce\\WebContent\\images\\"
					+ rs.getString(1) + "\\" + "productImage.jpg");
			int i;
			while((i=fis.read())!=-1) {
				fos.write(i);
			}
			fis.close();
			fos.close();
			con.close();
			response.getWriter().write("ok");
		} catch(Exception e) {
			response.getWriter().write(e.getMessage());
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
