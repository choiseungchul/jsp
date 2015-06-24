/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.BoardModel;
import kr.co.zadusoft.contents.model.MessageReceiveModel;
import kr.co.zadusoft.contents.model.MessageRelationModel;
import kr.co.zadusoft.contents.model.MessageSendModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.service.BoardService;
import kr.co.zadusoft.contents.service.MessageReceiveService;
import kr.co.zadusoft.contents.service.MessageRelationService;
import kr.co.zadusoft.contents.util.ContentsConstants;
import kr.co.zadusoft.contents.util.ContentsParameter;
import kr.co.zadusoft.contents.util.ContentsParameterHelper;

import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.DateUtil;
import dynamic.util.HttpServiceContext;
import dynamic.web.controller.ListController;
import dynamic.web.dao.BizException;
import dynamic.web.func.Function;
import dynamic.web.func.FunctionHandler;
import dynamic.web.resource.Constants;
import dynamic.web.util.MessageHandler;
import dynamic.web.util.ParameterHelper;
import dynamic.web.util.SessionContext;
import dynamic.web.view.Dispatcher;
import dynamic.web.view.Header;

public class ContentsListController extends ListController{
	
	private BoardService boardService;
	private MessageRelationService messageRelationService;
	private MessageHandler msgHandler;
	
	public BoardService getBoardService() {
		return boardService;
	}

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}
	
	public MessageRelationService getMessageRelationService() {
		return messageRelationService;
	}

	public void setMessageRelationService(
			MessageRelationService messageRelationService) {
		this.messageRelationService = messageRelationService;
	}
	
	public MessageHandler getMsgHandler() {
		return msgHandler;
	}

	public void setMsgHandler(MessageHandler msgHandler) {
		this.msgHandler = msgHandler;
	}

	public Parameter buildParameter( HttpServletRequest request) throws Exception
	{
		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
		return paramHelper.buildParameter();
	}
	
	public Parameter buildParameter( HttpServletRequest request, String fid) throws Exception
	{
		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
		return paramHelper.buildParameter( fid);
	}
	
	@Override
	public Dispatcher getDispatcher(HttpServletRequest request, HttpServletResponse response, Parameter param) throws Exception {
		
		if( FunctionHandler.equals( "funcPostingList", param.getFunctionId())){
			
			ContentsParameter contentsParam = (ContentsParameter)param;
			
			if( contentsParam.getBoardId() == null){
				throw new BizException( MessageHandler.getMessage( "contents.error.posting.list.boardidnotexist"));
			}else{
				param.addCondition( new SearchCondition( "boardId", contentsParam.getBoardId()));
			}
		}else if( FunctionHandler.equals( "funcMessageSendList", param.getFunctionId())){
			UserModel umodel = (UserModel)SessionContext.getUserModel();
			param.addCondition( new SearchCondition( "sendUserId", umodel.getId()));
		}else if( FunctionHandler.equals( "funcMessageReceiveList", param.getFunctionId())){
			UserModel umodel = (UserModel)SessionContext.getUserModel();
			param.addCondition( new SearchCondition( "receiveUserId", umodel.getId()));
		}
		
		Dispatcher dispatcher = super.getDispatcher( request, response, param);
		
		processDispatcher( dispatcher, param);
		adjustHeader( dispatcher, param);
		
		return dispatcher;
	}
	
	protected void processDispatcher( Dispatcher dispatcher, Parameter param) throws Exception{
		if( FunctionHandler.equals( "funcMessageSendList", param.getFunctionId())){
			if( dispatcher.getDatas() != null){
				int size = dispatcher.getDatas().size();
				for( int i=0; i < size; i++){
					MessageSendModel sModel = (MessageSendModel)dispatcher.getDatas().get(i);
					List<MessageRelationModel> mrModels = (List<MessageRelationModel>)messageRelationService.search( new SearchCondition( "sendMessageId", sModel.getId()));
					if( mrModels.size() > 1){
						int readCount = 0;
						for( MessageRelationModel mrModel : mrModels){
							if( mrModel.getReadDate() != null)
								readCount ++;
						}
						sModel.addRenderedData( "readDate", readCount + msgHandler.getMessage( "message.read.suffix"));
					}else{
						MessageRelationModel mrModel = mrModels.get(0);
						if( mrModel.getReadDate() != null){
							String szDate = DateUtil.formatDate( mrModel.getReadDate(), DateUtil.YYYYMMDD);
							sModel.addRenderedData( "readDate", szDate);
						}else{
							sModel.addRenderedData( "readDate", msgHandler.getMessage( "message.notread"));
						}
					}
				}
			}
		}
	}
	
	protected void adjustHeader( Dispatcher dispatcher, Parameter param) throws Exception{
		if( FunctionHandler.equals( "funcPostingList", param.getFunctionId())){
			BoardModel bmodel = (BoardModel)boardService.get( ((ContentsParameter)param).getBoardId());
			
			// 추천기능의 사용여부에 따라 recommendCount 헤더를 제거한다.
			if( Constants.NO.equals( bmodel.getUseRecommend())){
				List<Header> headers = dispatcher.getHeaders();
				Header recommendHeader = null;
				for( Header header : headers){
					if( "recommendCount".equals( header.getName())){
						recommendHeader = header;
						break;
					}
				}
				
				dispatcher.getHeaders().remove( recommendHeader);
			}
			
			// 글 구분 기능의 사용여부에 따라 categoryId 헤더를 제거한다.
			if( Constants.NO.equals( bmodel.getUsePostingCategory())){
				List<Header> headers = dispatcher.getHeaders();
				Header postingCategoryHeader = null;
				for( Header header : headers){
					if( "categoryId".equals( header.getName())){
						postingCategoryHeader = header;
						break;
					}
				}
				
				dispatcher.getHeaders().remove( postingCategoryHeader);
			}
		}
	}
}
