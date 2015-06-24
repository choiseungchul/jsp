/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.List;

import kr.co.zadusoft.contents.dao.RoleDAO;
import dynamic.web.dao.DAException;
import kr.co.zadusoft.contents.model.RoleModel;
//import dynamic.web.model.RoleModel;
import dynamic.web.service.BaseService;

public class RoleService extends BaseService{
	private RoleDAO roleDAO;

	public RoleDAO getRoleDAO() {
		return roleDAO;
	}

	public void setRoleDAO(RoleDAO roleDAO) {
		this.roleDAO = roleDAO;
		setBaseDAO( roleDAO);
	}

	public List<RoleModel> getRoleByAccount( String account) throws DAException{
		return roleDAO.getRoleByAccount( account);
	}
}
