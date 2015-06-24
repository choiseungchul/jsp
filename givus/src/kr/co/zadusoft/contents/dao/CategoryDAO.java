/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.dao;

import java.util.HashMap;
import java.util.Map;

import dynamic.web.dao.DAException;
import dynamic.web.dao.MybatisManagedDAO;

public class CategoryDAO extends MybatisManagedDAO{

	@Override
	public String getNamespace() {
		return "category";
	}
}