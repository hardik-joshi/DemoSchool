package com.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import com.dao.LoginDao;
import com.dao.StudentDao;
import com.utils.ProjectUtils;

import com.utils.*;
public class LoginController extends HttpServlet {
	
	/*
	public void init() throws ServletException {
		StudentDao studentDao = new StudentDao();
		int grNo = studentDao.getMaxGrNo();
		
		getServletContext().setAttribute("grno", grNo);
		
	}
	*/
	
	
	
	private static final long serialVersionUID = 1L;
	RequestDispatcher rd = null;
	LoginDao loginDao = null;
	
		
	
	public LoginController(){
		loginDao = new LoginDao();
	}
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
			String action = request.getParameter("action");
			
			
			if (action != null){
				
				if (action.equals("login")){
					
					//rd = request.getRequestDispatcher("admission.jsp");
					String username = request.getParameter("username");
					//String password = ProjectUtils.SHA256(request.getParameter("password"));
					String password = request.getParameter("password");
					//System.out.println("password = " + password);
					if (loginDao.validateLogin(username, password)){
						HttpSession session = request.getSession();
						session.setAttribute("username",username);
						int userId;
						if(username.equals("admin")){
							userId = 1;
						}
						else{
							userId = 2;
						}
						session.setAttribute("userId", userId);
						response.sendRedirect("index.jsp");
					}
					else {
						//response.getWriter().print("not Correct");
						response.sendRedirect("login.jsp");
					}
					
					
				}
				
				else if (action.equals("resetPassword")){
					String url = request.getParameter("url");
					LoginDao loginDao = new LoginDao();
					String username = loginDao.getUserName(url);
					request.setAttribute("username", username);
					System.out.println("username=" + username);
					
					RequestDispatcher disp = request.getRequestDispatcher("ChangeForgotPassword.jsp"); 
					disp.forward(request, response);
					
					
				}
				
				else if(action.equals("setforgotpassword")){
					String username = request.getParameter("username");
					String password = request.getParameter("password");
					LoginDao loginDao = new LoginDao();
					loginDao.resetPassword(username,password);
					response.sendRedirect("login.jsp");
				}
				else if (action.equals("forgotpassword")){
					
					String username = request.getParameter("username");
					String email = request.getParameter("email");
					ForgotPasswordURL FPURL = new ForgotPasswordURL();
					String url = FPURL.generateRandomString();
					LoginDao loginDao = new LoginDao();
					loginDao.setURL(url,username);
					url = "http://localhost:8080/MenusProject/LoginController?action=resetPassword&url=" + url;
					
					EmailSender.sendMail("Password Reset Link", url, email);
					response.sendRedirect("login.jsp");
				}
				
				
				
				
				else if (action.equals("register")){
					String username = request.getParameter("username");
					String password = request.getParameter("password");
					int userTypeId = 2;
					LoginDao loginDao = new LoginDao();
					loginDao.createUser(username, password, userTypeId);
					
					response.sendRedirect("login.jsp");
				}
				
				else if (action.equals("changepassword")){
					String username = (String) request.getSession().getAttribute("username");
					String oldpassword = request.getParameter("oldpassword");
					String newpassword = request.getParameter("password");
					LoginDao loginDao = new LoginDao();
					loginDao.changePassword(username, oldpassword, newpassword);
					response.sendRedirect("index.jsp");
				}
			}
		
	}
}
