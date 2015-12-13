package com.servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;







import com.dao.TaskDao;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.model.Task;
import com.utils.EmailSender;


public class TaskController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TaskDao taskDao;

	public TaskController() {
		taskDao = new TaskDao();
	}
	
	
	public String readJson(HttpServletRequest request){
	    	
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

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		
		if(action.equals("list")){
			List<Task> tasks = new ArrayList<Task>();
			TaskDao taskDao = new TaskDao();
			tasks = taskDao.getAllTasks();
			
			Gson gson = new Gson();
			String json = gson.toJson(tasks);
			response.setContentType("application/json");
			response.getWriter().print(json);
			//taskDao.get
		}
		
		else if (action.equals("create")){
			
			String json = readJson(request);
			System.out.println(json);
			Gson gson = new Gson();
			Task task = gson.fromJson(json, Task.class);
			TaskDao taskDao = new TaskDao();
			taskDao.addTask(task);
			System.out.println(task.getDateCreated());
		}
				
		else if (action.equals("delete")){
			TaskDao taskDao = new TaskDao();
			taskDao.deleteTask(Integer.parseInt(request.getParameter("taskid")));
		}
					
		else if (action.equals("email")){
				
			EmailSender.sendMail("Hello","This is a demo message", "pavanmehta91@gmail.com");
		}
	}

}