package kr.co.zadusoft.contents.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.UserModel;
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
import dynamic.web.util.MessageHandler;
import dynamic.web.util.SessionContext;

@Controller
@RequestMapping(value="/___/admin")
public class RenewAdminBoardController{

	@Autowired
	private SqlSession sqlsession;
	
	@RequestMapping( value="/board/{bid}", method = RequestMethod.GET)
	public ModelAndView boardlist(@PathVariable Integer bid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("admin/board/list");
	
		String PN = request.getParameter("PN") == null ? "1" : request.getParameter("PN");
		String QR = request.getParameter("QR") == null ? "" : request.getParameter("QR");
		String ST = request.getParameter("ST");
		String CT = request.getParameter("CT") == null ? "" : request.getParameter("CT");
		
		String type = "30";
		String sort = "p.createDate";
		if(ST != null){
			if(ST.equals("v")){
				sort = "p.viewCount";
			}
		}
		
		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("type", type);
		List<HashMap<String, Object>> category = sqlsession.selectList("renew_hospital.get_review_category", h_param);
		
		int pnum = 0;
		int total = 0;
		
		List<HashMap<String, Object>> get_board_list = null;
		
		pnum = Integer.parseInt(PN);
		
		if(bid != 32 ){
			HashMap<String, Object> params = new HashMap<String, Object>();
			params.put("bid",bid);
			params.put("cate", CT);
			params.put("query" ,QR);
			params.put("sort", sort);
			params.put("start", (pnum-1) * 10);
			params.put("end", 30);
			
			get_board_list = sqlsession.selectList("admin_board.get_board_list", params);
			total = sqlsession.selectOne("admin_board.get_board_list_count", params);
			
		}else if(bid == 32){						
			HashMap<String, Object> params = new HashMap<String, Object>();
			params.put("query" ,QR);
			params.put("start", (pnum-1) * 10);
			params.put("end", 30);
			
			get_board_list = sqlsession.selectList("admin_board.get_attend_list", params);
			total = sqlsession.selectOne("admin_board.get_attend_list_count", params);			
		}
		
		mv.addObject("list", get_board_list);
		mv.addObject("cate" ,category);
		mv.addObject("cateid", CT);
		mv.addObject("bid", bid);
		mv.addObject("total", total);

		mv.addObject("pnum", pnum);
		mv.addObject("query", QR);
		
		return mv;			
	
	}
	 
	@RequestMapping( value="/board/write/{type}", method = RequestMethod.GET)
	public ModelAndView board_write(@PathVariable Integer type, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("admin/board/board_write"); 
		
		HashMap<String, Object> h_param = new HashMap<String, Object>();		
		h_param.put("type", 30);
		List<HashMap<String, Object>> category = sqlsession.selectList("renew_hospital.get_review_category", h_param);
		
		mv.addObject("category" ,category);
		
		if(type == 25 || type == 26 ){
			List<HashMap<String, Object>> hos = sqlsession.selectList("get_hospitals");
			mv.addObject("hos" ,hos);	
		}
		
		mv.addObject("type", type);
		
		return mv;
		
	}
	
	@RequestMapping( value="/board/addproc", method = RequestMethod.POST)
	public ModelAndView board_write_proc( HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String bid = request.getParameter("bid");
		String category = request.getParameter("category");
		String creator = request.getParameter("creator");
		String createDate = request.getParameter("createDate");
		String viewCount = request.getParameter("viewCount");
		String contents = request.getParameter("contents");
		String subject = request.getParameter("subject");
		String hid = request.getParameter("hid") == null ? "0" : request.getParameter("hid")  ;
		
		if(viewCount == null) viewCount = "0";
		else if(viewCount.equals("")) viewCount = "0";
		if(creator == null) creator = "관리자";
		else if(creator.equals("")) creator = "관리자";
		
		HashMap<String, Object> param = new HashMap<>();		
		param.put("cateId", category);
		param.put("createDate", createDate);
		param.put("creator", creator);
		param.put("viewCount", viewCount);
		param.put("contents", contents);
		param.put("subject", subject);
		param.put("hid", hid);
		param.put("bid", bid);
		
		sqlsession.insert("admin_board.add_user_posting", param);
		
		// 최근 업데이트 날짜로 바꾼다
		if(!hid.equals("0")){
			sqlsession.update("renew_hospital.set_update_recent", hid);
		}
		
		int idx = (int) param.get("IDX");
		
		// 리뷰 포인트 넣기
		if(bid.equals("26")){
			String point = request.getParameter("point");
			String gender = request.getParameter("gender");
			String age = request.getParameter("age");
			
			String[] points = point.substring(1).split(":");
			
			HashMap<String, Object> add_point = new HashMap<String, Object>();
			add_point.put("pid", idx);
			add_point.put("hid", hid);
			add_point.put("gender", gender);
			add_point.put("age", age);			
			
			int total = 0;
			
			for(int i = 1 ; i <= points.length ;i++){
				total += Integer.parseInt(points[i-1]);
				add_point.put("point" + i, Integer.parseInt(points[i-1]));
				System.out.println("point = " + points[i-1]);
			}
			
			int rs2 = sqlsession.insert("renew_hospital.add_hospital_point", add_point);
			
			if(rs2 > 0){
				// 병원 리뷰 정보에도 합산정보를 적용 insert_points
				HashMap<String, Object> add_evalution = new HashMap<String, Object>();
				add_evalution.put("hid", hid);
				add_evalution.put("woman", 1);
				add_evalution.put("g20", 1);
				
				int totalPoint = (int)(total/12);
				add_evalution.put("point" + totalPoint, 1);
				
				int rs3 = sqlsession.insert("renew_hospital.insert_points", add_evalution);				
				
			}
		}
		
		ModelAndView mv = new ModelAndView("redirect:/___/admin/board/view/" + idx + "?pnum=1&TP="+bid); 
		
		return mv;
		
	}
	
	@RequestMapping( value="/board/getusers", method = RequestMethod.GET)
	public ModelAndView getusers(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		List<HashMap<String, Object>> list = sqlsession.selectList("admin_board.get_user_list");
		
		json.put("list", list );
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
		
	}
	
	@RequestMapping( value="/board/deletecomment", method = RequestMethod.POST)
	public ModelAndView remove_comment(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String pid = request.getParameter("pid");
		String bid = request.getParameter("bid");
		String cid = request.getParameter("cid");
		String pnum = request.getParameter("pnum");
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("ids", cid);
		
		sqlsession.update("admin_board.del_user_comment", param);
		
		ModelAndView mv = new ModelAndView("redirect:/___/admin/board/view/" + pid + "?pnum=" + pnum + "&TP=" + bid);
		
		return mv;
		
	}
	
	@RequestMapping( value="/board/deleteproc", method = RequestMethod.POST)
	public ModelAndView board_del(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String type = request.getParameter("type");
		String pnum = request.getParameter("pnum");
		
		String[] pid = request.getParameterValues("pid");
		
		StringBuffer sb = new StringBuffer();
		for(int i = 0 ; i < pid.length; i++){
			sb.append(pid[i]);
			sb.append(",");
		}

		HashMap<String, Object> param = new HashMap<>();
		param.put("ids", sb.toString().substring(0, sb.length()-1));
		
		if(!type.equals("32")){
			sqlsession.update("admin_board.del_user_posting", param);	
		}else if(type.equals("32")){
			sqlsession.update("admin_board.del_user_comment", param);
		}
		
		ModelAndView mv = new ModelAndView("redirect:/___/admin/board/" + type + "?pnum=" + pnum);
		
		return mv;
		
	}
	
	@RequestMapping( value="/board/modproc", method = RequestMethod.POST)
	public ModelAndView board_mod(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String pid = request.getParameter("pid");
		String bid = request.getParameter("bid");
		String category = request.getParameter("category");
		String creator = request.getParameter("creator");
		String createDate = request.getParameter("createDate");
		String viewCount = request.getParameter("viewCount");
		String contents = request.getParameter("contents");
		String subject = request.getParameter("subject");
		String hid = request.getParameter("hid") == null ? "" : request.getParameter("hid");
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("pid", pid);
		param.put("category", category);
		param.put("createDate", createDate);
		param.put("creator", creator);
		param.put("viewCount", viewCount);
		param.put("contents", contents);
		param.put("subject", subject);
		param.put("hid", hid);
		
		if(bid.equals("25") || bid.equals("26")){
			String ch_hid = request.getParameter("ch_hid");
			param.put("ch_hid", ch_hid);
		}
		
		sqlsession.update("admin_board.mod_user_posting", param);
		
		// 리뷰 포인트 넣기
		if(bid.equals("26")){
			String point = request.getParameter("point");
			String gender = request.getParameter("gender");
			String age = request.getParameter("age");
			
			String[] points = point.substring(1).split(":");
			
			HashMap<String, Object> add_point = new HashMap<String, Object>();
			add_point.put("pid", pid);
			add_point.put("hid", hid);
			add_point.put("gender", gender);
			add_point.put("age", age);
			
			int total = 0;
			
			for(int i = 1 ; i <= points.length ;i++){
				total += Integer.parseInt(points[i-1]);
				add_point.put("point" + i, Integer.parseInt(points[i-1]));
				System.out.println("point = " + points[i-1]);
			}
			
			int rs2 = sqlsession.insert("renew_hospital.mod_hospital_point", add_point);
			
			if(rs2 > 0){
				// 병원 리뷰 정보에도 합산정보를 적용 insert_points
				HashMap<String, Object> add_evalution = new HashMap<String, Object>();
				add_evalution.put("hid", hid);
				
				if(gender.equals("M"))
					add_evalution.put("man", 1);
				else if(gender.equals("F"))
					add_evalution.put("woman", 1);
				
				if(age.equals("10"))
					add_evalution.put("g10", 1);
				else if(age.equals("20"))
					add_evalution.put("g20", 1);
				else if(age.equals("30"))
					add_evalution.put("g30", 1);
				else if(age.equals("40"))
					add_evalution.put("g40", 1);
				
				int totalPoint = (int)(total/12);
				add_evalution.put("point" + totalPoint, 1);
				
				int rs3 = sqlsession.insert("renew_hospital.insert_points", add_evalution);				
			}
		}
		
		
		ModelAndView mv = new ModelAndView("redirect:/___/admin/board/view/" + pid + "?pnum=0&TP=" + bid + "&hid=" + hid);
		
		
		return mv;
	}
	
	@RequestMapping( value="/board/view/{bid}", method = RequestMethod.GET)
	public ModelAndView board_view(@PathVariable Integer bid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("admin/board/board_view");
		
		String categoryId = request.getParameter("CI") == null ? "0" : request.getParameter("CI");
		String type = request.getParameter("TP");
		
		HashMap<String, Integer> h_param = new HashMap<String, Integer>();
		h_param.put("bid", bid);
		
		HashMap<String, Object> board = sqlsession.selectOne("renew_board.get_review_board_view", h_param);
		
		String cdate =  board.get("createDate").toString();
		HashMap<String, Object> b_param = new HashMap<String, Object>();
		b_param.put("cdate", cdate);		
		b_param.put("cid", categoryId);
		b_param.put("type", type);
		
		HashMap<String, Object> c_param = new HashMap<String, Object>();
		if(type.equals("31") ) type ="30";
		c_param.put("type", type);
		List<HashMap<String, Object>> category = sqlsession.selectList("renew_hospital.get_review_category", c_param);
		
		if(type.equals("25") || type.equals("26") ){
			List<HashMap<String, Object>> hos = sqlsession.selectList("get_hospitals");
			mv.addObject("hos" ,hos);	
			
			String hid = request.getParameter("hid");
			mv.addObject("hid", hid);
		}
		
		if(type.equals("26")){
			//get_review_board_view
			HashMap<String, Object> rv_param = new HashMap<String, Object>();
			rv_param.put("bid", bid);
			
			HashMap<String, Object> rev_point = sqlsession.selectOne("renew_hospital.get_review_board_view_point", rv_param);
			
			HashMap<Integer, Object> review = new HashMap<Integer, Object>();
			review.put(1, rev_point.get("enoughDesc"));
			review.put(2, rev_point.get("considerNeeds"));
			review.put(3, rev_point.get("reaction"));
			review.put(4, rev_point.get("facilities"));
			review.put(5, rev_point.get("waitingTime"));
			review.put(6, rev_point.get("privacy"));
			review.put(7, rev_point.get("reliability"));
			review.put(8, rev_point.get("transportation"));
			review.put(9, rev_point.get("stress"));
			review.put(10, rev_point.get("afterSupport"));
			review.put(11, rev_point.get("amount"));
			review.put(12, rev_point.get("resultSatisfaction"));
			
			mv.addObject("review", review);
			
			mv.addObject("gender", rev_point.get("gender"));
			mv.addObject("age", rev_point.get("ageGroup"));
		}
		
		mv.addObject("board", board);
		mv.addObject("category", category);
		mv.addObject("bid", bid);
		mv.addObject("cid", categoryId);
		mv.addObject("type", type);
		return mv;
		
	}
	
	@RequestMapping( value="/board/contact", method = RequestMethod.GET)
	public ModelAndView contact(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("givus_v2/board/contact");
		
		String PN = request.getParameter("PN") == null ? "0" : request.getParameter("PN");

		int pnum = Integer.parseInt(PN);
		
		mv.addObject("pnum", pnum );
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		if(um!=null){
			if(um.getEmail() != null){
				HashMap<String, Object> param = new HashMap<String, Object>();				
				param.put("start", pnum * 30);
				param.put("end" , 30);
				param.put("uid", um.getId());
				
				List<HashMap<String, Object>> list = sqlsession.selectList("renew_mypage.get_user_contact_list", param);
				
				mv.addObject("list", list);
				
				int totalCnt = sqlsession.selectOne("renew_mypage.get_user_contact_list_count", param);
				
				mv.addObject("total", totalCnt);
			}
		}
		
		return mv;
	}
	
	
	@RequestMapping( value="/comment/add", method = RequestMethod.POST)
	public ModelAndView add(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String username = request.getParameter("username");
		String postingId = request.getParameter("postingId");
		String comment = request.getParameter("comment");
		String parentId = request.getParameter("parentId");
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", username);
		param.put("postingId", postingId);
		param.put("comment", comment);
		if(parentId != null)
		param.put("parentId", parentId);
		
		int id = sqlsession.insert("renew_board.add_comment", param);
		
		System.out.println("add comment insert id = " + id);
		
		// 댓글 카운트 증가
		sqlsession.update("add_comment_count", postingId);
		
		json.put("code", "0");
		json.put("id", id);
		
		mv.addObject("result", json.toJSONString());
		
		return mv;		
	}
}
