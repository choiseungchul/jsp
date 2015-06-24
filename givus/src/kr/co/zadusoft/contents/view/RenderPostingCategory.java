/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.zadusoft.contents.model.CodeModel;
import kr.co.zadusoft.contents.model.PostingCategoryModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.service.PostingCategoryService;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.HttpServiceContext;
import dynamic.web.resource.Constants;
import dynamic.web.view.RenderCombo;
import dynamic.web.view.RenderContext;

public class RenderPostingCategory extends RenderCombo{
	private PostingCategoryService postingCategoryService;
	
	public PostingCategoryService getPostingCategoryService() {
		return postingCategoryService;
	}

	public void setPostingCategoryService( PostingCategoryService postingCategoryService) {
		this.postingCategoryService = postingCategoryService;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void init( Object data) throws Exception
	{
		// 글분류 를 준비한다.
		PostingModel model = (PostingModel)data;
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition("boardId", model.getBoardId()));
		conditions.add( new SearchCondition("isDelete", Constants.NO));
		List<PostingCategoryModel> pcModels = postingCategoryService.search( conditions);
		
		Map<String, String> items = new HashMap<String,String>();
		if( pcModels != null){
			for( PostingCategoryModel pcModel : pcModels){
				items.put( String.valueOf(pcModel.getId()), pcModel.getName());
			}
		}
		
		HttpServletRequest request = HttpServiceContext.getRequest();
		if( request != null)
			request.setAttribute( getName() + "_items", items);
	}
	
	@Override
	public Object render(Object data, Object value, RenderContext context) throws Exception {
		PostingModel model = (PostingModel)data;
		PostingCategoryModel pcModel = null;
		if( model.getBoardId() != null && model.getCategoryId() != null){
			List<SearchCondition> conditions = new ArrayList<SearchCondition>();
			conditions.add( new SearchCondition( "boardId", model.getBoardId()));
			conditions.add( new SearchCondition( "id", model.getCategoryId()));
			
			pcModel = (PostingCategoryModel)postingCategoryService.get( conditions);
		}
		
		return pcModel != null ? pcModel.getName() : value;
	}
}
