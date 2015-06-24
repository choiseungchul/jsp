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
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/___/admin")
public class RenewAdminUserController{

	@Autowired
	private SqlSession sqlsession;
	
	@Resource(name = "txManager")
	protected DataSourceTransactionManager txManager;
	
	// 병원목록보기
	@RequestMapping( value="/user/list", method = RequestMethod.GET)
	public ModelAndView popular_newsbox(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("admin/user/list");

		String pnum = request.getParameter("PN");
		String srch_code = request.getParameter("SC");
		String srch_text = request.getParameter("ST");
		
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
		
		List<HashMap<String, Object>> list = sqlsession.selectList("admin_user.get_list", param);
		int totalCount = sqlsession.selectOne("admin_user.get_count", param);
		
		mv.addObject("list", list);
		mv.addObject("listCount", listCount);
		mv.addObject("total" , totalCount);
		mv.addObject("p", Integer.parseInt(pnum));
		
		return mv;
	}
	
	@RequestMapping(value="/user/modproc", method=RequestMethod.POST)
	public String ajax_user_mod(HttpServletRequest request, HttpServletResponse response) throws Exception{
	
		// 트랜잭션처리
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);		
		TransactionStatus status = txManager.getTransaction(def);
		
		String uid = request.getParameter("uid");
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		String birthday = request.getParameter("birthday");
		
		String userStatus = request.getParameter("userStatus");
		String userType = request.getParameter("userType");
		
		String hcstat = request.getParameter("hcstat");
		
		try {					
			HashMap<String, Object> mod_param = new HashMap<String, Object>();
			mod_param.put("name", name);
			mod_param.put("email", email);
			mod_param.put("gender", gender);
			mod_param.put("birthday", birthday);
			mod_param.put("userStatus", userStatus);
			mod_param.put("userType", userType);
			mod_param.put("uid", uid);
			
			sqlsession.update("admin_user.update_user", mod_param);
			
			if(hcstat != null){
				HashMap<String, Object> mod_hos_connect = new HashMap<>();
				mod_hos_connect.put("uid", uid);
				mod_hos_connect.put("status", hcstat);
				
				sqlsession.update("admin_user.update_hcstat", mod_hos_connect);
			}
			
			txManager.commit(status);
		
		}catch(Exception e){			
			txManager.rollback(status);
			
			System.out.println(e.toString());
		}
		
		return "redirect:/___/admin/user/mod/" + uid + "/?pnum=1";
	}
	
	//병원 수정하기
	@RequestMapping( value="/user/mod/{uid}", method = RequestMethod.GET)
	public ModelAndView getview(@PathVariable Integer uid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("admin/user/mod");
		
		String pnum = request.getParameter("pnum");
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("uid", uid);
		
		HashMap<String, Object> user_info = sqlsession.selectOne("admin_user.get_one", param);
		
		mv.addObject("user_info", user_info);		
		
		mv.addObject("pnum", pnum);
		
		return mv;
	}
	
}
