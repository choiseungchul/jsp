/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.model.HospitalEventModel;
import kr.co.zadusoft.contents.model.HospitalEventUserActionModel;
import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.PostingUserActionModel;
import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.service.HospitalEventService;
import kr.co.zadusoft.contents.service.HospitalEventUserActionService;
import kr.co.zadusoft.contents.service.HospitalService;
import kr.co.zadusoft.contents.util.ContentsParameter;
import kr.co.zadusoft.givus.controller.GivusListController;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.ibatis.util.PlainSearchCondition;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.controller.ListController;
import dynamic.web.dao.DAException;
import dynamic.web.func.Function;
import dynamic.web.func.FunctionHandler;
import dynamic.web.util.MessageHandler;
import dynamic.web.util.SessionContext;
import dynamic.web.view.Dispatcher;

@Controller
@RequestMapping( value="/___/hospitalevent")
public class HospitalEventController {
	
	@Autowired
	private ListController listController;
	
	@Autowired
	private GivusListController glistController;
	
	@Autowired
	private HospitalService hospitalService;
	
	@Autowired
	private HospitalEventService hospitalEventService;
	
	@Autowired
	private HospitalEventUserActionService hospitalEventUserActionService;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private MessageHandler msgHandler;
	
	public ListController getListController() {
		return listController;
	}

	public void setListController(ListController listController) {
		this.listController = listController;
	}
	public GivusListController getGlistController() {
		return glistController;
	}

	public void setGlistController(GivusListController glistController) {
		this.glistController = glistController;
	}
	
	public HospitalService getHospitalService() {
		return hospitalService;
	}

	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}
	
	public HospitalEventUserActionService getHospitalEventUserActionService() {
		return hospitalEventUserActionService;
	}

	public void setHospitalEventUserActionService( HospitalEventUserActionService hospitalEventUserActionService) {
		this.hospitalEventUserActionService = hospitalEventUserActionService;
	}
	
	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	public MessageHandler getMsgHandler() {
		return msgHandler;
	}

	public void setMsgHandler(MessageHandler msgHandler) {
		this.msgHandler = msgHandler;
	}
	
	public HospitalEventService getHospitalEventService() {
		return hospitalEventService;
	}

	public void setHospitalEventService(HospitalEventService hospitalEventService) {
		this.hospitalEventService = hospitalEventService;
	}

	@RequestMapping( value="/{hospitalId}", method = RequestMethod.POST)
	public ModelAndView hospitalEventDetailView( @PathVariable Integer hospitalId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_hospital_event_detail");
		if( hospitalId != null){
			
			// hospital info
			HospitalModel hospital = (HospitalModel)hospitalService.get( hospitalId);
			
			// event list
			Function func = FunctionHandler.getFunctionByBeanId( "funcHospitalEventList");
			ContentsParameter param = (ContentsParameter)listController.buildParameter( request, func.getId());
			param.setFunctionId( func.getId());
			param.addCondition( new SearchCondition( "hospitalId", hospitalId));
			
			Dispatcher dispatcher = listController.getDispatcher( request, response, param);
			//Dispatcher dispatcher = glistController.getDispatcher( request, response, param);
			
			List datas = dispatcher.getDatas();
			int size = datas.size();
			Date now = new Date();
			for( int i=0; i < size; i++){
				HospitalEventModel model = (HospitalEventModel)datas.get( i);
				if( model.getStartDate().compareTo( now) <= 0 && model.getEndDate().compareTo( now) >= 0){
					model.addRenderedData( "progress", "I");
				}else if( model.getStartDate().compareTo( now) > 0){
					model.addRenderedData( "progress", "E");
				}
				//fileid 넣기
				if ( hospital.getThumbFileId() == null || hospital.getThumbFileId() == 0 ){
					List<SearchCondition> conditions = new ArrayList<SearchCondition>();
					conditions.add( new SearchCondition( "relationId", hospital.getId()));
					conditions.add( new SearchCondition( "relationType", "hospital"));
					
					FileModel fmodel = (FileModel)fileService.get(conditions);
					if( fmodel != null){ 
						hospital.setThumbFileId(fmodel.getId());
					}
				}
			}
			
			mav.addObject( "hospital", hospital);
			mav.addObject( "dispatcher", dispatcher);
		}
		
		return mav;
	}
	
	@RequestMapping( value="/bestview", method = RequestMethod.POST)
	public ModelAndView bestViewHospitalView( HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_hospital_event_best_view");
		
		Function func = FunctionHandler.getFunctionByBeanId( "funcHospitalListOrderByViewCount");
		ContentsParameter param = (ContentsParameter)listController.buildParameter( request, func.getId());
		param.setFunctionId( func.getId());
		
		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
		
		List datas = dispatcher.getDatas();
		int size = datas.size();
		for( int i=0; i < size; i++){
			HospitalModel model = (HospitalModel)datas.get( i);
			//fileid 넣기
			if ( model.getThumbFileId() == null || model.getThumbFileId() == 0 ){
				List<SearchCondition> conditions = new ArrayList<SearchCondition>();
				conditions.add( new SearchCondition( "relationId", model.getId()));
				conditions.add( new SearchCondition( "relationType", "hospital"));
				
				FileModel fmodel = (FileModel)fileService.get(conditions);
				if( fmodel != null){ 
					model.setThumbFileId(fmodel.getId());
				}
			}
		}
		
		mav.addObject( "dispatcher", dispatcher);
		
		return mav;
	}
	
	@RequestMapping( value="/bestrecommend", method = RequestMethod.POST)
	public ModelAndView bestRecommendHospitalEventView( HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_hospital_event_best_recommend");
		
		Function func = FunctionHandler.getFunctionByBeanId( "funcHospitalEventListOrderByRecommendCount");
		ContentsParameter param = (ContentsParameter)listController.buildParameter( request, func.getId());
		param.setFunctionId( func.getId());
		
		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
		
		// 각 이벤트의 병원정보(HospitalModel)을 가져온다.
		List datas = dispatcher.getDatas();
		Date now = new Date();
		int size = datas.size();
		for( int i=0; i < size; i++){
			HospitalEventModel model = (HospitalEventModel)datas.get( i);
			if( model.getStartDate().compareTo( now) <= 0 && model.getEndDate().compareTo( now) >= 0){
				model.addRenderedData( "progress", "I");
			}else if( model.getStartDate().compareTo( now) > 0){
				model.addRenderedData( "progress", "E");
			}
			HospitalModel hmodel = (HospitalModel)hospitalService.get( model.getHospitalId());

			//fileid 넣기
			if ( hmodel.getThumbFileId() == null || hmodel.getThumbFileId() == 0 ){
				List<SearchCondition> conditions = new ArrayList<SearchCondition>();
				conditions.add( new SearchCondition( "relationId", hmodel.getId()));
				conditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_HOSPITAL));
				
				FileModel fmodel = (FileModel)fileService.get(conditions);
				if( fmodel != null){ 
//					model.setFileId(fmodel.getId());
					hmodel.setThumbFileId(fmodel.getId());
				}
			}
			
			model.setHospitalModel( hmodel);
		}
		
		mav.addObject( "dispatcher", dispatcher);
		
		return mav;
	}
		
	@RequestMapping( value="/recommend/{hospitalEventId}", method = RequestMethod.GET)
	public ModelAndView recommendHospitalEvent( @PathVariable Integer hospitalEventId, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		JSONObject json = new JSONObject();
		if( hospitalEventId != null){
			if( SessionContext.getLoginInfo() != null){
				UserModel umodel = (UserModel)SessionContext.getUserModel();
				boolean isExist = hospitalEventUserActionService.isUserActionExist( hospitalEventId, PostingUserActionModel.ACTION_TYPE_RECOMMEND);

				if( isExist){
					json.put( "result", "false");
					json.put( "message", msgHandler.getMessage( "posting.msg.recommend_already"));
				}else{
					// 사용자의 추천 기록을 남김다.
					hospitalEventUserActionService.create( hospitalEventId, HospitalEventUserActionModel.ACTION_TYPE_RECOMMEND);
					
					// recommendCount 를 1 증가시킨다.
					HospitalEventModel pModel = (HospitalEventModel)hospitalEventService.get( hospitalEventId);
					pModel.setRecommendCount( pModel.getRecommendCount() != null ? pModel.getRecommendCount() + 1 : 1);
					hospitalEventService.update( pModel);
					
					json.put( "result", "true");
					json.put( "message", msgHandler.getMessage( "posting.msg.recommend_success"));
				}
			}else{
				json.put( "result", "false");
				json.put( "message", msgHandler.getMessage( "posting.msg.recommend_needlogin"));
			}
			
			mav.addObject( "result", json.toJSONString());
		}
		
		return mav;
	}

}
