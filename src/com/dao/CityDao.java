/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;
import java.sql.*;
import java.util.*;

import com.jdbc.*;
import com.model.City;
/**
 *
 * @author pavan
 */
public class CityDao {
    
	
	private static Connection dbConnection;
	//private PreparedStatement pStmt;
	
	
	public CityDao(){
		dbConnection = DBUtility.getConnection();
		System.out.println("inside a constructor");
	}
	
   public  void insertCity(){
       
   }
   
   public  ArrayList<City> getAllCities() throws SQLException{
       ArrayList<City> city = new ArrayList<City>();
        Statement st = dbConnection.createStatement();   
        String sql = "select cityid,cityname from city Order by cityname";
        ResultSet rs = st.executeQuery(sql);
       while(rs.next()){
    	   City c = new City();
    	   c.setCityName(rs.getString("cityname"));
    	   c.setCityId(rs.getInt("cityid"));
           city.add(c);
       }
       //dbConnection.close();
       return city;
        
    }
    
}
