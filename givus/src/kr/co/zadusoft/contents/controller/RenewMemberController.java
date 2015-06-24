package kr.co.zadusoft.contents.controller;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.UserModel;

import org.apache.commons.codec.binary.Base64;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dynamic.web.util.MessageHandler;
import dynamic.web.util.SessionContext;

@Controller
@RequestMapping(value="/___/renew")
public class RenewMemberController{

	@Autowired
	private SqlSession sqlsession;
	
	// 로그인폼
	@RequestMapping( value="/login", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("givus_v2/member/login");
		//login_check
		
		return mv;
	}
	
	@RequestMapping( value="/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mav = new ModelAndView("redirect:/___/renew/main");
		request.getSession().invalidate();
		
		Cookie[] cookies = request.getCookies();
		
		for(int i = 0 ; i < cookies.length ; i++){
			Cookie cok = cookies[i];
			if(cok.getName().equals("userkey")){
				cok.setMaxAge(0);
				response.addCookie(cok);
			}
			if(cok.getName().equals("useremail")){
				cok.setMaxAge(0);
				response.addCookie(cok);
			}			
			
		}
		
		return mav;
	}
	
	// 자동 로그인
	@RequestMapping( value="/autologin", method = RequestMethod.POST)
	public ModelAndView autologin(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String useremail = null;
		String userkey = null;
		Cookie[] coks = request.getCookies();
		for(int i = 0 ; i < coks.length ; i++){
			if(coks[i].getName().equals("useremail")){
				useremail = coks[i].getValue();
			}else if(coks[i].getName().equals("userkey")){
				userkey = coks[i].getValue();
			}
		}
		
		if(useremail != null && userkey != null){
			byte[] decodedPass = Base64.decodeBase64(userkey.getBytes());
			
			System.out.println(new String(decodedPass, "UTF-8"));
			
			HashMap<String, String> param = new HashMap<String, String>();
			param.put("email", useremail);
			param.put("login_key", new String(decodedPass, "UTF-8"));
			HashMap<String, Object> user = sqlsession.selectOne("renew_member.autologin_check", param);
			
			// 로그인 로그
			HashMap<String, Object> login_log_param = new HashMap<>();
			login_log_param.put("userId", user.get("id"));
			login_log_param.put("ipaddress", request.getRemoteAddr());
			login_log_param.put("user_email", useremail);
			
			if(user != null){			
				UserModel um = new UserModel();
				um.setEmail(user.get("email").toString());
				um.setAccount(user.get("account").toString());
				um.setBirthday(user.get("birthday").toString());
				um.setGender(user.get("gender").toString());
				um.setIsFbUser(user.get("is_fbuser").toString()); 
				um.setId((Integer)user.get("id"));
				um.setUserType(user.get("userType").toString());
				
				if(um.getUserType().equals("H")){
					um.setHospitalAccepted(user.get("status").toString());
					um.setHospitalId((Integer)user.get("hospitalId"));
				}
				
				// 세션 설정
				SessionContext.setUserModel(um);
				
				// 새로운키로 교체
				SecureRandom rand = new SecureRandom();
				String key = new BigInteger(130, rand).toString();
				// 키 업데이트
				HashMap<String, String> add_key = new HashMap<String, String>();
				add_key.put("key", key);
				add_key.put("email", useremail);
				int rrs = sqlsession.update("update_user_key", add_key);
				
				byte[] encKey = Base64.encodeBase64(key.getBytes());
				
				if(rrs == 1){
					Cookie newkey = new Cookie("userkey", new String( encKey ));					
					Cookie cok_email = new Cookie("useremail", useremail);
					// 100년유지
					newkey.setMaxAge(60 * 60 * 24 * 365 * 100 );
					cok_email.setMaxAge(60 * 60 * 24 * 365 * 100 );
					
					response.addCookie(newkey);
					response.addCookie(cok_email);					
				}	
				
				login_log_param.put("login_error", "사용자 자동 로그인 성공");
				login_log_param.put("is_suc", true);
				sqlsession.insert("renew_member.login_log", login_log_param);
				
				json.put("code", "0");
				json.put("msg", MessageHandler.getMessage("login.success"));
			}else{
				login_log_param.put("login_error", "사용자 자동 로그인 실패");
				login_log_param.put("is_suc", false);
				sqlsession.insert("renew_member.login_log", login_log_param);
				
				json.put("code", "-1003");
				json.put("msg",MessageHandler.getMessage("login.failed") );
			}
		}else{
			
			// 로그인 로그
			HashMap<String, Object> login_log_param = new HashMap<>();
			login_log_param.put("userId", -1);
			login_log_param.put("user_email", useremail);
			login_log_param.put("ipaddress", request.getRemoteAddr());
			login_log_param.put("login_error", "사용자 자동 로그인 실패, 사용자 로그인키 또는 이메일이 없음");
			login_log_param.put("is_suc", false);
			sqlsession.insert("renew_member.login_log", login_log_param);
			
			json.put("code", "-1004");
			json.put("msg", "Not auto login");
		}
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
	@RequestMapping( value="/loginproc", method = RequestMethod.POST)
	public ModelAndView login_proc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
		String autologin = request.getParameter("auto");
		
		byte[] decodedPass = Base64.decodeBase64(pass.getBytes());
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("email", email);
		param.put("pass", new String(decodedPass, "UTF-8"));
		
		//login_check
		HashMap<String, Object> user = sqlsession.selectOne("renew_member.login_check", param);
		
		// 로그인 로그
		HashMap<String, Object> login_log_param = new HashMap<>();
		login_log_param.put("userId", user.get("id"));
		login_log_param.put("ipaddress", request.getRemoteAddr());
		login_log_param.put("user_email", email);
		
		if(user != null){			
			if(autologin.equals("Y")){
				SecureRandom rand = new SecureRandom();
				String key = new BigInteger(130, rand).toString();
				
				System.out.println(key);
				// 키 업데이트
				HashMap<String, String> add_key = new HashMap<String, String>();
				add_key.put("key", key);
				add_key.put("email", email);
				int rrs = sqlsession.update("update_user_key", add_key);
				
				byte[] encKey = Base64.encodeBase64(key.getBytes());
				
				if(rrs == 1){
					Cookie userkey = new Cookie("userkey", new String( encKey ));					
					Cookie useremail = new Cookie("useremail", email);
					// 100년유지
					userkey.setMaxAge(60 * 60 * 24 * 365 * 100 );
					useremail.setMaxAge(60 * 60 * 24 * 365 * 100 );
					
					response.addCookie(userkey);
					response.addCookie(useremail);					
				}				
			} // 자동 로그인쪽
			
			
			UserModel um = new UserModel();
			um.setEmail(user.get("email").toString());
			um.setAccount(user.get("account").toString());
			um.setBirthday(user.get("birthday").toString());
			um.setGender(user.get("gender").toString());
			um.setIsFbUser(user.get("is_fbuser").toString());
			um.setId((Integer)user.get("id"));
			um.setUserType(user.get("userType").toString());
			
			if(um.getUserType().equals("H")){
				um.setHospitalAccepted(user.get("status").toString());
				um.setHospitalId((Integer)user.get("hospitalId"));
			}
			
			login_log_param.put("is_suc", true);
			login_log_param.put("login_error", "사용자 로그인 성공");
			sqlsession.insert("renew_member.login_log", login_log_param);
			
			// 세션 설정
			SessionContext.setUserModel(um);
			
			json.put("code", "0");
			json.put("msg", MessageHandler.getMessage("login.success"));
		}else{
			
			login_log_param.put("is_suc", false);
			login_log_param.put("login_error", "아이디 비밀번호가 맞지 않음");
			sqlsession.insert("renew_member.login_log", login_log_param);
			
			json.put("code", "-1002");
			json.put("msg",MessageHandler.getMessage("login.failed") );
		}
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
	@RequestMapping( value="/loginprocfb", method = RequestMethod.POST)
	public ModelAndView login_proc_facebook(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String email = request.getParameter("email");
		String facebook_id = request.getParameter("facebook_id");
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("email", email);
		param.put("facebook_id", facebook_id);
		
		//login_check
		HashMap<String, Object> user = sqlsession.selectOne("renew_member.login_check_facebook", param);
		
		// 로그인 로그
		HashMap<String, Object> login_log_param = new HashMap<>();
		login_log_param.put("userId", user.get("id"));
		login_log_param.put("ipaddress", request.getRemoteAddr());
		login_log_param.put("user_email", email);
		
		if(user != null){						
			UserModel um = new UserModel();
			um.setEmail(user.get("email").toString());
			um.setAccount(user.get("account").toString());
			um.setBirthday(user.get("birthday").toString());
			um.setGender(user.get("gender").toString());
			um.setIsFbUser(user.get("is_fbuser").toString());
			um.setId((Integer)user.get("id"));
			um.setUserType(user.get("userType").toString());
			
			if(um.getUserType().equals("H")){
				um.setHospitalAccepted(user.get("status").toString());
				um.setHospitalId((Integer)user.get("hospitalId"));
			}
			
			// 세션 설정
			SessionContext.setUserModel(um);
			
			login_log_param.put("is_suc", true);
			login_log_param.put("login_error", "페이스북 로그인 성공");
			sqlsession.insert("renew_member.login_log", login_log_param);
			
			json.put("code", "0");
			json.put("msg", MessageHandler.getMessage("login.success"));
		}else{
			
			login_log_param.put("is_suc", false);
			login_log_param.put("login_error", "페이스북 아이디가 맞지않음");
			sqlsession.insert("renew_member.login_log", login_log_param);
			
			json.put("code", "-1002");
			json.put("msg",MessageHandler.getMessage("login.failed") );
		}
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}

	@RequestMapping( value="/find", method = RequestMethod.GET)
	public ModelAndView findpass(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("givus_v2/member/find");		
		return mv;
	}
	
	@RequestMapping( value="/findproc", method = RequestMethod.GET)
	public ModelAndView findpass_proc(HttpServletRequest request, HttpServletResponse response) throws Exception{				
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		return mv;
	}
	
	@RequestMapping( value="/join", method = RequestMethod.GET)
	public ModelAndView join(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("givus_v2/member/join");	
		return mv;
	}
	
	@RequestMapping( value="/joinproc", method = RequestMethod.POST)
	public ModelAndView join_proc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String email = request.getParameter("email");
		String nick = request.getParameter("nick");
		String pass = request.getParameter("pass");
		String gender = request.getParameter("gender");
		String birth = request.getParameter("birth");
		
		byte[] decodedPass = Base64.decodeBase64(pass.getBytes());
//		System.out.println(new String(decodedPass, "UTF-8") + "\n");
		
		HashMap<String, String> check_param = new HashMap<String, String>();
		check_param.put("email", email);
		check_param.put("name", nick );
		
		int e_cnt = sqlsession.selectOne("renew_member.email_check", check_param);
		int n_cnt = sqlsession.selectOne("renew_member.nick_check", check_param);
		
		if(e_cnt > 0){
			json.put("code","-1001");
			json.put("msg", MessageHandler.getMessage("join.email.exist"));
		}else if(n_cnt > 0){
			json.put("code","-1002");
			json.put("msg", MessageHandler.getMessage("join.nick.exist"));
		}else{
//			#{email}, #{name}, #{name}, now(), password(#{password}), #{userType}, #{birthday}, #{gender}, #{userStatus}, #{is_fbuser}
			
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("email", email);
			param.put("name", nick);
			param.put("password", new String(decodedPass, "UTF-8"));
			param.put("userType", "G");
			param.put("birthday", birth);
			param.put("gender", gender);
			param.put("userStatus", "A");
			param.put("is_fbuser", "N");
			
			int rs = sqlsession.insert("renew_member.add_user", param);
			
			if(rs == 1){
				json.put("code","0");
				json.put("msg", MessageHandler.getMessage("join.success"));

				UserModel um = new UserModel();
				um.setEmail(email);
				um.setAccount(nick);
				um.setBirthday(birth);
				um.setGender(gender);
				um.setIsFbUser("N");
				um.setId((Integer)param.get("id"));
				um.setUserType("G");
				
				
				// 세션 설정
				SessionContext.setUserModel(um);
				
			}else{
				json.put("code","-9999");
				json.put("msg", MessageHandler.getMessage("givus.global.error"));
			}
		}
		
		mv.addObject("result", json.toJSONString());
		
		
		return mv;
	}
	
	@RequestMapping( value="/joinprocfb", method = RequestMethod.POST)
	public ModelAndView join_proc_fb(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String email = request.getParameter("email");
		String nick = request.getParameter("nick");
		String gender = request.getParameter("gender");
		String birth = request.getParameter("birth");
		String facebook_id = request.getParameter("facebook_id");
		
		HashMap<String, String> check_param = new HashMap<String, String>();
		check_param.put("email", email);
		
		HashMap<String, String> check_param2 = new HashMap<String, String>();
		check_param2.put("nick", nick);
		
		int e_cnt = sqlsession.selectOne("renew_member.email_check", check_param);
		int n_cnt = sqlsession.selectOne("renew_member.email_check", check_param2);
		
		if(e_cnt > 0 || n_cnt > 0){
			if(e_cnt > 0){
				json.put("code","-1001");
				json.put("msg", MessageHandler.getMessage("join.email.exist"));
			}else if(n_cnt > 0){
				json.put("code","-1002");
				json.put("msg", MessageHandler.getMessage("join.nick.exist"));
			}
		}else{
			//#{email}, #{name}, #{name}, now(), #{userType}, #{birthday}, #{gender}, #{userStatus}, #{is_fbuser}, #{facebook_id}
			
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("email", email);
			param.put("name", nick);			
			param.put("userType", "G");
			param.put("birthday", birth);
			param.put("gender", gender);
			param.put("userStatus", "A");
			param.put("is_fbuser", "Y");
			param.put("facebook_id", facebook_id);
			
			int rs = sqlsession.insert("renew_member.add_user_fb", param);
			
			if(rs == 1){
				json.put("code","0");
				json.put("msg", MessageHandler.getMessage("join.success"));

				UserModel um = new UserModel();
				um.setEmail(email);
				um.setAccount(nick);
				um.setBirthday(birth);
				um.setGender(gender);
				um.setIsFbUser("Y");
				um.setFacebookId(facebook_id);
				um.setId((Integer)param.get("id"));
				um.setUserType("G");
				
				// 세션 설정
				SessionContext.setUserModel(um);
				
			}else{
				json.put("code","-9999");
				json.put("msg", MessageHandler.getMessage("givus.global.error"));
			}
		}
		
		mv.addObject("result", json.toJSONString());
		
		
		return mv;
	}
	
		
}
