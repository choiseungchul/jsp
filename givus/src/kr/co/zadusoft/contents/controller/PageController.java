///**
// * Copyright (c) 2013, ZADUSOFT CO. LTD,.
// * All rights reserved.
// */
//package kr.co.zadusoft.contents.controller;
//
//import java.util.ArrayList;
//import java.util.Calendar;
//import java.util.Date;
//import java.util.List;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import kr.co.zadusoft.contents.model.BoardModel;
//import kr.co.zadusoft.contents.model.CategoryModel;
//import kr.co.zadusoft.contents.model.FileModel;
//import kr.co.zadusoft.contents.model.HospitalEvaluationModel;
//import kr.co.zadusoft.contents.model.HospitalEventModel;
//import kr.co.zadusoft.contents.model.HospitalModel;
//import kr.co.zadusoft.contents.model.HospitalStatsModel;
//import kr.co.zadusoft.contents.model.PostingCategoryModel;
//import kr.co.zadusoft.contents.model.PostingModel;
//import kr.co.zadusoft.contents.model.RankingModel;
//import kr.co.zadusoft.contents.model.UserConnectHospitalModel;
//import kr.co.zadusoft.contents.model.UserModel;
//import kr.co.zadusoft.contents.service.BoardService;
//import kr.co.zadusoft.contents.service.CategoryService;
//import kr.co.zadusoft.contents.service.FileService;
//import kr.co.zadusoft.contents.service.HospitalEvaluationService;
//import kr.co.zadusoft.contents.service.HospitalEventService;
//import kr.co.zadusoft.contents.service.HospitalEventViewService;
//import kr.co.zadusoft.contents.service.HospitalService;
//import kr.co.zadusoft.contents.service.HospitalStatsService;
//import kr.co.zadusoft.contents.service.KeywordService;
//import kr.co.zadusoft.contents.service.MessageReceiveService;
//import kr.co.zadusoft.contents.service.MessageSendService;
//import kr.co.zadusoft.contents.service.OperationPriceService;
//import kr.co.zadusoft.contents.service.PostingCategoryService;
//import kr.co.zadusoft.contents.service.PostingService;
//import kr.co.zadusoft.contents.service.RankingDataService;
//import kr.co.zadusoft.contents.service.RankingService;
//import kr.co.zadusoft.contents.service.UserConnectHospitalService;
//import kr.co.zadusoft.contents.service.UserHospitalViewService;
//import kr.co.zadusoft.contents.service.UserService;
//import kr.co.zadusoft.contents.util.ContentsParameter;
//import kr.co.zadusoft.contents.util.ContentsParameterHelper;
//import kr.co.zadusoft.givus.controller.GivusAuthorityException;
//import kr.co.zadusoft.givus.controller.GivusEditController;
//import kr.co.zadusoft.givus.controller.GivusListController;
//import kr.co.zadusoft.givus.util.GivusConstants;
//import kr.co.zadusoft.givus.util.GivusUserContext;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.servlet.ModelAndView;
//
//import dynamic.ibatis.util.Parameter;
//import dynamic.ibatis.util.PlainSearchCondition;
//import dynamic.ibatis.util.SearchCondition;
//import dynamic.util.DateUtil;
//import dynamic.web.controller.EditController;
//import dynamic.web.controller.ListController;
//import dynamic.web.dao.DAException;
//import dynamic.web.func.Function;
//import dynamic.web.func.FunctionHandler;
//import dynamic.web.util.CalendarUtil;
//import dynamic.web.util.MessageHandler;
//import dynamic.web.util.ParameterHelper;
//import dynamic.web.view.Dispatcher;
//import dynamic.web.view.RenderHandler;
//
//@Controller
//@RequestMapping( value="/___/p")
//public class PageController {
//	
//	@Autowired
//	private BoardService boardService;
//
//	@Autowired
//	private PostingService postingService;
//	
//	@Autowired
//	private RenderHandler renderHandler;
//	
//	@Autowired
//	private ListController listController;
//	
//	@Autowired
//	private GivusListController glistController;
//	
//	@Autowired
//	private ContentsViewController viewController;
//	
//	@Autowired
//	private CategoryService categoryService;
//	
//	@Autowired
//	private RankingService rankingService;
//	
//	@Autowired
//	private RankingDataService rankingDataService;
//	
//	@Autowired
//	private HospitalService hospitalService;
//	
//	@Autowired
//	private EditController editController;
//	
//	@Autowired
//	private GivusEditController givusEditController;
//		
//	@Autowired
//	private KeywordService keywordService;
//	
//	@Autowired
//	private FileService fileService;
//	
//	@Autowired
//	private PostingCategoryService postingCategoryService;
//	
//	@Autowired
//	private HospitalEvaluationService hospitalEvaluationService;
//	
//	@Autowired
//	private UserHospitalViewService userHospitalViewService;
//	
//	@Autowired
//	private OperationPriceService operationPriceService;
//	
//	@Autowired
//	private MessageReceiveService messageReceiveService;
//	
//	@Autowired
//	private MessageSendService messageSendService;
//	
//	@Autowired
//	private HospitalEventViewService hospitalEventViewService;
//	
//	@Autowired
//	private HospitalEventService hospitalEventService;
//	
//	@Autowired
//	private HospitalStatsService hospitalStatsService;
//	
//	@Autowired
//	private UserConnectHospitalService userConnectHospitalService;
//	
//	@Autowired
//	private UserService userService;
//	
//	public BoardService getBoardService() {
//		return boardService;
//	}
//
//	public void setBoardService(BoardService boardService) {
//		this.boardService = boardService;
//	}
//	
//	public PostingService getPostingService() {
//		return postingService;
//	}
//
//	public void setPostingService(PostingService postingService) {
//		this.postingService = postingService;
//	}
//	
//	public RenderHandler getRenderHandler() {
//		return renderHandler;
//	}
//
//	public void setRenderHandler(RenderHandler renderHandler) {
//		this.renderHandler = renderHandler;
//	}
//
//	public ListController getListController() {
//		return listController;
//	}
//
//	public void setListController(ListController listController) {
//		this.listController = listController;
//	}
//	
//	public GivusListController getGlistController() {
//		return glistController;
//	}
//
//	public void setGlistController(GivusListController glistController) {
//		this.glistController = glistController;
//	}
//
//	public ContentsViewController getViewController() {
//		return viewController;
//	}
//
//	public void setViewController(ContentsViewController viewController) {
//		this.viewController = viewController;
//	}
//
//	public CategoryService getCategoryService() {
//		return categoryService;
//	}
//
//	public void setCategoryService(CategoryService categoryService) {
//		this.categoryService = categoryService;
//	}
//
//	public RankingService getRankingService() {
//		return rankingService;
//	}
//
//	public void setRankingService(RankingService rankingService) {
//		this.rankingService = rankingService;
//	}
//	
//	public RankingDataService getRankingDataService() {
//		return rankingDataService;
//	}
//
//	public void setRankingDataService(RankingDataService rankingDataService) {
//		this.rankingDataService = rankingDataService;
//	}
//
//	public HospitalService getHospitalService() {
//		return hospitalService;
//	}
//
//	public void setHospitalService(HospitalService hospitalService) {
//		this.hospitalService = hospitalService;
//	}
//	
//	public EditController getEditController() {
//		return editController;
//	}
//
//	public void setEditController(EditController editController) {
//		this.editController = editController;
//	}
//
//	public PostingCategoryService getPostingCategoryService() {
//		return postingCategoryService;
//	}
//
//	public void setPostingCategoryService( PostingCategoryService postingCategoryService) {
//		this.postingCategoryService = postingCategoryService;
//	}
//	
//	public FileService getFileService() {
//		return fileService;
//	}
//
//	public void setFileService(FileService fileService) {
//		this.fileService = fileService;
//	}
//	
//	public HospitalEvaluationService getHospitalEvaluationService() {
//		return hospitalEvaluationService;
//	}
//
//	public void setHospitalEvaluationService(
//			HospitalEvaluationService hospitalEvaluationService) {
//		this.hospitalEvaluationService = hospitalEvaluationService;
//	}
//	
//	public UserHospitalViewService getUserHospitalViewService() {
//		return userHospitalViewService;
//	}
//
//	public void setUserHospitalViewService( UserHospitalViewService userHospitalViewService) {
//		this.userHospitalViewService = userHospitalViewService;
//	}
//	
//	public OperationPriceService getOperationPriceService() {
//		return operationPriceService;
//	}
//
//	public void setOperationPriceService(OperationPriceService operationPriceService) {
//		this.operationPriceService = operationPriceService;
//	}
//
//	public MessageReceiveService getMessageReceiveService() {
//		return messageReceiveService;
//	}
//
//	public void setMessageReceiveService(MessageReceiveService messageReceiveService) {
//		this.messageReceiveService = messageReceiveService;
//	}
//
//	public MessageSendService getMessageSendService() {
//		return messageSendService;
//	}
//
//	public void setMessageSendService(MessageSendService messageSendService) {
//		this.messageSendService = messageSendService;
//	}
//
//	public HospitalEventViewService getHospitalEventViewService() {
//		return hospitalEventViewService;
//	}
//
//	public void setHospitalEventViewService(
//			HospitalEventViewService hospitalEventViewService) {
//		this.hospitalEventViewService = hospitalEventViewService;
//	}
//
//	public HospitalEventService getHospitalEventService() {
//		return hospitalEventService;
//	}
//
//	public void setHospitalEventService(
//			HospitalEventService hospitalEventService) {
//		this.hospitalEventService = hospitalEventService;
//	}
//
//	public HospitalStatsService getHospitalStatsService() {
//		return hospitalStatsService;
//	}
//
//	public void setHospitalStatsService(HospitalStatsService hospitalStatsService) {
//		this.hospitalStatsService = hospitalStatsService;
//	}
//	
//	public UserConnectHospitalService getUserConnectHospitalService() {
//		return userConnectHospitalService;
//	}
//	
//	public void setUserConnectHospitalService(
//			UserConnectHospitalService userConnectHospitalService) {
//		this.userConnectHospitalService = userConnectHospitalService;
//	}
//	
//	public UserService getUserService() {
//		return userService;
//	}
//
//	public void setUserService(UserService userService) {
//		this.userService = userService;
//	}
//
//	@RequestMapping( value="/board", method = RequestMethod.GET)
//	public ModelAndView viewBoardPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewBoardPage( null, request, response);
//	}
//
//	@RequestMapping( value="/board/{boardId}", method = RequestMethod.GET)
//	public ModelAndView viewBoardPage( @PathVariable Integer boardId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewBoardPage( boardId, null, request, response);
//	}
//
//	/**
//	 * 게시판 - 일반회원공간
//	 * @param boardId
//	 * @param postingCategoryId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/board/{boardId}/{postingCategoryId}", method = RequestMethod.GET)
//	public ModelAndView viewBoardPage( @PathVariable Integer boardId, @PathVariable Integer postingCategoryId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		Function funcPostingListBoardPage = FunctionHandler.getFunctionByBeanId( "funcPostingListBoardPage");
//		
//		// get board category 
//		int rootCategoryId = GivusConstants.ROOTCATEGORYID_BOARD;
//		CategoryModel rootCategory = categoryService.getConnectedCategories( rootCategoryId);
//		mav.addObject( "leftMenu", rootCategory);
//
//				
//		// best view postings
//		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//		conditions.add( new PlainSearchCondition( "boardId IN (SELECT relatedId FROM Category WHERE relatedType = 'board' AND nodePath LIKE '" + rootCategory.getNodePath() + "%')"));
//		
//		List<PostingModel> bestViewPostings = (List<PostingModel>)postingService.search( 0, 5, 1, PostingModel.POSTING_SELECTFIELD_EXCEPT_CONTENTS, conditions, "viewCount DESC");
//		renderHandler.renderData( bestViewPostings, funcPostingListBoardPage.getRenders());
//		mav.addObject( "bestViewPostings", bestViewPostings);
//		
//		// best recommend postings
//		conditions.add( new SearchCondition( "recommendCount", "0", ">"));
//		List<PostingModel> bestRecommendPostings = (List<PostingModel>)postingService.search( 0, 5, 1, PostingModel.POSTING_SELECTFIELD_EXCEPT_CONTENTS, conditions, "recommendCount DESC");
//		renderHandler.renderData( bestRecommendPostings, funcPostingListBoardPage.getRenders());
//		mav.addObject( "bestRecommendPostings", bestRecommendPostings);
//		
//		// notice postings for board 
//		conditions.removeAll(conditions);
//		conditions.add( new SearchCondition( "boardId", GivusConstants.BOARD_NOTICE_FORBOARD_BOARDID));
//		List<BoardModel> noticePostings = (List<BoardModel>)postingService.search( 0, 4, 1, PostingModel.POSTING_SELECTFIELD_EXCEPT_CONTENTS, conditions, " id DESC "); 
//		renderHandler.renderData( noticePostings, funcPostingListBoardPage.getRenders());
//		mav.addObject( "noticePostings", noticePostings);
//		
//		// set default board id
//		final int defaultBoardId = 1;
//		if( boardId == null){
//			boardId = defaultBoardId;
//		}
//		
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingListBoardPage.getId());
//		param.setBoardId( boardId);
//		param.addCondition( new SearchCondition( "boardId", boardId));
//		if( postingCategoryId != null){
//			param.addCondition( new SearchCondition( "categoryId", postingCategoryId));
//		}
//		
//		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
//		
//		String xPath = param.getXpath();
//		if ( param.getXpath() == null || param.getXpath().equals("")){
//			xPath = "___/p/board/"+boardId;
//			if( postingCategoryId != null){
//				xPath += "/"+postingCategoryId;
//			}
//		}
//		///edit.do?fid=f{funcPostingCreate}&amp;action=create&amp;bid=#!{bid}
//		Function funcPostingCreate = FunctionHandler.getFunctionByBeanId("funcPostingCreateBoardPage");
//		String formAction = ( new StringBuffer().append("fid=").append(funcPostingCreate.getId()).append("&action=create&bid=").append(boardId).append("&xpath=").append(xPath)).toString();
//		
//		mav.addObject( "formAction", formAction);
//		mav.addObject( "boardId", boardId);
//		mav.addObject( "postingCategoryId", postingCategoryId);
//		mav.addObject( "body_page", "givus_board");
//		mav.addObject( "dispatcher", dispatcher);
//		
//		return mav;
//	}
//	
//	@RequestMapping( value="/hboard", method = RequestMethod.GET)
//	public ModelAndView viewHospitalBoardPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewHospitalBoardPage( null, request, response);
//	}
//	
//	/**
//	 * 게시판 - 병원회원공간
//	 * @param boardId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/hboard/{boardId}", method = RequestMethod.GET)
//	public ModelAndView viewHospitalBoardPage( @PathVariable Integer boardId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		// TODO 병원 관계자인지 권한 체크
//		
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null && ( umodel.getUserType().equals( UserModel.USER_TYPE_HOSPITAL) || umodel.getUserType().equals( UserModel.USER_TYPE_MANAGER))){
//			if (  (umodel.getHospitalId() != null && umodel.getHospitalId() > 0) 
//					|| umodel.getUserType().equals( UserModel.USER_TYPE_MANAGER)){
//				mav.addObject( "userAccount", umodel.getAccount());
//				mav.addObject( "userNickname", umodel.getNickname());
//				mav.addObject( "userType", umodel.getUserType());
//				mav.addObject( "userConHospitalId", umodel.getHospitalId());
//			}else{
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.hboard.notconhospital"));
//			}
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.hboard"));
//		}
//		
//		Function funcPostingListHospitalBoardPage = FunctionHandler.getFunctionByBeanId( "funcPostingListHospitalBoardPage");
//		
//		// get board category 
//		int rootCategoryId = GivusConstants.ROOTCATEGORYID_HOSPITAL_BOARD;
//		CategoryModel rootCategory = categoryService.getConnectedCategories( rootCategoryId);
//		mav.addObject( "leftMenu", rootCategory);
//		
//		// best view postings
//		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//		conditions.add( new PlainSearchCondition( "boardId IN (SELECT relatedId FROM Category WHERE relatedType = 'board' AND nodePath LIKE '" + rootCategory.getNodePath() + "%')"));
//		
//		List<PostingModel> bestViewPostings = (List<PostingModel>)postingService.search( 0, 5, 1, PostingModel.POSTING_SELECTFIELD_EXCEPT_CONTENTS, conditions, "viewCount DESC");
//		renderHandler.renderData( bestViewPostings, funcPostingListHospitalBoardPage.getRenders());
//		mav.addObject( "bestViewPostings", bestViewPostings);
//		
//		// best recommend postings
//		conditions.add( new SearchCondition( "recommendCount", "0", ">"));
//		List<PostingModel> bestRecommendPostings = (List<PostingModel>)postingService.search( 0, 5, 1, PostingModel.POSTING_SELECTFIELD_EXCEPT_CONTENTS, conditions, "recommendCount DESC");
//		renderHandler.renderData( bestRecommendPostings, funcPostingListHospitalBoardPage.getRenders());
//		mav.addObject( "bestRecommendPostings", bestRecommendPostings);
//		
//		// set default board id
//		final int DEFAULT_BOARD_ID = 20;
//		if( boardId == null){
//			boardId = DEFAULT_BOARD_ID;
//		}
//		
//		
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingListHospitalBoardPage.getId());
//		param.setBoardId( boardId);
//		param.addCondition( new SearchCondition( "boardId", boardId));
//		
//		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
//		mav.addObject( "boardId", boardId);
//		
//		mav.addObject( "body_page", "givus_board_hospital");
//		mav.addObject( "dispatcher", dispatcher);
//		
//		return mav;
//	}
//	
//	/**
//	 * 우리병원pr
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/hospitalpr", method = RequestMethod.GET)
//	public ModelAndView viewHospitalPRPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		// TODO 병원 관계자인지 권한 체크
//		
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		// hospital's photo
//		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//		conditions.add( new SearchCondition( "relationType", "hospitalpr_gallery"));
//		List<FileModel> files = fileService.search( conditions);
//		
//		mav.addObject( "body_page", "givus_hospital_pr");
//		mav.addObject( "files", files);
//		
//		return mav;
//	}
//	
//	/**
//	 * 병원정보
//	 * @param hospitalId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/hospital/{hospitalId}", method = RequestMethod.GET)
//	public ModelAndView viewHospitalDetailPage( @PathVariable Integer hospitalId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		// TODO 병원 관계자인지 권한 체크
//		
//		// 해당 병원 정보에 대한 조회기록을 UserHospitalView 테이블에 남긴다. 
//		userHospitalViewService.createViewHistory( hospitalId);
//				
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		HospitalModel model = (HospitalModel)hospitalService.get( hospitalId);
//		
//		System.out.println( "model.getTotalPoint() = " + model.getTotalPoint());
//		System.out.println( "model.getExpertPoint() = " + model.getExpertPoint());
//		System.out.printf( "%04.2f", model.getExpertPoint());
//		System.out.println( "model.getSafePoint() = " + model.getSafePoint());
//		System.out.println( "model.getSafePoint() = " + model.getSatisfyPoint());
//		System.out.println( "model.getSafePoint() = " + model.getSizePoint());
//		System.out.println( "model.getSafePoint() = " + model.getConvenientPoint());
//		
//		CategoryModel rootCategory = operationPriceService.getOperationPriceCategory( hospitalId, "#,000원");
//		
//		// hospital's photo
//		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//		conditions.add( new SearchCondition( "relationId", hospitalId));
//		conditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_HOSPITAL_GALLERY));
//		List<FileModel> files = fileService.search( conditions);
//		
//		// 많이 본 성형외과 정보를 가져온다.
//		List<HospitalModel> mostViewedHospitals = userHospitalViewService.searchMostViewHospitalByHospitalId( hospitalId);
//		
//		if ( mostViewedHospitals != null){
//			int hospitalsCount = ( mostViewedHospitals.size() < 3) ? mostViewedHospitals.size() : 3;
//			
//			for ( int i=0; i < hospitalsCount; i++){
//				conditions.removeAll(conditions);
//				conditions.add( new SearchCondition( "relationId", mostViewedHospitals.get(i).getId()));
//				conditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_HOSPITAL));
//				
//				FileModel fmodel = (FileModel)fileService.get(conditions);
//				if( fmodel != null){ 
//					mostViewedHospitals.get(i).setThumbFileId(fmodel.getId());
//				}
//				
//			}
//		}
//		
//				
//		// 병원 평점을 가져온다.
//		HospitalEvaluationModel heModel = (HospitalEvaluationModel)hospitalEvaluationService.get( new SearchCondition( "hospitalId", hospitalId));
//		if( heModel != null)
//			heModel.prepareStats();
//		
//		// 전문의 정보를 가져온다.
//		HospitalStatsModel hospitalStatsModel = ( HospitalStatsModel)hospitalStatsService.get( new SearchCondition( "hospitalId", hospitalId));
//		
//		mav.addObject( "body_page", "givus_hospital_detail");
//		mav.addObject( "files", files);
//		mav.addObject( "hospitalEvaluationModel", heModel);
//		mav.addObject( "hospitalModel", model);
//		mav.addObject( "mostViewedHospitalModels", mostViewedHospitals);
//		mav.addObject( "operationPriceRootCategory", rootCategory);
//		mav.addObject( "hospitalStatsModel", hospitalStatsModel);
//		
//		return mav;
//	}
//	
//	@RequestMapping( value="/hepilogue/{hospitalId}", method = RequestMethod.GET)
//	public ModelAndView viewHospitalEpiloguePage( @PathVariable Integer hospitalId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewHospitalEpiloguePage( hospitalId, null, request, response);
//	}
//	
//	/**
//	 * 병원정보 - 병원후기
//	 * @param hospitalId
//	 * @param postingCategoryId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/hepilogue/{hospitalId}/{postingCategoryId}", method = RequestMethod.GET)
//	public ModelAndView viewHospitalEpiloguePage( @PathVariable Integer hospitalId, @PathVariable Integer postingCategoryId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		// Posting Category 목록을 가져온다.
//		/*TODO : 병원별로 후기를 볼수 있도록 차후에 변경 - 글 쓸때 병원id를 customfield에 채워둘것*/
//		List<PostingCategoryModel> pcModels = postingCategoryService.searchCountInPostingCategory( GivusConstants.BOARD_HOSPITAL_EPILOGUE_BOARDID);
//		
//		// 전체를 추가한다.
//		PostingCategoryModel pcModelAll = new PostingCategoryModel();
//		pcModelAll.setName( "전체");
//		int countAll = 0;
//		for( PostingCategoryModel pcModel : pcModels){
//			countAll += pcModel.getPostingCount() != null ? pcModel.getPostingCount() : 0; 
//		}
//		pcModelAll.setPostingCount( countAll);
//		pcModels.add( pcModelAll);
//		
//		HospitalModel model = (HospitalModel)hospitalService.get( hospitalId);
//		
//		// 후기 게시물을 가져온다.
//		Function funcPostingListBoardPage = FunctionHandler.getFunctionByBeanId( "funcPostingListHospitalEpiloguePage");
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingListBoardPage.getId());
//		param.setBoardId( GivusConstants.BOARD_HOSPITAL_EPILOGUE_BOARDID);
//		param.addCondition( new SearchCondition( "boardId", GivusConstants.BOARD_HOSPITAL_EPILOGUE_BOARDID));
//		if( postingCategoryId != null && postingCategoryId > 0){
//			param.addCondition( new SearchCondition( "categoryId", postingCategoryId));
//		}
//		param.addCondition( new SearchCondition( "customField1", hospitalId));
//		
//		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
//		
//		// 많이 본 성형외과 정보를 가져온다.
//		List<HospitalModel> mostViewedHospitals = userHospitalViewService.searchMostViewHospitalByHospitalId( hospitalId);
//		List<SearchCondition> hfileconditions = new ArrayList<SearchCondition>();
//		
//		if ( mostViewedHospitals != null){
//			int hospitalsCount = ( mostViewedHospitals.size() < 3) ? mostViewedHospitals.size() : 3;
//			
//			for ( int i=0; i < hospitalsCount; i++){
//				hfileconditions.removeAll(hfileconditions);
//				hfileconditions.add( new SearchCondition( "relationId", mostViewedHospitals.get(i).getId()));
//				hfileconditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_HOSPITAL));
//				
//				FileModel fmodel = (FileModel)fileService.get(hfileconditions);
//				if( fmodel != null){ 
//					mostViewedHospitals.get(i).setThumbFileId(fmodel.getId());
//				}
//			}
//		}
//		
//		// 첨부파일중 이미지 파일을 가려낸다.
//		if( dispatcher.getDatas() != null){
//			int size = dispatcher.getDatas().size();
//			for( int i=0; i<size; i++){
//				PostingModel pmodel = (PostingModel)dispatcher.getDatas().get( i);
//				List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//				conditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
//				conditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
//				conditions.add( new SearchCondition( "relationId", pmodel.getId()));
//				List files = fileService.search( conditions);
//				pmodel.setFiles( files);
//			}
//		}
//		
//		mav.addObject( "body_page", "givus_hospital_epilogue");
//		mav.addObject( "hospitalModel", model);
//		mav.addObject( "postingCategoryModels", pcModels);
//		mav.addObject( "mostViewedHospitalModels", mostViewedHospitals);
//		mav.addObject( "dispatcher", dispatcher);
//		
//		return mav;
//	}
//	
//	
//	@RequestMapping( value="/hreview/{hospitalId}", method = RequestMethod.GET)
//	public ModelAndView viewHospitalReviewPage( @PathVariable Integer hospitalId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewHospitalReviewPage( hospitalId, null, request, response);
//	}
//	
//	/**
//	 * 병원정보 - 병원리뷰
//	 * @param hospitalId
//	 * @param postingCategoryId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/hreview/{hospitalId}/{postingCategoryId}", method = RequestMethod.GET)
//	public ModelAndView viewHospitalReviewPage( @PathVariable Integer hospitalId, @PathVariable Integer postingCategoryId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		// TODO 병원 관계자인지 권한 체크
//		
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		
//		final int hospitalEpilogueBoardId = 26;
//		
//		// Posting Category 목록을 가져온다.
//		List<PostingCategoryModel> pcModels = postingCategoryService.searchCountInPostingCategory( hospitalEpilogueBoardId);
//		
//			// 전체를 추가한다.
//		PostingCategoryModel pcModelAll = new PostingCategoryModel();
//		pcModelAll.setName( "전체");
//		int countAll = 0;
//		for( PostingCategoryModel pcModel : pcModels){
//			countAll += pcModel.getPostingCount() != null ? pcModel.getPostingCount() : 0; 
//		}
//		pcModelAll.setPostingCount( countAll);
//		pcModels.add( pcModelAll);
//		
//		HospitalModel hModel = (HospitalModel)hospitalService.get( hospitalId);
//		
//		// 후기 게시물을 가져온다.
//		Function funcPostingListBoardPage = FunctionHandler.getFunctionByBeanId( "funcPostingListHospitalEpiloguePage");
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingListBoardPage.getId());
//		param.setBoardId( hospitalEpilogueBoardId);
//		param.addCondition( new SearchCondition( "boardId", hospitalEpilogueBoardId));
//		if( postingCategoryId != null && postingCategoryId > 0){
//			param.addCondition( new SearchCondition( "categoryId", postingCategoryId));
//		}
//		param.addCondition( new SearchCondition( "customField1", hospitalId));
//		
//		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
//		
//		// 병원 평점을 가져온다.
//		HospitalEvaluationModel heModel = (HospitalEvaluationModel)hospitalEvaluationService.get( new SearchCondition( "hospitalId", hospitalId));
//		if( heModel != null)
//			heModel.prepareStats();
//		
//		// 많이 본 성형외과 정보를 가져온다.
//		List<HospitalModel> mostViewedHospitals = userHospitalViewService.searchMostViewHospitalByHospitalId( hospitalId);
//		List<SearchCondition> hfileconditions = new ArrayList<SearchCondition>();
//		if ( mostViewedHospitals != null){
//			int hospitalsCount = ( mostViewedHospitals.size() < 3) ? mostViewedHospitals.size() : 3;
//			
//			for ( int i=0; i < hospitalsCount; i++){
//				hfileconditions.removeAll(hfileconditions);
//				hfileconditions.add( new SearchCondition( "relationId", mostViewedHospitals.get(i).getId()));
//				hfileconditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_HOSPITAL));
//				
//				FileModel fmodel = (FileModel)fileService.get(hfileconditions);
//				if( fmodel != null){ 
//					mostViewedHospitals.get(i).setThumbFileId(fmodel.getId());
//				}
//			}
//		}
//				
//		mav.addObject( "body_page", "givus_hospital_review");
//		mav.addObject( "hospitalModel", hModel);
//		mav.addObject( "postingCategoryModels", pcModels);
//		mav.addObject( "hospitalEvaluationModel", heModel);
//		mav.addObject( "mostViewedHospitalModels", mostViewedHospitals);
//		mav.addObject( "dispatcher", dispatcher);
//		
//		return mav;
//	}
//	
//	
//	@RequestMapping( value="/ranking/{rankingType}", method = RequestMethod.GET)
//	public ModelAndView viewRankingPage( @PathVariable String rankingType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewRankingPage( rankingType, null, request, response);
//	}
//	
//	@RequestMapping( value="/ranking/{rankingType}/{rankingLocationCode}", method = RequestMethod.GET)
//	public ModelAndView viewRankingPage( @PathVariable String rankingType, @PathVariable String rankingLocationCode, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewRankingPage( rankingType, rankingLocationCode, null, request, response);
//	}
//	
//	/**
//	 * 랭킹
//	 * @param rankingType
//	 * @param rankingLocationCode
//	 * @param rankingPartCode
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/ranking/{rankingType}/{rankingLocationCode}/{rankingPartCode}", method = RequestMethod.GET)
//	public ModelAndView viewRankingPage( @PathVariable String rankingType, @PathVariable String rankingLocationCode, @PathVariable String rankingPartCode, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		if( rankingType == null){
//			rankingType = RankingModel.RANKING_TYPE_TOP_100;
//			rankingLocationCode = null;
//			rankingPartCode = null;
//		}
//		if( RankingModel.RANKING_TYPE_MAJOR_CITY_10.equals( rankingType)){
//			if ( rankingLocationCode == null)
//				rankingLocationCode = GivusConstants.CODE_CATEGORY_LOCATION_INCHEON; // set Defautl LocationCode
//			rankingPartCode = null;
//		}
//		if( RankingModel.RANKING_TYPE_PART_10.equals( rankingType)){
//			if ( rankingPartCode == null)
//				rankingPartCode = GivusConstants.CODE_CATEGORY_PARTCODE_EYE; // set Default partCode
//			rankingLocationCode = null;
//		}
//		if( RankingModel.RANKING_TYPE_SEOUL_50.equals( rankingType)){
//			if ( rankingLocationCode == null)
//				rankingLocationCode = GivusConstants.CODE_CATEGORY_LOCATION_SEOUL; // set Defautl LocationCode
//			rankingPartCode = null;
//		}
//		
//		// search Ranking Data
//		Dispatcher dispatcher = null;
//		RankingModel rankingModel = null;
//		if ( RankingModel.RANKING_TYPE_MAJOR_CITY_10.equals( rankingType) ||  RankingModel.RANKING_TYPE_SEOUL_50.equals( rankingType)){
//			rankingModel = rankingService.getRecentRanking( rankingType, rankingLocationCode);
//		}
//		if ( RankingModel.RANKING_TYPE_TOP_100.equals( rankingType)){
//			rankingModel = rankingService.getRecentRanking( rankingType);
//		}
//		if ( RankingModel.RANKING_TYPE_PART_10.equals( rankingType)){
//			rankingModel = rankingService.getRecentRanking( rankingType, null, rankingPartCode);
//		}
//		
//		if( rankingModel != null){
//			Function function = FunctionHandler.getFunctionByBeanId( "funcHospitalRankingList");
//			ParameterHelper paramHelper = new ParameterHelper( request);
//			Parameter param = paramHelper.buildParameter( function.getId());
//			param.setFunctionId( function.getId());
//			param.addCondition( new SearchCondition("rankingId", rankingModel.getId()));
//			
//			//dispatcher = listController.getDispatcher( request, response, param);
//			dispatcher = glistController.getDispatcher( request, response, param);
//		}
//				
//		mav.addObject( "body_page", "givus_ranking");
//		mav.addObject( "rankingModel", rankingModel);
//		mav.addObject( "dispatcher", dispatcher);
//		
//		return mav;
//	}
//	
//	@RequestMapping( value="/rankingdata/{rankingType}", method = RequestMethod.GET)
//	public ModelAndView viewRankingDataPage( @PathVariable String rankingType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewRankingDataPage( rankingType, null, request, response);
//	}
//
//	@RequestMapping( value="/rankingdata/{rankingType}/{rankingLocationCode}", method = RequestMethod.GET)
//	public ModelAndView viewRankingDataPage( @PathVariable String rankingType, @PathVariable String rankingLocationCode, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewRankingDataPage( rankingType, rankingLocationCode, null, request, response);
//	}
//	
//	/**
//	 * 랭킹데이터
//	 * @param rankingType
//	 * @param rankingLocationCode
//	 * @param rankingPartCode
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/rankingdata/{rankingType}/{rankingLocationCode}/{rankingPartCode}", method = RequestMethod.GET)
//	public ModelAndView viewRankingDataPage( @PathVariable String rankingType, @PathVariable String rankingLocationCode, @PathVariable String rankingPartCode, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//
//		if( rankingType == null){
//			rankingType = RankingModel.RANKING_TYPE_TOP_100;
//			rankingLocationCode = null;
//			rankingPartCode = null;
//		}
//		if( RankingModel.RANKING_TYPE_MAJOR_CITY_10.equals( rankingType)){
//			if ( rankingLocationCode == null)
//				rankingLocationCode = GivusConstants.CODE_CATEGORY_LOCATION_INCHEON; // set Defautl LocationCode
//			rankingPartCode = null;
//		}
//		if( RankingModel.RANKING_TYPE_PART_10.equals( rankingType)){
//			if ( rankingPartCode == null)
//				rankingPartCode = GivusConstants.CODE_CATEGORY_PARTCODE_EYE; // set Default partCode
//			rankingLocationCode = null;
//		}
//		if( RankingModel.RANKING_TYPE_SEOUL_50.equals( rankingType)){
//			if ( rankingLocationCode == null)
//				rankingLocationCode = GivusConstants.CODE_CATEGORY_LOCATION_SEOUL; // set Defautl LocationCode
//			rankingPartCode = null;
//		}
//		
//		// get Ranking Model
//		String rankingId = request.getParameter( "rankingId");
//		String szStartDate = request.getParameter( "startDate");
//		RankingModel rankingModel = null;
//		if( rankingId != null){
//			rankingModel = (RankingModel)rankingService.get( Integer.parseInt( rankingId));
//		}else if( szStartDate != null){
//			Date startDate = DateUtil.parseString( szStartDate, DateUtil.YYYYMMDD);
//			Date endDate = CalendarUtil.getNextMonthFirstDateObj( startDate);
//			List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//			conditions.add( new SearchCondition( "startDate", startDate, ">="));
//			conditions.add( new SearchCondition( "startDate", endDate, "<"));
//			List<RankingModel> rankingModels = rankingService.search( 0, 1, conditions, "startDate DESC");
//			if( rankingModels != null && !rankingModels.isEmpty())
//				rankingModel = rankingModels.get(0);
//			else{
//				rankingModel = new RankingModel();
//				rankingModel.setStartDate( startDate);
//				rankingModel.setRankingType( rankingType);
//				rankingModel.setRankingLocationCode( rankingLocationCode);
//				rankingModel.setRankingPartCode( rankingPartCode);
//			}
//		}else{
//			rankingModel = rankingService.getRecentRanking( rankingType, rankingLocationCode, rankingPartCode);
//		}
//		
//		Dispatcher dispatcher = null;
//		if( rankingModel != null){
//			Function function = FunctionHandler.getFunctionByBeanId( "funcRankingDataPageList");
//			ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//			Parameter param = paramHelper.buildParameter( function.getId());
//			param.setFunctionId( function.getId());
//			param.addCondition( new SearchCondition("rankingId", rankingModel.getId()));
//			
////			dispatcher = listController.getDispatcher( request, response, param);
//			dispatcher = glistController.getDispatcher( request, response, param);
//			
//			// 해당 월의 랭킹 목록을 가져온다. startDate 를 기준으로 한다.
//			Function functionRanking = FunctionHandler.getFunctionByBeanId( "funcRankingList");
//			Parameter paramRanking = paramHelper.buildParameter( functionRanking.getId());
//			
//			Date date = rankingModel.getStartDate();
//			
//			List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//			String today_YYYYMM = DateUtil.formatDate( date, "yyyy-MM");
//			conditions.add( new SearchCondition( "date_format(startDate, '%Y-%m')", today_YYYYMM));
//			conditions.add( new SearchCondition( "rankingType", rankingType));
//			if( ( RankingModel.RANKING_TYPE_SEOUL_50.equals( rankingType) || RankingModel.RANKING_TYPE_MAJOR_CITY_10.equals( rankingType))
//					&& rankingLocationCode != null){
//				conditions.add( new SearchCondition( "rankingLocationCode", rankingLocationCode));
//			}else if ( RankingModel.RANKING_TYPE_PART_10.equals( rankingType) && rankingPartCode != null){
//				conditions.add( new SearchCondition( "rankingPartCode", rankingPartCode));
//			}
//			
//			paramRanking.addConditions( conditions);
//			
//			Dispatcher dispatcherRanking = listController.getDispatcher( request, response, paramRanking);
//			
//			mav.addObject( "rankingModels", dispatcherRanking.getDatas());
//			
//			// 해당 달의 몇번째 주인지 확인한다.
//			Calendar cal = Calendar.getInstance();
//			cal.setTime( date);
//			int week_of_month = cal.get( Calendar.WEEK_OF_MONTH);
//			
//			StringBuilder weekInfo = new StringBuilder();
//			weekInfo.append( DateUtil.formatDate( date, "yyyy.MM")).append( ".").append( week_of_month).append("주");
//			mav.addObject( "weekInfo", weekInfo.toString());
//			
//			// 이전달, 다음달을 구한다.
//			String prevMonth = CalendarUtil.getPreviousMonthFirstDate( date, "yyyy-MM-dd");
//			String nextMonth = CalendarUtil.getNextMonthFirstDate( date, "yyyy-MM-dd");
//			mav.addObject( "prevMonth", prevMonth);
//			mav.addObject( "nextMonth", nextMonth);
//			
//		}
//		
//		mav.addObject( "body_page", "givus_rankingdata");
//		mav.addObject( "rankingModel", rankingModel);
//		mav.addObject( "dispatcher", dispatcher);
//		
//		return mav;
//	}
//	
//	/**
//	 * 회원가입
//	 * @param userType
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/user/create/{userType}", method = RequestMethod.GET)
//	public ModelAndView viewUserPage(  @PathVariable String userType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		if( userType == null || userType == "")
//			userType = UserModel.USER_TYPE_GENERAL;
//		
//		String responsePage = "givus_join_user";
//		Function func = FunctionHandler.getFunctionByBeanId("funcUserCreateGeneralUserSelf");
//		
//		if( userType.equalsIgnoreCase( UserModel.USER_TYPE_HOSPITAL)){
//			//responsePage = "givus_join_generaluser";
//			func = FunctionHandler.getFunctionByBeanId("funcUserCreateHospitalUserSelf");
//		}
//		
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter();
//		param.setFunctionId(func.getId());
//		
//		Dispatcher dispatcher = givusEditController.getDispatcher(request, response, param);
//
//		mav.addObject( "body_page", responsePage);
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "command", dispatcher.getCommand());
//		mav.addObject( "userType", userType);
//		mav.addObject( "joinFunction", func.getId());
//		
//		return mav;
//	}
//	
//	@RequestMapping( value="/msg/create", method = RequestMethod.GET)
//	public ModelAndView viewMessageCreatePage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewMessageCreatePage( null, request, response);
//	}
//	/**
//	 * 쪽지보내기
//	 * @param pageType
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/msg/create/{pageType}", method = RequestMethod.GET)
//	public ModelAndView viewMessageCreatePage( @PathVariable String pageType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		if ( pageType == null || pageType.equals("")){
//			pageType = GivusConstants.PAGETYPE_MYPAGE;
//		}
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//			mav.addObject( "userConHospitalId", umodel.getHospitalId());
//			if ( pageType.equals( GivusConstants.PAGETYPE_MYPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_HOSPITAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.g"));
//			}	
//			else if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_GENERAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.h"));
//			}
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.msg.nosession"));
//		}
//		
//		//병원사용자에게 쓰기 //funcMessageCreate
//		Function func = FunctionHandler.getFunctionByBeanId("funcMessageToHospitalCreate");
//		
//		//TODO: 일반 사용자에게 쓰기
//		if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE)){
//			func = FunctionHandler.getFunctionByBeanId("funcMessageToGeneralUserCreate");
//		}
//		
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter();
//		param.setFunctionId(func.getId());
//		Dispatcher dispatcher = givusEditController.getDispatcher(request, response, param);
//		System.out.println( " dispatcher.getCommand() =" + dispatcher.getCommand());
//
//		mav.addObject( "pageType", pageType);
//		mav.addObject( "body_page", "givus_message_create");
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "command", dispatcher.getCommand());
//		
//		return mav;
//	}
//	
//	@RequestMapping( value="/msg/send", method = RequestMethod.GET)
//	public ModelAndView viewMessageSendPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewMessageSendPage( null, request, response);
//	}
//	/**
//	 * 보낸쪽지함
//	 * @param pageType
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/msg/send/{pageType}", method = RequestMethod.GET)
//	public ModelAndView viewMessageSendPage( @PathVariable String pageType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		if ( pageType == null || pageType.equals("")){
//			pageType = GivusConstants.PAGETYPE_MYPAGE;
//		}
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//			mav.addObject( "userConHospitalId", umodel.getHospitalId());
//			if ( pageType.equals( GivusConstants.PAGETYPE_MYPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_HOSPITAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.g"));
//			}	
//			else if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_GENERAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.h"));
//			}
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.msg.nosession"));
//		}
//		
//		Function func = FunctionHandler.getFunctionByBeanId("funcMessageSendList");
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter();
//		param.setFunctionId(func.getId());
//		Dispatcher dispatcher = listController.getDispatcher(request, response, param);
//		
//		mav.addObject( "pageType", pageType);
//		mav.addObject( "body_page", "givus_message_send");
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "command", dispatcher.getCommand());
//		
//		return mav;
//	}
//	
//	@RequestMapping( value="/msg/receive", method = RequestMethod.GET)
//	public ModelAndView viewMessageReceivePage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewMessageReceivePage( null, request, response);
//	}
//	/**
//	 * 받은쪽지함
//	 * @param pageType
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/msg/receive/{pageType}", method = RequestMethod.GET)
//	public ModelAndView viewMessageReceivePage( @PathVariable String pageType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		if ( pageType == null || pageType.equals("")){
//			pageType = GivusConstants.PAGETYPE_MYPAGE;
//		}
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//			mav.addObject( "userConHospitalId", umodel.getHospitalId());
//			if ( pageType.equals( GivusConstants.PAGETYPE_MYPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_HOSPITAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.g"));
//			}	
//			else if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_GENERAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.h"));
//			}
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.msg.nosession"));
//		}
//		
//		Function func = FunctionHandler.getFunctionByBeanId("funcMessageReceiveList");
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter();
//		param.setFunctionId(func.getId());
//		Dispatcher dispatcher = listController.getDispatcher(request, response, param);
//		
//		mav.addObject( "pageType", pageType);
//		mav.addObject( "body_page", "givus_message_receive");
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "command", dispatcher.getCommand());
//		
//		return mav;
//	}
//	/**
//	 * 성형가격비교
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/price/compare", method = RequestMethod.GET)
//	public ModelAndView viewPriceComparePage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		CategoryModel rootCategory = getCategoryService().getConnectedCategories( GivusConstants.ROOTCATEGORYID_OPERATION);
//		
//		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//		conditions.add( new SearchCondition( "ranking", 4 , " < "));
//		
//		List<HospitalModel> hmodels = (List<HospitalModel>)hospitalService.search( 0, 3, 1, conditions, "ranking ASC");
//		
//		mav.addObject( "hmodels", hmodels);
//		mav.addObject( "body_page", "givus_price_compare");
//		mav.addObject( "operationCategory", rootCategory);
//		
//		return mav;
//	}
//	/**
//	 * 병원이벤트
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/event", method = RequestMethod.GET)
//	public ModelAndView viewEventPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		// event list
//		Function func = FunctionHandler.getFunctionByBeanId("funcHospitalEventViewList");
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter( func.getId());
//		Dispatcher dispatcher = listController.getDispatcher(request, response, param);
//		
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "body_page", "givus_hospital_event");
//		
//		return mav;
//	}
//	
//	@RequestMapping( value="/surgeryinfo", method = RequestMethod.GET)
//	public ModelAndView viewSurgeryInfoPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewSurgeryInfoPage( null, request, response);
//	}
//	
//	@RequestMapping( value="/surgeryinfo/{boardId}", method = RequestMethod.GET)
//	public ModelAndView viewSurgeryInfoPage( @PathVariable Integer boardId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewSurgeryInfoPage( boardId, null, request, response);
//	}
//	/**
//	 * 성형정보/뉴스
//	 * @param boardId
//	 * @param postingCategoryId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/surgeryinfo/{boardId}/{postingCategoryId}", method = RequestMethod.GET)
//	public ModelAndView viewSurgeryInfoPage( @PathVariable Integer boardId, @PathVariable Integer postingCategoryId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}		
//		// news list
//		Function funcPostingListSurgeryInfoPage = FunctionHandler.getFunctionByBeanId( "funcPostingListSurgeryInfoPage");
//		Function funcPostingListSurgeryInfoPortletPage = FunctionHandler.getFunctionByBeanId( "funcPostingListSurgeryInfoPortletPage");
//		
//		
//		// get board category 
//		int rootCategoryId = GivusConstants.ROOTCATEGORYID_SURGERYINFO_BOARD;
//		CategoryModel rootCategory = categoryService.getConnectedCategories( rootCategoryId);
//		mav.addObject( "leftMenu", rootCategory);
//		
//		// best view postings
//		List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//		conditions.add( new PlainSearchCondition( "boardId IN (SELECT relatedId FROM Category WHERE relatedType = 'board' AND nodePath LIKE '" + rootCategory.getNodePath() + "%')"));
//		
//		
//		/* 오늘 성형정보 목록 포틀릿*/
//		//todaysposting
//		conditions.add( new SearchCondition( "createDate", DateUtil.getToday()+"%" , " LIKE "));
//		List<PostingModel> todaysPostings = (List<PostingModel>)postingService.search( 0, 2, 1, conditions, "createDate DESC");
//		renderHandler.renderData( todaysPostings, funcPostingListSurgeryInfoPage.getRenders());
//		mav.addObject( "todaysPostings", todaysPostings);
//		
//		/* 베스트성형뉴스 포틀릿*/ 
//		conditions.removeAll(conditions);
//		conditions.add( new SearchCondition( "boardId", GivusConstants.BOARD_SURGERY_INFO_BOARDID));
//		conditions.add( new SearchCondition( "categoryId", GivusConstants.POSTINGCATEGORY_SURGERY_NEWS_ID));
//		List<PostingModel> bestSurgeryNewsPostings = (List<PostingModel>)postingService.search( 0, 8, 1, PostingModel.POSTING_SELECTFIELD_EXCEPT_CONTENTS, conditions, "viewCount DESC");
//		renderHandler.renderData( bestSurgeryNewsPostings, funcPostingListSurgeryInfoPortletPage.getRenders());
//		mav.addObject( "bestSurgeryNewsPostings", bestSurgeryNewsPostings);
//
//		/* 베스트성형정보 포틀릿*/
//		conditions.removeAll(conditions);
//		conditions.add( new SearchCondition( "boardId", GivusConstants.BOARD_SURGERY_INFO_BOARDID));
//		conditions.add( new SearchCondition( "categoryId", GivusConstants.POSTINGCATEGORY_SURGERY_INFO_ID));
//		List<PostingModel> bestSurgeryInfoPostings = (List<PostingModel>)postingService.search( 0, 8, 1, PostingModel.POSTING_SELECTFIELD_EXCEPT_CONTENTS, conditions, "viewCount DESC");
//		renderHandler.renderData( bestSurgeryInfoPostings, funcPostingListSurgeryInfoPortletPage.getRenders());
//		mav.addObject( "bestSurgeryInfoPostings", bestSurgeryInfoPostings);
//		
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingListSurgeryInfoPage.getId());
//		
//		// set default board id
//		/**TODO: boardid가 없는경우 목록을 19번 모두에서 가져오는 로직이 요구됨*/
//		final int DEFAULT_BOARD_ID = GivusConstants.BOARD_SURGERY_INFO_BOARDID;
//		if( boardId == null){
//			boardId = DEFAULT_BOARD_ID;
//			param.addCondition( new PlainSearchCondition( " boardId=" + GivusConstants.BOARD_SURGERY_INFO_BOARDID/* + " OR boardId=" + GivusConstants.BOARD_SURGERY_INFO_BOARDID+" "*/));
//		}else{
//			if ( postingCategoryId == null){
//				postingCategoryId = GivusConstants.POSTINGCATEGORY_SURGERY_NEWS_ID;
//				param.addCondition( new PlainSearchCondition( " categoryId=" + GivusConstants.POSTINGCATEGORY_SURGERY_NEWS_ID + " OR categoryId=" + GivusConstants.POSTINGCATEGORY_SURGERY_INFO_ID+" "));
//			}else{
//				param.addCondition( new SearchCondition( "categoryId", postingCategoryId));
//			}
//			param.addCondition( new SearchCondition( "boardId", boardId));
//		}
//		
//		param.setBoardId( boardId);
//		
//		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
//		
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "body_page", "givus_surgery_news");
//		return mav;
//	}
//	/**
//	 * 성형정보-상세보기
//	 * @param postingId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/surgeryinfo/detail/{postingId}", method = RequestMethod.GET)
//	public ModelAndView viewSurgeryInfoDetail( @PathVariable Integer postingId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		Function func = FunctionHandler.getFunctionByBeanId("funcPostingViewSurgeryInfoPage");
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter();
//		param.setFunctionId(func.getId());
//		param.setId(postingId);
//
//		Dispatcher dispatcher = viewController.getDispatcher( request, response, param);
//		
//		if( dispatcher != null){
//			PostingModel posting = (PostingModel)dispatcher.getData();
//			if( posting != null){
//				// 성형정보 목록
//				Function funcPostingList = FunctionHandler.getFunctionByBeanId( "funcPostingListSurgeryInfoPage");
//				List<SearchCondition> conditions = new ArrayList<SearchCondition>();
//				conditions.add( new SearchCondition( "boardId", posting.getBoardId()));
//				conditions.add( new SearchCondition( "categoryId", posting.getCategoryId()));
//				
//				List<PostingModel> surgeryPostings = (List<PostingModel>)postingService.search( 0, 4, conditions, "id DESC");
//				renderHandler.renderData( surgeryPostings, funcPostingList.getRenders());
//				mav.addObject( "surgeryPostings", surgeryPostings);
//			}
//		}
//		
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "body_page", "givus_surgery_news_detail");
//		return mav;
//	}
//	
//	/**
//	 * GIVUS소개
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/introduction", method = RequestMethod.GET)
//	public ModelAndView viewIntroductionPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		mav.addObject( "body_page", "givus_introduction");
//		return mav;
//	}
//	/**
//	 * 메인화면
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/main", method = RequestMethod.GET)
//	public ModelAndView viewMainPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		// 성형정보 목록
//		Function funcPostingListSurgeryInfoPage = FunctionHandler.getFunctionByBeanId( "funcPostingListSurgeryInfoPortletPage");
//		List<SearchCondition> infoconditions = new ArrayList<SearchCondition>();
//		infoconditions.add( new SearchCondition( "boardId", GivusConstants.BOARD_SURGERY_INFO_BOARDID ));
//		infoconditions.add( new SearchCondition( "categoryId", GivusConstants.POSTINGCATEGORY_SURGERY_INFO_ID ));
//		
//		List<PostingModel> surgeryInfoPostings = (List<PostingModel>)postingService.search( 0, 7, infoconditions, "id DESC");
//		renderHandler.renderData( surgeryInfoPostings, funcPostingListSurgeryInfoPage.getRenders());
//		mav.addObject( "surgeryInfoPostings", surgeryInfoPostings);
//		// 성형정보 첫번째 글의 사진이 있으면 가져오기
//		if ( surgeryInfoPostings != null && surgeryInfoPostings.size()>0){
//			List<SearchCondition> infoFileConditions = new ArrayList<SearchCondition>();
//			infoFileConditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
//			infoFileConditions.add( new SearchCondition( "relationId", surgeryInfoPostings.get(0).getId()));
//			infoFileConditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
//			List<FileModel> infoFiles = (List<FileModel>)fileService.search( 0, 7, infoFileConditions);
//			if ( infoFiles != null && infoFiles.size()>0){
//				mav.addObject( "infoFileId", infoFiles.get(0).getId());
//			}
//		}
//		
//
//		// 성형뉴스 목록
//		Function funcPostingListSurgeryNewsPage = FunctionHandler.getFunctionByBeanId( "funcPostingListSurgeryInfoPortletPage");
//		List<SearchCondition> newsconditions = new ArrayList<SearchCondition>();
//		newsconditions.add( new SearchCondition( "boardId", GivusConstants.BOARD_SURGERY_INFO_BOARDID ));
//		newsconditions.add( new SearchCondition( "categoryId", GivusConstants.POSTINGCATEGORY_SURGERY_NEWS_ID ));
//		
//		List<PostingModel> surgeryNewsPostings = (List<PostingModel>)postingService.search( 0, 7, newsconditions, "id DESC");
//		renderHandler.renderData( surgeryNewsPostings, funcPostingListSurgeryNewsPage.getRenders());
//		mav.addObject( "surgeryNewsPostings", surgeryNewsPostings);
//		//newsFileId
//		// 성형뉴스 첫번째 글의 사진이 있으면 가져오기
//		if ( surgeryNewsPostings != null && surgeryNewsPostings.size()>0){
//			List<SearchCondition>newsFileConditions = new ArrayList<SearchCondition>();
//			newsFileConditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
//			newsFileConditions.add( new SearchCondition( "relationId", surgeryNewsPostings.get(0).getId()));
//			newsFileConditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
//			List<FileModel> newsFiles = (List<FileModel>)fileService.search( 0, 7, newsFileConditions);
//			if ( newsFiles != null && newsFiles.size()>0){
//				mav.addObject( "newsFileId", newsFiles.get(0).getId());
//			}
//		}
//		
//		// 게시판 목록
//		Function funcGeneralPostingList = FunctionHandler.getFunctionByBeanId( "funcPostingListContents40");
//		
//		// get board category 
//		int rootCategoryId = GivusConstants.ROOTCATEGORYID_BOARD;
//		CategoryModel rootCategory = categoryService.getConnectedCategories( rootCategoryId);
//				
//		// best view postings
//		List<SearchCondition> generalPostingConditions = new ArrayList<SearchCondition>();
//		generalPostingConditions.add( new PlainSearchCondition( "boardId IN (SELECT relatedId FROM Category WHERE relatedType = 'board' AND nodePath LIKE '" + rootCategory.getNodePath() + "%')"));
//		
//		List<PostingModel> generalPostings = (List<PostingModel>)postingService.search( 0, 7, /*1, PostingModel.POSTING_SELECTFIELD_EXCEPT_CONTENTS, */generalPostingConditions, "id DESC");
//		renderHandler.renderData( generalPostings, funcGeneralPostingList.getRenders());
//		mav.addObject( "generalPostings", generalPostings);
//		//gpostingFileId
//		// 게시판 첫번째 글의 사진이 있으면 가져오기
//		if ( generalPostings != null && generalPostings.size()>0){
//			List<SearchCondition> gpostingFileConditions = new ArrayList<SearchCondition>();
//			gpostingFileConditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
//			gpostingFileConditions.add( new SearchCondition( "relationId", generalPostings.get(0).getId()));
//			gpostingFileConditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
//			List<FileModel> gpostingFiles = (List<FileModel>)fileService.search( 0, 7, gpostingFileConditions);
//			if ( gpostingFiles != null && gpostingFiles.size()>0){
//				mav.addObject( "gpostingFileId", gpostingFiles.get(0).getId());
//			}
//		}
//		
//		//우리병원PR
//		// hospital's photo
//		List<SearchCondition> prConditions = new ArrayList<SearchCondition>();
//		prConditions.add( new SearchCondition( "relationType", "hospitalpr_gallery"));
//		List<FileModel> hospitalprFiles = fileService.search( prConditions);
//		mav.addObject( "hospitalprFiles", hospitalprFiles);
//		
//		
//		//병원 이벤트
//		// event list
//		Function funcHospitalEventList = FunctionHandler.getFunctionByBeanId("funcHospitalEventList");
//
//		List<SearchCondition> eventConditions = new ArrayList<SearchCondition>();
//		eventConditions.add( new PlainSearchCondition( " startDate < now() "));
////		eventConditions.add( new SearchCondition("startDate", "now()", "<"));
//		List<HospitalEventModel> hospitalEvents = (List<HospitalEventModel>)hospitalEventService.search( 0, 10, 1, HospitalEventModel.HOSPITALEVENT_SELECTFIELD_WITH_STATUS, eventConditions, "recommendCount DESC");
//		renderHandler.renderData( hospitalEvents, funcHospitalEventList.getRenders());
//		mav.addObject( "hospitalEvents", hospitalEvents);	
//		
//		
//		//인기 병원
//		Function funcHospitalListOrderByViewCount = FunctionHandler.getFunctionByBeanId( "funcHospitalListOrderByViewCount");
//		List<HospitalModel> bestViewHospitals = (List<HospitalModel>)hospitalService.search( 0, 10, 1, null, "viewCount DESC");
//		renderHandler.renderData( bestViewHospitals, funcHospitalListOrderByViewCount.getRenders());
//		mav.addObject( "bestViewHospitals", bestViewHospitals);	
//
//		
//		
//		mav.addObject( "body_page", "givus_main");
//		return mav;
//	}	
//		
//	/**
//	 * 공지사항
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/notice", method = RequestMethod.GET)
//	public ModelAndView viewNoticePage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		//funcPostingNoticeList
//		Function funcPostingNoticeList = FunctionHandler.getFunctionByBeanId( "funcPostingNoticeList");
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingNoticeList.getId());
//		param.setBoardId( GivusConstants.BOARD_NOTICE_BOARDID);
//		param.addCondition( new SearchCondition( "boardId", GivusConstants.BOARD_NOTICE_BOARDID));
//				
//		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
//		
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "body_page", "givus_notice");
//		return mav;
//	}
//	/**
//	 * 자주묻는질문
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/faq", method = RequestMethod.GET)
//	public ModelAndView viewFAQPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		//funcPostingNoticeList
//		Function funcPostingFAQList = FunctionHandler.getFunctionByBeanId( "funcPostingNoticeList");
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingFAQList.getId());
//		param.setBoardId( GivusConstants.BOARD_FAQ_BOARDID);
//		param.addCondition( new SearchCondition( "boardId", GivusConstants.BOARD_FAQ_BOARDID));
//				
//		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
//		
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "body_page", "givus_faq");
//		return mav;
//	}
//	/**
//	 * 1:1문의하기 - 쓰기
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/inquiry/create", method = RequestMethod.GET)
//	public ModelAndView viewInquiryCreatePage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		//String userAccount = "";
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.inquiry.nosession"));
//		}
//		
//		Function funcPostingCreate = FunctionHandler.getFunctionByBeanId("funcPostingCreateInquiryPage");
//		int boardId = GivusConstants.BOARD_INQUIRY_BOARDID;
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingCreate.getId());
//		
//		param.setAction("create");
//		param.setFunctionId(funcPostingCreate.getId());
//		
//		param.setBoardId( boardId);
//		param.addCondition( new SearchCondition( "boardId", boardId));
//
//		Dispatcher dispatcher = editController.getDispatcher(request, response, param);
//		
//		PostingModel model = (PostingModel) dispatcher.getCommand();
//		if (model.getBoardId() == null) model.setBoardId(boardId);
//		
//		dispatcher.setCommand(model);
//		String xPath = param.getXpath();
//		String formAction = ( new StringBuffer().append("fid=").append(funcPostingCreate.getId()).append("&action=create&bid=").append(boardId).append("&xpath=").append(xPath)).toString();
//		
//		mav.addObject( "formAction", formAction);
//		mav.addObject( "command", dispatcher.getCommand());
//		mav.addObject( "boardId", boardId);
//		
//		
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "body_page", "givus_inquiry_create");
//		return mav;
//	}
//	/**
//	 * 1:1문의하기 - 목록
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/inquiry", method = RequestMethod.GET)
//	public ModelAndView viewInquiryListPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		String userAccount = "";
//		if ( umodel != null && umodel.getAccount() != null ){
//			userAccount = umodel.getAccount();
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		//funcPostingNoticeList
//		Function funcPostingInquiryList = FunctionHandler.getFunctionByBeanId( "funcPostingNoticeList");
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingInquiryList.getId());
//		param.setBoardId( GivusConstants.BOARD_INQUIRY_BOARDID);
//		param.addCondition( new SearchCondition( "boardId", GivusConstants.BOARD_INQUIRY_BOARDID));
//		param.addCondition( new SearchCondition( "creator", userAccount));
//				
//		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
//		
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "body_page", "givus_inquiry_list");
//		return mav;
//	}
//	/**
//	 * GIVUS 활용하기
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/howToUseGivus", method = RequestMethod.GET)
//	public ModelAndView viewHowToUseGivusListPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		//funcPostingListHowToUseGivus
//		Function funcPostingListHowToUseGivus = FunctionHandler.getFunctionByBeanId( "funcPostingListHowToUseGivus");
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingListHowToUseGivus.getId());
//		param.setBoardId( GivusConstants.BOARD_HOWTOUSE_GIVUS_BOARDID);
//		param.addCondition( new SearchCondition( "boardId", GivusConstants.BOARD_HOWTOUSE_GIVUS_BOARDID));
//				
//		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
//		
//		mav.addObject( "dispatcher", dispatcher);
//		
//		mav.addObject( "body_page", "givus_howtouse_givus");
//		return mav;
//	}
//	
//	@RequestMapping( value="/posting/detail/{postingId}", method = RequestMethod.GET)
//	public ModelAndView viewPostingDetail( @PathVariable Integer postingId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewPostingDetail( null, postingId, request, response);
//	}
//	/**
//	 * 게시판 상세조회
//	 * @param boardType
//	 * @param postingId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/posting/detail/{boardType}/{postingId}", method = RequestMethod.GET)
//	public ModelAndView viewPostingDetail( @PathVariable String boardType, @PathVariable Integer postingId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		if ( boardType == null){
//			boardType = GivusConstants.BOARD_TYPE_BOARD;
//		}
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( ( boardType.equals(GivusConstants.BOARD_TYPE_BOARD)) &&
//				umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		// 병원회원공간의 글을 조회시에는 병원연결된 사용자만 가능하도록 추가
//		else if ( ( boardType.equals(GivusConstants.BOARD_TYPE_HOSPITAL_BOARD)) &&
//				umodel != null && umodel.getAccount() != null && ( umodel.getUserType().equals( UserModel.USER_TYPE_HOSPITAL) || umodel.getUserType().equals( UserModel.USER_TYPE_MANAGER))){
//			if (  (umodel.getHospitalId() != null && umodel.getHospitalId() > 0) 
//					|| umodel.getUserType().equals( UserModel.USER_TYPE_MANAGER)){
//				mav.addObject( "userAccount", umodel.getAccount());
//				mav.addObject( "userNickname", umodel.getNickname());
//				mav.addObject( "userType", umodel.getUserType());
//				mav.addObject( "userConHospitalId", umodel.getHospitalId());
//			}else{
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.hboard.notconhospital"));
//			}
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.board.nosession"));
//		}
//		
//		
//		// get board category 
//		int rootCategoryId = GivusConstants.ROOTCATEGORYID_BOARD;
//		if ( boardType.equals( GivusConstants.BOARD_TYPE_HOSPITAL_BOARD)){
//			rootCategoryId = GivusConstants.ROOTCATEGORYID_HOSPITAL_BOARD;
//		}
//		
//		CategoryModel rootCategory = categoryService.getConnectedCategories( rootCategoryId);
//		mav.addObject( "leftMenu", rootCategory);
//		
//		Function funcPostingView = FunctionHandler.getFunctionByBeanId("funcPostingDetail");
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter();
//		param.setFunctionId(funcPostingView.getId());
//		param.setId(postingId);
//
//		Dispatcher dispatcher = viewController.getDispatcher( request, response, param);
//		
//		PostingModel posting = (PostingModel)dispatcher.getData();
//		
//		List<SearchCondition> postingconditions = new ArrayList<SearchCondition>();
//		postingconditions.add( new SearchCondition( "boardId", posting.getBoardId()));
//		postingconditions.add( new SearchCondition( "id", posting.getId(), "<"));
//		if ( posting.getCategoryId() != null){
//			postingconditions.add( new SearchCondition( "categoryId", posting.getCategoryId()));
//		}
//		List<PostingModel> prevPosting = (List<PostingModel>)postingService.search( 0, 1, postingconditions, "id DESC");
//		renderHandler.renderData( prevPosting, funcPostingView.getRenders());
//		
//		postingconditions.removeAll(postingconditions);
//		postingconditions.add( new SearchCondition( "boardId", posting.getBoardId()));
//		postingconditions.add( new SearchCondition( "id", posting.getId(), ">"));
//		if ( posting.getCategoryId() != null){
//			postingconditions.add( new SearchCondition( "categoryId", posting.getCategoryId()));
//		}
//		List<PostingModel> nextPosting = (List<PostingModel>)postingService.search( 0, 1, postingconditions, "id ASC");
//		renderHandler.renderData( nextPosting, funcPostingView.getRenders());
//		
//		if (prevPosting != null && prevPosting.size() > 0 ) mav.addObject( "prevPosting", prevPosting.get(0));
//		if (nextPosting != null && nextPosting.size() > 0 ) mav.addObject( "nextPosting", nextPosting.get(0));
//		mav.addObject( "boardType", boardType);
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "body_page", "givus_posting_detail");
//		return mav;
//	}
//	
//	@RequestMapping( value="/posting/write", method = RequestMethod.GET)
//	public ModelAndView viewPostingWrite( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewPostingWrite( null, request, response);
//	}
//	
//	@RequestMapping( value="/posting/write/{boardType}", method = RequestMethod.GET)
//	public ModelAndView viewPostingWrite( @PathVariable String boardType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewPostingWrite( boardType, null, request, response);
//	}
//	
//	@RequestMapping( value="/posting/write/{boardType}/{boardId}", method = RequestMethod.GET)
//	public ModelAndView viewPostingWrite( @PathVariable String boardType, @PathVariable Integer boardId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewPostingWrite( boardType, boardId, null, request, response);
//	}
//	/**
//	 * 게시글쓰기
//	 * @param boardType
//	 * @param boardId
//	 * @param postingCategoryId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/posting/write/{boardType}/{boardId}/{postingCategoryId}", method = RequestMethod.GET)
//	public ModelAndView viewPostingWrite( @PathVariable String boardType, @PathVariable Integer boardId, @PathVariable Integer postingCategoryId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//			mav.addObject( "userConHospitalId", umodel.getHospitalId());
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.board.nosession"));
//		}
//		
//		if ( boardType == null){
//			boardType = GivusConstants.BOARD_TYPE_BOARD;
//		}
//		
//		if ( umodel.getUserType().equals( UserModel.USER_TYPE_GENERAL) && boardType.equals( GivusConstants.BOARD_TYPE_HOSPITAL_BOARD)){
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.hboard"));
//		
//		}else if ( umodel.getUserType().equals( UserModel.USER_TYPE_HOSPITAL) && boardType.equals( GivusConstants.BOARD_TYPE_HOSPITAL_BOARD) && ( umodel.getHospitalId() == null || umodel.getHospitalId() < 1)){
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.hboard.notconhospital"));
//		}
//		
//		
//		// get board category 
//		int rootCategoryId = GivusConstants.ROOTCATEGORYID_BOARD;
//		if ( boardType.equals( GivusConstants.BOARD_TYPE_HOSPITAL_BOARD)){
//			rootCategoryId = GivusConstants.ROOTCATEGORYID_HOSPITAL_BOARD;
//		}
//		
//		CategoryModel rootCategory = categoryService.getConnectedCategories( rootCategoryId);
//		mav.addObject( "leftMenu", rootCategory);
//		
//		// 쓰기 command 설정
//		Function funcPostingCreate = FunctionHandler.getFunctionByBeanId("funcPostingCreateBoardPage");
//		if ( boardType.equals(GivusConstants.BOARD_TYPE_HOSPITAL_BOARD)){
//			funcPostingCreate = FunctionHandler.getFunctionByBeanId("funcPostingCreateHospitalBoardPage");
//		}
//		
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingCreate.getId());
//		param.setAction("create");
//		param.setFunctionId(funcPostingCreate.getId());
//		
//		param.setBoardId( boardId);
//		param.addCondition( new SearchCondition( "boardId", boardId));
//		if( postingCategoryId != null){
//			param.addCondition( new SearchCondition( "categoryId", postingCategoryId));
//		}
//		Dispatcher dispatcher = editController.getDispatcher(request, response, param);
//		
//		PostingModel model = (PostingModel) dispatcher.getCommand();
//		if (model.getBoardId() == null) model.setBoardId(boardId);
//		if (model.getCategoryId() == null) model.setCategoryId(postingCategoryId);
//		
//		dispatcher.setCommand(model);
//		String xPath = param.getXpath();
//		if ( param.getXpath() == null || param.getXpath().equals("")){
//			xPath = "___/p/" +boardType+"/"+boardId;
//			if( postingCategoryId != null){
//				xPath += "/"+postingCategoryId;
//			}
//		}
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "command", dispatcher.getCommand());
//		mav.addObject( "boardId", boardId);
//		mav.addObject( "postingCategoryId", postingCategoryId);
//		mav.addObject( "boardType", boardType);
//		mav.addObject( "body_page", "givus_posting_write");
//		return mav;
//	}
//	
//	@RequestMapping( value="/posting/modify", method = RequestMethod.GET)
//	public ModelAndView viewPostingEdit( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewPostingWrite( null, request, response);
//	}
//	
//	@RequestMapping( value="/posting/modify/{boardType}", method = RequestMethod.GET)
//	public ModelAndView viewPostingEdit( @PathVariable String boardType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewPostingWrite( boardType, null, request, response);
//	}
//	/**
//	 * 게시글 수정
//	 * @param boardType
//	 * @param postingId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/posting/modify/{boardType}/{postingId}", method = RequestMethod.GET)
//	public ModelAndView viewPostingEdit( @PathVariable String boardType, @PathVariable Integer postingId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//			mav.addObject( "userConHospitalId", umodel.getHospitalId());
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.board.nosession"));
//		}
//		
//		if ( boardType == null){
//			boardType = GivusConstants.BOARD_TYPE_BOARD;
//		}
//		
//		if ( umodel.getUserType().equals( UserModel.USER_TYPE_GENERAL) && boardType.equals( GivusConstants.BOARD_TYPE_HOSPITAL_BOARD)){
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.hboard"));
//		
//		}else if ( umodel.getUserType().equals( UserModel.USER_TYPE_HOSPITAL) && boardType.equals( GivusConstants.BOARD_TYPE_HOSPITAL_BOARD) && ( umodel.getHospitalId() == null || umodel.getHospitalId() < 1)){
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.hboard.notconhospital"));
//		}
//		
//		
//		// get board category 
//		int rootCategoryId = GivusConstants.ROOTCATEGORYID_BOARD;
//		if ( boardType.equals( GivusConstants.BOARD_TYPE_HOSPITAL_BOARD)){
//			rootCategoryId = GivusConstants.ROOTCATEGORYID_HOSPITAL_BOARD;
//		}
//		
//		CategoryModel rootCategory = categoryService.getConnectedCategories( rootCategoryId);
//		mav.addObject( "leftMenu", rootCategory);
//		Function funcPostingModifyBoardPage = FunctionHandler.getFunctionByBeanId("funcPostingModifyBoardPage");
//
//		ContentsParameterHelper paramHelper = new ContentsParameterHelper( request);
//		ContentsParameter param = (ContentsParameter)paramHelper.buildParameter( funcPostingModifyBoardPage.getId());
//		if( param.getAction() == null || param.getAction().equals(""))  param.setAction("modify");
//		param.setFunctionId(funcPostingModifyBoardPage.getId());
//		
//		param.addCondition( new SearchCondition( "id", postingId));
//		
//		Dispatcher dispatcher = editController.getDispatcher(request, response, param);
//		
//		PostingModel model = (PostingModel) dispatcher.getCommand();
//		
//		dispatcher.setCommand(model);
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "command", dispatcher.getCommand());
//		mav.addObject( "boardType", boardType);
//		mav.addObject( "boardId", model.getBoardId());
//		mav.addObject( "postingCategoryId", model.getCategoryId());
//		mav.addObject( "body_page", "givus_posting_write");
//		return mav;
//	}
//	
//	/**
//	 * HOME 메뉴 사용시
//	 * @param postingId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/posting/view/{postingId}", method = RequestMethod.GET)
//	public ModelAndView viewPostingViewPage( @PathVariable Integer postingId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewPostingViewPage( null, postingId, request, response);
//	}
//
//	/**
//	 * CONTACT US 게시글 조회
//	 * @param boardType
//	 * @param postingId
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/posting/view/{boardType}/{postingId}", method = RequestMethod.GET)
//	public ModelAndView viewPostingViewPage( @PathVariable String boardType, @PathVariable Integer postingId, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		if ( boardType == null || ! ( boardType.equals( GivusConstants.BOARD_TYPE_CONTACKUS_NOTICE)
//				|| boardType.equals( GivusConstants.BOARD_TYPE_HOWTOUSE_GIVUS))){
//			boardType = GivusConstants.BOARD_TYPE_CONTACKUS_NOTICE;
//		}
//
//		
//		Function funcPostingView = FunctionHandler.getFunctionByBeanId("funcPostingViewHowToUseGivus");
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter();
//		param.setFunctionId(funcPostingView.getId());
//		param.setId(postingId);
//		
//		Dispatcher dispatcher = viewController.getDispatcher( request, response, param);
//		
//		PostingModel posting = (PostingModel)dispatcher.getData();
//		BoardModel board = (BoardModel) boardService.get( posting.getBoardId());
//		
//		String boardName = GivusConstants.BOARDNAME_NOTICE;
//		if ( GivusConstants.BOARD_FAQ_BOARDID == posting.getBoardId()){
//			boardName = GivusConstants.BOARDNAME_FAQ;
//		}else if ( GivusConstants.BOARD_INQUIRY_BOARDID == posting.getBoardId()){
//			boardName = GivusConstants.BOARDNAME_INQUIRY;
//		}else if ( GivusConstants.BOARD_HOWTOUSE_GIVUS_BOARDID == posting.getBoardId()){
//			boardName = GivusConstants.BOARDNAME_HOWTOUSE_GIVUS;
//		}
//		
//		mav.addObject( "boardName", boardName);
//		mav.addObject( "boardType", boardType);
//		mav.addObject( "board", board);
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "body_page", "givus_posting_view");
//		return mav;
//	}
//	/**
//	 * 회원가입약관
//	 * @param joinUserType
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/user/terms/{joinUserType}", method = RequestMethod.GET)
//	public ModelAndView viewUserTermsPage( @PathVariable String joinUserType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		String userAccount = "";
//		if ( umodel != null && umodel.getAccount() != null ){
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.wrong.access"));
//		}
//		if ( joinUserType == null || joinUserType.equals("")){
//			joinUserType = UserModel.USER_TYPE_GENERAL;
//		}
//		
//		mav.addObject( "joinUserType", joinUserType);
//		
//		mav.addObject( "body_page", "givus_user_terms");
//		return mav;
//	}
//	
//	@RequestMapping( value="/user/modify", method = RequestMethod.GET)
//	public ModelAndView viewMyInfoModifyPage(HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewMyInfoModifyPage( null, request, response);
//	}
//	/**
//	 * 사용자 정보수정
//	 * @param pageType
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/user/modify/{pageType}", method = RequestMethod.GET)
//	public ModelAndView viewMyInfoModifyPage( @PathVariable String pageType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		if ( pageType == null || pageType.equals("")){
//			pageType = GivusConstants.PAGETYPE_MYPAGE;
//		}
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//			mav.addObject( "userConHospitalId", umodel.getHospitalId());
//			if ( pageType.equals( GivusConstants.PAGETYPE_MYPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_HOSPITAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.g"));
//			}	
//			else if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_GENERAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.h"));
//			}
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.page.access"));
//		}
//		
//		//funcUserModifyGeneralUser, funcUserModifyHospitalUser
//		Function func = FunctionHandler.getFunctionByBeanId("funcUserModifyGeneralUser");
//		if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE ) ){
//			func = FunctionHandler.getFunctionByBeanId("funcUserModifyHospitalUser");
//		}
//		
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter();
//		param.setFunctionId(func.getId());
//		param.setAction("modify");
//		param.setId( umodel.getId());
//		Dispatcher dispatcher = editController.getDispatcher(request, response, param);
//		System.out.println(" param.getAction()="+ param.getAction());
//
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "command", dispatcher.getCommand());
//		mav.addObject( "pageType", pageType);
//		mav.addObject( "body_page", "givus_user_info_edit");
//		return mav;
//	}
//	
//	@RequestMapping( value="/user/withdraw", method = RequestMethod.GET)
//	public ModelAndView viewUserWithdrawPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewUserWithdrawPage( null, request, response);
//	}
//	//withdraw
//	/**
//	 * 회원탈퇴
//	 * @param pageType
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/user/withdraw/{pageType}", method = RequestMethod.GET)
//	public ModelAndView viewUserWithdrawPage( @PathVariable String pageType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		if ( pageType == null || pageType.equals("")){
//			pageType = GivusConstants.PAGETYPE_MYPAGE;
//		}
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//			if ( pageType.equals( GivusConstants.PAGETYPE_MYPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_HOSPITAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.g"));
//			}	
//			else if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_GENERAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.h"));
//			}
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.page.access"));
//		}
//		
//		mav.addObject( "pageType", pageType);
//		mav.addObject( "body_page", "givus_user_withdraw");
//		return mav;
//	}
//	
//
//	
//	@RequestMapping( value="/user/password/modify", method = RequestMethod.GET)
//	public ModelAndView viewMyInfoModifyPasswordPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		return viewMyInfoModifyPasswordPage( null, request, response);
//	}
//	/**
//	 * 비밀번호 수정
//	 * @param pageType
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/user/password/modify/{pageType}", method = RequestMethod.GET)
//	public ModelAndView viewMyInfoModifyPasswordPage( @PathVariable String pageType, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		if ( pageType == null || pageType.equals("")){
//			pageType = request.getParameter("pageType");
//			if ( pageType == null || pageType.equals("")){
//				pageType = GivusConstants.PAGETYPE_MYPAGE;
//			}
//		}
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//			mav.addObject( "userConHospitalId", umodel.getHospitalId());
//			if ( pageType.equals( GivusConstants.PAGETYPE_MYPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_HOSPITAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.g"));
//			}	
//			else if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_GENERAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.h"));
//			}
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.page.access"));
//		}
//		
//		//funcUserModifyGeneralUser, funcUserModifyHospitalUser
//		Function func = FunctionHandler.getFunctionByBeanId("funcUserModifyPasswordUser");
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter();
//		param.setFunctionId(func.getId());
//		param.setAction("modify");
//		param.setId( umodel.getId());
//		Dispatcher dispatcher = editController.getDispatcher(request, response, param);
//		System.out.println(" param.getAction()="+ param.getAction());
//
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "command", dispatcher.getCommand());
//		mav.addObject( "pageType", pageType);
//		mav.addObject( "body_page", "givus_user_password_edit");
//		return mav;
//	}
//	/**
//	 * 병원 연결 신청
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/user/conHospital/apply", method = RequestMethod.GET)
//	public ModelAndView viewHospitalConnectApplyPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/givus_page");
//		
//		String	pageType = GivusConstants.PAGETYPE_HOSPITALPAGE;
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//			mav.addObject( "userConHospitalId", umodel.getHospitalId());
//			if ( pageType.equals( GivusConstants.PAGETYPE_MYPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_HOSPITAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.g"));
//			}	
//			else if ( pageType.equals( GivusConstants.PAGETYPE_HOSPITALPAGE ) && umodel.getUserType().equals(UserModel.USER_TYPE_GENERAL)){
//				throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.mypage.h"));
//			}
//		}
//		else
//		{
//			throw new GivusAuthorityException( MessageHandler.getMessage("authrity.error.page.access"));
//		}
//		
//		Function func = FunctionHandler.getFunctionByBeanId("funcUserConHospitalCreatePage");
//		ParameterHelper paramHelper = new ParameterHelper( request);
//		Parameter param = paramHelper.buildParameter();
//		
//		param.setAction("create");
//		param.setFunctionId(func.getId());
//		UserModel user = (UserModel)userService.getByAccount(umodel.getAccount());
//		
//		UserConnectHospitalModel usercon = (UserConnectHospitalModel)userConnectHospitalService.get( new SearchCondition( "userId",  user.getId()));
//		if ( usercon != null){
//			param.setAction("modify");
//		}
//		
//		Dispatcher dispatcher = editController.getDispatcher(request, response, param);
//		
//		System.out.println( "dispatcher.getData()=" + dispatcher.getData());
//		System.out.println( "dispatcher.getCommand()=" + dispatcher.getCommand());
//		if ( usercon != null){
//			param.setAction("modify");
//			dispatcher.setCommand( usercon);
//		}
//		
//		mav.addObject( "dispatcher", dispatcher);
//		mav.addObject( "command", dispatcher.getCommand());
//		mav.addObject( "pageType", pageType);
//		mav.addObject( "body_page", "givus_user_conhospital_apply");
//		return mav;
//	}
//	
//	
//	/***** ENGLISH SITE START ****/
//	/**
//	 * 영문 메인화면
//	 * @param request
//	 * @param response
//	 * @return
//	 * @throws DAException
//	 * @throws Exception
//	 */
//	@RequestMapping( value="/english/main", method = RequestMethod.GET)
//	public ModelAndView viewEnMainPage( HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
//		ModelAndView mav = new ModelAndView("givus/english/givus_page");
//		
//		//사용자 로그인 여부 설정
//		UserModel umodel = GivusUserContext.getUserModel();
//		if ( umodel != null && umodel.getAccount() != null ){
//			mav.addObject( "userAccount", umodel.getAccount());
//			mav.addObject( "userNickname", umodel.getNickname());
//			mav.addObject( "userType", umodel.getUserType());
//		}
//		
//		// 성형정보 목록
//		Function funcPostingListSurgeryInfoPage = FunctionHandler.getFunctionByBeanId( "funcPostingListSurgeryInfoPortletPage");
//		List<SearchCondition> infoconditions = new ArrayList<SearchCondition>();
//		infoconditions.add( new SearchCondition( "boardId", GivusConstants.BOARD_SURGERY_INFO_BOARDID ));
//		infoconditions.add( new SearchCondition( "categoryId", GivusConstants.POSTINGCATEGORY_SURGERY_INFO_ID ));
//		
//		List<PostingModel> surgeryInfoPostings = (List<PostingModel>)postingService.search( 0, 7, infoconditions, "id DESC");
//		renderHandler.renderData( surgeryInfoPostings, funcPostingListSurgeryInfoPage.getRenders());
//		mav.addObject( "surgeryInfoPostings", surgeryInfoPostings);
//		// 성형정보 첫번째 글의 사진이 있으면 가져오기
//		if ( surgeryInfoPostings != null && surgeryInfoPostings.size()>0){
//			List<SearchCondition> infoFileConditions = new ArrayList<SearchCondition>();
//			infoFileConditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
//			infoFileConditions.add( new SearchCondition( "relationId", surgeryInfoPostings.get(0).getId()));
//			infoFileConditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
//			List<FileModel> infoFiles = (List<FileModel>)fileService.search( 0, 7, infoFileConditions);
//			if ( infoFiles != null && infoFiles.size()>0){
//				mav.addObject( "infoFileId", infoFiles.get(0).getId());
//			}
//		}
//		
//
//		// 성형뉴스 목록
//		Function funcPostingListSurgeryNewsPage = FunctionHandler.getFunctionByBeanId( "funcPostingListSurgeryInfoPortletPage");
//		List<SearchCondition> newsconditions = new ArrayList<SearchCondition>();
//		newsconditions.add( new SearchCondition( "boardId", GivusConstants.BOARD_SURGERY_INFO_BOARDID ));
//		newsconditions.add( new SearchCondition( "categoryId", GivusConstants.POSTINGCATEGORY_SURGERY_NEWS_ID ));
//		
//		List<PostingModel> surgeryNewsPostings = (List<PostingModel>)postingService.search( 0, 7, newsconditions, "id DESC");
//		renderHandler.renderData( surgeryNewsPostings, funcPostingListSurgeryNewsPage.getRenders());
//		mav.addObject( "surgeryNewsPostings", surgeryNewsPostings);
//		//newsFileId
//		// 성형뉴스 첫번째 글의 사진이 있으면 가져오기
//		if ( surgeryNewsPostings != null && surgeryNewsPostings.size()>0){
//			List<SearchCondition>newsFileConditions = new ArrayList<SearchCondition>();
//			newsFileConditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
//			newsFileConditions.add( new SearchCondition( "relationId", surgeryNewsPostings.get(0).getId()));
//			newsFileConditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
//			List<FileModel> newsFiles = (List<FileModel>)fileService.search( 0, 7, newsFileConditions);
//			if ( newsFiles != null && newsFiles.size()>0){
//				mav.addObject( "newsFileId", newsFiles.get(0).getId());
//			}
//		}
//		
//		// 게시판 목록
//		Function funcGeneralPostingList = FunctionHandler.getFunctionByBeanId( "funcPostingListContents40");
//		
//		// get board category 
//		int rootCategoryId = GivusConstants.ROOTCATEGORYID_BOARD;
//		CategoryModel rootCategory = categoryService.getConnectedCategories( rootCategoryId);
//				
//		// best view postings
//		List<SearchCondition> generalPostingConditions = new ArrayList<SearchCondition>();
//		generalPostingConditions.add( new PlainSearchCondition( "boardId IN (SELECT relatedId FROM Category WHERE relatedType = 'board' AND nodePath LIKE '" + rootCategory.getNodePath() + "%')"));
//		
//		List<PostingModel> generalPostings = (List<PostingModel>)postingService.search( 0, 7, /*1, PostingModel.POSTING_SELECTFIELD_EXCEPT_CONTENTS, */generalPostingConditions, "id DESC");
//		renderHandler.renderData( generalPostings, funcGeneralPostingList.getRenders());
//		mav.addObject( "generalPostings", generalPostings);
//		//gpostingFileId
//		// 게시판 첫번째 글의 사진이 있으면 가져오기
//		if ( generalPostings != null && generalPostings.size()>0){
//			List<SearchCondition> gpostingFileConditions = new ArrayList<SearchCondition>();
//			gpostingFileConditions.add( new SearchCondition( "fileType", FileModel.FILE_TYPE_IMAGE));
//			gpostingFileConditions.add( new SearchCondition( "relationId", generalPostings.get(0).getId()));
//			gpostingFileConditions.add( new PlainSearchCondition( "relationType IN ( 'posting', 'posting_contents')"));
//			List<FileModel> gpostingFiles = (List<FileModel>)fileService.search( 0, 7, gpostingFileConditions);
//			if ( gpostingFiles != null && gpostingFiles.size()>0){
//				mav.addObject( "gpostingFileId", gpostingFiles.get(0).getId());
//			}
//		}
//		
//		//우리병원PR
//		// hospital's photo
//		List<SearchCondition> prConditions = new ArrayList<SearchCondition>();
//		prConditions.add( new SearchCondition( "relationType", "hospitalpr_gallery"));
//		List<FileModel> hospitalprFiles = fileService.search( prConditions);
//		mav.addObject( "hospitalprFiles", hospitalprFiles);
//		
//		
//		//병원 이벤트
//		// event list
//		Function funcHospitalEventList = FunctionHandler.getFunctionByBeanId("funcHospitalEventList");
//
//		List<SearchCondition> eventConditions = new ArrayList<SearchCondition>();
//		eventConditions.add( new PlainSearchCondition( " startDate < now() "));
//		List<HospitalEventModel> hospitalEvents = (List<HospitalEventModel>)hospitalEventService.search( 0, 10, 1, HospitalEventModel.HOSPITALEVENT_SELECTFIELD_WITH_STATUS, eventConditions, "recommendCount DESC");
//		renderHandler.renderData( hospitalEvents, funcHospitalEventList.getRenders());
//		mav.addObject( "hospitalEvents", hospitalEvents);	
//		
//		
//		//인기 병원
//		Function funcHospitalListOrderByViewCount = FunctionHandler.getFunctionByBeanId( "funcHospitalListOrderByViewCount");
//		List<HospitalModel> bestViewHospitals = (List<HospitalModel>)hospitalService.search( 0, 10, 1, null, "viewCount DESC");
//		renderHandler.renderData( bestViewHospitals, funcHospitalListOrderByViewCount.getRenders());
//		mav.addObject( "bestViewHospitals", bestViewHospitals);	
//
//		
//		
//		mav.addObject( "body_page", "givus_main");
//		return mav;
//	}	
//	
//	
//	/***** ENGLISH STTE END   ****/
//}
