package com.utils;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.security.*;
import java.util.ArrayList;
import java.util.List;

import com.dao.PersonDao;
import com.model.Person;
import com.model.Student;

public class ProjectUtils {

	public static String hashString(String message, String algorithm){
		byte[] hashedBytes = null;
	 
	    try {
	        MessageDigest digest = MessageDigest.getInstance(algorithm);
	        hashedBytes = digest.digest(message.getBytes("UTF-8"));
	        
	        
	    	} 
	    
	    catch (NoSuchAlgorithmException ex) {
	       
	    	} 
	    catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			}
	    
	    return new String(hashedBytes);
	}
	
	public static String generateIdCards(List<Student> students){
		
		System.out.println("in generate ID card");
		System.out.println("Student list size = " + students.size());
		List<Person> persons = new ArrayList<Person>();
		List<Person> mothers = new ArrayList<Person>();
		List<Person> fathers = new ArrayList<Person>();
		for(int i = 0;i<students.size();i++){
			
			Student stud = students.get(i);
			Person p = new PersonDao().getPersonThroughId(stud.getPersonId());
			Person m = new PersonDao().getPersonThroughId(stud.getMotherId());
			Person f = new PersonDao().getPersonThroughId(stud.getFatherId());
			persons.add(p);
			mothers.add(m);
			fathers.add(f);
		}
		 IDCardGenerator IDCardPdf = new IDCardGenerator(persons,students,fathers,mothers);
		/* ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		 URL url = classLoader.getResource("path/folder");
		 localhost:8080/AjaxCurdjTableServlet/StudentController?action=generateIDCards&ClassID=2
		 System.out.println(url.toString());
		 */
		 
		 File f = new File("Idcard.pdf");
		 System.out.println("get path =" + f.getAbsolutePath());
		 IDCardPdf.createPdf("Idcard.pdf");
		 
		 return "Idcard.pdf";
		 //htmlPdf.createPdf(file);
	}
	
	
	public static void generateReceipt(){
		ReceiptGenerator receiptPDF = new ReceiptGenerator();
	}
}
