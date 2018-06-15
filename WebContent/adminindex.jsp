<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html>
<%
if(session.getAttribute("sessionAdminEmail") == null){
	response.sendRedirect("adminLoginSignup.jsp");
	return;
}
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=session.getAttribute("sessionAdminName") %>'s Shop</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
    font-family: "Lato", sans-serif;
}

.productdisplayshadow
{
		-moz-box-shadow: 0 0 40px #ccc;
		-webkit-box-shadow: 0 0 40px #ccc;
		box-shadow: 0 0 40px #ccc;
	}

.sidenav {
    height: 100%;
    width: 0;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    background-color: #111;
    overflow-x: hidden;
    transition: 0.5s;
    padding-top: 60px;
}

.sidenav a {
    padding: 8px 8px 8px 32px;
    text-decoration: none;
    font-size: 25px;
    color: #818181;
    display: block;
    transition: 0.3s;
}

.sidenav a:hover {
    color: #f1f1f1;
}

.sidenav .closebtn {
    position: absolute;
    top: 0;
    right: 25px;
    font-size: 36px;
    margin-left: 50px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
}
function addaproductfunction(event){
	event.preventDefault();
	var gender = "";
	if(document.getElementById('productGenderMale').checked){
		gender = "Male";
	} else if(document.getElementById('productGenderFemale').checked){
		gender = "Female";
	} else {
		gender = "Both";
	}
	var params = {
			productName: document.getElementById('productName').value,
			productDescription: document.getElementById('productDescription').value,
			productGender: gender,
			productCategory: document.getElementById('productCategory').value,
			productQuantitySmall: document.getElementById('productQuantitySmall').value,
			productQuantityMedium: document.getElementById('productQuantityMedium').value,
			productQuantityLarge: document.getElementById('productQuantityLarge').value,
			productPrice: document.getElementById('productPrice').value,
			productDiscount: document.getElementById('productDiscount').value
	}
	
	$.get("AddAProduct", $.param(params), function(response) {
		if(response == 'ok'){
			alert("Product is now live!");
			window.location.reload();
		} else if(response == 'not'){
			alert("Some Error!");
		}
	});
}
function showeditproductmodal(productId){
	$('#editproductmodal').on('show.bs.modal', function() {
		var $modal = $(this);
		$.ajax({
            cache: false,
            type: 'get',
            async: true,
            url: 'EditProductModal?productId=' + productId,
            success: function(data) {
            	$modal.find('.editmodalbody').html(data);
            }
        });
    });
	$('#editproductmodal').modal('show');
}
</script>
</head>
<body style="background-color: #F1F3FA;">

<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="">Products</a>
  <a href="">Dashboard</a>
  <a href="">Clients</a>
  <a href="AdminLogout">Logout</a>
</div>
<div style="background-color:#32127A">
&nbsp&nbsp&nbsp
<span style="color:#ffffff;font-size:30px;cursor:pointer" onclick="openNav()">&#9776;</span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<a class="navbar-brand mr-auto" href="#"><img alt="Logo" src="images/amazonlogowhite.png" style="" height="40px" width="180px"></a>
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<span style="color: #ffffff"><span style="font-weight:bold;"><%=session.getAttribute("sessionAdminName")%>'s</span> shop</span>
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
<span style="color: #ffffff">Sellers' id:<span style="font-weight:bold"> <%=session.getAttribute("sessionAdminEmail") %></span></span>
</div>
<br>

<!--Add a product Modal -->
<div class="modal fade" id="addaproductmodal" tabindex="-1" role="dialog" aria-labelledby="addaproductmodal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addaproductmodal">Tell us about the product</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form onsubmit="addaproductfunction(event)" style="max-height:400px; overflow-y:scroll">
        	<input required type="text" class="form-control" placeholder="Product Name" id="productName"><br>
        	<input required class="form-control" placeholder="Product Description" id="productDescription"><br>
        	<div class="form-inline">
	        	<input required type="radio" name="gender" class="form-control" id="productGenderMale">
	        	<label for="productGenderMale">&nbsp&nbspMale</label>&nbsp&nbsp&nbsp&nbsp&nbsp
	        	<input type="radio" name="gender" class="form-control" id="productGenderFemale">
	        	<label for="productGenderFemale">&nbsp&nbspFemale</label>&nbsp&nbsp&nbsp&nbsp&nbsp
	        	<input type="radio" name="gender" class="form-control" id="productGenderBoth">
	        	<label for="productGenderBoth">&nbsp&nbspBoth</label>
        	</div><br>
        	<select required id="productCategory" class="form-control">
        		<option value="Topwear">Topwear</option>
        		<option value="Bottomwear">Bottomwear</option>
        		<option value="Footwear">Footwear</option>
        		<option value="Accessories">Accessories</option>
        	</select><br>
        	<input required type="number" class="form-control" id="productQuantitySmall" placeholder="Quantity you have for small size"><br>
        	<input required type="number" class="form-control" id="productQuantityMedium" placeholder="Quantity you have for medium size"><br>
        	<input required type="number" class="form-control" id="productQuantityLarge" placeholder="Quantity you have for large size"><br>
        	<input required type="number" class="form-control" id="productPrice" placeholder="Price of the product"><br>
        	<input required type="number" class="form-control" id="productDiscount" placeholder="Discount on product(%)">
      </div>
      <div class="modal-footer">
       		<input type="submit" class="btn btn-md btn-info" value="Add">
       	</form>
      </div>
    </div>
  </div>
</div>

<!--Edit Product Modal -->
<div class="modal fade" id="editproductmodal" tabindex="-1" role="dialog" aria-labelledby="editproductmodal" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content editmodalbody">
      <!-- data is loaded by the EditProductModal.java servlet -->
    </div>
  </div>
</div>

<%!
public String getDiscountedPrice(int op, int d){
	int dp = op - (op*d)/100;
	return dp+"";
}
%>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/amazon?user=root&password=test123");
PreparedStatement statement = con.prepareStatement("select * from products where productSoldBy=?");
statement.setString(1, session.getAttribute("sessionAdminEmail").toString());
ResultSet rs = statement.executeQuery();
%>
<div class="container" style="background-color: #ffffff">
	<br>
	<div class="row">
		<%
		while(rs.next()){
			%>
			<div class="col-xl-3">
				<div class="card productdisplayshadow" style="margin-bottom: 20px;height: 480px; width: 100%;">
				<%String productImagePath = "images\\" + rs.getString(1) + "\\productImage.jpg?" + Math.random(); %>
				  <img class="card-img-top" onclick="$('#changeproductfilebutton<%=rs.getString(1) %>').click()" width="150px" height="200px" src="<%=productImagePath %>" alt="Card image cap">
				  <form  ENCTYPE="multipart/form-data" ACTION="fileupload.jsp?productId=<%=rs.getString(1) %>" METHOD=POST>
					       <input id="changeproductfilebutton<%=rs.getString(1) %>" style="display:none;" type="file" name="f1" required>
					       <input style="width:100%" class="btn btn-info btn-sm" type="submit" value="Upload/Change Image">
					
					    </form>
				  <div class="card-body">
				    <h5 class="card-title"><%=rs.getString(2) %></h5>
				    <p class="card-text">"<%=rs.getString(3) %>"<br>
				    <del style="text-decoration: line-through"> $<%=rs.getString(10) %></del>
				    <span style="font-size:12px"><%=rs.getString(11) %>% off</span>&nbsp&nbsp
				    <span style="font-weight:bold; font-size:22px">$<%=getDiscountedPrice(rs.getInt(10),rs.getInt(11)) %></span><br>
				    Quantity Left: <span style="font-size:18px ;font-weight:bold;"><%=(rs.getInt(6) + rs.getInt(7) + rs.getInt(8)) %></span></p>
				  </div>
				  <div class="card-footer">
				  	<button onclick="showeditproductmodal(<%=rs.getString(1) %>)" class="btn btn-info btn-sm">Edit</button>
				  	<a href="AdminDeleteProduct?productId=<%=rs.getString(1) %>" class="btn btn-danger btn-sm"><span style="color:#ffffff">Delete</span></a>
				  </div>
				</div>
			</div>
			<%
		}
		%>
		<div class="col-xl-3 text-center">
			<div class="card productdisplayshadow" style="height:450px ;width: 100%;">
			  <img class="card-img-top" width="150px" height="100%" src="images/addaproduct.png" alt="Card image cap">
			  <div class="card-body">
			  	<button data-toggle="modal" data-target="#addaproductmodal" class="btn btn-info">Add a Product</button>
			  </div>
			 </div>
		</div>
	</div>
	<br>
</div>
<%con.close(); %>


<br><br>

</body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.slim.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</html>