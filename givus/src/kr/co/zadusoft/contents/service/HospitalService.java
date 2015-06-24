/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.List;

import kr.co.zadusoft.contents.dao.HospitalDAO;
import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.util.ContentsParameter;
import dynamic.ibatis.util.Parameter;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;

public class HospitalService extends BaseService{
	private HospitalDAO hospitalDAO;

	public HospitalDAO getHospitalDAO() {
		return hospitalDAO;
	}

	public void setHospitalDAO(HospitalDAO hospitalDAO) {
		this.hospitalDAO = hospitalDAO;
		setBaseDAO( hospitalDAO);
	}
	
	/**
	 * @param param
	 * @return
	 * @throws DAException
	 */
	public List<HospitalModel> searchHospitalByRanking( Parameter param) throws DAException{
		return hospitalDAO.searchHospitalByRanking( param);
	}
	
	/**
	 * @param param
	 * @return
	 * @throws DAException
	 */
	public Integer countHospitalByRanking( Parameter param) throws DAException{
		return hospitalDAO.countHospitalByRanking( param);
	}
}
