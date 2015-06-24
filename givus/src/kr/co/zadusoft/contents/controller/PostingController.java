/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.PostingUserActionModel;
import kr.co.zadusoft.contents.model.ReviewPointsModel;
import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.service.PostingService;
import kr.co.zadusoft.contents.service.PostingUserActionService;
import kr.co.zadusoft.contents.service.ReviewPointsService;
import kr.co.zadusoft.contents.util.ContentsParameter;
import kr.co.zadusoft.contents.util.ContentsParameterHelper;
import kr.co.zadusoft.givus.controller.GivusAuthorityPortletException;
import kr.co.zadusoft.givus.controller.GivusEditController;
import kr.co.zadusoft.givus.util.GivusConstants;
import kr.co.zadusoft.givus.util.GivusUserContext;
import kr.co.zadusoft.givus.util.GivusUtil;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.ibatis.util.EncodingUtil;
import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.PlainSearchCondition;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.HttpServiceContext;
import dynamic.web.controller.ListController;
import dynamic.web.controller.ViewController;
import dynamic.web.dao.DAException;
import dynamic.web.func.Function;
import dynamic.web.func.FunctionHandler;
import dynamic.web.util.MessageHandler;
import dynamic.web.util.ParameterHelper;
import dynamic.web.util.RenderUtil;
import dynamic.web.view.Dispatcher;

@Controller
@RequestMapping( value="/___/posting")
public class PostingController {
	
	@Autowired
	private PostingService postingService;
	
	@Autowired
	private PostingUserActionService postingUserActionService;
	
	@Autowired
	private MessageHandler msgHandler;
	
	@Autowired
	private ListController listController;
	
	@Autowired
	private ViewController viewController;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private GivusEditController givusEditController;
	
	@Autowired
	private ReviewPointsService reviewPointsService;
	
	public PostingService getPostingService() {
		return postingService;
	}

	public void setPostingService(PostingService postingService) {
		this.postingService = postingService;
	}
	
	public PostingUserActionService getPostingUserActionService() {
		return postingUserActionService;
	}

	public void setPostingUserActionService(
			PostingUserActionService postingUserActionService) {
		this.postingUserActionService = postingUserActionService;
	}

	public MessageHandler getMsgHandler() {
		return msgHandler;
	}

	public void setMsgHandler(MessageHandler msgHandler) {
		this.msgHandler = msgHandler;
	}
	
	public ListController getListController() {
		return listController;
	}

	public void setListController(ListController listController) {
		this.listController = listController;
	}
	
	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}
	
	public ViewController getViewController() {
		return viewController;
	}

	public void setViewController(ViewController viewController) {
		this.viewController = viewController;
	}

	public GivusEditController getGivusEditController() {
		return givusEditController;
	}

	public void setGivusEditController(GivusEditController givusEditController) {
		this.givusEditController = givusEditController;
	}

	public ReviewPointsService getReviewPointsService() {
		return reviewPointsService;
	}

	public void setReviewPointsService(ReviewPointsService reviewPointsService) {
		this.reviewPointsService = reviewPointsService;
	}

	/**
	 * 채택된 우수 답변을 등록한다.
	 * @param model
	 * @return
	 * @throws DAException
	 */
	@RequestMapping( value="/answer/select/{id}", method = RequestMethod.POST)
	public ModelAndView updateSelectBestAnswer( @PathVariable Integer id) throws DAException, ServletException, Exception{
		PostingModel model = (PostingModel)postingService.get( id);
		String commentId = (String)HttpServiceContext.getParameter( "commentId");
		if( commentId != null){
			model.setAnswerCommentId( Integer.parseInt( commentId));
			postingService.update( model);
		}
		
		String successLink = RenderUtil.renderLink( model, "redirect:!{xpath}");
		successLink = EncodingUtil.encodeRedirect( successLink);
		ModelAndView mav = new ModelAndView( successLink);
		
		return mav;
	}
	
	/**
	 * 해당 글을 추천한다.
	 * 추천은 한 사용자가 하나의 글에 대해 한번만 가능한다.
	 * @param model
	 * @return
	 * @throws DAException
	 */
	@RequestMapping( value="/recommend/{id}", method = RequestMethod.GET)
	public ModelAndView recommendPosting( @PathVariable Integer id, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		JSONObject json = new JSONObject();
		try{
			boolean isExist = postingUserActionService.isUserActionExist( id, PostingUserActionModel.ACTION_TYPE_RECOMMEND);
			
			if( isExist){
				json.put( "result", "false");
				json.put( "message", msgHandler.getMessage( "posting.msg.recommend_already"));
			}else{
				// 사용자의 추천 기록을 남김다.
				postingUserActionService.create( id, PostingUserActionModel.ACTION_TYPE_RECOMMEND);
				
				// recommendCount 를 1 증가시킨다.
				PostingModel pModel = (PostingModel)postingService.get( id);
				pModel.setRecommendCount( pModel.getRecommendCount() != null ? pModel.getRecommendCount() + 1 : 1);
				postingService.update( pModel);
				
				json.put( "result", "true");
				json.put( "message", msgHandler.getMessage( "posting.msg.recommend_success"));
			}
		}catch( Exception e){
			json.put( "result", "false");
			json.put( "error_message", e.getMessage());
			
			throw e;
		}
		mav.addObject( "result", json.toJSONString());
		
		return mav;
	}
	
	@RequestMapping( value="/portlet/{boardId}", method = RequestMethod.POST)
	public ModelAndView postingListPortlet( @PathVariable Integer boardId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_posting_list_portlet");
		if( boardId != null){
			
			Function func = FunctionHandler.getFunctionByBeanId( "funcPostingListPortlet");
			ContentsParameter param = (ContentsParameter)listController.buildParameter( request, func.getId());
			param.setFunctionId( func.getId());
			param.setBoardId( boardId);
			param.addCondition( new SearchCondition( "boardId", boardId));
			
			Dispatcher dispatcher = listController.getDispatcher( request, response, param);
			
			// 첨부파일중 이미지 파일을 가려낸다.
			if( dispatcher.getDatas() != null){
				int size = dispatcher.getDatas().size();
				for( int i=0; i<size; i++){
					PostingModel pmodel = (PostingModel)dispatcher.getDatas().get( i);
					List<SearchCondition> conditions = new ArrayList<SearchCondition>();
					conditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
					conditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
					conditions.add( new SearchCondition( "relationId", pmodel.getId()));
					List files = fileService.search( conditions);
					pmodel.setFiles( files);
				}
			}
			
			mav.addObject( "dispatcher", dispatcher);
		}
		
		return mav;
	}
	
	@RequestMapping( value="/portlet/{boardId}/{categoryId}", method = RequestMethod.POST)
	public ModelAndView postingListPortlet( @PathVariable Integer boardId, @PathVariable Integer categoryId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_posting_list_portlet");
		if( boardId != null){
			
			Function func = FunctionHandler.getFunctionByBeanId( "funcPostingListPortlet");
			if ( boardId == GivusConstants.BOARD_SURGERY_INFO_BOARDID){
				func = FunctionHandler.getFunctionByBeanId( "funcPostingListSurgeryInfoPortletPage");
			}
			
			ContentsParameter param = (ContentsParameter)listController.buildParameter( request, func.getId());
			param.setFunctionId( func.getId());
			param.setBoardId( boardId);
			param.addCondition( new SearchCondition( "boardId", boardId));
			param.addCondition( new SearchCondition( "categoryId", categoryId));
			
			Dispatcher dispatcher = listController.getDispatcher( request, response, param);
			
			// 첨부파일중 이미지 파일을 가려낸다.
			if( dispatcher.getDatas() != null){
				int size = dispatcher.getDatas().size();
				for( int i=0; i<size; i++){
					PostingModel pmodel = (PostingModel)dispatcher.getDatas().get( i);
					List<SearchCondition> conditions = new ArrayList<SearchCondition>();
					conditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
					conditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
					conditions.add( new SearchCondition( "relationId", pmodel.getId()));
					List files = fileService.search( conditions);
					pmodel.setFiles( files);
				}
			}
			
			mav.addObject( "dispatcher", dispatcher);
		}
		
		return mav;
	}
	
	@RequestMapping( value="/contents/{boardId}", method = RequestMethod.POST)
	public ModelAndView postingListContents( @PathVariable Integer boardId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_posting_list_contents");
		if( boardId != null){
			
			Function func = FunctionHandler.getFunctionByBeanId( "funcPostingListContents");
			ContentsParameter param = (ContentsParameter)listController.buildParameter( request, func.getId());
			param.setFunctionId( func.getId());
			param.setBoardId( boardId);
			param.addCondition( new SearchCondition( "boardId", boardId));
			
			Dispatcher dispatcher = listController.getDispatcher( request, response, param);
			
			// 첨부파일중 이미지 파일을 가려낸다.
			if( dispatcher.getDatas() != null){
				int size = dispatcher.getDatas().size();
				for( int i=0; i<size; i++){
					PostingModel pmodel = (PostingModel)dispatcher.getDatas().get( i);
					List<SearchCondition> conditions = new ArrayList<SearchCondition>();
					conditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
					conditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
					conditions.add( new SearchCondition( "relationId", pmodel.getId()));
					List files = fileService.search( conditions);
					pmodel.setFiles( files);
				}
			}
			
			mav.addObject( "dispatcher", dispatcher);
		}
		
		return mav;
	}
	@RequestMapping( value="/contents/{boardId}/{categoryId}", method = RequestMethod.POST)
	public ModelAndView postingListContents( @PathVariable Integer boardId, @PathVariable Integer categoryId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_posting_list_contents");
		if( boardId != null){
			
			Function func = FunctionHandler.getFunctionByBeanId( "funcPostingListContents");
			if ( boardId == GivusConstants.BOARD_SURGERY_INFO_BOARDID){
				func = FunctionHandler.getFunctionByBeanId( "funcPostingListSurgeryInfoPortletPage");
			}
			ContentsParameter param = (ContentsParameter)listController.buildParameter( request, func.getId());
			param.setFunctionId( func.getId());
			param.setBoardId( boardId);
			param.addCondition( new SearchCondition( "boardId", boardId));
			param.addCondition( new SearchCondition( "categoryId", categoryId));
			
			Dispatcher dispatcher = listController.getDispatcher( request, response, param);
			
			// 첨부파일중 이미지 파일을 가려낸다.
			if( dispatcher.getDatas() != null){
				int size = dispatcher.getDatas().size();
				for( int i=0; i<size; i++){
					PostingModel pmodel = (PostingModel)dispatcher.getDatas().get( i);
					List<SearchCondition> conditions = new ArrayList<SearchCondition>();
					conditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
					conditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
					conditions.add( new SearchCondition( "relationId", pmodel.getId()));
					List files = fileService.search( conditions);
					pmodel.setFiles( files);
				}
			}
			
			mav.addObject( "dispatcher", dispatcher);
		}
		
		return mav;
	}
	
	@RequestMapping( value="/detail/{postingId}", method = RequestMethod.POST)
	public ModelAndView postingInterviewDetail( @PathVariable Integer postingId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_posting_interview_detail");
			
		Function func = FunctionHandler.getFunctionByBeanId( "funcPostingView");
		Parameter param = viewController.buildParameter( request, func.getId());
		param.setId( postingId);
		param.setFunctionId( func.getId());
		
		Dispatcher dispatcher = viewController.getDispatcher( request, response, param);
		
		mav.addObject( "dispatcher", dispatcher);
		
		return mav;
	}
	
	@RequestMapping( value="/feedback/write", method = RequestMethod.POST)
	public ModelAndView postingEditFeedback( HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_feedback_popup");
			
		Function func = FunctionHandler.getFunctionByBeanId( "funcPostingEditFeedback");
		
		ParameterHelper paramHelper = new ParameterHelper( request);
		Parameter param = paramHelper.buildParameter();		
		param.setFunctionId(func.getId());
		if ( param.getXpath() == null)
			param.setXpath("");
		Dispatcher dispatcher = givusEditController.getDispatcher(request, response, param);

		
		mav.addObject( "dispatcher", dispatcher);
		mav.addObject( "command", dispatcher.getCommand());
		return mav;
	}
	
	@RequestMapping( value="/epilogue/detail/{postingId}", method=RequestMethod.POST)
	public ModelAndView postingViewHospitalEpilogue( @PathVariable Integer postingId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_hospital_epilogue_view_popup");
		
		Function func = FunctionHandler.getFunctionByBeanId( "funcPostingView");
		Parameter param = viewController.buildParameter( request, func.getId());
		param.setId( postingId);
		param.setFunctionId( func.getId());
		
		Dispatcher dispatcher = viewController.getDispatcher( request, response, param);
		
		mav.addObject( "dispatcher", dispatcher);
		
		return mav;
	}
	
	@RequestMapping( value="/epilogue/write", method = RequestMethod.POST)
	public ModelAndView postingEditEpilogue( HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_hospital_epilogue_write_popup");
		
		//사용자 로그인 여부 설정
		UserModel umodel = GivusUserContext.getUserModel();
		if ( umodel != null && umodel.getAccount() != null ){
			mav.addObject( "userAccount", umodel.getAccount());
			mav.addObject( "userNickname", umodel.getNickname());
			mav.addObject( "userType", umodel.getUserType());
		}
		else
		{
			throw new GivusAuthorityPortletException( MessageHandler.getMessage("authrity.error.epilogue.write"));
		}
		
		Function funcPostingEditEpilogue = FunctionHandler.getFunctionByBeanId( "funcPostingEditEpilogue");

		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingEditEpilogue.getId());

		param.setFunctionId(funcPostingEditEpilogue.getId());
		String hospitalId = request.getParameter("hid");

		int boardId = param.getBoardId();
//		param.addCondition( new SearchCondition( "boardId", boardId));

		Dispatcher dispatcher = givusEditController.getDispatcher(request, response, param);
		PostingModel model = (PostingModel)dispatcher.getCommand();
		if (model.getBoardId() == null) model.setBoardId(boardId);
		
		dispatcher.setCommand(model);
		model.setCustomField1( hospitalId);
		dispatcher.setCommand(model);
		
		mav.addObject( "dispatcher", dispatcher);
		mav.addObject( "command", dispatcher.getCommand());
		
		return mav;
	}
	
	@RequestMapping( value="/review/detail/{postingId}", method=RequestMethod.POST)
	public ModelAndView postingViewHospitalReview( @PathVariable Integer postingId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_hospital_review_view_popup");
		
		//평점정보 가져오기
		
		ReviewPointsModel reviewPointModel = (ReviewPointsModel) reviewPointsService.get( new SearchCondition( "postingId", postingId));
		
		int mean =  ( reviewPointModel != null) ? reviewPointsService.getMean(reviewPointModel) : 0;
		Map<String, String> reviewPoints = new HashMap<String, String>();
		
		
		if ( reviewPointModel != null){
			reviewPoints.put( "review1", GivusUtil.getReviewAnswerMessage( reviewPointModel.getEnoughDesc()));
			reviewPoints.put( "review2", GivusUtil.getReviewAnswerMessage( reviewPointModel.getConsiderNeeds()));
			reviewPoints.put( "review3", GivusUtil.getReviewAnswerMessage( reviewPointModel.getReaction()));
			reviewPoints.put( "review4", GivusUtil.getReviewAnswerMessage( reviewPointModel.getFacilities()));
			reviewPoints.put( "review5", GivusUtil.getReviewAnswerMessage( reviewPointModel.getWaitingTime()));
			reviewPoints.put( "review6", GivusUtil.getReviewAnswerMessage( reviewPointModel.getPrivacy()));
			reviewPoints.put( "review7", GivusUtil.getReviewAnswerMessage( reviewPointModel.getReliability()));
			/*reviewPoints.put( "review8", GivusUtil.getReviewAnswerMessage( reviewPointModel.getDealingWith()));*/
			reviewPoints.put( "review8", GivusUtil.getReviewAnswerMessage( reviewPointModel.getTransportation()));
			reviewPoints.put( "review9", GivusUtil.getReviewAnswerMessage( reviewPointModel.getStress()));
			reviewPoints.put( "review10", GivusUtil.getReviewAnswerMessage( reviewPointModel.getAfterSupport()));
			reviewPoints.put( "review11", GivusUtil.getReviewAnswerMessage(  reviewPointModel.getAmount()));
			reviewPoints.put( "review12", GivusUtil.getReviewAnswerMessage( reviewPointModel.getResultSatisfaction()));
		}
		
		mav.addObject( "reviewMean", mean);
		mav.addObject( "reviewPoints", reviewPoints);
		
		
		
		Function func = FunctionHandler.getFunctionByBeanId( "funcPostingView");
		Parameter param = viewController.buildParameter( request, func.getId());
		param.setId( postingId);
		param.setFunctionId( func.getId());
		
		Dispatcher dispatcher = viewController.getDispatcher( request, response, param);
		
		mav.addObject( "dispatcher", dispatcher);
		
		return mav;
	}
	
	@RequestMapping( value="/review/write", method = RequestMethod.POST)
	public ModelAndView postingEditReview( HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_hospital_review_write_popup");
		
		//사용자 로그인 여부 설정
		UserModel umodel = GivusUserContext.getUserModel();
		if ( umodel != null && umodel.getAccount() != null ){
			mav.addObject( "userAccount", umodel.getAccount());
			mav.addObject( "userNickname", umodel.getNickname());
			mav.addObject( "userType", umodel.getUserType());
		}
		else
		{
			throw new GivusAuthorityPortletException( MessageHandler.getMessage("authrity.error.review.write"));
		}
		
		Function funcPostingEditReview = FunctionHandler.getFunctionByBeanId( "funcPostingEditReview");

		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingEditReview.getId());

		param.setFunctionId(funcPostingEditReview.getId());
		String hospitalId = request.getParameter("hid");

		int boardId = param.getBoardId();

		Dispatcher dispatcher = givusEditController.getDispatcher(request, response, param);
		PostingModel model = (PostingModel)dispatcher.getCommand();
		if (model.getBoardId() == null) model.setBoardId(boardId);
				
		model.setCustomField1( hospitalId);
		// 간략 사용자 정보를 customField2에 담기 성별,닉네임,연령대
		if ( umodel !=null ) { 
			StringBuffer userInfo = new StringBuffer();
			if ( umodel.getGender() == null) umodel.setGender("F"); //성별정보가 없을때 여성으로 셋팅
			
//			int generation =  GivusUtil.getAgeGroup ( umodel.getBirthday());

//			userInfo.append( umodel.getGender()).append(",").append(umodel.getNickname()).append(",").append(generation).append("대");
//			
//			model.setCustomField2( userInfo.toString());
		}
		
		dispatcher.setCommand(model);
		
		mav.addObject( "dispatcher", dispatcher);
		mav.addObject( "command", dispatcher.getCommand());
		
		return mav;
	}
	
	@RequestMapping( value="/modify/{boardId}/{postingId}", method = RequestMethod.POST)
	public ModelAndView postingEdit( HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_hospital_epilogue_write_popup");
		
		//사용자 로그인 여부 설정
		UserModel umodel = GivusUserContext.getUserModel();
		if ( umodel != null && umodel.getAccount() != null ){
			mav.addObject( "userAccount", umodel.getAccount());
			mav.addObject( "userNickname", umodel.getNickname());
			mav.addObject( "userType", umodel.getUserType());
		}
		else
		{
			throw new GivusAuthorityPortletException( MessageHandler.getMessage("authrity.error.epilogue.write"));
		}
		
		Function funcPostingEditEpilogue = FunctionHandler.getFunctionByBeanId( "funcPostingEditEpilogue");

		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingEditEpilogue.getId());

		param.setFunctionId(funcPostingEditEpilogue.getId());
		String hospitalId = request.getParameter("hid");

		int boardId = param.getBoardId();

		Dispatcher dispatcher = givusEditController.getDispatcher(request, response, param);
		PostingModel model = (PostingModel)dispatcher.getCommand();
		if (model.getBoardId() == null) model.setBoardId(boardId);
		
		dispatcher.setCommand(model);
		model.setCustomField1( hospitalId);
		dispatcher.setCommand(model);
		
		mav.addObject( "dispatcher", dispatcher);
		mav.addObject( "command", dispatcher.getCommand());
		
		return mav;
	}
}
