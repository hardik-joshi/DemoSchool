package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.*;
public class LoginDao {

	public static Connection dbConnection;
	public PreparedStatement pStmt;
	
	public LoginDao(){
		dbConnection = DBUtility.getConnection();
	}
	
	
	public boolean changePassword(String userName, String oldPassword, String newPassword){
		boolean isCorrect = validateLogin(userName, oldPassword);
		if(isCorrect){
			String sql = "update login set userpassword = md5(?) where username = ?";
			
			try{
				pStmt = dbConnection.prepareStatement(sql);
				pStmt.setString(1, newPassword);
				pStmt.setString(2, userName);
				pStmt.executeUpdate();
				return true;
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		return false;
	}
	
	public void setURL(String url, String username){
		String sql = "update login set reseturl = ? where username = ?";
		try{
			pStmt = dbConnection.prepareStatement(sql);
			pStmt.setString(1, url);
			pStmt.setString(2,username);
			pStmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	public boolean validateLogin(String username, String password){
		
		String sql = " select * from login "
					+ "where username='"
					+ username + "' AND"
					+ " userpassword=md5('" + password + "')";
		System.out.println(sql);
		
		try {
			Statement st = dbConnection.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if(!rs.next()){
				System.out.println("Not Found");
				return false;
			}
			else{
				
				System.out.println("Logged in as =" + rs.getInt(4));
				return true;
				
			}
			
		} catch (SQLException e) {
		
			e.printStackTrace();
		}
		return false;
	}
	
	public String getUserName(String url){
		String sql = "select username FROM login where reseturl='" + url + "'" ;
		System.out.println(sql);
		String username = "";
		try{
			Statement st = dbConnection.createStatement();
			ResultSet rs = st.executeQuery(sql);
			if(rs.next())
				username = rs.getString("username");
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return username;
	}
	public void resetPassword(String username, String newpassword) {
		
	
	
			String sql = "update login set userpassword=md5( '" + newpassword + "') WHERE username='" + username + "'";
				try {
				Statement st = dbConnection.createStatement();
				st.executeUpdate(sql);
			
				} 
				catch (SQLException e) {
					
				e.printStackTrace();
				}
			
		
		
	
	}

	public void createUser(String username, String password, int userTypeId){
		
		String insertQuery = "insert into login (username,userpassword,usertype) values (?,md5(?),?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setString(1, username);
			pStmt.setString(2, password);
			pStmt.setInt(3, userTypeId );
			pStmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public int getIdByUsername(String username){
		username = username.toLowerCase();
		int userId = 0;
		String query = "select userid from login where username =" + username;
		try{
			
		
		Statement st = dbConnection.createStatement();
		ResultSet rs = st.executeQuery(query);
			while(rs.next()){
				userId = rs.getInt(1);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return userId;
	}
	
	public List<User> getAllUsers(){
		String sql = "select * from login";
		
		List<User> users = new ArrayList<User>();
		
		try{
			Statement st = dbConnection.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while(rs.next()){
				User user = new User();
				user.setUsername(rs.getString("username"));
				user.setUserType(rs.getInt("userType"));
				users.add(user);
			}
		}
		catch(SQLException e){
			
		}
		
		return users;
	}
}
