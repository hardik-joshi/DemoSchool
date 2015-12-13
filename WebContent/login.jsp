<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<script src="js/jquery-2.1.4.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<!-- Bootstrap CSS and bootstrap datepicker CSS used for styling the demo pages-->
        
        <script>
        $(document).ready(function(){
        	
        	$("#changepass").hide();
        	
        	$("#Change").click(function(){
        		
        		$("#changepass").show();
        		$("#login").hide();
        	});
        	
        	$("#signin").click(function(){
        		
        		$("#changepass").toggle();
        		$("#login").toggle();
        	});
        	
        });
        
        
        </script>
	<style>
		
	
		
		
	body{
		
	margin: 5px;
   /*background: #3BCBC0 none repeat scroll 0% 0%; */
   background: #E2EEF4 none repeat scroll 0% 0%
		}
		
		
		#form
		{
			/*background-color: rgba(245, 245, 245, 0.7);*/
			/*border-radius:5px 5px 5px 5px;*/
			background-color:rgb(245,245,245);
			vertical-align: middle;
			box-shadow:0px 0px 25px 0px #000;
		}
	</style>
	
<title>Login</title>
</head>
<body>
	
	<center>
		<img alt="" src="design.jpg" style="width:150px;">
	</center>
	<div id="login">
		
		<div class="col-sm-4 col-sm-offset-4 horizontal-center " style="margin-top:1%;" id="form">	
		<center><h3>LOGIN</h3></center>
			<form action="LoginController?action=login" method="post">
					
					 
		
						<div class="form-group ">
						<label>Username :</label>
						<input type="text" class="form-control" placeholder="Username" name="username" value="admin"><br>
						<label>Password :</label>
						<input type="password" class="form-control" id="inputError2" placeholder="Password" value="admin" name="password" aria-describedby="inputError2Status">
						</div>
					
					<br>				
					<input type="submit" class="btn btn-primary btn-block"  value="Log In">
					<br>
					<a id="Change"><label style="float:right;cursor:pointer;">Forgot Password?</label></a>
					<!-- <a id="Change"><label style="float:left;cursor:pointer;">Change Password</label></a> -->
			</form>
			
		</div>
	
	
	</div>
	
	
	<div id="changepass">
	
	
	
	<div class="col-sm-4 col-sm-offset-4 horizontal-center " style="margin-top:1%;" id="form">	
		<center><h3>Forgot Password</h3></center>
		<form action="LoginController?action=forgotpassword" method="post">
					<br><br>
					<input type="text" class="form-control" placeholder="Username" name="username"><br>
		
					<input type="text" class="form-control" placeholder="Email" name="email"><br>
					
					<!-- 
					<input type="password" class="form-control" id="inputError2" placeholder="Old Password" name="oldpassword" aria-describedby="inputError2Status"><br>
					
				
						<input type="password" class="form-control" id="inputError2" placeholder="New Password" name="newpassword" aria-describedby="inputError2Status">
			
					 -->
					<br><br>		
							
					<input type="submit" class="btn btn-primary btn-block"  value="Change Password">
					<br>
					<a id="signin"><label style="float:left;cursor:pointer;">Sign In</label></a>
			</form>
			</div>
	</div>
</body>
</html>