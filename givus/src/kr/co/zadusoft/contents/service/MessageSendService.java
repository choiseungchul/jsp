/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.MessageSendDAO;
import dynamic.web.service.BaseService;

public class MessageSendService extends BaseService{
	private MessageSendDAO messageSendDAO;

	public MessageSendDAO getMessageSendDAO() {
		return messageSendDAO;
	}

	public void setMessageSendDAO(MessageSendDAO messageSendDAO) {
		this.messageSendDAO = messageSendDAO;
		setBaseDAO( messageSendDAO);
	}
}
