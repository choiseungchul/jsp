/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;
import dynamic.web.model.ManagedBaseModel;

public class StatisticsModel extends BaseModel{
	
	@DBField
	private Date statsDate;
	
	@DBField
	private Integer userLoginCount;
	
	@DBField
	private Integer hospitalLoginCount;
	
	@DBField
	private Integer userSignUpCount;
	
	@DBField
	private Integer hospitalSignUpCount;
	
	@DBField
	private Integer userWithdrawCount;
	
	@DBField
	private Integer hospitalWithdrawCount;

	public Date getStatsDate() {
		return statsDate;
	}

	public void setStatsDate(Date statsDate) {
		this.statsDate = statsDate;
	}

	public Integer getUserLoginCount() {
		return userLoginCount;
	}

	public void setUserLoginCount(Integer userLoginCount) {
		this.userLoginCount = userLoginCount;
	}

	public Integer getHospitalLoginCount() {
		return hospitalLoginCount;
	}

	public void setHospitalLoginCount(Integer hospitalLoginCount) {
		this.hospitalLoginCount = hospitalLoginCount;
	}

	public Integer getUserSignUpCount() {
		return userSignUpCount;
	}

	public void setUserSignUpCount(Integer userSignUpCount) {
		this.userSignUpCount = userSignUpCount;
	}

	public Integer getHospitalSignUpCount() {
		return hospitalSignUpCount;
	}

	public void setHospitalSignUpCount(Integer hospitalSignUpCount) {
		this.hospitalSignUpCount = hospitalSignUpCount;
	}

	public Integer getUserWithdrawCount() {
		return userWithdrawCount;
	}

	public void setUserWithdrawCount(Integer userWithdrawCount) {
		this.userWithdrawCount = userWithdrawCount;
	}

	public Integer getHospitalWithdrawCount() {
		return hospitalWithdrawCount;
	}

	public void setHospitalWithdrawCount(Integer hospitalWithdrawCount) {
		this.hospitalWithdrawCount = hospitalWithdrawCount;
	}
	
	
}
