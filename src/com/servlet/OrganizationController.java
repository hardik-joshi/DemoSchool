package com.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.dao.OrganizationDao;
import com.dao.PersonDao;
import com.google.gson.Gson;
import com.model.Organization;
import com.model.OrganizationType;
import com.model.Person;

@WebServlet("/Organization")
public class OrganizationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	   String readJson(HttpServletRequest request){
	    	
	    	 StringBuffer sb = new StringBuffer();
	    	 try {
	             
	 			BufferedReader reader = request.getReader();
	 			String line = null;
	  
	 			while ((line = reader.readLine()) != null){
	 				sb.append(line);
	 			}
	    	 }
	 			catch (Exception e) {  }
	  
	    	return new String(sb);
	    }
	
   
    public OrganizationController() {
        super();
 
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Gson gson = new Gson();
		String action = request.getParameter("action");
		
		if(action != null){
			if(action.equals("listtypes")){
				OrganizationDao organizationDao = new OrganizationDao();
				
				List<OrganizationType> orgTypes = organizationDao.getOrganizationTypes();
				
				String jsonArray = gson.toJson(orgTypes);
				response.getWriter().print(jsonArray);
			}
			
			
			else if (action.equals("listpersonsbyType")){
				
				int organizationTypeId = Integer.parseInt(request.getParameter("organizationTypeId"));
				OrganizationDao organizationDao = new OrganizationDao();
				List<Organization> orgs = organizationDao.getOrganizationByType(organizationTypeId);
				List<Person> persons = new ArrayList<Person>();
				for(int i = 0 ; i<orgs.size(); i++){
					persons.addAll(organizationDao.getOrganizationPersons(orgs.get(i).getOrganizationId()));
				}
				
				String json = gson.toJson(persons);	

        		response.setContentType("application/json"); 
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(json);
			}
			
			else if (action.equals("updateperson")){
				String json = readJson(request);
				System.out.println(json);
				
				Person p = gson.fromJson(json, Person.class);
				PersonDao personDao = new PersonDao();
				personDao.updatePerson1(p);
				
			}
			
			else if (action.equals("updateorganization")){
				String json = readJson(request);
				System.out.println(json);
				Organization o = gson.fromJson(json, Organization.class);
				OrganizationDao organizationDao = new OrganizationDao();
				organizationDao.updateOrganization(o);
			}
			
			else if(action.equals("addperson")){
				
				int organizationId = Integer.parseInt(request.getParameter("organizationId"));
				
				String json = readJson(request);
				System.out.println(json);
				
				Person p = gson.fromJson(json, Person.class);
				System.out.println(p.getOccupation());
				
				PersonDao personDao = new PersonDao();
				int personId = personDao.addPerson(p);
				OrganizationDao organizationDao = new OrganizationDao();
				if(personId!=-1){
					
					organizationDao.enterOrganizationContact(organizationId, personId);
				}
				
				Organization o = organizationDao.getOrganizationById(organizationId);
				
				List<Person> persons = organizationDao.getOrganizationPersons(organizationId); 
				
				json = gson.toJson(persons);	
        		response.setContentType("application/json"); 
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(json);
				
				
			}
			
			else if (action.equals("listpersons")){
				
				int organizationId = Integer.parseInt(request.getParameter("organizationId"));
				
				System.out.println(organizationId);
				
				OrganizationDao organizationDao = new OrganizationDao();
				Organization o = organizationDao.getOrganizationById(organizationId);
				
				List<Person> persons = organizationDao.getOrganizationPersons(organizationId); 
				
				String json = gson.toJson(persons);	
        		response.setContentType("application/json"); 
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(json);
			}
			
			else if(action.equals("listorganizations")){
				OrganizationDao organizationDao = new OrganizationDao();
				List<Organization> orgs = organizationDao.getAllOrganizations();
				
				String json = gson.toJson(orgs);
				response.setContentType("application/json");
				response.setCharacterEncoding("utf-8");
				response.getWriter().print(json);
			}
			
			else if (action.equals("deleteorganization")){
				int organizationId = Integer.parseInt(request.getParameter("organizationId"));
			}
			
			else if (action.equals("deleteperson")){
				int personId = Integer.parseInt(request.getParameter("personId")) ;
				
				OrganizationDao organizationDao = new OrganizationDao();
				organizationDao.removeOrganizationContact(personId);
				
				
				
				int organizationId = Integer.parseInt(request.getParameter("organizationId"));
				
				//OrganizationDao organizationDao = new OrganizationDao();
				Organization o = organizationDao.getOrganizationById(organizationId);
				
				List<Person> persons = organizationDao.getOrganizationPersons(organizationId); 
				
				String json = gson.toJson(persons);	
        		response.setContentType("application/json"); 
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(json);
			}
			else if (action.equals("create")){
				
				String json = readJson(request);
				System.out.println(json);
				List<Integer> personIds = new ArrayList<Integer>();
				JSONObject jo;
				try {
					jo = new JSONObject(json);
					JSONArray joPersons = jo.getJSONArray("persons");
		        	JSONObject joOrganization = jo.getJSONObject("organization");
		        	
		        	
		        	for(int i=0; i<joPersons.length(); i++){
		        		
		        		System.out.println("Inserting person " + i);
		        		JSONObject joPerson = joPersons.getJSONObject(i);
		        		Person p = gson.fromJson(joPerson.toString(), Person.class);
		        		System.out.println(p.getFirstName());
		        		PersonDao personDao = new PersonDao();
		        		int personId = personDao.addPerson(p);
		        		System.out.println("successfully added");
		        		if(personId != -1){
		        			personIds.add(personId);
		        		}
		        		else{
		        			System.out.println("Could not Insert Person Contact");
		        		}
		        			
		        	}
		        	Organization org = gson.fromJson(joOrganization.toString(), Organization.class);
		        	System.out.println(org.getName());
		        	OrganizationDao orgDao = new OrganizationDao();
		        	int orgId = orgDao.enterOrganization(org);
		        	
		        	for (int i=0; i<personIds.size(); i++){
		        		orgDao.enterOrganizationContact(orgId, personIds.get(i));
		        	}
				} 
				catch (JSONException e) {
					
					e.printStackTrace();
				}
				catch (Exception e){
					e.printStackTrace();
				}
	        	
				
			}
		}
		
	}

}
