/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.zadusoft.contents.dao.PostingCategoryDAO;
import kr.co.zadusoft.contents.model.PostingCategoryModel;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;
import dynamic.web.resource.Constants;
import dynamic.web.service.BaseService;

public class PostingCategoryService extends BaseService{
	private PostingCategoryDAO postingCategoryDAO;

	public PostingCategoryDAO getPostingCategoryDAO() {
		return postingCategoryDAO;
	}

	public void setPostingCategoryDAO(PostingCategoryDAO postingCategoryDAO) {
		this.postingCategoryDAO = postingCategoryDAO;
		setBaseDAO( postingCategoryDAO);
	}
	
	public List<PostingCategoryModel> getByBoardId( int boardId) throws DAException{
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "boardId", boardId));
		conditions.add( new SearchCondition( "isDelete", Constants.NO));
		
		return (List<PostingCategoryModel>)search( conditions);
	}
	
	public List<PostingCategoryModel> searchCountInPostingCategory( int boardId) throws DAException{
		return postingCategoryDAO.searchCountInPostingCategory( boardId);
	}
}
