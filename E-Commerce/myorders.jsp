<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link href="https://fonts.googleapis.com/css?family=Alegreya" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Merriweather|Open+Sans" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title><%=session.getAttribute("sessionName") %>'s orders</title>
</head>
<body>

<div class="text-center" style="background-color:#32127A">
<a style="padding-top:15px; padding-bottom:15px;" class="navbar-brand mr-auto" href="#"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
</div>
<br><br>

<div class="container">
	<h2 style="font-family: 'Merriweather', serif;">Your orders</h2>
</div>
<br><br>
<%!
public String getDiscountedPrice(int op, int d){
	int dp = op - (op*d)/100;
	return dp+"";
}
%>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
PreparedStatement statement = con.prepareStatement("select * from orders where userEmail=?");
statement.setString(1, session.getAttribute("sessionEmail").toString());
ResultSet rs = statement.executeQuery();
%>
<div class="container">
<%
while(rs.next()){
	List<String> products = new ArrayList<>(Arrays.asList(rs.getString(3).split(",")));
	List<String> sizes = new ArrayList<>(Arrays.asList(rs.getString(4).split(",")));
	int total = 0;
	%>
	<div class="card">
		<div class="card-body">
			<div class="card-title">Order Placed: <span style="font-weight:bold"><%=rs.getString(7) %></span></div>
			<div>
				<table class="table table-hover">
					<thead>
						<tr>
							<th colspan="2">Product</th>
							<th>Price</th>
							<th>Size</th>
						</tr>
					</thead>
					<tbody>
					<%
					int i = 0;
					for(String productId: products){
						PreparedStatement statement1 = con.prepareStatement("select * from products where productId=?");
						statement1.setString(1, productId);
						ResultSet rs1 = statement1.executeQuery();
						rs1.next();
						total += Integer.parseInt(getDiscountedPrice(rs1.getInt(10),rs1.getInt(11)));
						%>
						<tr>
<%
String productImagePath = rs1.getString(12);
				if(productImagePath == null)
					productImagePath = "images/" + "prdouctplaceholder.jpg";
				else
					productImagePath = productImagePath.replace("productImages/","productImages%2F");
%>
							<td style="width:150px"><img class="" height="70px" src="<%=productImagePath %>" alt="Card image cap"></td>
							<td style="vertical-align:middle"><%=rs1.getString(2) %></td>
							<td style="vertical-align:middle">$<%=getDiscountedPrice(rs1.getInt(10),rs1.getInt(11)) %></td>
							<td style="vertical-align:middle"><%=sizes.get(i) %></td>
						</tr>
						<%
						i++;
					}
					%>
					</tbody>
				</table>
				<p class="text-right">
				<span style="font-size:22px;font-weight:bold;color:red">Total:</span>&nbsp&nbsp&nbsp<span style="font-size:28px; color:#32127A; font-weight:bold">$<%=total %>.00</span>
				</p>
			</div>
		</div>
	</div><br>
	<%
}
con.close();
%>
</div>
<br><br><br>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.slim.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</html>
