/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.UserKeywordDAO;
import dynamic.web.service.BaseService;

public class UserKeywordService extends BaseService{
	private UserKeywordDAO userKeywordDAO;

	public UserKeywordDAO getUserKeywordDAO() {
		return userKeywordDAO;
	}

	public void setUserKeywordDAO(UserKeywordDAO userKeywordDAO) {
		this.userKeywordDAO = userKeywordDAO;
		setBaseDAO( userKeywordDAO);
	}
}
