package kr.co.zadusoft.contents.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.UserModel;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sun.org.apache.xml.internal.security.utils.Base64;

import dynamic.web.util.SessionContext;

@Controller
@RequestMapping(value="/___/admin")
public class RenewAdminLoginController{

	@Autowired
	private SqlSession sqlsession;
	
	
	@RequestMapping( value="/login", method = RequestMethod.GET)
	public ModelAndView login_view(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("admin/login");
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		if(um != null){
			if(um.getEmail() != null){
				if(um.getUserType().equals("M")){
					return new ModelAndView("redirect:/___/admin/main");
				}
			}
		}

		return mv;
	}
	
	@RequestMapping( value="/loginproc", method = RequestMethod.POST)
	public ModelAndView loginproc(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();

		String email = request.getParameter("email");
		String pass = request.getParameter("pass");
		
		byte[] pass_decode =  Base64.decode(pass.getBytes());
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("email", email);
		param.put("pass", new String(pass_decode, "UTF-8"));
		
		//login_check
		HashMap<String, Object> user = sqlsession.selectOne("renew_member.login_check", param);
		
		// 로그인 로그
		HashMap<String, Object> login_log_param = new HashMap<>();
		login_log_param.put("userId", user.get("id"));
		login_log_param.put("ipaddress", request.getRemoteAddr());
		login_log_param.put("user_email", email);
		
		if(user != null){
			
			if(user.get("userType").toString().equals("M")){
				
				UserModel um = new UserModel();
				um.setEmail(user.get("email").toString());
				um.setAccount(user.get("account").toString());
				um.setBirthday(user.get("birthday").toString());
				um.setGender(user.get("gender").toString());
				um.setIsFbUser(user.get("is_fbuser").toString());
				um.setId((Integer)user.get("id"));
				um.setUserType(user.get("userType").toString());
				
				SessionContext.setUserModel(um);
					
				login_log_param.put("login_error", "관리자 로그인 성공");
				login_log_param.put("is_suc", true);
				sqlsession.insert("renew_member.login_log", login_log_param);
				
				json.put("code", "0");
				
			}else{
				login_log_param.put("login_error", "관리자가 아닌 계정이 관리자로 접근");
				login_log_param.put("is_suc", false);
				sqlsession.insert("renew_member.login_log", login_log_param);
				
				json.put("code", "-1001");
				json.put("msg", "관리자가 아닙니다.");				
			}
			
		}else{
			login_log_param.put("login_error", "아이디 비밀번호 가 맞지않음");
			sqlsession.insert("renew_member.login_log", login_log_param);
			
			json.put("code", "-1002");
			json.put("msg", "아이디 또는 비밀번호가 맞지 않습니다.");
		}
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
}
