/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.model;

import java.util.List;

import dynamic.ibatis.util.DBField;
import dynamic.web.model.ManagedBaseModel;

public class PostingModel extends ManagedBaseModel{
	
	public static final String POSTING_TYPE_GENERAL = "G";
	public static final String POSTING_TYPE_QNA = "Q";
	public static final String POSTING_TYPE_RSS = "R"; // RSS 에서 이관된 게시물
	
	public static final String POSTING_SELECTFIELD_EXCEPT_CONTENTS = 
			"id, boardId, subject, postingType, email, fileCount, commentCount, viewCount, referenceURL, recommendCount, answerCommentId, categoryId, creator, createDate";

	@DBField
	private Integer boardId;
	
	@DBField
	private String subject;
	
	@DBField
	private String contents;
	
	@DBField
	private String postingType;
	
	@DBField
	private String email;
	
	@DBField
	private Integer fileCount;
	
	@DBField
	private Integer commentCount;
	
	@DBField
	private Integer viewCount = 0; // default is 0
	
	@DBField
	private String referenceURL;

	@DBField
	private Integer recommendCount = 0; // default is 0
	
	@DBField /** 채택된 답변 코멘트, Q&A 게시판에서 사용됨 */
	private Integer answerCommentId;
	
	@DBField /** 게시물 분류 BoardPostingCategory 를 참조함 */
	private Integer categoryId;
	
	@DBField
	private String customField1;
	
	@DBField
	private String customField2;
	
	@DBField
	private String customField3;
	
	@DBField
	private String customField4;
	
	private List<FileModel> files;
	
	private BoardModel board;
	
	private List<CommentModel> comments;
	
	private CommentModel answerComment; 
	
	private ReviewPointsModel reviewPoints;
	
	public Integer getBoardId() {
		return boardId;
	}

	public void setBoardId(Integer boardId) {
		this.boardId = boardId;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getPostingType() {
		return postingType;
	}
	public void setPostingType(String postingType) {
		this.postingType = postingType;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getFileCount() {
		return fileCount;
	}

	public void setFileCount(Integer fileCount) {
		this.fileCount = fileCount;
	}

	public Integer getViewCount() {
		return viewCount;
	}

	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}

	public String getReferenceURL() {
		return referenceURL;
	}

	public void setReferenceURL(String referenceURL) {
		this.referenceURL = referenceURL;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public List<FileModel> getFiles() {
		return files;
	}

	public void setFiles(List<FileModel> files) {
		this.files = files;
	}

	public Integer getRecommendCount() {
		return recommendCount;
	}

	public void setRecommendCount(Integer recommendCount) {
		this.recommendCount = recommendCount;
	}

	public BoardModel getBoard() {
		return board;
	}

	public void setBoard(BoardModel board) {
		this.board = board;
	}

	public List<CommentModel> getComments() {
		return comments;
	}

	public void setComments(List<CommentModel> comments) {
		this.comments = comments;
	}

	public Integer getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(Integer commentCount) {
		this.commentCount = commentCount;
	}

	public Integer getAnswerCommentId() {
		return answerCommentId;
	}

	public void setAnswerCommentId(Integer answerCommentId) {
		this.answerCommentId = answerCommentId;
	}

	public CommentModel getAnswerComment() {
		return answerComment;
	}

	public void setAnswerComment(CommentModel answerComment) {
		this.answerComment = answerComment;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public String getCustomField1() {
		return customField1;
	}

	public void setCustomField1(String customField1) {
		this.customField1 = customField1;
	}

	public String getCustomField2() {
		return customField2;
	}

	public void setCustomField2(String customField2) {
		this.customField2 = customField2;
	}

	public String getCustomField3() {
		return customField3;
	}

	public void setCustomField3(String customField3) {
		this.customField3 = customField3;
	}

	public String getCustomField4() {
		return customField4;
	}

	public void setCustomField4(String customField4) {
		this.customField4 = customField4;
	}

	public ReviewPointsModel getReviewPoints() {
		return reviewPoints;
	}

	public void setReviewPoints(ReviewPointsModel reviewPoints) {
		this.reviewPoints = reviewPoints;
	}
	
	
}
