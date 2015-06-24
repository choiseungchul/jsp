package kr.co.zadusoft.contents.controller;

import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.util.RelativeDateFormat;
import kr.co.zadusoft.givus.util.GivusUtil;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.util.DateUtil;
import dynamic.web.util.SessionContext;
import dynamic.web.util.SessionContext.LoginInfo;

@Controller
@RequestMapping(value="/___/renew")
public class RenewNewsController{

	@Autowired
	private SqlSession sqlsession;
	
	@RequestMapping( value="/news/list", method = RequestMethod.GET)
	public ModelAndView newslist(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/news/list");

		String start = request.getParameter("PN");
		String query = request.getParameter("QR") == null ? "" : request.getParameter("QR");
		String sort = request.getParameter("ST");
		
		if(start == null) start = "0";
		if(sort == null ) sort = "createDate";
		else{
			if(sort.equals("v")){
				sort = "viewCount";
			}else{
				sort = "createDate";
			}
		}
		
		query = URLDecoder.decode(query, "UTF-8");
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("start", Integer.parseInt(start) * 30);
		param.put("end", 30);		
		param.put("query", query);
		param.put("sort", sort);
		
		List<HashMap<String, Object>> newsList = sqlsession.selectList("renew_news.get_news_all" , param);
		
		int total = 0;
		total = (Integer)sqlsession.selectOne("renew_news.get_news_all_count", param);		
		

		mv.addObject("newsList", newsList);
		mv.addObject("p", Integer.parseInt(start));
		mv.addObject("total", total);
		mv.addObject("QR", query);
		
		return mv;
	}
	
	// 조회수 증가
	@RequestMapping( value="/news/addcnt/{bid}", method = RequestMethod.GET)
	public ModelAndView viewMainPage(@PathVariable Integer bid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		int rs = sqlsession.update("renew_news.view_cnt_add", bid);
		json.put("code", rs);
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}	
	
	
	
	@RequestMapping( value="/tile/newsbox", method = RequestMethod.GET)
	public ModelAndView popular_newsbox(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/inc/newsbox");

		List<HashMap<String, Object>> newsList = sqlsession.selectList("renew_news.get_news_box");
		
		mv.addObject("newsList", newsList);
		
		return mv;
	}
	
}
