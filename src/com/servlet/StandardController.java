package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.StandardDao;
import com.model.Standard;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class StandardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StandardDao standardDao;

	public StandardController() {
		standardDao = new StandardDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<Standard> standardList = new ArrayList<Standard>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from Student Table
					standardList = standardDao.getAllStandards();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(standardList);

					// Return Json in the format required by jTable plugin

					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : " + e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update")) {
				Standard standard = new Standard();
				if (request.getParameter("standardId") != null) {
					int standardId = Integer.parseInt(request
							.getParameter("standardid"));
					standard.setStandardId(standardId);
				}

				if (request.getParameter("standardName") != null) {
					String standardName = request.getParameter("standardname");
					standard.setStandardName(standardName);
				}

				try {
					if (action.equals("create")) {
						// Create new record
						standardDao.addStandard(standard);

						// Fetch Data from Student Table
						standardList = standardDao.getAllStandards();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(standardList);
						// Return Json in the format required by jTable plugin

						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						// Update existing record
						standardDao.updateStandard(standard);
						// Convert Java Object to Json
						String json = gson.toJson(standard);

						response.getWriter().print(json);
					}
				} catch (Exception e) {
					String error = "Message:" + e.getMessage();
					response.getWriter().print(error);
				}

			} else if (action.equals("delete")) {
				try {
					// Delete record
					if (request.getParameter("standardId") != null) {
						int standardId = Integer.parseInt(request
								.getParameter("standardid"));
						standardDao.deleteStandard(standardId);
						String jsonData = "Success";
						response.getWriter().print(jsonData);
					}
				} catch (Exception e) {
					String error = "Message :" + e.getMessage();
					response.getWriter().print(error);
				}
			} else if (action.equals("standardId")) {
				try {
					if (request.getParameter("standardId") != null) {
						int standardId = Integer.parseInt(request.getParameter("standardid"));
						Standard standard = (Standard) StandardDao.getStandardThroughId(standardId);
						String json = gson.toJson(standard);

						response.getWriter().print(json);
					}
				} catch (Exception e) {
					String error = "Message :" + e.getMessage();
					response.getWriter().print(error);
				}

			}

		}
	}
}
