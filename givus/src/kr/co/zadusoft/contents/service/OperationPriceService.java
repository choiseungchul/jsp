/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.ArrayList;
import java.util.List;

import kr.co.zadusoft.contents.dao.OperationPriceDAO;
import kr.co.zadusoft.contents.model.CategoryModel;
import kr.co.zadusoft.contents.model.OperationPriceModel;
import kr.co.zadusoft.givus.util.GivusConstants;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.NumberUtil;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;

public class OperationPriceService extends BaseService{
	private OperationPriceDAO operationPriceDAO;

	private CategoryService categoryService;
	
	public OperationPriceDAO getOperationPriceDAO() {
		return operationPriceDAO;
	}

	public void setOperationPriceDAO(OperationPriceDAO operationPriceDAO) {
		this.operationPriceDAO = operationPriceDAO;
		setBaseDAO( operationPriceDAO);
	}
	
	public CategoryService getCategoryService() {
		return categoryService;
	}

	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}

	/**
	 * 병원의 수술 가격을 Category 형태로 가져온다.
	 * @param hospitalId
	 * @return
	 * @throws DAException
	 */
	public CategoryModel getOperationPriceCategory( int hospitalId) throws DAException{
		return getOperationPriceCategory( hospitalId, null);
	}
	
	/**
	 * 병원의 수술 가격을 Category 형태로 가져온다.
	 * @param hospitalId
	 * @return
	 * @throws DAException
	 */
	public CategoryModel getOperationPriceCategory( int hospitalId, String numberFormat) throws DAException{
		CategoryModel rootCategory = getCategoryService().getConnectedCategories( GivusConstants.ROOTCATEGORYID_OPERATION);
		
		// search OperationPrice
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "hospitalId", hospitalId));
		
		List<OperationPriceModel> operationPriceModels = search( conditions);
		if( operationPriceModels != null){
			for( OperationPriceModel operationPriceModel : operationPriceModels){
				CategoryModel categoryModel = (CategoryModel)rootCategory.getChildById( operationPriceModel.getCategoryId());
				if( categoryModel != null){
					String price = null;
					if( numberFormat != null){
						price = NumberUtil.formatNumber( operationPriceModel.getPrice(), numberFormat);
					}else{
						price = String.valueOf( operationPriceModel.getPrice());
					}
					categoryModel.getRenderedData().put( "price", price);
				}
			}
		}
		
		return rootCategory;
	}
}
