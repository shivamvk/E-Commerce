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
<title>E-Commerce</title>
<style>
.productbox
	{
		-moz-box-shadow: 0 0 40px #ccc;
		-webkit-box-shadow: 0 0 40px #ccc;
		box-shadow: 0 0 40px #ccc;
	}
.productbox:hover
	{
	opacity:0.7;
		-moz-box-shadow: 0 0 40px #ccc;
		-webkit-box-shadow: 0 0 40px #ccc;
		box-shadow: 0 0 40px #ccc;
	}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('.navbarlinks').css("color","grey");
		$('.navbarlinks').css("font-weight","bold");
        $('.navbarlinks').hover(
          function(){
            $(this).css("color","blue");
          },
          function(){
            $(this).css("color","grey");
          }
        );
	});
	function signupfunction(event){
		event.preventDefault();
		var name = document.getElementById('signupname').value;
		var email = document.getElementById('signupemail').value;
		var password = document.getElementById('signuppassword').value;
		$.ajax({
		    url : "actionSignup.jsp?name=" + name + "&email=" + email + "&password=" + password + "",
		    type : "GET",
		    async : true,
		    success : function(data) {
		    	data = data.trim();
				if(data == "not"){
					alert("Email already exists!");
				} else if(data == "ok"){
					window.location.reload();
				} else{
					alert("Hello");
				}
		    }
		});
	}
	function loginfunction(event){
		event.preventDefault();
		var email = document.getElementById('loginemail').value;
		var password = document.getElementById('loginpassword').value;
		$.ajax({
		    url : "actionLogin.jsp?email=" + email + "&password=" + password + "",
		    type : "GET",
		    async : true,
		    success : function(data) {
		    	data = data.trim();
		    	if(data == "not"){
					alert("Invalid email or password!");
				} else if(data == "ok"){
					window.location.reload();
				}
		    }
		});
	}
	function addtocart(id){
		<%
		if(session.getAttribute("sessionEmail") == null){
			%>
			document.getElementById("addtocarterror").innerHTML = "You need to login before adding items to your cart!";
			return;
			<%
		} else {
			%>
			document.getElementById("addtocarterror").innerHTML = "";
			<%
		}
		%>
		var size = document.getElementById("productdisplaysize").value;
		if(size == "Select your size"){
			document.getElementById("addtocarterror").innerHTML = "Please select a size!";
			return;
		} else{
			document.getElementById("addtocarterror").innerHTML = "";
		}
		$.ajax({
            type: 'get',
            async: true,
            url: 'actionAddToCart.jsp?productId=' + id + '&size=' + size,
            success: function(data) {
		data = data.trim();
            	if(data == 'ok'){
            		alert("Item added to cart!");
                	window.location.reload();
            	} else if (data == 'not'){
            		document.getElementById("addtocarterror").innerHTML = "Item already in your cart!";
            	}
            }
        });
	}
	function productDisplayFunction(productId){
		$('#productdisplaymodal').on('show.bs.modal', function() {
			var $modal = $(this);
			$.ajax({
	            cache: false,
	            type: 'get',
	            async: true,
	            url: 'actionGetProductInfo.jsp?productId=' + productId,
	            success: function(data) {
	            	$modal.find('#productmodalbody').html(data);
	            }
	        });
	    });
		$('#productdisplaymodal').modal('show');
	}
	function showProductHints(productName){
		if(productName!=""){
    		$.ajax({
    		    url : "actionShowSuggestions.jsp?term=" + productName,
    		    type : "GET",
    		    async : true,
    		    success : function(data) {
			data = data.trim();
    		    	if(data != ""){
    		    		var array = data.split(",");
    		    		var selectList = document.getElementById("datalist");
    		    		while (selectList.hasChildNodes()) {
    		    			selectList.removeChild(selectList.lastChild);
    		    		}
    		    		for (var i = 0; i < array.length; i++) {
    		    		    var option = document.createElement("option");
    		    		    option.value = array[i];
    		    		    option.text = array[i];
    		    		    selectList.appendChild(option);
    		    		}
    				}
    		    }
    		});
    	}
	}
	function seacrhbuttonclicked(event){
		event.preventDefault();
		var searchterm = document.getElementById('searchTerm').value;
		if(searchterm != " "){
			window.location.assign("searchresults.jsp?query=" + searchterm);	
		}
	}
	function logoutbutton(){
		$.ajax({
            type: 'get',
            async: true,
            url: 'actionLogout.jsp',
            success: function(data) {
		data = data.trim();
            	if(data == 'ok'){
            		alert("You've been logged out!");
                	window.location.reload();
            	} else if (data == 'not'){
            		alert("Some error!");
            	}
            }
        });
	}
	function checkoutclicked(){
		window.location.assign("checkout.jsp");
	}
	function viewallclicked(type){
		window.location.assign("viewall.jsp?productCategory=" + type);
	}
</script>
</head>
<body style="background-color: #ffffff;">
<!--Product Display Modal -->
<div class="modal fade" id="productdisplaymodal" tabindex="-1" role="dialog" aria-labelledby="productdisplaymodal" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div id="productmodalbody" class="modal-body"> 			
	      
      </div>
    </div>
  </div>
</div>
<!--Login Modal -->
<div class="modal fade" id="loginmodal" tabindex="-1" role="dialog" aria-labelledby="loginmodal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="loginmodal">Login</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form onsubmit="loginfunction(event)">
        	<div class="form-group">
        		<label for="loginemail">Email:</label>
        		<input required="" type="email" class="form-control" placeholder="Email" id="loginemail">
        	</div>
        	<div class="form-group">
        		<label for="loginpassword">Password:</label>
        		<input required="" type="password" placeholder="Password" id="loginpassword" class="form-control">
        	</div>
      </div>
      <div class="modal-footer">
        <input type="submit" class="btn btn-info" value="Login">
        <button data-toggle="modal" data-target="#signupmodal" class="btn btn-info">New to Amazon? Sign up</button>
        </form>
      </div>
    </div>
  </div>
</div>
<!--Sign up Modal -->
<div class="modal fade" id="signupmodal" tabindex="-1" role="dialog" aria-labelledby="signupmodal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="signupmodal">Sign up</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form onsubmit="signupfunction(event)">
        	<div class="form-group">
        		<label for="signupname">Name:</label>
        		<input required="" type="text" class="form-control" placeholder="Name" id="signupname">
        	</div>
        	<div class="form-group">
        		<label for="signupemail">Email:</label>
        		<input required="" type="email" class="form-control" placeholder="Email" id="signupemail">
        	</div>
        	<div class="form-group">
        		<label for="signuppassword">Password:</label>
        		<input required="" type="password" placeholder="Password" id="signuppassword" class="form-control">
        	</div>
      </div>
      <div class="modal-footer">
        <input type="submit" class="btn btn-info" value="Sign up">
        </form>
      </div>
    </div>
  </div>
</div>
<%int countInCart = 0; %>
<!--Cart Modal -->
<div class="modal fade" id="cartmodal" tabindex="-1" role="dialog" aria-labelledby="cartmodal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
	      <%
	      if(session.getAttribute("sessionEmail") == null){
	    	  %>
	    	  	<div class="modal-header">
			   	<h5 class="modal-title" id="cartmodal">You need to login first!</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		        </div>	 	  
	    	  <%
	      } else {
	    	  %>
	    	  <%
	    	  Class.forName("com.mysql.jdbc.Driver");
			  Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
			  PreparedStatement statement = con.prepareStatement("select * from cart where userEmail=?");
			  statement.setString(1, session.getAttribute("sessionEmail").toString());
			  ResultSet rs = statement.executeQuery();
			  int total = 0;
	    	  %>
	    	    <div class="modal-header">
				    <h5 class="modal-title" id="cartmodal">Your cart</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
		        </div>
		        <div class="modal-body">
		        	<table class="table table-hover">
					    <thead>
					      <tr>
					        <th>Product</th>
					        <th>Price</th>
					        <th>Size</th>
					        <th></th>
					      </tr>
					    </thead>
					    <tbody>
		        	<%
		        	while(rs.next()){
		        		%>
						<%
						countInCart += 1;
						PreparedStatement statement1 = con.prepareStatement("select * from products where productId=?");
						statement1.setString(1, rs.getString(2));
						ResultSet rs1 = statement1.executeQuery();
						rs1.next();
						total += Integer.parseInt(getDiscountedPrice(rs1.getInt(10),rs1.getInt(11)));
						%>
						<tr>
						<td><%=rs1.getString(2) %></td>
						<td>$<%=getDiscountedPrice(rs1.getInt(10),rs1.getInt(11)) %></td>
						<td><%=rs.getString(3) %></td>
						<td><a href="actionDeleteFromCart.jsp?productId=<%=rs.getString(2) %>&calledBy=index.jsp" class="btn btn-sm btn-danger">Remove</a></td>
						</tr>										
		        		<%
		        	}
		        	%>
		        	</tbody>
		        	</table>
		        </div>
		        <div class="modal-footer">
		        <span style="font-weight:bold;color:red">Total:</span>&nbsp&nbsp&nbsp<span style="font-size:22px; color:#32127A; font-weight:bold">$<%=total %></span>
		        <%
		        if(total != 0){
		        	%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		        		<button onclick="checkoutclicked()" class="btn btn-info btn-sm">Checkout</button>
		        	<%
		        }
		        %>
		        </div>	  
	    	  <%
	    	  con.close();
	      }
	      %>
    </div>
  </div>
</div>
<nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background-color:#32127A;">
  <a class="navbar-brand" href="#"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <datalist id="datalist">
  </datalist>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  	<form onsubmit="seacrhbuttonclicked(event)" class="form-inline mr-auto">
  		<input required autocomplete="off" id="searchTerm" list="datalist" type="text" class="form-control mr-sm-2" onkeyup="showProductHints(this.value);" style="width:500px" placeholder="Type a product name">
  		<input type="submit" class="btn" value="Search">
  	</form>
    <ul class="navbar-nav">
      <li class="nav-item active">
      	<%
      	if(session.getAttribute("sessionEmail") == null){
      		%>
      		<button id="navbarloginsignup" class="btn btn-md" data-toggle="modal" data-target="#loginmodal">Login/Sign up</button>
      		<%
      	} else{
      		%>
      		<li class="nav-item dropdown">
        <button class="btn btn-md  dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fa fa-user-circle"></i>
        </button>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item">Profile</a>
          <a class="dropdown-item" href="myorders.jsp">Orders</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" onclick="logoutbutton()">Logout</a>
        </div>
      </li>
      		<%
      	}
      	%>
        
      </li>
      &nbsp&nbsp&nbsp&nbsp
      <li class="nav-item active">
        <button class="btn btn-md" data-toggle="modal" data-target="#cartmodal"><i class="fa fa-shopping-cart"></i>
        &nbspCart (<%=countInCart %>)</button>
      </li>
      &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
    </ul>
  </div>
</nav>
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img class="d-block w-100" src="images/caraousel2.jpg" alt="First slide">
    </div>
    <div class="carousel-item">
      <img class="d-block w-100" src="images/caraousel3.jpg" alt="Second slide">
    </div>
    <div class="carousel-item">
      <img class="d-block w-100" src="images/caraousel1.jpg" alt="Third slide">
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

<%!
public String getDiscountedPrice(int op, int d){
	int dp = op - (op*d)/100;
	return dp+"";
}
%>

<div class="container" style="background-color:#ffffff">
<br>
	<p style="font-size:26px; color:#2f4f4f;font-family: 'Alegreya', serif;">Premium collection in Footwear</p>
	<p onclick="viewallclicked('Footwear')" style="text-align:right;">View all</p>
	<div class="row">
	<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
	PreparedStatement statement = con.prepareStatement("select * from products where productCategory='Footwear' order by productId desc limit 4");
	ResultSet rs = statement.executeQuery();
	while(rs.next()){
		%>
		<div class="col-xl-3">
<%String productImagePath = rs.getString(12);
				if(productImagePath == null)
					productImagePath = "images/" + "prdouctplaceholder.jpg";
				else
					productImagePath = productImagePath.replace("productImages/","productImages%2F");
				
				%>		
<div onclick="productDisplayFunction(<%=rs.getString(1) %>)" class="card productbox" onmouseover="this.opacity=0.5" style="margin-bottom: 20px; width: 250px;">
			  <img class="card-img-top" width="150px" height="200px" src="<%=productImagePath %>" alt="Card image cap">
			  <div class="card-body" style="height:90px">
			    <p style="font-style:italic;" class="card-text"><span style="font-weight:bold;color:red">"</span><%=rs.getString(3) %><span style="font-weight:bold;color:red">"</span><br></p>
			  </div>
			  <div class="card-footer">
			  <del style="text-decoration: line-through"> $<%=rs.getString(10) %></del>
			    <span style="font-size:12px"><%=rs.getString(11)%>% off</span>&nbsp&nbsp
			    <span style="color:#32127A;font-weight:bold; font-size:22px">$<%=getDiscountedPrice(rs.getInt(10),rs.getInt(11)) %></span><br>
			  </div>
			</div>
		</div>
		<%
	}
	con.close();
	%>		
	</div>
<br>
</div>
<div class="container" style="background-color:#ffffff">
<br>
	<p style="font-size:26px; color:#2f4f4f;font-family: 'Alegreya', serif;">Premium collection in Topwear</p>
	<p onclick="viewallclicked('Topwear')" style="text-align:right;">View all</p>
	<div class="row">
	<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
	PreparedStatement statement1 = con1.prepareStatement("select * from products where productCategory='Topwear' order by productId desc limit 4");
	ResultSet rs1 = statement1.executeQuery();
	while(rs1.next()){
		%>
		<div class="col-xl-3">
		<%String productImagePath = rs1.getString(12);
				if(productImagePath == null)
					productImagePath = "images/" + "prdouctplaceholder.jpg";
				else
					productImagePath = productImagePath.replace("productImages/","productImages%2F");
				
				%>
			<div onclick="productDisplayFunction(<%=rs1.getString(1) %>)" class="card productbox" onmouseover="this.opacity=0.5" style="margin-bottom: 20px; width: 250px;">
			  <img class="card-img-top" width="150px" height="200px" src="<%=productImagePath %>" alt="Card image cap">
			  <div class="card-body" style="height:90px">
			    <p style="font-style:italic;" class="card-text"><span style="font-weight:bold;color:red">"</span><%=rs1.getString(3) %><span style="font-weight:bold;color:red">"</span><br></p>
			  </div>
			  <div class="card-footer">
			  <del style="text-decoration: line-through"> $<%=rs1.getString(10) %></del>
			    <span style="font-size:12px"><%=rs1.getString(11)%>% off</span>&nbsp&nbsp
			    <span style="color:#32127A;font-weight:bold; font-size:22px">$<%=getDiscountedPrice(rs1.getInt(10),rs1.getInt(11)) %></span><br>
			  </div>
			</div>
		</div>
		<%
	}
	con1.close();
	%>		
	</div>
<br>
</div>
<div class="container" style="background-color:#ffffff">
<br>
	<p style="font-size:26px; color:#2f4f4f;font-family: 'Alegreya', serif;">Premium collection in Bottomwear</p>
	<p onclick="viewallclicked('Bottomwear')" style="text-align:right;">View all</p>
	<div class="row">
	<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
	PreparedStatement statement2 = con2.prepareStatement("select * from products where productCategory='Bottomwear' order by productId desc limit 4");
	ResultSet rs2 = statement2.executeQuery();
	while(rs2.next()){
		%>
		<div class="col-xl-3">
		<%String productImagePath = rs2.getString(12);
				if(productImagePath == null)
					productImagePath = "images/" + "prdouctplaceholder.jpg";
				else
					productImagePath = productImagePath.replace("productImages/","productImages%2F");
				
				%>
			<div onclick="productDisplayFunction(<%=rs2.getString(1) %>)" class="card productbox" onmouseover="this.opacity=0.5" style="margin-bottom: 20px; width: 250px;">
			  <img class="card-img-top" width="150px" height="200px" src="<%=productImagePath %>" alt="Card image cap">
			  <div class="card-body" style="height:90px">
			    <p style="font-style:italic;" class="card-text"><span style="font-weight:bold;color:red">"</span><%=rs2.getString(3) %><span style="font-weight:bold;color:red">"</span><br></p>
			  </div>
			  <div class="card-footer">
			  <del style="text-decoration: line-through"> $<%=rs2.getString(10) %></del>
			    <span style="font-size:12px"><%=rs2.getString(11)%>% off</span>&nbsp&nbsp
			    <span style="color:#32127A;font-weight:bold; font-size:22px">$<%=getDiscountedPrice(rs2.getInt(10),rs2.getInt(11)) %></span><br>
			  </div>
			</div>
		</div>
		<%
	}
	con2.close();
	%>		
	</div>
<br>
</div>
 <br><br><br>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.slim.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</html>
