package kr.co.zadusoft.contents.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.givus.util.GivusUtil;

import org.apache.commons.codec.binary.Base64;
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
import dynamic.web.util.SessionContext;

@Controller
@RequestMapping(value="/___/renew")
public class RenewMypageController{

	@Autowired
	private SqlSession sqlsession;
	
	@Resource(name = "txManager")
	protected DataSourceTransactionManager txManager;
	
	@RequestMapping( value="/mypage/board/{type}", method = RequestMethod.GET)
	public ModelAndView boardlist(@PathVariable Integer type, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/mypage/board");

		String PN = request.getParameter("PN") == null ? "0" : request.getParameter("PN");
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		if(um != null){
			if(um.getEmail() != null){
				String account = um.getAccount();
				
				int board_count = sqlsession.selectOne("renew_mypage.get_my_board_list_count", account);
				int comment_count = sqlsession.selectOne("renew_mypage.get_my_comment_count", account);
				int attend_count = sqlsession.selectOne("renew_mypage.get_my_attend_count", account);
				int delete_count = sqlsession.selectOne("renew_mypage.get_my_board_delete_list_count", account);
				
				mv.addObject("board_count", board_count);
				mv.addObject("comment_count", comment_count);
				mv.addObject("attend_count", attend_count);
				mv.addObject("delete_count", delete_count);
				
				List<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
				
				HashMap<String, Object> params = new HashMap<String, Object>();
				params.put("account", account);
				params.put("start", (Integer.parseInt(PN) * 30));
				params.put("end", 30);
				
				if(type == 0){					
					list = sqlsession.selectList("renew_mypage.get_my_board_list", params);
				}else if(type == 1){
					list = sqlsession.selectList("renew_mypage.get_my_commented_board", params);
				}else if(type == 2){
					list = sqlsession.selectList("renew_mypage.get_my_comment_list", params);
				}else if(type == 3){
					list = sqlsession.selectList("renew_mypage.get_my_board_delete_list", params);
				}
				
				mv.addObject("pnum", Integer.parseInt(PN));
				mv.addObject("list", list);
			}			
		}
		
		mv.addObject("type", type);
		
		return mv;
	}
	
	@RequestMapping( value="/mypage/board/delete", method = RequestMethod.POST)
	public ModelAndView delete_board( HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String[] ids = request.getParameterValues("ids[]");
		String type = request.getParameter("type");
		String[] postId = request.getParameterValues("pid[]");

		// 유효성검사
		for(int i = 0 ; i < ids.length ; i++){			
			if(!GivusUtil.isNumber(ids[i]) || !GivusUtil.isNumber(postId[i])){
				json.put("code", "2");
				json.put("msg", MessageHandler.getMessage("mypage.board.check.isnan"));
				
				mv.addObject("result", json.toJSONString());
				return mv;
			}
		}
		
		StringBuilder sb = new StringBuilder();
		
		for(int k=0; k < ids.length; k++){
			sb.append(ids[k]);
			sb.append(",");
		}
		
		String id_string = sb.substring(0, sb.length()-1);
		
		int rw = 0;
		
		HashMap<String, String> d_param = new HashMap<String, String>();
		d_param.put("ids", id_string);
		
		if(type.equals("p")){
			rw = sqlsession.update("renew_mypage.delete_board", d_param);			
		}else if(type.equals("c")){
			rw = sqlsession.update("renew_mypage.delete_comment", d_param);
			
			if(rw > 0){
				HashMap<String, Object> post_update = new HashMap<String, Object>();
				post_update.put("cnt", 1);
				for(int j = 0 ; j < postId.length ; j++){					
					post_update.put("id", postId[j]);
					
					sqlsession.update("renew_mypage.up_reduce_viewcount", post_update);
				}				
			}
		}
		
		json.put("code", "0");
		json.put("msg" ,rw);
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
	@RequestMapping( value="/mypage/myinfo", method = RequestMethod.GET)
	public ModelAndView myinfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/mypage/myinfo");
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("email", um.getEmail());
		HashMap<String, Object> user = sqlsession.selectOne("renew_mypage.get_my_info", param);
		
		List<HashMap<String, Object>> keywords = sqlsession.selectList("renew_mypage.get_keywords");
		//get_user_keywords
		HashMap<String, Object> uk_params = new HashMap<String, Object>();
		uk_params.put("uid", um.getId());
		List<HashMap<String, Object>> user_keyword = sqlsession.selectList("renew_mypage.get_user_keywords", uk_params);
		
		mv.addObject("user" ,user);
		mv.addObject("user_keyword" , user_keyword);
		mv.addObject("keywords", keywords);
		
		return mv;
	}
	
	@RequestMapping( value="/mypage/zipcode", method = RequestMethod.POST)
	public ModelAndView zipcode(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String query = request.getParameter("query");
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("query", query );
		
		List<HashMap<String, Object>> zipcode = sqlsession.selectList("renew_mypage.zipcode_search", param);
		json.put("zipcode", zipcode);
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
	@RequestMapping( value="/mypage/modifyproc", method = RequestMethod.POST)
	public ModelAndView modifyproc(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		String tel1 = request.getParameter("tel1") == null ? "" : request.getParameter("tel1");
		String tel2 = request.getParameter("tel2") == null ? "" : request.getParameter("tel2");
		String tel3 = request.getParameter("tel3") == null ? "" : request.getParameter("tel3");
		
		String post1 = request.getParameter("post1") == null ? "" : request.getParameter("post1");
		String post2 = request.getParameter("post2") == null ? "" : request.getParameter("post2");
		
		String addr1 = request.getParameter("addr1") == null ? "" : request.getParameter("addr1");
		String addr2 = request.getParameter("addr2") == null ? "" : request.getParameter("addr2");
		
		String uk = request.getParameter("uk") == null ? "" : request.getParameter("uk");
		
		String telnum = "";
		String postNum = "";
		
		if(!tel1.equals("")){
			telnum = tel1 + "-" + tel2 + "-" + tel3;
		}
		
		if(!post1.equals("")){
			postNum = post1 + post2;
		}
		
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("tel", telnum);
		param.put("address1", addr1);
		param.put("address2", addr2);
		param.put("postalCode", postNum);
		param.put("id", um.getId());
		
		int rw = sqlsession.update("renew_mypage.set_my_info", param);
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		if(rw > 0){
			// 키워드 변경
			if(uk.length() > 0){
				String[] value = uk.split(",");
				
				// 트랜잭션처리
				DefaultTransactionDefinition def = new DefaultTransactionDefinition();
				// explicitly setting the transaction name is something that can only be done programmatically
				def.setName("user-keyword-transaction");
				def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
				
				TransactionStatus status = txManager.getTransaction(def);
				
				try {
					HashMap<String, Object> del_param = new HashMap<String, Object>();
					del_param.put("uid", um.getId());
					sqlsession.delete("renew_mypage.del_user_keywords", del_param);
					
					for(int i = 0 ; i < value.length; i++){
						HashMap<String, Object> insert_param = new HashMap<String, Object>();
						insert_param.put("uid", um.getId());
						insert_param.put("keywordId", value[i]);
						
						sqlsession.insert("renew_mypage.add_user_keywords", insert_param);
					}
					
				}catch(Exception e){
					txManager.rollback(status);
					throw e;
				}finally{
					txManager.commit(status);
				}
			}
			
			
			json.put("code", rw);
			json.put("msg", MessageHandler.getMessage("mypage.myinfo.modified"));
		}else{
			json.put("code", "-1000");
			json.put("msg", MessageHandler.getMessage("givus.global.error"));
		}
		
		mv.addObject("result", json.toJSONString());
		
		
		return mv;
	}
	
	
	
	@RequestMapping( value="/mypage/contact", method = RequestMethod.GET)
	public ModelAndView contact(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("givus_v2/mypage/contact");
		
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
	
	
	@RequestMapping( value="/mypage/contact/write", method = RequestMethod.GET)
	public ModelAndView contact_write(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("givus_v2/mypage/contact_write");

		return mv;
	}
	
	@RequestMapping( value="/mypage/contact/delete", method = RequestMethod.POST)
	public ModelAndView contact_delete(HttpServletRequest request, HttpServletResponse response) throws Exception{		

		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		if(um!=null){
			if(um.getEmail() != null){
				String[] ids = request.getParameterValues("ids[]");

				// 유효성검사
				for(int i = 0 ; i < ids.length ; i++){			
					if(!GivusUtil.isNumber(ids[i])){
						json.put("code", "2");
						json.put("msg", MessageHandler.getMessage("mypage.board.check.isnan"));
						
						mv.addObject("result", json.toJSONString());
						return mv;
					}
				}
				
				StringBuilder sb = new StringBuilder();
				
				for(int k=0; k < ids.length; k++){
					sb.append(ids[k]);
					sb.append(",");
				}
				
				String id_string = sb.substring(0, sb.length()-1);
				
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("ids", id_string);
				param.put("userId" , um.getId());
				
				int rw = sqlsession.update("del_user_contact", param);
				if(rw > 0){
					json.put("code", "0");
					json.put("msg", MessageHandler.getMessage("mypage.contact.delete"));
				}else{
					json.put("code", "-1999");
					json.put("msg", MessageHandler.getMessage("givus.global.error"));
				}
			}
		}
		
		mv.addObject("result", json.toJSONString());
		
		
		
		return mv;
	}
	
	@RequestMapping( value="/mypage/contact/view/{id}", method = RequestMethod.GET)
	public ModelAndView contact_view(@PathVariable Integer id, HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("givus_v2/mypage/contact_view");

		UserModel um = (UserModel) SessionContext.getUserModel();
		
		if(um!=null){
			if(um.getEmail() != null){
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("id", id);
				param.put("uid", um.getId());
				HashMap<String, Object> contact = sqlsession.selectOne("renew_mypage.get_user_contact_view", param);
				
				mv.addObject("contact", contact);
			}
		}
		
		return mv;
	}
	
	
	
	@RequestMapping( value="/mypage/contact/writeproc", method = RequestMethod.POST)
	public ModelAndView contact_writeproc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		if(um!=null){
			if(um.getEmail() != null){
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("title", title);
				param.put("content", content);
				param.put("uid", um.getId());
				
				int rw = sqlsession.insert("renew_mypage.add_user_contact", param);
				
				if(rw > 0){
					json.put("code" ,"0");
					json.put("msg", MessageHandler.getMessage("mypage.contact.success"));
				}else{
					json.put("code" ,"-1002");
					json.put("msg", MessageHandler.getMessage("mypage.contact.failed"));
				}
			}else{
				json.put("code" ,"-1001");
				json.put("msg", MessageHandler.getMessage("authrity.error.inquiry.nosession"));	
			}			
		}else{
			json.put("code" ,"-1001");
			json.put("msg", MessageHandler.getMessage("authrity.error.inquiry.nosession"));
		}
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
	@RequestMapping( value="/mypage/chpass", method = RequestMethod.GET)
	public ModelAndView chpass(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/mypage/chpass");
		//login_check
		
		return mv;
	}
	
	@RequestMapping( value="/mypage/chpassproc", method = RequestMethod.GET)
	public ModelAndView chpassproc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String old_pass = request.getParameter("old_pass");
		String pass = request.getParameter("pass");
		
		byte[] decoded_old_pass = Base64.decodeBase64(old_pass.getBytes());
		byte[] decoded_pass = Base64.decodeBase64(pass.getBytes());
		
		String oldPassDecoded = new String(decoded_old_pass, "UTF-8");
		String newPassDecoded = new String(decoded_pass, "UTF-8");
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		if(oldPassDecoded.equals(newPassDecoded)){
			json.put("code", "-1002");
			json.put("msg", MessageHandler.getMessage("mypage.chpass.pass.same"));
		}else{
			UserModel um = (UserModel) SessionContext.getUserModel();
			
			HashMap<String, String> param = new HashMap<String, String>();
			param.put("email", um.getEmail());
			param.put("pass", new String(decoded_old_pass, "UTF-8"));
			
			//login_check
			HashMap<String, Object> user = sqlsession.selectOne("renew_member.login_check", param);
			
			if(user != null){
				HashMap<String, Object> ch_param = new HashMap<String, Object>();
				ch_param.put("pass", new String(decoded_pass, "UTF-8"));
				ch_param.put("id", um.getId());
				
				int rw = sqlsession.update("renew_mypage.change_password", ch_param);
				if(rw > 0){
					json.put("code", "0");
					json.put("msg", MessageHandler.getMessage("mypage.chpass.pass.changed"));
				}
				
			}else{
				json.put("code", "-1001");
				json.put("msg", MessageHandler.getMessage("mypage.chpass.pass.notcorrect"));
			}
		}
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
	@RequestMapping( value="/mypage/withraw", method = RequestMethod.GET)
	public ModelAndView withraw(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/mypage/withraw");
		//login_check
		
		return mv;
	}
	
	@RequestMapping( value="/mypage/withraw/send", method = RequestMethod.POST)
	public ModelAndView withraw_wait(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String reason1 = request.getParameter("reason_1");
		String reason2 = request.getParameter("reason_2");
		String reasonText= request.getParameter("reasonText");
		String agree = request.getParameter("user_agree");
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		if(um!=null){
			if(um.getEmail() != null){
				
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("reason1", reason1);
				param.put("reason2", reason2);
				param.put("reasonText", reasonText);

				param.put("agree", agree);
				param.put("uid", um.getId());
				
				int rw = sqlsession.update("renew_mypage.add_withraw", param);
				
				if(rw > 0){
					HashMap<String, Object> w_param = new HashMap<String, Object>();
					w_param.put("id", um.getId());
					
					int u = sqlsession.update("renew_mypage.user_withraw_wait", w_param);
					
					if(u > 0){
						json.put("code", "0");
						json.put("msg",  MessageHandler.getMessage("mypage.withraw.send"));
						
						request.getSession().invalidate();
						
					}else{
						json.put("code", "-1002");
						json.put("msg",  MessageHandler.getMessage("mypage.withraw.send.error"));
					}
				}else{
					json.put("code", "-1002");
					json.put("msg",  MessageHandler.getMessage("mypage.withraw.send.error"));
				}
				
			}else{
				json.put("code", "-1001");
				json.put("msg", MessageHandler.getMessage("authrity.error.inquiry.nosession"));
			}
		}else{
			json.put("code", "-1001");
			json.put("msg", MessageHandler.getMessage("authrity.error.inquiry.nosession"));
		}
		
		
		mv.addObject("result", json.toJSONString());

		return mv;
	}
	
	
	
	
	// 병원회원 Controller
	
	// 병원조회
	@RequestMapping( value="/mypage/myhinfo", method = RequestMethod.GET)
	public ModelAndView getMyHospital(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/mypage/hospital_info");
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("uid", um.getId());
		HashMap<String, Object> my_hospital = sqlsession.selectOne("renew_mypage.get_my_hospital", param);
		
		List<HashMap<String, Object>> location = sqlsession.selectList("admin_hospital.get_location", param);
		
		mv.addObject("uh" ,my_hospital);
		mv.addObject("location" ,location);
		
		return mv;
	}
	
	// 병원소개 변경
	@RequestMapping( value="/mypage/myhintro", method = RequestMethod.GET)
	public ModelAndView getMyHosIntro(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/mypage/hospital_intro");
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("uid", um.getId());
		HashMap<String, Object> my_hospital = sqlsession.selectOne("renew_mypage.get_my_hospital", param);
		
		int hid = (Integer)my_hospital.get("id");
		
		param.put("hid", hid);
		
		HashMap<String, Object> hos_stat = sqlsession.selectOne("renew_mypage.get_my_hos_stat", param);
		
		List<HashMap<String, Object>> location = sqlsession.selectList("admin_hospital.get_location", param);
		
		// 썸네일조회 get_hospital_thumb
		HashMap<String, Object> thumb_p = new HashMap<String, Object>();
		thumb_p.put("hid", hid);
		HashMap<String, Object> thumbId = sqlsession.selectOne("renew_hospital.get_hospital_thumb",thumb_p);
		if(thumbId != null){
			if(thumbId.get("id") != null)
				my_hospital.put("fid", thumbId.get("id"));
		}
		
		// 썸네일 5개 조회
		List<HashMap<String, Object>> thumbList = sqlsession.selectList("renew_hospital.get_hospital_thumb5", thumb_p);
		
		mv.addObject("thumb5", thumbList);		
		mv.addObject("location", location);
		mv.addObject("hospital" ,my_hospital);
		mv.addObject("hos_stat" ,hos_stat);
		
		return mv;
	}
	
	
	// 병원소개 변경
	@RequestMapping( value="/mypage/myhmod", method = RequestMethod.POST)
	public String mod_myhospital(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String hid = request.getParameter("hid");
		
		String tel1 = request.getParameter("tel1") == null ? "" : request.getParameter("tel1");
		String tel2 = request.getParameter("tel2") == null ? "" : request.getParameter("tel2");
		String tel3 = request.getParameter("tel3") == null ? "" : request.getParameter("tel3");
		
		String fax = request.getParameter("fax") == null ? "" : request.getParameter("fax");
		
		String post1 = request.getParameter("post1") == null ? "" : request.getParameter("post1");
		String post2 = request.getParameter("post2") == null ? "" : request.getParameter("post2");
		
		String addr1 = request.getParameter("addr1") == null ? "" : request.getParameter("addr1");
		String addr2 = request.getParameter("addr2") == null ? "" : request.getParameter("addr2");
		
		String homepage = request.getParameter("homepage")  == null ? "" : request.getParameter("homepage");
		String location = request.getParameter("location")  == null ? "" : request.getParameter("location");
		
		String business_id = request.getParameter("business_id")  == null ? "" : request.getParameter("business_id");
		
//		UPDATE Hospital SET
//		tel = #{tel}, fax = #{fax}, homepage = #{homepage}, address = #{address}, address1 = #{address1}, address2 = #{address2},
//		locationCode = #{locationCode}, business_id = #{business_id}, postalCode = #{postalCode}
//		WHERE id = #{hid};
		
		//change_hos_info_basic
		
		String tel = tel1 + "-" + tel2 + "-" + tel3;
		String post = post1 + "-" + post2;
		String address = addr1 + " " + addr2;
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("tel", tel);
		param.put("fax", fax);
		param.put("homepage", homepage);
		param.put("address", address);
		param.put("address1", addr1);
		param.put("address2", addr2);
		param.put("locationCode", location);
		param.put("business_id", business_id);
		param.put("postalCode", post);
		param.put("hid", hid);
		
		
		sqlsession.update("renew_mypage.change_hos_info_basic", param);
		
		return "redirect:/___/renew/mypage/myhinfo";
	}
	
	@RequestMapping( value="/mypage/myhintromod", method = RequestMethod.POST)
	public String mod_myhospital_intro(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String hid = request.getParameter("hid");
		
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
		
		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		// explicitly setting the transaction name is something that can only be done programmatically
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = txManager.getTransaction(def);
		
		try {		
			// 병원정보입력
			HashMap<String, Object> addH_param = new HashMap<String, Object>();
			
			addH_param.put("introduction", intro);
			addH_param.put("specialistCount", Integer.parseInt(sp_count));
			addH_param.put("anestheticCount", Integer.parseInt(an_count));
			
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
			
			addH_param.put("hid", hid);
			
			sqlsession.update("renew_mypage.change_hos_intro", addH_param);
		
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
			
			txManager.commit(status);
			
		}catch(Exception e){			
			txManager.rollback(status);			
		}
		
		return "redirect:/___/renew/mypage/myhintro";
	}
	
	// 수술가격 변경폼
	@RequestMapping( value="/mypage/myhprice", method = RequestMethod.GET)
	public ModelAndView mod_hospital_price(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/mypage/hospital_price");
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		if(um!=null){
			if(um.getEmail() != null){
				
				int hid = um.getHospitalId();
				
//				System.out.println("hid= " + hid);
				
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
//							break;
						}				
					}
				}
				
				mv.addObject("list", surg);
				mv.addObject("hid", hid);
			}else{
				mv.setViewName("redirect:/___/renew/main");
			}
		}else{
			mv.setViewName("redirect:/___/renew/main");
		}
		
		return mv;
	}
	
	//  병원 가격정보 수정
	@RequestMapping( value="/mypage/modhprice", method = RequestMethod.POST)
	public String mod_hospital_price_proc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String mv = "redirect:/___/renew/mypage/myhprice";
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		if(um!=null){
			if(um.getEmail() != null){
				int hid = um.getHospitalId();
				
				// 트랜잭션처리
				DefaultTransactionDefinition def = new DefaultTransactionDefinition();
				def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);		
				TransactionStatus status = txManager.getTransaction(def);
				
				try {			
				
					String[] price = request.getParameterValues("price");
					String[] operId = request.getParameterValues("operId");
					String[] oName = request.getParameterValues("oname");
					
					for(int i = 0 ; i < price.length; i++){
						
						if(!price[i].equals("")){
							HashMap<String, Object > param = new HashMap<>();
							param.put("price", Integer.parseInt(price[i]));
							param.put("oid", Integer.parseInt(operId[i]));
							param.put("hid", hid);
							param.put("oname", oName[i]);
							
							sqlsession.update("admin_hospital.set_price", param);	
							
//							System.out.println(param.toString());
						}else{
							HashMap<String, Object > param = new HashMap<>();
							param.put("price", 0);
							param.put("oid", Integer.parseInt(operId[i]));
							param.put("hid", hid);
							param.put("oname", oName[i]);
							
							sqlsession.update("admin_hospital.set_price", param);
						}
					}
				
					txManager.commit(status);
				
				}catch(Exception e){			
					txManager.rollback(status);
					
					System.out.println(e.toString());
				}
				
			}else{
				return "redirect:/___/renew/main";
			}
		}else{
			return "redirect:/___/renew/main";
		}
		
		return mv;
	}
}
