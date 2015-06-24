/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.dao;

import java.util.List;

import kr.co.zadusoft.contents.model.HospitalModel;
import dynamic.ibatis.util.Parameter;
import dynamic.web.dao.DAException;
import dynamic.web.dao.MybatisManagedDAO;

public class HospitalDAO extends MybatisManagedDAO{

	@Override
	public String getNamespace() {
		return "hospital";
	}
	
	/**
	 * @param param
	 * @return
	 * @throws DAException
	 */
	public List<HospitalModel> searchHospitalByRanking( Parameter param) throws DAException{
		return (List<HospitalModel>)queryForList( "searchHospitalByRanking", param);
	}
	
	/**
	 * @param param
	 * @return
	 * @throws DAException
	 */
	public Integer countHospitalByRanking( Parameter param) throws DAException{
		Integer count = (Integer)queryForObject( "countHospitalByRanking", param); 
		return count == null ? 0 : count;
	}
}