package kr.co.zadusoft.contents.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/___/renew")
public class RenewIntroController{

	@Autowired
	private SqlSession sqlsession;
	
	@RequestMapping( value="/intro/ranking", method = RequestMethod.GET)
	public ModelAndView ranking(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/intro/rankmethod");
		
		return mv;
	}
	
	@RequestMapping( value="/intro/aboutus", method = RequestMethod.GET)
	public ModelAndView aboutus(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/intro/aboutus");
		
		return mv;
	}
}