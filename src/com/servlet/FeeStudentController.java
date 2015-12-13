package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.FeeStudentDao;
import com.model.FeeStudent;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class FeeStudentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FeeStudentDao feeStudentDao;

	public FeeStudentController() {
		feeStudentDao = new FeeStudentDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<FeeStudent> feeStudentList = new ArrayList<FeeStudent>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from FeeStudent Table
					feeStudentList = feeStudentDao.getAllFeeStudents();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(feeStudentList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : "+ e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update")) {
				System.out.println("---------------------------------");
				System.out.println("Called FeeStudent");
				System.out.println("---------------------------------");
				FeeStudent feeStudent = new FeeStudent();
				if (request.getParameter("feeStudentId") != null) {
					int feeStudentId = Integer.parseInt(request.getParameter("feeStudentId"));
					feeStudent.setFeeStudentId(feeStudentId);
				}
				
				if (request.getParameter("feeTypeId") != null) {
					int feeTypeId = Integer.parseInt(request.getParameter("feeTypeId"));
					feeStudent.setFeesTypeId(feeTypeId);
				}

				if (request.getParameter("studentId") != null) {
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					feeStudent.setStudentId(studentId);
				}

				if (request.getParameter("paidFrom") != null) {
					String paidFrom = request.getParameter("paidFrom");
					feeStudent.setPaidFrom(paidFrom);
				}
				
				if (request.getParameter("paidTo") != null) {
					String paidTo = request.getParameter("paidTo");
					feeStudent.setPaidFrom(paidTo);
				}
				
				/*if (request.getParameter("enrollmentDate") != null) {
					String enrollmentDate = request.getParameter("enrollmentDate");
					feeStudent.setEnrollmentDate(enrollmentDate);
				}
				
				if (request.getParameter("leavingDate") != null) {
					String leavingDate = request.getParameter("leavingDate");
					feeStudent.setLeavingDate(leavingDate);
				}
				
				if (request.getParameter("standardId") != null) {
					int standardId = Integer.parseInt(request.getParameter("standardId"));
					feeStudent.setStandardId(standardId);
				}
				
				if (request.getParameter("motherId") != null) {
					int motherId = Integer.parseInt(request.getParameter("motherId"));
					feeStudent.setMotherId(motherId);
				}*/

				try {
					if (action.equals("create")) {
						// Create new record
						feeStudentDao.addFeeStudent(feeStudent);
						
						// Fetch Data from FeeStudent Table
						feeStudentList = feeStudentDao.getAllFeeStudents();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(feeStudentList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						// Update existing record
						feeStudentDao.updateFeeStudent(feeStudent);
						// Fetch Data from FeeStudent Table
						feeStudentList = feeStudentDao.getAllFeeStudents();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(feeStudentList);
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
					if (request.getParameter("feeStudentId") != null) {
						int feeStudentId = Integer.parseInt(request
								.getParameter("feeStudentId"));
						feeStudentDao.deleteFeeStudent(feeStudentId);
						
						feeStudentList = feeStudentDao.getAllFeeStudents();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(feeStudentList);
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
