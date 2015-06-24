/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.BoardDAO;
import kr.co.zadusoft.contents.model.BoardModel;
import kr.co.zadusoft.contents.model.PostingCategoryModel;
import dynamic.util.StringUtil;
import dynamic.web.dao.DAException;
import dynamic.web.resource.Constants;
import dynamic.web.service.BaseService;

public class BoardService extends BaseService{
	private BoardDAO boardDAO;
	private PostingCategoryService postingCategoryService;
	
	public BoardDAO getBoardDAO() {
		return boardDAO;
	}

	public void setBoardDAO(BoardDAO boardDAO) {
		this.boardDAO = boardDAO;
		setBaseDAO( boardDAO);
	}
	
	public PostingCategoryService getPostingCategoryService() {
		return postingCategoryService;
	}

	public void setPostingCategoryService(
			PostingCategoryService postingCategoryService) {
		this.postingCategoryService = postingCategoryService;
	}

	@Override
	public Object create(Object obj) throws DAException {
		BoardModel model = (BoardModel)super.create( obj);
		
		createPostingCategory( model);
		
		return model;
	}
	
	@Override
	public void update(Object obj) throws DAException {
		BoardModel model = (BoardModel)obj;
		
		createPostingCategory( model);
		
		super.update( obj);
	}
	
	protected void createPostingCategory( BoardModel model) throws DAException{
		if( Constants.YES.equals( model.getUsePostingCategory())){
			if( StringUtil.isNotNull( model.getPostingCategory())){
				String[] categoryNames = StringUtil.separate( model.getPostingCategory(), ",");
				for( String name : categoryNames){
					PostingCategoryModel pmodel = new PostingCategoryModel();
					pmodel.setBoardId( model.getId());
					pmodel.setName( name);
					
					postingCategoryService.create( pmodel);
				}
			}
		}
	}
}
