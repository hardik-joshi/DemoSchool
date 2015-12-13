package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.FeeStudent;

public class FeeStudentDao {

	public static Connection dbConnection;
	public PreparedStatement pStmt;

	public FeeStudentDao() {
		dbConnection = DBUtility.getConnection();
	}

	public void addFeeStudent(FeeStudent feeStudent) {
		String insertQuery = "INSERT INTO feestudent(feestudentid,feetypeid,studentid,paidfrom,paidto,standardid,amountpaid) VALUES (?,?,?,?,?,?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setInt(1, feeStudent.getFeeStudentId());
			pStmt.setInt(2, feeStudent.getFeesTypeId());
			pStmt.setInt(3, feeStudent.getStudentId());
			pStmt.setString(4, feeStudent.getPaidFrom());
			pStmt.setString(5, feeStudent.getPaidTo());
			pStmt.setInt(6, feeStudent.getStandardId());
			pStmt.setInt(7, feeStudent.getAmountPaid());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deleteFeeStudent(int studentId) {
		String deleteQuery = "DELETE FROM feestudent WHERE feestudentid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, studentId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updateFeeStudent(FeeStudent feeStudent) {
		String updateQuery = "UPDATE feestudent SET feetypeid = ?, studentid = ?, paidfrom = ?, paidto = ?, standardid = ?, amountpaid = ? WHERE feestudentid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setInt(1, feeStudent.getFeesTypeId());
			pStmt.setInt(2, feeStudent.getStudentId());
			pStmt.setString(3, feeStudent.getPaidFrom());
			pStmt.setString(4, feeStudent.getPaidTo());
			pStmt.setInt(5, feeStudent.getStandardId());
			pStmt.setInt(6, feeStudent.getAmountPaid());
			pStmt.setInt(7, feeStudent.getFeeStudentId());
			pStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public List<FeeStudent> getAllFeeStudents() {
		List<FeeStudent> feeStudents = new ArrayList<FeeStudent>();

		String query = "SELECT * FROM feestudent ORDER BY feestudentid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				FeeStudent feeStudent = new FeeStudent();
				feeStudent.setFeeStudentId(rs.getInt("feestudentid"));
				feeStudent.setFeesTypeId(rs.getInt("feetypeid"));
				feeStudent.setStudentId(rs.getInt("studentid"));
				feeStudent.setPaidFrom(rs.getString("paidfrom"));
				feeStudent.setPaidTo(rs.getString("patdto"));
				feeStudent.setStandardId(rs.getInt("standardid"));
				feeStudent.setAmountPaid(rs.getInt("amountpaid"));
				feeStudents.add(feeStudent);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return feeStudents;
	}
}