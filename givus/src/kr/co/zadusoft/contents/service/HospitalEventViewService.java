/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.HospitalEventViewDAO;
import dynamic.web.service.BaseService;

public class HospitalEventViewService extends BaseService{
	private HospitalEventViewDAO hospitalEventViewDAO;

	public HospitalEventViewDAO getHospitalEventViewDAO() {
		return hospitalEventViewDAO;
	}

	public void setHospitalEventViewDAO(HospitalEventViewDAO hospitalEventViewDAO) {
		this.hospitalEventViewDAO = hospitalEventViewDAO;
		setBaseDAO( hospitalEventViewDAO);
	}
}
