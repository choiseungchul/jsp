/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.ZipcodeZibunDAO;
import dynamic.web.service.BaseService;

public class ZipcodeZibunService extends BaseService{
	private ZipcodeZibunDAO zipcodeZibunDAO;

	public ZipcodeZibunDAO getZipcodeZibunDAO() {
		return zipcodeZibunDAO;
	}

	public void setZipcodeZibunDAO(ZipcodeZibunDAO zipcodeZibunDAO) {
		this.zipcodeZibunDAO = zipcodeZibunDAO;
		setBaseDAO( zipcodeZibunDAO);
	}
}
