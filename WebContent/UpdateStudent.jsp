<head>
<title>Update Student</title>
</head>
<jsp:include page="header.jsp"></jsp:include>

<%

     if (null==session.getAttribute("username"))
     {
    	 
    	 response.setHeader("Cache-Control","no-store"); 
         response.setHeader("Pragma","no-cache"); 
         response.setHeader ("Expires", "0"); //prevents caching at the proxy server	
    	 
    	 response.sendRedirect("login.jsp");
  
     }
 
    
   %>

<script type="text/javascript">
var app = angular.module('myApp', []);
app
		.controller(
				'admission',
				function($scope, $http) {
					$scope.admit = {};
					$scope.admit.student = {};
					$scope.admit.mother = {};
					$scope.admit.father = {};

					$scope.init = function() {
						
						
						
						$http(
								{
									method : 'POST',
									url : "StandardController?action=list",
									datatype : 'text',
									headers : {
										"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
									}
								})
								.success(
										function(response) {

											//console.log(response);
											$scope.standardList = response;
											
											
											
											$http(
													{
														method : 'POST',
														url : "CityController?action=list",
														datatype : 'text',
														headers : {
															"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
														}
													}).success(function(response) {

												$scope.cityList = response;
											
												
												$http(
														{
															method : 'POST',
															url : "AdmissionController?action=display&studentId=" + <%= request.getParameter("studentId")%>,
															datatype : 'text',
															headers : {
																"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
															}
														})
														.success(
																function(response) {
																		
																	
																	//console.log(response);
																	$scope.response = JSON.parse(response);
																	
																	$scope.admit.student = $scope.response[0];
																	$scope.admit.person = $scope.response[1];
																	$scope.admit.mother = $scope.response[2];
																	$scope.admit.father = $scope.response[3];
																	
														
																	//console.log($scope.admit.mother.firstName)
																	
																	$("#photoDisplay").attr("src",$scope.admit.person.photo);
																	$("#photoDisplay").css("height","100px");
																	$("#photoDisplay").css("width","88px");
																	//console.log($scope.admit.student.grNo);
																	//console.log("RECEIVERD THIS AS PHOTO");
																	//console.log($scope.admit.person.photo);
																	//$scope.selectedCity = $scope.person.  ;
																	//$scope.selectedStandard = $scope.student. ;

																	angular.forEach($scope.cityList,function(city){
																		
																		if(city.cityId == $scope.admit.person.cityId){
																			
																			$scope.selectedCity = city;
																			}
																	});
																	
																	
																	
																	angular.forEach($scope.standardList,function(standard){
																		
																		if(standard.standardId == $scope.admit.student.standardId){
																			$scope.selectedStandard = standard;
																			}
																	});
																	
															

																});	
												
											

											});
											
										
										});

						
						
			
				
					};
					
					$scope.reset = function(){
						$scope.admit = {};
					}

					$scope.saveInfo = function() {

					
						$scope.admit.person.cityId = $scope.selectedCity.cityId;
						$scope.admit.student.standardId = $scope.selectedStandard.standardId;
						
						
						console.log($scope.admit);
						
						
						dob = $("#dob").val();
						console.log(dob);
						//$scope.admit.person.dob = new Date(dob);
						$scope.admit.person.dob = dob;
						console.log($scope.admit.person.dob)
						
						$scope.admit.person.photo = $("#imageText").val();
						//console.log("SENDING THIS AS PHOTO");
						//console.log($scope.admit.person.photo);
						
						$http({
							method : 'POST',
							url : 'AdmissionController?action=update',
							headers : {
								'Content-Type' : 'application/json'
							},
							data : $scope.admit
							
						})
								.success(
										function(data) {
											console.log($scope.admit);
											alert("successfully updated data");
											
											$scope.admit = {};
											//location.reload();
											window.location = "studentlist.jsp";
										});
					};

				});
				
function getbase64() {

	filesSelected = document.getElementById('photo').files;
	if (filesSelected.length > 0) {
		var fileToLoad = filesSelected[0];

		var fileReader = new FileReader();

		fileReader.onload = function(fileLoadedEvent) {
			imgPhoto = fileLoadedEvent.target.result;
			document.getElementById('imageText').value = imgPhoto;
			element = document.getElementById('imageText');

			$('#photoDisplay').attr("src", imgPhoto);
			$('#photoDisplay').css("display", "block");

		
		/*	if ("createEvent" in document) {
				var evt = document.createEvent("HTMLEvents");
				evt.initEvent("change", false, true);
				element.dispatchEvent(evt);
			} else
				element.fireEvent("onchange"); */

		};

		fileReader.readAsDataURL(fileToLoad);

	}

}
</script>

<!-- Hardik Code End -->

<div ng-app="myApp" class="container-fluid" ng-controller="admission"
	ng-init="init()">

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
							<li><a href="Admission.jsp">Admission</a><span class="divider">/</span></li>
							
							<li><a href="studentlist.jsp">Student Details</a><span class="divider">/</span></li>
							<li class="active">Update Student Info.</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<!-- block -->
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">Update Student Info.</div>
					</div>

					<div class="block-content collapse in">
						<div>

							<form role="form">

								<legend> Academic Details </legend>

								<fieldset>
									<!-- 	<div class="span12">
								<div class="span2">
									<label class="form-control">Sample</label>
								</div>
								<div class="span4">
									<input type="text" class="form-control" />
								</div>
								<div class="span2">
									<label class="form-control">Sample</label>
								</div>
								<div class="span4">
									<input type="text" class="form-control" />
								</div>
							</div> -->
									<div class="span12">

										<div class='col-md-5'>
											<img id="photoDisplay"> </img>
										</div>

										<div class="span2">

											<label for="textfield" class="form-control">Photo</label>
										</div>

										<div class="span4">
											<textarea ng-model="admit.person.photo" id="imageText"
												style="display: none;">
                                                        </textarea>
											<input name="sPhoto" id="photo" type="file" accept="image/*"
												onchange="getbase64();">
										</div>

									</div>









									<div class="span12">

										<div class='span2'>
											<label for="textfield" class="form-control">GR No. :
											</label>
										</div>

										<div class='span4'>
											<input class="span6 m-wrap h30" ng-model="admit.student.grNo"
												required type="number" placeholder='Enter GRNO.'>
										</div>

										<div class='span2'>
											<label for="textfield" class="form-control">Roll No.
												:</label>
										</div>

										<div class='span4'>

											<input placeholder="Enter Roll No." class="span6 m-wrap h30"
												ng-model="admit.student.rollNo" type="number">
										</div>

									</div>


									<div class="span12">

										<div class='span2'>
											<label for="textfield" class="form-control">DISE No.</label>
										</div>

										<div class='span4'>
											<input placeholder="Enter DISE Number" class="span6 m-wrap h30"
												ng-model="admit.student.diseNo" type="text">
										</div>


										<div class='span2'>
											<label for="textfield" class="form-control">Board</label>
										</div>

										<div class='span4'>
											<select ng-model="admit.student.board" class='span6 m-wrap h30'
												id="board"
												ng-options="board for board in ['GSEB','CBSE','ICSE']"
												ng-init="admit.student.board='GSEB'">

											</select>


										</div>

									</div>


									<div class="span12">
										<div class='span2'>
											<label for="textfield" class="form-control">First
												Name</label>
										</div>

										<div class="span4">
											<input placeholder="Enter First Name" class="span6 m-wrap h30"
												ng-model="admit.person.firstName" required type="text">
										</div>


										<div class="span2">
											<label for="textfield" class="form-control">Last Name</label>
										</div>

										<div class="span4">
											<input placeholder="Enter Last Name" class="span6 m-wrap h30"
												ng-model="admit.person.lastName" data-rule-required="true"
												type="text">
										</div>
									</div>






									<div class="span12">
										<div class="span2">
											<label for="textfield" class="form-control"> Batch:</label>
										</div>

										<div class="span4">
											<select ng-options="shift for shift in ['Morning','Evening']"
												ng-init="admit.student.batch='Morning'"
												ng-model="admit.student.batch" class='span6 m-wrap h30'>

											</select>
										</div>




										<div class="span2">
											<label for="textfield" class="form-control">
												Standard:</label>
										</div>

										<div class="span4">
											<select
												ng-options="standard.standardName for standard in standardList"
												class='span6 m-wrap h30' ng-model="selectedStandard">

											</select>
										</div>
									</div>

								</fieldset>

								<legend> Personal Details </legend>
								<fieldset>

									<div class="span12">
										<div class="span2">
											<label for="textfield" class="form-control">Gender</label>
										</div>

										<div class="span4">
											<input ng-model="admit.person.gender" id="sGender"
												ng-checked="admit.person.gender" value="Male"
												checked="checked" type="radio" />Male <input id="sGender"
												name="sGender" value="Female" ng-model="admit.person.gender"
												type="radio" />Female
										</div>




										<div class="span2">

											<label for="textfield" class="form-control">Date of
												Birth</label>

										</div>

										<div class="span4">

											<input class="span6 m-wrap h30"
												placeholder="Date" id="dob" type="text"
												step=7 min="2014-09-08" class="input-xlarge datepicker"
												ng-model="admit.person.dob">
											<script>
												$(document).ready(

												function() {
													/*
													$('#dob')
															.datepicker(
																	{
																		format : "dd-mm-yyyy"
																	});
													 */

												});
											</script>


										</div>

									</div>








									<div class="span12">
										<div class="span2">
											<label for="textfield" class="form-control">Religion</label>
										</div>

										<div class="span4">
											<select ng-model="admit.student.religion"
												class="span6 m-wrap h30"
												ng-options="religion for religion in ['Hinduism','Christainity','Islam','Jainism','Sikhism','Jewism','Buddhism','Other']"
												ng-init="admit.student.religion='Hinduism'">

											</select>
										</div>

										<div class="span2">
											<label for="textfield" class="form-control">Category</label>
										</div>

										<div class="span4">

											<select ng-model="admit.student.category"
												class="span6 m-wrap h30"
												ng-options="category for category in ['Open','SEBC','SC','ST','Other']"
												ng-init="admit.student.category='Open'">

											</select>

										</div>
									</div>












									<div class="span12">
										<div class="span2">
											<label for="textfield" class="form-control">Nationality</label>
										</div>

										<div class="span4">

											<input ng-model="admit.student.nationality"
												class="span6 m-wrap h30" type="text">


										</div>

										<div class='span2'>
											<label for="textfield" class="form-control">Blood
												Group</label>
										</div>


										<div class="span4">
											<select ng-model="admit.student.bloodGroup"
												class='span6 m-wrap h30'
												ng-options="bloodGroup for bloodGroup in ['A+','A-','AB+','AB-','B+','B-','O+','O-']"
												ng-init="admit.student.bloodGroup='B+'">
												<option>A+</option>
												<option>A-</option>
												<option>AB+</option>
												<option>AB-</option>
												<option>B+</option>
												<option>B-</option>
												<option>O+</option>
												<option>O-</option>
											</select>
										</div>
									</div>


								</fieldset>





								<div class="span12">
									<div class="span2">
										<label for="textfield" class="form-control">Email-Address</label>
									</div>

									<div class="span4">
										<input Placeholder="Enter Email Id(If Any)"
											class="span6 m-wrap h30" 
											ng-model="admit.person.email" data-rule-required="true"
											data-rule-email="true" type="text">
									</div>


									<div class="span2">
										<label for="textfield" class="form-control">Home Phone</label>
									</div>

									<div class="span4">
										<input ng-model="admit.person.homeNo" name="sPhone"
											class="span6 m-wrap h30" id="sPhone" 
												data-rule-required="true"
											type="text">
									</div>
								</div>









								<div class="span12">
									<div class="span2">
										<label for="textfield" class="form-control">Mobile
											Number</label>
									</div>

									<div class="span4">
										<input ng-model="admit.person.mobileNo" class="span6 m-wrap h30"
											pattern="^[7-9][0-9]{9}$" type="text">
									</div>

									<div class="span2">
										<label for="textfield" class="form-control">Alt Number</label>
									</div>

									<div class="span4">
										<input ng-model="admit.person.alternateNo"
											class="span6 m-wrap h30" data-rule-required="true" type="text">
									</div>
								</div>








								<div class="span12">
									<div class="span2">
										<label for="textfield" class="form-control">Address
											Line 1 </label>
									</div>

									<div class="span4">
										<input ng-model="admit.person.address1" name="sAddress"
											id="sAddress" class="span6 m-wrap h30" data-rule-required="true"
											type="text">
									</div>

									<div class="span2">
										<label for="textfield" class="form-control">Address
											Line 2</label>
									</div>

									<div class="span4">
										<input ng-model="admit.person.address2" name="sAddress"
											id="sAddress" class="span6 m-wrap h30" data-rule-required="true"
											type="text">
									</div>
								</div>





								<div class="span12">
									<div class="span2">
										<label for="textfield" class="form-control">City</label>
									</div>

									<div class="span4">
										<select class="span6 m-wrap h30"
											ng-options="city.cityName for city in cityList"
											ng-model="selectedCity">
										</select>
									</div>

									<div class="span2">

										<label for="textfield" class="form-control">Pincode</label>

									</div>

									<div class="span4">

										<input name="pincode" ng-model="admit.person.pincode"
											id="pincode" class="span6 m-wrap h30" pattern="^[0-9]{6}$"
											type="text">
									</div>
								</div>

								<legend>Family Details</legend>
								<fieldset>
									<div class="span12">
										<div class="span2">
											<label for="textfield" class="form-control">Father
												Name</label>
										</div>

										<div class="span4">
											<input name="sFname" ng-model="admit.father.firstName"
												size=id= "sFname" type="text" class="span6 m-wrap h30">
										</div>

										<div class="span2">
											<label for="textfield" class="form-control">Mother
												Name</label>

										</div>

										<div class="span4">

											<input name="sMname" ng-model="admit.mother.firstName"
												class="span6 m-wrap h30" size=id= "sMname" type="text">

										</div>

									</div>



									<div class="span12">
										<div class="span2">
											<label for="textfield" class="form-control">
												Occupation</label>
										</div>

										<div class="span4">
											<input name="sFoccu" ng-model="admit.father.occupation"
												class="span6 m-wrap h30" id="sFoccu" type="text">
										</div>


										<div class="span2">
											<label for="textfield" class="form-control">
												Occupation</label>
										</div>

										<div class="span4">

											<input name="sMoccu" ng-model="admit.mother.occupation"
												class="span6 m-wrap h30" id="sMoccu" type="text">
										</div>

									</div>




									<div class="span12">


										<div class="span2">
											<label for="textfield" class="form-control">Father
												Mobile</label>
										</div>

										<div class="span4">
											<input ng-model="admit.father.mobileNo" name="fMobile"
												class='span6 m-wrap h30' pattern="^[7-9][0-9]{9}$" type="text">
										</div>


										<div class="span2">
											<label for="textfield" class="form-control">Mother
												Mobile</label>
										</div>

										<div class="span4">
											<input ng-model="admit.mother.mobileNo" name="fMobile"
												class='span6 m-wrap h30' pattern="^[7-9][0-9]{9}$" type="text">
										</div>
									</div>





									<div class="span12">
										<div class="span2">
											<label for="textfield" class="form-control">Family
												Income</label>
										</div>

										<div class="span4">

											<input ng-model="admit.student.familyIncome"
												class='span6 m-wrap h30' id="sAddresso" type="text">
										</div>


										<div class="span2">
											<label for="textfield" class="form-control">Home
												Phone</label>

										</div>

										<div class="span4">
											<input ng-model="admit.father.homeNo" class="span6 m-wrap h30"
												id="sAddresso" type="text">
										</div>

									</div>



									<div class="span12">
										<div class="span2">
											<label for="textfield" class="form-control">Father
												Email</label>

										</div>

										<div class="span4">

											<input ng-model="admit.father.email" class="span6 m-wrap h30"
												id="fEmail" type="text">

										</div>

										<div class="span2">
											<label for="textfield" class="form-control">Mother
												Email</label>
										</div>

										<div class="span4">
											<input ng-model="admit.mother.email" class="span6 m-wrap h30"
												type="text">
										</div>
									</div>
								</fieldset>
								<div class="span12">
									<div class="col-md-5">
										<button class="btn btn-success" ng-click="saveInfo()">Submit</button>
										<button class="btn btn-warning" ng-click="reset()">reset</button>
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