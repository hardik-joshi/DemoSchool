package com.servlet;

import javax.servlet.http.*;

import com.dao.*;
import com.model.*;
import com.google.gson.*;

import org.json.*;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;

public class AdmissionController extends HttpServlet {
   
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public AdmissionController(){
        super();
    }
               
    
    public Student getStudentObject(String json){
    	
    	Student stu = null;
    	try {
            
            JSONObject jo = new JSONObject(json);
        	JSONObject joStud = jo.getJSONObject("student");
        	JSONObject joPerson = jo.getJSONObject("person");
        	JSONObject joMother = jo.getJSONObject("mother");
        	JSONObject joFather = jo.getJSONObject("father");
       
        	Gson gson = new Gson();
        	
        	stu = gson.fromJson(joStud.toString(),Student.class);
        	Person stuPer = gson.fromJson(joPerson.toString(),Person.class);
        	Person mother = gson.fromJson(joMother.toString(), Person.class);
        	Person father = gson.fromJson(joFather.toString(), Person.class);
        	
        
        	int motherId = stu.getPersonId();
        	int fatherId = stu.getFatherId();
        	int personId = stu.getMotherId();
        	
  
        	PersonDao personDao = new PersonDao();
        	
        	
        	/* This means the request is an insert request and not an update request and id of mother,father or person are -1 */
        		if(motherId == -1 || fatherId == -1 || personId == -1){
        		
        			personId = personDao.addPerson(stuPer);
        			System.out.println("added Student Person");
        			motherId = personDao.addPerson(mother);
        			System.out.println("added Mother Person");
        			fatherId = personDao.addPerson(father);
        			System.out.println("added father Person");
        			//System.out.println("INSERTING");
        			
        			stu.setPersonId(personId);
        			stu.setFatherId(fatherId);
        			stu.setMotherId(motherId);
        			
        			//System.out.println("inserted Successfully");
        		
        		}
        	  	/* This means the request is an update request and not an insert request and id of mother,father or person already exist so it needs be updated */
        		else{
        		
        			System.out.println("UPDATING");
        			
        			personDao.updatePerson(stuPer);
        			personDao.updatePerson(mother);
        			personDao.updatePerson(father);
        		}
        	
        	
           }

            catch(Exception e){
                e.printStackTrace();
            }
    		
    	return stu;
    	
    }
    
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
    
    public void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException{
       
    	String action = request.getParameter("action");
 
    	
        if (action != null){
        	if(action.equals("create")|| action.equals("update")){
        		
        		response.setContentType("text/html");
        		String json = readJson(request);
        		
        		System.out.println(json);
        		
        		Student student = getStudentObject(json);
        		
        		StudentDao studentDao = new StudentDao();
        		
        		
        		if(action.equals("create")){
        			
        			
        			
        			DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        			   Date date = new Date();
        			 String enrolDate=  dateFormat.format(date);
        			
        			
        			student.setEnrollmentDate(enrolDate);
        			studentDao.addStudent(student);
        			System.out.println("added student object");
        		}
        		else{
        			studentDao.updateStudent(student);
        		}
        		
        	}
        	else if (action.equals("leave")){
        		
 			   	int studentId = Integer.parseInt(request.getParameter("studentId"));
 			   	StudentDao studentDao = new StudentDao();
 			   	studentDao.leaveSchool(studentId);
 			
        	}
        	else if (action.equals("display")){
        		
        		System.out.println("In Admission Controller Display");
        		
        		int studentId = 0; 
        		//StudentDao studentDao = new StudentDao();
        		try{
        		studentId = Integer.parseInt(request.getParameter("studentId"));
        		System.out.println(studentId);
        		}
        		catch(Exception e){
        			System.out.println("can't get the student Id");
        		}
        		//System.out.println("Student Id=" + studentId);
        		StudentDao studentDao = new StudentDao();
        		Student student = studentDao.getStudentThroughId(studentId);
        		System.out.println("GRNO:" + student.getGrNo());
        		
        		PersonDao personDao = new PersonDao();
        		Person stuPerson = personDao.getPersonThroughId(student.getPersonId());
        		Person mother = personDao.getPersonThroughId(student.getMotherId());
        		Person father = personDao.getPersonThroughId(student.getFatherId());
        		
        		Gson gson = new Gson();
        		
        		String json1 = gson.toJson(student);
        		String json2 = gson.toJson(stuPerson);
        		String json3 = gson.toJson(mother);
        		String json4 = gson.toJson(father);
        		
        		
        		String json = "[" + json1 + "," + json2 + "," + json3 + "," + json4 + "]";
        		
        		
        		json = gson.toJson(json);
        		
        		System.out.println("RETURNED JSON " + json);
        		
        		
        		response.setContentType("application/json"); 
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(json);
        		}
        	
        }
        
        

    }
      
}

