package com.model;

public class Organization {
	
	int organizationId;
	
	String name;
	int organizationTypeId;
	String contactNumber;
	
	
	
	
	public int getOrganizationId() {
		return organizationId;
	}
	public void setOrganizationId(int organizationId) {
		this.organizationId = organizationId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getOrganizationTypeId() {
		return organizationTypeId;
	}
	public void setOrganizationTypeId(int industryTypeId) {
		this.organizationTypeId = industryTypeId;
	}
	public String getContactNumber() {
		return contactNumber;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
}
