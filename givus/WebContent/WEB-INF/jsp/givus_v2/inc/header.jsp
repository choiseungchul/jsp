<%@page import="dynamic.web.util.SessionContext"%>
<%@page import="kr.co.zadusoft.contents.model.UserModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/jsp/dynamic/web/jqueryui.jsp" %>
<script type="text/javascript" src="${contextPath}/script/givus.js"></script>
<script type="text/javascript" src="${contextPath }/script/jquery.corner.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${contextPath}/style/givus_v2/common.css?noc=<%=System.currentTimeMillis() %>" />
<%
	UserModel um = (UserModel)SessionContext.getUserModel();

	if(um != null) {
		if(um.getEmail() == null){
		
%>
<script type="text/javascript">
var alogin = getCookie("alogin");

if(alogin == 'Y'){
	$.ajax({
		url : '${contextPath}/___/renew/autologin',
		type : 'post',
		dataType :'json',
		success : function(rs){
			console.log(rs);
			if(rs.code == 0){
				
			}else{
				if(rs.code == -1003){
					setCookie("alogin", "N");
				}else if(rs.code == -1004){
					setCookie("alogin", "N");
				}
			}
		}
	});
}
</script>
<%
		}else{	
%>
<script type="text/javascript">
var isLogin = true;
</script>
<%
		}
	}else{
		um = new UserModel();
	}
%>
<script type="text/javascript" src="http://wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "7cd914d74cdaa0";
wcs_do();
</script>
