/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.OperationDAO;
import dynamic.web.service.BaseService;

public class OperationService extends BaseService{
	private OperationDAO operationDAO;

	public OperationDAO getOperationDAO() {
		return operationDAO;
	}

	public void setOperationDAO(OperationDAO operationDAO) {
		this.operationDAO = operationDAO;
		setBaseDAO( operationDAO);
	}
}
