package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.FeesStatement;

public class StatementDao {

	public static Connection dbConnection;
	public PreparedStatement pStmt;

	public StatementDao() {
		dbConnection = DBUtility.getConnection();
	}

	public void addStatement(FeesStatement statement) {
		String insertQuery = "INSERT INTO statement(startdate, enddate, "
				+ "statementname, msg, studentid) VALUES (?,?,?,?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setString(1, statement.getStartDate());
			pStmt.setString(2, statement.getEndDate());
			pStmt.setString(3, statement.getStatementName());
			pStmt.setString(4, statement.getMsg());
			pStmt.setInt(5, statement.getStudentId());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deleteStatement(int statementId) {
		String deleteQuery = "DELETE FROM statement WHERE statementid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, statementId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updateStatement(FeesStatement statement) {
		String updateQuery = "UPDATE statement SET startdate = ?, enddate = ?, "
				+ "statementname = ?, msg = ?, studentid = ? WHERE statementid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setString(1, statement.getStartDate());
			pStmt.setString(2, statement.getEndDate());
			pStmt.setString(3, statement.getStatementName());
			pStmt.setString(4, statement.getMsg());
			pStmt.setInt(5, statement.getStudentId());
			pStmt.setInt(6, statement.getStatementId());
			pStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public List<FeesStatement> getAllStatements() {
		List<FeesStatement> statements = new ArrayList<FeesStatement>();

		String query = "SELECT * FROM statement ORDER BY statementid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				FeesStatement statement = new FeesStatement();
				
				statement.setStatementId(rs.getInt("statementid"));
				statement.setStartDate(rs.getString("startdate"));
				statement.setEndDate(rs.getString("enddate"));
				statement.setStatementName(rs.getString("statementname"));
				statement.setMsg(rs.getString("msg"));
				statement.setStudentId(rs.getInt("studentid"));
				statements.add(statement);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return statements;
	}

	public static FeesStatement getStatementThroughId(int statementId) {
		FeesStatement statement = new FeesStatement();
		String query = "SELECT * FROM statement WHERE statementid=" + statementId;
		Statement stmt=null;
		ResultSet rs=null;
		try 
		{
			stmt = dbConnection.createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) 
			{
				statement.setStatementId(rs.getInt("statementid"));
				statement.setStartDate(rs.getString("startdate"));
				statement.setEndDate(rs.getString("enddate"));
				statement.setStatementName(rs.getString("statementname"));
				statement.setMsg(rs.getString("msg"));
				statement.setStudentId(rs.getInt("studentid"));
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
		return statement;
	}
	
	public List<FeesStatement> getStatementThroughStudentId(int studentId) {
		List<FeesStatement> statements = new ArrayList<FeesStatement>();

		String query = "SELECT * FROM statement WHERE statementid=1 OR statementid=2 OR studentid=" + studentId + " order by startdate desc";
		System.out.println("statemnet : " +query);
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				FeesStatement statement = new FeesStatement();
				
				statement.setStatementId(rs.getInt("statementid"));
				statement.setStartDate(rs.getString("startdate"));
				statement.setEndDate(rs.getString("enddate"));
				statement.setStatementName(rs.getString("statementname"));
				statement.setMsg(rs.getString("msg"));
				statement.setStudentId(rs.getInt("studentid"));
				statements.add(statement);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return statements;
	}
}