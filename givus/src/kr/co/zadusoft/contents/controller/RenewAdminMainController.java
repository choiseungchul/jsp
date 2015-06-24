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
@RequestMapping(value="/___/admin")
public class RenewAdminMainController{

	@Autowired
	private SqlSession sqlsession;
	
	
	@RequestMapping( value="/main", method = RequestMethod.GET)
	public ModelAndView popular_newsbox(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("admin/main");

		return mv;
	}
	
}
