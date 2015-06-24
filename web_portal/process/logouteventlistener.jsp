<%@page import="wp.cli.Command"%>
<%@page import="wp.juds.ReqDeamon"%>
<%@page import="wp.utils.Property"%>
<%@page import="wp.manager.SessionDAO"%>
<%@page import="wp.manager.SessionStorage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function deleteCookie( cookieName )
{
	 var expireDate = new Date();
	 
	 //어제 날짜를 쿠키 소멸 날짜로 설정한다.
	 expireDate.setDate( expireDate.getDate() - 1 );
	 document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString() + "; path=/";
}
</script>
<%
	String uid = request.getParameter("uid");
	String sid = request.getParameter("sid");
	String clientIP = request.getParameter("c_ip");

   	if ( uid != null && sid != null && clientIP != null )
   	{
   		SessionStorage.removeBySessionId(sid);  
   		
   		SessionDAO.getInstance().deleteSession(sid);
   		
   		// 인증데몬으로 로그아웃 정보 전송
   		ReqDeamon deamon = new ReqDeamon();
		deamon.requestAuth( uid , null , sid , clientIP ,2 );
   		
   		int result = deamon.getAuthResult();
   		String msg = deamon.getRelMsg();
   		
   		// 로그아웃 처리 CLI로 웹접속서버로 보냄
		Command cmd = new Command();
		cmd.runBlueCmd(sid);
   		
   		out.println("result:" + result + "<br>" + "msg:" + msg);
   		
   		//out.println ( uid + ":" + sid + ":" + clientIP + " logout!!");
   	}
%>  