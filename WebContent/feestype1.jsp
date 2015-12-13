<!DOCTYPE html>
<head>
<title>Fees Type</title>
<!-- Include one of jTable styles. -->
<link href="css/metro/blue/jtable.css" rel="stylesheet" type="text/css" />
<link href="css/jquery-ui-1.10.3.custom.css" rel="stylesheet"
	type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<!-- Include jTable script file. -->
<script src="js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
<script src="js/jquery.jtable.js" type="text/javascript"></script>
<script src="js/angular.min.js" type="text/javascript"></script>
<script src="js/bootstrap-modal.js" type="text/javascript"></script>

<script src="js/bootstrap.min.js"></script>

<script type="text/javascript">
	angular.module("FeesTypeApp", []).controller("FeesTypeController",function($scope, $http) {
						$scope.feesTypeList = "";
						$scope.feesType = {};
						$scope.selectedStandard = {};
						$scope.init = function() {
							var url = "StandardController?action=list";
							var req = $http({
								headers : {
									"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
								},
								datatype : 'text',
								method : 'post',
								url : url
							});
							req.success(function(response) {
								$scope.standardList = response;
								$scope.selectedStandard = $scope.standardList[0];
								console.log($scope.standardList);
								console.log("Selected Standard");
								console.log($scope.selectedStandard);
								var url = "FeesTypeController?action=selectedFeesType&standardId=" + $scope.selectedStandard.standardId;
								var req = $http({
									headers : {
										"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
									},
									datatype : 'text',
									method : 'post',
									url : url
								});
								req.success(function(response) {
									console.log(response);
									$scope.feesTypeList = response;
								});
							});
						};
						
						$scope.displayFeesTypeData = function(){
							var url = "FeesTypeController?action=selectedFeesType&standardId=" + $scope.selectedStandard.standardId;
							var req = $http({
								headers : {
									"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
								},
								datatype : 'text',
								method : 'post',
								url : url
							});
							req.success(function(response) {
								console.log(response);
								$scope.feesTypeList = response;
							});
						}
						
						$scope.openAddFeesTypeModal = function() {
							$('#addFeesTypeModal').modal("show");
						}
						$scope.saveFeesType = function(){
							//console.log($scope.feesType);
							alert($scope.selectedStandard.standardId);
							$scope.feesType.duration = $scope.selectedDuration;
							var url = "FeesTypeController?action=create&typeName=" + $scope.feesType.typeName + "&duration=" + $scope.feesType.duration + "&amount=" + $scope.feesType.amount + "&standardId=" + $scope.selectedStandard.standardId;
							var req = $http({
								headers : {
									"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
								},
								datatype : 'text',
								method : 'post',
								url : url
							});
							req.success(function(response) {
								$scope.feesType = "";
								$scope.feesTypeList = response;
								$('#addFeesTypeModal').modal("hide");
							});
						}
						$scope.deleteFeesType = function(feesTypeId){
							var url = "FeesTypeController?action=delete&feesTypeId=" + feesTypeId;
							var req = $http({
								headers : {
									"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
								},
								datatype : 'text',
								method : 'post',
								url : url
							});
							req.success(function(response) {
								$scope.feesTypeList = response;
							});
						}
						$scope.openUpdateFeesType = function(feesType){
							$scope.feesType = feesType;
							$scope.selectedDuration = $scope.feesType.duration;
							console.log($scope.feesType);
							$('#updateFeesTypeModal').modal("show");
						}
						$scope.saveUpdateFeesType = function(){
							//console.log($scope.feesType);
							$scope.feesType.duration = $scope.selectedDuration;
							var url = "FeesTypeController?action=update&feesTypeId=" + $scope.feesType.feesTypeId + "&typeName=" + $scope.feesType.typeName + "&duration=" + $scope.feesType.duration + "&amount=" + $scope.feesType.amount + "&standardId=" + $scope.selectedStandard.standardId;
							var req = $http({
								headers : {
									"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
								},
								datatype : 'text',
								method : 'post',
								url : url
							});
							req.success(function(response) {
								$scope.feesType = "";
								$scope.feesTypeList = response;
								$('#updateFeesTypeModal').modal("hide");
							});
						}
					});
</script>

</head>
<body ng-app="FeesTypeApp">
	<div ng-controller="FeesTypeController" ng-init="init()" class="container"
		style="padding-top: 20px;">

		<!--Add FeesType Modal -->
		<div class="modal fade" id="addFeesTypeModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Add Fees Type</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="isbnno">Fees Name</label>
							<input type="text" class="form-control" placeholder="E.g. Tution Fees" ng-model="feesType.typeName">
						</div>
						
						<div class="form-group">
							<label for="isbnno">Duration</label>
							
							<select class="form-control" ng-model="selectedDuration">
								<option value="Monthly">Monthly</option>
								<option value="Annually">Annually</option>
								<option value="Bi-Annually(Term Wise)">Bi-Annually(Term Wise)</option>								
							</select>
						</div>
						<div class="form-group">
							<label for="isbnno">Fees</label>
							<input type="text" class="form-control" placeholder="E.g. 400" ng-model="feesType.amount">
						</div>						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" ng-click="saveFeesType()" >Save</button>
					</div>
				</div>
			</div>
		</div>
		<!--Update feesType Modal -->
		<div class="modal fade" id="updateFeesTypeModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Edit Fees Type</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="isbnno">Name</label>
							<input type="text" class="form-control" placeholder="E.g. 101" ng-model="feesType.typeName">
						</div>
						
						<div class="form-group">
							<label for="isbnno">Duration</label>
							
							<select class="form-control" ng-model="selectedDuration">
								<option value="Monthly">Monthly</option>
								<option value="Annually">Annually</option>
								<option value="Bi-Annually(Term Wise)">Bi-Annually(Term Wise)</option>								
							</select>
						</div>
						<div class="form-group">
							<label for="isbnno">Fees</label>
							<input type="text" class="form-control" placeholder="E.g. 400" ng-model="feesType.amount">
						</div>	
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" ng-click="saveUpdateFeesType()" >Save</button>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-12">
			<div class=" pull-left">
				<div class="form-group">
					<label for="isbnno">Standard</label> <select class="form-control"
						ng-options="standard.standardName for standard in standardList"
						ng-model="selectedStandard" ng-click="displayFeesTypeData()"></select>
				</div>
			</div>
			<div class="pull-right">
				<div class="form-group">
				<button class="btn btn-default" type="button" data-toggle="modal"
					data-target="#addFeesTypeModal" ng-click="openAddFeesTypeModal()"><span class="glyphicon glyphicon-plus-sign" aria-hidden="true"  ></span></button>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="col-sm-12">

			<table class="table table-bordered table-hover">
				<thead >
				<tr class="info">
					<th>Fees Name</th>
					<th>Duration</th>
					<th>Fees(in Rs.)</th>		
					<th></th>
					<th></th>			
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="x in feesTypeList">
						<td><span ng-bind="x.typeName"></span></td>
						<td><span ng-bind="x.duration"></span></td>
						<td><span ng-bind="x.amount"></span></td>						
						<td><span class="glyphicon glyphicon-edit" aria-hidden="true" ng-click="openUpdateFeesType(x)" style="cursor:pointer;"></span></td>
						<td><span class="glyphicon glyphicon-remove-circle" aria-hidden="true" ng-click="deleteFeesType(x.feesTypeId)" style="cursor:pointer;"></span></td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- <h4>FeesType Details</h4>
		<div id="feesTypeTableContainer"></div> -->
	</div>
	<script type="text/javascript">
		
	</script>
</body>
</html>