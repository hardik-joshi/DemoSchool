package com.model;

public class City {
	
	String cityName;
	int cityId;
	
	
	
	public int getCityId() {
		return cityId;
	}

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public void setCityName(String cityName){
		this.cityName = cityName;
	}
	
	public String getCityName(){
		
		return this.cityName;
	}

}
