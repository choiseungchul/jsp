/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.HospitalStatsDAO;
import dynamic.web.service.BaseService;

public class HospitalStatsService extends BaseService{
	private HospitalStatsDAO hospitalStatsDAO;

	public HospitalStatsDAO getHospitalStatsDAO() {
		return hospitalStatsDAO;
	}

	public void setHospitalStatsDAO(HospitalStatsDAO hospitalStatsDAO) {
		this.hospitalStatsDAO = hospitalStatsDAO;
		setBaseDAO( hospitalStatsDAO);
	}
}
