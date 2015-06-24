package kr.co.zadusoft.contents.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.web.util.MessageHandler;

@Controller
@RequestMapping(value="/___/admin")
public class RenewAdminHospitalController{

	@Autowired
	private SqlSession sqlsession;
	
	@Resource(name = "txManager")
	protected DataSourceTransactionManager txManager;
	
	// 가격정보 보기
	@RequestMapping( value="/hospital/prices/{hid}", method = RequestMethod.GET)
	public ModelAndView prices(@PathVariable Integer hid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("admin/hospital/prices");

		String pnum = request.getParameter("pnum");
		
		if(pnum == null){
			pnum = "1";
		}
		
		List<HashMap<String, Object>> surg  = sqlsession.selectList("admin_hospital.get_surg");
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("hid", hid);
		List<HashMap<String, Object>> list = sqlsession.selectList("admin_hospital.get_prices", param);
		
		for(int i = 0 ; i < list.size(); i++){
			HashMap<String, Object> list_data = list.get(i);
			
			String oid = list_data.get("operationId").toString();
			String price = list_data.get("price").toString();
			String update = list_data.get("updateDate") == null ? "" : list_data.get("updateDate").toString();
			
			for(int k = 0 ; k < surg.size(); k++){
				HashMap<String, Object> surg_data = surg.get(k);
				String opId = surg_data.get("id").toString();
				
				if(oid.equals(opId)){
					surg_data.put("updateDate", update);
					surg_data.put("price", price);
					surg.set(k, surg_data);
//					break;
				}				
			}
		}
		
		mv.addObject("list", surg);
		mv.addObject("hid", hid);
		
		mv.addObject("pnum", Integer.parseInt(pnum));
		
		return mv;
	}
	
	// 병원목록보기
	@RequestMapping( value="/hospital/list", method = RequestMethod.GET)
	public ModelAndView hos_list(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("admin/hospital/list");

		String pnum = request.getParameter("PN");
		String srch_code = request.getParameter("SC");
		String srch_text = request.getParameter("ST");
		
		String type = request.getParameter("type");
		
		if(type == null) type = "A";
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		
		if(srch_code != null){
			param.put("srch_code", srch_code);			
			param.put("srch_text", srch_text);
			
			mv.addObject("SC", srch_code);
			mv.addObject("ST", srch_text);
		}
		
		if(pnum == null){
			pnum = "1";
		}
		
		int listCount = 15;
		int p = (Integer.parseInt(pnum)-1) * listCount;
		
		
		param.put("start", p);
		param.put("end", listCount);
		param.put("type", type);
		
		List<HashMap<String, Object>> list = sqlsession.selectList("admin_hospital.get_list", param);
		int totalCount = sqlsession.selectOne("admin_hospital.get_count", param);
		
		System.out.println("list size = " +totalCount);
		
		mv.addObject("list", list);
		mv.addObject("listCount", listCount);
		mv.addObject("total" , totalCount);
		mv.addObject("type", type);
		mv.addObject("p", Integer.parseInt(pnum));
		
		return mv;
	}
	
	@RequestMapping(value="/hospital/mod_price", method=RequestMethod.POST)
	public String ajax_price(HttpServletRequest request, HttpServletResponse response) throws Exception{
	
		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);		
		TransactionStatus status = txManager.getTransaction(def);
		
		String hid = request.getParameter("hid");
		
		try {			
		
			String[] price = request.getParameterValues("price");
			String[] operId = request.getParameterValues("operId");
			String[] oName = request.getParameterValues("oname");
			
			for(int i = 0 ; i < price.length; i++){
				
				if(!price[i].equals("")){
					HashMap<String, Object > param = new HashMap<>();
					param.put("price", Integer.parseInt(price[i]));
					param.put("oid", Integer.parseInt(operId[i]));
					param.put("hid", Integer.parseInt(hid));
					param.put("oname", oName[i]);
					
					sqlsession.update("admin_hospital.set_price", param);	
					
//					System.out.println(param.toString());
				}else{
					HashMap<String, Object > param = new HashMap<>();
					param.put("price", 0);
					param.put("oid", Integer.parseInt(operId[i]));
					param.put("hid", Integer.parseInt(hid));
					param.put("oname", oName[i]);
					
					sqlsession.update("admin_hospital.set_price", param);
				}
			}
		
			txManager.commit(status);
		
		}catch(Exception e){			
			txManager.rollback(status);
			
			System.out.println(e.toString());
		}
		
		return "redirect:/___/admin/hospital/prices/" + hid;
	}
	
	//병원 수정하기
	@RequestMapping( value="/hospital/mod/{hid}", method = RequestMethod.GET)
	public ModelAndView getview(@PathVariable Integer hid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("admin/hospital/mod");
		
		String pnum = request.getParameter("pnum");
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("hid", hid);
		
		HashMap<String, Object> hospital = sqlsession.selectOne("admin_hospital.get_one", param);
		
		List<HashMap<String, Object>> location = sqlsession.selectList("admin_hospital.get_location", param);
		
		// 썸네일조회 get_hospital_thumb
		HashMap<String, Object> thumb_p = new HashMap<String, Object>();
		thumb_p.put("hid", hid);
		HashMap<String, Object> thumbId = sqlsession.selectOne("renew_hospital.get_hospital_thumb",thumb_p);
		if(thumbId != null){
			if(thumbId.get("id") != null)
				hospital.put("fid", thumbId.get("id"));
		}
		
		// 썸네일 5개 조회
		List<HashMap<String, Object>> thumbList = sqlsession.selectList("renew_hospital.get_hospital_thumb5", thumb_p);
		mv.addObject("thumb5", thumbList);
		
		mv.addObject("hospital", hospital);		
		mv.addObject("location", location);
		mv.addObject("pnum", pnum);
		
		return mv;
	}
	
	// 병원 정보 입력 
	@RequestMapping( value="/hospital/modproc", method = RequestMethod.POST)
	public ModelAndView mod_hospital(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();

		String hid = request.getParameter("hid");
		
		String name = request.getParameter("name");
		String homepage = request.getParameter("homepage");
		String busyId = request.getParameter("busy_id_num");
		
		String tel1 = request.getParameter("tel1");
		String tel2 = request.getParameter("tel2");
		String tel3 = request.getParameter("tel3");
		
		String tel = tel1 + "-" + tel2 + "-" + tel3;
		
		String fax = request.getParameter("fax");
		
		String post1 = request.getParameter("post1");
		String post2 = request.getParameter("post2");
		
		String post = post1 + "-" + post2;
		
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		
		String location = request.getParameter("location");
		
		// step2 파라미터
		// 사진들
		String pic0 = request.getParameter("pic0").equals("") ? "" : request.getParameter("pic0");
		String pic1 = request.getParameter("pic1").equals("") ? "" : request.getParameter("pic1");
		String pic2 = request.getParameter("pic2").equals("") ? "" : request.getParameter("pic2");
		String pic3 = request.getParameter("pic3").equals("") ? "" : request.getParameter("pic3");
		String pic4 = request.getParameter("pic4").equals("") ? "" : request.getParameter("pic4");
		String pic5 = request.getParameter("pic5").equals("") ? "" : request.getParameter("pic5");
		// 과별 의사수
		String hstat1 = request.getParameter("hstat1").equals("") ? "0" : request.getParameter("hstat1");
		String hstat2 = request.getParameter("hstat2").equals("") ? "0" : request.getParameter("hstat2");
		String hstat3 = request.getParameter("hstat3").equals("") ? "0" : request.getParameter("hstat3");
		String hstat4 = request.getParameter("hstat4").equals("") ? "0" : request.getParameter("hstat4");
		String hstat5 = request.getParameter("hstat5").equals("") ? "0" : request.getParameter("hstat5");
	
		String hstat6 = request.getParameter("hstat6").equals("") ? "0" : request.getParameter("hstat6");
		String hstat7 = request.getParameter("hstat7").equals("") ? "0" : request.getParameter("hstat7");
		String hstat8 = request.getParameter("hstat8").equals("") ? "0" : request.getParameter("hstat8");
		String hstat9 = request.getParameter("hstat9").equals("") ? "0" : request.getParameter("hstat9");
		String hstat10 = request.getParameter("hstat10").equals("") ? "0" : request.getParameter("hstat10");
		
		String hstat11 = request.getParameter("hstat11").equals("") ? "0" : request.getParameter("hstat11");
		String hstat12 = request.getParameter("hstat12").equals("") ? "0" : request.getParameter("hstat12");
		String hstat13 = request.getParameter("hstat13").equals("") ? "0" : request.getParameter("hstat13");
		String hstat14 = request.getParameter("hstat14").equals("") ? "0" : request.getParameter("hstat14");
		String hstat15 = request.getParameter("hstat15").equals("") ? "0" : request.getParameter("hstat15");
		
		String hstat16 = request.getParameter("hstat16").equals("") ? "0" : request.getParameter("hstat16");
		
		// 나머지들
		//주요수술 1 2
		String mOper1 = request.getParameter("mOper1");
		String mOper2 = request.getParameter("mOper2");
		
		//전문의 마취과의
		String sp_count = request.getParameter("sp_count").equals("") ? "0" : request.getParameter("sp_count");
		String an_count = request.getParameter("an_count").equals("") ? "0" : request.getParameter("an_count");
		
		//온라인상담건수, 전후사진
		String cou_count = request.getParameter("cou_count").equals("") ? "0" : request.getParameter("cou_count");
		String pic_count = request.getParameter("pic_count").equals("") ? "0" : request.getParameter("pic_count");
		
		//외국인유치, 통역여부
		String foreign = request.getParameter("foreign");
		String inter = request.getParameter("inter");
		
		//병원크기, 픽업서비스
		String scale = request.getParameter("scale");
		String pickup = request.getParameter("pickup");
		
		//입원실, 회복실
		String proom = request.getParameter("proom").equals("") ? "0" : request.getParameter("proom");
		String rroom = request.getParameter("rroom").equals("") ? "0" : request.getParameter("rroom");
		
		//가능수술, 진료시간
		String surg_list = request.getParameter("surg_list");
		String open_time = request.getParameter("open_time");
		
		// 진료 소개글
		String intro = request.getParameter("intro");
		
		// 점수
		String expertPoint = request.getParameter("expertPoint") == null ? "0.00" : request.getParameter("expertPoint").toString();
		String safePoint = request.getParameter("safePoint")  == null ? "0.00" : request.getParameter("safePoint").toString();
		String satisfyPoint = request.getParameter("satisfyPoint")  == null ? "0.00" : request.getParameter("satisfyPoint").toString();
		String sizePoint = request.getParameter("sizePoint")  == null ? "0.00" : request.getParameter("sizePoint").toString();
		String convenientPoint = request.getParameter("convenientPoint") == null ? "0.00" : request.getParameter("convenientPoint").toString();
		String totalPoint = request.getParameter("totalPoint") == null ? "0.00" : request.getParameter("totalPoint").toString();
		
		String grade = request.getParameter("grade");
		
		// 승인
		String stat = request.getParameter("status");
		String h_cancel_reason = request.getParameter("h_cancel_reason");
		
		// 공개날짜
		String publishDate = request.getParameter("publishDate");
		
//		if(publishDate.equals("null")){
//			publishDate = "2024-01-01";
//		}
		
		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		// explicitly setting the transaction name is something that can only be done programmatically
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = txManager.getTransaction(def);
		
		try {			
			// 병원정보입력
			HashMap<String, Object> addH_param = new HashMap<String, Object>();
			addH_param.put("hid", hid);
			
			addH_param.put("name", name);
			addH_param.put("tel", tel);
			addH_param.put("address", addr1 + " " + addr2);
			addH_param.put("post", post);
			addH_param.put("location", location);
			
			addH_param.put("introduction", intro);
			addH_param.put("specialistCount", Integer.parseInt(sp_count));
			addH_param.put("anestheticCount", Integer.parseInt(an_count));
			
			addH_param.put("homepage", homepage);
			addH_param.put("patientRoom", proom);
			addH_param.put("recoveryRoom", rroom);
			addH_param.put("interpreter", inter);
			addH_param.put("pickupService", pickup);
			
			addH_param.put("mostOperation1", mOper1);
			addH_param.put("mostOperation2", mOper2);
			addH_param.put("scale", scale);
			addH_param.put("counselCount", Integer.parseInt(cou_count));
			
			addH_param.put("reviewPicCount", Integer.parseInt(pic_count));
			addH_param.put("foreignerReg", foreign);
			addH_param.put("possibleSurgery", surg_list);
			addH_param.put("hours", open_time);
			addH_param.put("fax", fax);
			
			addH_param.put("address1", addr1);
			addH_param.put("address2", addr2);
			addH_param.put("business_id", busyId);
			
			// 점수
			addH_param.put("expertPoint", expertPoint);
			addH_param.put("safePoint", safePoint);
			addH_param.put("satisfyPoint", satisfyPoint);
			addH_param.put("sizePoint", sizePoint);
			addH_param.put("convenientPoint", convenientPoint);
			addH_param.put("totalPoint", totalPoint);
			addH_param.put("grade", grade);
			
			addH_param.put("publishDate", publishDate);
			
			sqlsession.update("admin_hospital.mod_hospital", addH_param);
			
			System.out.println("---mod_hospital---");
			
			// 병원 진료과 의사 등록 add_hospital_status
			HashMap<String, Integer> stat_param = new HashMap<String, Integer>();
			stat_param.put("hid", Integer.parseInt(hid));
			stat_param.put("hstat1", Integer.parseInt(hstat1));
			stat_param.put("hstat2", Integer.parseInt(hstat2));
			stat_param.put("hstat3", Integer.parseInt(hstat3));
			stat_param.put("hstat4", Integer.parseInt(hstat4));
			stat_param.put("hstat5", Integer.parseInt(hstat5));
			stat_param.put("hstat6", Integer.parseInt(hstat6));
			stat_param.put("hstat7", Integer.parseInt(hstat7));
			stat_param.put("hstat8", Integer.parseInt(hstat8));
			stat_param.put("hstat9", Integer.parseInt(hstat9));
			stat_param.put("hstat10", Integer.parseInt(hstat10));
			stat_param.put("hstat11", Integer.parseInt(hstat11));
			stat_param.put("hstat12", Integer.parseInt(hstat12));
			stat_param.put("hstat13", Integer.parseInt(hstat13));
			stat_param.put("hstat14", Integer.parseInt(hstat14));
			stat_param.put("hstat15", Integer.parseInt(hstat15));
			stat_param.put("hstat16", Integer.parseInt(hstat16));
			
			sqlsession.update("admin_hospital.mod_hstat" ,stat_param);
			
			System.out.println("---mod_hstat---");
			
			// 파일정보 등록 add_file_map, add_file_thumb
			HashMap<String, Object> f_thumb = new HashMap<String, Object>();
			f_thumb.put("hid", hid);
			f_thumb.put("id", pic0);
			
			sqlsession.update("renew_hospital.add_file_thumb", f_thumb);
			
			System.out.println("---add_file_thumb---");
			
			if(!pic1.equals("") || !pic2.equals("") || !pic3.equals("") || !pic4.equals("") || !pic5.equals("")){
				HashMap<String, Object> f_map = new HashMap<String, Object>();			
				f_map.put("hid", hid);			
				String ids = "";
				
				if(!pic1.equals("")){
					ids += pic1 + ",";
				}
				if(!pic2.equals("")){
					ids += pic2 + ",";
				}
				if(!pic3.equals("")){
					ids += pic3 + ",";
				}
				if(!pic4.equals("")){
					ids += pic4 + ",";
				}
				if(!pic5.equals("")){
					ids += pic5 + ",";
				}
				
				ids = ids.substring(0, ids.length() - 1);
				
				f_map.put("ids", ids);
				
				sqlsession.update("renew_hospital.add_file_map", f_map);
			}
			
			System.out.println("---add_file_map---");
			
			// 승인여부 수정
			HashMap<String, Object> stat_mod = new HashMap<String, Object>();

			stat_mod.put("status", stat);
			stat_mod.put("reason_desc", h_cancel_reason);
			stat_mod.put("hid", hid);
			
			sqlsession.update("admin_hospital.mod_h_awc", stat_mod);
			
			System.out.println("--- hospital status updated ---");
			
			txManager.commit(status);
			
			json.put("code", "0");
			
		}catch(Exception e){
			e.printStackTrace();
			
			txManager.rollback(status);
			json.put("code", "-1999");
			json.put("msg", MessageHandler.getMessage("givus.global.error"));
		}
		
		mv.addObject("result", json.toJSONString());

		return mv;
	}
	
	//병원 추가하기
	@RequestMapping( value="/hospital/addnew", method = RequestMethod.GET)
	public ModelAndView add_new(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("admin/hospital/add");
		
		String pnum = request.getParameter("pnum");
		if(pnum == null) pnum = "1";
		
		List<HashMap<String, Object>> location = sqlsession.selectList("admin_hospital.get_location");
		
		mv.addObject("location", location);

		mv.addObject("pnum", pnum);
		
		return mv;
	}
	
	// 병원 정보 입력 
	@RequestMapping( value="/hospital/addproc", method = RequestMethod.POST)
	public ModelAndView add_hospital(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();

		String name = request.getParameter("name");
		String homepage = request.getParameter("homepage");
		String busyId = request.getParameter("busy_id_num");
		
		String tel1 = request.getParameter("tel1");
		String tel2 = request.getParameter("tel2");
		String tel3 = request.getParameter("tel3");
		
		String tel = tel1 + "-" + tel2 + "-" + tel3;
		
		String fax = request.getParameter("fax");
		
		String post1 = request.getParameter("post1");
		String post2 = request.getParameter("post2");
		
		String post = post1 + "-" + post2;
		
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		
		String location = request.getParameter("location");
		
		// step2 파라미터
		// 사진들
		String pic0 = request.getParameter("pic0").equals("") ? "" : request.getParameter("pic0");
		String pic1 = request.getParameter("pic1").equals("") ? "" : request.getParameter("pic1");
		String pic2 = request.getParameter("pic2").equals("") ? "" : request.getParameter("pic2");
		String pic3 = request.getParameter("pic3").equals("") ? "" : request.getParameter("pic3");
		String pic4 = request.getParameter("pic4").equals("") ? "" : request.getParameter("pic4");
		String pic5 = request.getParameter("pic5").equals("") ? "" : request.getParameter("pic5");
		// 과별 의사수
		String hstat1 = request.getParameter("hstat1").equals("") ? "0" : request.getParameter("hstat1");
		String hstat2 = request.getParameter("hstat2").equals("") ? "0" : request.getParameter("hstat2");
		String hstat3 = request.getParameter("hstat3").equals("") ? "0" : request.getParameter("hstat3");
		String hstat4 = request.getParameter("hstat4").equals("") ? "0" : request.getParameter("hstat4");
		String hstat5 = request.getParameter("hstat5").equals("") ? "0" : request.getParameter("hstat5");
	
		String hstat6 = request.getParameter("hstat6").equals("") ? "0" : request.getParameter("hstat6");
		String hstat7 = request.getParameter("hstat7").equals("") ? "0" : request.getParameter("hstat7");
		String hstat8 = request.getParameter("hstat8").equals("") ? "0" : request.getParameter("hstat8");
		String hstat9 = request.getParameter("hstat9").equals("") ? "0" : request.getParameter("hstat9");
		String hstat10 = request.getParameter("hstat10").equals("") ? "0" : request.getParameter("hstat10");
		
		String hstat11 = request.getParameter("hstat11").equals("") ? "0" : request.getParameter("hstat11");
		String hstat12 = request.getParameter("hstat12").equals("") ? "0" : request.getParameter("hstat12");
		String hstat13 = request.getParameter("hstat13").equals("") ? "0" : request.getParameter("hstat13");
		String hstat14 = request.getParameter("hstat14").equals("") ? "0" : request.getParameter("hstat14");
		String hstat15 = request.getParameter("hstat15").equals("") ? "0" : request.getParameter("hstat15");
		
		String hstat16 = request.getParameter("hstat16").equals("") ? "0" : request.getParameter("hstat16");
		
		// 나머지들
		//주요수술 1 2
		String mOper1 = request.getParameter("mOper1");
		String mOper2 = request.getParameter("mOper2");
		
		//전문의 마취과의
		String sp_count = request.getParameter("sp_count").equals("") ? "0" : request.getParameter("sp_count");
		String an_count = request.getParameter("an_count").equals("") ? "0" : request.getParameter("an_count");
		
		//온라인상담건수, 전후사진
		String cou_count = request.getParameter("cou_count").equals("") ? "0" : request.getParameter("cou_count");
		String pic_count = request.getParameter("pic_count").equals("") ? "0" : request.getParameter("pic_count");
		
		//외국인유치, 통역여부
		String foreign = request.getParameter("foreign");
		String inter = request.getParameter("inter");
		
		//병원크기, 픽업서비스
		String scale = request.getParameter("scale");
		String pickup = request.getParameter("pickup");
		
		//입원실, 회복실
		String proom = request.getParameter("proom").equals("") ? "0" : request.getParameter("proom");
		String rroom = request.getParameter("rroom").equals("") ? "0" : request.getParameter("rroom");
		
		//가능수술, 진료시간
		String surg_list = request.getParameter("surg_list");
		String open_time = request.getParameter("open_time");
		
		// 진료 소개글
		String intro = request.getParameter("intro");
		
		// 점수
		String expertPoint = request.getParameter("expertPoint") == null ? "0.00" : request.getParameter("expertPoint").toString();
		String safePoint = request.getParameter("safePoint")  == null ? "0.00" : request.getParameter("safePoint").toString();
		String satisfyPoint = request.getParameter("satisfyPoint")  == null ? "0.00" : request.getParameter("satisfyPoint").toString();
		String sizePoint = request.getParameter("sizePoint")  == null ? "0.00" : request.getParameter("sizePoint").toString();
		String convenientPoint = request.getParameter("convenientPoint") == null ? "0.00" : request.getParameter("convenientPoint").toString();
		String totalPoint = request.getParameter("totalPoint") == null ? "0.00" : request.getParameter("totalPoint").toString();
		
		String grade = request.getParameter("grade");
		
		// 공개날짜
		String publishDate = request.getParameter("publishDate");
		
		if(publishDate == null){
			publishDate = "2024-01-01";
		}
		
		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		// explicitly setting the transaction name is something that can only be done programmatically
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = txManager.getTransaction(def);
		
		try {			
			// 병원정보입력
			HashMap<String, Object> addH_param = new HashMap<String, Object>();
			
			addH_param.put("name", name);
			addH_param.put("tel", tel);
			addH_param.put("address", addr1 + " " + addr2);
			addH_param.put("post", post);
			addH_param.put("location", location);
			
			addH_param.put("introduction", intro);
			addH_param.put("specialistCount", Integer.parseInt(sp_count));
			addH_param.put("anestheticCount", Integer.parseInt(an_count));
			
			addH_param.put("homepage", homepage);
			addH_param.put("patientRoom", proom);
			addH_param.put("recoveryRoom", rroom);
			addH_param.put("interpreter", inter);
			addH_param.put("pickupService", pickup);
			
			addH_param.put("mostOperation1", mOper1);
			addH_param.put("mostOperation2", mOper2);
			addH_param.put("scale", scale);
			addH_param.put("counselCount", Integer.parseInt(cou_count));
			
			addH_param.put("reviewPicCount", Integer.parseInt(pic_count));
			addH_param.put("foreignerReg", foreign);
			addH_param.put("possibleSurgery", surg_list);
			addH_param.put("hours", open_time);
			addH_param.put("fax", fax);
			
			addH_param.put("address1", addr1);
			addH_param.put("address2", addr2);
			addH_param.put("business_id", busyId);
			
			// 점수
			addH_param.put("expertPoint", expertPoint);
			addH_param.put("safePoint", safePoint);
			addH_param.put("satisfyPoint", satisfyPoint);
			addH_param.put("sizePoint", sizePoint);
			addH_param.put("convenientPoint", convenientPoint);
			addH_param.put("totalPoint", totalPoint);
			addH_param.put("grade", grade);
			
			addH_param.put("publishDate", publishDate);
			
			sqlsession.update("admin_hospital.add_hospital", addH_param);
			
			String hid = addH_param.get("hid").toString();
			
			System.out.println("---add_hospital---");
			
			// 병원 진료과 의사 등록 add_hospital_status
			HashMap<String, Object> stat_param = new HashMap<String, Object>();
			
			stat_param.put("hstat1", Integer.parseInt(hstat1));
			stat_param.put("hstat2", Integer.parseInt(hstat2));
			stat_param.put("hstat3", Integer.parseInt(hstat3));
			stat_param.put("hstat4", Integer.parseInt(hstat4));
			stat_param.put("hstat5", Integer.parseInt(hstat5));
			stat_param.put("hstat6", Integer.parseInt(hstat6));
			stat_param.put("hstat7", Integer.parseInt(hstat7));
			stat_param.put("hstat8", Integer.parseInt(hstat8));
			stat_param.put("hstat9", Integer.parseInt(hstat9));
			stat_param.put("hstat10", Integer.parseInt(hstat10));
			stat_param.put("hstat11", Integer.parseInt(hstat11));
			stat_param.put("hstat12", Integer.parseInt(hstat12));
			stat_param.put("hstat13", Integer.parseInt(hstat13));
			stat_param.put("hstat14", Integer.parseInt(hstat14));
			stat_param.put("hstat15", Integer.parseInt(hstat15));
			stat_param.put("hstat16", Integer.parseInt(hstat16));
			stat_param.put("hid", hid);
			
			sqlsession.update("admin_hospital.add_hstat" ,stat_param);
			
			System.out.println("---mod_hstat---");
			
			// 파일정보 등록 add_file_map, add_file_thumb
			HashMap<String, Object> f_thumb = new HashMap<String, Object>();
			f_thumb.put("hid", hid);
			f_thumb.put("id", pic0);
			
			sqlsession.update("renew_hospital.add_file_thumb", f_thumb);
			
			System.out.println("---add_file_thumb---");
			
			if(!pic1.equals("") || !pic2.equals("") || !pic3.equals("") || !pic4.equals("") || !pic5.equals("")){
				HashMap<String, Object> f_map = new HashMap<String, Object>();			
				f_map.put("hid", hid);			
				String ids = "";
				
				if(!pic1.equals("")){
					ids += pic1 + ",";
				}
				if(!pic2.equals("")){
					ids += pic2 + ",";
				}
				if(!pic3.equals("")){
					ids += pic3 + ",";
				}
				if(!pic4.equals("")){
					ids += pic4 + ",";
				}
				if(!pic5.equals("")){
					ids += pic5 + ",";
				}
				
				ids = ids.substring(0, ids.length() - 1);
				
				f_map.put("ids", ids);
				
				sqlsession.update("renew_hospital.add_file_map", f_map);
			}
			
			System.out.println("---add_file_map---");
			
			// 승인여부 수정
			HashMap<String, Object> stat_mod = new HashMap<String, Object>();
			stat_mod.put("hid", hid);
			
			sqlsession.update("admin_hospital.add_h_awc", stat_mod);
			
			System.out.println("--- hospital status updated ---");
			
			txManager.commit(status);
			
			json.put("code", "0");
			
		}catch(Exception e){
			e.printStackTrace();
			
			txManager.rollback(status);
			json.put("code", "-1999");
			json.put("msg", MessageHandler.getMessage("givus.global.error"));
		}
		
		mv.addObject("result", json.toJSONString());

		return mv;
	}
}
