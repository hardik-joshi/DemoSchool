package com.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.Task;


public class TaskDao {

	public static Connection dbConnection;
	public PreparedStatement pStmt;

	public TaskDao() {
		dbConnection = DBUtility.getConnection();
	}

	public void addTask(Task task) {
		String insertQuery = "INSERT INTO task(taskname, taskDescription, "
				+ "userid, datecreated, fordate) VALUES (?,?,?,?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setString(1, task.getTaskName());
			pStmt.setString(2, task.getTaskDescription());
			pStmt.setInt(3, task.getUserId());
			System.out.println(task.getDateCreated());
			
			pStmt.setDate(4,java.sql.Date.valueOf(task.getDateCreated()));
			pStmt.setDate(5, java.sql.Date.valueOf(task.getForDate()));
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void deleteTask(int taskId) {
		String deleteQuery = "DELETE FROM task WHERE taskid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, taskId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public void updateTask(Task task) {
		String updateQuery = "UPDATE task SET taskname = ?, taskdescription = ?, "
				+ "userid = ?, datecreated = ?, fordate = ? WHERE taskid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setString(1, task.getTaskName());
			pStmt.setString(2, task.getTaskDescription());
			pStmt.setInt(3, task.getUserId());
			pStmt.setDate(4,java.sql.Date.valueOf(task.getDateCreated()));
			pStmt.setDate(5, java.sql.Date.valueOf(task.getForDate()));
			pStmt.setInt(6, task.getTaskId());
			pStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public List<Task> getAllTasks() {
		List<Task> tasks = new ArrayList<Task>();

		String query = "SELECT * FROM task ORDER BY fordate DESC";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Task task = new Task();
				
				task.setTaskId(rs.getInt("taskid"));
				task.setTaskName(rs.getString("taskname"));
				task.setTaskDescription(rs.getString("taskdescription"));
				task.setForDate(rs.getDate("fordate").toString());
				task.setDateCreated(rs.getDate("datecreated").toString());
				task.setUserId(rs.getInt("userid"));
				tasks.add(task);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return tasks;
	}
	public static Task getBookThroughId(int taskid) {
		Task task = new Task();
		String query = "SELECT * FROM task WHERE taskid=" + taskid;
		Statement stmt=null;
		ResultSet rs=null;
		try 
		{
			while(rs.next()){
			
			task.setTaskId(rs.getInt("taskid"));
			task.setTaskName(rs.getString("taskname"));
			task.setTaskDescription(rs.getString("taskdescription"));
			task.setForDate(rs.getDate("fordate").toString());
			task.setDateCreated(rs.getDate("datecreated").toString());
			task.setUserId(rs.getInt("userid"));
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
		System.out.println("inside book through id1 " + taskid);
		return task;
	}
	
	
}