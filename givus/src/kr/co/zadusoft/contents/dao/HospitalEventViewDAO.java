/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.dao;

import dynamic.web.dao.MybatisDAO;

public class HospitalEventViewDAO extends MybatisDAO{

	@Override
	public String getNamespace() {
		return "hospitaleventview";
	}
}