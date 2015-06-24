/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.zadusoft.contents.model.MessageReceiveModel;

import dynamic.web.dao.DAException;
import dynamic.web.dao.MybatisManagedDAO;

public class MessageReceiveDAO extends MybatisManagedDAO{

	@Override
	public String getNamespace() {
		return "messagereceive";
	}
}