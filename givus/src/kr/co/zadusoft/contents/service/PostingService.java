/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.regexp.RE;
import org.apache.regexp.RECompiler;

import kr.co.zadusoft.contents.dao.PostingDAO;
import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.PostingUserActionModel;
import kr.co.zadusoft.contents.util.ContentsConstants;
import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.PlainSearchCondition;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.StringUtil;
import dynamic.web.dao.DAException;
import dynamic.web.service.BaseService;

public class PostingService extends BaseService{
	private PostingDAO postingDAO;

	private FileService fileService;
	
	private PostingUserActionService postingUserActionService;
	
	public PostingDAO getPostingDAO() {
		return postingDAO;
	}

	public void setPostingDAO(PostingDAO postingDAO) {
		this.postingDAO = postingDAO;
		setBaseDAO( postingDAO);
	}
	
	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}
	
	public PostingUserActionService getPostingUserActionService() {
		return postingUserActionService;
	}

	public void setPostingUserActionService(
			PostingUserActionService postingUserActionService) {
		this.postingUserActionService = postingUserActionService;
	}

	@Override
	public void update(Object obj) throws DAException {
		PostingModel pmodel = (PostingModel)obj;
		
		// 업데이트시 posting_contents 파일을 체크하여 내용중에 존재하는 posting_contents 만 남기도 존재하지 않는 posting_contents 파일은 제거한다.
		final String format = "/___/file/get/([0-9]+)";
		Pattern pattern = Pattern.compile( format);
		Matcher match = pattern.matcher( pmodel.getContents());
		List<String> fileIds = new ArrayList<String>();
		while( match.find()){
			fileIds.add( match.group( 1));
		}
		
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( new SearchCondition( "relationId", pmodel.getId()));
		conditions.add( new SearchCondition( "relationType", "posting_contents"));
		if( !fileIds.isEmpty()){
			conditions.add( new PlainSearchCondition( "id NOT IN (" + StringUtil.join( fileIds, ",") + ")"));
		}
		List<FileModel> fmodels = fileService.search( conditions);
		// 포스팅 내용에서 제거된 업로드 파일을 제거해 준다.
		if( fmodels != null){
			for( FileModel fileModel : fmodels){
				// delete physical file
				fileService.deletePhysicalFile( fileModel);
				
				// delete file model
				fileService.delete( fileModel.getId());
			}
		}
		
		super.update( obj);
	}
	
	@Override
	public void delete(int id) throws DAException {
		// DELETE PostingUserAction
		
		// DELETE FILE
		deleteRelatedFiles( id, getTableName());
		deleteRelatedFiles( id, getTableName() + ContentsConstants.FILE_RELATION_TYPE_CONTENTS_SUFFIX);
		
		// 추천받은 경우 추천된 것을 먼저 삭제
		deleteUserAction( id);
		
		
		super.delete( id);
	}
	
	protected void deleteRelatedFiles( int postingId, String relationType) throws DAException{
		List<FileModel> files = fileService.getRelatedFiles( relationType, postingId);		
		
		if( files != null){
			for( FileModel fileModel : files){
				// delete physical file
				fileService.deletePhysicalFile( fileModel);
				
				// delete file model
				fileService.delete( fileModel.getId());
			}
		}
	}
	
	protected void deleteUserAction( int postingId) throws DAException{
		SearchCondition condition = new SearchCondition( "postingId", postingId);
		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
		conditions.add( condition);
		Parameter param = new Parameter();
		param.setConditions(conditions);
		
		postingUserActionService.delete(param);
	}
}
