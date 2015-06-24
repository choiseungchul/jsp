/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.List;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;
import dynamic.web.resource.Constants;

public class BoardModel extends ManagedBaseModel{
	
	public static final String BOARD_TYPE_GENERAL = "G"; // 일반 게시판
	public static final String BOARD_TYPE_QNA = "Q"; // Q&A 게시판
	
	@DBField
	private String boardType = BOARD_TYPE_GENERAL;

	@DBField
	private String useAttachmentFile = Constants.YES;
	
	@DBField
	private String useComment = Constants.YES;
	
	@DBField
	private String useRecommend = Constants.YES;
	
	@DBField
	private String usePostingCategory = Constants.NO;
	
	@DBField
	private Integer attachmentFileCount;
	
	@DBField
	private Integer attachmentFileSize;
	
	@DBField
	private String description;
	
	private String postingCategory;
	
	private List<PostingCategoryModel> postingCategoryModels;
	
	public String getBoardType() {
		return boardType;
	}

	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}

	public String getUseAttachmentFile() {
		return useAttachmentFile;
	}

	public void setUseAttachmentFile(String useAttachmentFile) {
		this.useAttachmentFile = useAttachmentFile;
	}

	public String getUseComment() {
		return useComment;
	}

	public void setUseComment(String useComment) {
		this.useComment = useComment;
	}

	public Integer getAttachmentFileCount() {
		return attachmentFileCount;
	}

	public void setAttachmentFileCount(Integer attachmentFileCount) {
		this.attachmentFileCount = attachmentFileCount;
	}

	public Integer getAttachmentFileSize() {
		return attachmentFileSize;
	}

	public void setAttachmentFileSize(Integer attachmentFileSize) {
		this.attachmentFileSize = attachmentFileSize;
	}

	public String getUseRecommend() {
		return useRecommend;
	}

	public void setUseRecommend(String useRecommend) {
		this.useRecommend = useRecommend;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPostingCategory() {
		return postingCategory;
	}

	public void setPostingCategory(String postingCategory) {
		this.postingCategory = postingCategory;
	}

	public String getUsePostingCategory() {
		return usePostingCategory;
	}

	public void setUsePostingCategory(String usePostingCategory) {
		this.usePostingCategory = usePostingCategory;
	}

	public List<PostingCategoryModel> getPostingCategoryModels() {
		return postingCategoryModels;
	}

	public void setPostingCategoryModels(
			List<PostingCategoryModel> postingCategoryModels) {
		this.postingCategoryModels = postingCategoryModels;
	}
}
