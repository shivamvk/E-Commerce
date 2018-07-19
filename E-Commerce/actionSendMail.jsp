<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.annotation.*"%>
<%@page import="java.servlet.http.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%!
public static void sendMail(String to,String subject,String msg){
final String user="shivambhasin1234@gmail.com";//change accordingly  
	final String pass="shivam123";  
  
	//1st step) Get the session object    
	Properties props = new Properties();  	
	props.setProperty("mail.transport.protocol", "smtp");     
    props.setProperty("mail.host", "smtp.gmail.com");  
    props.put("mail.smtp.auth", "true");  
    props.put("mail.smtp.port", "465");  
    props.put("mail.debug", "true");  
    props.put("mail.smtp.socketFactory.port", "465");  
    props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");  
    props.put("mail.smtp.socketFactory.fallback", "false"); 
  
	Session session = Session.getDefaultInstance(props,  
			new javax.mail.Authenticator() {  
				protected PasswordAuthentication getPasswordAuthentication() {  
					return new PasswordAuthentication(user,pass);  
				}  
			});  
//2nd step)compose message  
	try {  
		MimeMessage message = new MimeMessage(session);  
		message.setFrom(new InternetAddress(user));  
		message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
		message.setSubject(subject);  
		message.setText(msg);  
   
 //3rd step)send message  
		Transport.send(message);  
  
		System.out.println("Done");  
  
	} catch (MessagingException e) {  
		throw new RuntimeException(e);  
	}  

}
%>

<%
String Products = "";
String Sizes = "";
String SoldBy = "";
Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
			PreparedStatement statement = con.prepareStatement("select * from cart where userEmail=?");
			statement.setString(1, session.getAttribute("sessionEmail").toString());
			ResultSet rs = statement.executeQuery();
			while(rs.next()) {
				Sizes += rs.getString(3) + ",";
				Products += rs.getString(2) + ",";
				PreparedStatement statement1 = con.prepareStatement("select * from products where productId=?");
				statement1.setString(1, rs.getString(2));
				ResultSet rs1 = statement1.executeQuery();
				rs1.next();
				SoldBy += rs1.getString(9) + ",";
			}
			PreparedStatement statement1 = con.prepareStatement("insert into orders(userEmail,products,sizes,soldBy,total,dateOfOrder) values(?,?,?,?,?,?)");
			statement1.setString(1, session.getAttribute("sessionEmail").toString());
			statement1.setString(2, Products);
			statement1.setString(3, Sizes);
			statement1.setString(4, SoldBy);
			statement1.setString(5, request.getParameter("totalPrice"));
			long millis=System.currentTimeMillis();  
			java.util.Date date=new java.util.Date(millis);
			statement1.setString(6, date.toString());
			statement1.executeUpdate();
			
			PreparedStatement statement2 = con.prepareStatement("delete from cart where userEmail=?");
			statement2.setString(1, session.getAttribute("sessionEmail").toString());
			statement2.executeUpdate();
			
			con.close();
response.setContentType("text/html");  
	    String to = session.getAttribute("sessionEmail").toString();  
	    String subject = "Your order has been placed successfully!";  
	    String msg = "Thankyou for ordering! ^_^";  
	          
	    sendMail(to, subject, msg);  
	    out.print("<h2 style='text-align:center'>You order has been placed succesfully!</h2>");
	    out.print("<a href='index.jsp'>Click here to go back to the home page!</a>");
	    out.close(); 
%>
