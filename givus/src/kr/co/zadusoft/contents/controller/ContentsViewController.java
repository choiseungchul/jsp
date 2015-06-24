/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.util.ArrayList;
import java.util.List;

import kr.co.zadusoft.contents.model.BoardModel;
import kr.co.zadusoft.contents.model.CommentModel;
import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.service.BoardService;
import kr.co.zadusoft.contents.service.CommentService;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.service.PostingService;
import kr.co.zadusoft.contents.util.ContentsConstants;
import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.StringUtil;
import dynamic.web.controller.ViewController;
import dynamic.web.dao.DAException;
import dynamic.web.func.Function;
import dynamic.web.func.FunctionException;
import dynamic.web.func.FunctionHandler;
import dynamic.web.resource.Constants;
import dynamic.web.util.AccessManager;
import dynamic.web.util.MessageHandler;

public class ContentsViewController extends ViewController{
	
	private FileService fileService;
	private PostingService postingService;
	private BoardService boardService;
	private CommentService commentService;
	private AccessManager accessManager;
	private MessageHandler msgHandler;
	
	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}
	
	public PostingService getPostingService() {
		return postingService;
	}

	public void setPostingService(PostingService postingService) {
		this.postingService = postingService;
	}
	
	public BoardService getBoardService() {
		return boardService;
	}

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	public CommentService getCommentService() {
		return commentService;
	}

	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}
	
	public AccessManager getAccessManager() {
		return accessManager;
	}

	public void setAccessManager(AccessManager accessManager) {
		this.accessManager = accessManager;
	}
	
	public MessageHandler getMsgHandler() {
		return msgHandler;
	}

	public void setMsgHandler(MessageHandler msgHandler) {
		this.msgHandler = msgHandler;
	}

	@Override
	public Object getData(Parameter param, Function func) throws DAException {
		Object data = super.getData( param, func);
		
		try{
			if( FunctionHandler.equals( "funcPostingView", func.getId())
					||  FunctionHandler.equals( "funcPostingViewHowToUseGivus", func.getId())){
				PostingModel pmodel = (PostingModel)data;
				
				// 조회수를 증가시킨다.
				pmodel.setViewCount( pmodel.getViewCount() == null ? 1 : pmodel.getViewCount() + 1);
				postingService.update( pmodel);
				
				// 파일목록을 가져온다.
				if( pmodel.getFileCount() != null && pmodel.getFileCount() > 0){
					List<SearchCondition> conditions = new ArrayList<SearchCondition>();
					conditions.add( new SearchCondition( "relationType", "posting"));
					conditions.add( new SearchCondition( "relationId", pmodel.getId()));
					
					List<FileModel> files = fileService.search( conditions);
					
					pmodel.setFiles( files);
				}
				
				// 게시판 정보를 가져온다.
				BoardModel board = (BoardModel)boardService.get( pmodel.getBoardId());
				pmodel.setBoard( board);
				
				if( Constants.YES.equals( board.getUseRecommend())){
					
				}
				
				// 코멘트 정보를 가져온다.
				if( Constants.YES.equals( board.getUseComment())){
					List<CommentModel> comments = commentService.search( new SearchCondition("postingId", pmodel.getId()), "nodePath ASC");
					if( comments != null){
						// render Comments
						Function funcCommentView = FunctionHandler.getFunctionByBeanId( "funcCommentView");
						try{
							renderHandler.renderData( comments, funcCommentView.getRenders());
						}catch( Exception e){
							e.printStackTrace();
						}
						// calcurate depth
						for( CommentModel cmodel : comments){
							if( cmodel.getNodePath() != null)
								cmodel.setDepth( StringUtil.count( cmodel.getNodePath(), ContentsConstants.NODEPATH_DELIMETER));
							if( accessManager.isOwner( cmodel)){
								cmodel.getRenderedData().put( "isOwner", "Y");
							}
							if( Constants.YES.equals(cmodel.getIsDelete())){
								cmodel.getRenderedData().put( "contents", msgHandler.getMessage("comment.contents.isdeletedcomment"));
							}
							
							// find best answer
							if( pmodel.getAnswerCommentId() != null && cmodel.getId() ==  pmodel.getAnswerCommentId()){
								pmodel.setAnswerComment( cmodel);
							}
						}
						pmodel.setComments( comments);
					}
				}
			}
		}catch( FunctionException e){
			throw new DAException( e);
		}
		
		return data;
	}
}
