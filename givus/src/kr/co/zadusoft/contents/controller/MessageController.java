/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.MessageReceiveModel;
import kr.co.zadusoft.contents.model.MessageRelationModel;
import kr.co.zadusoft.contents.model.MessageSendModel;
import kr.co.zadusoft.contents.model.RankingModel;
import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.service.MessageReceiveService;
import kr.co.zadusoft.contents.service.MessageRelationService;
import kr.co.zadusoft.contents.service.MessageSendService;
import kr.co.zadusoft.givus.controller.GivusAuthorityException;
import kr.co.zadusoft.givus.controller.GivusEditController;
import kr.co.zadusoft.givus.util.GivusConstants;
import kr.co.zadusoft.givus.util.GivusUserContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.DateUtil;
import dynamic.web.controller.ViewController;
import dynamic.web.dao.DAException;
import dynamic.web.func.Function;
import dynamic.web.func.FunctionHandler;
import dynamic.web.util.MessageHandler;
import dynamic.web.util.ParameterHelper;
import dynamic.web.view.Dispatcher;

@Controller
@RequestMapping( value="/___/msg")
public class MessageController {
	
	@Autowired
	private MessageSendService messageSendService;
	
	@Autowired
	private MessageReceiveService messageReceiveService;
	
	@Autowired
	private MessageRelationService messageRelationService;
	
	@Autowired
	private ViewController viewController;
	
	@Autowired
	private GivusEditController editController;
	
	public MessageSendService getMessageSendService() {
		return messageSendService;
	}

	public void setMessageSendService(MessageSendService messageSendService) {
		this.messageSendService = messageSendService;
	}
	
	public MessageRelationService getMessageRelationService() {
		return messageRelationService;
	}

	public void setMessageRelationService(
			MessageRelationService messageRelationService) {
		this.messageRelationService = messageRelationService;
	}
	
	public ViewController getViewController() {
		return viewController;
	}

	public void setViewController(ViewController viewController) {
		this.viewController = viewController;
	}
	
	public MessageReceiveService getMessageReceiveService() {
		return messageReceiveService;
	}

	public void setMessageReceiveService(MessageReceiveService messageReceiveService) {
		this.messageReceiveService = messageReceiveService;
	}

	public GivusEditController getEditController() {
		return editController;
	}

	public void setEditController(GivusEditController editController) {
		this.editController = editController;
	}

	/**
	 * 쪽지 보기
	 * @param model
	 * @return
	 * @throws DAException
	 */
	@RequestMapping( value="/send/view/{sendMessageId}", method = RequestMethod.POST)
	public ModelAndView getSendMessageView( @PathVariable Integer sendMessageId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_message_send_view");
		
		// TODO 족지에 대한 열람권한이 있는지 체크
		MessageSendModel msModel = (MessageSendModel)messageSendService.get( sendMessageId);
		List<MessageRelationModel> mrModels = (List<MessageRelationModel>)messageRelationService.getReceiveInfo( msModel.getId());
		
		Function func = FunctionHandler.getFunctionByBeanId( "funcMessageSendView");
		ParameterHelper helper = new ParameterHelper( request);
		Parameter param = helper.buildParameter();
		param.setFunctionId( func.getId());
		param.setId( sendMessageId);
		
		Dispatcher dispatcher = viewController.getDispatcher( request, response, param);	
		
		mav.addObject( "receiveInfos", mrModels);
		mav.addObject( "data", dispatcher.getData());
		
		return mav;
	}
	
	/**
	 * 쪽지 보기 - 상세
	 * @param model
	 * @return
	 * @throws DAException
	 */
	@RequestMapping( value="/receive/view/{receiveMessageId}", method = RequestMethod.POST)
	public ModelAndView getReceiveMessageView( @PathVariable Integer receiveMessageId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_message_receive_view");
		
		// TODO 족지에 대한 열람권한이 있는지 체크
		MessageReceiveModel msModel = (MessageReceiveModel)messageReceiveService.get( receiveMessageId);
		
		Function func = FunctionHandler.getFunctionByBeanId( "funcMessageReceiveView");
		ParameterHelper helper = new ParameterHelper( request);
		Parameter param = helper.buildParameter();
		param.setFunctionId( func.getId());
		param.setId( receiveMessageId);
		
		Dispatcher dispatcher = viewController.getDispatcher( request, response, param);	
		
		mav.addObject( "data", dispatcher.getData());
		
		// 읽음 표시
		Date readDate = new Date();
		msModel.setReadDate( readDate);
		messageReceiveService.update( msModel);
		
		messageRelationService.update( "readDate", readDate, new SearchCondition( "receiveMessageId", receiveMessageId));
		
		return mav;
	}
	@RequestMapping( value="/create/{pageType}/{account}", method= RequestMethod.POST)
	public ModelAndView getCreateMessageViewPopup( @PathVariable String pageType, @PathVariable String account, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		return getCreateMessageViewPopup( pageType, account, null,  request,  response);
	}
	@RequestMapping( value="/create/{pageType}/{account}/{xPath}", method= RequestMethod.POST)
	public ModelAndView getCreateMessageViewPopup( @PathVariable String pageType, @PathVariable String account, @PathVariable String xPath, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_msg_popup");
		
		if ( pageType == null || pageType.equals("")){
			pageType = GivusConstants.PAGETYPE_MYPAGE;
		}
		
		//사용자 로그인 여부 설정
		UserModel umodel = GivusUserContext.getUserModel();
		if ( umodel != null && umodel.getAccount() != null ){
			mav.addObject( "userAccount", umodel.getAccount());
			mav.addObject( "userNickname", umodel.getNickname());
			mav.addObject( "userType", umodel.getUserType());
			
			if ( pageType.equals( GivusConstants.PAGETYPE_MYPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_HOSPITAL)){
				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.g"));
			}	
			else if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_GENERAL)){
				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.h"));
			}
		}
		else
		{
			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.msg.nosession"));
		}
		
		// 전체 병원사용자에게 쓰기
		Function func = FunctionHandler.getFunctionByBeanId("funcMessageToAllCreate");
		
		//TODO: 일반 사용자에게 쓰기
		/*if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE)){
			func = FunctionHandler.getFunctionByBeanId("funcMessageToGeneralUserCreate");
		}*/
		
		ParameterHelper paramHelper = new ParameterHelper( request);
		Parameter param = paramHelper.buildParameter();
		param.setFunctionId(func.getId());
		Dispatcher dispatcher = editController.getDispatcher(request, response, param);

		System.out.println("xPath="+xPath);
		xPath = xPath.replaceAll( "[+]", "/");
		System.out.println("xPath="+xPath);
		mav.addObject( "xPath", xPath);
		mav.addObject( "pageType", pageType);
		/*mav.addObject( "body_page", "givus_message_create");*/
		mav.addObject( "dispatcher", dispatcher);
		mav.addObject( "command", dispatcher.getCommand());
		
		return mav;
	}
}
