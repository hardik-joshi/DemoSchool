package com.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.StudentDao;
import com.model.Student;
import com.utils.ProjectUtils;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class StudentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private StudentDao studentDao;

	public StudentController() {
		studentDao = new StudentDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<Student> studentList = new ArrayList<Student>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from Student Table
					studentList = studentDao.getAllStudents();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(studentList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : "+ e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update")) {
				System.out.println("---------------------------------");
				System.out.println("Called student");
				System.out.println("---------------------------------");
				Student student = new Student();
				if (request.getParameter("studentId") != null) {
					int studentId = Integer.parseInt(request.getParameter("studentId"));
					student.setStudentId(studentId);
				}
				
				if (request.getParameter("grNo") != null) {
					int grNo = Integer.parseInt(request.getParameter("grNo"));
					student.setGrNo(grNo);
				}

				if (request.getParameter("diseNo") != null) {
					int diseNo = Integer.parseInt(request.getParameter("diseNo"));
					student.setDiseNo(diseNo);
				}
				
				if (request.getParameter("fatherId") != null) {
					int fatherId = Integer.parseInt(request.getParameter("fatherId"));
					student.setFatherId(fatherId);
				}
				
				if (request.getParameter("personId") != null) {
					int personId = Integer.parseInt(request.getParameter("personId"));
					student.setPersonId(personId);
				}
				
				if (request.getParameter("shift") != null) {
					String shift = request.getParameter("shift");
					student.setShift(shift);
				}
				
				if (request.getParameter("board") != null) {
					String board = request.getParameter("board");
					student.setBoard(board);
				}
				
				if (request.getParameter("enrollmentDate") != null) {
					String enrollmentDate = request.getParameter("enrollmentDate");
					student.setEnrollmentDate(enrollmentDate);
				}
				
				if (request.getParameter("leavingDate") != null) {
					String leavingDate = request.getParameter("leavingDate");
					student.setLeavingDate(leavingDate);
				}
				
				if (request.getParameter("standardId") != null) {
					int standardId = Integer.parseInt(request.getParameter("standardId"));
					student.setStandardId(standardId);
				}
				
				if (request.getParameter("motherId") != null) {
					int motherId = Integer.parseInt(request.getParameter("motherId"));
					student.setMotherId(motherId);
				}

				try {
					if (action.equals("create")) {
						// Create new record
						studentDao.addStudent(student);
						
						// Fetch Data from Student Table
						studentList = studentDao.getAllStudents();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(studentList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						// Update existing record
						studentDao.updateStudent(student);
						// Fetch Data from Student Table
						studentList = studentDao.getAllStudents();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(studentList);
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
					if (request.getParameter("studentId") != null) {
						int studentId = Integer.parseInt(request
								.getParameter("studentId"));
						studentDao.deleteStudent(studentId);
						
						studentList = studentDao.getAllStudents();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(studentList);
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}
			else if(action.equals("selectedStudent")){
				try{
					int standardId = 0;
					if(request.getParameter("standardId")!=null){
						standardId = Integer.parseInt(request.getParameter("standardId"));
					}
					System.out.println("standard Id " + standardId);
					studentList = studentDao.getStudentsFromStandardId(standardId);
					
					String jsonArray = gson.toJson(studentList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
					
				}catch(Exception e){
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}
			else if(action.equals("promoteStudent")){
				String tempStudentId = null;
				int standardId = -1; 
				if(request.getParameter("studentId")!=null){
					tempStudentId = request.getParameter("studentId");
					System.out.println(tempStudentId);
				}
				if(request.getParameter("standardId")!=null){
					standardId = Integer.parseInt(request.getParameter("standardId"));
				}
				StringTokenizer st = new StringTokenizer(tempStudentId, ",");
				int len = st.countTokens();
				int[] studentId = new int[len];
				int i=0;
				while (st.hasMoreElements()) {
					 studentId[i] = Integer.parseInt(st.nextElement().toString());
					 System.out.println("studentId" + studentId[i]);
					 i++;
				}
				 
				// Fetch Data from Student Table
				studentDao.promoteStudentThroughStudentId(studentId);
				studentList = studentDao.getStudentsFromStandardId(standardId);
				
				String jsonArray = gson.toJson(studentList);

				// Return Json in the format required by jTable plugin
				
				response.getWriter().print(jsonArray);
			}
			else if(action.equals("demoteStudent")){
				String tempStudentId = null;
				int standardId = -1; 
				if(request.getParameter("studentId")!=null){
					tempStudentId = request.getParameter("studentId");
					System.out.println(tempStudentId);
				}
				if(request.getParameter("standardId")!=null){
					standardId = Integer.parseInt(request.getParameter("standardId"));
				}
				StringTokenizer st = new StringTokenizer(tempStudentId, ",");
				int len = st.countTokens();
				int[] studentId = new int[len];
				int i=0;
				while (st.hasMoreElements()) {
					 studentId[i] = Integer.parseInt(st.nextElement().toString());
					 System.out.println("studentId" + studentId[i]);
					 i++;
				}
				 
				// Fetch Data from Student Table
				studentDao.demoteStudentThroughStudentId(studentId);
				studentList = studentDao.getStudentsFromStandardId(standardId);
				
				String jsonArray = gson.toJson(studentList);

				// Return Json in the format required by jTable plugin
				
				response.getWriter().print(jsonArray);
			}
			else if(action.equals("purchaseBookStudent")){
				String tempStudentId = null;
				int standardId = -1; 
				if(request.getParameter("studentId")!=null){
					tempStudentId = request.getParameter("studentId");
					System.out.println(tempStudentId);
				}
				if(request.getParameter("standardId")!=null){
					standardId = Integer.parseInt(request.getParameter("standardId"));
				}
				StringTokenizer st = new StringTokenizer(tempStudentId, ",");
				int len = st.countTokens();
				int[] studentId = new int[len];
				int i=0;
				while (st.hasMoreElements()) {
					 studentId[i] = Integer.parseInt(st.nextElement().toString());
					 System.out.println("studentId" + studentId[i]);
					 i++;
				}
				 
				// Fetch Data from Student Table
				studentDao.purchaseBookByStudent(studentId,standardId);
				studentList = studentDao.getStudentsFromStandardId(standardId);
				
				String jsonArray = gson.toJson(studentList);

				// Return Json in the format required by jTable plugin
				
				response.getWriter().print(jsonArray);
			}
			else if(action.equals("resetPurchaseBookStudent")){
				// Fetch Data from Student Table
				studentDao.resetPurchaseBook();
				
				
				String jsonArray = gson.toJson("Success");

				// Return Json in the format required by jTable plugin
				
				response.getWriter().print(jsonArray);
			}
			else if(action.equals("getMaxSequenceNo")){
				int studentId = 0;
				if(request.getParameter("studentId")!=null){
					studentId = Integer.parseInt(request.getParameter("studentId"));
					
				}
				System.out.println("studentId :" + studentId);
				try {
					int maxSequenceNo = StudentDao.getMaxSequenceNo(studentId);
					String jsonArray = gson.toJson(maxSequenceNo);
					response.getWriter().print(jsonArray);	
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			} else if(action.equals("updateOutstandingFees")){
				int studentId = 0;
				int outstandingFees = 0;
				
				if(request.getParameter("studentId")!=null){
					studentId = Integer.parseInt(request.getParameter("studentId"));
				}
				
				if(request.getParameter("outstandingFees")!=null){
					outstandingFees = Integer.parseInt(request.getParameter("outstandingFees"));
				}
				
				try{
					StudentDao.updateOutstandingFees(studentId,outstandingFees);
					String jsonArray = gson.toJson("Success");
					response.getWriter().print(jsonArray);	
				}catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}
			else if (action.equals("generateIDCards")){
				
				int classId = Integer.parseInt(request.getParameter("ClassID"));
				System.out.println("classId = " + classId);
				studentList = studentDao.getStudentsFromStandardId(classId);
				String fileName = ProjectUtils.generateIdCards(studentList);
				
				System.out.println(fileName);
				
				System.out.println("Real path =" + getServletContext().getRealPath(""));
				
				
				File pdfFile = new File(fileName);

				response.setContentType("application/pdf");
				response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
				response.setContentLength((int) pdfFile.length());

				FileInputStream fileInputStream = new FileInputStream(pdfFile);
				OutputStream responseOutputStream = response.getOutputStream();
				int bytes;
				while ((bytes = fileInputStream.read()) != -1) {
					responseOutputStream.write(bytes);
				}
				fileInputStream.close();
				
				
				
				//response.setContentType("application/pdf");
				//"Idcard.pdf";
			}
			else if (action.equals("generateIDCard")){
				
				int studentId = Integer.parseInt(request.getParameter("studentId"));
				StudentDao studentDao = new StudentDao();
				Student s = studentDao.getStudentThroughId(studentId);
				List<Student> students = new ArrayList<Student>();
				students.add(s);
				String fileName = ProjectUtils.generateIdCards(students);
				
				
				File pdfFile = new File(fileName);

				response.setContentType("application/pdf");
				response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
				response.setContentLength((int) pdfFile.length());

				FileInputStream fileInputStream = new FileInputStream(pdfFile);
				OutputStream responseOutputStream = response.getOutputStream();
				int bytes;
				while ((bytes = fileInputStream.read()) != -1) {
					responseOutputStream.write(bytes);
				}
				fileInputStream.close();
			}
		}
		
	}
}
