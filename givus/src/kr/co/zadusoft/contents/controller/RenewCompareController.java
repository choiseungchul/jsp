package kr.co.zadusoft.contents.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.contents.util.StringUtil;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.web.util.SessionContext;

@Controller
@RequestMapping(value="/___/renew")
public class RenewCompareController{

	@Autowired
	private SqlSession sqlsession;
	
	@RequestMapping( value="/compare", method = RequestMethod.GET)
	public ModelAndView compare(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("givus_v2/compare/prices");
		
		//지역목록 get_loc_codes
		List<HashMap<String, Object>> codes = sqlsession.selectList("renew_compare.get_loc_codes");
		mv.addObject("codes", codes);
		
		// 평균 스텟 구하기
		HashMap<String, Object> statCount = sqlsession.selectOne("renew_compare.get_avg_counts");
		mv.addObject("statCount", statCount);
		
		// 평균 수술 및 등급 구하기
		int avgGrade = 0;
		List<HashMap<String, String>> grades = sqlsession.selectList("renew_compare.get_grades");
		for(int i = 0 ; i < grades.size(); i++){
			HashMap<String, String> data = grades.get(i);
			String gradeStr = data.get("grade");
			
			int cnt = StringUtil.countOccurrences(gradeStr, 'A');
			
			if(cnt != 1){
				avgGrade += (cnt * 3) - 1;
			}else{
				avgGrade += 2;
			}
			
			String lastStr = gradeStr.substring( gradeStr.length() - 1 );
			
			if(lastStr.equals("+")){
				avgGrade += 1;
			}else if(lastStr.equals("-")){
				avgGrade -= 1;
			}			
		}// for
		
		int avg = avgGrade / grades.size();
		
		mv.addObject("avgGrade", avg);
		
		// 가장많이 하는 수술 top
		HashMap<String, String> mostSurg = sqlsession.selectOne("renew_compare.get_most_surg_count");
		
		mv.addObject("mostSurg", mostSurg);
		// 병원갯수
		mv.addObject("hCount", grades.size());
		
		// 수술비용 평균가 get_avg_prices
		List<HashMap<String, Object>> prices = sqlsession.selectList("renew_compare.get_avg_prices");
		mv.addObject("prices", prices);
		
		// 병원이름
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("loc", "ALL");		
		List<HashMap<String, String>> hos_names = sqlsession.selectList("renew_compare.get_hospital_names", param);
		mv.addObject("hos_names", hos_names);
		
		return mv;
	}

	@RequestMapping( value="/compare/hinfo/{hid}", method = RequestMethod.GET)
	public ModelAndView get_hospital(@PathVariable Integer hid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		if(um!=null){
			if(um.getEmail()!=null){
				//병원정보 구하기
				HashMap<String, Integer> param = new HashMap<String, Integer>();
				param.put("hid", hid);
				
				HashMap<String, Object> hos = sqlsession.selectOne("renew_compare.get_hospital", param);
				HashMap<String, Object> thumb = sqlsession.selectOne("renew_compare.get_hospital_thumb", param);
				
				json.put("hos", hos);
				json.put("thumb", thumb);
				// 가격 구하기
				List<HashMap<String, Object>> prices = sqlsession.selectList("renew_compare.get_hospital_price", param);
				json.put("price", prices);
				json.put("code", 0);
			}else{
				json.put("code", -1001);				
			}
		}
		// 
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
	@RequestMapping( value="/compare/hname/{code}", method = RequestMethod.GET)
	public ModelAndView get_hospital_names(@PathVariable String code, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		// 병원정보 구하기
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("loc", code);		
		List<HashMap<String, String>> hos_names = sqlsession.selectList("renew_compare.get_hospital_names", param);
		
		JSONObject json = new JSONObject();
		json.put("hos_names", hos_names);
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
}
