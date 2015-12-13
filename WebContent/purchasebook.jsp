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
	angular.module("PurchaseBookApp", []).controller("PurchaseBookController",
			function($scope, $http) {
				$scope.mainList = [];
				$scope.studentList = [];
				$scope.standardList = [];
				$scope.personList = [];
				$scope.selectedStandard = {};
				$scope.bookSet = {};
				$scope.disablePurchaseBook = true;
				$scope.init = function() {
					$scope.mainList = [];
					$scope.studentList = [];
					$scope.standardList = [];
					$scope.personList = [];
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

						var url = "BookSetController?action=selectedBookSet&standardId=" + $scope.selectedStandard.standardId;
						var req = $http({
							headers : {
								"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
							},
							datatype : 'text',
							method : 'post',
							url : url
						});
						req.success(function(response){
							console.log("Bookset :");
							console.log(response);
							$scope.bookSet = response;
							
							var url = "BookController?action=BooksFromBookSet&bookSetId=" + $scope.bookSet.bookSetId;
							var req = $http({
								headers : {
									"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
								},
								datatype : 'text',
								method : 'post',
								url : url
							});
							req.success(function(response){
								console.log("Books :");
								console.log(response);
								$scope.bookList = response;
								var temp = "";
								angular.forEach($scope.bookList, function(list){
						        	console.log(list);
						        	temp += list.title + ", \n";
						        });
								$scope.displayBookName = temp.slice(0, temp.length-1);
							});
						});
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
					
					var url = "BookSetController?action=selectedBookSet&standardId=" + $scope.selectedStandard.standardId;
					var req = $http({
						headers : {
							"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
						},
						datatype : 'text',
						method : 'post',
						url : url
					});
					req.success(function(response){
						console.log("Bookset :");
						console.log(response);
						$scope.bookSet = response;
						var url = "BookController?action=BooksFromBookSet&bookSetId=" + $scope.bookSet.bookSetId;
						var req = $http({
							headers : {
								"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
							},
							datatype : 'text',
							method : 'post',
							url : url
						});
						req.success(function(response){
							console.log("Books :");
							console.log(response);
							$scope.bookList = response;
							var temp = "";
							angular.forEach($scope.bookList, function(list){
					        	console.log(list);
					        	temp += list.title + ",\n";
					        });
							$scope.displayBookName = temp.slice(0, temp.length-1);
						});
					});
					var url = "StudentController?action=selectedStudent&standardId=" + $scope.selectedStandard.standardId;
					var req = $http({
						headers : {
							"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
						},
						datatype : 'text',
						method : 'post',
						url : url
					});
					
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
				
				$scope.buyBook = function(){
					$scope.selectedAll = false;
					$scope.studentId = [];
					$scope.disablePurchaseBook = true;
					alert("Buy Book")
					 angular.forEach($scope.mainList, function(list){
						if(list.checkSelectedStudent){
							$scope.studentId.push(list.studentList.studentId);
						}	
			        });
					var url = "StudentController?action=purchaseBookStudent&standardId=" + $scope.selectedStandard.standardId + "&studentId=" + $scope.studentId;
					var req = $http({
						headers : {
							"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
						},
						datatype : 'text',
						method : 'post',
						url : url
					});
					req.success(function(response){
						console.log("Purchase Book Response :");
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
			       	if($scope.mainList!=""){
		        	 	if($scope.selectedAll) {
				            $scope.selectedAll = true;
				        } else {
				        	$scope.disablePurchaseBook = true;
				            $scope.selectedAll = false;
				        }
				        angular.forEach($scope.mainList, function(list){
				        	console.log("test");
				        	console.log(list);
				        	if(list.studentList.purchaseBook == 0 && $scope.selectedAll == true){
				        		$scope.disablePurchaseBook = false;
				        		list.checkSelectedStudent = $scope.selectedAll;
				        	}
				        });
			        }
			    };
			    // Add Reset Functionality
			    $scope.checkSelected =function(){
			        var flag = true;
			    	for(var i=0;i<$scope.mainList.length;i++){
			    		if($scope.mainList[i].checkSelectedStudent)
			    		{
				    		$scope.disablePurchaseBook = false;
				    		flag = false;
			    		}
			    	}
			    	if(flag==true)
			    		$scope.disablePurchaseBook = true;
			    }
			
			    
			    $scope.openResetPurchaseBook = function(){
					$scope.alertTitle = "Reset Purchase Book";
					$scope.alertMessage = "Do you want to reset All Purchase Book ?";
					$('#AlertMessage').modal("show"); 
				}
			    
			    $scope.resetPurchaseBook = function(){
			    	$scope.selectedAll = false;
			    	var url = "StudentController?action=resetPurchaseBookStudent";
					var req = $http({
						headers : {
							"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
						},
						datatype : 'text',
						method : 'post',
						url : url
					});
					req.success(function(response){
						$scope.init();
						$('#AlertMessage').modal("hide"); 
					});
					$('#AlertMessage').modal("hide"); 
			    }
			});
</script>

<!-- Hardik Code End -->

	<div ng-app="PurchaseBookApp" class="container-fluid" ng-controller="PurchaseBookController" ng-init="init()">
		
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
	                                    <li>
	                                        <a href="book.jsp">Books</a> <span class="divider">/</span>	
	                                    </li>
	                                    <li>
	                                        <a href="bookset.jsp">Book Set</a> <span class="divider">/</span>	
	                                    </li>
	                                    <li class="active">Purchase Book</li>
	                                </ul>
                            	</div>
                        	</div>
                    	</div>
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">Purchase Book</div>
							<div class="pull-right"><button class="btn btn-warning btn-mini" ng-click="openResetPurchaseBook()" style="margin-top:0px;">Reset</button></div>
						</div>

						<div class="block-content collapse in">
							<div class="span12">
								<div class="pull-left">
									<div class="form-group">

										<label for="isbnno">Standard</label> <select
											class="form-control"
											ng-options="standard.standardName for standard in standardList"
											ng-model="selectedStandard" ng-change="displayStudentData()"></select>
									</div>
								</div>
								<div class="pull-left">
									<div class="form-group" style="margin-left: 30px;">
										<label for="booksetname">Book Set Name</label> <label class="btn tooltip-bottom" data-original-title="{{ displayBookName }}"
											ng-bind="bookSet.name"
											style="border-style: solid; padding-left: 25px; padding-right: 25px; padding-top: 1px; padding-bottom: 2px; border-color: gainsboro; border-radius: 5px; background-color: gainsboro;"></label>

									</div>
								</div>
								<div class="pull-right">
									<div class="form-group">

										 <input type="text" class="span6 m-wrap h30" placeholder="Search for..." ng-model="searchStudent" style="margin-top: 35px;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;border-top-left-radius: 5px;border-top-right-radius: 5px;width:190px;">
										<button type="button" class="btn btn-success"
											ng-disabled="disablePurchaseBook" ng-click="buyBook()"
											style="margin-top: 25px;">Buy</button>
									</div>
								</div>

								<div class="clearfix"></div>
							</div>
							<div>

								<table class="table table-bordered table-hover">
									<thead>
										<tr class="info">
											<th style="text-align: center; width: 50px"><input
												type="checkbox" ng-model="selectedAll" ng-click="checkAll()">
											<th style="width: 100px;">Gr No</th>
											<th style="width: 150px;">First Name</th>
											<th style="width: 150px;">Last Name</th>
											<th style="width: 150px;">Date Of Birth</th>
											<th style="width: 250px;">Email</th>
											<th style="width: 150px;">Mobile No</th>
											<th style="width: 100px;">Gender</th>
											<th>Buy</th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="x in mainList | filter:searchStudent">
											<td style="text-align: center;"><input type="checkbox"
												ng-disabled="x.studentList.purchaseBook == 1"
												ng-model="x.checkSelectedStudent"
												ng-click="checkSelected(x.checkSelectedStudent)"></td>
											<td><span ng-bind="x.studentList.grNo"></span></td>
											<td><span ng-bind="x.personList.firstName"></span></td>
											<td><span ng-bind="x.personList.lastName"></span></td>
											<td><span ng-bind="x.personList.dob"></span></td>
											<td><span ng-bind="x.personList.email"></span></td>
											<td><span ng-bind="x.personList.mobileNo"></span></td>
											<td><span ng-bind="x.personList.gender"></span></td>
											<td><i ng-show="x.studentList.purchaseBook == 0" title="Not Yet Buy" class="icon-thumbs-down"></i><i ng-show="x.studentList.purchaseBook == 1" title="Buy" class="icon-thumbs-up"></i></td>
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
			$('.tooltip-bottom').tooltip({ placement: 'bottom' });
			$('.chart').easyPieChart({
				animate : 1000
			});
		});
	</script>
</body>

</html>