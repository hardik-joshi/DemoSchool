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
import com.model.BookSet;
import com.model.BookSetWithBookInfo;

public class BookSetDao {

	private static Connection dbConnection;
	private PreparedStatement pStmt;

	public BookSetDao() throws SQLException {
		dbConnection = DBUtility.getConnection();
		dbConnection.setAutoCommit(true);
	}

	public void addBookSet(BookSet bookSet,BookSetWithBookInfo bookSetWithBookInfo) {
		int lastBookSetId = 0;
		
		String insertBookSetQuery = "INSERT INTO bookset(name, standardid, "
				+ "quantity, availquantity) VALUES (?,?,?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertBookSetQuery);
			pStmt.setString(1, bookSet.getName());
			pStmt.setInt(2, bookSet.getStandardId());
			pStmt.setInt(3, bookSet.getQuantity());
			pStmt.setInt(4,bookSet.getAvailQuantity());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		
		
		String query = "SELECT MAX(booksetid) as lastbooksetid FROM bookset";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				lastBookSetId = rs.getInt("lastbooksetid");
			}
		}catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		int price = 0;
		int[] books = bookSetWithBookInfo.getBooks();
		for(int i=0;i<7;i++){
			String insertBookInBookSetQuery = "INSERT INTO bookinbookset(booksetid, bookid) VALUES (?,?)";
			try {
				pStmt = dbConnection.prepareStatement(insertBookInBookSetQuery);
				pStmt.setInt(1, lastBookSetId);
				pStmt.setInt(2, books[i]);
				pStmt.executeUpdate();
				//System.out.println("inserted1");
				Book book =(Book) BookDao.getBookThroughId(books[i]);
				//System.out.println("inserted2");
				price += book.getPrice();
			} catch (SQLException e) {
				System.out.println("---------------------------------");
				System.err.println(e.getMessage());
				System.out.println("---------------------------------");
			}
		}
		String updateQuery = "UPDATE bookset SET price = ? WHERE booksetid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setInt(1, price);
			pStmt.setInt(2, lastBookSetId);
			pStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deleteBookSet(int bookSetId) {
		String deleteQuery;
		deleteQuery = "DELETE FROM bookset WHERE booksetid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, bookSetId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		deleteQuery = "DELETE FROM bookinbookset WHERE booksetid = ?";
		try{
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, bookSetId);
			pStmt.executeUpdate();
		}catch(SQLException e){
			System.err.println(e.getMessage());
		}
	}

	public void updateBookSet(BookSet bookSet,BookSetWithBookInfo bookSetWithBookInfo) {
		String deleteQuery = "DELETE FROM bookinbookset WHERE booksetid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1,bookSetWithBookInfo.getBookSetId());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		int price = 0;
		int[] books = bookSetWithBookInfo.getBooks();
		
		for(int i=0;i<7;i++){
			String insertBookInBookSetQuery = "INSERT INTO bookinbookset(booksetid, bookid) VALUES (?,?)";
			try {
				pStmt = dbConnection.prepareStatement(insertBookInBookSetQuery);
				pStmt.setInt(1, bookSet.getBookSetId());
				pStmt.setInt(2, books[i]);
				pStmt.executeUpdate();
				//System.out.println("inserted1");
			Book book =(Book) BookDao.getBookThroughId(books[i]);
			price += book.getPrice();
			}catch(SQLException e){
				System.err.println(e.getMessage());
			}
		} 
		
		String updateQuery = "UPDATE bookset SET name = ?, "
				+ "standardid = ?, quantity = ?, availquantity = ?, price = ? WHERE booksetid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setString(1, bookSet.getName());
			pStmt.setInt(2, bookSet.getStandardId());
			pStmt.setInt(3, bookSet.getQuantity());
			pStmt.setInt(4,bookSet.getAvailQuantity());
			pStmt.setInt(5, price);
			pStmt.setInt(6, bookSet.getBookSetId());
			pStmt.executeUpdate();
			System.out.println(updateQuery);
			
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public List<BookSet> getAllBookSets() {
		List<BookSet> bookSets = new ArrayList<BookSet>();

		String query = "SELECT * FROM bookset ORDER BY booksetid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				BookSet bookSet = new BookSet();

				bookSet.setBookSetId(rs.getInt("booksetid"));
				bookSet.setName(rs.getString("name"));
				bookSet.setStandardId(rs.getInt("standardid"));
				bookSet.setPrice(rs.getInt("price"));
				bookSet.setQuantity(rs.getInt("quantity"));
				bookSet.setAvailQuantity(rs.getInt("availquantity"));
				bookSets.add(bookSet);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return bookSets;
	}
	
	public List<BookSetWithBookInfo> getAllBookInBookSets() {
		List<BookSetWithBookInfo> bookSetWithBookInfos = new ArrayList<BookSetWithBookInfo>();

		String query = "SELECT * FROM bookinbookset ORDER BY booksetid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			int i=0;
			int[] bookId=new int[7]; 
			while (rs.next()) {
				bookId[i++] = rs.getInt("bookid");
				if(i == 7){
					System.out.println("called BookSetWithBook");
					BookSetWithBookInfo bookSetWithBookInfo = new BookSetWithBookInfo();
					bookSetWithBookInfo.setBookSetId(rs.getInt("booksetid"));
					bookSetWithBookInfo.setBooks(bookId);
					bookSetWithBookInfos.add(bookSetWithBookInfo);
					i=0;
				}
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return bookSetWithBookInfos;
	}
	
	public static BookSetWithBookInfo getBookIdFromBookSetId(int bookSetId){
		BookSetWithBookInfo bookSetWithBookInfo = new BookSetWithBookInfo();
		String query = "SELECT * FROM bookinbookset where booksetid = " + bookSetId;
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			int i=0;
			int[] bookId = new int[7];
			while (rs.next()) {
				bookId[i++] = rs.getInt("bookid");
			}
			bookSetWithBookInfo.setBooks(bookId);
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return bookSetWithBookInfo;
	}
	
	public static List<Book> getBooksForUpdate(int bookSetId){
		BookSetWithBookInfo bookSetWithBookInfo = (BookSetWithBookInfo) BookSetDao.getBookIdFromBookSetId(bookSetId);
		int[] bookIds = bookSetWithBookInfo.getBooks();
		//System.out.println("Called Custom" + bookIds.length);
		List<Book> listBook = new ArrayList<Book>();
		for(int i=0;i<bookIds.length;i++)
		{
			//System.out.println("bookIds[i] : "+bookIds[i]);
			Book book = (Book) BookDao.getBookThroughId(bookIds[i]);
			//System.out.println("book : "+book.getBookId());
			
			listBook.add(book);
		}
		return listBook;
	}
	
	public static BookSet getBookSetFromStandardId(int standardId){
		BookSet bookSet = new BookSet();
		String query = "SELECT * FROM bookset WHERE standardid=" + standardId;
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				bookSet.setBookSetId(rs.getInt("booksetid"));
				bookSet.setName(rs.getString("name"));
				bookSet.setStandardId(rs.getInt("standardid"));
				bookSet.setPrice(rs.getInt("price"));
				bookSet.setQuantity(rs.getInt("quantity"));
				bookSet.setAvailQuantity(rs.getInt("availquantity"));
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return bookSet;
	}
}