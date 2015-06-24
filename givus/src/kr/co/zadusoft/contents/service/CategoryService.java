/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.zadusoft.contents.dao.CategoryDAO;
import kr.co.zadusoft.contents.model.CategoryModel;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;

public class CategoryService extends BaseService{
	private CategoryDAO categoryDAO;

	public CategoryDAO getCategoryDAO() {
		return categoryDAO;
	}

	public void setCategoryDAO(CategoryDAO categoryDAO) {
		this.categoryDAO = categoryDAO;
		setBaseDAO( categoryDAO);
	}
	
	/**
	 * 자식 카테고리중에서 가장 큰 sortOrder 값을 가져온다.
	 * sortOrder 에 따라 정렬이 이뤄지기 때문에 새로 생성되는 카테고리는 가장 큰 sortOrder 값을 갖는다. 
	 * @param nodePath
	 * @return
	 * @throws DAException
	 */
	public Integer getMaxSortOrder( String nodePath) throws DAException{
		Map<String, String> param = new HashMap<String, String>();
		param.put( "nodePath", nodePath);
		return (Integer)getCategoryDAO().queryForObject( "getMaxSortOrder", param);
	}
	
	/**
	 * Tree 형태의 카테고리를 가져온후 해당 Tree 의 Root 카테고리를 리턴한다.
	 * @param model
	 * @return root CategoryModel
	 * @throws DAException
	 */
	public CategoryModel getConnectedCategories( CategoryModel model) throws DAException{
		if( model == null) return null;
		
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "nodePath", model.getNodePath() + "%", "LIKE"));
		List<CategoryModel> categoryModels = (List<CategoryModel>)search( -1, -1, conditions, "nodePath ASC, sortOrder ASC");
		
		CategoryModel root = CategoryModel.chainByNodePath( categoryModels);
		
		return root;
	}
	
	public CategoryModel getConnectedCategories( int rootCategoryId) throws DAException{
		CategoryModel rootModel = (CategoryModel)get( rootCategoryId);
		
		return getConnectedCategories( rootModel);
	}
}
