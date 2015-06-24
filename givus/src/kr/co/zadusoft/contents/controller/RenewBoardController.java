package kr.co.zadusoft.contents.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.UserModel;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.web.util.MessageHandler;
import dynamic.web.util.SessionContext;

@Controller
@RequestMapping(value="/___/renew")
public class RenewBoardController{

	@Autowired
	private SqlSession sqlsession;
	
	@RequestMapping( value="/board/attendance", method = RequestMethod.GET)
	public ModelAndView attendance(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/board/attendance");

		
		return mv;
	}
	
	@RequestMapping( value="/board/post/remove", method = RequestMethod.POST)
	public ModelAndView del_posting(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		if(um != null){
			if(um.getEmail() != null){
				
				String creator = um.getAccount();
				String pid = request.getParameter("pid");
				
				HashMap<String, Object> param = new HashMap<>();
				param.put("pid", pid);
				param.put("creator", creator);
				
				sqlsession.update("renew_board.del_posting", param);
				
				json.put("code", "0");
				json.put("msg", MessageHandler.getMessage("posting.msg.delete.complete"));
				
			}else{
				json.put("code", "-1001");
				json.put("msg", MessageHandler.getMessage("posting.msg.recommend_needlogin"));
			}
		}else{
			json.put("code", "-1002");
			json.put("msg", MessageHandler.getMessage("posting.msg.recommend_needlogin"));
		}
		
		return mv;
	}
	
	@RequestMapping( value="/board/post/update", method = RequestMethod.GET)
	public ModelAndView update_posting(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		if(um != null){
			if(um.getEmail() != null){
				
				String creator = um.getAccount();
				String pid = request.getParameter("pid");
				String cate = request.getParameter("cate");
				String subject = request.getParameter("title");
				String contents = request.getParameter("content");
				
				HashMap<String, Object> param = new HashMap<>();
				param.put("pid", pid);
				param.put("creator", creator);
				
				param.put("cate", cate);
				param.put("subject", subject);
				param.put("contents", contents);
				
				
				sqlsession.update("renew_board.board_modify", param);
				
				json.put("code", "0");
				json.put("msg", MessageHandler.getMessage("posting.msg.update.complete"));
				
			}else{
				json.put("code", "-1001");
				json.put("msg", MessageHandler.getMessage("posting.msg.recommend_needlogin"));
			}
		}else{
			json.put("code", "-1002");
			json.put("msg", MessageHandler.getMessage("posting.msg.recommend_needlogin"));
		}
		
		return mv;
	}
	
	@RequestMapping( value="/board/list/{bid}", method = RequestMethod.GET)
	public ModelAndView boardlist(@PathVariable Integer bid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("givus_v2/board/board" + bid);
	
		String PN = request.getParameter("PN") == null ? "0" : request.getParameter("PN");
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
		
		pnum = Integer.parseInt(PN);
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("bid",bid);			
		params.put("cate", CT);
		params.put("query" ,QR);
		params.put("sort", sort);
		params.put("start", pnum * 10);
		params.put("end", 30);
		
		List<HashMap<String, Object>> get_board_list = sqlsession.selectList("renew_board.get_board_list", params);
		
		total = sqlsession.selectOne("renew_board.get_board_list_count", params);
		
		mv.addObject("list", get_board_list);
		mv.addObject("cate" ,category);
		mv.addObject("cateid", CT);
		mv.addObject("bid", bid);
		mv.addObject("total", total);
		mv.addObject("pnum", pnum);
		mv.addObject("query", QR);
		
		return mv;			
	
	}
	
	@RequestMapping( value="/board/write/{bid}", method = RequestMethod.GET)
	public ModelAndView board_write(@PathVariable Integer bid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("givus_v2/board/board_write");
		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("type", "30");
		List<HashMap<String, Object>> category = sqlsession.selectList("renew_hospital.get_review_category", h_param);
		
		mv.addObject("cate" ,category);
		mv.addObject("bid", bid);
		return mv;
		
	}
	
	// 글수정 폼
	@RequestMapping( value="/board/modify/{bid}", method = RequestMethod.GET)
	public ModelAndView board_modify(@PathVariable Integer bid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("givus_v2/board/board_modify");
		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("type", "30");
		List<HashMap<String, Object>> category = sqlsession.selectList("renew_hospital.get_review_category", h_param);
		
		HashMap<String, Integer> get_board_view = new HashMap<String, Integer>();
		get_board_view.put("bid", bid);		
		HashMap<String, Object> board = sqlsession.selectOne("renew_board.get_review_board_view", get_board_view);
		
		mv.addObject("cate" ,category);
		mv.addObject("board" ,board);
		mv.addObject("bid", bid);
		
		return mv;
		
	}
	
	@RequestMapping( value="/board/writeproc", method = RequestMethod.POST)
	public ModelAndView board_write_process(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String cate =  request.getParameter("sct");
		String title   = request.getParameter("title");
		String content   = request.getParameter("content");
		
		String type   = request.getParameter("type");
		
		
		UserModel login =  (UserModel) SessionContext.getUserModel();
		
		if(login != null){
			if(login.getEmail() != null){
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("type",type);
				param.put("account", login.getAccount());
				param.put("subject", title);
				param.put("contents",content);
				param.put("cate",cate);
				
				int rs = sqlsession.insert("renew_board.board_write", param);
				
				// 메인 시간업뎃
				sqlsession.update("renew_etc.main_updatetime_set");
				
				if(rs > 0){
					json.put("code", "0");
					json.put("pid", param.get("IDX"));
					json.put("msg", "게시물이 등록되었습니다.");
				}
				
			}else{
				json.put("code", "-1000");
				json.put("msg", MessageHandler.getMessage("posting.msg.recommend_needlogin"));
			}			
		}else{
			json.put("code", "-1000");
			json.put("msg", MessageHandler.getMessage("posting.msg.recommend_needlogin"));
		}
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
		
	}
	
	@RequestMapping( value="/board/modproc", method = RequestMethod.POST)
	public ModelAndView board_mod_process(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String cate =  request.getParameter("sct");
		String title   = request.getParameter("title");
		String content   = request.getParameter("content");
		
		String type   = request.getParameter("type");
		String pid   = request.getParameter("pid");
		
		UserModel login =  (UserModel) SessionContext.getUserModel();
		
		if(login != null){
			if(login.getEmail() != null){
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("type",type);
				param.put("creator", login.getAccount());
				param.put("subject", title);
				param.put("contents",content);
				param.put("cate",cate);
				param.put("pid", pid);
				
				int rs = sqlsession.update("renew_board.board_modify", param);
				
				// 메인 시간업뎃
				sqlsession.update("renew_etc.main_updatetime_set");
				
				json.put("code", "0");
				json.put("msg", "게시물이 수정되었습니다.");
				
				
			}else{
				json.put("code", "-1000");
				json.put("msg", MessageHandler.getMessage("posting.msg.recommend_needlogin"));
			}			
		}else{
			json.put("code", "-1000");
			json.put("msg", MessageHandler.getMessage("posting.msg.recommend_needlogin"));
		}
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
		
	}
	
	@RequestMapping( value="/board/view/{bid}", method = RequestMethod.GET)
	public ModelAndView board_view(@PathVariable Integer bid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		// 조회수 증가
		sqlsession.update("renew_board.add_viewcount", bid);
		
		String categoryId = request.getParameter("CI") == null ? "0" : request.getParameter("CI");
		String type = request.getParameter("TP");
		
		ModelAndView mv = new ModelAndView("givus_v2/board/board_view");
		HashMap<String, Integer> h_param = new HashMap<String, Integer>();
		h_param.put("bid", bid);
		
		HashMap<String, Object> board = sqlsession.selectOne("renew_board.get_review_board_view", h_param);
		
		String cdate =  board.get("createDate").toString();
		HashMap<String, Object> b_param = new HashMap<String, Object>();
		b_param.put("cdate", cdate);		
		b_param.put("cid", categoryId);
		b_param.put("type", type);
		
//		System.out.println("cdate = " + cdate);
		
		HashMap<String, Object> prevId = sqlsession.selectOne("renew_board.get_board_prev_id", b_param);
		HashMap<String, Object> nextId = sqlsession.selectOne("renew_board.get_board_next_id", b_param);
		
		if(prevId != null)
		mv.addObject("prevId", prevId);
		if(nextId != null)
		mv.addObject("nextId", nextId);
		
		
		mv.addObject("board", board);
		
		mv.addObject("bid", bid);
		mv.addObject("cid", categoryId);
		mv.addObject("type", type);
		return mv;
		
	}
	
	@RequestMapping( value="/board/viewn/{bid}", method = RequestMethod.GET)
	public ModelAndView board_viewn(@PathVariable Integer bid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		// 조회수 증가
		
		sqlsession.update("renew_board.add_viewcount", bid);
		
		String categoryId = request.getParameter("CI") == null ? "0" : request.getParameter("CI");
		String type = request.getParameter("TP");
		
		ModelAndView mv = new ModelAndView("givus_v2/board/board_view_n");
		HashMap<String, Integer> h_param = new HashMap<String, Integer>();
		h_param.put("bid", bid);
		
		HashMap<String, Object> board = sqlsession.selectOne("renew_board.get_review_board_view", h_param);
		
		String cdate =  board.get("createDate").toString();
		HashMap<String, Object> b_param = new HashMap<String, Object>();
		b_param.put("cdate", cdate);		
		b_param.put("cid", categoryId);
		b_param.put("type", type);
		
//		System.out.println("cdate = " + cdate);
		
		HashMap<String, Object> prevId = sqlsession.selectOne("renew_board.get_board_prev_id", b_param);
		HashMap<String, Object> nextId = sqlsession.selectOne("renew_board.get_board_next_id", b_param);
		
		if(prevId != null)
		mv.addObject("prevId", prevId);
		if(nextId != null)
		mv.addObject("nextId", nextId);
		
		
		mv.addObject("board", board);
		
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
	
	
	
}
