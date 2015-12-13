<head>
	<title>Standard Charges</title>
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
angular.module("FeesTypeApp", []).controller("FeesTypeController",function($scope, $http, $filter) {
	$scope.feesTypeList = "";
	$scope.feesType = {};
	$scope.selectedStandard = {};
	$scope.disableApply = true;
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
		// alert($scope.selectedStandard.standardId);
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
			/* $scope.feesTypeList = response; */
			$scope.displayFeesTypeData();
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
	
	$scope.applyFeesType = function(){
		$scope.studentId = [];
		$scope.disableApply = true;
		var url = "StudentController?action=selectedStudent&standardId=" + $scope.selectedStandard.standardId;
		// alert(url);
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			var studentList = response;
			console.log(response);
			var i=0;
			angular.forEach(studentList, function(list){
	        	$scope.studentId[i++] = list.studentId;
	        });
			console.log("Student Id [] :")
			console.log($scope.studentId);
			alert("Applying to Students...");
			
			var chargedate = $filter('date')(new Date(),"yyyy-MM-dd");
			for(var i=0;i<$scope.studentId.length;i++){
				angular.forEach($scope.feesTypeList, function(list){
					var url = "ChargeController?action=createUpdateInOutstanding&chargeDate=" + chargedate + "&description=" + list.typeName + "&amount=" + list.amount + "&studentId=" + $scope.studentId[i];
					var req = $http({
						headers : {
							"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
						},
						datatype : 'text',
						method : 'post',
						url : url
					});
					req.success(function(response) {
					});    	
		        });
			}
			
		});
	}
	
	$scope.checkAll = function () {
        if ($scope.selectedAll) {
        	$scope.disableApply = false;
            $scope.selectedAll = true;
        } else {
        	$scope.disableApply = true;
            $scope.selectedAll = false;
        }
        angular.forEach($scope.feesTypeList, function(list){
        	console.log("test");
        	console.log(list);
           	list.checkSelectedFeesType = $scope.selectedAll;
        });
    };
    
    $scope.checkSelected =function(checkSelectedFeesType){
    	if(checkSelectedFeesType)
    		$scope.disableApply = false;
    	else
    		$scope.disableApply = true;
    }
});
</script>

<!-- Hardik Code End -->

	<div ng-app="FeesTypeApp" class="container-fluid" ng-controller="FeesTypeController" ng-init="init()">
		
		<!--Add FeesType Modal -->
		<div class="modal fade" id="addFeesTypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 600px;left: 50% !important;display:none;">
			<div class="modal-dialog">	
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Add Fees Type</h4>
					</div>
					<div class="modal-body" style="max-height: 481px !important;">
						<div class="control-group">
							<label for="isbnno" class="control-label">Fees Name</label>
							<input type="text" class="span6 m-wrap h30" placeholder="E.g. Tution Fees" ng-model="feesType.typeName">
						</div>
						
						<div class="control-group">
							<label for="isbnno" class="control-label">Duration</label>
							
							<select class="span6 m-wrap h30" ng-model="selectedDuration">
								<option value="Monthly">Monthly</option>
								<option value="Annually">Annually</option>
								<option value="Bi-Annually(Term Wise)">Bi-Annually(Term Wise)</option>								
							</select>
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">Fees</label>
							<input type="text" class="span6 m-wrap h30" placeholder="E.g. 400" ng-model="feesType.amount">
						</div>						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" ng-click="saveFeesType()" >Save</button>
					</div>
				</div>
			</div>
		</div>
		<!--Update feesType Modal -->
		<div class="modal fade" id="updateFeesTypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 600px;left: 50% !important;display:none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Edit Fees Type</h4>
					</div>
					<div class="modal-body" style="max-height: 481px !important;">
						<div class="control-group">
							<label for="isbnno" class="control-label">Name</label>
							<input type="text" class="span6 m-wrap h30" placeholder="E.g. 101" ng-model="feesType.typeName">
						</div>
						
						<div class="control-group">
							<label for="isbnno" class="control-label">Duration</label>
							
							<select class="span6 m-wrap h30" ng-model="selectedDuration">
								<option value="Monthly">Monthly</option>
								<option value="Annually">Annually</option>
								<option value="Bi-Annually(Term Wise)">Bi-Annually(Term Wise)</option>								
							</select>
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">Fees</label>
							<input type="text" class="span6 m-wrap h30" placeholder="E.g. 400" ng-model="feesType.amount">
						</div>	
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" ng-click="saveUpdateFeesType()" >Save</button>
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
	                                       Standard Charges <span class="divider">/</span>	
	                                    </li>
	                                    <li>
	                                        <a href="fees.jsp">Student Billing</a>	
	                                    </li>
	                                </ul>
                            	</div>
                        	</div>
                    	</div>
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">Standard Charges</div>
						</div>

						<div class="block-content collapse in">
							<div class="span12">
								<div class=" pull-left">
									<div class="form-group">
										<label for="isbnno">Standard</label> <select class="form-control"
											ng-options="standard.standardName for standard in standardList"
											ng-model="selectedStandard" ng-change="displayFeesTypeData()"></select>
									</div>
								</div>
								<div class="pull-right" style="margin-top: 25px;">
									
									<button class="btn btn-success" type="button" ng-click="openAddFeesTypeModal()"> Add New <i class="icon-plus icon-white"></i>
									</button> 
								</div>
							</div>
							<div>
								<table class="table table-bordered table-hover">
									<thead >
									<tr class="info">
										<th style="text-align: center;width:50px"><input type="checkbox" ng-model="selectedAll" ng-click="checkAll()"></th>
										<th>Fees Name</th>
										<th>Duration</th>
										<th>Fees(in Rs.)</th>		
										<th></th>
										<th></th>			
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="x in feesTypeList">
											<td style="text-align: center;"><input type="checkbox" ng-model="x.checkSelectedFeesType" ng-click="checkSelected(x.checkSelectedFeesType)"></td>
											<td><span ng-bind="x.typeName"></span></td>
											<td><span ng-bind="x.duration"></span></td>
											<td><span ng-bind="x.amount"></span></td>						
											<td><span class="icon-edit" aria-hidden="true" ng-click="openUpdateFeesType(x)" style="cursor:pointer;"></span></td>
											<td><span class="icon-remove" aria-hidden="true" ng-click="deleteFeesType(x.feesTypeId)" style="cursor:pointer;"></span></td>
										</tr>
									</tbody>
								</table>
							</div>
							
								<div class="form-group" style="text-align:center;">		
									<button type="button" class="btn btn-success" ng-disabled="disableApply" ng-click="applyFeesType()" >Apply</button>
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