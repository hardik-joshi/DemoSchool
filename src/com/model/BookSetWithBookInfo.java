package com.model;

public class BookSetWithBookInfo {
	private int books[] = new int[7];
	private int bookSetId;
	public int getBookSetId() {
		return bookSetId;
	}
	public void setBookSetId(int bookSetId) {
		this.bookSetId = bookSetId;
	}
	public int[] getBooks() {
		return books;
	}
	public void setBooks(int[] books) {
		for(int i=0;i<7;i++){
			this.books[i] = books[i];
		}
	}
}
