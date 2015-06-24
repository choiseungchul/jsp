/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.UserConnectHospitalDAO;
import dynamic.web.service.BaseService;

public class UserConnectHospitalService extends BaseService{
	private UserConnectHospitalDAO userConnectHospitalDAO;

	public UserConnectHospitalDAO getUserConnectHospitalDAO() {
		return userConnectHospitalDAO;
	}

	public void setUserConnectHospitalDAO(UserConnectHospitalDAO userConnectHospitalDAO) {
		this.userConnectHospitalDAO = userConnectHospitalDAO;
		setBaseDAO( userConnectHospitalDAO);
	}
}
