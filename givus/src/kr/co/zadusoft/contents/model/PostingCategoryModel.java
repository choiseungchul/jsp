/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import org.json.simple.JSONObject;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.BaseModel;
import dynamic.web.resource.Constants;

public class PostingCategoryModel extends BaseModel{
	
	@DBField
	private String name;
	
	@DBField
	private Integer boardId;

	@DBField
	private String isDelete = Constants.NO;
	
	private Integer postingCount;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getBoardId() {
		return boardId;
	}

	public void setBoardId(Integer boardId) {
		this.boardId = boardId;
	}

	public String getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
	
	public Integer getPostingCount() {
		return postingCount;
	}

	public void setPostingCount(Integer postingCount) {
		this.postingCount = postingCount;
	}

	@SuppressWarnings("unchecked")
	public JSONObject getJSONObject(){
		JSONObject jsonObj = new JSONObject();
		jsonObj.put( "id", getId());
		jsonObj.put( "name", getName());
		
		return jsonObj;
	}
}
