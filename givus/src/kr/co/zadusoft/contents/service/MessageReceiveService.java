/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;

import kr.co.zadusoft.contents.dao.MessageReceiveDAO;
import kr.co.zadusoft.contents.model.MessageReceiveModel;
import kr.co.zadusoft.contents.model.MessageRelationModel;
import kr.co.zadusoft.contents.model.MessageSendModel;
import kr.co.zadusoft.contents.model.UserModel;
import dynamic.ibatis.util.Parameter;
import dynamic.util.HttpServiceContext;
import dynamic.util.StringUtil;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;
import dynamic.web.util.SessionContext;

public class MessageReceiveService extends BaseService{
	
	private MessageReceiveDAO messageReceiveDAO;
	
	private MessageSendService messageSendService;
	
	private MessageRelationService messageRelationService;
	
	public MessageReceiveDAO getMessageReceiveDAO() {
		return messageReceiveDAO;
	}

	public void setMessageReceiveDAO(MessageReceiveDAO messageReceiveDAO) {
		this.messageReceiveDAO = messageReceiveDAO;
		setBaseDAO( messageReceiveDAO);
	}
	
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

	/**
	 * 다수의 병원사용자에게 쪽지를 보낸다.
	 * Http Parameter : receiveUserIds, isSave(보낸편지함에 저장)
	 * @param param
	 * @throws DAException
	 */
	public MessageReceiveModel createMessageToHospitalUsers( MessageReceiveModel model) throws DAException, ServletException{
		String receiveUserIds = HttpServiceContext.getParameter( "receiveUserIds");
		String isSave = HttpServiceContext.getParameter( "isSave");
		
		// 개개의 받는 사용자별로 받은편지함에 메세지를 생성한다.
		String[] userIds = StringUtil.separate( receiveUserIds, ",");
		if( userIds != null && userIds.length > 0){
				
			UserModel umodel = (UserModel)SessionContext.getUserModel();
			List<MessageReceiveModel> mrModels = new ArrayList<MessageReceiveModel>();
			for( String userId : userIds){
				MessageReceiveModel mrModel = new MessageReceiveModel();
				mrModel.setSendUserId( umodel.getId());
				mrModel.setReceiveUserId( Integer.parseInt( userId));
				mrModel.setMessage( model.getMessage());
				
				mrModel = (MessageReceiveModel)create( mrModel);
				
				mrModels.add( mrModel);
			}
			
			// 보낸 편지함에 저장시 MessageSend 를 생성한다.
			if( "true".equals( isSave)){
				MessageSendModel msModel = new MessageSendModel();
				msModel.setSendUserId( umodel.getId());
				msModel.setReceiveUserId( receiveUserIds);
				msModel.setMessage( model.getMessage());
				
				msModel = (MessageSendModel)messageSendService.create( msModel);
				
				// 두 메세지간의 관계를 생성한다.
				for( MessageReceiveModel mrModel : mrModels){
					MessageRelationModel relationModel = new MessageRelationModel();
					relationModel.setSendMessageId( msModel.getId());
					relationModel.setReceiveMessageId( mrModel.getId());
					
					messageRelationService.create( relationModel);
				}
			}
		}
		
		return model;
	}
	
	/**
	 * 다수의 사용자에게 쪽지를 보낸다.
	 * Http Parameter : receiveUserIds, isSave(보낸편지함에 저장)
	 * @param param
	 * @throws DAException
	 */
	public MessageReceiveModel createMessageToUsers( MessageReceiveModel model) throws DAException, ServletException{
		String receiveUserIds = HttpServiceContext.getParameter( "receiveUserIds");
		String isSave = HttpServiceContext.getParameter( "isSave");
		
		// 개개의 받는 사용자별로 받은편지함에 메세지를 생성한다.
		String[] userIds = StringUtil.separate( receiveUserIds, ",");
		if( userIds != null && userIds.length > 0){
				
			UserModel umodel = (UserModel)SessionContext.getUserModel();
			List<MessageReceiveModel> mrModels = new ArrayList<MessageReceiveModel>();
			for( String userId : userIds){
				MessageReceiveModel mrModel = new MessageReceiveModel();
				mrModel.setSendUserId( umodel.getId());
				mrModel.setReceiveUserId( Integer.parseInt( userId));
				mrModel.setMessage( model.getMessage());
				
				mrModel = (MessageReceiveModel)create( mrModel);
				
				mrModels.add( mrModel);
			}
			
			// 보낸 편지함에 저장시 MessageSend 를 생성한다.
			if( "true".equals( isSave)){
				MessageSendModel msModel = new MessageSendModel();
				msModel.setSendUserId( umodel.getId());
				msModel.setReceiveUserId( receiveUserIds);
				msModel.setMessage( model.getMessage());
				
				msModel = (MessageSendModel)messageSendService.create( msModel);
				
				// 두 메세지간의 관계를 생성한다.
				for( MessageReceiveModel mrModel : mrModels){
					MessageRelationModel relationModel = new MessageRelationModel();
					relationModel.setSendMessageId( msModel.getId());
					relationModel.setReceiveMessageId( mrModel.getId());
					
					messageRelationService.create( relationModel);
				}
			}
		}
		
		return model;
	}
}
