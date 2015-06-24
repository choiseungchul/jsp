/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.zadusoft.contents.model.PostingCategoryModel;

import dynamic.web.dao.DAException;
import dynamic.web.dao.MybatisDAO;

public class PostingCategoryDAO extends MybatisDAO{

	@Override
	public String getNamespace() {
		return "postingcategory";
	}
	
	public List<PostingCategoryModel> searchCountInPostingCategory( int boardId) throws DAException{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put( "boardId", boardId);
		
		return (List<PostingCategoryModel>)queryForList( "searchCountInPostingCategory", param);
	}
}