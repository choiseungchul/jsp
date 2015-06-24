package kr.co.zadusoft.contents.controller;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.UserModel;
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
import dynamic.web.util.SessionContext;
import dynamic.web.util.SessionContext.LoginInfo;

@Controller
@RequestMapping(value="/___/renew")
public class RenewCommentController{

	@Autowired
	private SqlSession sqlsession;
	
	@RequestMapping( value="/comment/{articleId}", method = RequestMethod.GET)
	public ModelAndView comment(@PathVariable Integer articleId, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("pid", articleId);
		
		String start = request.getParameter("start");
		int stIdx = 0;
		if(start != null){
			stIdx = Integer.parseInt(start);
		}
		param.put("start", stIdx);
		param.put("end", 15);
		
		
		HashMap<String, Object> get_cnt = new HashMap<String, Object>();
		get_cnt.put("pid", articleId);
		int totalCount = sqlsession.selectOne("renew_board.get_hospital_view_cnt", get_cnt);
		
		List<HashMap<String, Object>> comments = sqlsession.selectList("renew_board.get_board_comment", param);
		
		StringBuffer sb = new StringBuffer();
		
		for(int i = 0 ; i < comments.size(); i++){
			HashMap<String, Object> data = comments.get(i);
			
			long compared = new Date().getTime() - ((Date)data.get("createDate")).getTime();
			
			String timetext = "";
			if(compared <= 1000 * 60 * 60 * 24 * 7 ){
				timetext = GivusUtil.parseRelativeDate((Date)data.get("createDate")) + "전";
			}else{
				timetext = ((Date)data.get("createDate")).toString();
			}
			
			data.put("createDate", timetext);
			comments.set(i, data);
			
			sb.append(data.get("id"));
			sb.append(",");
		}
		
		if(sb.length() > 1){
			HashMap<String, Object> param_re = new HashMap<String, Object>();
			param_re.put("pid", articleId);
			param_re.put("ids", sb.substring(0, sb.length() -1));
			List<HashMap<String, Object>> comments_re = sqlsession.selectList("renew_board.get_board_comment_re", param_re);
			comments_re = GivusUtil.parseRelativeDate(comments_re);
			
			json.put("comments_re", comments_re);
		}
		
		json.put("comments", comments);		
		json.put("next", stIdx+15);
		json.put("total", totalCount);
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
	@RequestMapping( value="/comment/add", method = RequestMethod.POST)
	public ModelAndView add(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String userId = null;
		String postingId = request.getParameter("postingId");
		String comment = request.getParameter("comment");
		String parentId = request.getParameter("parentId");
		
		UserModel login = (UserModel)SessionContext.getUserModel();
		
		if(login != null){
			
			if(login.getEmail() != null){
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("userId", login.getAccount());
				param.put("postingId", postingId);
				param.put("comment", comment);
				if(parentId != null)
				param.put("parentId", parentId);
				
				int id = sqlsession.insert("renew_board.add_comment", param);
				
				System.out.println("add comment insert id = " + id);
				
				// 댓글 카운트 증가
				sqlsession.update("add_comment_count", postingId);
				
				// 업데이트 시간 변경
				sqlsession.update("renew_etc.main_updatetime_set");
				
				json.put("code", "0");
				json.put("id", id);
				
			}else{
				
				json.put("code", "-1000");
				json.put("msg", MessageHandler.getMessage("posting.msg.recommend_needlogin"));
				
			}
			
			mv.addObject("result", json.toJSONString());
			
			return mv;
			
//			if(!login.getAccount().equals("anonymous")){
//				HashMap<String, Object> param = new HashMap<String, Object>();
//				param.put("userId", login.getAccount());
//				param.put("postingId", postingId);
//				param.put("comment", comment);
//				if(parentId != null)
//				param.put("parentId", parentId);
//				
//				int id = sqlsession.insert("renew_board.add_comment", param);
//				
//				JSONObject json = new JSONObject();
//				json.put("code", "0");
//				json.put("id", id);
//				
//				mv.addObject("result", json.toJSONString());
//				
//				return mv;
//			}else{
//				
//				JSONObject json = new JSONObject();
//				json.put("code", "-1000");
//				json.put("msg", "not login");
//				
//				mv.addObject("result", json.toJSONString());
//				
//				return mv;
//			}			
		}
		
		return null;
	}
}
