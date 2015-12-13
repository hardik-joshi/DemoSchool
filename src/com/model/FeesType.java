package com.model;

public class FeesType {
	int feesTypeId;
	String typeName;
	String duration;
	int amount;
	int standardId;
	public int getStandardId() {
		return standardId;
	}
	public void setStandardId(int standardId) {
		this.standardId = standardId;
	}
	public int getFeesTypeId() {
		return feesTypeId;
	}
	public void setFeesTypeId(int feesTypeId) {
		this.feesTypeId = feesTypeId;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
}
