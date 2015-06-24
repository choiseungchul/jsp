<%@page import="java.util.HashMap"%>
<%@page import="wp.utils.Property"%>
<%@page import="wp.utils.ShowMsg"%>
<%@page import="wp.databean.SessionDTO"%>
<%@page import="wp.manager.SessionDAO"%>
<%@page import="wp.manager.SessionStorage"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 현재 페이지의 세션아이디 값을 받아서 메모리에 로드된 값과 비교 하여 세션을 파기한다.
	
//	boolean loginchk = false;

// 로그인체크시 session 정보에 저장된 아이디 값 , 세션 값을 비교 한다. 
// 쿠기값을 얻어와서 세션저장객체와 비교

	String s_user = null;
	String s_prp  = null;

	Cookie[] cookies = request.getCookies();
	
	if ( cookies == null )
	{  
		out.println(ShowMsg.showAlert("쿠키정보가 없습니다.")); 
		response.sendRedirect( Property.getProperty("prxserver") + "/" + Property.getProperty("wp.domain") + "/index.jsp");
	}else{
		
		String seid = null;
		
		for ( Cookie cok : cookies )
		{
			if (cok.getName().equals("secui_session"))
			{
				seid = cok.getValue();
				//out.println(ShowMsg.showAlert(seid));
				break;
			}
		}
		 
		if ( SessionStorage.loginCheck(seid) && SessionDAO.getInstance().get(seid) != null ) {
			
			HashMap<String, Object> mdata = SessionStorage.get(seid);
			
			s_user = (String)mdata.get("secui_user");
			s_prp  = (String)mdata.get("secui_profile");
			
			//out.println(ShowMsg.showAlert(s_user));
			//out.println(ShowMsg.showAlert(s_prp));  
			
		} else{  
			out.println(ShowMsg.showAlert("로그인이 필요합니다.")); 
			response.sendRedirect( "https://" + Property.getProperty("prxserver") + "/" + Property.getProperty("wp.domain") + "/index.jsp");
		}
	}
%>