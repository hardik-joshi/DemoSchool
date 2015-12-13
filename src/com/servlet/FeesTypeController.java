package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.FeesTypeDao;
import com.model.FeesType;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class FeesTypeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private FeesTypeDao feesTypeDao;

	public FeesTypeController() {
		feesTypeDao = new FeesTypeDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<FeesType> feesTypeList = new ArrayList<FeesType>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from Student Table
					feesTypeList = feesTypeDao.getAllFeesTypes();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(feesTypeList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : "+ e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update")) {
				System.out.println("---------------------------------");
				System.out.println("Called feesType");
				System.out.println("---------------------------------");
				FeesType feesType = new FeesType();
				if (request.getParameter("feesTypeId") != null) {
					int feesTypeId = Integer.parseInt(request.getParameter("feesTypeId"));
					feesType.setFeesTypeId(feesTypeId);
				}
				
				if (request.getParameter("typeName") != null) {
					String typeName = request.getParameter("typeName");
					feesType.setTypeName(typeName);
				}

				if (request.getParameter("duration") != null) {
					String duration = request.getParameter("duration");
					feesType.setDuration(duration);
				}

				if (request.getParameter("amount") != null) {
					int amount = Integer.parseInt(request.getParameter("amount"));
					feesType.setAmount(amount);
				}
				
				if(request.getParameter("standardId") != null){
					int standardId = Integer.parseInt(request.getParameter("standardId"));
					feesType.setStandardId(standardId);
				}
				try {
					if (action.equals("create")) {
						// Create new record
						feesTypeDao.addFeesType(feesType);
						
						// Fetch Data from Student Table
						feesTypeList = feesTypeDao.getFeesTypesFromStandardId(feesType.getStandardId());
						// Convert Java Object to Json
						String jsonArray = gson.toJson(feesTypeList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						System.out.println("----------------------");
						System.out.println("called Update");
						System.out.println("----------------------");
						// Update existing record
						feesTypeDao.updateFeesType(feesType);
						// Fetch Data from Student Table
						feesTypeList = feesTypeDao.getFeesTypesFromStandardId(feesType.getStandardId());
						// Convert Java Object to Json
						String jsonArray = gson.toJson(feesTypeList);
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
					if (request.getParameter("feesTypeId") != null) {
						int feesTypeId = Integer.parseInt(request
								.getParameter("feesTypeId"));
						feesTypeDao.deleteFeesType(feesTypeId);
						
						feesTypeList = feesTypeDao.getAllFeesTypes();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(feesTypeList);
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}
			else if(action.equals("selectedFeesType")){
				try{
					int standardId = 0;
					if(request.getParameter("standardId")!=null){
						standardId = Integer.parseInt(request.getParameter("standardId"));
					}
					
					feesTypeList = feesTypeDao.getFeesTypesFromStandardId(standardId);
					
					String jsonArray = gson.toJson(feesTypeList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
					
				}catch(Exception e){
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}
		}
	}
}
