/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.BoardModel;
import kr.co.zadusoft.contents.model.CategoryModel;
import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.model.HospitalEvaluationModel;
import kr.co.zadusoft.contents.model.PostingCategoryModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.ReviewPointsModel;
import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.service.BoardService;
import kr.co.zadusoft.contents.service.CategoryService;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.service.HospitalEvaluationService;
import kr.co.zadusoft.contents.service.PostingCategoryService;
import kr.co.zadusoft.contents.service.PostingService;
import kr.co.zadusoft.contents.service.ReviewPointsService;
import kr.co.zadusoft.contents.util.ContentsConstants;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;

import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.HttpServiceContext;
import dynamic.util.StringUtil;
import dynamic.web.controller.EditController;
import dynamic.web.dao.DAException;
import dynamic.web.func.Function;
import dynamic.web.func.FunctionException;
import dynamic.web.func.FunctionHandler;
import dynamic.web.model.BaseModel;
import dynamic.web.model.ITreeNode;
import dynamic.web.model.TreeNodeSupport;
import dynamic.web.resource.Constants;

public class ContentsEditController extends EditController{
	
	protected FileService fileService;
	protected PostingService postingService;
	protected BoardService boardService;
	protected PostingCategoryService postingCategoryService;
	protected CategoryService categoryService;
	protected ReviewPointsService reviewPointsService;
	protected HospitalEvaluationService hospitalEvaluationService;
	
	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}
	
	public PostingService getPostingService() {
		return postingService;
	}

	public void setPostingService(PostingService postingService) {
		this.postingService = postingService;
	}
	
	public BoardService getBoardService() {
		return boardService;
	}
	
	public PostingCategoryService getPostingCategoryService() {
		return postingCategoryService;
	}

	public void setPostingCategoryService(
			PostingCategoryService postingCategoryService) {
		this.postingCategoryService = postingCategoryService;
	}

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	public CategoryService getCategoryService() {
		return categoryService;
	}

	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}

	public ReviewPointsService getReviewPointsService() {
		return reviewPointsService;
	}

	public void setReviewPointsService(ReviewPointsService reviewPointsService) {
		this.reviewPointsService = reviewPointsService;
	}

	// 차후에 코어로 이전
	public HospitalEvaluationService getHospitalEvaluationService() {
		return hospitalEvaluationService;
	}

	public void setHospitalEvaluationService(
			HospitalEvaluationService hospitalEvaluationService) {
		this.hospitalEvaluationService = hospitalEvaluationService;
	}

	@Override
	protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception {
		ModelAndView mav = super.onSubmit( request, response, command, errors);
		
		String fileInfos = request.getParameter( ContentsConstants.PARAM_FILEINFOS);
		String contentsFileInfos = request.getParameter( ContentsConstants.PARAM_CONTENTSFILEINFOS);
		
		// fileInfos's string format
		// [{"id":"252","thumbnailUrl":"/givus/___/file/thumb/252/80","name":"i am a HERO e01_021.jpg","deleteUrl":"/givus/___/file/delete/252","url":"/givus/___/file/get/252","deleteType":"GET","size":237308},{"id":"253","thumbnailUrl":"/givus/___/file/thumb/253/80","name":"i am a HERO e01_022.jpg","deleteUrl":"/givus/___/file/delete/253","url":"/givus/___/file/get/253","deleteType":"GET","size":224724},]
		System.out.println( "UPLOADED FILE INFO : " + fileInfos);
		
		if( fileInfos != null && fileInfos.length() > 0){
			
			Parameter param = buildParameter(request);
			Function func = functionHandler.getFunction( param.getFunctionId());
			Integer relationId = ((BaseModel)command).getId();
			String relationType = func.getDao().getTableName();
			
			JSONArray files = (JSONArray)JSONValue.parse( fileInfos);
			for( int i=0 ; i<files.size(); i++){
				JSONObject file = (JSONObject)files.get(i);
				Integer fileId = Integer.parseInt( file.get("id").toString());
				FileModel fileModel = (FileModel)fileService.get( fileId);
				fileModel.setRelationId( relationId);
				fileModel.setRelationType( relationType);
				
				fileService.update( fileModel);
			}
			
			if( command instanceof PostingModel){
				PostingModel pmodel = (PostingModel)command;
				pmodel.setFileCount( files.size());
				
				postingService.update( pmodel);
			}
		}
		
		if( contentsFileInfos != null && contentsFileInfos.length() > 0){
			Parameter param = buildParameter(request);
			Function func = functionHandler.getFunction( param.getFunctionId());
			Integer relationId = ((BaseModel)command).getId();
			String relationType = func.getDao().getTableName() + ContentsConstants.FILE_RELATION_TYPE_CONTENTS_SUFFIX;
			
			String[] fileIds = StringUtil.separate( contentsFileInfos, ",");
			
			for( String fileId : fileIds){
				FileModel fileModel = (FileModel)fileService.get( Integer.parseInt( fileId));
				fileModel.setRelationId( relationId);
				fileModel.setRelationType( relationType);
				
				fileService.update( fileModel);
			}
		}
		
		/*Parameter param = buildParameter(request);
		if( FunctionHandler.equals( "funcPostingEditReview", param.getFunctionId())){
			ReviewPointsModel reviewPoints = ((PostingModel)command).getReviewPoints();
			reviewPoints.setPostingId( ((PostingModel)command).getId());
			
			List<SearchCondition> conditions = new ArrayList<SearchCondition>();
			conditions.add( new SearchCondition( "postingId", reviewPoints.getPostingId()));
			
			ReviewPointsModel reviewPoints_saved = (ReviewPointsModel)reviewPointsService.get( conditions);
			if ( reviewPoints_saved != null){
				reviewPoints.setId( reviewPoints_saved.getId());
				reviewPointsService.update( reviewPoints);
			}else{
				reviewPointsService.create(reviewPoints);
			}
			
			//병원평가 정보 입력
			HospitalEvaluationModel hospitalEvaluationModel = hospitalEvaluationService.setHospitalEvaluationWithReviewPoints( reviewPoints);
			
			if(  hospitalEvaluationModel.getId() == 0){
				hospitalEvaluationModel.setHospitalId( reviewPoints.getHospitalId());
				hospitalEvaluationService.create(hospitalEvaluationModel);
				//create
			}else{
				//update
				hospitalEvaluationService.update(hospitalEvaluationModel);
			}
				
			
		}*/
		
		return mav;
	}
	
	@Override
	protected Object getTargetObject(Parameter param) throws FunctionException, DAException, Exception {
		Object obj = super.getTargetObject( param);
		if( FunctionHandler.equals( "funcPostingModify", param.getFunctionId()))
		{
			Function func = functionHandler.getFunction( param.getFunctionId());
			PostingModel model = (PostingModel)obj;
			
			if( model.getFileCount() != null && model.getFileCount() > 0){
				List<SearchCondition> conditions = new ArrayList<SearchCondition>();
				conditions.add( new SearchCondition("relationType", func.getDao().getTableName()));
				conditions.add( new SearchCondition("relationId", model.getId()));
				List<FileModel> files = fileService.search( conditions);
				
				String contextPath = HttpServiceContext.getContextPath();
				for( FileModel file : files){
					JSONObject jsono = new JSONObject();
                    jsono.put("id", String.valueOf( file.getId())); 
                    jsono.put("name", file.getName());
                    jsono.put("size", file.getSize());
                    jsono.put("url", contextPath + "/___/file/get/" + file.getId());
                    jsono.put("thumbnailUrl", contextPath + "/___/file/thumb/"+ file.getId() + "/100");
                    jsono.put("deleteUrl", contextPath + "/___/file/delete/" + file.getId());
                    jsono.put("deleteType", "GET");
                    
                    file.getRenderedData().put( "json", jsono.toJSONString());
				}
				
				model.setFiles( files);
			}
			
			BoardModel board = (BoardModel)boardService.get( model.getBoardId());
			model.setBoard( board);
		}else if( FunctionHandler.equals( "funcBoardModify", param.getFunctionId())){
			BoardModel model = (BoardModel)obj;
//			if( Constants.YES.equals( model.getUsePostingCategory())){
				List<SearchCondition> conditions = new ArrayList<SearchCondition>();
				conditions.add( new SearchCondition("boardId", model.getId()));
				conditions.add( new SearchCondition("isDelete", Constants.NO));
				List<PostingCategoryModel> pcmodels = postingCategoryService.search( conditions);
				model.setPostingCategoryModels( pcmodels);
//			}
		}else if( FunctionHandler.equals( "funcCategoryEdit", param.getFunctionId())){
			CategoryModel model = (CategoryModel)obj;
			List<SearchCondition> conditions = new ArrayList<SearchCondition>();
			conditions.add( new SearchCondition( "nodePath", model.getNodePath() + "%", "LIKE"));
			List<CategoryModel> categoryModels = (List<CategoryModel>)categoryService.search( -1, -1, conditions, "nodePath ASC, sortOrder ASC");
			
			CategoryModel root = CategoryModel.chainByNodePath( categoryModels);
			
			return root;
		}
		
		return obj;
	}
	
	@Override
	protected Object getNewObject(Function func) throws Exception {
		// TODO Auto-generated method stub
		Object obj = super.getNewObject( func);
		
		if( FunctionHandler.equals( "funcPostingCreate", func.getId())
				|| FunctionHandler.equals( "funcPostingCreateBoardPage", func.getId())
			//	|| FunctionHandler.equals( "funcPostingCreateHospitalBoardPage", func.getId())
			//	|| FunctionHandler.equals( "funcPostingEditEpilogue", func.getId())
			//	|| FunctionHandler.equals( "funcPostingEditReview", func.getId())
				){
			PostingModel model = (PostingModel)obj;
			
			String boardId = HttpServiceContext.getParameter( ContentsConstants.PARAM_BID);
			BoardModel board = (BoardModel)boardService.get( Integer.parseInt( boardId));
			model.setBoard( board);
			
			model.setBoardId( board.getId());
			
		}
				
		return obj;
	}
	
	
}	
