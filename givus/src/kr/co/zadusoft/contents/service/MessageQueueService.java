/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import kr.co.zadusoft.contents.dao.MessageQueueDAO;
import dynamic.web.service.BaseService;

public class MessageQueueService extends BaseService{
	private MessageQueueDAO messageQueueDAO;

	public MessageQueueDAO getMessageQueueDAO() {
		return messageQueueDAO;
	}

	public void setMessageQueueDAO(MessageQueueDAO messageQueueDAO) {
		this.messageQueueDAO = messageQueueDAO;
		setBaseDAO( messageQueueDAO);
	}
}
