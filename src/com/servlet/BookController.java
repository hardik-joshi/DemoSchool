package com.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.BookDao;
import com.model.Book;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


public class BookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookDao bookDao;

	public BookController() {
		bookDao = new BookDao();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		List<Book> bookList = new ArrayList<Book>();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		response.setContentType("application/json");

		if (action != null) {
			if (action.equals("list")) {
				try {
					// Fetch Data from Student Table
					bookList = bookDao.getAllBooks();
					// Convert Java Object to Json
					String jsonArray = gson.toJson(bookList);

					// Return Json in the format required by jTable plugin
					
					response.getWriter().print(jsonArray);
				} catch (Exception e) {
					String error = "Message : "+ e.getMessage();
					response.getWriter().print(error);
					System.err.println(e.getMessage());
				}
			} else if (action.equals("create") || action.equals("update")) {
				System.out.println("---------------------------------");
				System.out.println("Called book");
				System.out.println("---------------------------------");
				Book book = new Book();
				if (request.getParameter("bookId") != null) {
					int bookId = Integer.parseInt(request.getParameter("bookId"));
					book.setBookId(bookId);
				}
				
				if (request.getParameter("isbn") != null) {
					int isbn = Integer.parseInt(request.getParameter("isbn"));
					book.setIsbn(isbn);
				}

				if (request.getParameter("title") != null) {
					String title = request.getParameter("title");
					book.setTitle(title);
				}

				if (request.getParameter("publicationYear") != null) {
					String publicationYear = request.getParameter("publicationYear");
					book.setPublicationYear(publicationYear);
				}

				if (request.getParameter("price") != null) {
					int price = Integer.parseInt(request.getParameter("price"));
					book.setPrice(price);
				}
				
				if (request.getParameter("publication") != null) {
					String publication = request.getParameter("publication");
					book.setPublication(publication);
				}

				try {
					if (action.equals("create")) {
						// Create new record
						bookDao.addBook(book);
						
						// Fetch Data from Student Table
						bookList = bookDao.getAllBooks();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(bookList);
						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					} else if (action.equals("update")) {
						// Update existing record
						bookDao.updateBook(book);
						// Fetch Data from Student Table
						bookList = bookDao.getAllBooks();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(bookList);
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
					if (request.getParameter("bookId") != null) {
						int bookId = Integer.parseInt(request
								.getParameter("bookId"));
						bookDao.deleteBook(bookId);
						
						bookList = bookDao.getAllBooks();
						// Convert Java Object to Json
						String jsonArray = gson.toJson(bookList);
						response.getWriter().print(jsonArray);
					}
				} catch (Exception e) {
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}
			else if(action.equals("BooksFromBookSet")){
				try{
					if(request.getParameter("bookSetId") != null){
						int bookSetId = Integer.parseInt(request.getParameter("bookSetId"));
						
						// Fetch Data from Student Table
						bookList = BookDao.getBooksFromBookSetId(bookSetId);
						// Convert Java Object to Json
						String jsonArray = gson.toJson(bookList);

						// Return Json in the format required by jTable plugin
						
						response.getWriter().print(jsonArray);
					}
				}catch(Exception e){
					String error = "Message :"
							+ e.getMessage();
					response.getWriter().print(error);
				}
			}
		}
	}
}
