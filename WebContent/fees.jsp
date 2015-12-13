<head>
	<title>Student Billing</title>
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
angular.module("FeesApp", []).controller("FeesController",function($scope, $http,$filter,$timeout) {
	$scope.mainList = [];
	$scope.studentList = [];
	$scope.standardList = [];
	$scope.personList = [];
	$scope.selectedStandard = {};
	$scope.bookSet = {};
	
	$scope.showStudent = false;
	$scope.selectedStudent = [];
	
	$scope.statementList = [];
	$scope.selectedStatement = $scope.statementList[0];
	
	$scope.charge = {};
	
	$scope.payment = {};
	
	$scope.invoice = {};
	
	$scope.sequenceNo = 0;
	$scope.displayTransactions = [];
	
	$scope.statement = {};
	$scope.currentCharge = false;
	$scope.allCharge = false;
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

			var url = "BookSetController?action=selectedBookSet&standardId="+ $scope.selectedStandard.standardId;
			var req = $http({
				headers : {
					"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
				},
				datatype : 'text',
				method : 'post',
				url : url
			});
			req.success(function(response) {
				$scope.bookSet = response;

				var url = "BookController?action=BooksFromBookSet&bookSetId="
						+ $scope.bookSet.bookSetId;
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
					var temp = "";
					angular.forEach($scope.bookList,function(list) {
						temp += list.title + ",";
					});
					$scope.displayBookName = temp.slice(0,temp.length - 1);
				});
			});
			var url = "StudentController?action=selectedStudent&standardId="
					+ $scope.selectedStandard.standardId;
			var req = $http({
				headers : {
					"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
				},
				datatype : 'text',
				method : 'post',
				url : url
			});
			req.success(function(response) {
				$scope.studentList = response;

				$scope.personId = [];
				for (var i = 0; i < $scope.studentList.length; i++) {
					$scope.personId
							.push($scope.studentList[i].personId);
				}
				var url = "PersonController?action=selectedPerson&personId="
						+ $scope.personId;
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
					for (var i = 0; i < $scope.personList.length; i++) {
						$scope.mainList.push({
							personList : $scope.personList[i],
							studentList : $scope.studentList[i]
						});
					}
				});
			});
		});
	};

	$scope.displayStudentData = function() {
		$scope.mainList = [];
		$scope.studentList = [];
		$scope.personList = [];

		var url = "BookSetController?action=selectedBookSet&standardId="
				+ $scope.selectedStandard.standardId;
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
					
					$scope.bookSet = response;
					var url = "BookController?action=BooksFromBookSet&bookSetId="
							+ $scope.bookSet.bookSetId;
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
						var temp = "";
						angular.forEach($scope.bookList,
								function(list) {
									
									temp += list.title
											+ ",";
								});
						$scope.displayBookName = temp
								.slice(0, temp.length - 1);
					});
				});
		var url = "StudentController?action=selectedStudent&standardId="
				+ $scope.selectedStandard.standardId;
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});

		var url = "StudentController?action=selectedStudent&standardId="
				+ $scope.selectedStandard.standardId;
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req
				.success(function(response) {
					$scope.studentList = response;

					$scope.personId = [];
					for (var i = 0; i < $scope.studentList.length; i++) {
						$scope.personId
								.push($scope.studentList[i].personId);
					}
					
					var url = "PersonController?action=selectedPerson&personId="
							+ $scope.personId;
					var req = $http({
						headers : {
							"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
						},
						datatype : 'text',
						method : 'post',
						url : url
					});
					req
							.success(function(response) {
								
								$scope.mainList = [];
								$scope.personList = response;
								for (var i = 0; i < $scope.personList.length; i++) {
									$scope.mainList
											.push({
												personList : $scope.personList[i],
												studentList : $scope.studentList[i],
												checkSelectedStudent : false
											});
								}
							});
				});
	}

	$scope.openStudent = function(list) {
		$scope.selectedStudent = list;
		$scope.showStudent = true;
		
		$scope.initStudent();
	};
	
	$scope.closeStudent = function() {
		var url = "StudentController?action=updateOutstandingFees&studentId=" + $scope.selectedStudent.studentList.studentId + "&outstandingFees=" + $scope.outstandingAmt;
		
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			$scope.showStudent = false;
			$scope.selectedStudent = [];
			$scope.displayStudentData();
		});
	};
	
	$scope.checkAll = function() {
		if ($scope.selectedAll) {
			$scope.disablePurchaseBook = false;
			$scope.selectedAll = true;
		} else {
			$scope.disablePurchaseBook = true;
			$scope.selectedAll = false;
		}
		angular.forEach($scope.mainList, function(list) {
			list.checkSelectedStudent = $scope.selectedAll;
		});
	};

	$scope.checkSelected = function(checkSelectedStudent) {
		if (checkSelectedStudent)
			$scope.disablePurchaseBook = false;
		else
			$scope.disablePurchaseBook = true;
	}
	
	$scope.displayStatementData =function(){
		$scope.currentCharge = false;
		$scope.allCharge = false;
		// Current Charges
		if($scope.selectedStatement.statementId == 1){
			$scope.currentTransactionInfo();
		}
		else if($scope.selectedStatement.statementId == 2){
			// alert("All Chagres");
			$scope.allChargesInfo();
		}
		else{
			// alert("Generated Statement");
			$scope.generateTransactionInfo($scope.selectedStatement.startDate,$scope.selectedStatement.endDate);
		}
	}
	
	$scope.currentTransactionInfo = function(){
		$scope.currentCharge = true;
		var currentAmt = 0;
		var chargeList = [];
		var paymentList = [];
		var invoiceList = [];
		$scope.displayTransactions = [];
		
		var url = "ChargeController?action=currentCharges&studentId=" + $scope.selectedStudent.studentList.studentId;
		
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
			chargeList = response;
			var url = "PaymentController?action=currentPayments&studentId=" + $scope.selectedStudent.studentList.studentId;
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
				paymentList = response;
				var url = "InvoiceController?action=currentInvoices&studentId=" + $scope.selectedStudent.studentList.studentId;
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
					invoiceList = response;
					
					var chargeAmt1 = 0;
					var paymentAmt1 = 0;
					var invoiceAmt1 = 0;
					console.log("dsfsdfsdfsdf");
					angular.forEach(chargeList, function(list) {
						var tempObj = new Object();
						tempObj.id = list.chargeId
						tempObj.date = list.chargeDate;
						tempObj.description = list.description;
						tempObj.amount = list.amount;
						tempObj.studentId = list.studentId;
						tempObj.sequenceNo = list.sequenceNo;
						tempObj.type = "Charge";
						$scope.displayTransactions.push(tempObj);
						chargeAmt1 += parseInt(list.amount); 
					});
					
					angular.forEach(paymentList, function(list) {
						var tempObj = new Object();
						tempObj.id = list.paymentId
						tempObj.date = list.paymentDate;
						tempObj.description = list.description;
						tempObj.amount = "-" + list.amount;;
						tempObj.studentId = list.studentId;
						tempObj.sequenceNo = list.sequenceNo;
						tempObj.type = "Payment";
						$scope.displayTransactions.push(tempObj);
						paymentAmt1 += parseInt(list.amount);
					});
					
					angular.forEach(invoiceList, function(list) {
						var tempObj = new Object();
						tempObj.id = list.invoiceId
						tempObj.date = list.invoiceDate;
						tempObj.description = list.description;
						tempObj.amount = list.amount;
						tempObj.studentId = list.studentId;
						tempObj.sequenceNo = list.sequenceNo;
						tempObj.type = "Invoice";
						$scope.displayTransactions.push(tempObj);
						invoiceAmt1 += parseInt(list.amount);
					});
					
					// TO find total Outstanding Start 
					
					var chargeList1 = [];
					var paymentList1 = [];
					var invoiceList1 = [];
					
					var url = "ChargeController?action=AllCharges&studentId=" + $scope.selectedStudent.studentList.studentId;
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
						chargeList1 = response;
						var url = "PaymentController?action=AllPayments&studentId=" + $scope.selectedStudent.studentList.studentId;
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
							paymentList1 = response;
							var url = "InvoiceController?action=AllInvoices&studentId=" + $scope.selectedStudent.studentList.studentId;
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
								invoiceList1 = response;
								var chargeAmt = 0;
								var paymentAmt = 0;
								var invoiceAmt = 0;
								console.log("dsfsdfsdfsdf");
								angular.forEach(chargeList1, function(list) {
									chargeAmt += parseInt(list.amount); 
								});
								
								angular.forEach(paymentList1, function(list) {
									paymentAmt += parseInt(list.amount);
								});
								
								angular.forEach(invoiceList1, function(list) {
									invoiceAmt += parseInt(list.amount);
								});
								$scope.outstandingAmt = (chargeAmt + invoiceAmt) - paymentAmt;
								// alert($scope.outstandingAmt);
								
								console.log($scope.displayTransactions);
								currentAmt = (chargeAmt1 + invoiceAmt1) - paymentAmt1;
								$scope.openingAmt = $scope.outstandingAmt - currentAmt;
								//alert("Opening : " + $scope.openingAmt + "outstanding :" + $scope.outstandingAmt + "current :" + currentAmt);
							});
						});
					});
					
					// TO find total Outstanding end
				});
			});
		});
	}
	
	$scope.allChargesInfo = function(){
		$scope.allCharge = true;
		var chargeList = [];
		var paymentList = [];
		var invoiceList = [];
		$scope.displayTransactions = [];
		
		var url = "ChargeController?action=AllCharges&studentId=" + $scope.selectedStudent.studentList.studentId;
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
			chargeList = response;
			var url = "PaymentController?action=AllPayments&studentId=" + $scope.selectedStudent.studentList.studentId;
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
				paymentList = response;
				var url = "InvoiceController?action=AllInvoices&studentId=" + $scope.selectedStudent.studentList.studentId;
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
					invoiceList = response;
					var chargeAmt = 0;
					var paymentAmt = 0;
					var invoiceAmt = 0;
					console.log("dsfsdfsdfsdf");
					angular.forEach(chargeList, function(list) {
						var tempObj = new Object();
						tempObj.id = list.chargeId
						tempObj.date = list.chargeDate;
						tempObj.description = list.description;
						tempObj.amount = list.amount;
						tempObj.studentId = list.studentId;
						tempObj.sequenceNo = list.sequenceNo;
						tempObj.type = "Charge";
						$scope.displayTransactions.push(tempObj);
						
						chargeAmt += parseInt(list.amount); 
					});
					
					angular.forEach(paymentList, function(list) {
						var tempObj = new Object();
						tempObj.id = list.paymentId
						tempObj.date = list.paymentDate;
						tempObj.description = list.description;
						tempObj.amount = "-" + list.amount;
						tempObj.studentId = list.studentId;
						tempObj.sequenceNo = list.sequenceNo;
						tempObj.type = "Payment";
						$scope.displayTransactions.push(tempObj);
						
						paymentAmt += parseInt(list.amount);
					});
					
					angular.forEach(invoiceList, function(list) {
						var tempObj = new Object();
						tempObj.id = list.invoiceId
						tempObj.date = list.invoiceDate;
						tempObj.description = list.description;
						tempObj.amount = list.amount;
						tempObj.studentId = list.studentId;
						tempObj.sequenceNo = list.sequenceNo;
						tempObj.type = "Invoice";
						$scope.displayTransactions.push(tempObj);
						
						invoiceAmt += parseInt(list.amount);
					});
					
					console.log($scope.displayTransactions);
					$scope.outstandingAmt = (chargeAmt + invoiceAmt) - paymentAmt;
					// alert($scope.outstandingAmt);
				});
			});
		});
	}
	
	$scope.maxSequenceNo = function(){
		var url = "StudentController?action=getMaxSequenceNo&studentId=" + $scope.selectedStudent.studentList.studentId;
		// alert(url);
		return $.ajax({
			headers: {'Content-Type': 'application/x-www-form-urlencoded'},
	        dataType: "text",
	        method: "POST",
	        url: url,
	        async: false
		});
	}
	
	$scope.initStudent = function(){
		var currentDate = "";
		$scope.statementList = [];
		$scope.selectedStatement = $scope.statementList[0];
		
		$scope.charge = {};
		
		$scope.payment = {};
		
		$scope.invoice = {};
		
		$scope.sequenceNo = 0;
		$scope.displayTransactions = [];
		
		$scope.statement = {};
		$scope.currentCharge = false;
		$scope.allCharge = false;
		
		var url = "StatementController?action=selectedStudent&studentId=" + $scope.selectedStudent.studentList.studentId;
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			$scope.statementList = response;
			if($scope.statementList != null)
				
				$scope.selectedStatement = $scope.statementList[$scope.statementList.length-2];
			
			$scope.currentTransactionInfo();
		});
	}
	
	$scope.openChargeModal =function(){
		$scope.charge.date = $filter('date')(new Date(), "MM/dd/yyyy");
		$('#chargeModal').modal('show');
	}
	
	$scope.saveCharge = function(){
		$scope.maxSequenceNo().then(function(response){
			console.log("In save charge"+response);
			$scope.sequenceNo = parseInt(response);
			$scope.charge.date = $filter('date')(new Date($scope.charge.date),"yyyy-MM-dd");
			var url = "ChargeController?action=create&chargeDate=" + $scope.charge.date + "&description=" + $scope.charge.description + "&amount=" + $scope.charge.amount + "&studentId=" + $scope.selectedStudent.studentList.studentId + "&sequenceNo=" + ($scope.sequenceNo+1);
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
				$scope.currentTransactionInfo();
			});
			$('#chargeModal').modal("hide");
		});
	}
	
	$scope.openPaymentModal =function(){
		$scope.payment.date = $filter('date')(new Date(), "MM/dd/yyyy");
		$('#paymentModal').modal('show');
	}
	
	$scope.savePayment = function(){
		$scope.maxSequenceNo().then(function(response){
			$scope.sequenceNo = parseInt(response);
			$scope.payment.date = $filter('date')(new Date($scope.payment.date),"yyyy-MM-dd");
			var url = "PaymentController?action=create&paymentDate=" + $scope.payment.date + "&description=" + $scope.payment.description + "&amount=" + $scope.payment.amount + "&studentId=" + $scope.selectedStudent.studentList.studentId + "&sequenceNo=" + ($scope.sequenceNo+1);
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
				$scope.currentTransactionInfo();
			});
			$('#paymentModal').modal("hide");
		});
	}
	
	$scope.openInvoiceModal =function(){
		$scope.invoice.date = $filter('date')(new Date(), "MM/dd/yyyy");
		$('#invoiceModal').modal('show');
	}
	
	$scope.saveInvoice = function(){
		$scope.maxSequenceNo().then(function(response){
			$scope.sequenceNo = parseInt(response);
			$scope.invoice.date = $filter('date')(new Date($scope.invoice.date),"yyyy-MM-dd");
			var url = "InvoiceController?action=create&invoiceDate=" + $scope.invoice.date + "&description=" + $scope.invoice.description + "&amount=" + $scope.invoice.amount + "&studentId=" + $scope.selectedStudent.studentList.studentId + "&sequenceNo=" + ($scope.sequenceNo+1);
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
				$scope.currentTransactionInfo();
			});
			$('#invoiceModal').modal("hide");
		});
	}
	
	$scope.generateTransactionInfo = function(toDate,fromDate){
		var chargeList = [];
		var paymentList = [];
		var invoiceList = [];
		$scope.displayTransactions = [];
		
		var url = "ChargeController?action=getChargeFromDate&toDate=" + toDate + "&fromDate=" + fromDate + "&studentId=" + $scope.selectedStudent.studentList.studentId;
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
			console.log(response);
			chargeList = response;
			var url = "PaymentController?action=getPaymentFromDate&toDate=" + toDate + "&fromDate=" + fromDate + "&studentId=" + $scope.selectedStudent.studentList.studentId;
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
				paymentList = response;
				var url = "InvoiceController?action=getInvoiceFromDate&toDate=" + toDate + "&fromDate=" + fromDate + "&studentId=" + $scope.selectedStudent.studentList.studentId;
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
					invoiceList = response;
					
					var chargeAmt = 0;
					var paymentAmt = 0;
					var invoiceAmt = 0;
					console.log("dsfsdfsdfsdf");
					angular.forEach(chargeList, function(list) {
						var tempObj = new Object();
						tempObj.id = list.chargeId
						tempObj.date = list.chargeDate;
						tempObj.description = list.description;
						tempObj.amount = list.amount;
						tempObj.studentId = list.studentId;
						tempObj.sequenceNo = list.sequenceNo;
						tempObj.type = "Charge";
						$scope.displayTransactions.push(tempObj);
						
						chargeAmt += parseInt(list.amount); 
					});
					
					angular.forEach(paymentList, function(list) {
						var tempObj = new Object();
						tempObj.id = list.paymentId
						tempObj.date = list.paymentDate;
						tempObj.description = list.description;
						tempObj.amount = "-" + list.amount;;
						tempObj.studentId = list.studentId;
						tempObj.sequenceNo = list.sequenceNo;
						tempObj.type = "Payment";
						$scope.displayTransactions.push(tempObj);
						
						paymentAmt += parseInt(list.amount); 
					});
					
					angular.forEach(invoiceList, function(list) {
						var tempObj = new Object();
						tempObj.id = list.invoiceId
						tempObj.date = list.invoiceDate;
						tempObj.description = list.description;
						tempObj.amount = list.amount;
						tempObj.studentId = list.studentId;
						tempObj.sequenceNo = list.sequenceNo;
						tempObj.type = "Invoice";
						$scope.displayTransactions.push(tempObj);
						
						invoiceAmt += parseInt(list.amount); 
					});
					
					// Start of Opening Balance Amount Code
					var totalChargeAmount = 0;
					var totalPaymentAmount = 0;
					var totalInvoiceAmount = 0;
					var url = "ChargeController?action=generateChargeFromStatement&studentId=" + $scope.selectedStudent.studentList.studentId + "&startDate=" + $scope.selectedStatement.startDate;
					var req = $http({
						headers : {
							"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
						},
						datatype : 'text',
						method : 'post',
						url : url
					});
					req.success(function(response) {
						console.log("Generate Statement Charges :")
						// alert(response);
						totalChargeAmount = parseInt(response);
						var url = "PaymentController?action=generatePaymentFromStatement&studentId=" + $scope.selectedStudent.studentList.studentId + "&startDate=" + $scope.selectedStatement.startDate;
						var req = $http({
							headers : {
								"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
							},
							datatype : 'text',
							method : 'post',
							url : url
						});
						req.success(function(response) {
							console.log("Generate Statement Payments :")
							console.log(response);
							totalPaymentAmount = parseInt(response);
							var url = "InvoiceController?action=generateInvoiceFromStatement&studentId=" + $scope.selectedStudent.studentList.studentId + "&startDate=" + $scope.selectedStatement.startDate;
							var req = $http({
								headers : {
									"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
								},
								datatype : 'text',
								method : 'post',
								url : url
							});
							req.success(function(response) {
								console.log("Generate Statement Invoices :")
								console.log(response);
								totalInvoicesAmount = parseInt(response);
								$scope.openingGenerateBalance = (totalChargeAmount +  totalInvoicesAmount) - totalPaymentAmount;
								$scope.closingGenerateBalance = ($scope.openingGenerateBalance + chargeAmt + invoiceAmt) - paymentAmt;
							}); 
						}); 
					});
						
					// End of Opening Balance Amount Code
						
					console.log($scope.displayTransactions);
				});
			});
		});
	}
	
	$scope.showStatement = function(){
		$scope.statement.startDate = $filter('date')(new Date(), "MM/dd/yyyy");
		$scope.statement.endDate = $filter('date')(new Date(), "MM/dd/yyyy");
		$scope.statement.statementName = $scope.statement.startDate + " - " + $scope.statement.endDate + " " + $scope.selectedStudent.personList.firstName + " " +$scope.selectedStudent.personList.lastName;
		$('#statementModal').modal('show');
	}
	
	$scope.generateStatement = function(){
		$scope.statement.startDate = $filter('date')(new Date($scope.statement.startDate), "yyyy-MM-dd");
		$scope.statement.endDate = $filter('date')(new Date($scope.statement.endDate), "yyyy-MM-dd");
		if($scope.statement.msg == undefined){
			$scope.statement.msg = "";
		}
		var url = "StatementController?action=create&startDate="+ $scope.statement.startDate + "&endDate=" + $scope.statement.endDate + "&statementName=" + $scope.statement.statementName + "&msg=" + $scope.statement.msg + "&studentId=" + $scope.selectedStudent.studentList.studentId;
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
			$scope.statementList = response;
			$scope.selectedStatement = $scope.statementList[0];
			$scope.currentTransactionInfo();
		});
		$('#statementModal').modal("hide");
	}
	
	$scope.deleteSelectedTransactionInfo = function(list){
		if(list.type == "Charge"){
			var url = "ChargeController?action=delete&chargeId=" + list.id;
			
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
		}
		else if(list.type == "Payment"){
			var url = "PaymentController?action=delete&paymentId=" + list.id;
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
		}
		else if(list.type == "Invoice"){
			var url = "InvoiceController?action=delete&invoiceId=" + list.id;
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
		}
		$scope.currentTransactionInfo();
	}
	
	$scope.deleteStatement = function(){
		var url = "StatementController?action=delete&statementId=" + $scope.selectedStatement.statementId + "&studentId=" + $scope.selectedStudent.studentList.studentId;
		var req = $http({
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"
			},
			datatype : 'text',
			method : 'post',
			url : url
		});
		req.success(function(response) {
			$scope.statementList = response;
			$scope.selectedStatement = $scope.statementList[0];
			$scope.currentTransactionInfo();
		});
	}
	
	$scope.print = function(id){
		//window.print();
		 var html="<html>";
		   html+= document.getElementById(id).innerHTML;
		   html+="</html>";

		   var printWin = window.open('','','left=0,top=0,width=1,height=1,toolbar=0,scrollbars=0,status  =0');
		   printWin.document.write(html);
		   printWin.document.close();
		   printWin.focus();
		   printWin.print();
		   printWin.close();
	}
	// hardik
	$scope.printReceipt = function(x,id){
		$scope.receiptDate = x.date;
		$scope.receiptDescription = x.description;
		$scope.receiptAmount = x.amount;
		
		$timeout(function() {
			$scope.print(id);
	    }, 500);
		
	}
	
	$scope.printInvoice = function(x,id){
		$scope.invoiceDate = x.date;
		$scope.invoiceDescription = x.description;
		$scope.invoiceAmount = x.amount;
		
		$timeout(function() {
			$scope.print(id);
	    }, 500);
		
	}
});
</script>

<!-- Hardik Code End -->

	<div ng-app="FeesApp" class="container-fluid" ng-controller="FeesController" ng-init="init()">
		
		<!--Start of Charge Modal -->
		<div class="modal fade" id="chargeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 600px;left: 50% !important;display:none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Add Charge</h4>
					</div>
					<div class="modal-body" style="max-height: 481px !important;">
						<div class="control-group">
							<label for="isbnno" class="control-label">Charge Date</label>
							<input class="span6 m-wrap h30"  placeholder="" type="text" ng-model="charge.date">
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">Description</label>
							<input type="text" class="span6 m-wrap h30" placeholder="" ng-model="charge.description">
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">Amount</label>
							<input type="text" class="span6 m-wrap h30" placeholder="" ng-model="charge.amount">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" ng-click="saveCharge()" >Save</button>
					</div>
				</div>
			</div>
		</div>
		<!-- End of Charge Modal -->
		
		<!--Start of Payment Modal -->
		<div class="modal fade" id="paymentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 600px;left: 50% !important;display:none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Add Payment</h4>
					</div>
					<div class="modal-body" style="max-height: 481px !important;">
						<div class="control-group">
							<label for="isbnno" class="control-label">Payment Date</label>
							<input class="span6 m-wrap h30" type="text" ng-model="payment.date">
						     
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">Description</label>
							<input type="text" class="span6 m-wrap h30" placeholder="" ng-model="payment.description">
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">Amount</label>
							<input type="text" class="span6 m-wrap h30" placeholder="" ng-model="payment.amount">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" ng-click="savePayment()" >Save</button>
					</div>
				</div>
			</div>
		</div>
		<!-- End of payment Modal -->
		
		<!--Start of Invoice Modal -->
		<div class="modal fade" id="invoiceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 600px;left: 50% !important;display:none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Add Invoice</h4>
					</div>
					<div class="modal-body" style="max-height: 481px !important;">
						<div class="control-group">
							<label for="isbnno" class="control-label">Invoice Date</label>
							<input class="span6 m-wrap h30" type="text" ng-model="invoice.date">
						     
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">Description</label>
							<input type="text" class="span6 m-wrap h30" placeholder="" ng-model="invoice.description">
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">Amount</label>
							<input type="text" class="span6 m-wrap h30" placeholder="" ng-model="invoice.amount">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" ng-click="saveInvoice()" >Save</button>
					</div>
				</div>
			</div>
		</div>
		<!-- End of Invoice Modal -->
		
		<!--Start of Statement Modal -->
		<div class="modal fade" id="statementModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 600px;left: 50% !important;display:none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Generate Statement</h4>
					</div>
					<div class="modal-body" style="max-height: 481px !important;">
						<div class="control-group">
							<label for="isbnno" class="control-label">Start Date</label>
							<input class="span6 m-wrap h30" type="text" ng-model="statement.startDate">
						     
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">End Date</label>
							<input class="span6 m-wrap h30" type="text" ng-model="statement.endDate">
						     
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">Name this statement</label>
							<input type="text" class="span6 m-wrap h30" placeholder="" ng-model="statement.statementName">
						</div>
						<div class="control-group">
							<label for="isbnno" class="control-label">Optional Message</label>
							<input type="text" class="span6 m-wrap h30" placeholder="" ng-model="statement.msg">
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" ng-click="generateStatement()" >Generate Statement</button>
					</div>
				</div>
			</div>
		</div>
		<!-- End of Statement Modal -->
		
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
	                                    <li> <a href="feestype.jsp">
	                                       Standard Charges <span class="divider">/</span>	</a>
	                                    </li>
	                                    <li class="active">
	                                       Student Billing</a>	
	                                    </li>
	                                </ul>
                            	</div>
                        	</div>
                    	</div>
				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">Student Billing</div>
						</div>

						<div class="block-content collapse in">
							<div ng-hide="showStudent">
								<div class="span12">
									<div class="col-sm-3 pull-left">
										<div class="form-group">
					
											<label for="isbnno">Standard</label> <select class="form-control"
												ng-options="standard.standardName for standard in standardList"
												ng-model="selectedStandard" ng-change="displayStudentData()"></select>
										</div>
									</div>
									<div class="col-sm-9 ">
									    <div class="row">
										  <div class="col-sm-5 pull-right" style="margin-top: 27px;">
										    <div class="input-group">
										      <input type="text" class="span6 m-wrap h30" placeholder="Search for..." ng-model="searchStudent" style="border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;border-top-left-radius: 5px;border-top-right-radius: 5px;width:190px;">
										    </div><!-- /input-group -->
										  </div><!-- /.col-lg-6 -->
										</div><!-- /.row -->
									</div>
	
									<div class="clearfix"></div>
								</div>
								<div>
	
									<table class="table table-bordered table-hover">
										<thead>
											<tr class="info">
												<th width="20%">Gr No</th>
												<th width="60%">Name</th>
												<th width="80%">Outstanding</th>
											</tr>
										</thead>
										<tbody>
											<tr ng-repeat="x in mainList | filter:searchStudent" ng-click="openStudent(x)" style="cursor:pointer;">
												<td><span ng-bind="x.studentList.grNo"></span></td>
												<td>{{x.personList.firstName + " " + x.personList.lastName}}</td>
												<td>&#8377; <span ng-bind="x.studentList.outstandingFees"></span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="col-sm-12" ng-show="showStudent">
								<div class="col-sm-12">
									<div class="pull-left">
										<div class="form-group">
											<h1><span ng-bind="selectedStudent.personList.firstName + ' ' + selectedStudent.personList.lastName" style="color:grey;"></span></h1> 
										</div>
									</div>
									<div class="pull-right">
										<div class="form-group" style="margin-top:23px;">
											<button type="button" class="btn btn-danger" ng-click="closeStudent()">Close</button>
										</div>
									</div>
					
									
								</div>
								
								<hr style="width: 100%; color: black; height: 1px; background-color:black;" />
								
								<div class="col-sm-12">
									<div class="pull-left">
										<div class="form-group form-inline">
					
											<label for="isbnno">Statment : </label> <select class="form-control"
												ng-options="statement.statementName for statement in statementList"
												ng-model="selectedStatement" ng-change="displayStatementData()"></select>
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
								<div class="col-sm-12">
									<div class="pull-left">
										<div class="form-group">
											<h3><span ng-if="currentCharge == false && allCharge == false">STATEMENT : </span>
											<span ng-bind="selectedStatement.statementName"></span></h3>
										</div>
									</div>
									
								</div>
								
								<hr style="width: 100%; color: black; height: 1px; background-color:black;" />
								
								<div class="col-sm-12" ng-if="currentCharge == true || allCharge == true">
									<div class="pull-left">
										<div class="form-group" ng-if="currentCharge == true">
											<label for="isbnno">Opening Balance : &#8377; {{ openingAmt }}</label> 
										</div>
										<div class="form-group">
											<label for="isbnno">Outstanding Balance : &#8377; {{ outstandingAmt }}</label> 
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
								
								<div class="col-sm-12" ng-if="currentCharge == false && allCharge == false">
									<div class="pull-left">
										<div class="form-group">
											<label for="isbnno">Date : {{ selectedStatement.startDate + " - " + selectedStatement.endDate }}</label> 
										</div>
										<div class="form-group">
											<label for="isbnno">Opening Balance : &#8377; {{ openingGenerateBalance }}</label> 
										</div>
										<div class="form-group">
											<label for="isbnno">Closing Balance : &#8377; {{ closingGenerateBalance }}</label> 
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
								
								<div class="col-sm-12" ng-if="currentCharge == false && allCharge == false">
									<div class="pull-left">
										<div class="form-group" >
											<button type="button" class="btn btn-primary" ng-click="print('printData');">Print</button>
											<button type="button" class="btn btn-default" ng-click="deleteStatement()">Delete Statement</button>
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
								
								<div class="col-sm-12" ng-if="currentCharge == true">
									<div class="pull-left">
										<div class="form-group" >
											<button type="button" class="btn btn-default" ng-click="openChargeModal()">Add Charge</button>
											<button type="button" class="btn btn-default" ng-click="openPaymentModal()">Add Payment</button>
											<button type="button" class="btn btn-default" ng-click="openInvoiceModal()">Add Invoice</button>
											<button type="button" class="btn btn-default" ng-click="showStatement()">Generate Statement</button>
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
								
								<div class="col-sm-12" style="margin-top:10px;">
									<table class="table table-bordered table-hover">
										<thead>
											<tr class="info">
												<th>Date</th>
												<th>Description</th>
												<th>Amount</th>
												<th ng-if="currentCharge == true">Delete</th>
											</tr>
										</thead>
										<tbody>
											<tr ng-repeat="x in displayTransactions | orderBy:'date'">
												<td><span ng-bind="x.date"></span></td>
												<td><span ng-bind="x.type + ' : ' + x.description"></span><button class="btn btn-default" style="float:right;" ng-if="x.type == 'Invoice'" ng-click="printInvoice(x,'printInvoiceData');">Receipt</button><button class="btn btn-default" style="float:right;" ng-if="x.type == 'Payment'" ng-click="printReceipt(x,'printReceiptData');">Receipt</button></td>
												<!-- <td><span ng-bind="x.description"></span></td> -->
												<td>&#8377; <span ng-bind="x.amount"></span></td>
												<td ng-if="currentCharge == true" align="center"><span class="icon-remove" aria-hidden="true" ng-click="deleteSelectedTransactionInfo(x)" style="cursor:pointer;"></span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<!-- /block -->
					<!-- Print Statement Modal Start -->
					
					<div ng-hide="true" id="printData">
						<table width="604" height="460" border="1">
						  <tr>
						    <td width="164"><img src="design.jpg" width="149" height="100" /></td>
						    <td colspan="2"><h1><strong>National Engish School</strong></h1></td>
						  </tr>
						  <tr>
						    <td colspan="3">Pushpam Building, Kharawala Compound, Isanpur-Vatva Road, Isanpur, Ahmedabad - 382 443.</td>
						  </tr>
						  <tr>
						    <td colspan="2">phone:079-30429522</td>
						    <td width="289">Email:info@nationalenglishschool.in</td>
						  </tr>
						  <tr>
						    <td colspan="3">Date : {{ selectedStatement.startDate + " - " + selectedStatement.endDate }}</td>
						  </tr>
						  <tr>
						    <td colspan="2">Student Name: <span ng-bind="selectedStudent.personList.firstName + ' ' + selectedStudent.personList.lastName"></span></td>
						    <td>STANDARD - <span ng-bind="selectedStudent.studentList.standardId"></span></td>
						  </tr>
						  <tr>
						    <td colspan="3"><center><b>Financial Statement</b></center></td>
						  </tr>
						  <tr>
						    <td colspan="2"><div align="center"><strong>Item</strong></div></td>
						    
						    <td><div align="center"><strong>Amount</strong></div></td>
						  </tr>
						  <tr>
						    <td colspan="2">Opening Balance</td>
						    <td>&#8377; {{ openingGenerateBalance }}</td>
						  </tr>
						  <tr ng-repeat="x in displayTransactions | orderBy:'date'">
								<td colspan="2"><span ng-bind="x.date"></span> - <span ng-bind="x.type + ' : ' + x.description"></span></td>
								<td>&#8377; <span ng-bind="x.amount"></span></td>
							</tr>
						 
						  <tr>
						    <td colspan="2">Ending Balance</td>
						    <td><b>&#8377; {{ closingGenerateBalance }}</b></td>
						  </tr>
						  <tr>
						    <td height="23" colspan="3"><div align="center">Website : www.nationalenglishschool.in</div></td>
						  </tr>
						</table>
					</div>
											
					<!-- Print Statement Modal End -->
					
					<!-- Print Receipt Modal Start -->
					
					<div ng-hide="true" id="printReceiptData">
						<table width="604" height="460" border="1">
						  <tr>
						    <td width="164"><img src="design.jpg" width="149" height="100" /></td>
						    <td colspan="2"><h1><strong>National Engish School</strong></h1></td>
						  </tr>
						  <tr>
						    <td colspan="3">Pushpam Building, Kharawala Compound, Isanpur-Vatva Road, Isanpur, Ahmedabad - 382 443.</td>
						  </tr>
						  <tr>
						    <td colspan="2">phone:079-30429522</td>
						    <td width="289">Email:info@nationalenglishschool.in</td>
						  </tr>
						  <tr>
						    <td colspan="3">Date : {{ receiptDate }}</td>
						  </tr>
						  <tr>
						    <td colspan="2">Student Name: <span ng-bind="selectedStudent.personList.firstName + ' ' + selectedStudent.personList.lastName"></span></td>
						    <td>STANDARD - <span ng-bind="selectedStudent.studentList.standardId"></span></td>
						  </tr>
						  <tr>
						    <td colspan="3"><center><b>Receipt</b></center></td>
						  </tr>
						  <tr>
						    <td colspan="2"><div align="center"><strong>Item</strong></div></td>
						    
						    <td><div align="center"><strong>Amount</strong></div></td>
						  </tr>
						  
						  <tr>
								<td colspan="2"><span ng-bind="receiptDescription"></span></td>
								<td>&#8377; <span ng-bind="receiptAmount"></span></td>
						 </tr>
						 
						  
						  <tr>
						    <td height="23" colspan="3"><div align="center">Website : www.nationalenglishschool.in</div></td>
						  </tr>
						</table>
					</div>
					
					<!-- Print Receipt Modal End -->
					
					<!-- Print Invoice Modal Start -->
					
					<div ng-hide="true" id="printInvoiceData">
						<table width="604" height="460" border="1">
						  <tr>
						    <td width="164"><img src="design.jpg" width="149" height="100" /></td>
						    <td colspan="2"><h1><strong>National Engish School</strong></h1></td>
						  </tr>
						  <tr>
						    <td colspan="3">Pushpam Building, Kharawala Compound, Isanpur-Vatva Road, Isanpur, Ahmedabad - 382 443.</td>
						  </tr>
						  <tr>
						    <td colspan="2">phone:079-30429522</td>
						    <td width="289">Email:info@nationalenglishschool.in</td>
						  </tr>
						  <tr>
						    <td colspan="3">Date : {{ invoiceDate }}</td>
						  </tr>
						  <tr>
						    <td colspan="2">Student Name: <span ng-bind="selectedStudent.personList.firstName + ' ' + selectedStudent.personList.lastName"></span></td>
						    <td>STANDARD - <span ng-bind="selectedStudent.studentList.standardId"></span></td>
						  </tr>
						  <tr>
						    <td colspan="3"><center><b>Invoice</b></center></td>
						  </tr>
						  <tr>
						    <td colspan="2"><div align="center"><strong>Item</strong></div></td>
						    
						    <td><div align="center"><strong>Amount</strong></div></td>
						  </tr>
						  
						  <tr>
								<td colspan="2"><span ng-bind="invoiceDescription"></span></td>
								<td>&#8377; <span ng-bind="invoiceAmount"></span></td>
						 </tr>
						 
						  
						  <tr>
						    <td height="23" colspan="3"><div align="center">Website : www.nationalenglishschool.in</div></td>
						  </tr>
						</table>
					</div>
					
					<!-- Print Invoice Modal End -->
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