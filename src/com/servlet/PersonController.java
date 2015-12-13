package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PersonDao;
import com.dao.StudentDao;
import com.model.Person;
import com.model.Student;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class PersonController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PersonDao personDao;

	public PersonController() {
		personDao = new PersonDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<Person> personList = new ArrayList<Person>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from Student Table
					personList = personDao.getAllPersons();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(personList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : "+ e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update")) {
				System.out.println("---------------------------------");
				System.out.println("Called person");
				System.out.println("---------------------------------");
				Person person = new Person();
				if (request.getParameter("personId") != null) {
					int personId = Integer.parseInt(request.getParameter("personId"));
					person.setPersonId(personId);
				}
				
				if (request.getParameter("firstName") != null) {
					String firstName = request.getParameter("firstName");
					person.setFirstName(firstName);
				}

				if (request.getParameter("lastName") != null) {
					String lastName = request.getParameter("lastName");
					person.setLastName(lastName);
				}
				
				if (request.getParameter("dob") != null) {
					String dob = request.getParameter("dob");
					person.setDob(dob);
				}

				if (request.getParameter("email") != null) {
					String email = request.getParameter("email");
					person.setEmail(email);
				}
				
				if (request.getParameter("mobileNo") != null) {
					String mobileNo = request.getParameter("mobileNo");
					person.setMobileNo(mobileNo);
				}
				
				if (request.getParameter("alternateNo") != null) {
					String alternateNo = request.getParameter("alternateNo");
					person.setAlternateNo(alternateNo);
				}
				
				if (request.getParameter("gender") != null) {
					String gender = request.getParameter("gender");
					person.setGender(gender);
				}
				
				if (request.getParameter("homeNo") != null) {
					String homeNo = request.getParameter("homeNo");
					person.setHomeNo(homeNo);
				}
				
				try {
					if (action.equals("create")) {
						// Create new record
						personDao.addPerson(person);
						
						// Fetch Data from Student Table
						personList = personDao.getAllPersons();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(personList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						// Update existing record
						personDao.updatePerson(person);
						// Fetch Data from Student Table
						personList = personDao.getAllPersons();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(personList);
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
					if (request.getParameter("personId") != null) {
						int personId = Integer.parseInt(request
								.getParameter("personId"));
						personDao.deletePerson(personId);
						
						personList = personDao.getAllPersons();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(personList);
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}
			else if(action.equals("selectedPerson")){
				
				String tempPersonId = null;
				 
				if(request.getParameter("personId")!=null){
					tempPersonId = request.getParameter("personId");
					System.out.println(tempPersonId);
				}
				StringTokenizer st = new StringTokenizer(tempPersonId, ",");
				int len = st.countTokens();
				int[] personId = new int[len];
				int i=0;
				while (st.hasMoreElements()) {
					 personId[i] = Integer.parseInt(st.nextElement().toString());
					 System.out.println("personId" + personId[i]);
					 i++;
				}
				 
				// Fetch Data from Student Table
				personList = personDao.getPersonsFromPersonId(personId);
				// Convert Java Object to Json
				String jsonArray = gson.toJson(personList);

				// Return Json in the format required by jTable plugin
				
				response.getWriter().print(jsonArray);
			}
		}
	}
}
