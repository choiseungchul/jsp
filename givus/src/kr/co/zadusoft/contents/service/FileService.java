/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import kr.co.zadusoft.contents.dao.FileDAO;
import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.util.FileUploadHandler;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;

public class FileService extends BaseService{
	
	private FileDAO fileDAO;
	
	private FileUploadHandler fileUploadHandler;
	
	public FileDAO getFileDAO() {
		return fileDAO;
	}

	public void setFileDAO(FileDAO fileDAO) {
		this.fileDAO = fileDAO;
		setBaseDAO( fileDAO);
	}
	
	public FileUploadHandler getFileUploadHandler() {
		return fileUploadHandler;
	}

	public void setFileUploadHandler(FileUploadHandler fileUploadHandler) {
		this.fileUploadHandler = fileUploadHandler;
	}

	/**
	 * FileModel 과 연결된 물리파일을 삭제한다.
	 * @param model
	 * @return
	 */
	public boolean deletePhysicalFile( FileModel model) throws DAException{
		if( model != null){
			// delete physical file
			return fileUploadHandler.delete( model);
		}
		return false;
	}
	
	/**
	 * 관련된 파일 목록을 가져온다.
	 * @param relationType
	 * @param relationId
	 * @return
	 * @throws DAException
	 */
	public List<FileModel> getRelatedFiles( String relationType, int relationId) throws DAException{
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition("relationType", relationType));
		conditions.add( new SearchCondition("relationId", relationId));
		
		return search( conditions);
	}
}
