package com.model;

public class FeeStudent {
	int feeStudentId = 0;
	int feesTypeId = 0;
	int studentId = 0;
	String paidFrom = null;
	String paidTo = null;
	int standardId = 0;
	int amountPaid = 0;
	public int getFeeStudentId() {
		return feeStudentId;
	}
	public void setFeeStudentId(int feeStudentId) {
		this.feeStudentId = feeStudentId;
	}
	public int getFeesTypeId() {
		return feesTypeId;
	}
	public void setFeesTypeId(int feesTypeId) {
		this.feesTypeId = feesTypeId;
	}
	public int getStudentId() {
		return studentId;
	}
	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}
	public String getPaidFrom() {
		return paidFrom;
	}
	public void setPaidFrom(String paidFrom) {
		this.paidFrom = paidFrom;
	}
	public String getPaidTo() {
		return paidTo;
	}
	public void setPaidTo(String paidTo) {
		this.paidTo = paidTo;
	}
	public int getStandardId() {
		return standardId;
	}
	public void setStandardId(int standardId) {
		this.standardId = standardId;
	}
	public int getAmountPaid() {
		return amountPaid;
	}
	public void setAmountPaid(int amountPaid) {
		this.amountPaid = amountPaid;
	}
}
