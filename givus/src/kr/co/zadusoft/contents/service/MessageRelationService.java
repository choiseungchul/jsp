/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.zadusoft.contents.dao.MessageRelationDAO;
import kr.co.zadusoft.contents.model.MessageRelationModel;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;

public class MessageRelationService extends BaseService{
	private MessageRelationDAO messageRelationDAO;

	public MessageRelationDAO getMessageRelationDAO() {
		return messageRelationDAO;
	}

	public void setMessageRelationDAO(MessageRelationDAO messageRelationDAO) {
		this.messageRelationDAO = messageRelationDAO;
		setBaseDAO( messageRelationDAO);
	}
	
	@SuppressWarnings("unchecked")
	public List<MessageRelationModel> getReceiveInfo( int sendMessageId) throws DAException{
		return messageRelationDAO.getReceiveInfo( sendMessageId);
	}
}
