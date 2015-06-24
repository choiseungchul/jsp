/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.view;

import kr.co.zadusoft.contents.model.MessageSendModel;
import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.service.UserService;
import dynamic.util.StringUtil;
import dynamic.web.view.RenderContext;
import dynamic.web.view.RenderText;

public class RenderMessageReceiveUserIds extends RenderText{
	
	private UserService userService;
	
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@Override
	public Object render(Object data, Object value, RenderContext context) throws Exception {
		String receiveUserIds = (String)value;
		MessageSendModel model = (MessageSendModel)data;
		
		StringBuilder renderedValue = new StringBuilder();
		String[] userIds = StringUtil.separate( receiveUserIds, ",");
		if( userIds != null){
			UserModel umodel = (UserModel)userService.get( Integer.parseInt( userIds[0]));
			renderedValue.append( umodel.getName());
			if( userIds.length > 1){
				renderedValue.append( " 외 ").append( userIds.length - 1).append( "명");
			}
		}
		
		return (String)super.render( data, renderedValue.toString(), context);
	}
}
