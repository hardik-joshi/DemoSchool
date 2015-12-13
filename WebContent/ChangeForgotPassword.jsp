<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% 
if(request.getAttribute("username")==null){
	
	response.sendRedirect("login.jsp");
}	
%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<title>Change Forgot Password</title>
	<script>
	function validatePassword(){
		
		var newPass = document.getElementById("newPass").value
		var cnfPass = document.getElementById("cnfPass").value

		if (newPass==cnfPass){
			return true;
		}else{
			alert("New Password and Confirm Password does not match!");
		}
		return false;
	}
	</script>

</head>
<body style="background-color:seagreen;">

	<form action=<%="LoginController?action=setforgotpassword&username=" + request.getAttribute("username")  %> method="post">
		<div class="container" style="margin-top:10%;background-color:white;width:40%;">
			<div class="col-sm-12" style="text-align:center;">
				<h2>Forgot Password</h2>
				<hr><br>
			</div>
			<div class="col-sm-12">
				<label>New Password</label>
				<br><br>
			</div>
			<div class="col-sm-12">
				<input type="password" class="form-control" placeholder="New Password" name="password" id="newPass"/>
				<br>
			</div>
			<div class="col-sm-12">
				<label>Retype New Password</label>
				<br><br>
			</div>
			<div class="col-sm-12">
				<input type="password" class="form-control" placeholder="Retype New Password" name="password" id="cnfPass"/>
				<br>
			</div>
			
			<div class="col-sm-12">
				<input type="submit" value="Submit" class="btn btn-primary" onclick="return validatePassword();"/>
				<br><br><br>
			</div>
		</div>
	</form>
</body>
</html>