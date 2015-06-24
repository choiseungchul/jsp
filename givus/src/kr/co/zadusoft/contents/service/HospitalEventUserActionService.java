/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.co.zadusoft.contents.dao.HospitalEventUserActionDAO;
import kr.co.zadusoft.contents.model.HospitalEventUserActionModel;
import kr.co.zadusoft.contents.model.PostingUserActionModel;
import kr.co.zadusoft.contents.model.UserModel;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;
import dynamic.web.util.SessionContext;

public class HospitalEventUserActionService extends BaseService{
	private HospitalEventUserActionDAO hospitalEventUserActionDAO;

	public HospitalEventUserActionDAO getHospitalEventUserActionDAO() {
		return hospitalEventUserActionDAO;
	}

	public void setHospitalEventUserActionDAO(HospitalEventUserActionDAO hospitalEventUserActionDAO) {
		this.hospitalEventUserActionDAO = hospitalEventUserActionDAO;
		setBaseDAO( hospitalEventUserActionDAO);
	}
	
	public boolean isUserActionExist( int hospitalEventId, String actionType) throws DAException{
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "actionType", actionType));
		conditions.add( new SearchCondition( "hospitalEventId", hospitalEventId));
		UserModel umodel = (UserModel)SessionContext.getUserModel();
		conditions.add( new SearchCondition( "userId", umodel.getId()));
		
		return exist( conditions);
	}
	
	public Object create( int hospitalEventId, String actionType) throws DAException{
		HospitalEventUserActionModel model = new HospitalEventUserActionModel();
		model.setHospitalEventId( hospitalEventId);
		model.setActionType( actionType);
		model.setActionDate( new Date());
		UserModel umodel = (UserModel)SessionContext.getUserModel();
		model.setUserId( umodel.getId());
		
		return create( model);
	}
}
