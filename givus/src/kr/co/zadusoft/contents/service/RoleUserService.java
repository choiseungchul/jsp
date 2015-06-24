/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;


import kr.co.zadusoft.contents.dao.RoleUserDAO;
import dynamic.web.service.BaseService;

public class RoleUserService extends BaseService{
	private RoleUserDAO roleUserDAO;

	public RoleUserDAO getRoleUserDAO() {
		return roleUserDAO;
	}

	public void setRoleUserDAO(RoleUserDAO roleUserDAO) {
		this.roleUserDAO = roleUserDAO;
		setBaseDAO( roleUserDAO);
	}
}
