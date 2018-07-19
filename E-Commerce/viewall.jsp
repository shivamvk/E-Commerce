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
<title>All products in "<%=request.getParameter("productCategory") %>"</title>
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
<script>
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
</script>

</head>
<body>
<!--Product Display Modal -->
<div class="modal fade" id="productdisplaymodal" tabindex="-1" role="dialog" aria-labelledby="productdisplaymodal" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div id="productmodalbody" class="modal-body"> 			
	      
      </div>
    </div>
  </div>
</div>
<div class="text-center" style="background-color:#32127A">
<a style="padding-top:15px; padding-bottom:15px;" class="navbar-brand mr-auto" href="#"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
</div>
<br><br>

<div class="container">
	<h2 style="font-family: 'Merriweather', serif;">All products in "<%=request.getParameter("productCategory") %>"</h2>
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
PreparedStatement statement = con.prepareStatement("select * from products where productCategory=?");
statement.setString(1, request.getParameter("productCategory"));
ResultSet rs = statement.executeQuery();
%>
<div class="container">
	<div class="row">
	<%
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
	%>
	</div>
</div>
<br>
<div class="container text-center">
	<p style="color:red; font-weignt:bold;font-size:20px">That's all we have ^_^.</p>
</div>
<br><br>
</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.slim.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</html>
