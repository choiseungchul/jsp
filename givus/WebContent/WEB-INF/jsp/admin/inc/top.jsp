<%@page import="dynamic.web.util.MessageHandler"%>
<%@page import="dynamic.web.util.SessionContext"%>
<%@page import="kr.co.zadusoft.contents.model.UserModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	
UserModel um = (UserModel)SessionContext.getUserModel();
String alert_str = MessageHandler.getMessage("admin.notadminuser");
String contextPath = request.getContextPath();

if(um != null){
	if(um.getEmail() != null){
		if(um.getUserType().equals("M")){
			
		}else{
			out.print("<script>alert('"+alert_str+"');location.href='"+contextPath + "/___/admin/login" +"'</script>");
		}
	}else{
		out.print("<script>alert('"+alert_str+"');location.href='"+contextPath + "/___/admin/login" +"'</script>");
	}
}else{
	out.print("<script>alert('"+alert_str+"');location.href='"+contextPath + "/___/admin/login" +"'</script>");
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>   
<link rel="stylesheet" type="text/css" href="${contextPath}/plugin/bootstrap-3.0.3/css/bootstrap.css?noc=<%=System.currentTimeMillis() %>" />
<link rel="stylesheet" type="text/css" href="${contextPath}/plugin/bootstrap-3.0.3/css/bootstrap-theme.css?noc=<%=System.currentTimeMillis() %>" />
<script type="text/javascript" src="${contextPath}/plugin/bootstrap-3.0.3/js/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="${contextPath}/style/admin/main.css?noc=<%=System.currentTimeMillis() %>" />
<script type="text/javascript">
var Browser = {
		a : navigator.userAgent.toLowerCase()
	}

	Browser = {
		ie : /* @cc_on true || @ */false,
		ie6 : Browser.a.indexOf('msie 6') != -1,
		ie7 : Browser.a.indexOf('msie 7') != -1,
		ie8 : Browser.a.indexOf('msie 8') != -1,
		ie9 : Browser.a.indexOf('msie 9') != -1,
		opera : !!window.opera,
		safari : Browser.a.indexOf('safari') != -1,
		safari3 : Browser.a.indexOf('applewebkit/5') != -1,
		mac : Browser.a.indexOf('mac') != -1,
		chrome : Browser.a.indexOf('chrome') != -1,
		firefox : Browser.a.indexOf('firefox') != -1
	}
</script>
<title>관리자</title>
