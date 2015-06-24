/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;

public class HospitalEventUserActionModel extends BaseModel{
	
	public static final String ACTION_TYPE_RECOMMEND = "R"; // 추천
	
	@DBField
	private String actionType;
	
	@DBField
	private Date actionDate;
	
	@DBField
	private Integer userId;
	
	@DBField
	private Integer hospitalEventId;

	public String getActionType() {
		return actionType;
	}

	public void setActionType(String actionType) {
		this.actionType = actionType;
	}

	public Date getActionDate() {
		return actionDate;
	}

	public void setActionDate(Date actionDate) {
		this.actionDate = actionDate;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getHospitalEventId() {
		return hospitalEventId;
	}

	public void setHospitalEventId(Integer hospitalEventId) {
		this.hospitalEventId = hospitalEventId;
	}
}
