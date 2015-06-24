/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.ZipcodeZibunModel;
import kr.co.zadusoft.contents.service.ZipcodeZibunService;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.web.dao.DAException;

@Controller
@RequestMapping( value="/___/zipcode")
public class ZipcodeZibunController {
	
	@Autowired
	private ZipcodeZibunService zipcodeZibunService;
	
	public ZipcodeZibunService getZipcodeZibunService() {
		return zipcodeZibunService;
	}

	public void setZipcodeZibunService(ZipcodeZibunService zipcodeZibunService) {
		this.zipcodeZibunService = zipcodeZibunService;
	}

	@RequestMapping( value="/json/{zipcodeId}", method = RequestMethod.GET)
	public ModelAndView getZipcodeZibunInfoJson( @PathVariable Integer zipcodeId, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");

		if( zipcodeId != null){
			ZipcodeZibunModel model = (ZipcodeZibunModel)zipcodeZibunService.get( zipcodeId);
			
			if( model != null){
				JSONObject json = new JSONObject();
				json.put( "postalCode", model.getPostalCode());
				json.put( "eupMyunDong", model.getEupMyunDong());
				json.put( "id", model.getId());
				json.put( "fullAddress", model.getFullAddress());		
				
				mav.addObject( "result", json.toJSONString());
			}
		}
		return mav;
	}
}
