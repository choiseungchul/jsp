/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.HospitalEventDAO;
import dynamic.web.service.BaseService;

public class HospitalEventService extends BaseService{
	private HospitalEventDAO hospitalEventDAO;

	public HospitalEventDAO getHospitalEventDAO() {
		return hospitalEventDAO;
	}

	public void setHospitalEventDAO(HospitalEventDAO hospitalEventDAO) {
		this.hospitalEventDAO = hospitalEventDAO;
		setBaseDAO( hospitalEventDAO);
	}
}
