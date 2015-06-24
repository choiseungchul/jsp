/**
 * Copyright (c) 2013, ZADUSOFT CO. LTD,.
 * All rights reserved.
 */
package kr.co.zadusoft.contents.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.BoardModel;
import kr.co.zadusoft.contents.model.PostingCategoryModel;
import kr.co.zadusoft.contents.model.PostingModel;
import kr.co.zadusoft.contents.model.PostingUserActionModel;
import kr.co.zadusoft.contents.service.BoardService;
import kr.co.zadusoft.contents.service.PostingCategoryService;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.ibatis.util.SearchCondition;
import dynamic.web.dao.DAException;
import dynamic.web.resource.Constants;

@Controller
@RequestMapping( value="/___/board")
public class BoardController {
	
	@Autowired
	private PostingCategoryService postingCategoryService;
	
	@Autowired
	private BoardService boardService;
	
	public PostingCategoryService getPostingCategoryService() {
		return postingCategoryService;
	}

	public void setPostingCategoryService(
			PostingCategoryService postingCategoryService) {
		this.postingCategoryService = postingCategoryService;
	}
	
	public BoardService getBoardService() {
		return boardService;
	}

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	@RequestMapping( value="/pc/{boardId}", method = RequestMethod.GET)
	public ModelAndView getPostingCategory( @PathVariable Integer boardId) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		JSONArray jsonArray = new JSONArray();
		
		List<PostingCategoryModel> pcModels = postingCategoryService.getByBoardId( boardId);
		for( PostingCategoryModel pcModel : pcModels){
			jsonArray.add( pcModel.getJSONObject());
		}
		
		mav.addObject( "result", jsonArray.toJSONString());
		
		return mav;
	}
	
	@RequestMapping( value="/getwithpc/{boardId}", method = RequestMethod.GET)
	public ModelAndView getBoardWithPostingCategory( @PathVariable Integer boardId, HttpServletResponse response) throws DAException, ServletException, Exception{
		ModelAndView mav = new ModelAndView( "dynamic/web/json");
		
		// Board
		BoardModel model = (BoardModel)boardService.get( boardId);
		
		JSONObject jsonBoard = model.getJSONObject();
		
		// PostingCategory
		JSONArray jsonArray = new JSONArray();
		List<PostingCategoryModel> pcModels = postingCategoryService.getByBoardId( boardId);
		for( PostingCategoryModel pcModel : pcModels){
			jsonArray.add( pcModel.getJSONObject());
		}
		
		jsonBoard.put( "postingCategory", jsonArray);
		
		mav.addObject( "result", jsonBoard.toJSONString());
		
		return mav;
	}
	
}
