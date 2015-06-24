/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class OperationPriceModel extends ManagedBaseModel{

	@DBField
	private Integer hospitalId;
	
	@DBField
	private Integer categoryId;

	@DBField
	private Integer price;

	@DBField
	private String description;
	
	public Integer getHospitalId() {
		return hospitalId;
	}

	public void setHospitalId(Integer hospitalId) {
		this.hospitalId = hospitalId;
	}
	
	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public Integer getPrice() {
		return price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}
}
