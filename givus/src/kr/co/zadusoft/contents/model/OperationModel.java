/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class OperationModel extends ManagedBaseModel{
	
	@DBField
	private Integer keywordId;

	public Integer getKeywordId() {
		return keywordId;
	}

	public void setKeywordId(Integer keywordId) {
		this.keywordId = keywordId;
	}
}
