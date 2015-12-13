<%
     if (null==session.getAttribute("username"))
     {
     
     response.sendRedirect("login.jsp");
     }
  %>
   <% 
     response.setHeader("Cache-Control","no-store"); 
     response.setHeader("Pragma","no-cache"); 
     response.setHeader ("Expires", "0"); //prevents caching at the proxy server	
   %>
<!DOCTYPE html>
<html class="no-js">
<!-- Bootstrap -->
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"
	media="screen">
<link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet"
	media="screen">
<link href="vendors/easypiechart/jquery.easy-pie-chart.css"
	rel="stylesheet" media="screen">
<link href="assets/styles.css" rel="stylesheet" media="screen">
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<script src="vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>

<!-- Hardik Code Start -->

<!-- Include one of jTable styles. -->

<!-- Include jTable script file. -->

<script src="js/angular.min.js" type="text/javascript"></script>
<script src="js/bootstrap-modal.js" type="text/javascript"></script>

<script src="js/bootstrap.min.js"></script>
<style>
.h30{
		height: 30px !important;
	}
</style>

<body>
	<div class="navbar navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse"> <span class="icon-bar"></span> <span
					class="icon-bar"></span> <span class="icon-bar"></span>
				</a> <a class="brand" href="#"><img src="design.jpg" height="30px" width="30px">&nbsp;National High School</a>
				<div class="nav-collapse collapse">
					<ul class="nav pull-right">
						<li class="dropdown"><a href="#" role="button"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="icon-user"></i> <%=session.getAttribute("username") %> <i class="caret"></i>

						</a>
							<ul class="dropdown-menu">
								<!-- <li><a tabindex="-1" href="#">Profile</a></li>
								<li class="divider"></li> -->
								<li><a tabindex="-1" href="logout.jsp">Logout</a></li>
							</ul></li>
					</ul>
					<ul class="nav ">
						<li class=""><a href="index.jsp">Dashboard</a></li>
						<li class="dropdown"><a href="#" role="button"
							class="dropdown-toggle" data-toggle="dropdown">Students <i
								class="caret"></i>

						</a>
							<ul class="dropdown-menu">
								<li><a tabindex="-1" href="Admission.jsp">Admission</a></li>
								<li><a tabindex="-1" href="studentlist.jsp">Student Details</a></li>
							</ul></li>
						<li class="dropdown"><a href="#" role="button"
							class="dropdown-toggle" data-toggle="dropdown">Books <i
								class="caret"></i>

						</a>
							<ul class="dropdown-menu">
								<li><a tabindex="-1" href="book.jsp">Book</a></li>
								<li><a tabindex="-1" href="bookset.jsp">Book Set</a></li>
								<li><a tabindex="-1" href="purchasebook.jsp">Purchase Book</a></li>
							</ul></li>
						<li class="dropdown"><a href="#" role="button"
							class="dropdown-toggle" data-toggle="dropdown">Fees <i
								class="caret"></i>

						</a>
							<ul class="dropdown-menu">
								<li><a tabindex="-1" href="feestype.jsp">Standard Charges</a></li>
								<li><a tabindex="-1" href="fees.jsp">Student Billing</a></li>															
							</ul></li>
						<li class="dropdown"><a href="#" role="button"
							class="dropdown-toggle" data-toggle="dropdown">Contacts <i
								class="caret"></i>

						</a>
							<ul class="dropdown-menu">
								<li><a tabindex="-1" href="OrganizationPerson.jsp">Add</a></li>
								<li><a tabindex="-1" href="ContactManagement.jsp">Manage</a></li>
								<li><a tabindex="-1" href="ContactListByType.jsp">All Contacts</a></li>															
							</ul></li>
						<li class="dropdown"><a href="#" role="button"
							class="dropdown-toggle" data-toggle="dropdown">Users <i
								class="caret"></i>

						</a>
							<ul class="dropdown-menu">
								<li><a tabindex="-1" href="CreateUser.jsp">Add User</a></li>
								<li><a tabindex="-1" href="ChangePassword.jsp">Change Password</a></li>															
							</ul></li>

							<% /* 
							int id = (int) session.getAttribute("userId");
							
							if(id == 1){  */%>
									<!-- <li class="dropdown"><a href="#" role="button"> Task </a>
							</li> -->
							<%/* } */ %>
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>
