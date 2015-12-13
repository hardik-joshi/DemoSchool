package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.ChargeDao;
import com.model.Charge;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class ChargeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ChargeDao chargeDao;

	public ChargeController() {
		chargeDao = new ChargeDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<Charge> chargeList = new ArrayList<Charge>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from Student Table
					chargeList = chargeDao.getAllCharges();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(chargeList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : "+ e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update") || action.equals("createUpdateInOutstanding")) {
				System.out.println("---------------------------------");
				System.out.println("Called charge");
				System.out.println("---------------------------------");
				Charge charge = new Charge();
				if (request.getParameter("chargeId") != null) {
					int chargeId = Integer.parseInt(request.getParameter("chargeId"));
					charge.setChargeId(chargeId);
				}
				
				if (request.getParameter("chargeDate") != null) {
					String chargeDate = request.getParameter("chargeDate");
					charge.setChargeDate(chargeDate);
				}

				if (request.getParameter("description") != null) {
					String description = request.getParameter("description");
					charge.setDescription(description);
				}

				if (request.getParameter("amount") != null) {
					int amount = Integer.parseInt(request.getParameter("amount"));
					charge.setAmount(amount);
				}

				if (request.getParameter("studentId") != null) {
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					charge.setStudentId(studentId);
				}
				
				if (request.getParameter("sequenceNo") != null) {
					int sequenceNo = Integer.parseInt(request.getParameter("sequenceNo"));
					charge.setSequenceNo(sequenceNo);
				}

				try {
					if (action.equals("create")) {
						// Create new record
						chargeDao.addCharge(charge);
						
						// Fetch Data from Student Table
						chargeList = chargeDao.getAllCharges();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(chargeList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						// Update existing record
						chargeDao.updateCharge(charge);
						// Fetch Data from Student Table
						chargeList = chargeDao.getAllCharges();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(chargeList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if(action.equals("createUpdateInOutstanding")){
						System.out.println("createUpdateInOutstanding");
						chargeDao.addChargeUpdateOutstanding(charge);
						String jsonArray = gson.toJson("Success");
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
					if (request.getParameter("chargeId") != null) {
						int chargeId = Integer.parseInt(request.getParameter("chargeId"));
						chargeDao.deleteCharge(chargeId);
						
						chargeList = chargeDao.getAllCharges();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(chargeList);
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			} else if(action.equals("getChargeFromDate")){
				try{
					if(request.getParameter("toDate") != null && request.getParameter("fromDate") != null && request.getParameter("studentId") != null){
						String toDate = request.getParameter("toDate");
						String fromDate = request.getParameter("fromDate");
						int studentId = Integer.parseInt(request.getParameter("studentId"));
						chargeList = ChargeDao.getChargesFromDate(toDate,fromDate,studentId);
						String jsonArray = gson.toJson(chargeList);
						response.getWriter().print(jsonArray);
					}
				} catch(Exception e){
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			} else if(action.equals("AllCharges")){
				if(request.getParameter("studentId") != null){
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					chargeList = ChargeDao.getChargesFromStudentId(studentId);
					String jsonArray = gson.toJson(chargeList);
					response.getWriter().print(jsonArray);
				}
			} else if(action.equals("currentCharges")){
				if(request.getParameter("studentId") != null){
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					chargeList = ChargeDao.getCurrentCharges(studentId);
					String jsonArray = gson.toJson(chargeList);
					response.getWriter().print(jsonArray);
				}
			} else if(action.equals("generateChargeFromStatement")){
				if(request.getParameter("startDate") != null && request.getParameter("studentId") != null){
					String startDate = request.getParameter("startDate");
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					int totalChargeAmount = ChargeDao.getSpecificChargesFromStatementId(studentId,startDate);
					String jsonArray = gson.toJson(totalChargeAmount);
					response.getWriter().print(jsonArray);
				}
			}
		}
	}
}
