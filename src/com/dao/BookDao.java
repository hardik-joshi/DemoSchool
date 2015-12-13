package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.Book;
import com.model.Standard;
import com.model.Student;

public class BookDao {

	public static Connection dbConnection;
	public PreparedStatement pStmt;

	public BookDao() {
		dbConnection = DBUtility.getConnection();
	}

	public void addBook(Book book) {
		String insertQuery = "INSERT INTO book(isbn, title, "
				+ "publicationyear, price, publication) VALUES (?,?,?,?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setInt(1, book.getIsbn());
			pStmt.setString(2, book.getTitle());
			pStmt.setString(3, book.getPublicationYear());
			pStmt.setInt(4, book.getPrice());
			pStmt.setString(5, book.getPublication());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deleteBook(int bookId) {
		String deleteQuery = "DELETE FROM book WHERE bookid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, bookId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updateBook(Book book) {
		String updateQuery = "UPDATE book SET isbn = ?, title = ?, "
				+ "publicationyear = ?, price = ?, publication = ? WHERE bookid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setInt(1, book.getIsbn());
			pStmt.setString(2, book.getTitle());
			pStmt.setString(3, book.getPublicationYear());
			pStmt.setInt(4, book.getPrice());
			pStmt.setString(5, book.getPublication());
			pStmt.setInt(6, book.getBookId());
			pStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public List<Book> getAllBooks() {
		List<Book> books = new ArrayList<Book>();

		String query = "SELECT * FROM book ORDER BY bookid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Book book = new Book();
				
				book.setBookId(rs.getInt("bookid"));
				book.setIsbn(rs.getInt("isbn"));
				book.setTitle(rs.getString("title"));
				book.setPublicationYear(rs.getString("publicationyear"));
				book.setPrice(rs.getInt("price"));
				book.setPublication(rs.getString("publication"));
				books.add(book);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return books;
	}
	public static Book getBookThroughId(int bookId) {
		Book book = new Book();
		String query = "SELECT * FROM book WHERE bookid=" + bookId;
		Statement stmt=null;
		ResultSet rs=null;
		try 
		{
			System.out.println("stmt1");
			stmt = dbConnection.createStatement();
			System.out.println("stmt2");
			rs = stmt.executeQuery(query);
			
			while (rs.next()) 
			{
				System.out.println("resultSet");
				book.setBookId(rs.getInt("bookid"));
				book.setIsbn(rs.getInt("isbn"));
				book.setTitle(rs.getString("title"));
				book.setPublicationYear(rs.getString("publicationyear"));
				book.setPrice(rs.getInt("price"));
				book.setPublication(rs.getString("publication"));
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("exception");
			System.err.println(e.getMessage());
			System.out.println(e);
		}
		finally
		{
			try 
			{
				rs.close();
				stmt.close();
			} 
			catch (SQLException e) 
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println("inside book through id1 " + bookId);
		return book;
	}
	
	public static List<Book> getBooksFromBookSetId(int bookSetId) {
		List<Book> books = new ArrayList<Book>();
		int[] bookIds = new int[7];
		String query = "SELECT * FROM bookinbookset WHERE booksetid = " + bookSetId;
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			int i=0;
			while (rs.next()) {
				bookIds[i] = rs.getInt("bookid");
				i++;
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		
		for (int i = 0; i < bookIds.length; i++) {
			String query1 = "SELECT * FROM book WHERE bookid=" + bookIds[i];
			try {
				Statement stmt = dbConnection.createStatement();
				ResultSet rs = stmt.executeQuery(query1);
				while (rs.next()) {
					Book book = new Book();

					book.setBookId(rs.getInt("bookid"));
					book.setIsbn(rs.getInt("isbn"));
					book.setTitle(rs.getString("title"));
					book.setPublicationYear(rs.getString("publicationyear"));
					book.setPrice(rs.getInt("price"));
					book.setPublication(rs.getString("publication"));
					books.add(book);
				}
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
		return books;
	}
}