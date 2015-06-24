/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.util;

import javax.servlet.http.HttpServletRequest;

import dynamic.ibatis.util.Parameter;
import dynamic.web.util.ParameterHelper;

public class ContentsParameterHelper extends ParameterHelper{
	
	public ContentsParameterHelper( HttpServletRequest request) {
		super( request);
	}
	
	@Override
	public Parameter buildParameter(String fid) throws Exception {
		ContentsParameter param = (ContentsParameter)super.buildParameter( fid);
		param.setBoardId( getParameterInt( "bid"));
		
		return param;
	}
	
	@Override
	public Parameter newParameter() {
		return new ContentsParameter();
	}
}
