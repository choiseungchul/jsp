/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.PostingCategoryModel;
import kr.co.zadusoft.contents.service.PostingCategoryService;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import dynamic.web.dao.DAException;
import dynamic.web.resource.Constants;

@Controller
@RequestMapping( value="/___/posting_category")
public class PostingCategoryController {
	
	@Autowired
	private PostingCategoryService postingCategoryService;
	
	public PostingCategoryService getPostingCategoryService() {
		return postingCategoryService;
	}

	public void setPostingCategoryService(
			PostingCategoryService postingCategoryService) {
		this.postingCategoryService = postingCategoryService;
	}

	/**
	 * 글 구분을 삭제한다.
	 * @param model
	 * @return
	 * @throws DAException
	 */
	@RequestMapping( value="/delete/{id}", method = RequestMethod.GET)
	public void deletePostingCategory( @PathVariable Integer id, HttpServletRequest request, HttpServletResponse response) throws DAException, ServletException, Exception{
		JSONObject json = new JSONObject();
		try{
			PostingCategoryModel pcModel = (PostingCategoryModel)postingCategoryService.get( id);
			pcModel.setIsDelete( Constants.YES);
			postingCategoryService.update( pcModel);
			
			json.put("result", "true");
		}catch( Exception e){
			json.put( "result", "false");
			json.put( "error_message", e.getMessage());
			
			throw e;
		}finally{
			PrintWriter writer = response.getWriter();
	        response.setContentType("text/html");
	        writer.write( json.toString());
	        writer.close();
		}
	}
}
