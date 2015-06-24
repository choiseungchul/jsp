/**
 * Copyright (c) 2014, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.PostingUserActionModel;
import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.service.UserService;
import kr.co.zadusoft.givus.controller.GivusAuthorityException;
import kr.co.zadusoft.givus.util.GivusConstants;
import kr.co.zadusoft.givus.util.GivusUserContext;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.util.HttpServiceContext;
import dynamic.web.controller.LogoutController;
import dynamic.web.dao.DAException;
import dynamic.web.util.MessageHandler;

@Controller
@RequestMapping( value="/___/user")
public class UserController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private LogoutController logoutController;
	
	@Autowired
	private MessageHandler msgHandler;

	public UserService getUserService() {
		return userService;
	}
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public LogoutController getLogoutController() {
		return logoutController;
	}

	public void setLogoutController(LogoutController logoutController) {
		this.logoutController = logoutController;
	}

	public MessageHandler getMsgHandler() {
		return msgHandler;
	}

	public void setMsgHandler(MessageHandler msgHandler) {
		this.msgHandler = msgHandler;
	}

	@RequestMapping( value="/checkDuplicated/{joinType}/{checkType}/{checkName}", method = RequestMethod.GET)
	public ModelAndView checkNickname( @PathVariable String joinType, @PathVariable String checkType, @PathVariable String checkName) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		JSONObject json = new JSONObject();
		
		try{
		
			UserService userService = (UserService)HttpServiceContext.getBean("userService");
			boolean isDuplicated = false;
			boolean isNickName = checkType.equals( "nickname");
			boolean isAccount = checkType.equals( "account");
			if ( isNickName)
				isDuplicated = userService.checkNickname(checkName);
			else if ( isAccount)
				isDuplicated = userService.checkAccount(checkName);
			System.out.println("isDuplicated="+isDuplicated);
			
			if( isDuplicated){
				json.put( "result", "false");
				if ( isNickName){
					if ( joinType.equals(UserModel.USER_TYPE_HOSPITAL)) { json.put( "message", msgHandler.getMessage( "병원명이 중복되었습니다."));}
					else { json.put( "message", msgHandler.getMessage( "닉네임이 중복되었습니다."));}
				}else if ( isAccount){
					json.put( "message", msgHandler.getMessage( "아이디가 중복되었습니다."));
				}
			}else{
				json.put( "result", "true");
				if ( isNickName){
					if ( joinType.equals(UserModel.USER_TYPE_HOSPITAL)) { json.put( "message", msgHandler.getMessage( "사용 가능한 병원명입니다."));}
					else {json.put( "message", msgHandler.getMessage( "사용 가능한 닉네임입니다."));}
				}
				else if ( isAccount){
					json.put( "message", msgHandler.getMessage( "사용 가능한 아이디입니다."));
				}
			}
		
		}catch( Exception e){
			json.put( "result", "false");
			json.put( "error_message", e.getMessage());
			throw e;
		}
		
		mav.addObject( "result", json.toJSONString());
		return mav;
	}

	@RequestMapping( value="/withdraw", method = RequestMethod.GET)
	public ModelAndView withdrawUser( HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		return withdrawUser( null, request, response);
	}
	@RequestMapping( value="/withdraw/{pageType}", method = RequestMethod.GET)
	public ModelAndView withdrawUser( @PathVariable String pageType, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView("givus/givus_page");
		UserModel umodel = GivusUserContext.getUserModel();
		if ( pageType == null || pageType.equals("")){
			pageType = GivusConstants.PAGETYPE_MYPAGE;
		}
		
		if ( umodel != null && umodel.getAccount() != null ){
			if ( pageType.equals( GivusConstants.PAGETYPE_MYPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_HOSPITAL)){
				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.g"));
			}	
			else if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_GENERAL)){
				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.h"));
			}
		}
		else
		{
			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.page.access"));
		}
		
		//TODO: 탈퇴 테이블 별도 관리, 이 테이블에 insert
		
		UserService userService = (UserService)HttpServiceContext.getBean("userService");
		//umodel.setUserStatus( UserModel.USER_USERSTATUS_DELETE);
		umodel.setUserStatus( UserModel.USER_USERSTATUS_LOCK);

		
		userService.update(umodel);
		
		//ModelAndView 
		mav = logoutController.handle(request, response);
		
		mav.addObject( "body_page", "givus_main");
		return mav;
	}
}
