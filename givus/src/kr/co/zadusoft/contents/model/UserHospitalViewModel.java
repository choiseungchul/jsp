/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;

public class UserHospitalViewModel extends BaseModel{

	@DBField
	private Integer userId;
	
	@DBField
	private Integer hospitalId;
	
	@DBField
	private Date viewDate;
	
	@DBField
	private Integer viewCount;

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getHospitalId() {
		return hospitalId;
	}

	public void setHospitalId(Integer hospitalId) {
		this.hospitalId = hospitalId;
	}

	public Date getViewDate() {
		return viewDate;
	}

	public void setViewDate(Date viewDate) {
		this.viewDate = viewDate;
	}

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}
}
