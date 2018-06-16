<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
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
<title>Checkout - <%=session.getAttribute("sessionName") %></title>
<style>
* {
  box-sizing: border-box;
}
html, body {
    max-width: 100%;
    overflow-x: hidden;
}

.row {
  display: -ms-flexbox; /* IE10 */
  display: flex;
  -ms-flex-wrap: wrap; /* IE10 */
  flex-wrap: wrap;
  margin: 0 -16px;
}

.col-25 {
  -ms-flex: 25%; /* IE10 */
  flex: 25%;
}

.col-50 {
  -ms-flex: 50%; /* IE10 */
  flex: 50%;
}

.col-75 {
  -ms-flex: 75%; /* IE10 */
  flex: 75%;
}

.col-25,
.col-50,
.col-75 {
  padding: 0 16px;
}

.container {
  background-color: #f2f2f2;
  padding: 5px 20px 15px 20px;
  border: 1px solid lightgrey;
  border-radius: 3px;
}

input[type=text] {
  width: 100%;
  margin-bottom: 20px;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

label {
  margin-bottom: 10px;
  display: block;
}

.icon-container {
  margin-bottom: 20px;
  padding: 7px 0;
  font-size: 24px;
}

a {
  color: #2196F3;
}

hr {
  border: 1px solid lightgrey;
}

span.price {
  float: right;
  color: grey;
}

/* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other (also change the direction - make the "cart" column go on top) */
@media (max-width: 800px) {
  .row {
    flex-direction: column-reverse;
  }
  .col-25 {
    margin-bottom: 20px;
  }
}
</style>
</style>
</head>
<body>
<div class="text-center" style="background-color:#32127A">
<a style="padding-top:15px; padding-bottom:15px;" class="navbar-brand mr-auto" href="#"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
</div>
<br><br>

<div class=" container">
<table class="table table-hover">
  <thead>
    <tr>
      <th colspan="2" scope="col">Product</th>
      <th scope="col">Price</th>
      <th scope="col">Size</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
  
<%!
public String getDiscountedPrice(int op, int d){
	int dp = op - (op*d)/100;
	return dp+"";
}
%>
  <%
  Class.forName("com.mysql.jdbc.Driver");
  Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
  PreparedStatement statement = con.prepareStatement("select * from cart where userEmail=?");
  statement.setString(1, session.getAttribute("sessionEmail").toString());
  ResultSet rs = statement.executeQuery();
  int total = 0;
  %>
    <%
       	while(rs.next()){
       		%>
			<%
			PreparedStatement statement1 = con.prepareStatement("select * from products where productId=?");
			statement1.setString(1, rs.getString(2));
			ResultSet rs1 = statement1.executeQuery();
			rs1.next();
			total += Integer.parseInt(getDiscountedPrice(rs1.getInt(10),rs1.getInt(11)));
			%>
			<tr>
			<%String productImagePath = "images\\" + rs.getString(2) + "\\productImage.jpg?" + Math.random(); %>
			<td style="width:150px"><img class="card-img-top" height="120px" src="<%=productImagePath %>" alt="Card image cap"></td>
			<td style="vertical-align:middle"><%=rs1.getString(2) %></td>
			<td style="vertical-align:middle">$<%=getDiscountedPrice(rs1.getInt(10),rs1.getInt(11)) %></td>
			<td style="vertical-align:middle"><%=rs.getString(3) %></td>
			<td style="vertical-align:middle"><a href="DeleteFromCart?productId=<%=rs.getString(2) %>&calledBy=checkout.jsp" class="btn btn-sm btn-danger">Remove</a></td>
			</tr>										
       		<%
       	}
       	%>
  </tbody>
</table>
<br>
<p class="text-right">
<span style="font-size:22px;font-weight:bold;color:red">Total:</span>&nbsp&nbsp&nbsp<span style="font-size:28px; color:#32127A; font-weight:bold">$<%=total %>.00</span>
</p>
</div>
<br><br>

<div class="row">
  <div class="col-75">
    <div class="container">
      <form action="/action_page.php">
      
        <div class="row">
          <div class="col-50"><br>
            <h3>Billing Address</h3><br>
            <label for="fname"><i class="fa fa-user"></i> Full Name</label>
            <input required type="text" id="fname" name="firstname" placeholder="John M. Doe">
            <label for="email"><i class="fa fa-envelope"></i> Email</label>
            <input required type="text" id="email" name="email" placeholder="john@example.com">
            <label for="adr"><i class="fa fa-address-card-o"></i> Address</label>
            <input required type="text" id="adr" name="address" placeholder="542 W. 15th Street">
            <label for="city"><i class="fa fa-institution"></i> City</label>
            <input required type="text" id="city" name="city" placeholder="New York">

            <div class="row">
              <div class="col-50">
                <label for="state">State</label>
                <input required type="text" id="state" name="state" placeholder="NY">
              </div>
              <div class="col-50">
                <label for="zip">Zip</label>
                <input required type="text" id="zip" name="zip" placeholder="10001">
              </div>
            </div>
          </div>

          <div class="col-50"><br>
            <h3>Payment</h3><br>
            <label for="fname">Accepted Cards</label>
            <div class="icon-container">
              <i class="fa fa-cc-visa" style="color:navy;"></i>
              <i class="fa fa-cc-amex" style="color:blue;"></i>
              <i class="fa fa-cc-mastercard" style="color:red;"></i>
              <i class="fa fa-cc-discover" style="color:orange;"></i>
            </div>
            <label for="cname">Name on Card</label>
            <input required type="text" id="cname" name="cardname" placeholder="John More Doe">
            <label for="ccnum">Credit card number</label>
            <input required type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444">
            <label for="expmonth">Exp Month</label>
            <input required type="text" id="expmonth" name="expmonth" placeholder="September">
            <div class="row">
              <div class="col-50">
                <label for="expyear">Exp Year</label>
                <input required type="text" id="expyear" name="expyear" placeholder="2018">
              </div>
              <div class="col-50">
                <label for="cvv">CVV</label>
                <input required type="text" id="cvv" name="cvv" placeholder="352">
              </div>
            </div>
          </div>
          
        </div><br>
        <input style="width:100%; height:50px" class="btn btn-info" type="submit" value="Continue to checkout" class="btn">
      </form>
    </div>
  </div>
  
</div>
<br><br><br>
<br><br><br><br>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.slim.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</html>