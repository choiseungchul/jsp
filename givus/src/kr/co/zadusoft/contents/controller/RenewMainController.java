package kr.co.zadusoft.contents.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import dynamic.web.util.MessageHandler;

@Controller
@RequestMapping(value="/___/renew")
public class RenewMainController{

	@Autowired
	private SqlSession sqlsession;
	
	@RequestMapping( value="/main", method = RequestMethod.GET)
	public ModelAndView viewMainPage( HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String type = request.getParameter("type");
		String code = request.getParameter("code");
		
		
		
		
		
		ModelAndView mv = new ModelAndView("/givus_v2/givus_main");
		
		List<HashMap<String, Object>> ranking_list = new ArrayList<HashMap<String,Object>>();
		
		if(type != null){	
			if(type.equals("LC")){
				HashMap<String, Object> rk_param = new HashMap<String, Object>();
				rk_param.put("start",0);
				rk_param.put("limit", 10);
				
				rk_param.put("location", code);
				ranking_list  = sqlsession.selectList("renew_ranking.top50byLoc", rk_param);
			}else if(type.equals("PT")){
				HashMap<String, Object> rk_param = new HashMap<String, Object>();
				rk_param.put("start",0);
				rk_param.put("limit", 10);
				rk_param.put("point", "h."+code+"Point");			
				ranking_list = sqlsession.selectList("renew_ranking.top50bySurg", rk_param);
			}
		}else{
			HashMap<String, Integer> param = new HashMap<String, Integer>();
			param.put("start",0);
			param.put("limit", 100);
			
			ranking_list = sqlsession.selectList("renew_ranking.top50", param);
//
//			Date today = new Date();
//			int day = today.getDay();
//			
//			int flag = day % 10;
//			
//			ranking_list = ranking_list.subList((flag*10)-1, ((flag+1) * 10-1));
		}
		
		mv.addObject("top50list", ranking_list);
		
		List<HashMap<String, Object>> updated = sqlsession.selectList("renew_ranking.updatedHos");
		
		for(int i = 0 ; i < updated.size();i++){
			HashMap<String, Object> data = updated.get(i);
			String updateDate = GivusUtil.parseRelativeDate((Date) data.get("updateDate"));
			
			data.put("updateDate", updateDate);
			
			updated.set(i, data);
		}
		
		mv.addObject("updated" ,updated);
	
		List<HashMap<String, Object>> recent = sqlsession.selectList("renew_ranking.recentHos");
		
		mv.addObject("recent" ,recent);
		
		int total = sqlsession.selectOne("renew_ranking.get_hospitals_by_rank_count");
		mv.addObject("total", total);
		
		Date date = sqlsession.selectOne("renew_ranking.get_recent_updated_time");
		
		mv.addObject("updateDate", GivusUtil.parseRelativeDate(date));
		
		mv.addObject("type" ,type);
		mv.addObject("code", code);
		
		
		return mv;
	}
	
	@RequestMapping( value="/rank100", method = RequestMethod.GET)
	public ModelAndView viewRank100Page( HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("/givus_v2/rank100");

		String type = request.getParameter("type");
		String code = request.getParameter("code");
		
		List<HashMap<String, Object>> ranking_list = new ArrayList<HashMap<String,Object>>();
		
		if(type != null){	
			if(type.equals("LC")){
				HashMap<String, Object> rk_param = new HashMap<String, Object>();
				rk_param.put("start",0);
				rk_param.put("limit", 100);
				
				rk_param.put("location", code);
				ranking_list  = sqlsession.selectList("renew_ranking.top50byLoc", rk_param);
			}else if(type.equals("PT")){
				HashMap<String, Object> rk_param = new HashMap<String, Object>();
				rk_param.put("start",0);
				rk_param.put("limit", 100);
				rk_param.put("point", "h."+code+"Point");			
				ranking_list = sqlsession.selectList("renew_ranking.top50bySurg", rk_param);
			}
		}else{
			HashMap<String, Integer> param = new HashMap<String, Integer>();
			param.put("start",0);
			param.put("limit", 100);
			
			ranking_list = sqlsession.selectList("renew_ranking.top50", param);
		}
		
		mv.addObject("top50list", ranking_list);
		
		mv.addObject("type" ,type);
		mv.addObject("code", code);
		
		return mv;
	}
	
	@RequestMapping( value="/hospital/list", method = RequestMethod.GET)
	public ModelAndView viewHospitalList( HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String pnum = request.getParameter("PN");
		
		if(pnum == null) pnum = "0";
		
		ModelAndView mv = new ModelAndView("/givus_v2/hospital/list");
		
		HashMap<String, Integer> param = new HashMap<String, Integer>();
		param.put("start", Integer.parseInt(pnum) * 10);
		param.put("end", 10);
		
		List<HashMap<String, Object>> hospitals = sqlsession.selectList("renew_ranking.get_hospitals_by_rank", param);
		int total = sqlsession.selectOne("renew_ranking.get_hospitals_by_rank_count");
		
		StringBuilder sb = new StringBuilder();
		for(int i = 0 ; i < hospitals.size() ;i++){			
			sb.append(hospitals.get(i).get("id") + ",");			
		}
		
		if(sb.length() > 1){
			String d = sb.substring(0, sb.length() -1);
			
			HashMap<String, Object> params = new HashMap<String, Object>();
			params.put("ids", d);
			List<HashMap<String, Object>> thumbs = sqlsession.selectList("renew_ranking.get_hospital_thumbs", params);
			
			for(int k = 0 ; k < thumbs.size(); k++){				
				for(int j = 0 ; j < hospitals.size(); j++){
					HashMap<String, Object> item = hospitals.get(j);					
					if(item.get("id").equals(thumbs.get(k).get("relationId"))){
						item.put("thumb", thumbs.get(k).get("id"));
						break;
					}
				}				
			}			
		}
		
		mv.addObject("hospital100", hospitals);
		mv.addObject("p", Integer.parseInt(pnum));
		mv.addObject("total", total);
		
		
		
		return mv;
	}
	
	@RequestMapping( value="/tile/rankbox", method = RequestMethod.GET)
	public ModelAndView getRankBox(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("/givus_v2/inc/rankbox");
		
		String ymw =  GivusUtil.getCurrWeek();
		
		mv.addObject("ymw", ymw);
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("start",0);
		param.put("limit", 100);
		
		// 전체 top100
		List<HashMap<String, Object>> top100 = sqlsession.selectList("renew_ranking.top50_rankbox", param);
		mv.addObject("top100", top100);
		
		//서울 top50
		HashMap<String, Object> param2 = new HashMap<String, Object>();

		param2.put("location", "AA");
		param2.put("start",0);
		param2.put("limit", 50);
		List<HashMap<String, Object>> s_top50 = sqlsession.selectList("renew_ranking.top50byLoc_rankbox", param2);
		mv.addObject("s_top50", s_top50);
		
//		
		// 광역시별 50개 	
		HashMap<String, Object> param3 = new HashMap<String, Object>();
		param3.put("start",0);
		param3.put("limit", 50);		
		param3.put("location", "B");
		List<HashMap<String, Object>> B_top50 = sqlsession.selectList("renew_ranking.top50byLoc_rankbox", param3);
		param3.put("location", "C");
		List<HashMap<String, Object>> C_top50 = sqlsession.selectList("renew_ranking.top50byLoc_rankbox", param3);
		param3.put("location", "D");
		List<HashMap<String, Object>> D_top50 = sqlsession.selectList("renew_ranking.top50byLoc_rankbox", param3);
		param3.put("location", "E");
		List<HashMap<String, Object>> E_top50 = sqlsession.selectList("renew_ranking.top50byLoc_rankbox", param3);
		param3.put("location", "F");
		List<HashMap<String, Object>> F_top50 = sqlsession.selectList("renew_ranking.top50byLoc_rankbox", param3);
		param3.put("location", "G");
		List<HashMap<String, Object>> G_top50 = sqlsession.selectList("renew_ranking.top50byLoc_rankbox", param3);
		mv.addObject("B_top50", B_top50);
		mv.addObject("C_top50", C_top50);
		mv.addObject("D_top50", D_top50);
		mv.addObject("E_top50", E_top50);
		mv.addObject("F_top50", F_top50);
		mv.addObject("G_top50", G_top50);
//		
//		// 부위별 10개
		HashMap<String, Object> param4 = new HashMap<String, Object>();
		param4.put("start",0);
		param4.put("limit", 10);
		param4.put("point", "h.eyePoint");
		List<HashMap<String, Object>> Surg_eye = sqlsession.selectList("renew_ranking.top50bySurg", param4);
		param4.put("point", "h.nosePoint");
		List<HashMap<String, Object>> Surg_nose = sqlsession.selectList("renew_ranking.top50bySurg", param4);
		param4.put("point", "h.facePoint");
		List<HashMap<String, Object>> Surg_face = sqlsession.selectList("renew_ranking.top50bySurg", param4);
		param4.put("point", "h.breastPoint");
		List<HashMap<String, Object>> Surg_breast = sqlsession.selectList("renew_ranking.top50bySurg", param4);
		param4.put("point", "h.bodyPoint");
		List<HashMap<String, Object>> Surg_body = sqlsession.selectList("renew_ranking.top50bySurg", param4);
		param4.put("point", "h.petitPoint");
		List<HashMap<String, Object>> Surg_petit = sqlsession.selectList("renew_ranking.top50bySurg", param4);
		
		mv.addObject("surg1", Surg_eye);
		mv.addObject("surg2", Surg_nose);
		mv.addObject("surg3", Surg_face);
		mv.addObject("surg4", Surg_breast);
		mv.addObject("surg5", Surg_body);
		mv.addObject("surg6", Surg_petit);
		
		return mv;
	}

	//input_hospital_connect
	@RequestMapping( value="/arr/test1", method = RequestMethod.GET)
	public ModelAndView testbed(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		for(int i = 1 ; i  <= 300; i++){
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("hid", i);
			
			try{
				sqlsession.insert("renew_ranking.input_hospital_connect", param);
			}catch(Exception e){
				System.out.println(e.toString());
			}			
		}
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
	
}
