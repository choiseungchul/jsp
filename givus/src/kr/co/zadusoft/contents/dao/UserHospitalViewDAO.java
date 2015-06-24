/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.zadusoft.contents.model.HospitalModel;

import dynamic.web.dao.DAException;
import dynamic.web.dao.MybatisDAO;

public class UserHospitalViewDAO extends MybatisDAO{

	@Override
	public String getNamespace() {
		return "userhospitalview";
	}
	
	public List<HospitalModel> searchMostViewHospitalByHospitalId( int hospitalId) throws DAException{
		Map<String, Object> params = new HashMap<String, Object>();
		params.put( "hospitalId", hospitalId);
		
		return (List<HospitalModel>)queryForList( "searchMostViewHospitalByHospitalId", params);
	}
}