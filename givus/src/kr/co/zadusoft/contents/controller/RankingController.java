/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.CategoryModel;
import kr.co.zadusoft.contents.model.CodeModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.RankingModel;
import kr.co.zadusoft.contents.service.CodeService;
import kr.co.zadusoft.contents.service.HospitalService;
import kr.co.zadusoft.contents.service.RankingService;
import kr.co.zadusoft.givus.cron.RankingCron;
import kr.co.zadusoft.givus.util.GivusConstants;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.ibatis.util.EncodingUtil;
import dynamic.ibatis.util.Parameter;
import dynamic.ibatis.util.SearchCondition;
import dynamic.util.DateUtil;
import dynamic.util.HttpServiceContext;
import dynamic.util.StringUtil;
import dynamic.web.controller.ListController;
import dynamic.web.dao.DAException;
import dynamic.web.func.Function;
import dynamic.web.func.FunctionHandler;
import dynamic.web.util.MessageHandler;
import dynamic.web.util.RenderUtil;
import dynamic.web.view.Dispatcher;

@Controller
@RequestMapping( value="/___/ranking")
public class RankingController {

	@Autowired
	private RankingCron rankingCron;
	
	@Autowired
	private MessageHandler msgHandler;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private RankingService rankingService;
	
	@Autowired
	private HospitalService hospitalService;
	
	@Autowired
	private ListController listController;
	
	public RankingCron getRankingCron() {
		return rankingCron;
	}

	public void setRankingCron(RankingCron rankingCron) {
		this.rankingCron = rankingCron;
	}
	
	public MessageHandler getMsgHandler() {
		return msgHandler;
	}

	public void setMsgHandler(MessageHandler msgHandler) {
		this.msgHandler = msgHandler;
	}

	public CodeService getCodeService() {
		return codeService;
	}

	public void setCodeService(CodeService codeService) {
		this.codeService = codeService;
	}

	public RankingService getRankingService() {
		return rankingService;
	}

	public void setRankingService(RankingService rankingService) {
		this.rankingService = rankingService;
	}
	
	public HospitalService getHospitalService() {
		return hospitalService;
	}

	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}
	
	public ListController getListController() {
		return listController;
	}

	public void setListController(ListController listController) {
		this.listController = listController;
	}

	/**
	 * 랭킹을 생성한다.
	 * @param model
	 * @return
	 * @throws DAException
	 */
//	@RequestMapping( value="/gen/{rankingType}", method = RequestMethod.GET)
//	public ModelAndView generateRankings( @PathVariable String rankingType) throws DAException, ServletException, Exception{
//		ModelAndView mav = new ModelAndView( "dynamic/web/json");
//		
//		Date today = new Date();
//		Calendar cal = getCalendarDate( today);
//
//		Date startDate = getFirstDayOfWeek( cal);
//		Date endDate = getLastDayOfWeek( cal);
//		
//		if( RankingModel.RANKING_TYPE_TOP_100.equals( rankingType)){
//			rankingCron.generateTop100Ranking( startDate, endDate);
//		}else if( RankingModel.RANKING_TYPE_MAJOR_CITY_10.equals( rankingType)){
//			List<CodeModel> codeModels = (List<CodeModel>)codeService.search( new SearchCondition( "category", GivusConstants.CODE_CATEGORY_LOCATION));
//			for( CodeModel codeModel : codeModels){
//				//if( !"A".equals(codeModel.getCode())){ // 서울은 제외한다.
//				if( !GivusConstants.CODE_CATEGORY_LOCATION_SEOUL.equals(codeModel.getCode())){ // 서울은 제외한다.
//					
//					rankingCron.generateTop10RankingByLocationCode( codeModel.getCode(), startDate, endDate);
//				}
//			}
//		}else if( RankingModel.RANKING_TYPE_SEOUL_50.equals( rankingType)){
//			rankingCron.generateSeoulTop50( startDate, endDate);
//		}else if ( RankingModel.RANKING_TYPE_PART_10.equals( rankingType)){
//			List<CodeModel> codeModels = (List<CodeModel>)codeService.search( new SearchCondition( "category", GivusConstants.CODE_CATEGORY_PARTIAL_RANKING));
//			for( CodeModel codeModel : codeModels){
//				rankingCron.generateTop10RankingByPartCode( codeModel.getCode(), startDate, endDate);
//			}
//		}
//		
//		JSONObject json = new JSONObject();
//		json.put( "result", "true");
//		json.put( "message", msgHandler.getMessage( "category.msg.success"));
//		
//		mav.addObject( "result", json.toJSONString());
//		
//		return mav;
//	}
//	
	/**
	 * 최근 랭킹을 json으로 가져온다.
	 * @param model
	 * @return
	 * @throws DAException
	 */
	@RequestMapping( value="/getRecent/{rankingType}", method = RequestMethod.POST)
	public ModelAndView getRecentRankings( @PathVariable String rankingType, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		return getRecentRankings( rankingType, null, request, response);
	}
	
	/**
	 * 최근 랭킹을 json으로 가져온다.
	 * @param model
	 * @return
	 * @throws DAException
	 */
	@RequestMapping( value="/getRecent/{rankingType}/{rankingLocationCode}", method = RequestMethod.POST)
	public ModelAndView getRecentRankings( @PathVariable String rankingType,  @PathVariable String rankingLocationCode, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		return getRecentRankings( rankingType, rankingLocationCode, null, request, response);
	}
	
	/**
	 * 최근 랭킹을 json으로 가져온다.
	 * @param model
	 * @return
	 * @throws DAException
	 */
	@RequestMapping( value="/getRecent/{rankingType}/{rankingLocationCode}/{rankingPartCode}", method = RequestMethod.POST)
	public ModelAndView getRecentRankings( @PathVariable String rankingType, @PathVariable String rankingLocationCode,  @PathVariable String rankingPartCode, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "givus/givus_ranking_portlet_list");
		
		RankingModel rankingModel = rankingService.getRecentRanking( rankingType, rankingLocationCode, rankingPartCode);
		
		Function func = FunctionHandler.getFunctionByBeanId( "funcRankingDataPortletList");
		Parameter param = listController.buildParameter( request, func.getId());
		param.setFunctionId( func.getId());
		param.addCondition( new SearchCondition("rankingId", rankingModel.getId()));
		
		Dispatcher dispatcher = listController.getDispatcher( request, response, param);
		
		mav.addObject( "dispatcher", dispatcher);
		mav.addObject( "rankingModel", rankingModel);
		
		return mav;
	}
	
	public Date getFirstDayOfWeek( Calendar cal){
		int day = cal.get(Calendar.DAY_OF_WEEK);
		cal.add( Calendar.DATE, -(day-1));
		
		return cal.getTime();
	}
	
	public Date getLastDayOfWeek( Calendar cal){
		int day = cal.get(Calendar.DAY_OF_WEEK);
		cal.add( Calendar.DATE, 7-day);

		return cal.getTime();
	}
	
	public Calendar getCalendarDate( Date date){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		
		return cal;
	}
}
