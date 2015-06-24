/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class HospitalEventModel extends ManagedBaseModel {
	
	public static final String HOSPITALEVENT_SELECTFIELD_WITH_STATUS = 
			"id, name, fileId, startDate, endDate, now()-startDate>0 startStatus, endDate-now()>0 endStatus, eventPrice, recommendCount, hospitalId";

	@DBField
	private Date startDate;
	
	@DBField
	private Date endDate;
	
	@DBField
	private Integer eventPrice;
	
	@DBField
	private Integer oriPrice;
	
	@DBField
	private Integer recommendCount;
	
	@DBField
	private Integer hospitalId;
	
	@DBField
	private Integer fileId;
	
	@DBField
	private String description;
	
	@DBField
	private Integer startStatus;
	
	@DBField
	private Integer endStatus;
	

	private HospitalModel hospitalModel;
	
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

	public Integer getEventPrice() {
		return eventPrice;
	}

	public void setEventPrice(Integer eventPrice) {
		this.eventPrice = eventPrice;
	}

	public Integer getOriPrice() {
		return oriPrice;
	}

	public void setOriPrice(Integer oriPrice) {
		this.oriPrice = oriPrice;
	}

	public Integer getRecommendCount() {
		return recommendCount;
	}

	public void setRecommendCount(Integer recommendCount) {
		this.recommendCount = recommendCount;
	}

	public Integer getHospitalId() {
		return hospitalId;
	}

	public void setHospitalId(Integer hospitalId) {
		this.hospitalId = hospitalId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getStartStatus() {
		return startStatus;
	}

	public void setStartStatus(Integer startStatus) {
		this.startStatus = startStatus;
	}

	public Integer getEndStatus() {
		return endStatus;
	}

	public void setEndStatus(Integer endStatus) {
		this.endStatus = endStatus;
	}

	public Integer getFileId() {
		return fileId;
	}

	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}

	public HospitalModel getHospitalModel() {
		return hospitalModel;
	}

	public void setHospitalModel(HospitalModel hospitalModel) {
		this.hospitalModel = hospitalModel;
	}
}
