/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.Date;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;

public class MessageRelationModel extends BaseModel{

	@DBField
	private Integer sendMessageId;
	
	@DBField
	private Integer receiveMessageId;
	
	@DBField
	private Date readDate;

	private String receiveUserName;
	
	public Integer getSendMessageId() {
		return sendMessageId;
	}

	public void setSendMessageId(Integer sendMessageId) {
		this.sendMessageId = sendMessageId;
	}

	public Integer getReceiveMessageId() {
		return receiveMessageId;
	}

	public void setReceiveMessageId(Integer receiveMessageId) {
		this.receiveMessageId = receiveMessageId;
	}

	public Date getReadDate() {
		return readDate;
	}

	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}

	public String getReceiveUserName() {
		return receiveUserName;
	}

	public void setReceiveUserName(String receiveUserName) {
		this.receiveUserName = receiveUserName;
	}
}
