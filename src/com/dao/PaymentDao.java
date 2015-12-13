package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.Payment;

public class PaymentDao {

	public static Connection dbConnection;
	public PreparedStatement pStmt;

	public PaymentDao() {
		dbConnection = DBUtility.getConnection();
	}

	public void addPayment(Payment payment) {
		String insertQuery = "INSERT INTO payment(paymentdate, description, "
				+ "amount, studentid, sequenceno) VALUES (?,?,?,?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setString(1, payment.getPaymentDate());
			pStmt.setString(2, payment.getDescription());
			pStmt.setInt(3, payment.getAmount());
			pStmt.setInt(4, payment.getStudentId());
			pStmt.setInt(5, payment.getSequenceNo());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deletePayment(int paymentId) {
		String deleteQuery = "DELETE FROM payment WHERE paymentid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, paymentId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updatePayment(Payment payment) {
		String updateQuery = "UPDATE payment SET paymentdate = ?, description = ?, "
				+ "amount = ?, studentid = ?, sequenceno = ? WHERE paymentid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setString(1, payment.getPaymentDate());
			pStmt.setString(2, payment.getDescription());
			pStmt.setInt(3, payment.getAmount());
			pStmt.setInt(4, payment.getStudentId());
			pStmt.setInt(5, payment.getSequenceNo());
			pStmt.setInt(6, payment.getPaymentId());
			pStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public List<Payment> getAllPayments() {
		List<Payment> payments = new ArrayList<Payment>();

		String query = "SELECT * FROM payment ORDER BY paymentid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Payment payment = new Payment();
				
				payment.setPaymentId(rs.getInt("paymentid"));
				payment.setPaymentDate(rs.getString("paymentdate"));
				payment.setDescription(rs.getString("description"));
				payment.setAmount(rs.getInt("amount"));
				payment.setStudentId(rs.getInt("studentid"));
				payment.setSequenceNo(rs.getInt("sequenceno"));
				payments.add(payment);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return payments;
	}

	public static Payment getPaymentThroughId(int paymentId) {
		Payment payment = new Payment();
		String query = "SELECT * FROM payment WHERE paymentid=" + paymentId;
		Statement stmt=null;
		ResultSet rs=null;
		try 
		{
			stmt = dbConnection.createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) 
			{
				payment.setPaymentId(rs.getInt("paymentid"));
				payment.setPaymentDate(rs.getString("paymentdate"));
				payment.setDescription(rs.getString("description"));
				payment.setAmount(rs.getInt("amount"));
				payment.setStudentId(rs.getInt("studentid"));
				payment.setSequenceNo(rs.getInt("sequenceno"));
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
		return payment;
	}
	
	public static List<Payment> getPaymentsFromDate(String toDate,String fromDate, int studentId){
		List<Payment> payments = new ArrayList<Payment>();

		String query = "SELECT * FROM payment WHERE studentid=" + studentId + " AND paymentdate BETWEEN '" + toDate + "' AND '" + fromDate + "'";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Payment payment = new Payment();
				
				payment.setPaymentId(rs.getInt("paymentid"));
				payment.setPaymentDate(rs.getString("paymentdate"));
				payment.setDescription(rs.getString("description"));
				payment.setAmount(rs.getInt("amount"));
				payment.setStudentId(rs.getInt("studentid"));
				payment.setSequenceNo(rs.getInt("sequenceno"));
				payments.add(payment);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return payments;
	}
	
	public static List<Payment> getPaymentsFromStudentId(int studentId){
		List<Payment> payments = new ArrayList<Payment>();

		String query = "SELECT * FROM payment WHERE studentid=" + studentId;
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Payment payment = new Payment();
				
				payment.setPaymentId(rs.getInt("paymentid"));
				payment.setPaymentDate(rs.getString("paymentdate"));
				payment.setDescription(rs.getString("description"));
				payment.setAmount(rs.getInt("amount"));
				payment.setStudentId(rs.getInt("studentid"));
				payment.setSequenceNo(rs.getInt("sequenceno"));
				payments.add(payment);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return payments;
	}
	
	public static List<Payment> getCurrentPayments(int studentId){
		List<Payment> payments = new ArrayList<Payment>();

		String query = "SELECT * FROM payment p WHERE p.studentid=" + studentId + " AND paymentdate NOT IN (SELECT p.paymentdate FROM payment p,statement s WHERE p.studentid=" + studentId + " AND s.studentid=" + studentId + " AND p.paymentdate BETWEEN s.startdate AND s.enddate)";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Payment payment = new Payment();
				
				payment.setPaymentId(rs.getInt("paymentid"));
				payment.setPaymentDate(rs.getString("paymentdate"));
				payment.setDescription(rs.getString("description"));
				payment.setAmount(rs.getInt("amount"));
				payment.setStudentId(rs.getInt("studentid"));
				payment.setSequenceNo(rs.getInt("sequenceno"));
				payments.add(payment);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return payments;
	}
	
	public static int getSpecificPaymentsFromStatementId(int studentId,String startDate){
		int totalPaymentAmount = 0;

		String query = "SELECT SUM(amount) as totalamount FROM payment p WHERE p.studentid=" + studentId + " AND paymentdate IN (SELECT p.paymentdate FROM payment p,statement s WHERE p.studentid=" + studentId + " AND s.studentid=" + studentId + " AND p.paymentdate BETWEEN s.startdate AND s.enddate AND s.startdate < '" + startDate + "')";
		System.out.println("Current payment Query : "+ query);
				
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				totalPaymentAmount = rs.getInt("totalamount");
			}
			return totalPaymentAmount;
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return 0;
	}
}