/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.zadusoft.contents.dao.UserHospitalViewDAO;
import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.model.UserHospitalViewModel;
import kr.co.zadusoft.contents.model.UserModel;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.DateUtil;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;
import dynamic.web.util.SessionContext;

public class UserHospitalViewService extends BaseService{
	private UserHospitalViewDAO userHospitalViewDAO;

	private HospitalService hospitalService;
	
	public UserHospitalViewDAO getUserHospitalViewDAO() {
		return userHospitalViewDAO;
	}

	public void setUserHospitalViewDAO(UserHospitalViewDAO userHospitalViewDAO) {
		this.userHospitalViewDAO = userHospitalViewDAO;
		setBaseDAO( userHospitalViewDAO);
	}
	
	public HospitalService getHospitalService() {
		return hospitalService;
	}

	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}

	/**
	 * 사용자의 병원 정보보기 기록을 남긴다. 
	 * @param hospitalId
	 * @return
	 * @throws DAException
	 */
	public Object createViewHistory( int hospitalId) throws DAException {
		// TODO Auto-generated method stub
		UserModel umodel = (UserModel)SessionContext.getUserModel();
		
		if( umodel != null){
			// 방문기록은 하루 한번 남긴다.
			String today = DateUtil.formatDate( new Date(), DateUtil.YYYYMMDD);
	
			List<SearchCondition> conditions = new ArrayList<SearchCondition>();
			conditions.add( new SearchCondition( "DATE( viewDate)", today));
			conditions.add( new SearchCondition( "hospitalId", hospitalId));
			conditions.add( new SearchCondition( "userId", umodel.getId())); // for test
			
			UserHospitalViewModel model = (UserHospitalViewModel)get( conditions);
			if( model == null){
				model = new UserHospitalViewModel();
				model.setUserId( umodel.getId());
				model.setHospitalId( hospitalId);
				model.setViewDate( new Date());
				model.setViewCount( 1);
				
				create( model);
				
				// viewCount 를 증가시킨다.
				HospitalModel hmodel = (HospitalModel)hospitalService.get( hospitalId);
				hmodel.setViewCount( hmodel.getViewCount() != null ? hmodel.getViewCount() + 1 : 1);
				hospitalService.update( hmodel);
			}else{
				model.setViewCount( model.getViewCount() + 1);
				update( model);
			}
			
			return model;
		}
		
		return null;
	}
	
	/**
	 * 해당 병원의 정보를 조회한 사용자가 가장 많이 조회한 병원의 리스트를 3개 가져온다.
	 * @param hospitalId
	 * @return
	 * @throws DAException
	 */
	public List<HospitalModel> searchMostViewHospitalByHospitalId( int hospitalId) throws DAException{
		return userHospitalViewDAO.searchMostViewHospitalByHospitalId( hospitalId);
	}
}
