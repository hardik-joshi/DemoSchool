

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

















<link href="css/tasklist.css" rel="stylesheet">

			
		
		
		
	
<div  ng-app="TaskApp"  ng-controller="TaskController"
		ng-init="init()">
				
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		<!--Add Book Modal -->
		<div class="modal fade" id="addtaskModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel1" aria-hidden="true" style="width: 600px;left: 50% !important;display:none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel1">Add Task</h4>
					</div>
					<div class="modal-body" style="max-height: 481px !important;">
						<div class="control-group">
							<label class="control-label">Name<span class="required">*</span></label>
							<div class="controls">
							 <input type="text" class="span6 m-wrap h30" ng-model="task.taskName">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">For Date<span class="required">*</span></label> 
							<div class="controls">
								<input type="text" class="span6 m-wrap h30"  name="title" ng-model="task.forDate">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Task Description<span class="required">*</span></label>
							<!--  -->
							<div class="controls">
								<textarea  class="span6 m-wrap h100"  ng-model="task.taskDescription"> </textarea>
							</div>
						</div>
					</div>
					
					<div class="modal-footer" >
						
  								<button type="button" class="btn btn-primary" ng-click="addTask()">Save</button>
  								<button type="button" class="btn" data-dismiss="modal">Cancel</button>
  				
							
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
<div class="container-fluid">
	<div class="row-fluid">
		<jsp:include page="sidebar.jsp"></jsp:include>

		<!--/span-->
		<div class="span9" id="content">
			<div class="row-fluid">
				<div class="navbar">
					<div class="navbar-inner">
						<ul class="breadcrumb">
							<i class="icon-chevron-left hide-sidebar"><a href='#'
								title="Hide Sidebar" rel='tooltip'>&nbsp;</a></i>
							<i class="icon-chevron-right show-sidebar" style="display: none;"><a
								href='#' title="Show Sidebar" rel='tooltip'>&nbsp;</a></i>
							<li class="active">Dashboard <span class="divider">/</span>
							</li>
							<li><a href="promotion.jsp">Promote Student</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">Task List</div>
						</div>

						<div class="block-content collapse in">
							<div class="span12">
						<div class="pull-right" style="margin-bottom: 10px;">
							<button class="btn btn-success" type="button" ng-click="addModal();"> Add New <i class="icon-plus icon-white"></i>
							</button>
						</div>				
					</div>
					<div>
					 <div class="task-list" id="pending" ng-repeat="x in taskList" style="margin-bottom:20px;">
							<div class="pull-right editbutton">
						  	<!-- <span class="icon-edit" aria-hidden="true" ></span> -->
							<span class="icon-remove" aria-hidden="true" ng-click="remove(x.taskId)"></span>
						</div>
						  <h5><span ng-bind="x.taskName" style="margin-left: 10px;"> </span></h5>
						  <div class="todo-task">
						    <div class="task-header">Task</div>
						    <div class="task-date"><span ng-bind="x.forDate"></span></div>
						    <div class="task-description"><span ng-bind="x.taskDescription"></span></div>
						  </div>
						</div>
					</div> 
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




<script>
angular
.module("TaskApp", [])
.controller(
		"TaskController",
		function($scope, $http) {

			$scope.init = function() {
				
				$scope.task = {};
				
				console.log("<%= session.getAttribute("username") %>");
				
				console.log("<%= session.getAttribute("userId") %>");
				$scope.taskList = {};
				url = "TaskController?action=list";
				
				
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
									
									//console.log(response);
									$scope.taskList = response;
									
									console.log($scope.taskList);
								
								}); 
			}
			
			$scope.editModal = function(task){
				$scope.task = task;
			}
			
			$scope.addModal = function(){
				$("#addtaskModal").modal("show");
			}
			
			$scope.edit = function(){
				
				task = $scope.task;
				url = "TaskController?action=edit&taskid=" + task.taskId;
				var req = $http({
					headers : {
						"Content-Type" : "Content-Type' : 'application/json"
					},
					datatype : 'text',
					method : 'post',
					url : url,
					data : task
				});
				req.success(function(response) {
				
					$scope.init();
				});
			}
			$scope.remove = function(id){
				
				
				url = "TaskController?action=delete&taskid=" + id;
				
				
				
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
								$scope.init();
							});
			}
			
			$scope.addTask = function(){
				
				
				
				
				var today = new Date();
				var dd = today.getDate();
				var mm = today.getMonth()+1; //January is 0!
				var yyyy = today.getFullYear();

				if(dd<10) {
				    dd='0'+dd
				} 

				if(mm<10) {
				    mm='0'+mm
				} 

				today = yyyy + '-' + mm + '-' + dd;
			
				
				
				
				
				
				
				
				
				$scope.task.dateCreated = today;
				console.log($scope.task.dateCreated);
				$scope.task.userId = <%= session.getAttribute("userId") %>
				
				
				
				console.log($scope.task);
				
				
				url = "TaskController?action=create"
					$http(
												{
													method : 'POST',
													url : url,
													headers : {
														"Content-Type" : "Content-Type' : 'application/json"
													},
													data : $scope.task
												})
												.success(
														function(response) {
															$("#addtaskModal").modal("hide");
															$scope.init();
												});
					
			
			
			
			}
		});


</script>















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