/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.CodeDAO;
import dynamic.web.service.BaseService;

public class CodeService extends BaseService{
	private CodeDAO codeDAO;

	public CodeDAO getCodeDAO() {
		return codeDAO;
	}

	public void setCodeDAO(CodeDAO codeDAO) {
		this.codeDAO = codeDAO;
		setBaseDAO( codeDAO);
	}
}
