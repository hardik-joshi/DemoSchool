package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.Invoice;

public class InvoiceDao {

	public static Connection dbConnection;
	public PreparedStatement pStmt;

	public InvoiceDao() {
		dbConnection = DBUtility.getConnection();
	}

	public void addInvoice(Invoice invoice) {
		String insertQuery = "INSERT INTO invoice(invoicedate, description, "
				+ "amount, studentid, sequenceno) VALUES (?,?,?,?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setString(1, invoice.getInvoiceDate());
			pStmt.setString(2, invoice.getDescription());
			pStmt.setInt(3, invoice.getAmount());
			pStmt.setInt(4, invoice.getStudentId());
			pStmt.setInt(5, invoice.getSequenceNo());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deleteInvoice(int invoiceId) {
		String deleteQuery = "DELETE FROM invoice WHERE invoiceid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, invoiceId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updateInvoice(Invoice invoice) {
		String updateQuery = "UPDATE invoice SET invoicedate = ?, description = ?, "
				+ "amount = ?, studentid = ?, sequenceno = ? WHERE invoiceid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setString(1, invoice.getInvoiceDate());
			pStmt.setString(2, invoice.getDescription());
			pStmt.setInt(3, invoice.getAmount());
			pStmt.setInt(4, invoice.getStudentId());
			pStmt.setInt(5, invoice.getSequenceNo());
			pStmt.setInt(6, invoice.getInvoiceId());
			pStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public List<Invoice> getAllInvoices() {
		List<Invoice> invoices = new ArrayList<Invoice>();

		String query = "SELECT * FROM invoice ORDER BY invoiceid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Invoice invoice = new Invoice();
				
				invoice.setInvoiceId(rs.getInt("invoiceid"));
				invoice.setInvoiceDate(rs.getString("invoicedate"));
				invoice.setDescription(rs.getString("description"));
				invoice.setAmount(rs.getInt("amount"));
				invoice.setStudentId(rs.getInt("studentid"));
				invoice.setSequenceNo(rs.getInt("sequenceno"));
				invoices.add(invoice);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return invoices;
	}

	public static Invoice getInvoiceThroughId(int invoiceId) {
		Invoice invoice = new Invoice();
		String query = "SELECT * FROM invoice WHERE invoiceid=" + invoiceId;
		Statement stmt=null;
		ResultSet rs=null;
		try 
		{
			stmt = dbConnection.createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) 
			{
				invoice.setInvoiceId(rs.getInt("invoiceid"));
				invoice.setInvoiceDate(rs.getString("invoicedate"));
				invoice.setDescription(rs.getString("description"));
				invoice.setAmount(rs.getInt("amount"));
				invoice.setStudentId(rs.getInt("studentid"));
				invoice.setSequenceNo(rs.getInt("sequenceno"));
			}
		} 
		catch (SQLException e) 
		{
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
		return invoice;
	}
	
	public static List<Invoice> getInvoicesFromDate(String toDate,String fromDate,int studentId){
		List<Invoice> invoices = new ArrayList<Invoice>();

		String query = "SELECT * FROM invoice WHERE studentid=" + studentId + " AND invoicedate BETWEEN '" + toDate + "' AND '" + fromDate + "'";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Invoice invoice = new Invoice();
				
				invoice.setInvoiceId(rs.getInt("invoiceid"));
				invoice.setInvoiceDate(rs.getString("invoicedate"));
				invoice.setDescription(rs.getString("description"));
				invoice.setAmount(rs.getInt("amount"));
				invoice.setStudentId(rs.getInt("studentid"));
				invoice.setSequenceNo(rs.getInt("sequenceno"));
				invoices.add(invoice);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return invoices;
	}
	
	public static List<Invoice> getInvoicesFromStudentId(int studentId){
		List<Invoice> invoices = new ArrayList<Invoice>();

		String query = "SELECT * FROM invoice WHERE studentid=" + studentId;
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Invoice invoice = new Invoice();
				
				invoice.setInvoiceId(rs.getInt("invoiceid"));
				invoice.setInvoiceDate(rs.getString("invoicedate"));
				invoice.setDescription(rs.getString("description"));
				invoice.setAmount(rs.getInt("amount"));
				invoice.setStudentId(rs.getInt("studentid"));
				invoice.setSequenceNo(rs.getInt("sequenceno"));
				invoices.add(invoice);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return invoices;
	}
	
	public static List<Invoice> getCurrentInvoices(int studentId){
		List<Invoice> invoices = new ArrayList<Invoice>();

		String query = "SELECT * FROM invoice i WHERE i.studentid=" + studentId + " AND invoicedate NOT IN (SELECT i.invoicedate FROM invoice i,statement s WHERE i.studentid=" + studentId + " AND s.studentid=" + studentId + " AND i.invoicedate BETWEEN s.startdate AND s.enddate)";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Invoice invoice = new Invoice();
				
				invoice.setInvoiceId(rs.getInt("invoiceid"));
				invoice.setInvoiceDate(rs.getString("invoicedate"));
				invoice.setDescription(rs.getString("description"));
				invoice.setAmount(rs.getInt("amount"));
				invoice.setStudentId(rs.getInt("studentid"));
				invoice.setSequenceNo(rs.getInt("sequenceno"));
				invoices.add(invoice);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return invoices;
	}
	
	public static int getSpecificInvoicesFromStatementId(int studentId,String startDate){
		int totalInvoiceAmount = 0;

		String query = "SELECT SUM(amount) as totalamount FROM invoice i WHERE i.studentid=" + studentId + " AND invoicedate IN (SELECT i.invoicedate FROM invoice i,statement s WHERE i.studentid=" + studentId + " AND s.studentid=" + studentId + " AND i.invoicedate BETWEEN s.startdate AND s.enddate AND s.startdate < '" + startDate + "')";
		System.out.println("Current Invoice Query : "+ query);
				
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				totalInvoiceAmount = rs.getInt("totalamount");
			}
			return totalInvoiceAmount;
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return 0;
	}
}