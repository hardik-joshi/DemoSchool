package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.Standard;

public class StandardDao {

	private static Connection dbConnection;
	private PreparedStatement pStmt;

	public StandardDao() {
		dbConnection = DBUtility.getConnection();
	}

	public void addStandard(Standard standard) {
		String insertQuery = "INSERT INTO standard(standardid,standardname) VALUES (?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setInt(1, standard.getStandardId());
			pStmt.setString(2, standard.getStandardName());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deleteStandard(int standardId) {
		String deleteQuery = "DELETE FROM standard WHERE standardid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, standardId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updateStandard(Standard standard) {
		String updateQuery = "UPDATE standard SET standardname = ? WHERE standardid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setString(1, standard.getStandardName());
			pStmt.setInt(6, standard.getStandardId());
			pStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public List<Standard> getAllStandards() {
		List<Standard> standards = new ArrayList<Standard>();

		String query = "SELECT * FROM standard ORDER BY standardid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Standard standard = new Standard();

				standard.setStandardId(rs.getInt("standardid"));
				standard.setStandardName(rs.getString("standardname"));
				standards.add(standard);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return standards;
	}

	public List<Standard> getAllStandard() {
		List<Standard> standards = new ArrayList<Standard>();

		String query = "SELECT * FROM standard order by standardid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Standard standard = new Standard();

				standard.setStandardId(rs.getInt("standardid"));
				standard.setStandardName(rs.getString("standardname"));
				standards.add(standard);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return standards;

	}
	
	public static Standard getStandardThroughId(int standardId){
		Standard standard = new Standard();
		String query = "SELECT * FROM standard WHERE standardid=" + standardId;
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				standard.setStandardId(rs.getInt("standardid"));
				standard.setStandardName(rs.getString("standardname"));
			}
			
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return standard;
		
	}
}