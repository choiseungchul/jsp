/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;


import java.util.Date;

import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.dao.UserDAO;
import kr.co.zadusoft.givus.util.GivusUserContext;
import dynamic.util.UserContext;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;

public class UserService extends BaseService{
	private UserDAO userDAO;

	public UserDAO getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
		setBaseDAO( userDAO);
	}
	
	/**
	 * 사용자의 비밀번호를 체크한다.
	 * @param account
	 * @param password
	 * @return
	 * @throws DAException
	 */
	public boolean checkPassword( String account, String password) throws DAException{
		UserModel model = new UserModel();
		model.setAccount( account);
		model.setPassword( password);
		
		Integer count = (Integer)getUserDAO().queryForObject( "checkPassword", model);
		
		return count > 0;
	}
	
	public UserModel getByAccount(String account) throws DAException
	{
		return (UserModel)userDAO.get( "account", account);
	}
	
	/**
	 * 사용자의 nickname의 중복여부를 체크한다.
	 * @param nickname
	 * @return
	 * @throws DAException
	 */
	public boolean checkNickname( String nickname) throws DAException{
		UserModel model = new UserModel();
		model.setNickname(nickname);
		
		Integer count = (Integer)getUserDAO().queryForObject( "checkNickname", model);
		
		return count > 0;
	}
	/**
	 * 사용자의 account의 중복여부를 체크한다.
	 * @param account
	 * @return
	 * @throws DAException
	 */
	public boolean checkAccount( String account) throws DAException{
		UserModel model = new UserModel();
		model.setAccount( account);
		
		Integer count = (Integer)getUserDAO().queryForObject( "checkAccount", model);
		
		return count > 0;
	}
	/**
	 * 사용자의 비밀번호를 변경한다.
	 * updatePassword
	 */
	public void updatePassword( UserModel newModel) throws DAException{
		/*UserModel model = getByAccount( UserContext.getUser().getAccount());*/
		//UserModel model = getByAccount( newModel.getAccount());
		//model.setPassword( newModel.getPassword());
		newModel.setLastPasswordChangeDate( new Date());
		newModel.setUpdateDate( new Date());
		newModel.setUpdator( GivusUserContext.getUserModel().getAccount());
		
		getUserDAO().update( "updatePassword", newModel);
	}
}
