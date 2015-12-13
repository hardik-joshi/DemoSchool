package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.Charge;

public class ChargeDao {

	public static Connection dbConnection;
	public PreparedStatement pStmt;

	public ChargeDao() {
		dbConnection = DBUtility.getConnection();
	}

	public void addCharge(Charge charge) {
		String insertQuery = "INSERT INTO charge(chargedate, description, "
				+ "amount, studentid,sequenceno) VALUES (?,?,?,?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setString(1, charge.getChargeDate());
			pStmt.setString(2, charge.getDescription());
			pStmt.setInt(3, charge.getAmount());
			pStmt.setInt(4, charge.getStudentId());
			pStmt.setInt(5, charge.getSequenceNo());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deleteCharge(int chargeId) {
		String deleteQuery = "DELETE FROM charge WHERE chargeid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, chargeId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updateCharge(Charge charge) {
		String updateQuery = "UPDATE charge SET chargedate = ?, description = ?, "
				+ "amount = ?, studentid = ?, sequenceno = ? WHERE chargeid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setString(1, charge.getChargeDate());
			pStmt.setString(2, charge.getDescription());
			pStmt.setInt(3, charge.getAmount());
			pStmt.setInt(4, charge.getStudentId());
			pStmt.setInt(5, charge.getSequenceNo());
			pStmt.setInt(6, charge.getChargeId());
			pStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public List<Charge> getAllCharges() {
		List<Charge> charges = new ArrayList<Charge>();

		String query = "SELECT * FROM charge ORDER BY chargeid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Charge charge = new Charge();
				
				charge.setChargeId(rs.getInt("chargeid"));
				charge.setChargeDate(rs.getString("chargedate"));
				charge.setDescription(rs.getString("description"));
				charge.setAmount(rs.getInt("amount"));
				charge.setStudentId(rs.getInt("studentid"));
				charge.setSequenceNo(rs.getInt("sequenceno"));
				charges.add(charge);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return charges;
	}

	public static Charge getChargeThroughId(int chargeId) {
		Charge charge = new Charge();
		String query = "SELECT * FROM charge WHERE chargeid=" + chargeId;
		Statement stmt=null;
		ResultSet rs=null;
		try 
		{
			stmt = dbConnection.createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) 
			{
				charge.setChargeId(rs.getInt("chargeid"));
				charge.setChargeDate(rs.getString("chargedate"));
				charge.setDescription(rs.getString("description"));
				charge.setAmount(rs.getInt("amount"));
				charge.setStudentId(rs.getInt("studentid"));
				charge.setSequenceNo(rs.getInt("sequenceno"));
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
		return charge;
	}
	
	public static List<Charge> getChargesFromDate(String toDate,String fromDate, int studentId){
		List<Charge> charges = new ArrayList<Charge>();

		String query = "SELECT * FROM charge WHERE studentid=" + studentId + " AND chargedate BETWEEN '" + toDate + "' AND '" + fromDate + "'";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Charge charge = new Charge();
				
				charge.setChargeId(rs.getInt("chargeid"));
				charge.setChargeDate(rs.getString("chargedate"));
				charge.setDescription(rs.getString("description"));
				charge.setAmount(rs.getInt("amount"));
				charge.setStudentId(rs.getInt("studentid"));
				charge.setSequenceNo(rs.getInt("sequenceno"));
				charges.add(charge);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return charges;
	}
	
	public static List<Charge> getChargesFromStudentId(int studentId){
		List<Charge> charges = new ArrayList<Charge>();

		String query = "SELECT * FROM charge WHERE studentid=" + studentId;
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Charge charge = new Charge();
				
				charge.setChargeId(rs.getInt("chargeid"));
				charge.setChargeDate(rs.getString("chargedate"));
				charge.setDescription(rs.getString("description"));
				charge.setAmount(rs.getInt("amount"));
				charge.setStudentId(rs.getInt("studentid"));
				charge.setSequenceNo(rs.getInt("sequenceno"));
				charges.add(charge);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return charges;
	}
	
	public static List<Charge> getCurrentCharges(int studentId){
		List<Charge> charges = new ArrayList<Charge>();

		String query = "SELECT * FROM charge c WHERE c.studentid=" + studentId + " AND chargedate NOT IN (SELECT c.chargedate FROM charge c,statement s WHERE c.studentid=" + studentId + " AND s.studentid=" + studentId + " AND c.chargedate BETWEEN s.startdate AND s.enddate)";
		System.out.println("Current Charge Query : "+ query);
				
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Charge charge = new Charge();
				
				charge.setChargeId(rs.getInt("chargeid"));
				charge.setChargeDate(rs.getString("chargedate"));
				charge.setDescription(rs.getString("description"));
				charge.setAmount(rs.getInt("amount"));
				charge.setStudentId(rs.getInt("studentid"));
				charge.setSequenceNo(rs.getInt("sequenceno"));
				charges.add(charge);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return charges;
	}
	
	public static int getSpecificChargesFromStatementId(int studentId,String startDate){
		int totalChargeAmount = 0;
		String query = "SELECT SUM(amount) as totalamount FROM charge c WHERE c.studentid=" + studentId + " AND chargedate IN (SELECT c.chargedate FROM charge c,statement s WHERE c.studentid=" + studentId + " AND s.studentid=" + studentId + " AND c.chargedate BETWEEN s.startdate AND s.enddate AND s.startdate < '" + startDate + "')";
		System.out.println("Current Charge Query : "+ query);
				
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				totalChargeAmount = rs.getInt("totalamount");
			}
			return totalChargeAmount;
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return 0;
	}
	
	public void addChargeUpdateOutstanding(Charge charge) {
		String insertQuery = "INSERT INTO charge(chargedate, description, "
				+ "amount, studentid,sequenceno) VALUES (?,?,?,?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setString(1, charge.getChargeDate());
			pStmt.setString(2, charge.getDescription());
			pStmt.setInt(3, charge.getAmount());
			pStmt.setInt(4, charge.getStudentId());
			pStmt.setInt(5, charge.getSequenceNo());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		
		String updateQuery = "UPDATE student SET outstandingfees=outstandingfees+" + charge.getAmount() + " WHERE studentid=" + charge.getStudentId();
		System.out.println(updateQuery);
		try {
			Statement stmt = dbConnection.createStatement();
			stmt.executeUpdate(updateQuery);
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}
}