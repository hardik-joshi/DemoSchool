package com.model;

public class BookSet {
	private int bookSetId;
	private String name;
	private int standardId;
	private int quantity;
	private int price;
	private int availQuantity;
	public int getAvailQuantity() {
		return availQuantity;
	}
	public void setAvailQuantity(int availQuantity) {
		this.availQuantity = availQuantity;
	}
	public int getBookSetId() {
		return bookSetId;
	}
	public void setBookSetId(int bookSetId) {
		this.bookSetId = bookSetId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getStandardId() {
		return standardId;
	}
	public void setStandardId(int standardId) {
		this.standardId = standardId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
}
