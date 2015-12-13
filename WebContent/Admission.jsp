<head>
<title>Admission</title>
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
app.controller('admission',function($scope, $http, $filter) {
					$scope.flag = 0;
					$scope.currentDate = $filter('date')(new Date(), "MM/dd/yyyy");
					$scope.admit = {};
					$scope.admit.student = {};
					$scope.admit.mother = {};
					$scope.admit.father = {};
					$scope.admit.person = {};
					$scope.alertMsg = function(msg){
						$().toastmessage('showToast', {
						    text:msg,
						    sticky: false,
				            type: 'error',
				            closeButton: true,
				            closeText: '',
				            close: function() {
				                console.log("toast is closed ...");
				            }
						});
					}
					$scope.successMsg = function(msg){
						$().toastmessage('showToast', {
						    text:msg,
						    sticky: false,
				            type: 'success',
				            closeButton: true,
				            closeText: '',
				            close: function() {
				                console.log("toast is closed ...");
				            }
						});
					}
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
								.success(function(response) {
											console.log(response);
											$scope.standardList = response;
											$scope.selectedStandard = $scope.standardList[1];

										});

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
							$scope.selectedCity = $scope.cityList[3];
							$scope.admit.person.gender = "Male";
						});

					};

					
					$scope.reset = function() {
						$scope.admit = {};
						$scope.admit.student = {};
						$scope.admit.mother = {};
						$scope.admit.father = {};
						$scope.admit.person = {};
						//console.log($scope.admit.student.board);
						console.log($scope.admit.student.board);
						$scope.init();
					
					};
					
					// 	hardik
					$scope.validateInfo = function(){
						
						console.log("Admit :");
						console.log($scope.admit);
						var grno = $scope.admit.student.grNo;
						var rollno = $scope.admit.student.rollNo;
						var mobileno = $scope.admit.person.mobileNo;
						var alterno = $scope.admit.person.alternateNo;
						var fmobileno = $scope.admit.father.mobileNo;
						var mmobileno = $scope.admit.mother.mobileNo;
						var homeno = $scope.admit.person.homeNo;
						var fhomeno = $scope.admit.father.homeNo;
						var pincode = $scope.admit.person.pincode;
						var email = $scope.admit.person.email;
						var validate = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
						var femail = $scope.admit.father.email;
						var memail = $scope.admit.mother.email;
						if($scope.admit.student.grNo == undefined || $scope.admit.student.diseNo == undefined || $scope.admit.student.rollNo == undefined || $scope.admit.person.firstName == undefined ||
								$scope.admit.person.lastName == undefined || $scope.admit.student.nationality == undefined || $scope.admit.person.mobileNo == undefined || $scope.admit.person.email == undefined ||
								$scope.admit.person.address1 == undefined || $scope.admit.father.firstName == undefined ||  $scope.admit.person.homeNo == undefined ||  $scope.admit.person.alternateNo == undefined ||
								 $scope.admit.person.address2 == undefined || $scope.admit.person.pincode == undefined || $scope.admit.mother.firstName == undefined || $scope.admit.father.mobileNo == undefined ||
								$scope.admit.student.familyIncome == undefined || $scope.admit.person.photo == undefined || $scope.admit.father.occupation == undefined ||  $scope.admit.mother.occupation == undefined ||  
								$scope.admit.mother.mobileNo == undefined ||  $scope.admit.father.homeNo == undefined ||  $scope.admit.father.email == undefined ||  $scope.admit.mother.email == undefined){
							
							$scope.alertMsg("Required Field is Empty");
							return false;
						}  
						else if($scope.admit.student.grNo == "" || $scope.admit.student.diseNo == "" || $scope.admit.student.rollNo == "" || $scope.admit.person.firstName == "" ||
								$scope.admit.person.lastName == "" || $scope.admit.student.nationality == "" || $scope.admit.person.mobileNo == "" || $scope.admit.person.email == "" ||
								$scope.admit.person.address1 == "" || $scope.admit.father.firstName == "" ||  $scope.admit.person.homeNo == "" ||  $scope.admit.person.alternateNo == "" ||
								 $scope.admit.person.address2 == "" || $scope.admit.person.pincode == "" || $scope.admit.mother.firstName == "" || $scope.admit.father.mobileNo == "" ||
								$scope.admit.student.familyIncome == "" || $scope.admit.person.photo == "" || $scope.admit.father.occupation == "" ||  $scope.admit.mother.occupation == "" ||  
								$scope.admit.mother.mobileNo == "" ||  $scope.admit.father.homeNo == "" ||  $scope.admit.father.email == "" ||  $scope.admit.mother.email == ""){
							
							$scope.alertMsg("Required Field is Empty");
							return false;
						}
						else if(grno.match("^[0-9]{4}$") == null){ 
							$scope.alertMsg("Number Format Not Match");
							$scope.alertMsg("GrNo :- 4 digit");
							return false;
						}
						else if(rollno.match("^[0-9]{3}$") == null){
							$scope.alertMsg("Number Format Not Match");
							$scope.alertMsg("RollNo :- 3 digit");
							return false;
						}
						else if(mobileno.match("^[7-9][0-9]{9}$") == null || fmobileno.match("^[7-9][0-9]{9}$") == null || alterno.match("^[7-9][0-9]{9}$") == null || mmobileno.match("^[7-9][0-9]{9}$") == null){
							$scope.alertMsg("Mobile Number Format Not Valid");
							return false
						}
						else if(homeno.match("^[0-9]{10}$") == null || fhomeno.match("^[0-9]{10}$") == null){
							// homeno.match("^\(\d{3}\) ?\d{3}( |-)?\d{4}|^\d{3}( |-)?\d{3}( |-)?\d{4}")
							alert(homeno);
							$scope.alertMsg("Phone Number Format Not Valid");
						}
						else if(pincode.match("^[0-9]{6}$") == null){
							$scope.alertMsg("Pincode does not valid");
						}
						else if(email.match(validate) == null || femail.match(validate) == null || memail.match(validate) == null){
							$scope.alertMsg("Email Address not Valid")
						}
						else{
							$scope.successMsg("Successfully Completed");
							return true;
						}
						
						
					}
					
					$scope.saveInfo = function() {
						var valid = $scope.validateInfo();
						
						if(!valid)
						{
							return;
						}
						$scope.admit.person.cityId = $scope.selectedCity.cityId;
						$scope.admit.student.standardId = $scope.selectedStandard.standardId;
						$scope.admit.person.dob = $("#date01").val();
						
						
						//console.log($scope.admit.person.cityId);
						//console.log($scope.admit.student.standardId);
						
						
						/* dob = $("#date01").val(); */
						$scope.admit.person.dob = $filter('date')(new Date($scope.admit.person.dob),"yyyy-MM-dd");
						//console.log($scope.admit.person.dob)
						
						console.log($scope.admit);
						
						 $http({
							method : 'POST',
							url : 'AdmissionController?action=create',
							headers : {
								'Content-Type' : 'application/json'
							},
							data : $scope.admit
						})
								.success(
										function(data) {
											$scope.admit={};
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
			$('#photoDisplapy').css("height","100px");
			$('#photoDisplay').css("width","88px");
				
			if ("createEvent" in document) {
				var evt = document.createEvent("HTMLEvents");
				evt.initEvent("change", false, true);
				element.dispatchEvent(evt);
			} else
				element.fireEvent("onchange");

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
							<li class="active">Admission <span class="divider">/</span></li>
							
							<li><a href="studentlist.jsp">Student Details</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row-fluid">
				<!-- block -->
				<div class="block">
					<div class="navbar navbar-inner block-header">
						<div class="muted pull-left">Admission</div>
					</div>

					<div class="block-content collapse in">
						<div>

							<form role="form" name="myForm" novalidate>

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
									<div class="span12" style="margin-bottom:10px;">

										<div class='col-md-6' style="margin-left:25px;margin-bottom:10px;" >
											<img id="photoDisplay"> </img>
										</div>

										<div class="span2">

											<label for="textfield" class="form-control">Photo <span style="color:red;">*</span></label>
										</div>

										<div class="span4">
											 <textarea ng-model="admit.person.photo" id="imageText"
												style="display: none;">
                                                        </textarea>
											<input class="input-file uniform_on" name="sPhoto" id="photo" type="file" accept="image/*"
												onchange="getbase64();">
                                          </div>
                                        
									</div>

									<div class="span12">

										<div class='span2'>
											<label for="textfield" class="form-control">GR No. <span style="color:red;">*</span>
											</label>
										</div>

										<div class='span4'>
											<input class="span6 m-wrap h30" ng-model="admit.student.grNo"
												type="text" placeholder='Enter GRNO.'>
										</div>

										<div class='span2'>
											<label for="textfield" class="form-control">Roll No.
												 <span style="color:red;">*</span></label>
										</div>

										<div class='span4'>

											<input placeholder="Enter Roll No." class="span6 m-wrap h30"
												ng-model="admit.student.rollNo" type="text">
										</div>

									</div>


									<div class="span12">

										<div class='span2'>
											<label for="textfield" class="form-control">DISE No. <span style="color:red;">*</span></label>
										</div>

										<div class='span4'>
											<input placeholder="Enter DISE Number" class="span6 m-wrap h30"
												ng-model="admit.student.diseNo" type="text">
										</div>


										<div class='span2'>
											<label for="textfield" class="form-control">Board <span style="color:red;">*</span></label>
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
												Name <span style="color:red;">*</span></label>
											
										</div>

										<div class="span4">
											<input placeholder="Enter First Name" class="span6 m-wrap h30" name="firstname"
												ng-model="admit.person.firstName" type="text" required>
											<!-- <span style="color:red" ng-show="myForm.firstname.$dirty && myForm.firstname.$invalid">
											<span ng-show="myForm.firstname.$error.required">First Name is required.</span>
											</span> -->
										</div>


										<div class="span2">
											<label for="textfield" class="form-control">Last Name <span style="color:red;">*</span></label>
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
												Standard: <span style="color:red;">*</span></label>
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

									<div class="span12" style="margin-left:25px;">
										<div class="span2">
											<label for="textfield" class="form-control">Gender</label>
										</div>

										<div class="span4">
											<input ng-model="admit.person.gender" name="gender" value="Male"
												 type="radio" />Male
											<input ng-model="admit.person.gender" name="gender" value="Female"
												type="radio" />Female
										</div>




										<div class="span2">

											<label for="textfield" class="form-control">Date of
												Birth <span style="color:red;">*</span></label>

										</div>

										<div class="span4">

											<!-- <input class="span6 m-wrap h30"
												placeholder="Date" id="dob" type="text"
												class="input-xlarge datepicker"
												ng-model="admit.person.dob"> -->
											
	                                            <input type="text" class="span6 m-wrap h30 input-xlarge datepicker" id="date01" ng-model="admit.person.dob">
	                                        	


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
											<label for="textfield" class="form-control">Nationality <span style="color:red;">*</span></label>
										</div>

										<div class="span4">

											<input ng-model="admit.student.nationality"
												class="span6 m-wrap h30" type="text">


										</div>

										<div class='span2'>
											<label for="textfield" class="form-control">Blood
												Group </label>
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
											Number <span style="color:red;">*</span></label>
									</div>

									<div class="span4">
										<input ng-model="admit.person.mobileNo" class="span6 m-wrap h30"
											 type="text">
											 <!-- pattern="^[7-9][0-9]{9}$" -->
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
											Line 1 <span style="color:red;">*</span></label>
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
											id="pincode" class="span6 m-wrap h30" 
											type="text">
											<!-- pattern="^[0-9]{6}$" -->
									</div>
								</div>

								<legend>Family Details</legend>
								<fieldset>
									<div class="span12" style="margin-left:25px;">
										<div class="span2">
											<label for="textfield" class="form-control">Father
												Name <span style="color:red;">*</span></label>
										</div>

										<div class="span4">
											<input name="sFname" ng-model="admit.father.firstName"
												size=id= "sFname" type="text" class="span6 m-wrap h30">
										</div>

										<div class="span2">
											<label for="textfield" class="form-control">Mother
												Name <span style="color:red;">*</span></label>

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
												Mobile <span style="color:red;">*</span></label>
										</div>

										<div class="span4">
											<input ng-model="admit.father.mobileNo" name="fMobile"
												class='span6 m-wrap h30'  type="text">
												<!-- pattern="^[7-9][0-9]{9}$" -->
										</div>


										<div class="span2">
											<label for="textfield" class="form-control">Mother
												Mobile</label>
										</div>

										<div class="span4">
											<input ng-model="admit.mother.mobileNo" name="fMobile"
												class='span6 m-wrap h30'  type="text">
												<!-- pattern="^[7-9][0-9]{9}$" -->
										</div>
									</div>





									<div class="span12">
										<div class="span2">
											<label for="textfield" class="form-control">Family
												Income <span style="color:red;">*</span></label>
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
										<!-- <button class="btn btn-success" ng-click="saveInfo()">Submit</button> -->
										<button class="btn btn-success" ng-click="saveInfo()">Submit</button>
										<button class="btn btn-warning" ng-click="reset()">Reset</button>
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
        <link href="vendors/datepicker.css" rel="stylesheet" media="screen">
        <link href="vendors/uniform.default.css" rel="stylesheet" media="screen">
        <link href="vendors/chosen.min.css" rel="stylesheet" media="screen">
		<link href="css/jquery.toastmessage.css" rel="stylesheet" media="screen">
        <link href="vendors/wysiwyg/bootstrap-wysihtml5.css" rel="stylesheet" media="screen">

        <script src="vendors/jquery-1.9.1.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="vendors/jquery.uniform.min.js"></script>
        <script src="vendors/chosen.jquery.min.js"></script>
        <script src="vendors/bootstrap-datepicker.js"></script>

        <script src="vendors/wysiwyg/wysihtml5-0.3.0.js"></script>
        <script src="vendors/wysiwyg/bootstrap-wysihtml5.js"></script>

        <script src="vendors/wizard/jquery.bootstrap.wizard.min.js"></script>

	<script type="text/javascript" src="vendors/jquery-validation/dist/jquery.validate.min.js"></script>
	<script src="js/jquery.toastmessage.js"></script>
	<script src="assets/form-validation.js"></script>
        
	<script src="assets/scripts.js"></script>
        <script>

	jQuery(document).ready(function() {   
	   FormValidation.init();
	});
	

        $(function() {
            $(".datepicker").datepicker();
            $(".uniform_on").uniform();
            $(".chzn-select").chosen();
            $('.textarea').wysihtml5();

            $('#rootwizard').bootstrapWizard({onTabShow: function(tab, navigation, index) {
                var $total = navigation.find('li').length;
                var $current = index+1;
                var $percent = ($current/$total) * 100;
                $('#rootwizard').find('.bar').css({width:$percent+'%'});
                // If it's the last tab then hide the last button and show the finish instead
                if($current >= $total) {
                    $('#rootwizard').find('.pager .next').hide();
                    $('#rootwizard').find('.pager .finish').show();
                    $('#rootwizard').find('.pager .finish').removeClass('disabled');
                } else {
                    $('#rootwizard').find('.pager .next').show();
                    $('#rootwizard').find('.pager .finish').hide();
                }
            }});
            $('#rootwizard .finish').click(function() {
                alert('Finished!, Starting over!');
                $('#rootwizard').find("a[href*='tab1']").trigger('click');
            });
        });
        </script>
</body>

</html>