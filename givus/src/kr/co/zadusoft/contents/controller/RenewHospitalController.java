package kr.co.zadusoft.contents.controller;

import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.zadusoft.contents.model.HospitalEvaluationModel;
import kr.co.zadusoft.contents.model.UserModel;
import kr.co.zadusoft.givus.util.GivusUtil;
import kr.co.zadusoft.givus.util.RequestUtil;

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

import dynamic.util.DateUtil;
import dynamic.web.util.MessageHandler;
import dynamic.web.util.SessionContext;

@Controller
@RequestMapping(value="/___/renew")
public class RenewHospitalController{

	@Autowired
	private SqlSession sqlsession;
	
	@Resource(name = "txManager")
	protected DataSourceTransactionManager txManager;
	
	@RequestMapping( value="/hospital/info/{hospitalId}", method = RequestMethod.GET)
	public ModelAndView viewMainPage(@PathVariable Integer hospitalId, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("/givus_v2/hospital/info");

		// 로그인 체크
		UserModel umodel = (UserModel)SessionContext.getUserModel();
		
		if( umodel != null){
			if(umodel.getEmail() != null){
				// UserHospitalView테이블에서 카운트 증가 조회후 마지막날짜가 오늘이 아닌경우 뷰카운트 + 1
				String today = DateUtil.formatDate( new Date(), DateUtil.YYYYMMDD);
				
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("uid", umodel.getId());
				param.put("hid", hospitalId);
				param.put("viewDate", today);
				
				Integer cnt = sqlsession.selectOne("renew_hospital.get_hospital_view_cnt", param);
				
				HashMap<String, Object> u_param = new HashMap<String, Object>();
				u_param.put("uid", umodel.getId());
				u_param.put("hid", hospitalId);
				
				if(cnt == 0){
					int rs = sqlsession.update("renew_hospital.view_cnt_add",u_param);
				}
			}
			
		}
		
		// 병원정보 조회
		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("hid", hospitalId);
		HashMap<String, Object> hospital = sqlsession.selectOne("renew_hospital.get_hospital",h_param);
		
		// 썸네일조회 get_hospital_thumb
		HashMap<String, Object> thumb_p = new HashMap<String, Object>();
		thumb_p.put("hid", hospitalId);
		HashMap<String, Object> thumbId = sqlsession.selectOne("renew_hospital.get_hospital_thumb",thumb_p);
		if(thumbId != null){
			if(thumbId.get("id") != null)
				hospital.put("fid", thumbId.get("id"));
		}
		// 썸네일 5개 조회
		List<HashMap<String, Object>> thumbList = sqlsession.selectList("renew_hospital.get_hospital_thumb5", thumb_p);
		mv.addObject("thumb5", thumbList);
		
		// 진료과 의사 조회
		HashMap<String, Integer> h_stat = sqlsession.selectOne("renew_hospital.get_hospital_stat", h_param);

		// 가격조회
		List<HashMap<String, Object>> surg  = sqlsession.selectList("admin_hospital.get_surg");
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("hid", hospitalId);
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
		mv.addObject("price", surg);
		// 키워드 조회
		List<HashMap<String, Object>> surg_cate = sqlsession.selectList("admin_hospital.get_surg_keyname");
		mv.addObject("surg_cate", surg_cate);
		
		mv.addObject("hos", hospital);
		mv.addObject("hos_stat",h_stat );
		
		
		
		return mv;
	}	
	
	// 수술후기
	@RequestMapping( value="/hospital/epilogue/{hospitalId}", method = RequestMethod.GET)
	public ModelAndView epilogue(@PathVariable Integer hospitalId, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("/givus_v2/hospital/epilogue");

		// 로그인 체크
		UserModel umodel = (UserModel)SessionContext.getUserModel();
		
		if( umodel != null){
			
			if(umodel.getEmail() != null){
				// UserHospitalView테이블에서 카운트 증가 조회후 마지막날짜가 오늘이 아닌경우 뷰카운트 + 1
				String today = DateUtil.formatDate( new Date(), DateUtil.YYYYMMDD);
				
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("uid", umodel.getId());
				param.put("hid", hospitalId);
				param.put("viewDate", today);
				
				Integer cnt = sqlsession.selectOne("renew_hospital.get_hospital_view_cnt", param);
				
				HashMap<String, Object> u_param = new HashMap<String, Object>();
				u_param.put("uid", umodel.getId());
				u_param.put("hid", hospitalId);
				
				if(cnt == 0){
					int rs = sqlsession.update("renew_hospital.view_cnt_add",u_param);
				}
			}		
		}
		
		// 병원정보 조회
		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("hid", hospitalId);
		HashMap<String, Object> hospital = sqlsession.selectOne("renew_hospital.get_hospital",h_param);
		
		// 썸네일조회 get_hospital_thumb
		HashMap<String, Object> thumb_p = new HashMap<String, Object>();
		thumb_p.put("hid", hospitalId);
		HashMap<String, Object> thumbId = sqlsession.selectOne("renew_hospital.get_hospital_thumb",thumb_p);
		if(thumbId != null){
			if(thumbId.get("id") != null)
				hospital.put("fid", thumbId.get("id"));
		}
		
		// 썸네일 5개 조회
		List<HashMap<String, Object>> thumbList = sqlsession.selectList("renew_hospital.get_hospital_thumb5", thumb_p);
		mv.addObject("thumb5", thumbList);
		
		mv.addObject("hos", hospital);
		
		return mv;
	}
	
	// 리뷰
	@RequestMapping( value="/hospital/review/{hospitalId}", method = RequestMethod.GET)
	public ModelAndView review(@PathVariable Integer hospitalId, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("/givus_v2/hospital/review");

		// 로그인 체크
		UserModel umodel = (UserModel)SessionContext.getUserModel();
		
		if( umodel != null){
			
			if(umodel.getEmail() != null){
				// UserHospitalView테이블에서 카운트 증가 조회후 마지막날짜가 오늘이 아닌경우 뷰카운트 + 1
				String today = DateUtil.formatDate( new Date(), DateUtil.YYYYMMDD);
				
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("uid", umodel.getId());
				param.put("hid", hospitalId);
				param.put("viewDate", today);
				
				Integer cnt = sqlsession.selectOne("renew_hospital.get_hospital_view_cnt", param);
				
				HashMap<String, Object> u_param = new HashMap<String, Object>();
				u_param.put("uid", umodel.getId());
				u_param.put("hid", hospitalId);
				
				if(cnt == 0){
					int rs = sqlsession.update("renew_hospital.view_cnt_add",u_param);
				}
			}			
		}
		
		// 병원정보 조회
		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("hid", hospitalId);
		HashMap<String, Object> hospital = sqlsession.selectOne("renew_hospital.get_hospital",h_param);
		
		HashMap<String, Object> thumb_p = new HashMap<String, Object>();
		thumb_p.put("hid", hospitalId);
		HashMap<String, Object> thumbId = sqlsession.selectOne("renew_hospital.get_hospital_thumb",thumb_p);
		if(thumbId != null){
			if(thumbId.get("id") != null)
				hospital.put("fid", thumbId.get("id"));
		}
		
		// 썸네일 5개 조회
		List<HashMap<String, Object>> thumbList = sqlsession.selectList("renew_hospital.get_hospital_thumb5", thumb_p);
		mv.addObject("thumb5", thumbList);
		
		mv.addObject("hos", hospital);
		// 병원 평점을 가져온다.
		
		HospitalEvaluationModel heModel = sqlsession.selectOne("renew_hospital.get_review_points", h_param);
		if( heModel != null)
			heModel.prepareStats();
		
		mv.addObject("hospitalEvaluationModel", heModel);
		
		
		return mv;
	}
	
	// 게시물 목록 - 병원후기
	@RequestMapping( value="/hospital/board_epil/{hid}/{categoryId}/{page}/{type}", method = RequestMethod.GET)
	public ModelAndView epil_board(@PathVariable Integer hid,@PathVariable Integer categoryId,@PathVariable Integer page, @PathVariable Integer type,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
	
		int pnum = 1;
		int pageCount = 30;
		int totalCount = 0;
		
		if(page != null){
			pnum = page;
		}
		
		String srch = request.getParameter("srch");
		String order = request.getParameter("sorting");
		
		List<HashMap<String, Object>> boardList = null;
		
		ModelAndView mv = new ModelAndView("/givus_v2/boardlist");
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("hid", hid);
		params.put("cid", categoryId);
		params.put("start", (pnum-1) * pageCount);
		params.put("end" ,pageCount);
		params.put("type", type);
		
		if(order == null){
			order = "createDate";
		}else{
			if(order.equals("1")){
				order = "viewCount";
			}
		}
		
		params.put("order", order);
		
		System.out.println("order = " + order);
		
		if(srch != null){
			mv.addObject("query", srch);
			params.put("query", srch);
			boardList = sqlsession.selectList("renew_hospital.get_review_board_all_byQuery",params);
			params.remove("start");
			params.remove("end");
			totalCount = sqlsession.selectOne("renew_hospital.get_review_board_all_byQuery_cnt",params);
		}else{			
			boardList = sqlsession.selectList("renew_hospital.get_review_board_all",params);
			params.remove("start");
			params.remove("end");
			totalCount = sqlsession.selectOne("renew_hospital.get_review_board_all_cnt", params);
		}		

		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("type", type);
		// 카테고리 조회 get_review_category		
		List<HashMap<String, Object>> category = sqlsession.selectList("renew_hospital.get_review_category", h_param);
		
		mv.addObject("cate", category);	
		mv.addObject("cateId", categoryId);
		mv.addObject("board", boardList);
		mv.addObject("total", totalCount);
		mv.addObject("hid", hid);
		mv.addObject("p", pnum);
		mv.addObject("type", type);
		
		return mv;
	}
	
	// 게시물 목록 - 병원리뷰
	@RequestMapping( value="/hospital/board_review/{hid}/{categoryId}/{page}/{type}", method = RequestMethod.GET)
	public ModelAndView review_board(@PathVariable Integer hid,@PathVariable Integer categoryId,@PathVariable Integer page, @PathVariable Integer type,
			HttpServletRequest request, HttpServletResponse response) throws Exception{
	
		int pnum = 1;
		int pageCount = 30;
		int totalCount = 0;
		
		if(page != null){
			pnum = page;
		}
		
		String srch = request.getParameter("srch");
		String order = request.getParameter("sorting");
		
		List<HashMap<String, Object>> boardList = null;
		
		ModelAndView mv = new ModelAndView("/givus_v2/boardlist_review");
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("hid", hid);
		params.put("cid", categoryId);
		params.put("start", (pnum-1) * pageCount);
		params.put("end" ,pageCount);
		params.put("type", type);
		
		// 정렬방식
		if(order == null){
			order = "createDate";
			mv.addObject("sex", "A");
		}else{
			if(order.equals("1")){
				order = "viewCount";
				mv.addObject("sex", "A");
			}else if(order.equals("2")){
				order = "recommendCount";
				mv.addObject("sex", "A");
			}else if(order.equals("3")){
				// 남자
				params.put("sex", "M");
				mv.addObject("sex","M");
			}else if(order.equals("4")){
				// 여자
				params.put("sex", "F");
				mv.addObject("sex","F");
			}
		}
		
		params.put("order", order);
		
		System.out.println("order = " + order);
		
		if(srch != null){
			mv.addObject("query", srch);
			params.put("query", srch);
			boardList = sqlsession.selectList("renew_hospital.get_review_board_all_byQuery",params);
			params.remove("start");
			params.remove("end");
			totalCount = sqlsession.selectOne("renew_hospital.get_review_board_all_byQuery_cnt",params);
		}else{			
			boardList = sqlsession.selectList("renew_hospital.get_review_board_all",params);
			params.remove("start");
			params.remove("end");
			totalCount = sqlsession.selectOne("renew_hospital.get_review_board_all_cnt", params);
		}		

		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("type", type);
		// 카테고리 조회 get_review_category		
		List<HashMap<String, Object>> category = sqlsession.selectList("renew_hospital.get_review_category", h_param);
		
		mv.addObject("cate", category);	
		mv.addObject("cateId", categoryId);
		mv.addObject("board", boardList);
		mv.addObject("total", totalCount);
		mv.addObject("hid", hid);
		mv.addObject("p", pnum);
		mv.addObject("type", type);
				
		return mv;
	}
	
	// 게시물 뷰 - 병원후기
	@RequestMapping( value="/hospital/boardview/{bid}", method = RequestMethod.GET)
	public ModelAndView review_board(@PathVariable Integer bid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("/givus_v2/board_view");
		
		String xpath = request.getParameter("xpath");
		if(xpath != null) {
			xpath = URLDecoder.decode(xpath, "UTF-8");			
			mv.addObject("blist_path",xpath);
		}
		
		int hid = 0;
		int categoryId = 0;
		int pnum = 0;
		int type = 25;
		
		if(xpath.indexOf("?srch=") != -1){
			xpath = xpath.substring(0, xpath.indexOf("?srch=")-1);
		}
		if(xpath.indexOf("&srch=") != -1){
			xpath = xpath.substring(0, xpath.indexOf("&srch=")-1);
		}
		
		String[] str = xpath.split("/", 3);
		hid = Integer.parseInt(str[0].replace("/", ""));
		categoryId = Integer.parseInt(str[1].replace("/", ""));
		pnum = Integer.parseInt(str[2].replace("/", ""));
		
		//get_review_board_view
		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("bid", bid);
		
		HashMap<String, Object> board = sqlsession.selectOne("renew_hospital.get_review_board_view", h_param);
		
		String cdate =  board.get("createDate").toString();
		HashMap<String, Object> b_param = new HashMap<String, Object>();
		b_param.put("cdate", cdate);
		b_param.put("hid", hid);
		b_param.put("cid", categoryId);
		b_param.put("type", type);
		
//		System.out.println("cdate = " + cdate);
		
		HashMap<String, Object> prevId = sqlsession.selectOne("renew_hospital.get_board_prev_id", b_param);
		HashMap<String, Object> nextId = sqlsession.selectOne("renew_hospital.get_board_next_id", b_param);
		
		if(prevId != null)
		mv.addObject("prevId", prevId);
		if(nextId != null)
		mv.addObject("nextId", nextId);
		
		
		mv.addObject("board", board);
		
		return mv;
	}
	
	// 게시물 뷰 - 병원리뷰
	@RequestMapping( value="/hospital/boardview_review/{bid}", method = RequestMethod.GET)
	public ModelAndView board_view(@PathVariable Integer bid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("/givus_v2/board_view_review");
		
		String xpath = request.getParameter("xpath");
		if(xpath != null) {
			xpath = URLDecoder.decode(xpath, "UTF-8");			
			mv.addObject("blist_path",xpath);
		}
		
		int hid = 0;
		int categoryId = 0;
		int pnum = 0;
		int type = 26;
		
		if(xpath.indexOf("?srch=") != -1){
			xpath = xpath.substring(0, xpath.indexOf("?srch=")-1);
		}
		if(xpath.indexOf("&srch=") != -1){
			xpath = xpath.substring(0, xpath.indexOf("&srch=")-1);
		}
		
		String[] str = xpath.split("/", 3);
		hid = Integer.parseInt(str[0].replace("/", ""));
		categoryId = Integer.parseInt(str[1].replace("/", ""));
		pnum = Integer.parseInt(str[2].replace("/", ""));
		
		//get_review_board_view
		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("bid", bid);
		
		HashMap<String, Object> board = sqlsession.selectOne("renew_hospital.get_review_board_view_point", h_param);
		
		HashMap<Integer, Object> review = new HashMap<Integer, Object>();
		review.put(1, board.get("enoughDesc"));
		review.put(2, board.get("considerNeeds"));
		review.put(3, board.get("reaction"));
		review.put(4, board.get("facilities"));
		review.put(5, board.get("waitingTime"));
		review.put(6, board.get("privacy"));
		review.put(7, board.get("reliability"));
		review.put(8, board.get("transportation"));
		review.put(9, board.get("stress"));
		review.put(10, board.get("afterSupport"));
		review.put(11, board.get("amount"));
		review.put(12, board.get("resultSatisfaction"));
		
		int total = 0;
		
		for(int i = 1 ; i <= 12 ; i++){
			total += (Integer)review.get(i);
			review.put(i, MessageHandler.getMessage("reviewPoints.answer." + review.get(i).toString()));					
		}
		
		mv.addObject("totalScore", (int)(total/12));
		
		String cdate =  board.get("createDate").toString();
		HashMap<String, Object> b_param = new HashMap<String, Object>();
		b_param.put("cdate", cdate);
		b_param.put("hid", hid);
		b_param.put("cid", categoryId);
		b_param.put("type", type);
		
//			System.out.println("cdate = " + cdate);
		
		HashMap<String, Object> prevId = sqlsession.selectOne("renew_hospital.get_board_prev_id", b_param);
		HashMap<String, Object> nextId = sqlsession.selectOne("renew_hospital.get_board_next_id", b_param);
		
		if(prevId != null)
		mv.addObject("prevId", prevId);
		if(nextId != null)
		mv.addObject("nextId", nextId);
		
		
		mv.addObject("board", board);
		mv.addObject("review", review);
		
		return mv;
	}
	
	
	@RequestMapping( value="/hospital/mostview/{hid}", method = RequestMethod.GET)
	public ModelAndView mostHospitalView(@PathVariable Integer hid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("/givus_v2/inc/most_hview");
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("hid", hid);
		
		List<HashMap<String, Object>> most_hos = sqlsession.selectList("renew_hospital.get_mostview_by_hospital", param);
		
		StringBuffer ids = new StringBuffer();
		
		for(int i = 0 ; i < most_hos.size(); i++){
			ids.append(most_hos.get(i).get("id"));
			ids.append(",");
		}
		
		if(ids.length() > 1){
			HashMap<String, Object> thumb_param = new HashMap<String, Object>();
			thumb_param.put("ids", ids.substring(0, ids.length()-1));
			
			List<HashMap<String, Object>> h_thumb = sqlsession.selectList("get_hospital_thumbs", thumb_param);
			
			for(int j = 0 ; j < most_hos.size(); j++){
				HashMap<String, Object> data = most_hos.get(j);
				
				for(int k = 0 ; k < h_thumb.size(); k++){
					if(h_thumb.get(k).get("relationId").equals(data.get("id"))){
						data.put("thumb_id", h_thumb.get(k).get("id"));
						break;
					}
				}				
			}
		}
		
		mv.addObject("most", most_hos);
		
		return mv;
	}
	
	//후기 글쓰기
	@RequestMapping( value="/hospital/board/write", method = RequestMethod.GET)
	public ModelAndView board_write_form(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("/givus_v2/board_write");
		
		String type =  request.getParameter("type");
		String hid   = request.getParameter("hid");
		
		// 카테고리 조회 get_review_category
		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("type", type);
		List<HashMap<String, Object>> category = sqlsession.selectList("renew_hospital.get_review_category", h_param);
		
		mv.addObject("cate", category);
		mv.addObject("hid", hid);
		mv.addObject("type", type);
		
		return mv;
	}
	
	//리뷰 글쓰기
	@RequestMapping( value="/hospital/boardrv/write", method = RequestMethod.GET)
	public ModelAndView boardrv_write_form(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("/givus_v2/board_write_review");
		
		String type =  request.getParameter("type");
		String hid   = request.getParameter("hid");
		
		// 카테고리 조회 get_review_category
		HashMap<String, Object> h_param = new HashMap<String, Object>();
		h_param.put("type", type);
		List<HashMap<String, Object>> category = sqlsession.selectList("renew_hospital.get_review_category", h_param);
		
		mv.addObject("cate", category);
		mv.addObject("hid", hid);
		mv.addObject("type", type);
		
		return mv;
	}
	
	// 리뷰 추천하기
	@RequestMapping( value="/hospital/recomm/add/{pid}", method = RequestMethod.GET)
	public ModelAndView add_recomm(@PathVariable Integer pid, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		
		JSONObject json = new JSONObject();
		
		UserModel login = (UserModel) SessionContext.getUserModel();
		if(login != null){
			
			if(login.getEmail() != null){
				HashMap<String, Object> s_param = new HashMap<String, Object>();
				s_param.put("pid", pid);
				s_param.put("account", login.getAccount());
				s_param.put("date", DateUtil.getToday());
				
				int isRecomm = sqlsession.selectOne("renew_board.get_isrecomm", s_param);
				
				if(isRecomm == 0){
					//add_recomm_count
					int rs = sqlsession.update("renew_board.add_recomm_count", pid);
					
					HashMap<String, Object> param = new HashMap<String, Object>();
					param.put("pid", pid);
					param.put("account", login.getAccount());
					param.put("ip", request.getRemoteAddr());
					
					int in = sqlsession.insert("renew_board.add_recomm_useraction", param);
					
					if(in > 0){
						json.put("code", "0");
						json.put("msg", "추천이 완료되었습니다.");
					}
				}else{
					json.put("code", "1");
					json.put("msg", "이미 추천하셨습니다.");
				}
			}else{
				json.put("code", "-1000");
				json.put("msg", "로그인 후 확인해주세요.");
			}
			
			
			
		}else{
			json.put("code", "-1000");
			json.put("msg", "로그인 후 확인해주세요.");
		}
		
		mv.addObject("result", json.toJSONString());
		
		return mv;
	}
	
	// 후기 글쓰기 - 입력
	@RequestMapping( value="/hospital/board/writeproc", method = RequestMethod.POST)
	public ModelAndView board_write_process(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String cate =  request.getParameter("sct");
		String title   = request.getParameter("title");
		String content   = request.getParameter("content");
		
		String type   = request.getParameter("type");		
		String hid   = request.getParameter("hid");
		
		
		UserModel login =  (UserModel) SessionContext.getUserModel();
		
		if(login != null){
			if(login.getEmail() != null){
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("type",type);
				param.put("account", login.getAccount());
				param.put("subject", title);
				param.put("contents",content);
				param.put("cate",cate);
				param.put("hid",hid);
				
				int rs = sqlsession.insert("renew_board.add_board", param);
				
				if(rs > 0){
					
					// 시간 업데이트
					sqlsession.update("renew_hospital.set_update_recent", hid);
					
					json.put("code", "0");
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
	
	// 리뷰 글쓰기 - 입력
	@RequestMapping( value="hospital/board_rv/writeproc", method = RequestMethod.POST)
	public ModelAndView boardrv_write_process(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String cate =  request.getParameter("sct");
		String title   = request.getParameter("title");
		String content   = request.getParameter("content");
		
		String type   = request.getParameter("type");		
		String hid   = request.getParameter("hid");
		
		UserModel login =  (UserModel) SessionContext.getUserModel();
		
		if(login != null){
			
			if(login.getEmail() != null){
				
				if(login.getUserType().equals("G")){
					HashMap<String, Object> param = new HashMap<String, Object>();
					param.put("type",type);
					param.put("account", login.getAccount());
					param.put("subject", title);
					param.put("contents",content);
					param.put("cate",cate);
					param.put("hid",hid);
					
					int rs = sqlsession.insert("renew_board.add_board", param);
					
//					System.out.println("rs = " + rs);
//					System.out.println("rs = " + param.get("IDX"));
					
					if(rs > 0){
						
						// 리뷰포인트 적용				
						String point = request.getParameter("point");
						String[] points = point.substring(1).split(":");
						
						HashMap<String, Object> add_point = new HashMap<String, Object>();
						add_point.put("pid", param.get("IDX"));
						add_point.put("hid", hid);
						add_point.put("gender", login.getGender());
						
						String birth = login.getBirthday();
						Date dt =DateUtil.parseString(birth, "yyyyMMdd");				
						add_point.put("age", GivusUtil.getAgeGroup(dt));			
						
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
							
							if(rs3 > 0){
								sqlsession.update("renew_hospital.set_update_recent", hid);
								
								json.put("code", "0");
								json.put("msg", MessageHandler.getMessage("posting.msg.recommend_needlogin"));
							}else{
								// 합산 정보 입력 오류		
								json.put("code", "-2001");
								json.put("msg", MessageHandler.getMessage("givus.global.error"));
							}
							
						}else{
							// 리뷰포인트오류
							json.put("code", "-2002");
							json.put("msg", MessageHandler.getMessage("givus.global.error"));
						}
					}else{
						// 게시물입력 오류
						json.put("code", "-2003");
						json.put("msg", MessageHandler.getMessage("givus.global.error"));
					}
				}else{
					// 일반 사용자만 리뷰 등록가능
					json.put("code", "-2004");
					json.put("msg", MessageHandler.getMessage("authrity.error.only.general.user"));
				}
				
			}else{
				// 로그인
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

	
	@RequestMapping( value="/hospital/add1", method = RequestMethod.GET)
	public ModelAndView hospital_add1(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("givus_v2/hospital/add_step1");
		
		List<HashMap<String, Object>> locations = sqlsession.selectList("renew_hospital.get_location");
		
		mv.addObject("location", locations);

		return mv;
	}
	
	@RequestMapping( value="/hospital/add3", method = RequestMethod.GET)
	public ModelAndView hospital_add3(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("givus_v2/hospital/add_step3");

		return mv;
	}
	
	// 병원이름 체크
	@RequestMapping( value="/hospital/check/hname", method = RequestMethod.POST)
	public ModelAndView check_hos_name(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String hname = request.getParameter("hname");
		
		//
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("name" , hname);
		
		int cnt = sqlsession.selectOne("renew_hospital.check_hos_name", param);
		
		if(cnt > 0){
			json.put("exist", true);
		}else{
			json.put("exist", false);
		}
		
		mv.addObject("result", json.toJSONString());

		return mv;
	}
	
	// 병원 계정 이름 체크
	@RequestMapping( value="/hospital/check/hid", method = RequestMethod.POST)
	public ModelAndView check_hos_hid(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String hid = request.getParameter("hid");
		
		//
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("account" , hid);
		int cnt = sqlsession.selectOne("renew_hospital.check_user_id", param);
		
		if(cnt > 0){
			json.put("exist", true);
		}else{
			json.put("exist", false);
		}
		
		mv.addObject("result", json.toJSONString());

		return mv;
	}
	
	// 병원 이메일 이름 체크
	@RequestMapping( value="/hospital/check/email", method = RequestMethod.POST)
	public ModelAndView check_hos_email(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();
		
		String email = request.getParameter("email");
		
		//
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("email" , email);
		int cnt = sqlsession.selectOne("renew_hospital.check_user_email", param);
		
		if(cnt > 0){
			json.put("exist", true);
		}else{
			json.put("exist", false);
		}
		
		mv.addObject("result", json.toJSONString());

		return mv;
	}
	
	// 병원 정보 입력 1단계
	@RequestMapping( value="/hospital/addproc/step1", method = RequestMethod.POST)
	public ModelAndView step1(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("givus_v2/hospital/add_step2");
		
		HashMap<String, Object> params = RequestUtil.getParameterMap(request);

		mv.addObject("step1_param", params);

		return mv;
	}
	
	// 병원 정보 입력 
	@RequestMapping( value="/hospital/addnew", method = RequestMethod.POST)
	public ModelAndView step2(HttpServletRequest request, HttpServletResponse response) throws Exception{		
		ModelAndView mv = new ModelAndView("dynamic/web/json");
		JSONObject json = new JSONObject();

		// step1 파라미터
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
		
		UserModel um = (UserModel) SessionContext.getUserModel();
		
		String account = um.getAccount();
		String email = um.getEmail();
		
		HashMap<String, Object> check_param = new HashMap<String, Object>();
		check_param.put("email", email);		
		check_param.put("name", name);
		
		//병원명체크
		int namecount = sqlsession.selectOne("renew_hospital.check_hos_name", check_param);
		
		if(namecount > 0){
			json.put("code", "-1003");
			json.put("msg", MessageHandler.getMessage("join.hospital.add.name.exist"));
			
			mv.addObject("result", json.toJSONString());
			return mv;
		}
		
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
			addH_param.put("name", name);
			addH_param.put("creator", account);
			addH_param.put("tel", tel);
			addH_param.put("address", addr1 + " " + addr2);
			addH_param.put("post", post);
			addH_param.put("location", location);
			
			addH_param.put("introduction", intro);
			addH_param.put("specialistCount", Integer.parseInt(sp_count));
			addH_param.put("anestheticCount", Integer.parseInt(an_count));
			
			addH_param.put("homepage", homepage);
			addH_param.put("patientRoom", Integer.parseInt(proom));
			addH_param.put("recoveryRoom", Integer.parseInt(rroom));
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
			
			sqlsession.insert("renew_hospital.add_hospital_new", addH_param);
			
			System.out.println("---add_hospital_new---");
			
			int hid = (Integer)addH_param.get("id");
			System.out.println("hospital added = " + hid);
			
			// 병원 진료과 의사 등록 add_hospital_status
			HashMap<String, Integer> stat_param = new HashMap<String, Integer>();
			stat_param.put("hid", hid);
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
			
			sqlsession.insert("renew_hospital.add_hospital_status" ,stat_param);
			
			System.out.println("---add_hospital_status---");
			
			// 파일정보 등록 add_file_map, add_file_thumb
			HashMap<String, Object> f_thumb = new HashMap<String, Object>();
			f_thumb.put("hid", hid);
			f_thumb.put("id", pic0);
			
			sqlsession.update("renew_hospital.add_file_thumb", f_thumb);
			
			System.out.println("---add_file_thumb---");
			
			if(!pic0.equals("") || !pic1.equals("") || !pic2.equals("") || !pic3.equals("") || !pic4.equals("") || !pic5.equals("")){
				HashMap<String, Object> f_map = new HashMap<String, Object>();			
				f_map.put("hid", hid);			
				String ids = "";
				if(!pic0.equals("")){
					ids += pic0 + ",";
				}
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
			
			int uid = um.getId();
			HashMap<String , Object> hu_connect = new HashMap<String, Object>();
			hu_connect.put("hid", hid);
			hu_connect.put("uid", uid);
			hu_connect.put("account", account);
			
			sqlsession.insert("renew_hospital.add_user_hospital_connect", hu_connect);
			
			// 사용자 타입변경 및 병원아이디 입력
			HashMap<String, Object> ch_user = new HashMap<String, Object>();
			ch_user.put("uid", uid);
			ch_user.put("type", "H");
			ch_user.put("hid", hid);
			
			sqlsession.update("renew_hospital.change_user_type", ch_user);
			
			txManager.commit(status);
			
			um.setUserType("H");
			um.setHospitalAccepted("W");
			SessionContext.setUserModel(um);
			
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
