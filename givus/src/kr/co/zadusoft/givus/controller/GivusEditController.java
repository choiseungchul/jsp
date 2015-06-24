/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.givus.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;

import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.DateUtil;
import dynamic.util.HttpServiceContext;
import dynamic.util.StringUtil;
import dynamic.web.func.Function;
import dynamic.web.func.FunctionHandler;
import dynamic.web.resource.Constants;
import dynamic.web.view.Dispatcher;
import kr.co.zadusoft.contents.controller.ContentsEditController;
import kr.co.zadusoft.contents.model.BoardModel;
import kr.co.zadusoft.contents.model.CategoryModel;
import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.model.HospitalEvaluationModel;
import kr.co.zadusoft.contents.model.KeywordModel;
import kr.co.zadusoft.contents.model.OperationPriceModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.ReviewPointsModel;
import kr.co.zadusoft.contents.model.UserConnectHospitalModel;
import kr.co.zadusoft.contents.model.UserKeywordModel;
import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.service.CategoryService;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.service.KeywordService;
import kr.co.zadusoft.contents.service.OperationPriceService;
import kr.co.zadusoft.contents.service.UserConnectHospitalService;
import kr.co.zadusoft.contents.service.UserKeywordService;
import kr.co.zadusoft.contents.service.UserService;
import kr.co.zadusoft.contents.util.ContentsConstants;
import kr.co.zadusoft.givus.util.FileUploadUtil;
import kr.co.zadusoft.givus.util.GivusConstants;
import kr.co.zadusoft.givus.util.GivusUserContext;
import kr.co.zadusoft.givus.util.GivusUtil;

public class GivusEditController extends ContentsEditController{
	
	private OperationPriceService operationPriceService;

	private KeywordService keywordService;
	
	private UserKeywordService userKeywordService;
	
	private UserService userService;
	
	@Autowired
	private UserConnectHospitalService userConnectHospitalService;
	
	@Autowired
	private GivusLoginController loginController;
	
	public OperationPriceService getOperationPriceService() {
		return operationPriceService;
	}

	public void setOperationPriceService(OperationPriceService operationPriceService) {
		this.operationPriceService = operationPriceService;
	}
	public KeywordService getKeywordService() {
		return keywordService;
	}

	public void setKeywordService(KeywordService keywordService) {
		this.keywordService = keywordService;
	}
	
	public UserKeywordService getUserKeywordService() {
		return userKeywordService;
	}

	public void setUserKeywordService(UserKeywordService userKeywordService) {
		this.userKeywordService = userKeywordService;
	}

	public GivusLoginController getLoginController() {
		return loginController;
	}

	public void setLoginController(GivusLoginController loginController) {
		this.loginController = loginController;
	}

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public UserConnectHospitalService getUserConnectHospitalService() {
		return userConnectHospitalService;
	}

	public void setUserConnectHospitalService(
			UserConnectHospitalService userConnectHospitalService) {
		this.userConnectHospitalService = userConnectHospitalService;
	}

	@Override
	public Dispatcher getDispatcher(HttpServletRequest request, HttpServletResponse response, Parameter param) throws Exception {
	
		Dispatcher dispatcher = super.getDispatcher( request, response, param);
		
		if( FunctionHandler.equals( "funcOperationPriceEdit", param.getFunctionId())){
			CategoryModel rootCategory = operationPriceService.getOperationPriceCategory( param.getId());
			request.setAttribute( "operationCategoryRoot", rootCategory);
		}else if( FunctionHandler.equals( "funcHospitalGalleryEdit", param.getFunctionId())){
			List<SearchCondition> conditions = new ArrayList<SearchCondition>();
			conditions.add( new SearchCondition( "relationId", param.getId()));
			conditions.add( new SearchCondition( "relationType", "hospital_gallery"));
			List<FileModel> files = fileService.search( conditions);
			
			FileUploadUtil.prepareDownloadJSON( files);
			
			request.setAttribute( "files", files);
		}else if( FunctionHandler.equals( "funcHospitalPRGalleryEdit", param.getFunctionId())){
			List<SearchCondition> conditions = new ArrayList<SearchCondition>();
			conditions.add( new SearchCondition( "relationType", "hospitalpr_gallery"));
			List<FileModel> files = fileService.search( conditions);
			
			FileUploadUtil.prepareDownloadJSON( files);
			
			request.setAttribute( "files", files);
		}else if( FunctionHandler.equals( "funcUserCreateGeneralUserSelf", param.getFunctionId()) 
				|| FunctionHandler.equals( "funcUserCreateHospitalUserSelf",  param.getFunctionId())){
			
			List<KeywordModel> keywordModels = (List<KeywordModel>)keywordService.getAll();
			request.setAttribute( "keywordModels", keywordModels);
		}else if ( FunctionHandler.equals( "funcPostingEditFeedback", param.getFunctionId())){
			request.setAttribute( "boardId", GivusConstants.BOARD_FEEDBACK_BOARDID);
		}else if( FunctionHandler.equals( "funcPostingEditReview", param.getFunctionId())){
			
			PostingModel model = (PostingModel)dispatcher.getCommand();
			
			if ( model != null){
				String enoughDesc = request.getParameter("enoughDesc");
				String considerNeeds = request.getParameter("considerNeeds");
				String reaction = request.getParameter("reaction");
				String facilities = request.getParameter("facilities");
				String waitingTime = request.getParameter("waitingTime");
				String privacy = request.getParameter("privacy");
				String reliability = request.getParameter("reliability");
				/*String dealingWith = request.getParameter("dealingWith");*/
				String transportation = request.getParameter("transportation");
				String stress = request.getParameter("stress");
				String afterSupport = request.getParameter("afterSupport");
				String amount = request.getParameter("amount");
				String resultSatisfaction = request.getParameter("resultSatisfaction");
				String hospitalId = request.getParameter("hid");
				
				ReviewPointsModel reviewPoints = (ReviewPointsModel) reviewPointsService.get( new SearchCondition( "postingId", model.getId()));
				if ( reviewPoints == null)
					reviewPoints = new ReviewPointsModel();
				
				UserModel umodel = GivusUserContext.getUserModel();
				if ( umodel != null){
//					reviewPoints.setAgeGroup(GivusUtil.getAgeGroup( umodel.getBirthday()));
					reviewPoints.setGender( umodel.getGender());
				}
				
				reviewPoints.setHospitalId( (hospitalId != null && !hospitalId.equals("")) ? Integer.parseInt( hospitalId): 0);
				reviewPoints.setEnoughDesc( (enoughDesc != null && !enoughDesc.equals("")) ? Integer.parseInt( enoughDesc): 0);
				reviewPoints.setConsiderNeeds( (considerNeeds != null && !considerNeeds.equals("")) ? Integer.parseInt( considerNeeds): 0);
				reviewPoints.setReaction( (reaction != null && !reaction.equals("")) ? Integer.parseInt( reaction): 0);
				reviewPoints.setFacilities( (facilities != null && !facilities.equals("")) ? Integer.parseInt( facilities): 0);
				reviewPoints.setWaitingTime( (waitingTime != null && !waitingTime.equals("")) ? Integer.parseInt( waitingTime): 0);
				reviewPoints.setPrivacy( (privacy != null && !privacy.equals("")) ? Integer.parseInt( privacy): 0);
				reviewPoints.setReliability( (reliability != null && !reliability.equals("")) ? Integer.parseInt( reliability): 0);
				/*reviewPoints.setDealingWith( (dealingWith != null && !dealingWith.equals("")) ? Integer.parseInt( dealingWith): 0);*/
				reviewPoints.setTransportation( (transportation != null && !transportation.equals("")) ? Integer.parseInt( transportation): 0);
				reviewPoints.setStress( (stress != null && !stress.equals("")) ? Integer.parseInt( stress): 0);
				reviewPoints.setAfterSupport( (afterSupport != null && !afterSupport.equals("")) ? Integer.parseInt( afterSupport): 0);
				reviewPoints.setAmount( (amount != null && !amount.equals("")) ? Integer.parseInt( amount): 0);
				reviewPoints.setResultSatisfaction( (resultSatisfaction != null && !resultSatisfaction.equals("")) ? Integer.parseInt( resultSatisfaction): 0);
				
				model.setReviewPoints(reviewPoints);
				dispatcher.setCommand(model);
			}
		}else if ( 	FunctionHandler.equals("funcUserModifyGeneralUser", param.getFunctionId())
				|| FunctionHandler.equals("funcUserModifyHospitalUser", param.getFunctionId())){
			List<KeywordModel> keywordModels = (List<KeywordModel>)keywordService.getAll();
			request.setAttribute( "keywordModels", keywordModels);
			UserModel model = (UserModel)dispatcher.getCommand();
//			if ( model.getAddress() != null && !model.getAddress().equals("")){
//				String[] address = model.getAddress().split(GivusConstants.DEL_BACKSPACE_B);
//				if ( address.length > 0) { model.setAddress1(address[0]);}
//				if ( address.length > 1) { model.setAddress2(address[1]);}
//			}
//			if ( model.getTel() != null && !model.getTel().equals("")){
//				String[] tel = model.getTel().split( GivusConstants.DEL_HYPHEN);
//				if ( tel.length > 0) { model.setTel1(tel[0]);}
//				if ( tel.length > 1) { model.setTel2(tel[1]);}
//				if ( tel.length > 2) { model.setTel3(tel[2]);}
//			}
//			if ( model.getMobile1() != null && !model.getMobile1().equals("")){
//				String[] mobile = model.getMobile().split( GivusConstants.DEL_HYPHEN);
//				if ( mobile.length > 0) { model.setMobile1(mobile[0]);}
//				if ( mobile.length > 1) { model.setMobile2(mobile[1]);}
//				if ( mobile.length > 2) { model.setMobile3(mobile[2]);}
//			}
//			if ( model.getPostalCode() != null && !model.getPostalCode().equals("")){
//				String[] postalCode = model.getPostalCode().split( GivusConstants.DEL_HYPHEN);
//				if ( postalCode.length > 0) { model.setPostalCode1(postalCode[0]);}
//				if ( postalCode.length > 1) { model.setPostalCode2(postalCode[1]);}
//			}
//			if ( model.getEmail() != null && !model.getEmail().equals("")){
//				String[] email = model.getEmail().split( GivusConstants.DEL_AT);
//				if ( email.length > 0) { model.setEmail(email[0]);}
//				if ( email.length > 1) { model.setEmail2(email[1]);}
//			}
			dispatcher.setCommand(model);
			List<UserKeywordModel> userKeywordModels =  (List<UserKeywordModel>) userKeywordService.search( new SearchCondition( "userId", model.getId()));
			request.setAttribute( "userKeywordModels", userKeywordModels);
		}
		
		return dispatcher;
	}
	
	@Override
	protected ModelAndView onSubmit(HttpServletRequest request, HttpServletResponse response, Object command, BindException errors) throws Exception {
		// Spring 에서 래핑된 MultipartHttpServletRequest 를 재 설정한다.
		HttpServiceContext.init( request, response);
		
		Parameter param = buildParameter(request);
		Function func = functionHandler.getFunction( param.getFunctionId());
		
		if( FunctionHandler.equals( "funcUserCreateGeneralUserSelf", func.getId()) 
				|| FunctionHandler.equals( "funcUserCreateHospitalUserSelf", func.getId())
				|| FunctionHandler.equals("funcUserModifyGeneralUser", func.getId())
				|| FunctionHandler.equals("funcUserModifyHospitalUser", func.getId())){
			UserModel model = (UserModel)command;
			
			// 사용자 정보 셋팅
			StringBuilder address = new StringBuilder();
//			if ( model.getAddress1() != null && !model.getAddress1().equals("")) address.append( model.getAddress1()).append( GivusConstants.DEL_BACKSPACE_B);
//			if ( model.getAddress2() != null && !model.getAddress2().equals("")) address.append( model.getAddress2());
//			model.setAddress(address.toString());
//			
//			StringBuilder tel = new StringBuilder();
//			if ( model.getTel1() != null  && !model.getTel1().equals("")) tel.append( model.getTel1()).append( GivusConstants.DEL_HYPHEN);
//			if ( model.getTel2() != null  && !model.getTel2().equals("")) tel.append( model.getTel2()).append( GivusConstants.DEL_HYPHEN);
//			if ( model.getTel3() != null  && !model.getTel3().equals("")) tel.append( model.getTel3());
//			model.setTel(tel.toString());
//			
//			StringBuilder moblie = new StringBuilder();
//			if ( model.getMobile1() != null  && !model.getMobile1().equals("")) moblie.append( model.getMobile1()).append( GivusConstants.DEL_HYPHEN);
//			if ( model.getMobile2() != null  && !model.getMobile2().equals("")) moblie.append( model.getMobile2()).append( GivusConstants.DEL_HYPHEN);
//			if ( model.getMobile3() != null  && !model.getMobile3().equals("")) moblie.append( model.getMobile3());
//			model.setMobile(moblie.toString());
//			
//			StringBuilder postalCode = new StringBuilder();
//			if ( model.getPostalCode1() != null && !model.getPostalCode1().equals("")) postalCode.append( model.getPostalCode1()).append( GivusConstants.DEL_HYPHEN);
//			if ( model.getPostalCode2() != null && !model.getPostalCode2().equals("")) postalCode.append( model.getPostalCode2());
//			model.setPostalCode(postalCode.toString());
			
			StringBuilder email = new StringBuilder();
			if ( model.getEmail() != null && !model.getEmail().equals("")) email.append( model.getEmail()).append( GivusConstants.DEL_AT);
			if ( model.getEmail2() != null && !model.getEmail2().equals("")) email.append( model.getEmail2());
			else if( model.getEmail3() != null && !model.getEmail3().equals("")) email.append( model.getEmail3());
			model.setEmail(email.toString());
			
			if ( model.getUserType().equals( UserModel.USER_TYPE_HOSPITAL))
			{
				model.setName( model.getNickname());
			}
			if ( model.getUserStatus() == null || model.getUserStatus().equals("")){
				 model.setUserStatus( UserModel.USER_USERSTATUS_ACTIVATE);
			}
			model.setLastPasswordChangeDate( new Date());
			
			
		}else if( FunctionHandler.equals( "funcUserLock", func.getId())){
			UserModel model = (UserModel)command;
			model.setUserStatus(UserModel.USER_USERSTATUS_LOCK);
		}else if( FunctionHandler.equals( "funcUserActivate", func.getId())){
			UserModel model = (UserModel)command;
			model.setUserStatus(UserModel.USER_USERSTATUS_ACTIVATE);
		}else if( FunctionHandler.equals( "funcUserDelete", func.getId())){
			UserModel model = (UserModel)command;
			model.setUserStatus(UserModel.USER_USERSTATUS_DELETE);
		}else if ( FunctionHandler.equals( "funcPostingEditFeedback", func.getId())){
			PostingModel model = (PostingModel)command;
			model.setBoardId( GivusConstants.BOARD_FEEDBACK_BOARDID);
			if ( model.getSubject() == null ||  model.getSubject().equals("")){
				model.setSubject("Feedback");
				
			}
		}else if ( 	FunctionHandler.equals("funcUserConHospitalCreate", param.getFunctionId())
				|| FunctionHandler.equals("funcUserConHospitalCreatePage", param.getFunctionId())){
			UserConnectHospitalModel model = (UserConnectHospitalModel)command;
			model.setRequestDate( new Date());
			model.setStatus( UserConnectHospitalModel.USERCONHOSPITAL_STATUS_WAIT);
			UserModel umodel = GivusUserContext.getUserModel();
			if ( umodel != null && umodel.getId() > 0 ){
				model.setUserId( umodel.getId());
			}
			
			System.out.println( "funcUserConHospitalCreate왔는가~");
		}else if ( 	FunctionHandler.equals("funcUserConHospitalApproval", param.getFunctionId())){
			UserConnectHospitalModel model = (UserConnectHospitalModel)command;
			model.setApprovalDate( new Date());
			model.setApprover( GivusUserContext.getUserModel().getAccount());
		}else if ( FunctionHandler.equals( "funcPostingCreateInquiryPage", func.getId())){
			PostingModel model = (PostingModel)command;
			System.out.println( "model = " + model.getContents());
			model.setBoardId( GivusConstants.BOARD_INQUIRY_BOARDID);
			if ( model.getSubject() == null ||  model.getSubject().equals("")){
				model.setSubject("1:1문의하기( " + model.getCreator() + ")");
			}
		}
		
		//return super.onSubmit(request, response, command, errors);
		ModelAndView mav = super.onSubmit( request, response, command, errors);
		
		//Parameter param = buildParameter(request);
		if( FunctionHandler.equals( "funcPostingEditReview", param.getFunctionId())){
			System.out.println( "ch_satisfaction_research=" + request.getParameter("ch_satisfaction_research"));
			String satisfactionResearch =  request.getParameter("ch_satisfaction_research");
			
			if ( satisfactionResearch != null)
			{
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
			}
			
		}else if ( FunctionHandler.equals( "funcUserCreateGeneralUserSelf", func.getId()) 
				|| FunctionHandler.equals( "funcUserCreateHospitalUserSelf", func.getId())){
			UserModel model = (UserModel)command;
			
			// 사용자 키워드 셋팅
			UserKeywordModel userKeywordmodel = new UserKeywordModel();
			userKeywordmodel.setUserId( model.getId());

			String userKeyword = request.getParameter( "userKeyword");
			String keyIds[] = StringUtil.splitString(userKeyword, Constants.DEL_COMMA);
			if ( keyIds != null && keyIds.length > 0){
				for ( String keyId : keyIds ){
					if ( keyId != null && !keyId.equals("")){
						//int id = Integer.parseInt( keyId);
						userKeywordmodel.setId( 0);
						userKeywordmodel.setKeywordId(  Integer.parseInt( keyId));
						userKeywordService.create( userKeywordmodel);
					}
				}
			}
			
			loginController.setLoginStatus(model);
		}else if ( FunctionHandler.equals("funcUserModifyGeneralUser", func.getId())
				|| FunctionHandler.equals("funcUserModifyHospitalUser", func.getId())){
			UserModel model = (UserModel)command;
			
			// 사용자 키워드 셋팅
			List<UserKeywordModel> userKeywordModels =  (List<UserKeywordModel>) userKeywordService.search( new SearchCondition( "userId", model.getId()));
			
			String userKeyword = request.getParameter( "userKeyword");
			String keyIds[] = StringUtil.splitString(userKeyword, Constants.DEL_COMMA);
			
			// 1. DB에는 있으나 체크되지 않으면 삭제
			if ( userKeywordModels != null){
				boolean exist = false;
				for ( UserKeywordModel userKeywordModel : userKeywordModels){
					if ( keyIds != null && keyIds.length > 0){
						exist = false;
						for ( String keyId : keyIds ){
							if ( keyId != null && !keyId.equals("")){
								int keyword = Integer.parseInt( keyId);
								if ( keyword == userKeywordModel.getKeywordId()){
									exist = true;
								}
							}
						}
						// 체크되지 않아서 삭제
						if ( !exist){
							userKeywordService.delete( userKeywordModel.getId());
						}
						
					}else{
						userKeywordService.delete( userKeywordModel.getId());
					}
				}
			}
			// 2. DB에 없으나 체크되어 있으면 생성
			
			if ( keyIds != null && keyIds.length > 0){
				boolean exist = false;
				for ( String keyId : keyIds ){
					if ( keyId != null && !keyId.equals("")){
						//int id = Integer.parseInt( keyId);
						if ( userKeywordModels != null){
							exist = false;
							for ( UserKeywordModel userKeywordModel : userKeywordModels){
								// 있는 데이터가 그대로 체크되어있으면 냅두고, 체크되어 있지 않으나 DB에 없으면 생성
								int keyword = Integer.parseInt( keyId);
								if ( keyword == userKeywordModel.getKeywordId()){
									exist = true;
								}
							}
							// 체크되었으나 DB에 없어서 생성
							if ( !exist){
								UserKeywordModel userKeywordmodel = new UserKeywordModel();
								userKeywordmodel.setUserId( model.getId());
								userKeywordmodel.setKeywordId(  Integer.parseInt( keyId));
								userKeywordService.create( userKeywordmodel);
							}
						}
					}
				}
			}
		}else if ( 	FunctionHandler.equals("funcUserConHospitalApproval", func.getId())){
			
			UserConnectHospitalModel model = (UserConnectHospitalModel)command;
			int id = model.getUserId();
			if ( id > 0){
				UserModel umodel = (UserModel) userService.get(id);
				// 병원사용자인 경우에만 병원 연결함
				if ( umodel != null && umodel.getUserType().equals( UserModel.USER_TYPE_HOSPITAL)){
					int hospitalId = 0;
					if ( model.getStatus().equals( UserConnectHospitalModel.USERCONHOSPITAL_STATUS_APPROVAL)){
						hospitalId = model.getHospitalId();
					}else{
						hospitalId = 0;
					}
					umodel.setHospitalId( hospitalId);
					userService.update( umodel);
				}
			}
		}	
			
		
		return mav;
	}
	
	@Override
	protected Object getNewObject(Function func) throws Exception {
		Object obj = super.getNewObject( func);
		
		if( FunctionHandler.equals( "funcPostingCreateHospitalBoardPage", func.getId()) //funcPostingCreateBoardPage
				|| FunctionHandler.equals( "funcPostingEditEpilogue", func.getId())
				|| FunctionHandler.equals( "funcPostingEditReview", func.getId())
				|| FunctionHandler.equals( "funcPostingModifyBoardPage", func.getId())
				|| FunctionHandler.equals( "funcPostingCreateInquiryPage", func.getId())
				){
			PostingModel model = (PostingModel)obj;
			
			String boardId = HttpServiceContext.getParameter( ContentsConstants.PARAM_BID);

			int bid = ( boardId == null || boardId.equals("")) ? 0 :  Integer.parseInt( boardId);
			if ( ( boardId == null || boardId.equals("")) &&
					FunctionHandler.equals( "funcPostingCreateInquiryPage", func.getId())){
				bid = GivusConstants.BOARD_INQUIRY_BOARDID;
			}else if ( ( boardId == null || boardId.equals("")) &&
					FunctionHandler.equals( "funcPostingEditEpilogue", func.getId())){
				bid = GivusConstants.BOARD_HOSPITAL_EPILOGUE_BOARDID;
			}else if ( ( boardId == null || boardId.equals("")) &&
					FunctionHandler.equals( "funcPostingEditReview", func.getId())){
				bid = GivusConstants.BOARD_HOSPITAL_REVIEW_BOARDID;
			}
			
			BoardModel board = (BoardModel)boardService.get( bid);
			model.setBoard( board);
			
			model.setBoardId( board.getId());
			
		}
				
		return obj;
	}
}
