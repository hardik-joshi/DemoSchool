
<head>
	<title>Book Details</title>
</head>
<style>
	
	
</style>
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
angular.module("BookApp", []).controller("BookController",function($scope, $http) {
	
	$scope.bookList = "";
	$scope.book = {};
	$scope.selectedPublicationYear = "2015";
	$scope.init = function() {
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
	};
	$scope.openAddBookModal = function() {
		$('#addBookModal').modal("show");
		$scope.book = {};
	}
	$scope.saveBook = function(){
		//console.log($scope.book);
		$scope.book.publicationYear = $scope.selectedPublicationYear;
		var url = "BookController?action=create&isbn=" + $scope.book.isbn + "&title=" + $scope.book.title + "&publicationYear=" + $scope.book.publicationYear + "&price=" + $scope.book.price + "&publication=" + $scope.book.publication;
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			$scope.book = "";
			$scope.bookList = response;
			$('#addBookModal').modal("hide");
		});
	}
	$scope.deleteBook = function(bookId){
		var url = "BookController?action=delete&bookId=" + bookId;
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
	}
	$scope.openUpdateBook = function(book){
		$scope.book = book;
		console.log($scope.book);
		$scope.selectedPublicationYear = $scope.book.publicationYear;
		$('#updateBookModal').modal("show");
	}
	$scope.saveUpdateBook = function(){
		//console.log($scope.book);
		$scope.book.publicationYear = $scope.selectedPublicationYear;
		var url = "BookController?action=update&bookId=" + $scope.book.bookId + "&isbn=" + $scope.book.isbn + "&title=" + $scope.book.title + "&publicationYear=" + $scope.book.publicationYear + "&price=" + $scope.book.price + "&publication=" + $scope.book.publication;
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			$scope.book = "";
			$scope.bookList = response;
			$('#updateBookModal').modal("hide");
		});
	}
});
</script>

<!-- Hardik Code End -->

	<div ng-app="BookApp" class="container-fluid" ng-controller="BookController"
		ng-init="init()">

		<!--Add Book Modal -->
		<div class="modal fade" id="addBookModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel1" aria-hidden="true" style="width: 600px;left: 50% !important;display:none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel1">Add Book</h4>
					</div>
					<div class="modal-body" style="max-height: 481px !important;">
						<div class="control-group">
							<label class="control-label">ISBN<span class="required">*</span></label>
							<div class="controls">
							 <input type="text" class="span6 m-wrap h30" placeholder="E.g. 101" name="isbn" ng-model="book.isbn">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Book Title<span class="required">*</span></label> 
							<div class="controls">
								<input type="text" class="span6 m-wrap h30" placeholder="E.g. AngularJS" name="title" ng-model="book.title">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Publication Year<span class="required">*</span></label>
							<!-- <input type="text" class="control-label" placeholder="E.g. 2005" ng-model="book.publicationYear"> -->
							<div class="controls">
								<select class="span6 m-wrap h30" name="publicationyear" ng-model="selectedPublicationYear">
									<option value="1991">1991</option>
									<option value="1992">1992</option>
									<option value="1993">1993</option>
									<option value="1994">1994</option>
									<option value="1995">1995</option>
									<option value="1996">1996</option>
									<option value="1997">1997</option>
									<option value="1998">1998</option>
									<option value="1999">1999</option>
									<option value="2000">2000</option>
									<option value="2001">2001</option>
									<option value="2002">2002</option>
									<option value="2003">2003</option>
									<option value="2004">2004</option>
									<option value="2005">2005</option>
									<option value="2006">2006</option>
									<option value="2007">2007</option>
									<option value="2008">2008</option>
									<option value="2009">2009</option>
									<option value="2010">2010</option>
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Price<span class="required">*</span></label>
							<div class="controls">
							 <input type="text" class="span6 m-wrap h30" placeholder="E.g. 400" name="price" ng-model="book.price">
							</div>
						</div>
						<div class="control-group">
						
							<label class="control-label">Publication&nbsp;&nbsp;</label> 
							<div class="controls">
								<input type="text" name="publication" class="span6 m-wrap h30" placeholder="E.g. 1" ng-model="book.publication">
							</div>
						</div>
					</div>
					<div class="modal-footer" >
						
  								<button type="button" class="btn btn-primary" ng-click="saveBook()">Save</button>
  								<button type="button" class="btn" data-dismiss="modal">Cancel</button>
  				
							
					</div>
				</div>
			</div>
		</div>
		<!--Update Book Modal -->
		<div class="modal fade" id="updateBookModal" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 600px;left: 50% !important;display:none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel1">Edit Book</h4>
					</div>
					<div class="modal-body" style="max-height: 481px !important;">
						<div class="control-group">
							<label class="control-label">ISBN<span class="required">*</span></label>
							<div class="controls">
							 <input type="text" class="span6 m-wrap h30" placeholder="E.g. 101" name="isbn" ng-model="book.isbn">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Book Title<span class="required">*</span></label> 
							<div class="controls">
								<input type="text" class="span6 m-wrap h30" placeholder="E.g. AngularJS" name="title" ng-model="book.title">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Publication Year<span class="required">*</span></label>
							<!-- <input type="text" class="control-label" placeholder="E.g. 2005" ng-model="book.publicationYear"> -->
							<div class="controls">
								<select class="span6 m-wrap h30" name="publicationyear" ng-model="selectedPublicationYear">
									<option value="1991">1991</option>
									<option value="1992">1992</option>
									<option value="1993">1993</option>
									<option value="1994">1994</option>
									<option value="1995">1995</option>
									<option value="1996">1996</option>
									<option value="1997">1997</option>
									<option value="1998">1998</option>
									<option value="1999">1999</option>
									<option value="2000">2000</option>
									<option value="2001">2001</option>
									<option value="2002">2002</option>
									<option value="2003">2003</option>
									<option value="2004">2004</option>
									<option value="2005">2005</option>
									<option value="2006">2006</option>
									<option value="2007">2007</option>
									<option value="2008">2008</option>
									<option value="2009">2009</option>
									<option value="2010">2010</option>
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">Price<span class="required">*</span></label>
							<div class="controls">
							 <input type="text" class="span6 m-wrap h30" placeholder="E.g. 400" name="price" ng-model="book.price">
							</div>
						</div>
						<div class="control-group">
						
							<label class="control-label">Publication&nbsp;&nbsp;</label> 
							<div class="controls">
								<input type="text" name="publication" class="span6 m-wrap h30" placeholder="E.g. 1" ng-model="book.publication">
							</div>
						</div>
					</div>
					<div class="modal-footer" >
						
  								<button type="button" class="btn btn-primary" ng-click="saveUpdateBook()">Save</button>
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
                                  <li class="active">Books<span class="divider">/</span>	
                                  </li>
                                  <li>
                                      <a href="bookset.jsp">Book Set</a> <span class="divider">/</span>	
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
							<div class="muted pull-left">Book Details</div>
						</div>

						<div class="block-content collapse in">
							<div class="span12">
								<div class="pull-right" style="margin-bottom: 10px;">
									 <input type="text" class="span6 m-wrap h30" placeholder="Search for..." ng-model="searchBook" style="margin-top: 10px;border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;border-top-left-radius: 5px;border-top-right-radius: 5px;width:190px;">
									<button class="btn btn-success" type="button" ng-click="openAddBookModal()"> Add New <i class="icon-plus icon-white"></i>
									</button> 
									
								</div>
								
							</div>
							<div>

								<table class="table table-bordered table-hover">
									<thead>
										<tr class="info">
											<th width="10%">ISBN</th>
											<th width="25%">Book Title</th>
											<th width="20%">Publication Year</th>
											<th width="10%">Price</th>
											<th width="25%">Publication</th>
											<th width="5%"></th>
											<th width="5%"></th>
										</tr>
									</thead>
									<tbody>
										<tr ng-repeat="x in bookList | filter:searchBook">
											<td><span ng-bind="x.isbn"></span></td>
											<td><span ng-bind="x.title"></span></td>
											<td><span ng-bind="x.publicationYear"></span></td>
											<td><span ng-bind="x.price"></span></td>
											<td><span ng-bind="x.publication"></span></td>
											<td style="cursor: pointer;text-align:center;"><span class="icon-edit" aria-hidden="true" ng-click="openUpdateBook(x)" ></span></td>
											<td style="cursor: pointer;text-align:center;"><span class="icon-remove" aria-hidden="true" ng-click="deleteBook(x.bookId)"></span></td>
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
	<script src="assets/scripts.js"></script>
	<script src="vendors/easypiechart/jquery.easy-pie-chart.js"></script>
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