/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.AdsPositionDAO;
import dynamic.web.service.BaseService;

public class AdsPositionService extends BaseService{
	private AdsPositionDAO adsPositionDAO;

	public AdsPositionDAO getAdsPositionDAO() {
		return adsPositionDAO;
	}

	public void setAdsPositionDAO(AdsPositionDAO adsPositionDAO) {
		this.adsPositionDAO = adsPositionDAO;
		setBaseDAO( adsPositionDAO);
	}
}
