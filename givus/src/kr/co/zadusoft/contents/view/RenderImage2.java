/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.view;

import javax.servlet.http.HttpServletRequest;

import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.util.FileUploadHandler;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import dynamic.util.HttpServiceContext;
import dynamic.util.MethodUtil;
import dynamic.util.StringUtil;
import dynamic.web.view.Render;
import dynamic.web.view.RenderContext;

public class RenderImage2 extends Render{

	protected int width;
	
	protected int height;
	
	protected int thumbSize;
	
	protected FileUploadHandler fileUploadHandler;
	
	protected FileService fileService;
	
	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public int getThumbSize() {
		return thumbSize;
	}

	public void setThumbSize(int thumbSize) {
		this.thumbSize = thumbSize;
	}

	public FileUploadHandler getFileUploadHandler() {
		return fileUploadHandler;
	}

	public void setFileUploadHandler(FileUploadHandler fileUploadHandler) {
		this.fileUploadHandler = fileUploadHandler;
	}

	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	public String getType()
	{
		if( StringUtil.isNull(type))
			return TYPE_IMAGE;
		
		return super.getType();
	}
	
	@Override
	public Object render( Object data, Object value, RenderContext context) throws Exception
	{
		value = super.render( data, value, context);
		
		if( value == null || String.valueOf( value).length() == 0) return "";
		
		StringBuffer renderedValue = new StringBuffer();
		int imageid = Integer.parseInt( String.valueOf( value));
		
		StringBuilder thumbUrl = new StringBuilder();
		String contextPath = HttpServiceContext.getContextPath();
		if( thumbSize > 0){
			thumbUrl.append( contextPath).append( "/___/file/thumb/").append(imageid).append("/").append( thumbSize);
		}else{
			thumbUrl.append( contextPath).append( "/___/file/get/").append(imageid);
		}
		
		// IMG
		renderedValue.append("<img src='") 
		.append( thumbUrl.toString())
		.append("' ");
		if( width > 0)
		{
			renderedValue.append("width='").append(width).append("px' ");
		}
		if( height > 0)
		{
			renderedValue.append("height='").append(height).append("px' ");
		}
		renderedValue.append("'/>");
		
		return renderedValue.toString();
	}
	
	@Override
	public Object bind( Object data, Object vaule, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
		MultipartFile file = multipartRequest.getFile("file_" + getName());
		
		if( !file.isEmpty())
		{
			String path = fileUploadHandler.saveFile( file);
			
			// 파일 정보를 디비에 저장한다.
			FileModel fileModel = new FileModel();
			fileModel.setPath( path);
			fileModel.setName( file.getOriginalFilename());
			fileModel.setFileType( FileModel.FILE_TYPE_IMAGE);
			fileModel.setSize( (int)file.getSize());
			
			// relationId, relationType
			
			fileService.create( fileModel);
			
			if( thumbSize > 0){
				fileUploadHandler.createThumbnail( fileModel, thumbSize);
			}
	
			MethodUtil.bind( data, "set" + StringUtil.capitalize( getName()), fileModel.getId());
		}
		
		return data;
	}
}
