/**
 * Copyright (c) 2014, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class AdvertisementModel extends ManagedBaseModel {

	@DBField
	private Integer positionId;
	
	@DBField
	private Date startDate;
	
	@DBField
	private Date endDate;
	
	@DBField
	private String description;
	
	@DBField
	private Integer price;
	
	@DBField
	private Integer unitCost;
		
	public Integer getPositionId() {
		return positionId;
	}

	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}
	
	
}
