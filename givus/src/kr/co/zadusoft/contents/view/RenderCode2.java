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
import kr.co.zadusoft.contents.service.CodeService;

import dynamic.ibatis.util.SearchCondition;
import dynamic.web.view.RenderCombo;
import dynamic.web.view.RenderContext;

public class RenderCode2 extends RenderCombo{
	private CodeService codeService;
	private String category;
	
	public CodeService getCodeService() {
		return codeService;
	}

	public void setCodeService(CodeService codeService) {
		this.codeService = codeService;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	protected Map buildItems() throws Exception{
		List<CodeModel> models = (List<CodeModel>)codeService.search( new SearchCondition("category", getCategory()));
		Map<String, String> items = new HashMap<String, String>();
		if( models != null && !models.isEmpty()){
			for( CodeModel model : models){
				items.put( model.getCode(), model.getName());
			}
		}
		return items;
	}
	
	@Override
	public Object render(Object data, Object value, RenderContext context) throws Exception {
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "category", getCategory()));
		conditions.add( new SearchCondition( "code", value));
		
		CodeModel model = (CodeModel)codeService.get( conditions);
		
		return model != null ? model.getName() : value;
	}
}
