/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.AdvertisementDAO;
import dynamic.web.service.BaseService;

public class AdvertisementService extends BaseService{
	private AdvertisementDAO advertisementDAO;

	public AdvertisementDAO getAdvertisementDAO() {
		return advertisementDAO;
	}

	public void setAdvertisementDAO(AdvertisementDAO advertisementDAO) {
		this.advertisementDAO = advertisementDAO;
		setBaseDAO( advertisementDAO);
	}
}
