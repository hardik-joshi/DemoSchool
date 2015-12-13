package com.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.BookDao;
import com.dao.BookSetDao;
import com.dao.StandardDao;
import com.model.Book;
import com.model.BookSet;
import com.model.BookSetWithBookInfo;
import com.model.Standard;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class BookSetController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookSetDao bookSetDao;

	public BookSetController() throws SQLException {
		bookSetDao = new BookSetDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<BookSet> bookSetList = new ArrayList<BookSet>();
		List<BookSetWithBookInfo> bookSetWithBookInfoList = new ArrayList<BookSetWithBookInfo>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from Student Table
					bookSetList = bookSetDao.getAllBookSets();
					// Convert Java Object to Json
					
					String jsonArray = gson.toJson(bookSetList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : "+ e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update")) {
				BookSet bookSet = new BookSet();
				BookSetWithBookInfo bookSetWithBookInfo = new BookSetWithBookInfo();
				
				if(request.getParameter("bookSetId")!=null){
					int bookSetId = Integer.parseInt(request.getParameter("bookSetId"));
					bookSet.setBookSetId(bookSetId);
					bookSetWithBookInfo.setBookSetId(bookSetId);
				}
				
				if (request.getParameter("name") != null) {
					String name = request.getParameter("name");
					bookSet.setName(name);
				}

				if (request.getParameter("standardId") != null) {
					int standardId = Integer.parseInt(request.getParameter("standardId"));
					bookSet.setStandardId(standardId);
				}
				
				if (request.getParameter("quantity") != null) {
					int quantity = Integer.parseInt(request.getParameter("quantity"));
					bookSet.setQuantity(quantity);
					bookSet.setAvailQuantity(quantity);
				}
				
				int[] bookIds = new int[7];
				
				if (request.getParameter("book1") != null) {
					bookIds[0] = Integer.parseInt(request.getParameter("book1"));
				}
				if (request.getParameter("book2") != null) {
					bookIds[1] = Integer.parseInt(request.getParameter("book2"));
				}
				if (request.getParameter("book3") != null) {
					bookIds[2] = Integer.parseInt(request.getParameter("book3"));
				}
				if (request.getParameter("book4") != null) {
					bookIds[3] = Integer.parseInt(request.getParameter("book4"));
				}
				if (request.getParameter("book5") != null) {
					bookIds[4] = Integer.parseInt(request.getParameter("book5"));
				}
				if (request.getParameter("book6") != null) {
					bookIds[5] = Integer.parseInt(request.getParameter("book6"));
				}
				if (request.getParameter("book7") != null) {
					bookIds[6] = Integer.parseInt(request.getParameter("book7"));
				}
				
				bookSetWithBookInfo.setBooks(bookIds);
				
				System.out.println("---------------------------------");
				System.out.println("booksetid :" + bookSet.getBookSetId());
				System.out.println("name :" + bookSet.getName());
				System.out.println("price :" + bookSet.getPrice());
				System.out.println("quantity :" + bookSet.getQuantity());
				System.out.println("standardid :" + bookSet.getStandardId());
				int[] tempbook = bookSetWithBookInfo.getBooks();
				for(int i=0;i<7;i++){
					System.out.println("Bookkkk :" + tempbook[i]);
				}
				
				System.out.println("function Called update");
				System.out.println("---------------------------------");
				
				try {
					if (action.equals("create")) {
						// Create new record
						
						bookSetDao.addBookSet(bookSet, bookSetWithBookInfo);
						
						// Fetch Data from BookSet Table
						bookSetList = bookSetDao.getAllBookSets();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(bookSetList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						System.out.println("---------------------------------");
						System.out.println("Called update");
						System.out.println("---------------------------------");
						// Update existing record
						bookSetDao.updateBookSet(bookSet, bookSetWithBookInfo);
						
						bookSetList = bookSetDao.getAllBookSets();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(bookSetList);
						
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					System.out.println("---------------------------------");
					System.out.println("Called Exception");
					System.out.println("---------------------------------");
					String error = "Message:"
							+ e.getMessage();
					response.getWriter().print(error);
				}

			} else if (action.equals("delete")) {
				try {
					// Delete record
					if (request.getParameter("bookSetId") != null) {
						int bookSetId = Integer.parseInt(request
								.getParameter("bookSetId"));
						bookSetDao.deleteBookSet(bookSetId);
						//System.out.println("COntroller" + bookSetId);
						bookSetList = bookSetDao.getAllBookSets();
						// Convert Java Object to Json
						
						String jsonArray = gson.toJson(bookSetList);
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			} else if (action.equals("custom")) {
				try {
					
					if (request.getParameter("bookSetId") != null) {
						int bookSetId = Integer.parseInt(request
								.getParameter("bookSetId"));
						
						List<Book> listBook = new ArrayList<Book>();
						listBook = BookSetDao.getBooksForUpdate(bookSetId);
						
						String json = gson.toJson(listBook);

						response.getWriter().print(json);
					}
				} catch (Exception e) {
					String error = "Message :" + e.getMessage();
					response.getWriter().print(error);
				}

			}
			else if (action.equals("selectedBookSet")) {
				try {
					
					if (request.getParameter("standardId") != null) {
						int standardId = Integer.parseInt(request
								.getParameter("standardId"));
						
						BookSet bookSet = BookSetDao.getBookSetFromStandardId(standardId);
						
						String json = gson.toJson(bookSet);

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
