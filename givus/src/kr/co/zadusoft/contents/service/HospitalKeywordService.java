/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.HospitalKeywordDAO;
import dynamic.web.service.BaseService;

public class HospitalKeywordService extends BaseService{
	private HospitalKeywordDAO hospitalKeywordDAO;

	public HospitalKeywordDAO getHospitalKeywordDAO() {
		return hospitalKeywordDAO;
	}

	public void setHospitalKeywordDAO(HospitalKeywordDAO hospitalKeywordDAO) {
		this.hospitalKeywordDAO = hospitalKeywordDAO;
		setBaseDAO( hospitalKeywordDAO);
	}
}
