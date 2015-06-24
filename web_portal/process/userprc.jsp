<%@page import="wp.ha.MemberSynchronization"%>
<%@page import="wp.utils.DateUtil"%>
<%@page import="wp.juds.ReqDeamon"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.List"%>
<%@page import="wp.databean.ProfileDTO"%>
<%@page import="wp.manager.ProfileDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="wp.manager.UserDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="wp.manager.SessionStorage"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.URLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="wp.utils.Property"%>
<%@page import="wp.cli.CmdString"%>
<%@page import="wp.cli.Command"%>
<%@page import="wp.utils.WPParser"%> 
<%@page import="wp.databean.SessionDTO"%>
<%@page import="wp.manager.SessionDAO"%>
<%@page import="wp.databean.UserDTO"%>
<%@page import="wp.utils.ShowMsg"%>
<%  

	String classname = this.getClass().getName();
	classname = WPParser.getJSPName(classname);
	Logger log = Logger.getLogger(this.getClass().getName());
	log.log(Level.FINE , classname + " is request");
	
	String clientIP = null;
	String logout_seid = null;
	String s_prp = null;
	
	Cookie[] coks = request.getCookies();
	
	if (coks != null)
	{
		for ( Cookie cok : coks)
		{
			if (cok.getName().equals("clientip"))
			{
				clientIP = cok.getValue();
	
			}else if (cok.getName().equals("secui_session"))
			{
				logout_seid = cok.getValue();
			}
		}
	}
	
	int SHARE_SESSION_TIMEOUT = 20000;
	String mode = request.getParameter("mode");
	
	if ( mode.equals("login"))
	{
		String id 		= request.getParameter("uid");
		String pass 	= request.getParameter("pwd");
		
		boolean login = false;
		
		
		// 임의의 세션아이디 생성
		String dummy_id = session.getId();
		
		Cookie uidcok		= new Cookie("secui_user",id);
		uidcok.setMaxAge(60 * 60 * 24);
		uidcok.setPath("/");
		
		
		Cookie sidcok		= new Cookie("secui_session",dummy_id);
		sidcok.setMaxAge(60 * 60 * 24);
		sidcok.setPath("/");
	
		ReqDeamon dm = null;
		
		int result = -1;
		String profileid = null;
		String msg = null;
		
		if ( request.getParameter("login_force") != null )
		{
			if (request.getParameter("login_force").equals("true"))
			{
				result = 100;
				profileid = "prp1";
			}else {
				
				/*
				dm = new ReqDeamon();
				
				dm.requestAuth(id,pass, dummy_id , clientIP , 1);
				
				// 인증데몬에서 받은 값 처리
				
				result 			= dm.getAuthResult();		// 인증결과
			    profileid		= dm.getProfileId();		// 프로파일명
				msg 			= dm.getAuthMsg();			// 메세지
				*/
			}
		}
		
		Cookie prpcok		= new Cookie("secui_profile",profileid);
		prpcok.setMaxAge(60 * 60 * 24);
		prpcok.setPath("/");
		
		out.println(result);
		out.println(profileid);
		out.println(msg);
		
		
		
		// 인증데몬 결과값에 따라 세션 처리
		if ( result >= 120 )
		{
			out.println( ShowMsg.showAlert("일시적인 장애 입니다. \n 이용에 불편을 드려 죄송합니다.") );
		}
		// 비밀번호 오류
		else if (result == 102)
		{
			out.println( ShowMsg.showAlert("비밀번호가 일치하지 않거나 없는 아이디 입니다.") ); 
		}
		// 인증 성공
		else if (result == 100)
		{
			// 인증 성공 처리
			login = true;
			
			response.addCookie(uidcok);
			response.addCookie(sidcok);
			response.addCookie(prpcok);
		}
		if (login) {
	
			SessionDAO sessionMgr = new SessionDAO();
			SessionDTO sdata = new SessionDTO();
			
			sdata.setSid(dummy_id);
			sdata.setUid(id);
			 
			//List<ProfileDTO> profilelist = ProfileDAO.getInstance().getProfileURL(profileid);
			 List<ProfileDTO> profilelist = ProfileDAO.getInstance().getProfileURL(profileid);
			String prpurl = "";
			
			// DB에 URL 목록 입력
			if ( profilelist != null)
			{
				prpurl = "^";
				
				for ( ProfileDTO pdata : profilelist)
				{
					prpurl += pdata.getAlias() + "^";
				}
			}
			
			long cdate = System.currentTimeMillis() / 1000;
			
			sdata.setPurl(prpurl);
			sdata.setCdate(cdate);
			 
			int sidx = sessionMgr.addSession(sdata);
			
			Cookie cdate_ck = new Cookie("vpn_wp_cdate", DateUtil.getToday() );
			cdate_ck.setPath("/");
			cdate_ck.setMaxAge(60 * 60 * 24);
			
			response.addCookie(cdate_ck);
			
			if ( sidx != 0 && sidx != -1 ) {
				// 메모리에할당 
				SessionStorage.add(dummy_id ,id, sidx ,profileid);
				
				// 다른장비의 웹 포탈로 보냄 
				String params = "uid=" + id + "&sid=" + dummy_id + "&prp=" + profileid + "&sidx=" + sidx + "&cdate=" + cdate;
				MemberSynchronization.getInstance().sendLoginInfo(params); 
				
				out.println("<script>location.href='"+"https://"+ Property.getProperty("prxserver")+ "/"
						+ Property.getProperty("wp.domain") + "/main.jsp';</script>");
			}
		}
		
	}else if (mode.equals("logout"))
	{
		// 메모리에 할당된 세션 제거
		if ( logout_seid != null)
		{
			String rminfo = SessionStorage.removeBySessionId(logout_seid);
			SessionDAO.getInstance().deleteSession(logout_seid);
			
			String[] sinfo = new String[2];
			if(rminfo.length() != 0) { 
				sinfo = rminfo.split(":");
				
				// 인증데몬으로 로그아웃 정보 보냄
				//ReqDeamon deamon = new ReqDeamon();
				//deamon.requestAuth( sinfo[0] , null , logout_seid , clientIP ,2 );
						
				// 로그아웃 처리 CLI로 웹접속서버로 보냄
				Command cmd = new Command();
				cmd.runBlueCmd(sinfo[1]);
			
			// 쿠키 삭제
			if ( coks != null)
			{
				for (Cookie cok : coks)
				{
					if (cok.getName().equals("secui_session"))
					{
						cok.setMaxAge(0);
					}
					if (cok.getName().equals("secui_user"))
					{
						cok.setMaxAge(0);
					}
					if (cok.getName().equals("secui_profile"))
					{
						cok.setMaxAge(0);
					}
					if (cok.getName().equals("vpn_wp_cdate"))
					{
						cok.setMaxAge(0);
					}
				}
			}
			
			// 다른 웹 포탈로 보냄
			String params = "uid=" + sinfo[0] + "&sid=" + sinfo[1] + "&c_ip=" + clientIP;
			
			MemberSynchronization.getInstance().sendLogoutInfo(params); 
			
			}else{
				out.println(ShowMsg.showAlert("저장된 쿠키값이 없습니다."));
			}
			// 다른 웹 포탈로 세션 정보를 보냄
		}
			// 인덱스로 이동
			//out.println(ShowMsg.showAlert("로그인이 필요합니다.")); 
	//		response.sendRedirect( "https://" + Property.getProperty("prxserver") + "/" + 
	//				Property.getProperty("wp.domain") + "/index.jsp");
			out.println("<script>parent.location.href='"+"https://"+ Property.getProperty("prxserver")+ "/"
					+ Property.getProperty("wp.domain") + "/index.jsp';</script>");
		
		
	}else if (mode.equals("modify"))  
	{
		String id 	   = request.getParameter("uid");
		String prepass = request.getParameter("pwd_pre");
		String newpass = request.getParameter("pwd_new");
		
		int result = UserDAO.getInstance().changePass(id, prepass, newpass);
		
		if (result == -1 )
		{
			out.print( ShowMsg.showAlert("내부 오류입니다.") );
		}else if (result == 0)
		{ 
			out.print( ShowMsg.showAlert("비밀번호가 맞지 않습니다") );
			
		}else if (result == 1)
		{
			out.print( ShowMsg.showAlert("비밀번호가 변경되었습니다.") );
		}
		out.println("<script>location.href='"+"https://"+ Property.getProperty("prxserver")+ "/"
				+ Property.getProperty("wp.domain") + "/main.jsp';</script>");
		
	} 
%>
