/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.KeywordDAO;
import dynamic.web.service.BaseService;

public class KeywordService extends BaseService{
	private KeywordDAO keywordDAO;

	public KeywordDAO getKeywordDAO() {
		return keywordDAO;
	}

	public void setKeywordDAO(KeywordDAO keywordDAO) {
		this.keywordDAO = keywordDAO;
		setBaseDAO( keywordDAO);
	}
}
