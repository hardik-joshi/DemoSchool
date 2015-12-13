package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.InvoiceDao;
import com.model.Invoice;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class InvoiceController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private InvoiceDao invoiceDao;

	public InvoiceController() {
		invoiceDao = new InvoiceDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<Invoice> invoiceList = new ArrayList<Invoice>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from Student Table
					invoiceList = invoiceDao.getAllInvoices();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(invoiceList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : "+ e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update")) {
				System.out.println("---------------------------------");
				System.out.println("Called invoice");
				System.out.println("---------------------------------");
				Invoice invoice = new Invoice();
				if (request.getParameter("invoiceId") != null) {
					int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
					invoice.setInvoiceId(invoiceId);
				}
				
				if (request.getParameter("invoiceDate") != null) {
					String invoiceDate = request.getParameter("invoiceDate");
					invoice.setInvoiceDate(invoiceDate);
				}

				if (request.getParameter("description") != null) {
					String description = request.getParameter("description");
					invoice.setDescription(description);
				}

				if (request.getParameter("amount") != null) {
					int amount = Integer.parseInt(request.getParameter("amount"));
					invoice.setAmount(amount);
				}

				if (request.getParameter("studentId") != null) {
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					invoice.setStudentId(studentId);
				}

				if (request.getParameter("sequenceNo") != null) {
					int sequenceNo = Integer.parseInt(request.getParameter("sequenceNo"));
					invoice.setSequenceNo(sequenceNo);
				}
				
				try {
					if (action.equals("create")) {
						// Create new record
						invoiceDao.addInvoice(invoice);
						
						// Fetch Data from Student Table
						invoiceList = invoiceDao.getAllInvoices();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(invoiceList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						// Update existing record
						invoiceDao.updateInvoice(invoice);
						// Fetch Data from Student Table
						invoiceList = invoiceDao.getAllInvoices();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(invoiceList);
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
					if (request.getParameter("invoiceId") != null) {
						int invoiceId = Integer.parseInt(request.getParameter("invoiceId"));
						invoiceDao.deleteInvoice(invoiceId);
						
						invoiceList = invoiceDao.getAllInvoices();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(invoiceList);
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}else if(action.equals("getInvoiceFromDate")){
				try{
					if(request.getParameter("toDate") != null && request.getParameter("fromDate") != null && request.getParameter("studentId") != null){
						String toDate = request.getParameter("toDate");
						String fromDate = request.getParameter("fromDate");
						int studentId = Integer.parseInt(request.getParameter("studentId"));
						invoiceList = InvoiceDao.getInvoicesFromDate(toDate,fromDate,studentId);
						String jsonArray = gson.toJson(invoiceList);
						response.getWriter().print(jsonArray);
					}
				} catch(Exception e){
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}else if(action.equals("AllInvoices")){
				if(request.getParameter("studentId") != null){
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					invoiceList = InvoiceDao.getInvoicesFromStudentId(studentId);
					String jsonArray = gson.toJson(invoiceList);
					response.getWriter().print(jsonArray);
				}
			} else if(action.equals("currentInvoices")){
				if(request.getParameter("studentId") != null){
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					invoiceList = InvoiceDao.getCurrentInvoices(studentId);
					String jsonArray = gson.toJson(invoiceList);
					response.getWriter().print(jsonArray);
				}
			} else if(action.equals("generateInvoiceFromStatement")){
				if(request.getParameter("startDate") != null && request.getParameter("studentId") != null){
					String startDate = request.getParameter("startDate");
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					int totalInvoiceAmount = InvoiceDao.getSpecificInvoicesFromStatementId(studentId,startDate);
					String jsonArray = gson.toJson(totalInvoiceAmount);
					response.getWriter().print(jsonArray);
				}
			}
		}
	}
}
