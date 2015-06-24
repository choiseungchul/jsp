/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;

public class PostingUserActionModel extends BaseModel {
	
	public static final String ACTION_TYPE_RECOMMEND = "R"; // 추천
	public static final String ACTION_TYPE_VIEW = "V"; // 조회
	
	@DBField
	private Integer postingId;
	
	@DBField
	private String actionType;
	
	@DBField
	private Date actionDate;
	
	@DBField
	private String account;
	
	@DBField
	private String ipaddr;

	public Integer getPostingId() {
		return postingId;
	}

	public void setPostingId(Integer postingId) {
		this.postingId = postingId;
	}

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

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getIpaddr() {
		return ipaddr;
	}

	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}
}
