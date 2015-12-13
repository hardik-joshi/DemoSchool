package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.CityDao;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.model.City;

public class CityController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private CityDao cityDao;
	public CityController(){
		cityDao = new CityDao();
	}
	
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException{
		
		//System.out.println("into cities");
		
		String action = request.getParameter("action");
		List<City> cityList = new ArrayList<City>();
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");
		
		
		if (action != null) {
			if (action.equals("list")) {
				try {
					
					// Fetch Data from Student Table
					cityList = cityDao.getAllCities();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(cityList);
					// Return Json in the format required by jTable plugin

					response.getWriter().print(jsonArray);
					
				} catch (Exception e) {
					String error = "Message : " + e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			}
		}
		
	}
}


