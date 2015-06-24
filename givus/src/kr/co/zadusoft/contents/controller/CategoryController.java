/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.CategoryModel;
import kr.co.zadusoft.contents.service.CategoryService;
import kr.co.zadusoft.contents.util.JSONUtil;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;
import dynamic.web.resource.Constants;
import dynamic.web.util.MessageHandler;

@Controller
@RequestMapping( value="/___/category")
public class CategoryController {
	
	@Autowired
	private CategoryService categoryService;

	@Autowired
	private MessageHandler msgHandler;
	
	public CategoryService getCategoryService() {
		return categoryService;
	}

	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}
	
	public MessageHandler getMsgHandler() {
		return msgHandler;
	}

	public void setMsgHandler(MessageHandler msgHandler) {
		this.msgHandler = msgHandler;
	}

	@RequestMapping( value="/compose", method = RequestMethod.POST)
	public ModelAndView createCategories( HttpServletRequest request, HttpServletResponse response) throws DAException{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		String categoryInfo = request.getParameter( "categoryInfo");
		JSONArray jsonCategory = (JSONArray)JSONValue.parse( categoryInfo);
		
		JSONObject jsonRoot = (JSONObject)jsonCategory.get( 0);
		
		// create root category
		CategoryModel categoryModel = new CategoryModel();
		String name = (String)jsonRoot.get("data");
		categoryModel.setName( name);
		categoryModel.setIsRootCategory( Constants.YES);
		categoryModel = (CategoryModel)categoryService.create( categoryModel);
		
		categoryModel.setNodePath( String.valueOf( categoryModel.getId() + "|"));
		categoryService.update( categoryModel);
		
		// create child category
		JSONArray children = (JSONArray)jsonRoot.get( "children"); 
		if( children != null){
			createChildCategoryRecursive( children, categoryModel);
		}
		
		return mav;
	}
	
	@RequestMapping( value="/rename/{id}", method = RequestMethod.POST)
	public ModelAndView updateCategoryName( @PathVariable Integer id, HttpServletRequest request, HttpServletResponse response) throws DAException{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		String newName = request.getParameter( "name");
		CategoryModel model = (CategoryModel)categoryService.get( id);
		model.setName( newName);
		categoryService.update( model);
		
		JSONObject json = new JSONObject();
		json.put( "result", "true");
		json.put( "message", msgHandler.getMessage( "category.msg.success"));
		
		mav.addObject( "result", json.toJSONString());
		
		return mav;
	}
	
	@RequestMapping( value="/remove/{id}", method = RequestMethod.POST)
	public ModelAndView deleteCategoryWithChild( @PathVariable Integer id, HttpServletRequest request, HttpServletResponse response) throws DAException{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		CategoryModel model = (CategoryModel)categoryService.get( id);
		Parameter param = new Parameter();
		param.addCondition( new SearchCondition( "nodePath", model.getNodePath() + "%", "LIKE"));
		categoryService.delete( param);
		
		JSONObject json = new JSONObject();
		json.put( "result", "true");
		json.put( "message", msgHandler.getMessage( "category.msg.success"));
		
		mav.addObject( "result", json.toJSONString());
		
		return mav;
	}
	
	@RequestMapping( value="/create/{parentId}", method = RequestMethod.POST)
	public ModelAndView createChildCategory( @PathVariable Integer parentId, HttpServletRequest request, HttpServletResponse response) throws DAException{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		String name = request.getParameter( "name");
		CategoryModel parentModel = (CategoryModel)categoryService.get( parentId);
		
		Integer sortOrder = categoryService.getMaxSortOrder( CategoryModel.genNodePath( parentModel));
		sortOrder = sortOrder != null ? sortOrder + 1 : 0;
		
		CategoryModel model = new CategoryModel();
		model.setName( name);
		model.setParentId( parentModel.getId());
		model.setSortOrder( sortOrder);
		
		model = (CategoryModel)categoryService.create( model);
		model.setNodePath( CategoryModel.genNodePath( parentModel));
		categoryService.update( model);
		
		JSONObject json = new JSONObject();
		json.put( "result", "true");
		json.put( "message", msgHandler.getMessage( "category.msg.success"));
		json.put( "id", model.getId());
		
		mav.addObject( "result", json.toJSONString());
		
		return mav;
	}
	
	@RequestMapping( value="/save", method = RequestMethod.POST)
	public ModelAndView updateCategoryInfos( @RequestParam("infos") String infos, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		JSONObject jsonResult = new JSONObject();
		try{
			JSONParser parser = new JSONParser();
			JSONArray jsonArray = (JSONArray)parser.parse( infos);
			
			for( int i=0; i<jsonArray.size(); i++){
				JSONObject jsonObj = (JSONObject)jsonArray.get( i);
				int id = Integer.parseInt( (String)jsonObj.get("id"));
				CategoryModel cmodel = (CategoryModel)categoryService.get( id);
				JSONUtil.convert( jsonObj, cmodel);
				categoryService.update( cmodel);
			}
			
			jsonResult.put( "result", "true");
			jsonResult.put( "message", msgHandler.getMessage( "category.msg.success"));
		}catch ( org.json.simple.parser.ParseException e) {
			e.printStackTrace();
			jsonResult.put( "result", "false");
			jsonResult.put( "message", e.getMessage());
		}
		
		mav.addObject( "result", jsonResult.toJSONString());
		
		return mav;
	}
	
	/**
	 * 카테고리의 이동에 대한 처리를 한다.
	 * @param parentId
	 * @param request
	 * @param response
	 * @return
	 * @throws DAException
	 */
	@RequestMapping( value="/move/{id}/{parentId}/{position}", method = RequestMethod.POST)
	public ModelAndView updateCategoryMove( @PathVariable Integer id, @PathVariable Integer parentId, @PathVariable Integer position, HttpServletRequest request, HttpServletResponse response) throws DAException{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		CategoryModel parentModel = (CategoryModel)categoryService.get( parentId);
		CategoryModel model = (CategoryModel)categoryService.get( id);
		
		// nodePath 를 업데이트 하기전 하위 카테고리를 먼저 찾는다. 
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "nodePath", model.genNodePath( model) + "%", "LIKE"));
		List<CategoryModel> children = categoryService.search( conditions);
		
		model.setNodePath( model.genNodePath( parentModel));
		model.setParentId( parentModel.getId());
		model.setSortOrder( position);

		
		if( children != null){
			for( CategoryModel child : children){
				child.setNodePath( child.genNodePath( model));
				categoryService.update( child);
			}
		}
		
		// 순위 변동에 따른 형제 카테고리의 sortOrder 변경
		conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "parentId", model.getParentId()));
		conditions.add( new SearchCondition( "sortOrder", model.getSortOrder(), ">="));
		
		List<CategoryModel> siblings = categoryService.search( conditions);
		for( CategoryModel sibling : siblings){
			sibling.setSortOrder( sibling.getSortOrder() + 1);
			categoryService.update( sibling);
		}
		
		// 이동된 카테고리의 업데이트
		categoryService.update( model);
		
		JSONObject json = new JSONObject();
		json.put( "result", "true");
		json.put( "message", msgHandler.getMessage( "category.msg.success"));
		json.put( "id", model.getId());
		
		mav.addObject( "result", json.toJSONString());
		
		return mav;
	}
	
	/**
	 * 여러개의 하위 카테고리를 생성한다.
	 * @param categories
	 * @param parent
	 * @throws DAException
	 */
	public void createChildCategoryRecursive( JSONArray categories, CategoryModel parent) throws DAException{
		if( categories != null){
			int childCount = categories.size();
			for( int i=0; i<childCount; i++){
				JSONObject category = (JSONObject)categories.get( i);
				String name = (String)category.get( "data");
				// create Category
				CategoryModel categoryModel = new CategoryModel();
				categoryModel.setName( name);
				categoryModel.setSortOrder( i);
				categoryModel.setParentId( parent.getId());
				
				categoryModel = (CategoryModel)categoryService.create( categoryModel);
				categoryModel.setNodePath( categoryModel.genNodePath( parent));
				categoryService.update( categoryModel);
				
				JSONArray children = (JSONArray)category.get( "children"); 
				if( children != null){
					createChildCategoryRecursive( children, categoryModel);
				}
			}
		}
	}
}
