package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.jdbc.DBUtility;
import com.model.Organization;
import com.model.OrganizationType;
import com.model.Person;

public class OrganizationDao {

	public static Connection dbConnection;
	public PreparedStatement pStmt;
	
	public OrganizationDao(){
		dbConnection = DBUtility.getConnection();
	}
	
	public List<OrganizationType> getOrganizationTypes(){
		
		List<OrganizationType> orgTypes = new ArrayList<OrganizationType>();
		
		try {
			Statement st = dbConnection.createStatement();
			String sql = "select * from organizationtype";
			ResultSet rs = st.executeQuery(sql);
			
			while(rs.next()){
				OrganizationType org = new OrganizationType();
				
				org.setOrganizationTypeId(rs.getInt("organizationtypeid"));
				org.setTypeName(rs.getString("typename"));
				
				orgTypes.add(org);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		
		
		return orgTypes;
		
	}

	public List<Organization> getOrganizationByType(int typeId){
	
	List<Organization> orgs = new ArrayList<Organization>();
	
	try {
		Statement st = dbConnection.createStatement();
		String sql = "select * from organization where organizationtypeid='" + typeId + "'";
		ResultSet rs = st.executeQuery(sql);
		
		while(rs.next()){
			Organization org = new Organization();
			
			org.setName(rs.getString("name"));
			org.setContactNumber(rs.getString("contactnumber"));
			org.setOrganizationId(rs.getInt("organizationid"));
			org.setOrganizationTypeId(typeId);
			orgs.add(org);
			}
		
		} 
	catch (SQLException e) {
		e.printStackTrace();
		}
	
	return orgs;
	}

	
	public List<Organization> getAllOrganizations(){
		
	List<Organization> orgs = new ArrayList<Organization>();
	
	try {
		Statement st = dbConnection.createStatement();
		String sql = "select * from organization";
		ResultSet rs = st.executeQuery(sql);
		
		while(rs.next()){
			Organization org = new Organization();
			
			org.setName(rs.getString("name"));
			org.setContactNumber(rs.getString("contactnumber"));
			org.setOrganizationId(rs.getInt("organizationid"));
			org.setOrganizationTypeId(rs.getInt("organizationtypeid"));
			orgs.add(org);
			}
		
		} 
	catch (SQLException e) {
		e.printStackTrace();
		}
	
	return orgs;
	}
	
	
	public void updateOrganization(Organization o){
		String sql = "update organization set name = ?, contactnumber = ? WHERE organizationid = ?";
		
		System.out.println("Inside Update DAO");
		
		try{
			pStmt= dbConnection.prepareStatement(sql);	
			pStmt.setString(1,o.getName());
			pStmt.setString(2,o.getContactNumber());
			pStmt.setInt(3, o.getOrganizationId());
			
			pStmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public List<Person> getOrganizationContacts(int orgId){
	
	List<Person> contacts = new ArrayList<Person>();
	List<Integer> personIds = new ArrayList<Integer>();
	try {
		Statement st = dbConnection.createStatement();
		String sql = "select * from organizationcontact where organizationid='" + orgId + "'";
		ResultSet rs = st.executeQuery(sql);
		
		while(rs.next()){
			personIds.add(rs.getInt("personid"));
			}
		PersonDao personDao = new PersonDao();
		contacts = personDao.getPersonsFromPersonId((Integer[])personIds.toArray());
		} 
	catch (SQLException e) {
		e.printStackTrace();
		}
	
	return contacts;
	}

	public void removeOrganizationContact(int personId){
		
	String deleteQuery = "DELETE FROM organizationcontact WHERE personid = ?";
	String deletePersonQuery = "DELETE FROM person where personid= ?";
	
	try {
		pStmt = dbConnection.prepareStatement(deleteQuery);
		pStmt.setInt(1, personId);
		pStmt.executeUpdate();
		
		pStmt = dbConnection.prepareStatement(deletePersonQuery);
		pStmt.setInt(1, personId);
		pStmt.executeUpdate();
		
	} catch (SQLException e) {
		System.err.println(e.getMessage());
	}
	
}
	
	public int enterOrganization(Organization org){
		String insertQuery = "INSERT INTO organization(name,organizationtypeid,contactnumber) values(?,?,?)";
		try {
			pStmt = dbConnection.prepareStatement(insertQuery);
			pStmt.setString(1,org.getName());
			pStmt.setInt(2,org.getOrganizationTypeId());
			pStmt.setString(3, org.getContactNumber());
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		
		return getLastInsertedOrganizationId();
	}
	
	public int getLastInsertedOrganizationId(){
		String sql = "SELECT max(organizationid) FROM organization";
		try {
			Statement st = dbConnection.createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			if(rs.next()){
				return rs.getInt(1);
			}
		}
		catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		
		return -1;
	}
	
	
	public List<Person> getOrganizationPersons(int organziationId){
		
		List<Person> persons = new ArrayList<Person>();
		
		String sql = "SELECT * FROM organizationcontact WHERE"
				+ "  organizationId=" + organziationId;
		try{
			Statement st = dbConnection.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while(rs.next()){
				
				int personId = rs.getInt("personid");
				System.out.println("PERSON ID IN ORGANIZTIONCONTACT = " + personId);
				
				PersonDao personDao = new PersonDao();
				Person p = personDao.getPersonThroughId(personId);
				
				persons.add(p);
				
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return persons;
	}
	
	public Organization getOrganizationById(int organizationId){
		Organization org = new Organization();
		String sql = "SELECT * FROM organization WHERE organizationid= '" + organizationId + "'";
		try {
			Statement st = dbConnection.createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			while(rs.next()){
				
				org.setOrganizationId(organizationId);
				org.setContactNumber(rs.getString(2));
				org.setName(rs.getString(3));
			}
			
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		return org;
	}
	
	public void enterOrganizationContact(int organizationId, int personId){
		String deleteQuery = "INSERT INTO organizationcontact(personid,organizationid) values(?,?)";
		try {
			pStmt = dbConnection.prepareStatement(deleteQuery);
			pStmt.setInt(1, personId);
			pStmt.setInt(2, organizationId);
			pStmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
	}
}
