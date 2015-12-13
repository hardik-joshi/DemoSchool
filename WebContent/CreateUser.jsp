<head>
	<title>Create User</title>
</head>
<jsp:include page="header.jsp"></jsp:include>

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

			
	<div class="row-fluid">
		<jsp:include page="sidebar.jsp"></jsp:include>

		<!--/span-->
		<div class="span9" id="content">
			<!-- <div class="row-fluid">
					<div class="alert alert-success">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<h4>Success</h4>
						The operation completed successfully
					</div>
				</div> -->
			<div class="row-fluid">
				<div class="navbar">
					<div class="navbar-inner">
						<ul class="breadcrumb">
							<i class="icon-chevron-left hide-sidebar"><a href='#'
								title="Hide Sidebar" rel='tooltip'>&nbsp;</a></i>
							<i class="icon-chevron-right show-sidebar" style="display: none;"><a
								href='#' title="Show Sidebar" rel='tooltip'>&nbsp;</a></i>
							<li class="active">Create User <span class="divider">/</span></li>
							
							<li><a href="ChangePassword.jsp">Change Password</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<!-- block -->
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">Create User</div>
					</div>

					<div class="block-content collapse in">
						<div>

							<form role="form" method="post" action="LoginController?action=register">
								
								<div class="span12">
									<div class="span6">
											<label for="textfield" class="form-control" style="margin-left: 25px;">
											Username:
												</label>
										</div>

										<div class="span6">
											<input  name="username" class='span6 m-wrap h30'  type="text" style="margin-left: 25px;">
										</div>
								</div>	
								
								
								<div class="span12">
									<div class="span6">
											<label for="textfield" class="form-control">
											Password:
												</label>
										</div>

										<div class="span6">
											<input  name="password" class='span6 m-wrap h30' id="newPass" type="password">
										</div>
								</div>	
								
								
								<div class="span12">
									<div class="span6">
											<label for="textfield" class="form-control">
											Confirm Password:
												</label>
										</div>

										<div class="span6">
											<input  name="" class='span6 m-wrap h30' id="cnfPass" type="password">
										</div>
								</div>	
								<div class="span12">
									<div class="span6">
								<input type="submit" value="Submit" class="btn btn-primary" onclick="return validatePassword();"/>
									</div>
								</div>
							</form>
							</div>

					</div>
				</div>
				<!-- /block -->

			</div>
		</div>
	</div>
	<hr>
	<footer>
		<p>&copy; National High School</p>
	</footer>
</div>
<!--/.fluid-container-->
<script src="vendors/jquery-1.9.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="vendors/easypiechart/jquery.easy-pie-chart.js"></script>
<script src="assets/scripts.js"></script>
<script>
	$(function() {
		// Easy pie charts
		$('.chart').easyPieChart({
			animate : 1000
		});
	});
</script>
</body>

</html>