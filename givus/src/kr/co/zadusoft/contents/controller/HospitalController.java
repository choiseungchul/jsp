/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.CategoryModel;
import kr.co.zadusoft.contents.model.FileModel;
import kr.co.zadusoft.contents.model.HospitalModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.PostingUserActionModel;
import kr.co.zadusoft.contents.service.FileService;
import kr.co.zadusoft.contents.service.HospitalService;
import kr.co.zadusoft.contents.service.OperationPriceService;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.ibatis.util.EncodingUtil;
import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;
import dynamic.web.func.Function;
import dynamic.web.func.FunctionHandler;
import dynamic.web.model.ITreeNode;
import dynamic.web.util.RenderUtil;
import dynamic.web.view.RenderContext;
import dynamic.web.view.RenderText;

@Controller
@RequestMapping( value="/___/hospital")
public class HospitalController {
	
	@Autowired
	private HospitalService hospitalService;
	
	@Autowired
	private OperationPriceService operationPriceService;
	
	@Autowired
	private FileService fileService;
	
	public HospitalService getHospitalService() {
		return hospitalService;
	}

	public void setHospitalService(HospitalService hospitalService) {
		this.hospitalService = hospitalService;
	}
	
	public OperationPriceService getOperationPriceService() {
		return operationPriceService;
	}

	public void setOperationPriceService(OperationPriceService operationPriceService) {
		this.operationPriceService = operationPriceService;
	}
	
	public FileService getFileService() {
		return fileService;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	@RequestMapping( value="/json/{hospitalId}", method = RequestMethod.GET)
	public ModelAndView getHospitalInfoJson( @PathVariable Integer hospitalId, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");

		if( hospitalId != null){
			HospitalModel model = (HospitalModel)hospitalService.get( hospitalId);
			List<SearchCondition> conditions = new ArrayList<SearchCondition>();
			conditions.add( new SearchCondition( "relationId", model.getId()));
			conditions.add( new SearchCondition( "relationType", FileModel.RELATIONTYPE_HOSPITAL)); //"hospital"
			
			FileModel fmodel = (FileModel)fileService.get(conditions);
			if( fmodel != null){ 
				model.setThumbFileId( fmodel.getId());
			}
			
			if( model != null){	
				JSONObject json = new JSONObject();
				json.put( "name", model.getName());
				json.put( "address", model.getAddress());
				json.put( "tel", model.getTel());
				json.put( "photo", model.getThumbFileId());
				json.put( "comment", model.getRecommendNote());
				json.put( "ranking", model.getRanking());
				json.put( "grade", model.getGrade());
				json.put( "mostOperation1", model.getMostOperation1());
				json.put( "mostOperation2", model.getMostOperation2());
				json.put( "counselCount", model.getCounselCount());
				json.put( "specialistCount", model.getSpecialistCount());
				json.put( "anestheticCount", model.getAnestheticCount());
				json.put( "annualOperationCount", model.getAnnualOperationCount());
				
				CategoryModel rootCategory = operationPriceService.getOperationPriceCategory( hospitalId, "#,000원");
				
				JSONObject prices = new JSONObject();
				for( ITreeNode node : rootCategory.getChildren()){
					CategoryModel cmodel1 = (CategoryModel)node;
					JSONObject price = new JSONObject();
					for( ITreeNode node2: node.getChildren()){
						CategoryModel cmodel2 = (CategoryModel)node2;
						String szPrice = cmodel2.getRenderedData().get("price") != null ? cmodel2.getRenderedData().get("price") : "";
						price.put( cmodel2.getName(), szPrice);
					}
					
					prices.put( String.valueOf( cmodel1.getId()), price);
				}
				json.put( "price", prices);
				
				mav.addObject( "result", json.toJSONString());
			}
		}
		
		return mav;
	}
	
	@RequestMapping( value="/realranking", method = RequestMethod.GET)
	public ModelAndView getHospitalRealRankings( HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		List<HospitalModel> models = (List<HospitalModel>)hospitalService.search( 0, 10, null, "totalPoint DESC");
		if( models != null){	
			JSONArray jsonArr = new JSONArray();
			
			int size = models.size();
			for( int i=0; i < size; i++){
				HospitalModel model = models.get(i);
				JSONObject json = new JSONObject();
				json.put( "ranking", i+1);
				json.put( "name", model.getName());
				json.put( "hospitalId", model.getId());

				
				jsonArr.add( json);
			}
			
			mav.addObject( "result", jsonArr.toJSONString());
		}
		
		return mav;
	}
}
