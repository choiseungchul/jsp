/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.util;

import java.util.ArrayList;
import java.util.List;

import dynamic.web.model.ITreeNode;

import kr.co.zadusoft.contents.model.CategoryModel;

public class CategoryUtil {
	
	/**
	 * 카테고리의 모든 자식을 리턴한다.
	 * @param rootCategory
	 * @return
	 */
	public static List<CategoryModel> getAllChildren( CategoryModel rootCategory){
		List<CategoryModel> children = new ArrayList<CategoryModel>();
		getChildrenRecursive( rootCategory, children);
		return children;
	}
	
	protected static void getChildrenRecursive( ITreeNode rootCategory, List<CategoryModel> children){
		if( rootCategory != null){
			children.add( (CategoryModel)rootCategory);
			if( rootCategory.getChildren() != null){
				for( ITreeNode childCategory : rootCategory.getChildren()){
					getChildrenRecursive( childCategory, children);
				}
			}
		}
	}
}
