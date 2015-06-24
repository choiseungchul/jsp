/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.ZipcodeDAO;
import dynamic.web.service.BaseService;

public class ZipcodeService extends BaseService{
	private ZipcodeDAO zipcodeDAO;

	public ZipcodeDAO getZipcodeDAO() {
		return zipcodeDAO;
	}

	public void setZipcodeDAO(ZipcodeDAO zipcodeDAO) {
		this.zipcodeDAO = zipcodeDAO;
		setBaseDAO( zipcodeDAO);
	}
}
