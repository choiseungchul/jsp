package kr.co.zadusoft.contents.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/___/admin")
public class RenewAdminRankingController{

	@Autowired
	private SqlSession sqlsession;
	
	@Resource(name = "txManager")
	protected DataSourceTransactionManager txManager;
	
	// 랭킹목록보기
	@RequestMapping( value="/ranking/list", method = RequestMethod.GET)
	public ModelAndView get_rank_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("admin/ranking/list");

		String pnum = request.getParameter("PN");
		String st_date = request.getParameter("SD");
		String ed_date = request.getParameter("ED");
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		
		if(st_date != null){
			param.put("st_date", st_date);			
			param.put("ed_date", ed_date);
			
			mv.addObject("SD", st_date);
			mv.addObject("ED", ed_date);
		}
		
		if(pnum == null){
			pnum = "1";
		}
		
		int listCount = 15;
		int p = (Integer.parseInt(pnum)-1) * listCount;
		
		
		param.put("start", p);
		param.put("end", listCount);
		
		List<HashMap<String, Object>> list = sqlsession.selectList("admin_ranking.get_list", param);
		int totalCount = sqlsession.selectOne("admin_ranking.get_count");
		
		mv.addObject("list", list);
		mv.addObject("listCount", listCount);
		mv.addObject("total" , totalCount);
		mv.addObject("p", Integer.parseInt(pnum));
		
		return mv;
	}
	
	// 랭킹목록보기
	@RequestMapping( value="/ranking/view/{rid}", method = RequestMethod.GET)
	public ModelAndView get_rank_data( @PathVariable Integer rid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("admin/ranking/view");

		String pnum = request.getParameter("PN");
		
		if(pnum == null){
			pnum = "1";
		}
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("rid", rid );
		
		List<HashMap<String, Object>> list = sqlsession.selectList("admin_ranking.get_rank", param);
		
		mv.addObject("list", list);		
		mv.addObject("p", Integer.parseInt(pnum));
		
		return mv;
	}
	
	
}
