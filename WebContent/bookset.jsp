<head>
	<title>BookSet Details</title>
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
angular.module("BookSetApp", []).controller("BookSetController",function($scope, $http) {
	$scope.allStandardList = [];
	$scope.bookSetList = "";
	$scope.bookList = "";
	$scope.standardList = [];
	$scope.selectedStandard = "";
	$scope.bookSet = {};
	$scope.selectedBook = [];
	$scope.books = "";
	var standardId = [];
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
			$scope.allStandardList = response;
		});
		
		var url = "BookSetController?action=list";
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
			$scope.bookSetList = response;
			
			// calculate StandardId start
			 var i=0;
			angular.forEach($scope.bookSetList, function(list){
	        	standardId[i++] = list.standardId; 
	        }); 
			// calculate standardId end
		});
		
		//console.log($scope.bookSetList);
	};
	
	$scope.openAddBookSetModal = function() {
			
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
			$scope.standardList = [];
			var temp = response;
			var flag;
			angular.forEach(temp, function(list){
				console.log(list);
				flag = false;
				for(var i=0;i<standardId.length;i++){
					if(standardId[i] == list.standardId){
		        		flag=true;
		        	}
				}
				if(flag == false){
					$scope.standardList.push(list);
				}
	        });
			$scope.selectedStandard = $scope.standardList[0];
			//console.log($scope.standardList);
		});

		var url = "BookController?action=list";
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			$scope.bookList = response;
			for (var i = 0; i < 7; i++) {
				$scope.selectedBook[i] = $scope.bookList[0];
			}
		});
		$('#addBookSetModal').modal("show");
	}
	$scope.saveBookSet = function() {
		//console.log($scope.book);
		$scope.bookSet.standardId = $scope.selectedStandard;
		$scope.bookSet.book1 = $scope.selectedBook[0];
		$scope.bookSet.book2 = $scope.selectedBook[1];
		$scope.bookSet.book3 = $scope.selectedBook[2];
		$scope.bookSet.book4 = $scope.selectedBook[3];
		$scope.bookSet.book5 = $scope.selectedBook[4];
		$scope.bookSet.book6 = $scope.selectedBook[5];
		$scope.bookSet.book7 = $scope.selectedBook[6];

		//console.log($scope.bookSet);
		var url = "BookSetController?action=create&name="
				+ $scope.bookSet.name + "&standardId="
				+ $scope.bookSet.standardId.standardId
				+ "&quantity=" + $scope.bookSet.quantity
				+ "&book1=" + $scope.bookSet.book1.bookId
				+ "&book2=" + $scope.bookSet.book2.bookId
				+ "&book3=" + $scope.bookSet.book3.bookId
				+ "&book4=" + $scope.bookSet.book4.bookId
				+ "&book5=" + $scope.bookSet.book5.bookId
				+ "&book6=" + $scope.bookSet.book6.bookId
				+ "&book7=" + $scope.bookSet.book7.bookId;
		//console.log(url);
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			$scope.bookSet = "";
			$scope.selectedBook = [];
			$scope.bookSetList = response;
			// calculate StandardId start
			var i=0;
			angular.forEach($scope.bookSetList, function(list){
	        	standardId[i++] = list.standardId; 
	        });
			// calculate standardId end
			$('#addBookSetModal').modal("hide");
		});
	}

	$scope.deleteBookSet = function(bookSetId) {
		var url = "BookSetController?action=delete&bookSetId="
				+ bookSetId;
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			//console.log($scope.bookSetList);
			$scope.bookSetList = response;
			// calculate StandardId start
			var i=0;
			angular.forEach($scope.bookSetList, function(list){
	        	standardId[i++] = list.standardId; 
	        });
			// calculate standardId end
		});
	}

	$scope.openUpdateBookSet = function(bookSet) {
		$scope.bookSetUpdate = bookSet;
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
			$scope.standardList = [];
			var temp = response;
			var flag;
			angular.forEach(temp,function(standard, key) {
				//console.log(standard);
				if (standard.standardId == $scope.bookSetUpdate.standardId) {
					$scope.standardList.push(standard);
				}
			}); 
			
			angular.forEach(temp, function(list){
				console.log(list);
				flag = false;
				for(var i=0;i<standardId.length;i++){
					if(standardId[i] == list.standardId){
		        		flag=true;
		        	}
				}
				if(flag == false){
					$scope.standardList.push(list);
				}
	        });
			$scope.selectedStandard = $scope.standardList[0];
			//console.log($scope.standardList);
		});

		var url = "BookController?action=list";
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			$scope.bookList = response;
		});

		var url = "BookSetController?action=custom&bookSetId=" + $scope.bookSetUpdate.bookSetId;
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			$scope.books = response;
			for (var i = 0; i < $scope.books.length; i++) {
				for (var j = 0; j < $scope.bookList.length; j++) {
					if ($scope.books[i].title == $scope.bookList[j].title) {
						$scope.selectedBook[i] = $scope.bookList[j];
					}
				}
			}
			//console.log($scope.selectedBook);

		});

		$('#updateBookSetModal').modal("show");
	}

	$scope.saveUpdateBookSet = function() {
		$scope.bookSetUpdate.standardId = $scope.selectedStandard.standardId;
		alert($scope.bookSetUpdate.standardId);
		//console.log($scope.selectedBook);
		$scope.bookSetUpdate.book1 = $scope.selectedBook[0];
		$scope.bookSetUpdate.book2 = $scope.selectedBook[1];
		$scope.bookSetUpdate.book3 = $scope.selectedBook[2];
		$scope.bookSetUpdate.book4 = $scope.selectedBook[3];
		$scope.bookSetUpdate.book5 = $scope.selectedBook[4];
		$scope.bookSetUpdate.book6 = $scope.selectedBook[5];
		$scope.bookSetUpdate.book7 = $scope.selectedBook[6];
		console.log($scope.bookSetUpdate.book1);
		console.log($scope.bookSetUpdate.book2);

		//console.log($scope.bookSetUpdate);
		var url = "BookSetController?action=update&bookSetId=" + $scope.bookSetUpdate.bookSetId + "&name="
				+ $scope.bookSetUpdate.name 
				+ "&standardId=" + $scope.bookSetUpdate.standardId
				+ "&quantity=" + $scope.bookSetUpdate.quantity
				+ "&book1=" + $scope.bookSetUpdate.book1.bookId
				+ "&book2=" + $scope.bookSetUpdate.book2.bookId
				+ "&book3=" + $scope.bookSetUpdate.book3.bookId
				+ "&book4=" + $scope.bookSetUpdate.book4.bookId
				+ "&book5=" + $scope.bookSetUpdate.book5.bookId
				+ "&book6=" + $scope.bookSetUpdate.book6.bookId
				+ "&book7=" + $scope.bookSetUpdate.book7.bookId;
		//console.log(url);
		alert(url);
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			$scope.bookSetUpdate = "";
			$scope.selectedBook = [];
			$scope.bookSetList = response;
			// calculate StandardId start
			var i=0;
			angular.forEach($scope.bookSetList, function(list){
	        	standardId[i++] = list.standardId; 
	        });
			// calculate standardId end
			$('#updateBookSetModal').modal("hide");
		});
	}
});
</script>

<div ng-app="BookSetApp" ng-controller="BookSetController" ng-init="init()" class="container-fluid">
		
		<!--Add BookSet Modal -->
		<div class="modal fade" id="addBookSetModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel1" aria-hidden="true" style="width: 615px;left: 50% !important;display:none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Add BookSet</h4>
					</div>
					<div class="modal-body" style="max-height: 385px !important;">
						<div class="control-group">
							<label for="name" class="control-label">BookSet Name</label> <input type="text"
								class="span6 m-wrap h30" placeholder="E.g. 101"
								ng-model="bookSet.name">
						</div>
						<div class="control-group">
							<label for="quantity" class="control-label">Standard</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. AngularJS" ng-model="bookSet.quantity"> -->
							<select class="span6 m-wrap h30"
								ng-options="standard.standardName for standard in standardList"
								ng-model="selectedStandard"></select>
						</div>
						<div class="control-group">
							<label for="name" class="control-label">Quantity</label> <input type="text"
								class="span6 m-wrap h30" placeholder="E.g. 101"
								ng-model="bookSet.quantity">
						</div>
						<div class="control-group">
							<label for="book1" class="control-label">Book1</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSet.book1"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[0]"></select>
						</div>
						<div class="control-group">
							<label for="book2" class="control-label">Book2</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSet.book2"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[1]"></select>
						</div>
						<div class="control-group">
							<label for="book3" class="control-label">Book3</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSet.book3"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[2]"></select>
						</div>
						<div class="control-group">
							<label for="book4" class="control-label">Book4</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSet.book4"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[3]"></select>
						</div>
						<div class="control-group">
							<label for="book5" class="control-label">Book5</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSet.book5"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[4]"></select>
						</div>
						<div class="control-group">
							<label for="book6" class="control-label">Book6</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSet.book6"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[5]"></select>
						</div>
						<div class="control-group">
							<label for="book7" class="control-label">Book7</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSet.book7"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[6]"></select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" ng-click="saveBookSet()">Save</button>
						<button type="button" class="btn" data-dismiss="modal">Cancel</button>
					</div>
				</div>
			</div>
		</div>

		<!--Update BookSet Modal -->
		<div class="modal fade" id="updateBookSetModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true" style="width: 615px;left: 50% !important;display:none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Edit BookSet</h4>
					</div>
					<div class="modal-body" style="max-height: 385px !important;">
						<div class="control-group">
							<label for="name" class="control-label">BookSet Name</label> <input type="text"
								class="span6 m-wrap h30" placeholder="E.g. 101"
								ng-model="bookSetUpdate.name">
						</div>
						<div class="control-group">
							<label for="quantity" class="control-label">Standard</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. AngularJS" ng-model="bookSetUpdate.quantity"> -->
							<select class="span6 m-wrap h30"
								ng-options="standard.standardName for standard in standardList"
								ng-model="selectedStandard"></select>
						</div>
						<div class="control-group">
							<label for="name" class="control-label">Quantity</label> <input type="text"
								class="span6 m-wrap h30" placeholder="E.g. 101"
								ng-model="bookSetUpdate.quantity">
						</div>
						<div class="control-group">
							<label for="book1" class="control-label">Book1</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSetUpdate.book1"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[0]"></select>
						</div>
						<div class="control-group">
							<label for="book2" class="control-label">Book2</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSetUpdate.book2"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[1]"></select>
						</div>
						<div class="control-group">
							<label for="book3" class="control-label">Book3</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSetUpdate.book3"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[2]"></select>
						</div>
						<div class="control-group">
							<label for="book4" class="control-label">Book4</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSetUpdate.book4"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[3]"></select>
						</div>
						<div class="control-group">
							<label for="book5" class="control-label">Book5</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSetUpdate.book5"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[4]"></select>
						</div>
						<div class="control-group">
							<label for="book6" class="control-label">Book6</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSetUpdate.book6"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[5]"></select>
						</div>
						<div class="control-group">
							<label for="book7" class="control-label">Book7</label>
							<!-- <input type="text" class="form-control" placeholder="E.g. 400" ng-model="bookSetUpdate.book7"> -->
							<select class="span6 m-wrap h30"
								ng-options="book.title for book in bookList"
								ng-model="selectedBook[6]"></select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" ng-click="saveUpdateBookSet()">Save</button>
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
	                                        <a href="book.jsp">Books</a> <span class="divider">/</span>	
	                                    </li>
	                                    <li class="active">Book Set <span class="divider">/</span>	
	                                    </li>
	                                    <li><a href="purchasebook.jsp">Purchase Book</a></li>
	                                </ul>
                            	</div>
                        	</div>
                    	</div>
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">Book Set Details</div>
						</div>

						<div class="block-content collapse in">
							<div class="span12">
								<div class="pull-right" style="margin-bottom: 10px;">
									
									 <input type="text" class="span6 m-wrap h30" placeholder="Search for..." ng-model="searchBookset" style="margin-top: 10px;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;border-top-left-radius: 5px;border-top-right-radius: 5px;width:190px;">
									<button class="btn btn-success" type="button" ng-click="openAddBookSetModal()"> Add New <i class="icon-plus icon-white"></i>
									</button> 
								</div>
								
							</div>
							<div>

								<table class="table table-bordered table-hover">
									<thead>
										<tr class="info">
											<th>BookSet Name</th>
											<th>Standard</th>
											<th>Total Quantity</th>
											<th>Avail Quantity</th>
											<th>Price</th>
											<th></th>
											<th></th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="x in bookSetList | filter:searchBookset">
											<td><span ng-bind="x.name"></span></td>
											<td><span ng-bind="x.standardId"></span></td>
											<td><span ng-bind="x.quantity"></span></td>
											<td><span ng-bind="x.availQuantity"></span></td>
											<td><span ng-bind="x.price"></span></td>
											<td style="cursor: pointer;text-align:center;"><span class="icon-edit" aria-hidden="true"
												ng-click="openUpdateBookSet(x)" ></span></td>
											<td style="cursor: pointer;text-align:center;"><span class="icon-remove"
												aria-hidden="true" ng-click="deleteBookSet(x.bookSetId)"></span></td>
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