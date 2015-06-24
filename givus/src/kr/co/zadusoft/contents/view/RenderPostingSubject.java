/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.view;

import java.util.Date;

import kr.co.zadusoft.contents.model.BoardModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.service.BoardService;
import dynamic.web.util.ConfigHandler;
import dynamic.web.util.ImageHandler;
import dynamic.web.view.RenderContext;
import dynamic.web.view.RenderText;

public class RenderPostingSubject extends RenderText{
	
	private static final String KEY_BOARD = "BOARD";
	private static final String CONFIG_NEW_PERIOD = "posting.new.period";
	private static final String KEY_NEW_IMAGE = "icon_new";
	private static final String KEY_FILE_IMAGE = "icon_file";
	
	private BoardService boardService;
	private ConfigHandler configHandler;
	private ImageHandler imageHandler;
	
	public BoardService getBoardService() {
		return boardService;
	}

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}
	
	public ConfigHandler getConfigHandler() {
		return configHandler;
	}

	public void setConfigHandler(ConfigHandler configHandler) {
		this.configHandler = configHandler;
	}
	
	public ImageHandler getImageHandler() {
		return imageHandler;
	}

	public void setImageHandler(ImageHandler imageHandler) {
		this.imageHandler = imageHandler;
	}

	@Override
	public Object render(Object data, Object value, RenderContext context) throws Exception {
		String subject = (String)super.render( data, value, context);;
		PostingModel model = (PostingModel)data;
		
		BoardModel bModel = (BoardModel)context.getContext( KEY_BOARD);
		if( bModel == null){
			bModel = (BoardModel)boardService.get( model.getBoardId());
		}
		// comments
		StringBuilder renderedSubject = new StringBuilder( subject);
		if( "Y".equals( bModel.getUseComment()) && model.getCommentCount() != null && model.getCommentCount() > 0){
			renderedSubject.append("<span class='posting-list-commentcount'> (").append( model.getCommentCount()).append( ")</span>");
		}
		// new image
		String szNewPeriod = configHandler.getProperty( CONFIG_NEW_PERIOD);
		if( szNewPeriod != null){
			long newPeriod = Integer.parseInt( szNewPeriod.trim()) * 24 * 60 * 60 * 1000;
			Date now = new Date();
			if( now.getTime() - model.getCreateDate().getTime() < newPeriod){
				renderedSubject.append( " <img src='").append( imageHandler.getImageUrl( KEY_NEW_IMAGE)).append("'>");
			}
		}
		// has attachment file
		if( "Y".equals( bModel.getUseAttachmentFile()) && model.getFileCount() != null && model.getFileCount() > 0){
			renderedSubject.append( " <img src='").append( imageHandler.getImageUrl( KEY_FILE_IMAGE)).append("'>");
		}
		
		return renderedSubject.toString();
	}
}
