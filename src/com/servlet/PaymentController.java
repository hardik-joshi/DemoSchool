package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PaymentDao;
import com.model.Payment;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class PaymentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PaymentDao paymentDao;

	public PaymentController() {
		paymentDao = new PaymentDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<Payment> paymentList = new ArrayList<Payment>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from Student Table
					paymentList = paymentDao.getAllPayments();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(paymentList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : "+ e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update")) {
				System.out.println("---------------------------------");
				System.out.println("Called payment");
				System.out.println("---------------------------------");
				Payment payment = new Payment();
				if (request.getParameter("paymentId") != null) {
					int paymentId = Integer.parseInt(request.getParameter("paymentId"));
					payment.setPaymentId(paymentId);
				}
				
				if (request.getParameter("paymentDate") != null) {
					String paymentDate = request.getParameter("paymentDate");
					payment.setPaymentDate(paymentDate);
				}

				if (request.getParameter("description") != null) {
					String description = request.getParameter("description");
					payment.setDescription(description);
				}

				if (request.getParameter("amount") != null) {
					int amount = Integer.parseInt(request.getParameter("amount"));
					payment.setAmount(amount);
				}

				if (request.getParameter("studentId") != null) {
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					payment.setStudentId(studentId);
				}
				
				if (request.getParameter("sequenceNo") != null) {
					int sequenceNo = Integer.parseInt(request.getParameter("sequenceNo"));
					payment.setSequenceNo(sequenceNo);
				}

				try {
					if (action.equals("create")) {
						// Create new record
						paymentDao.addPayment(payment);
						
						// Fetch Data from Student Table
						paymentList = paymentDao.getAllPayments();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(paymentList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						// Update existing record
						paymentDao.updatePayment(payment);
						// Fetch Data from Student Table
						paymentList = paymentDao.getAllPayments();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(paymentList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message:"
							+ e.getMessage();
					response.getWriter().print(error);
				}

			} else if (action.equals("delete")) {
				try {
					// Delete record
					if (request.getParameter("paymentId") != null) {
						int paymentId = Integer.parseInt(request.getParameter("paymentId"));
						paymentDao.deletePayment(paymentId);
						
						paymentList = paymentDao.getAllPayments();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(paymentList);
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}else if(action.equals("getPaymentFromDate")){
				try{
					if(request.getParameter("toDate") != null && request.getParameter("fromDate") != null && request.getParameter("studentId") != null){
						String toDate = request.getParameter("toDate");
						String fromDate = request.getParameter("fromDate");
						int studentId = Integer.parseInt(request.getParameter("studentId"));
						paymentList = PaymentDao.getPaymentsFromDate(toDate,fromDate,studentId);
						String jsonArray = gson.toJson(paymentList);
						response.getWriter().print(jsonArray);
					}
				} catch(Exception e){
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}else if(action.equals("AllPayments")){
				if(request.getParameter("studentId") != null){
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					paymentList = PaymentDao.getPaymentsFromStudentId(studentId);
					String jsonArray = gson.toJson(paymentList);
					response.getWriter().print(jsonArray);
				}
			} else if(action.equals("currentPayments")){
				if(request.getParameter("studentId") != null){
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					paymentList = PaymentDao.getCurrentPayments(studentId);
					String jsonArray = gson.toJson(paymentList);
					response.getWriter().print(jsonArray);
				}
			} else if(action.equals("generatePaymentFromStatement")){
				if(request.getParameter("startDate") != null && request.getParameter("studentId") != null){
					String startDate = request.getParameter("startDate");
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					int totalPaymentAmount = PaymentDao.getSpecificPaymentsFromStatementId(studentId,startDate);
					String jsonArray = gson.toJson(totalPaymentAmount);
					response.getWriter().print(jsonArray);
				}
			}
		}
	}
}
