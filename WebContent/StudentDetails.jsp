<head>
<title>Students</title>
</head>
<jsp:include page="header.jsp"></jsp:include>
<link href= "font-awesome.min.css" rel="stylesheet"></link>
<script type="text/javascript" src="jquery-ui.js"></script>
<style>
td{
	padding:5px;
}
</style>
<script type="text/javascript">
	function navigate() {

		window.location = "studentlist.jsp";
	}

	var app = angular.module('myApp', []);
	app
			.controller(
					'studentdetails',
					function($scope, $http,$filter) {
						$scope.currentDate = $filter('date')(new Date(), "yyyy-MM-dd");
						$scope.student = {};
						$scope.mother = {};
						$scope.father = {};
						
						
						$scope.leaveschool = function(id){
							 url = "AdmissionController?action=leave&studentId="+<%=request.getParameter("studentId")%>+ " ";
							var req = $http({
								headers : {
									"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
								},
								datatype : 'text',
								method : 'post',
								url : url
							});
							req.success(function(response){
								var html="<html>";
								   html+= document.getElementById(id).innerHTML;
								   html+="</html>";

								   var printWin = window.open('','','left=0,top=0,width=1,height=1,toolbar=0,scrollbars=0,status  =0');
								   printWin.document.write(html);
								   printWin.document.close();
								   printWin.focus();
								   printWin.print();
								   printWin.close();
								alert("Succesfully Generated Leaving Certificate");
							 }); 
						};
						
						$scope.init = function() {

							//url = "AdmissionController?action=display&studentId=1";

							var url = "AdmissionController?action=display&studentId=" + <%=request.getParameter("studentId")%> + " ";

							$http(
									{
										method : 'POST',
										url : url,
										datatype : 'text',
										headers : {
											"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
										}
									})
									.success(
											function(response) {

												console.log(response);
												$scope.response = JSON
														.parse(response);

												$scope.student = $scope.response[0];
												$scope.person = $scope.response[1];
												$scope.mother = $scope.response[2];
												$scope.father = $scope.response[3];

												$scope.person.name = $scope.person.firstName
														+ " "
														+ $scope.person.lastName;

												$("#photoDisplay").attr("src",
														$scope.person.photo);
												$("#photoDisplay").css(
														"height", "200px");
												$("#photoDisplay").css("width",
														"150px");

												console
														.log($scope.student.standardId);

												url = "StandardController?action=standardId&standardId="
														+ $scope.student.standardId

												console.log(url);

												$http(
														{
															method : 'POST',
															url : url,
															datatype : 'text',
															headers : {
																"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
															}
														})
														.success(
																function(
																		response) {

																	$scope.response = response
																	$scope.student.standardId = $scope.response.standardId
																	$scope.student.standardName = $scope.response.standardName
																});

											});

						};

					});
</script>

<!-- Hardik Code End -->

<div ng-app="myApp" class="container-fluid"
	ng-controller="studentdetails" ng-init="init()">

	<!--Alert Box Modal -->
	<div class="modal fade" id="AlertMessage" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">{{alertTitle}}</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="isbnno">{{alertMessage}}</label>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						ng-click="resetPurchaseBook()">OK</button>
					<button type="button" class="btn btn-default" data-dismiss="modal"
						aria-label="Close">Cancel</button>
				</div>
			</div>
		</div>
	</div>

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
							<li><a href="Admission.jsp">Admission</a> <span
								class="divider">/</span></li>
							<li><a href="studentlist.jsp"> Student Details </a></li>

						</ul>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<!-- block -->
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">Student Profile</div>
					</div>

					<div class="block-content collapse in">
						<div class="span12">
							<div class="pull-left">
								<div class="form-group">
									<button class="btn btn-warning" onclick="navigate()">Back</button>
									
								</div>
							</div>
							<div class="pull-right">
								<div class="form-group">
									
									<button class="btn btn-danger" ng-click="leaveschool('printleavingcerti')">Leave School</button>
								</div>
							</div>

							<div class="clearfix"></div>
						</div>
						<div>
									
									
									
									
						<!-- Nav tabs -->
					    <ul class="nav nav-tabs" role="tablist">
					      <li class="active">
					          <a href="#home" role="tab" data-toggle="tab">
					              <icon class="fa fa-home"></icon> Personal Details
					          </a>
					      </li>
					      <li><a href="#profile" role="tab" data-toggle="tab">
					          <i class="fa fa-user"></i> School Details
					          </a>
					      </li>
					      <li>
					          <a href="#messages" role="tab" data-toggle="tab">
					              <i class="fa fa-envelope"></i>Family Details
					          </a>
					      </li>
					      <li>
					          <a href="#settings" role="tab" data-toggle="tab">
					              <i class="fa fa-cog"></i> Contact Details
					          </a>
					      </li>
					    </ul>			
									
									
									
									
									
									
									
							<!-- Tab panes -->
							<div class="tab-content">
      <div class="tab-pane fade active in" id="home">
          <div class="col-sm-12" style="width:100%;">
          	<div class="col-sm-3" style="float:left;">
          		<img id="photoDisplay"/>
          	</div>
          	<div class="col-sm-9" style="float:left;">
          		<table border="0" width="400px">
          			<tbody>
          				<tr>
          					<td>Standard:</td>
          					<td><span ng-bind="student.standardId"></span></td>
          				</tr>
          				<tr>
          					<td>Name:</td>
          					<td><span ng-bind="person.name"></span></td>
          				</tr>
          				<tr>
          					<td>Date of Birth:</td>
          					<td><span ng-bind="person.dob"></span></td>
          				</tr>
          				<tr>
          					<td>Gender:</td>
          					<td><span ng-bind="person.gender"></span></td>
          				</tr>
          				<tr>
          					<td>Religion:</td>
          					<td><span ng-bind="student.religion"></span></td>
          				</tr>
          				<tr>
          					<td>Category:</td>
          					<td><span ng-bind="student.category"></span></td>
          				</tr>
          				<tr>
          					<td>Blood Group:</td>
          					<td><span ng-bind="student.bloodGroup"></span></td>
          				</tr>
          			</tbody>
          		</table>
          		
          	</div>
          </div>
      </div>
      <div class="tab-pane fade" id="profile">
          <div class="col-sm-12" style="width:100%;">
          		<table border="0" width="50%">
          			<tbody>
          				<tr>
          					<td>Gr No.:</td>
          					<td><span ng-bind="student.grNo"></span></td>
          				</tr>
          				<tr>
          					<td>Roll No.:</td>
          					<td><span ng-bind="student.rollNo"></span></td>
          				</tr>
          				<tr>
          					<td>Dise No.:</td>
          					<td><span ng-bind="student.diseNo"></span></td>
          				</tr>
          				<tr>
          					<td>Enrollment Date:</td>
          					<td><span ng-bind="student.enrollmentDate"></span></td>
          				</tr>
          				<tr>
          					<td>Batch:</td>
          					<td><span ng-bind="student.batch"></span></td>
          				</tr>
          			</tbody>
          		</table>
          		
          </div>
      </div>
      <div class="tab-pane fade" id="messages">
          <div class="col-sm-12" style="width:50%;" align="center">
          		<table border="0" width="100%">
          			<tbody>
          				<tr>
          					<td>Father Name:</td>
          					<td><span ng-bind="father.firstName"></span></td>
          				</tr>
          				<tr>
          					<td>Mother Name:</td>
          					<td><span ng-bind="mother.firstName"></span></td>
          				</tr>
          				<tr>
          					<td>Father Occupation:</td>
          					<td><span ng-bind="father.occupation"></span></td>
          				</tr>
          				<tr>
          					<td>Mother Occupation:</td>
          					<td><span ng-bind="mother.occupation"></span></td>
          				</tr>
          				<tr>
          					<td>Family Income:</td>
          					<td><span ng-bind="student.familyIncome"></span></td>
          				</tr>
          			</tbody>
          		</table>
          		
          </div>
      </div>
      <div class="tab-pane fade" id="settings">
          <div class="col-sm-12" style="width:100%;">
          		<table border="0" width="50%">
          			<tbody>
          				<tr>
          					<td>Address1:</td>
          					<td><span ng-bind="person.address1"></span></td>
          				</tr>
          				<tr>
          					<td>&nbsp;</td>
          					<td><span ng-bind="person.address2"></span></td>
          				</tr>
          				<tr>
          					<td>Mobile No.:</td>
          					<td><span ng-bind="father.occupation"></span></td>
          				</tr>
          				<tr>
          					<td>Alternate No.:</td>
          					<td><span ng-bind="mother.occupation"></span></td>
          				</tr>
          				<tr>
          					<td>Home No.:</td>
          					<td><span ng-bind="person.homeNo""></span></td>
          				</tr>
          				<tr>
          					<td>Father Mobile No.:</td>
          					<td><span ng-bind="father.mobileNo"></span></td>
          				</tr>
          				<tr>
          					<td>Mother Mobile No.:</td>
          					<td><span ng-bind="mother.mobileNo"></span></td>
          				</tr>
          				<tr>
          					<td>Email:</td>
          					<td><span ng-bind="person.email"></span></td>
          				</tr>
          				<tr>
          					<td>Father Email:</td>
          					<td><span ng-bind="father.email"></span></td>
          				</tr>
          				<tr>
          					<td>Mother Email:</td>
          					<td><span ng-bind="mother.email"></span></td>
          				</tr>
          			</tbody>
          		</table>
          		<!-- <div class='col-md-3'>
					<label for="textfield" class="control-label">Address1:  <span ng-bind="person.address1"></span></label>
				</div>
				<div class='col-md-3'>
					<label for="textfield" class="control-label">Address2:  <span ng-bind="person.address2"></span></label>
				</div>
	          	<div class='col-md-3'>
					<label for="textfield" class="control-label">Mobile No.: <span ng-bind="person.mobileNo"></span></label>
				</div>
				<div class='col-md-3'>
					<label for="textfield" class="control-label">Alternate No.: <span ng-bind="person.alternateNo"></span></label>
				</div>
          		<div class='col-md-3'>
					<label for="textfield" class="control-label">Home No.: <span ng-bind="person.homeNo"></span></label>
				</div>
				<div class='col-md-3'>
					<label for="textfield" class="control-label">Father Mobile No.: <span ng-bind="father.mobileNo"></span></label>
				</div>
				<div class='col-md-3'>
					<label for="textfield" class="control-label">Mother Mobile No.: <span ng-bind="mother.mobileNo"></span></label>
				</div>
				<div class='col-md-3'>
					<label for="textfield" class="control-label">Email: <span ng-bind="person.email"></span></label>
				</div>
				<div class='col-md-3'>
					<label for="textfield" class="control-label">Father Email: <span ng-bind="father.email"></span></label>
				</div>
				<div class='col-md-3'>
					<label for="textfield" class="control-label">Mother Email: <span ng-bind="mother.email"></span></label>
				</div> -->
          </div>
      </div>
    </div><!-- 
							<div class="">
								<div class="tab-pane fade active in" id="home">
									


									<div class="">
										<div class='col-md-3' align='center'>
											<img id="photoDisplay"/>
										</div>

										<div class='col-md-5' align='right'>

											<div class="row">
												<div class='col-md-3' align='right'>
													<label for="textfield" class="control-label">GR No.
														: </label>


												</div>

												<div class='col-md-3' align='right'>
													<label for="textfield" class="control-label"> <span
														ng-bind="student.grNo"></span>
													</label>
												</div>

											</div>



											<div class="">
												<div class='col-md-3' align='right'>
													<label for="textfield" class="control-label">Roll
														No. : </label>

												</div>

												<div class='col-md-3' align='right'>
													<label for="textfield" class="control-label"> <span
														ng-bind="student.rollNo"></span>
													</label>
												</div>

											</div>





											<div class="">
												<div class='col-md-3' align='right'>
													<label for="textfield" class="control-label"> Name
														: </label>

												</div>

												<div class='col-md-4' align='right'>
													<label for="textfield" class="control-label"> <span
														ng-bind="person.name"></span>
													</label>
												</div>

											</div>





											<div class="">
												<div class='col-md-3' align='right'>
													<label for="textfield" class="control-label">Standard:
													</label>
												</div>

												<div class='col-md-3' align='right'>
													<label for="textfield" class="control-label"> <span
															ng-bind="student.standardName"></span>
													</label>
												</div>

											</div>


										</div>
									</div>


								</div>
								<div class="tab-pane fade" id="profile">
									<h2>School Details</h2>


								</div>
								<div class="tab-pane fade" id="messages">
									<h2>Parents Details</h2>

									<div class="row">
										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label">Father
												Name : </label>

										</div>

										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label"> <span
												ng-bind="father.firstName"></span>
											</label>
										</div>
									</div>


									<div class="row">
										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label">Mother
												Name : </label>

										</div>

										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label"> <span
												ng-bind="mother.firstName"></span>
											</label>
										</div>

									</div>


									<div class="row">
										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label">Father
												Occupation : </label>

										</div>

										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label"> <span
												ng-bind="father.occupation"></span>
											</label>
										</div>

									</div>

									<div class="row">
										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label">Mother
												Occupation : </label>

										</div>

										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label"> <span
												ng-bind="mother.occupation"></span>
											</label>
										</div>

									</div>




									<div class="row">
										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label">Father
												Mobile Number : </label>

										</div>

										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label"> <span
												ng-bind="father.mobileNo"></span>
											</label>
										</div>

									</div>



									<div class="row">
										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label">Mother
												Mobile Number : </label>

										</div>

										<div class='col-md-3' align='right'>
											<label for="textfield" class="control-label"> <span
												ng-bind="mother.mobileNo"></span>
											</label>
										</div>

									</div>





								</div>
								<div class="tab-pane fade" id="settings">
									<h2>Settings Content Goes Here</h2>

								</div>
							</div> -->
						</div>

					</div>
				</div>
				<!-- /block -->
				<!-- Start Leaving Certificate -->
				<div ng-show="false" id="printleavingcerti">
					<table width="604" height="460" border="1">
					  <tr>
					    <td width="50"><img src="design.jpg" width="50" height="25" /></td>
					    <td colspan="2"><h1><strong>National Engish School</strong></h1></td>
					  </tr>
					  <tr>
					    <td colspan="3"><center>Pushpam Building, Kharawala Compound, Isanpur-Vatva Road, Isanpur, Ahmedabad - 382 443.</center></td>
					  </tr>
					  <tr>
					    <td colspan="2">Phone:079-30429522</td>
					    <td width="289">Email:info@nationalenglishschool.in</td>
					  </tr>
					  <tr>
					    <td colspan="3"><h3><center>Leaving Certificate</center></h3></td>
					  </tr>
					  <tr>
					    <td >[1]</td>
					    <td>Pupil's Full Name</td>
					    <td><span ng-bind="person.lastName + ' ' + person.firstName + ' ' + father.firstName"></span></td>
					  </tr>
					  <tr>
					    <td>[2]</td>
					    <td>Religion and Caste</td>
					    <td><span ng-bind="student.religion"></span></td>
					  </tr>
					  <tr>
					    <td>[3]</td>
					    <td>Date of Birth</td>
					    <td><span ng-bind="person.dob"></span></td>
					  </tr>
					  <tr>
					    <td>[4]</td>
					    <td>Date of Admission</td>
					    <td><span ng-bind="student.enrollmentDate"></span></td>
					  </tr>
					  <tr>
					    <td>[5]</td>
					    <td>Date of Leaving School</td>
					    <td><span ng-bind="currentDate"></span></td>
					  </tr>
					  <tr>
					    <td>[6]</td>
					    <td>Conduct</td>
					    <td>Good</td>
					  </tr>
					  <tr>
					    <td colspan="3">It is to certify that above information is in accordance with the School Registration.</td>
					  </tr>
					  <tr>
					    <td></td>
					    <td></td>
					    <td><span style="text-align: right;">Principal</span></td>
					  </tr>
					</table>
					</div>
				<!-- End Leaving Certificate -->
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