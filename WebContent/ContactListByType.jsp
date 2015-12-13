<head>
	<title>Contact Manage</title>
</head>

<jsp:include page="header.jsp"></jsp:include>

<script type="text/javascript">
angular
.module("ContactApp", [])
.controller(
		"ContactController",
		function($scope, $http) {

			$scope.init = function() {

				$scope.organizationList = {};
				$scope.organization = {};
				$scope.selectedOrganizationType= {};
				$scope.OrgList = {};
				
				
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
									$scope.selectedOrganizationType = $scope.OrgList[0];
									//$scope.selectedStandard = $scope.standardList[1];

								});

				
				
				
				
				
				
				
				
			/*
				url = "OrganizationController?action=listorganizations";
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
								function(response) {
									console.log(response);
									//console.log(response);
									$scope.organizationList = response;
									$scope.selectedOrganization = $scope.organizationList[0];
									$scope.orgSelected();

								}); */

			};

			$scope.orgSelected = function() {
					
				
				console.log($scope.selectedOrganizationType);
				id = $scope.selectedOrganizationType.organizationTypeId;

				console.log(id);
				
				url = "OrganizationController?action=listpersonsbyType&organizationTypeId="
						+ id

				console.log(url);

				$http(
						{
							method : 'POST',
							url : url,
							datatype : 'text',
							headers : {
								"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
							}
						}).success(function(response) {
						console.log(response);
			
					
					$scope.personList = response;
						
					
				});
			};

			$scope.saveUpdatePerson = function() {

				url = "OrganizationController?action=updateperson"
				console.log(url);
				person = $scope.person;

				var req = $http({
					headers : {
						"Content-Type" : "Content-Type' : 'application/json"
					},
					datatype : 'text',
					method : 'post',
					url : url,
					data : person
				});
				req.success(function(response) {
					$scope.person = "";
					$scope.orgSelected();
					//$scope.personList = response;
					$('#updatePersonModal').modal("hide");
				});

			}

			$scope.updatePerson = function(person) {

				$scope.person = person;
				$("#updatePersonModal").modal("show");

			}

			$scope.savePerson = function() {

				organizationId = $scope.selectedOrganization.organizationId;
				console.log($scope.person.occupation);

				url = "OrganizationController?action=addperson&organizationId="
						+ organizationId // + "&firstName=" + $scope.person.firstName + "&lastName="+ $scope.person.lastName + "&occupation=" + $scope.person.occupation + "&mobileNo=" + $scope.person.mobileNo + "&alternateNo=" + $scope.person.alternateNo + "&email=" + $scope.person.email;
				console.log(url);

				var req = $http({
					headers : {
						"Content-Type" : "Content-Type' : 'application/json"
					},
					datatype : 'text',
					method : 'post',
					url : url,
					data : $scope.person
				});
				req.success(function(response) {
					$scope.person = "";

					$scope.personList = response;
					$('#addPersonModal').modal("hide");
				});

			}

			
			$scope.addModal = function(){
				$("#addPersonModal").modal("show");
			};
			$scope.deletePerson = function(personId) {

				if (confirm("Do You Wanna Delete!") == true) {
				} else {
					return;
				}

				var url = "OrganizationController?action=deleteperson&personId="
						+ personId
						+ "&organizationId="
						+ $scope.selectedOrganization.organizationId;

				console.log(url);
				var req = $http({
					headers : {
						"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
					},
					datatype : 'text',
					method : 'post',
					url : url
				});
				req.success(function(response) {
					$scope.personList = response;
				});
			}

		});
</script>

<div ng-app="ContactApp" ng-controller="ContactController" ng-init="init()" class="container-fluid">
		
		<!--Add BookSet Modal -->
		<!--Update Contact Modal -->
		<div class="modal fade" id="addPersonModal" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 615px;left: 50% !important;display:none;">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">
								Add Contact For <span ng-bind="selectedOrganization.name"></span>
							</h4>
						</div>
						<div class="modal-body" style="max-height: 385px !important;">
							<div class="control-group">
								<label for="isbnno" class="control-label">First Name</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter First Name"
									ng-model="person.firstName">
							</div>
							<div class="control-group">
								<label for="isbnno" class="control-label">Last Name</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter Last Name"
									ng-model="person.lastName">
							</div>
							<div class="control-group">
								<label for="isbnno" class="control-label">Mobile No</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter Mobile No"
									ng-model="person.mobileNo">

							</div>
							<div class="control-group">
								<label for="isbnno" class="control-label">Alternate No</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter Alternate No"
									ng-model="person.alternateNo">
							</div>
							<div class="control-group">
								<label for="isbnno" class="control-label">Designation</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter Occupation"
									ng-model="person.occupation">
							</div>

							<div class="control-group">
								<label for="isbnno" class="control-label">Email</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter Email"
									ng-model="person.email">
							</div>


						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								ng-click="savePerson()">Save</button>
							<button type="button" class="btn" data-dismiss="modal">Cancel</button>
						</div>
					</div>
				</div>
			</div>

		<!--Update Contact Modal -->
		<div class="modal fade" id="updatePersonModal" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 615px;left: 50% !important;display:none;">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">
								Update Contact For <span ng-bind="selectedOrganization.name"></span>
							</h4>
						</div>
						<div class="modal-body" style="max-height: 385px !important;">
							<div class="control-group">
								<label for="isbnno" class="control-label">First Name</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter First Name"
									ng-model="person.firstName">
							</div>
							<div class="control-group">
								<label for="isbnno" class="control-label">Last Name</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter Last Name"
									ng-model="person.lastName">
							</div>
							<div class="control-group">
								<label for="isbnno" class="control-label">Mobile No</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter Mobile No"
									ng-model="person.mobileNo">

							</div>
							<div class="control-group">
								<label for="isbnno" class="control-label">Alternate No</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter Alternate No"
									ng-model="person.alternateNo">
							</div>
							<div class="control-group">
								<label for="isbnno" class="control-label">Designation</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter Occupation"
									ng-model="person.occupation">
							</div>

							<div class="control-group">
								<label for="isbnno" class="control-label">Email</label> <input type="text"
									class="span6 m-wrap h30" placeholder="Enter Email"
									ng-model="person.email">
							</div>


						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								ng-click="saveUpdatePerson()">Update</button>
							<button type="button" class="btn" data-dismiss="modal">Cancel</button>
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
	                                    <li>
	                                        <a href="OrganizationPerson.jsp">Contact Add</a> <span class="divider">/</span>	
	                                    </li>
	                                     <li>
	                                        <a href="ContactManagement.jsp">Contact Manage</a> <span class="divider">/</span>	
	                                    </li>
	                                    <li class="active">All Contacts</li>
	                                </ul>
                            	</div>
                        	</div>
                    	</div>
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">People By Organization Type</div>
						</div>

						<div class="block-content collapse in">
							<div class="span12">
								<div class="pull-left">
									<div class="form-group">

										<label for="isbnno">Organization Types</label> 
										<select	ng-options="organizationType.typeName for organizationType in OrgList" ng-model="selectedOrganizationType" ng-click="orgSelected();"> </select>
										
									</div>
								</div>
					
								</div>
						

								<div class="clearfix"></div>
							</div>
							<div>

								<table class="table table-bordered table-hover">
									<thead>
										<tr class="info">
											<th>Name</th>
											<th>Designation</th>
											<th>Mobile No.</th>
											<th>Alternate No.</th>
											<th>Email</th>
											<th></th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="x in personList">
											<td><span ng-bind="x.firstName + ' ' + x.lastName"></span></td>
											<td><span ng-bind="x.occupation"></span></td>
											<td><span ng-bind="x.mobileNo"></span></td>
											<td><span ng-bind="x.alternateNo"></span></td>
											<td><span ng-bind="x.email"></span></td>
											<td><span class="icon-edit"
												aria-hidden="true" ng-click="updatePerson(x)"
												style="cursor: pointer;"></span></td>
											<td><span class="icon-remove"
												aria-hidden="true" ng-click="deletePerson(x.personId)"
												style="cursor: pointer;"></span></td>
										</tr>
									</tbody>
								</table>
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