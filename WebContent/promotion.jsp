<head>
	<title>Purchase Book</title>
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
angular.module("PromotionApp", []).controller("PromotionController",
		function($scope, $http) {
			$scope.mainList = [];
			$scope.studentList = [];
			$scope.standardList = [];
			$scope.personList = [];
			$scope.selectedStandard = {};
			$scope.disablePromotion = true;
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
					var url = "StudentController?action=selectedStudent&standardId=" + $scope.selectedStandard.standardId;
					var req = $http({
						headers : {
							"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
						},
						datatype : 'text',
						method : 'post',
						url : url
					});
					req.success(function(response){
						console.log("Student List :");
						console.log(response);
						$scope.studentList = response;
						
						$scope.personId = [];
						for(var i=0;i<$scope.studentList.length;i++){
							$scope.personId.push($scope.studentList[i].personId);	
						}
						console.log("$scope.personId :" + $scope.personId);
						var url = "PersonController?action=selectedPerson&personId=" + $scope.personId;
						var req = $http({
							headers : {
								"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
							},
							datatype : 'text',
							method : 'post',
							url : url
						});
						req.success(function(response){
							console.log("Person List :");
							console.log(response);
							$scope.personList = response;
							for(var i=0;i<$scope.personList.length;i++){	
									$scope.mainList.push({personList:$scope.personList[i],studentList:$scope.studentList[i]});
							}
							console.log("MainList :")
							console.log($scope.mainList);
							console.log("selectedStandard :")
							console.log($scope.selectedStandard); 
							
						});
					});
				});					
			};
			
			$scope.displayStudentData = function(){
				$scope.mainList = [];
				$scope.studentList = [];
				$scope.personList = [];
				console.log($scope.selectedStandard);
				var url = "StudentController?action=selectedStudent&standardId=" + $scope.selectedStandard.standardId;
				var req = $http({
					headers : {
						"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
					},
					datatype : 'text',
					method : 'post',
					url : url
				});
				req.success(function(response){
					console.log("Student List :");
					console.log(response);
					$scope.studentList = response;
					
					$scope.personId = [];
					for(var i=0;i<$scope.studentList.length;i++){
						$scope.personId.push($scope.studentList[i].personId);	
					}
					console.log("$scope.personId :" + $scope.personId);
					var url = "PersonController?action=selectedPerson&personId=" + $scope.personId;
					var req = $http({
						headers : {
							"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
						},
						datatype : 'text',
						method : 'post',
						url : url
					});
					req.success(function(response){
						console.log("Person List :");
						console.log(response);
						console.log(JSON.stringify(response));
						$scope.mainList = [];
						$scope.personList = response;
						for(var i=0;i<$scope.personList.length;i++){	
								$scope.mainList.push({personList:$scope.personList[i],studentList:$scope.studentList[i],checkSelectedStudent:false});
						}
						console.log("MainList :")
						console.log($scope.mainList);
						console.log("selectedStandard :")
						console.log($scope.selectedStandard); 
						
					});
				});
			}
			
			$scope.promoteStudent = function(){
				$scope.studentId = [];
				$scope.disablePromotion = true;
				angular.forEach($scope.mainList, function(list){
					if(list.checkSelectedStudent){
						$scope.studentId.push(list.studentList.studentId);
					}	
		        });
				var url = "StudentController?action=promoteStudent&standardId=" + $scope.selectedStandard.standardId + "&studentId=" + $scope.studentId;
				var req = $http({
					headers : {
						"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
					},
					datatype : 'text',
					method : 'post',
					url : url
				});
				req.success(function(response){
					console.log("Promotion Response :");
					$scope.studentList = response;
					$scope.mainList = [];
					for(var i=0;i<$scope.studentList.length;i++){	
						for(var j=0;j<$scope.personList.length;j++){
							if($scope.personList[j].personId == $scope.studentList[i].personId){
								console.log("person idddddd :"+ $scope.personList[j].personId);
								$scope.mainList.push({personList:$scope.personList[j],studentList:$scope.studentList[i],checkSelectedStudent:false});
								console.log($scope.mainList);
							}
						}
						
					}
				});
			}
			
			$scope.checkAll = function () {
		        if ($scope.selectedAll) {
		        	$scope.disablePromotion = false;
		            $scope.selectedAll = true;
		        } else {
		        	$scope.disablePromotion = true;
		            $scope.selectedAll = false;
		        }
		        angular.forEach($scope.mainList, function(list){
		        	console.log("test");
		        	console.log(list);
		           	list.checkSelectedStudent = $scope.selectedAll;
		        });
		    };
		    
		    $scope.checkSelected =function(checkSelectedStudent){
		    	if(checkSelectedStudent)
		    		$scope.disablePromotion = false;
		    	else
		    		$scope.disablePromotion = true;
		    }
		    
		    $scope.openDemoteStudent = function(){
				$scope.alertTitle = "Demote Student";
				$scope.alertMessage = "Do you want to Demote Student ?";
				$('#AlertMessage').modal("show"); 
			}
		    
		    $scope.demoteStudent = function(){
		    	$scope.studentId = [];
		    	$scope.disablePromotion = true;
				angular.forEach($scope.mainList, function(list){
					if(list.checkSelectedStudent){
						$scope.studentId.push(list.studentList.studentId);
					}	
		        });
				var url = "StudentController?action=demoteStudent&standardId=" + $scope.selectedStandard.standardId + "&studentId=" + $scope.studentId;
				var req = $http({
					headers : {
						"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
					},
					datatype : 'text',
					method : 'post',
					url : url
				});
				req.success(function(response){
					console.log("Demotion Response :");
					$scope.studentList = response;
					$scope.mainList = [];
					for(var i=0;i<$scope.studentList.length;i++){	
						for(var j=0;j<$scope.personList.length;j++){
							if($scope.personList[j].personId == $scope.studentList[i].personId){
								console.log("person idddddd :"+ $scope.personList[j].personId);
								$scope.mainList.push({personList:$scope.personList[j],studentList:$scope.studentList[i],checkSelectedStudent:false});
								console.log($scope.mainList);
								$('#AlertMessage').modal("hide"); 
							}
						}
						
					}
				});
				$('#AlertMessage').modal("hide"); 
		    }
		});
</script>

<!-- Hardik Code End -->

	<div ng-app="PromotionApp" class="container-fluid" ng-controller="PromotionController" ng-init="init()">
		
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
						<button type="button" class="btn btn-primary" ng-click="demoteStudent()" >OK</button>
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
	                                    <li>
	                                        <a href="index.jsp">Dashboard</a> <span class="divider">/</span>	
	                                    </li>
	                                    <li class="active">Promote Student</li>
	                                </ul>
                            	</div>
                        	</div>
                    	</div>
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">Promote Student</div>		
							<div class="pull-right"><button class="btn btn-warning btn-mini" ng-disabled="disablePromotion" ng-click="openDemoteStudent()" style="margin-top:0px;">Demote</button></div>					
						</div>

						<div class="block-content collapse in">
							<div class="span12">
								<div class="pull-left">
									<div class="form-group">
										<label for="isbnno">Standard</label> <select class="form-control"
											ng-options="standard.standardName for standard in standardList"
											ng-model="selectedStandard" ng-click="displayStudentData()"></select>
									</div>
								</div>
								<div class="pull-right">
									<div class="form-group">
											
										      <input type="text" class="span6 m-wrap h30" placeholder="Search for..." ng-model="searchStudent" style="margin-top: 35px;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;border-top-left-radius: 5px;border-top-right-radius: 5px;width:190px;">
										    
											<button type="button" class="btn btn-success" ng-disabled="disablePromotion" ng-click="promoteStudent()" style="margin-top: 25px;">Promote</button>
									</div>
								</div>
										
								<div class="clearfix"></div>
							</div>
							<div>
								<table class="table table-bordered table-hover">
									<thead>
										<tr class="info">
											<th style="text-align: center;width:50px"><input type="checkbox" ng-model="selectedAll" ng-click="checkAll()">
											<th style="width: 150px;">First Name</th>
											<th style="width: 150px;">Last Name</th>
											<th style="width: 150px;">Date Of Birth</th>
											<th style="width: 250px;">Email</th>
											<th style="width: 150px;">Mobile No</th>
											<th style="width: 100px;">Gender</th>
											<th style="width: 100px;">Gr No</th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="x in mainList | filter:searchStudent">
											<td style="text-align: center;"><input type="checkbox" ng-model="x.checkSelectedStudent" ng-click="checkSelected(x.checkSelectedStudent)"></td>
											<td><span ng-bind="x.personList.firstName"></span></td>
											<td><span ng-bind="x.personList.lastName"></span></td>
											<td><span ng-bind="x.personList.dob"></span></td>
											<td><span ng-bind="x.personList.email"></span></td>
											<td><span ng-bind="x.personList.mobileNo"></span></td>
											<td><span ng-bind="x.personList.gender"></span></td>
											<td><span ng-bind="x.studentList.grNo"></span></td>
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