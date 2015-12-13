package com.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtility {
	public static Connection connection = null;

	public static Connection getConnection() {
		if (connection != null)
			return connection;
		else 
		{
			System.out.println("Connection");
			/*String serverName = "127.0.0.1";
			String portNumber = "4928";*/
			String dbUrl = "jdbc:mysql://localhost:3306/pavanschool";
			
			try 
			{
				Class.forName("com.mysql.jdbc.Driver");
				// set the url, username and password for the database
				connection = DriverManager.getConnection(dbUrl,"root","root");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return connection;
		}
	}
}