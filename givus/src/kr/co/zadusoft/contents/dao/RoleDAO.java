/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dynamic.web.dao.DAException;
import dynamic.web.dao.MybatisDAO;
import kr.co.zadusoft.contents.model.RoleModel;
//import dynamic.web.model.RoleModel;

public class RoleDAO extends MybatisDAO{

	@Override
	public String getNamespace() {
		return "role";
	}
	
	public List<RoleModel> getRoleByAccount( String account) throws DAException
	{
		Map<String, String> params = new HashMap<String, String>();
		params.put( "account", account);
		return (List<RoleModel>)queryForList( "getRoleByAccount", params);
	}
	
}