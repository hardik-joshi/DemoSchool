<head>
	<title>Contact Add</title>
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
var app = angular.module('OrganizationApp', []);

app.controller('MainCtrl', function($scope, $http) {

	
	$scope.init = function(){
		
		$scope.org = {}
		$scope.org.organization = {}
		$scope.org.persons = {}
	
			$http(
									{
										method : 'POST',
										url : "OrganizationController?action=listtypes",
										datatype : 'text',
										headers : {
											"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
										}
									})
									.success(
											function(response) {

												console.log(response);
												$scope.OrgList = response;
												//$scope.selectedStandard = $scope.standardList[1];

											});
		
	
		$scope.org = {};
		$scope.org.persons = [{personid: '1'}];
	}
	
	$scope.saveInfo = function (){
		
		$scope.org.organization.organizationTypeId = $scope.selectedType.organizationTypeId;
		data = $scope.org;
		console.log(data);
		url = "OrganizationController?action=create"
		$http(
									{
										method : 'POST',
										url : url,
										headers : {
											"Content-Type" : "Content-Type' : 'application/json"
										},
										data : data
									})
									.success(
											function(response) {
								
									});
		
		$scope.init();
	}



	
$scope.addPerson = function() {
  var newItemNo = $scope.org.persons.length+1;
  $scope.org.persons.push({'personid':newItemNo});
};
  
$scope.removePerson = function() {
  var lastItem = $scope.org.persons.length-1;
  $scope.org.persons.splice(lastItem);
};

});
</script>

<!-- Hardik Code End -->

	<div ng-app="OrganizationApp" class="container-fluid" ng-controller="MainCtrl" ng-init="init()">
		
		<!--Alert Box Modal -->
		<div class="modal fade" id="AlertMessage" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true" style="display:none;">
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
						<button type="button" class="btn btn-primary" ng-click="resetPurchaseBook()" >OK</button>
						<button type="button" class="btn btn-default" data-dismiss="modal" aria-label="Close" >Cancel</button>
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
	                                    <i class="icon-chevron-left hide-sidebar"><a href='#' title="Hide Sidebar" rel='tooltip'>&nbsp;</a></i>
	                                    <i class="icon-chevron-right show-sidebar" style="display:none;"><a href='#' title="Show Sidebar" rel='tooltip'>&nbsp;</a></i>
	                                    <li class="active">
	                                        Contact Add <span class="divider">/</span>	
	                                    </li>
	                                    <li ><a href="ContactManagement.jsp">Contact Manage</a>	
	                                    </li>
	                                </ul>
                            	</div>
                        	</div>
                    	</div>
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">Organization Form</div>
						</div>

						<div class="block-content collapse in">
							<form>
							<div class="span12">
								
								<div class="col-sm-3 pull-left">
									<div class="control-group">

										<label for="isbnno" class="control-label">Organization Name:</label> <input class="span6 m-wrap h30" ng-model="org.organization.name" type="text" />
									</div>
								</div>
								<div class="col-sm-3 pull-left">
									<div class="control-group" style="margin-left: 30px;">
										<label for="booksetname" class="control-label">Organization Contact No.:</label> 
										<input class="span6 m-wrap h30" type="tel"   ng-model="org.organization.contactNumber" />

									</div>
								</div>
								<div class="col-sm-4 pull-left">
									<div class="control-group">

										<label for="booksetname" class="control-label">Organization Type: </label> 
										<select ng-options="orgtype.typeName for orgtype in OrgList" ng-model="selectedType"></select>
									</div>
								</div>

								<div class="clearfix"></div>
							</div>
							
							<div>
								<hr/>
								<fieldset class="control-group"  data-ng-repeat="person in org.persons">
									
									<div class="col-sm-12">
										<div class="col-sm-2"><label class="control-label"> First Name: </label> </div>
										<div class="col-sm-4"><input class="span6 m-wrap h30" ng-model="person.firstName"  pattern="^[a-zA-Z]+$" type="text" /> </div>
										<div class="col-sm-2"><label class="control-label">Last Name:</label> </div>
										<div class="col-sm-4"><input class="span6 m-wrap h30" ng-model="person.lastName" type ="text" /> </div>
									</div>
									
									<div class="col-sm-12">
										<div class="col-sm-2"><label class="control-label">Mobile No: </label></div>
										<div class="col-sm-4"> <input class="span6 m-wrap h30"  ng-model="person.mobileNo" pattern="^[7-9][0-9]{9}$"  type="tel"   /></div>
										<div class="col-sm-2"><label class="control-label">Alternate No:</label></div>
									 	<div class="col-sm-4"><input class="span6 m-wrap h30" ng-model="person.alternateNo" type="tel"  pattern="^[7-9][0-9]{9}$" /></div>
									</div>
									
									
									
									<div class="col-sm-12">
										<div class="col-sm-2"><label class="control-label">Designation: </label></div>
										<div class="col-sm-4"> <input class="span6 m-wrap h30" type ="text" ng-model="person.occupation" /></div>
										<div class="col-sm-2"><label class="control-label">Email :</label></div>
									 	<div class="col-sm-4"> <input class="span6 m-wrap h30" type="email" ng-model="person.email" /></div>
									</div>
									<hr/>
									<div style="float:right">
									<button class="btn btn-danger" ng-show="$last" ng-click="removePerson()"><i class="icon-minus icon-white"></i></button>
									</div>
									
									</fieldset>
										
										
									
									<div >
										<button class="btn btn-success" type="button" ng-click="addPerson()"> Add New <i class="icon-plus icon-white"></i>
									</button> 
										<button class="btn btn-primary" ng-click="saveInfo()">Save</button>
										
									</div>
									<!--  <div id="multiperson">
										{{org}}
									</div> -->
							</div>
							</form>
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