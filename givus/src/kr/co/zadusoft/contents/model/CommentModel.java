/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;
import dynamic.web.resource.Constants;

public class CommentModel extends ManagedBaseModel{

	@DBField
	private String contents;
	
	@DBField
	private String nodePath;
	
	@DBField
	private Integer postingId;
	
	@DBField
	private String isDelete = Constants.NO;

	private Integer depth;
	
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Integer getPostingId() {
		return postingId;
	}

	public void setPostingId(Integer postingId) {
		this.postingId = postingId;
	}

	public String getNodePath() {
		return nodePath;
	}

	public void setNodePath(String nodePath) {
		this.nodePath = nodePath;
	}

	public Integer getDepth() {
		return depth;
	}

	public void setDepth(Integer depth) {
		this.depth = depth;
	}

	public String getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
	}
}
