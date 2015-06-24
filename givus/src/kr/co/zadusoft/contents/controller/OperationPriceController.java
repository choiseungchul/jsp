/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.OperationPriceModel;
import kr.co.zadusoft.contents.service.OperationPriceService;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dynamic.web.dao.DAException;
import dynamic.web.util.MessageHandler;

@Controller
@RequestMapping( value="/___/operationprice")
public class OperationPriceController {
	
	@Autowired
	private MessageHandler msgHandler;
	
	@Autowired
	private OperationPriceService operationPriceService;
	
	public MessageHandler getMsgHandler() {
		return msgHandler;
	}

	public void setMsgHandler(MessageHandler msgHandler) {
		this.msgHandler = msgHandler;
	}
	
	public OperationPriceService getOperationPriceService() {
		return operationPriceService;
	}

	public void setOperationPriceService(OperationPriceService operationPriceService) {
		this.operationPriceService = operationPriceService;
	}

	@RequestMapping( value="/save/{hospitalId}", method = RequestMethod.POST)
	public ModelAndView saveOperationPrice( @PathVariable Integer hospitalId, @RequestParam("infos") String infos, HttpServletRequest request, HttpServletResponse response) throws DAException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		JSONObject jsonResult = new JSONObject();
		try{
			JSONParser parser = new JSONParser();
			JSONArray jsonArray = (JSONArray)parser.parse( infos);
			
			for( int i=0; i<jsonArray.size(); i++){
				JSONObject jsonObj = (JSONObject)jsonArray.get( i);
				int id = Integer.parseInt( (String)jsonObj.get("id"));
				int price = Integer.parseInt( (String)jsonObj.get("price"));
				OperationPriceModel model = new OperationPriceModel();
				model.setHospitalId( hospitalId);
				model.setCategoryId( id);
				model.setPrice( price);
				
				operationPriceService.create( model);
			}
			
			jsonResult.put( "result", "true");
			jsonResult.put( "message", msgHandler.getMessage( "category.msg.success"));
		}catch ( org.json.simple.parser.ParseException e) {
			e.printStackTrace();
			jsonResult.put( "result", "false");
			jsonResult.put( "message", e.getMessage());
		}
		
		mav.addObject( "result", jsonResult.toJSONString());
		
		return mav;
	}
}
