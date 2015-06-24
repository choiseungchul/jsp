/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.co.zadusoft.contents.dao.PostingUserActionDAO;
import kr.co.zadusoft.contents.model.PostingUserActionModel;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.UserContext;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;
import dynamic.web.util.SessionContext;

public class PostingUserActionService extends BaseService{
	private PostingUserActionDAO postingUserActionDAO;

	public PostingUserActionDAO getPostingUserActionDAO() {
		return postingUserActionDAO;
	}

	public void setPostingUserActionDAO(PostingUserActionDAO postingUserActionDAO) {
		this.postingUserActionDAO = postingUserActionDAO;
		setBaseDAO( postingUserActionDAO);
	}
	
	public boolean isUserActionExist( int postingId, String actionType) throws DAException{
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "actionType", actionType));
		conditions.add( new SearchCondition( "postingId", postingId));
		conditions.add( new SearchCondition( "account", SessionContext.getLoginInfo().getAccount()));
		
		return exist( conditions);
	}
	
	public Object create( int postingId, String actionType) throws DAException{
		PostingUserActionModel model = new PostingUserActionModel();
		model.setPostingId( postingId);
		model.setActionType( actionType);
		model.setActionDate( new Date());
		model.setAccount( SessionContext.getLoginInfo().getAccount());
		
		return create( model);
	}
}
