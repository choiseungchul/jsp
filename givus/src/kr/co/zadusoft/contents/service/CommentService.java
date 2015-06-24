/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;

import kr.co.zadusoft.contents.dao.CommentDAO;
import kr.co.zadusoft.contents.model.CommentModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.util.ContentsConstants;
import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.HttpServiceContext;
import dynamic.web.dao.DAException;
import dynamic.web.resource.Constants;
import dynamic.web.service.BaseService;
import dynamic.web.util.AccessManager;

public class CommentService extends BaseService{
	private CommentDAO commentDAO;

	private PostingService postingService;
	
	public CommentDAO getCommentDAO() {
		return commentDAO;
	}

	public void setCommentDAO(CommentDAO commentDAO) {
		this.commentDAO = commentDAO;
		setBaseDAO( commentDAO);
	}
	
	public PostingService getPostingService() {
		return postingService;
	}

	public void setPostingService(PostingService postingService) {
		this.postingService = postingService;
	}
	
	@Override
	public Object create(Object obj) throws DAException {
		CommentModel model = (CommentModel)super.create( obj);
		model.setNodePath( String.valueOf( model.getId()));
		update( model);
		
		incrementCommentCount( model);
		
		return model; 
	}
	
	@Override
	public void delete(int id) throws DAException {
		CommentModel model = (CommentModel)get(id);
		
		decrementCommentCount( model);
		
		super.delete( id);
	}
	
	/**
	 * 코멘트의 댓글을 등록한다.
	 * @param model
	 * @return
	 * @throws DAException
	 * @throws ServletException
	 */
	public Object createCommentReply( CommentModel model) throws DAException, ServletException{
		model = (CommentModel)super.create( model);
		
		String parentCommentId = (String)HttpServiceContext.getParameter( "parentCommentId");
		if( parentCommentId != null){
			CommentModel parentModel = (CommentModel)get( Integer.parseInt( parentCommentId));
			model.setNodePath( parentModel.getNodePath() + ContentsConstants.NODEPATH_DELIMETER + model.getId());
			update( model);
		}
		
		incrementCommentCount( model);
		
		return model;
	}
	
	protected void incrementCommentCount( CommentModel model) throws DAException{
		// increment PostingModel.commentCount
		PostingModel pModel = (PostingModel)postingService.get( model.getPostingId());
		pModel.setCommentCount( pModel.getCommentCount() != null ? pModel.getCommentCount() + 1 : 1);
		postingService.update( pModel);
	}
	
	protected void decrementCommentCount( CommentModel model) throws DAException{
		// decrement PostingModel.commentCount
		PostingModel pModel = (PostingModel)postingService.get( model.getPostingId());
		pModel.setCommentCount( pModel.getCommentCount() - 1);
		postingService.update( pModel);
	}
	
	/**
	 * 1. 답글이 있는 코멘트의 삭제
	 * 	- 실제 삭제하지는 않으며 isDelete 의 값을 Y 로 변경한다.
	 * 2. 답글이 없는 코멘트의 삭제
	 *  - 코멘트를 실제로 삭제한다.
	 * isDelete 필드를 Y 로 설정한다.
	 * @param param
	 * @throws DAException
	 */
	public void deleteComment( Parameter param) throws DAException{
		
		CommentModel model = (CommentModel)get( param.getId());
		
		// 답글이 있는지 체크
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "nodePath", model.getNodePath() + ContentsConstants.NODEPATH_DELIMETER + "%", "LIKE"));
		int replyCount = getCount( conditions);
		if( replyCount > 0){
			model.setIsDelete( Constants.YES);
			update( model);
		}
		else{
			delete( param.getId());
		}
	}
}
