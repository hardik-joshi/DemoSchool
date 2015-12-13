package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.StatementDao;
import com.model.FeesStatement;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class StatementController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StatementDao statementDao;

	public StatementController() {
		statementDao = new StatementDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<FeesStatement> statementList = new ArrayList<FeesStatement>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from Student Table
					statementList = statementDao.getAllStatements();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(statementList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : "+ e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update")) {
				System.out.println("---------------------------------");
				System.out.println("Called statement");
				System.out.println("---------------------------------");
				FeesStatement statement = new FeesStatement();
				if (request.getParameter("statementId") != null) {
					int statementId = Integer.parseInt(request.getParameter("statementId"));
					statement.setStatementId(statementId);
				}
				
				if (request.getParameter("startDate") != null) {
					String startDate = request.getParameter("startDate");
					statement.setStartDate(startDate);
				}

				if (request.getParameter("endDate") != null) {
					String endDate = request.getParameter("endDate");
					statement.setEndDate(endDate);
				}
				
				if (request.getParameter("statementName") != null) {
					String statementName = request.getParameter("statementName");
					statement.setStatementName(statementName);
				}

				if (request.getParameter("msg") != null) {
					String msg = request.getParameter("msg");
					statement.setMsg(msg);
				}

				if (request.getParameter("studentId") != null) {
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					statement.setStudentId(studentId);
				}

				try {
					if (action.equals("create")) {
						// Create new record
						statementDao.addStatement(statement);
						
						// Fetch Data from Student Table
						statementList = statementDao.getStatementThroughStudentId(statement.getStudentId());
						// Convert Java Object to Json
						String jsonArray = gson.toJson(statementList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						// Update existing record
						statementDao.updateStatement(statement);
						// Fetch Data from Student Table
						statementList = statementDao.getStatementThroughStudentId(statement.getStudentId());
						// Convert Java Object to Json
						String jsonArray = gson.toJson(statementList);
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
					if (request.getParameter("statementId") != null && request.getParameter("studentId") != null) {
						int statementId = Integer.parseInt(request.getParameter("statementId"));
						int studentId = Integer.parseInt(request.getParameter("studentId"));
						statementDao.deleteStatement(statementId);
						
						statementList = statementDao.getStatementThroughStudentId(studentId);
						// Convert Java Object to Json
						String jsonArray = gson.toJson(statementList);
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			} else if (action.equals("selectedStudent")){
				try {
					// Selected Student record
					if (request.getParameter("studentId") != null) {
						int studentId = Integer.parseInt(request.getParameter("studentId"));
						statementList = statementDao.getStatementThroughStudentId(studentId);
						// Convert Java Object to Json
						String jsonArray = gson.toJson(statementList);
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}
		}
	}
}
