package com.dao;

import java.io.*;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.Person;

public class PersonDao {

	public static Connection dbConnection;
	public PreparedStatement pStmt;

	public InputStream getInputStream(String img) {

		System.out.println("IMAGE==" + img);

		InputStream in = new ByteArrayInputStream(img.getBytes());

		return in;
	}

	public static String getString(InputStream in) {

		String photo = "";
		BufferedReader br = new BufferedReader(new InputStreamReader(in));
		String line = "";
		try {
			while (true) {

				line = br.readLine();

				if (line == null) {
					break;
				}
				photo += line;
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

		return photo;
	}

	public PersonDao() {
		dbConnection = DBUtility.getConnection();
	}

	public int addPerson(Person person) {
		System.out.println("in add person");
		String insertQuery = "INSERT INTO person(firstname,lastname,dob,email,mobileno,alternateno,gender,homeno,address1,address2,pincode,cityid,photo,occupation) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		InputStream in;
		if (person.getPhoto() == null) {
			in = null;
		} else {
			in = getInputStream(person.getPhoto());
		}
		try {
			System.out.println("trying to insert person");
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setString(1, person.getFirstName());
			pStmt.setString(2, person.getLastName());
			pStmt.setString(3, person.getDob());
			pStmt.setString(4, person.getEmail());
			pStmt.setString(5, person.getMobileNo());
			pStmt.setString(6, person.getAlternateNo());
			pStmt.setString(7, person.getGender());
			pStmt.setString(8, person.getHomeNo());
			pStmt.setString(9, person.getAddress1());
			pStmt.setString(10, person.getAddress2());
			pStmt.setString(11, person.getPincode());
			pStmt.setInt(12, person.getCityId());
			pStmt.setBinaryStream(13, in);
			pStmt.setString(14, person.getOccupation());
			pStmt.executeUpdate();

			return getLastInsertedId();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
			return -1;
		}

	}

	public int getLastInsertedId() {
		String sql = "SELECT max(personid) FROM person";
		try {
			Statement st = dbConnection.createStatement();
			ResultSet rs = st.executeQuery(sql);

			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}

		return -1;
	}

	public void deletePerson(int personId) {
		String deleteQuery = "DELETE FROM person WHERE personid = ?";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, personId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public int updatePerson1(Person person){
		String updateQuery = "UPDATE person SET firstname = ?, lastname = ?, "
				+ " email = ?, mobileno = ?, alternateno = ?, occupation = ?  WHERE personid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setString(1, person.getFirstName());
			pStmt.setString(2, person.getLastName());
			pStmt.setString(3, person.getEmail());
			pStmt.setString(4, person.getMobileNo());
			pStmt.setString(5, person.getAlternateNo());
			pStmt.setString(6,person.getOccupation());
			pStmt.setInt(7,person.getPersonId());
			
			System.out.println(" In UPDATE PERSON ");
			pStmt.executeUpdate();
			
			return getLastInsertedId();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		
		return -1;

		
	}
	
	public void updatePerson(Person person) {
		String updateQuery = "UPDATE person SET firstname = ?, lastname = ?, "
				+ "dob = ?, email = ?, mobileno = ?, alternateno = ?, gender = ?, homeno = ?, address1 = ?, address2 = ?, pincode = ?, cityid = ?  WHERE personid = ?";
		try {
			pStmt = dbConnection.prepareStatement(updateQuery);
			pStmt.setString(1, person.getFirstName());
			pStmt.setString(2, person.getLastName());
			pStmt.setString(3, person.getDob());
			pStmt.setString(4, person.getEmail());
			pStmt.setString(5, person.getMobileNo());
			pStmt.setString(6, person.getAlternateNo());
			pStmt.setString(7, person.getGender());
			pStmt.setString(8, person.getHomeNo());
			pStmt.setString(9, person.getAddress1());
			pStmt.setString(10, person.getAddress2());
			pStmt.setString(11, person.getPincode());
			pStmt.setInt(12, person.getCityId());
			pStmt.setInt(13, person.getPersonId());
			pStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}

	public List<Person> getAllPersons() {
		List<Person> persons = new ArrayList<Person>();

		String query = "SELECT * FROM person ORDER BY personid";
		try {
			Statement stmt = dbConnection.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				Person person = new Person();

				person.setPersonId(rs.getInt("personid"));
				person.setFirstName(rs.getString("firstname"));
				person.setLastName(rs.getString("lastname"));
				person.setDob(rs.getString("dob"));
				person.setEmail(rs.getString("email"));
				person.setMobileNo(rs.getString("mobileno"));
				person.setAlternateNo(rs.getString("alternateno"));
				person.setGender(rs.getString("gender"));
				person.setHomeNo(rs.getString("homeno"));
				person.setAddress1(rs.getString("address1"));
				person.setAddress2(rs.getString("address2"));
				person.setPincode(rs.getString("pincode"));
				person.setCityId(rs.getInt("cityid"));
				persons.add(person);
			}
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return persons;
	}

	
	
	
	public  static Person getPersonThroughId(int personId) {
		Person person = new Person();
		String query = "SELECT * FROM person WHERE personid=" + personId;
		Statement stmt=null;
		ResultSet rs=null;
		System.out.println(query);
		try 
		{
			
			stmt = dbConnection.createStatement();
			if(stmt==null)
				System.out.println("statement not created");
			rs = stmt.executeQuery(query);
			if(rs==null)
				System.out.println("result set not created");
			System.out.println("INSIDE query execute");
			while (rs.next()) 
			{
				System.out.println("INSIDE resultset");
				
				person.setPersonId(rs.getInt("personid"));
				person.setFirstName(rs.getString("firstname"));
				person.setLastName(rs.getString("lastname"));
				person.setDob(rs.getString("dob"));
				person.setEmail(rs.getString("email"));
				person.setMobileNo(rs.getString("mobileno"));
				person.setAlternateNo(rs.getString("alternateno"));
				person.setGender(rs.getString("gender"));
				person.setHomeNo(rs.getString("homeno"));
				person.setAddress1(rs.getString("address1"));
				person.setAddress2(rs.getString("address2"));
				person.setPincode(rs.getString("pincode"));
				person.setCityId(rs.getInt("cityid"));
				person.setOccupation(rs.getString("occupation"));
				Blob blob =  rs.getBlob("photo");
				InputStream in = blob.getBinaryStream();
				String photo = getString(in);
				
				
				person.setPhoto(photo);
				
			}
		} 
		catch (SQLException e) 
		{
			System.out.println("exception");
			System.err.println(e.getMessage());
			System.out.println(e);
		}
		catch (Exception e){
			System.err.println(e.getMessage());
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
		return person;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	public static Person getPersonThroughId(int personId) {
		Person person = new Person();
		String query = "SELECT * FROM person WHERE personid=" + personId;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			System.out.println("stmt1");
			stmt = dbConnection.createStatement();
			System.out.println("stmt2");
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				System.out.println("resultSet");
				person.setPersonId(rs.getInt("personid"));
				person.setFirstName(rs.getString("firstname"));
				person.setLastName(rs.getString("lastname"));
				person.setDob(rs.getString("dob"));
				person.setEmail(rs.getString("email"));
				person.setMobileNo(rs.getString("mobileno"));
				person.setAlternateNo(rs.getString("alternateno"));
				person.setGender(rs.getString("gender"));
				person.setHomeNo(rs.getString("homeno"));
				person.setAddress1(rs.getString("address1"));
				person.setAddress2(rs.getString("address2"));
				person.setPincode(rs.getString("pincode"));
				person.setCityId(rs.getInt("cityid"));
			}
		} catch (SQLException e) {
			System.out.println("exception");
			System.err.println(e.getMessage());
			System.out.println(e);
		} finally {
			try {
				rs.close();
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println("inside person through id1 " + personId);
		return person;
	}

	/*
	 * public List<Person> getPersonsFromPersonId(int[] personId){ List<Person>
	 * persons = new ArrayList<Person>();
	 * 
	 * for (int i = 0; i < personId.length; i++) { String query =
	 * "SELECT * FROM person WHERE personid=" + personId[i]; try { Statement
	 * stmt = dbConnection.createStatement(); ResultSet rs =
	 * stmt.executeQuery(query); while (rs.next()) { Person person = new
	 * Person();
	 * 
	 * person.setPersonId(rs.getInt("personid"));
	 * person.setFirstName(rs.getString("firstname"));
	 * person.setLastName(rs.getString("lastname"));
	 * person.setDob(rs.getString("dob"));
	 * person.setEmail(rs.getString("email"));
	 * person.setMobileNo(rs.getString("mobileno"));
	 * person.setAlternateNo(rs.getString("alternateno"));
	 * person.setGender(rs.getString("gender"));
	 * person.setHomeNo(rs.getString("homeno"));
	 * person.setAddress1(rs.getString("address1"));
	 * person.setAddress2(rs.getString("address2"));
	 * person.setPincode(rs.getString("pincode"));
	 * person.setCityId(rs.getInt("cityid")); persons.add(person); } } catch
	 * (SQLException e) { System.err.println(e.getMessage()); } } return
	 * persons;
	 * 
	 * }
	 */

	public List<Person> getPersonsFromPersonId(Integer[] personId) {
		List<Person> persons = new ArrayList<Person>();

		for (int i = 0; i < personId.length; i++) {
			String query = "SELECT * FROM person WHERE personid=" + personId[i];
			try {
				Statement stmt = dbConnection.createStatement();
				ResultSet rs = stmt.executeQuery(query);
				while (rs.next()) {
					Person person = new Person();

					person.setPersonId(rs.getInt("personid"));
					person.setFirstName(rs.getString("firstname"));
					person.setLastName(rs.getString("lastname"));
					person.setDob(rs.getString("dob"));
					person.setEmail(rs.getString("email"));
					person.setMobileNo(rs.getString("mobileno"));
					person.setAlternateNo(rs.getString("alternateno"));
					person.setGender(rs.getString("gender"));
					person.setHomeNo(rs.getString("homeno"));
					person.setAddress1(rs.getString("address1"));
					person.setAddress2(rs.getString("address2"));
					person.setPincode(rs.getString("pincode"));
					person.setCityId(rs.getInt("cityid"));
					person.setOccupation(rs.getString("occupation"));
					persons.add(person);
				}
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
		return persons;

	}

	public List<Person> getPersonsFromPersonId(int[] personId) {
		List<Person> persons = new ArrayList<Person>();

		for (int i = 0; i < personId.length; i++) {
			String query = "SELECT * FROM person WHERE personid=" + personId[i];
			try {
				Statement stmt = dbConnection.createStatement();
				ResultSet rs = stmt.executeQuery(query);
				while (rs.next()) {
					Person person = new Person();

					person.setPersonId(rs.getInt("personid"));
					person.setFirstName(rs.getString("firstname"));
					person.setLastName(rs.getString("lastname"));
					person.setDob(rs.getString("dob"));
					person.setEmail(rs.getString("email"));
					person.setMobileNo(rs.getString("mobileno"));
					person.setAlternateNo(rs.getString("alternateno"));
					person.setGender(rs.getString("gender"));
					person.setHomeNo(rs.getString("homeno"));
					person.setAddress1(rs.getString("address1"));
					person.setAddress2(rs.getString("address2"));
					
					person.setPincode(rs.getString("pincode"));
					person.setCityId(rs.getInt("cityid"));
					person.setOccupation(rs.getString("occupation"));
					persons.add(person);
				}
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
		return persons;

	}
}