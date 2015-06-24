<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String code = request.getParameter("code");
	
	Cookie[] cookies = request.getCookies();
	
	if ( cookies == null )
	{  
	}else{
		
		for ( Cookie cok : cookies )
		{
			out.println(cok.getName() + ":" + cok.getValue() + "<br>");
		} 
		 
	}

	// 코드에 따른 에러 출력
	String title = null;
	String msg = null;
	
	if ( code.equals("403"))
	{
		title = "접근 권한이 없습니다.";
		msg   = "해당 페이지의 접근권한이 없습니다.<br> 해당 사이트 관리자와 문의하세요 <br>";
	}else if ( code.equals("404"))
	{  
		title = "요청한 페이지가 없습니다.";
		msg   = "요청하신 페이지가 없습니다. <br>";
	}else if ( code.equals("500")) 
	{
		title = "내부 서버 오류 입니다.";
		msg	  = "해당 사이트에 오류가있어 서비스가 불가능합니다. <br>";
	}else if ( code.equals("401"))
	{
		title = "사용 권한이 없습니다.";
		msg	  = "해당 사용 권한이 없습니다.";
	}else if ( code.equals("600")){
		title = "알수없는 오류.";
		msg   = "서버 오류 입니다. 이용에 불편을 드려 죄송합니다. <br>";
	}else if ( code.equals("413")){
		title = "요청페이지가 너무 큽니다.";
		msg   = "요청된 페이지가 너무 큽니다. <br>";
	}else if ( code.equals("414")){
		title = "요청 URI가 너무 깁니다.";
		msg   = "요청 URI가 너무 깁니다. <br>";
	}
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=title %></title>
</head>
<body style="margin: 0px; padding: 0px;">
<span style="width: 1024px; margin: 0 auto; margin-top: 200px;"><%=msg %></span>
<a href="../index.jsp" style="margin: 0 auto; width: 1024px; margin-top: 300px;">메인 페이지로 이동합니다.</a>
</body>
</html>