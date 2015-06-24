/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.view;

import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.service.UserService;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.model.BaseModel;
import dynamic.web.view.RenderContext;
import dynamic.web.view.RenderText;

public class RenderUserAccount extends RenderText{
	
	private UserService userService;

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	@Override
	public Object render(Object data, Object value, RenderContext context) throws Exception {
		
		BaseModel base = (BaseModel)data;
		
		UserModel umodel = (UserModel)userService.get( new SearchCondition("account", value));
		
		String renderedValue = (String)value;
		if( umodel != null){
			renderedValue = umodel.getName();
		}
		
		// 사용자 버튼을 추가한다. (예> 쪽지 보내기 등)
		StringBuilder sbResult = new StringBuilder();
		sbResult.append( "<a class='context-menu-one' style='cursor:pointer;' ").append("data-account='").append( value).append("'>").append( renderedValue).append("</a>");
		
		return sbResult.toString();
	}
}
