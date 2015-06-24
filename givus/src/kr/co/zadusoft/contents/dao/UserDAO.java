/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.dao;

import dynamic.web.dao.MybatisManagedDAO;

public class UserDAO extends MybatisManagedDAO{

	@Override
	public String getNamespace() {
		return "user";
	}
	
	
	
}